Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38543C2D0D2
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C912467E
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwE4ms92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfLSWVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:21:44 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53286 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbfLSWVn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 17:21:43 -0500
Received: by mail-pj1-f65.google.com with SMTP id n96so3175637pjc.3
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 14:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JALWx8kavwlDW5GZC+ZEtTUpTnn8GUR/cS+EbnJCO8w=;
        b=cwE4ms92Z7o49zf1qdq9LzchRwzOMJsxFYfHTVhl14nJwwbs6/hy7yYKQuBYA6L8CM
         EvjcbKPwTjfxnIctgX1scVELPbadxSw5hczba2STkfJi6aCr1OPCsTEiwat91OTmKUAn
         0oJmGY+sOk4qfhGN8IzAMoXL6TYbgi345azHVxoQERQOeNx+C+f9pCBbEBKZW1nt+0+3
         s+3gW2WJZZ9NUEurvXnr1yvp9nHQn042p0lXbncuROEa7XwYSbvt9iu8cuX69jrUl9ss
         kQV+u2rFo4z/w6LSIfFPw3Hdx3ERU/vmToVkbSHr+ZljMET9TG5CkdNQEyIesKiGpX+q
         rmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JALWx8kavwlDW5GZC+ZEtTUpTnn8GUR/cS+EbnJCO8w=;
        b=nQUeVAWvYxXTA9RfimCCUAZfHKWdEKaJtIEMvfOqqNPU1UnoDl7rXsKx5NebBgDW4Q
         DFjgnPMmXL+R+v3hCnXucIAgcF4TN1bI1g+/hH0VnzUo6enkxtCCqCFqhGF6NcmG3vB0
         RgHW4PnvuuNm/UtfINS4BLgIURAv9EOotXcg87kVQgaAwPlOFkhLWOlR2DBpRgg/yDm7
         TxPk6udi2HjC/0MRK1v9FujzLhhpqZE6ocrftAR/qmMMeJzoLfm8qpR82si6Cu7YWgNt
         L1nqB3jDWjybm1G6O/OzOaKM0dxDL76cc6358A6JS0i2ph8aSP8htAGoy7fw3/sw2Y8o
         RHjw==
X-Gm-Message-State: APjAAAVfskO/X3B9z4SURHUTbocrlXelpPDesDHFxSJkvsgKsPwLAbyG
        KoZexc5V7N/qOnXpG4QO4XlIvKoQ
X-Google-Smtp-Source: APXvYqzOoV493nFqOtPeR/eX1oU5hREOd3bMPylOnxFjddFt8Y9kk4ld9ztfHnXZsUuk5S2rn22F3g==
X-Received: by 2002:a17:902:9048:: with SMTP id w8mr11388157plz.294.1576794102346;
        Thu, 19 Dec 2019 14:21:42 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id o19sm11428528pjr.2.2019.12.19.14.21.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 14:21:41 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/16] t0020: use ! check_packed_refs_marked
Date:   Thu, 19 Dec 2019 14:22:43 -0800
Message-Id: <27550eaae6d4944be6090541a4940c818099216c.1576794144.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576794144.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com> <cover.1576794144.git.liu.denton@gmail.com>
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

