Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019E7C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15872146E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFYTvOwZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfLTSOr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:14:47 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39425 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbfLTSOo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 13:14:44 -0500
Received: by mail-pj1-f66.google.com with SMTP id t101so4470242pjb.4
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 10:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iMKCNtVrFuUR6GRfj2YvDoumjSCaOdhEwxsJVghCcZk=;
        b=nFYTvOwZI5fvLiAsRfjya4QAyXRApa0nrdyIFLAOWI4XNzLmGY4nptz+6Y8gWivXn4
         stGW9VckdmeUTiZUjsqZNbZqjvOdYxtKOaSaAs2y+DzliZn4bi7n90sj8Y4OrPLCKwc+
         mVKtgQ1+WBTIXOgCtVYS399HWzwL6KWw+XijxZT8SYXaQHvdFQVVogVcbCAX6FcQVSuZ
         O6EFBhuf0TDDLujS25O1hdnh4zQCyNcx/naOlVXTz5um7Lf7MNt9xIS45C/FQhiMe/65
         iEn6zjMd9ZGHDiShWhZWw+6Lzw9RRRWbTj5rb1g31h304W7b8lPNeHYpaFoeGywmaYin
         Rg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iMKCNtVrFuUR6GRfj2YvDoumjSCaOdhEwxsJVghCcZk=;
        b=CUpz1ixuenERCTF/FmrZSbHrWfEscjv4bIrbvQW1aeLuT9tE+9V/yIPx44owwcdIGz
         tyEF59Ryh9gRbt6SXe+jbPdcS9LUnFtVAaQt2OXgyyxY7Tf8cZYAvNVZjJr6RGxWpNPr
         IruhcxXSPyCF0z0yYX5hKB2XtbAD3EduUe7zaLo6H2Ds5TdNQSaCGy4HZbVV19VjO5WL
         NDxwHZQupPuoN2mOhFI2M8GD/uGtiTiX5m+OiPr0GNaImceyLJl4OMxqbHdiKZE6TY/z
         M5ck7MP7RB0YOKGqTtsqAB2lPTdIuxKjMo5F7bvl5aO0rMsOIxU+fjNg+F5hsO1LYz0R
         TbLQ==
X-Gm-Message-State: APjAAAX9xO+UcOFQ3z6iSBdbvkOc9tgbO/1Xmmr6VQ1B3h7CmOJiC8bN
        Il8JucCDKGNXF5p3MiSE8IR84BN5
X-Google-Smtp-Source: APXvYqxf5wwRMz6HmgojlSgsMICAC8ZVDnL0vkwCXTOonLqJP9kq74P4LbNidUmVTkNbH8c7Bos5Sw==
X-Received: by 2002:a17:902:d915:: with SMTP id c21mr16552279plz.295.1576865683589;
        Fri, 20 Dec 2019 10:14:43 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com.com ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id c78sm14063082pfb.122.2019.12.20.10.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 10:14:43 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 11/15] t1409: use test_path_is_missing()
Date:   Fri, 20 Dec 2019 10:15:58 -0800
Message-Id: <1eef3f4bc5f93b8a0a6ce8b26a208cba4f06a56c.1576865664.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576865663.git.liu.denton@gmail.com>
References: <cover.1576794144.git.liu.denton@gmail.com> <cover.1576865663.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail() function should only be used for git commands since
we should assume that external commands work sanely. Replace
`test_must_fail test -f` with `test_path_is_missing` since we expect
these paths to not exist.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t1409-avoid-packing-refs.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t1409-avoid-packing-refs.sh b/t/t1409-avoid-packing-refs.sh
index f74d890e82..be12fb6350 100755
--- a/t/t1409-avoid-packing-refs.sh
+++ b/t/t1409-avoid-packing-refs.sh
@@ -27,15 +27,15 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'do not create packed-refs file gratuitously' '
-	test_must_fail test -f .git/packed-refs &&
+	test_path_is_missing .git/packed-refs &&
 	git update-ref refs/heads/foo $A &&
-	test_must_fail test -f .git/packed-refs &&
+	test_path_is_missing .git/packed-refs &&
 	git update-ref refs/heads/foo $B &&
-	test_must_fail test -f .git/packed-refs &&
+	test_path_is_missing .git/packed-refs &&
 	git update-ref refs/heads/foo $C $B &&
-	test_must_fail test -f .git/packed-refs &&
+	test_path_is_missing .git/packed-refs &&
 	git update-ref -d refs/heads/foo &&
-	test_must_fail test -f .git/packed-refs
+	test_path_is_missing .git/packed-refs
 '
 
 test_expect_success 'check that marking the packed-refs file works' '
-- 
2.24.1.703.g2f499f1283

