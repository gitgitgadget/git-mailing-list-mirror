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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AF2C2D0D2
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA442082E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiocWMPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfLTSOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:14:44 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36167 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbfLTSOk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 13:14:40 -0500
Received: by mail-pf1-f195.google.com with SMTP id x184so5645502pfb.3
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 10:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JALWx8kavwlDW5GZC+ZEtTUpTnn8GUR/cS+EbnJCO8w=;
        b=eiocWMPXeHWPDzprHw1ARxeRWobjv6eB2H6hZHNiphC/Urlz7sRkNEWjDvhZpykIG/
         Zt6/j0hCdA89JVBDYD37NijQQ8BA8XggwO+S5Kkp1YQtCduXhtHWsVakStLkA/tynhkH
         bmyAYBlqcuO8dusc6lu0SXEVu8+A45kwsciC/kIrlp8JSrngzv3Os8RtaIFRdp7HrhWL
         xOTjPj5FzM919+wPL9SkO6pGwpUIsdurb7NRAFtGq3YYdT5f+CuSdLWECsC8T+u1G3e9
         HQlrZAM0JK9EjKiqACWXMJdAjeEyWCQK/haX1GiqTSyl33D4T5jIlorjEU1YLVbMhJpI
         yVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JALWx8kavwlDW5GZC+ZEtTUpTnn8GUR/cS+EbnJCO8w=;
        b=DXQsM6KJKC20jLcOGOirNjGMH0rtLkqLxlw8zS7uRlWBLZnsa2qt76khMPK928YBcj
         JAiB4xTvV5y5jpfMxS8pprE8uWniBGJzEAb85Fi5o46l9afe1+TzoparP1lpgMYZq4wN
         6DW69ZMHucROGV1sAX7ATwTewUpL335LLh+11qs8xxHICR4pB+nALS/p9NXQlG9pE+uR
         y54OCsc6weZffZffUuxOjb3hapqJ00cf9knHtH40HY1sBQUyW0+moWnYlIS1Dbiz/+9y
         scTUQ+YbBUObEaSpImoV1vBll9j63eAFT41PZkxK3+WZaj+h4ZYv4AfwJF2dIbP6mjE1
         vR6A==
X-Gm-Message-State: APjAAAWJ1gvt7jUfkmb+z4dAAQFA0kI4HyntpAR0ZuzUcH0JHLpLhYYF
        HxFBjVckdVaMkaLWnxn+CrvdUrxF
X-Google-Smtp-Source: APXvYqxQhnbPe03AevbEtL771P9BedjmzR1AZpOmWGzJYH3J8yhJxLLUoDKgzCvjDBTxfb0R+77Odw==
X-Received: by 2002:a62:fc93:: with SMTP id e141mr17067597pfh.262.1576865680230;
        Fri, 20 Dec 2019 10:14:40 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com.com ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id c78sm14063082pfb.122.2019.12.20.10.14.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 10:14:39 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 07/15] t0020: use ! check_packed_refs_marked
Date:   Fri, 20 Dec 2019 10:15:54 -0800
Message-Id: <fc32b8d5847f57e7ea64e3be339cf7451ecd919e.1576865664.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576865663.git.liu.denton@gmail.com>
References: <cover.1576794144.git.liu.denton@gmail.com> <cover.1576865663.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail function should only be used for git commands since
we should assume that external commands work sanely. Since
check_packed_refs_marked() just wraps a grep invocation, replace
`test_must_fail check_packed_refs_marked` with
`! check_packed_refs_marked`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t1409-avoid-packing-refs.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1409-avoid-packing-refs.sh b/t/t1409-avoid-packing-refs.sh
index e5cb8a252d..c46848eb8e 100755
--- a/t/t1409-avoid-packing-refs.sh
+++ b/t/t1409-avoid-packing-refs.sh
@@ -46,7 +46,7 @@ test_expect_success 'check that marking the packed-refs file works' '
 	git for-each-ref >actual &&
 	test_cmp expected actual &&
 	git pack-refs --all &&
-	test_must_fail check_packed_refs_marked &&
+	! check_packed_refs_marked &&
 	git for-each-ref >actual2 &&
 	test_cmp expected actual2
 '
@@ -80,7 +80,7 @@ test_expect_success 'touch packed-refs on delete of packed' '
 	git pack-refs --all &&
 	mark_packed_refs &&
 	git update-ref -d refs/heads/packed-delete &&
-	test_must_fail check_packed_refs_marked
+	! check_packed_refs_marked
 '
 
 test_expect_success 'leave packed-refs untouched on update of loose' '
-- 
2.24.1.703.g2f499f1283

