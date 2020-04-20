Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8C4C3A5A0
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 08:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D8472145D
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 08:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3ZzmHeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgDTIy5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725865AbgDTIy5 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 04:54:57 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0513C061A0F
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 01:54:56 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 20so9679937qkl.10
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 01:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WNh2PdciZXeQAOKmhSRSdtAuo/MaAm16h7z3OTs+NHs=;
        b=m3ZzmHeHpM65O6GyEppAMIHDCl45EcZObEHv0RnSiF93wBw3UNAEoELFxbTNtOkrkQ
         MwdTCS1St5R/fB9lB9mBdrvvcxGcjjraMdxEhH64aCu8PdfUNp5dTGwtjmpvUIPCAovk
         VApJjXw8ZhabsStrADiDo/cnSSImbD3i8D4qaWSgr80NCcRxP60qVICwUR5gwzouV/DO
         mxs3F8C8yA5aj8hvA/3JY+vV3K15nrl9tt1MZvfQcZ3h81R6u83MgwDJeDBe2qsJVHlB
         Ygft5y0vj07OudFN69eccYKrQDFS/sW29XWkSxa+/+QtL+8cjQMgBlCwVsdfM96kVv2C
         Alag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WNh2PdciZXeQAOKmhSRSdtAuo/MaAm16h7z3OTs+NHs=;
        b=fp2FIfzwaTDEDGu6LEx0OnbwX8v3M+mc1YKl1/abqgjbS4ZG3tZPl95nf8J/CnxizM
         ztvbc3FmGHg71Rtll/9fB/0BiWuQbbzUZqaCCMaMl0x0gzQZtcyRgqN84L+SOgJJrENP
         JPwVGuS/FlHiS40UHDuNiEJRsKw5IwwTJEsiqHc7LPHy7+Sf0wN9YB6cP8yxt0Eed6B0
         A1V2h2SsNXT+W4jxlGXTLEdipZQdTOKIQIy9vpvLsdVtGkTxKo99H9GnWCK8q4ODwktj
         IPY38uOAezAAz7hkpVaAP1NueMUc5FS+/MPM2bzJKjpUnv7sLHi7CaOQAIDWvugas9ej
         1LDg==
X-Gm-Message-State: AGi0PubiOKtjIutsKJGhtT4cBfAVjpO3FnuJC7mvbzn6Kjlz6P+p0wEn
        3REGgd5WK7dvnZKrVUzPGhw9e6Wm
X-Google-Smtp-Source: APiQypLmGmD34LpkL4yWFllb5+RiGLzH9MexmplKcsOI6YXymucblVBUG3SZxTZg4M5j5rJn7aPz3g==
X-Received: by 2002:a37:98d:: with SMTP id 135mr14602501qkj.377.1587372895825;
        Mon, 20 Apr 2020 01:54:55 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id p25sm203222qkk.18.2020.04.20.01.54.55
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 01:54:55 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/8] t7408: replace incorrect uses of test_must_fail
Date:   Mon, 20 Apr 2020 04:54:40 -0400
Message-Id: <17db727121925cf0774e95a80ea13bbea8264931.1587372771.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1587372771.git.liu.denton@gmail.com>
References: <cover.1587372771.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to t/README, test_must_fail() should only be used to test for
failure in Git commands.

Replace the invocation of `test_must_fail test_path_is_file` with
`test_path_is_missing` since, in this test case, the path should not
exist at all.

In all the cases where `test_must_fail test_alternate_is_used` appears,
test_alternate_is_used() fails because test_line_count() cannot open the
non-existent $alternates_file. Replace
`test_must_fail test_alternate_is_used` with `test_path_is_missing` to
test for this directly.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7408-submodule-reference.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
index 34ac28c056..a3892f494b 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -122,8 +122,8 @@ test_expect_success 'missing submodule alternate fails clone and submodule updat
 		# update of the submodule succeeds
 		test_must_fail git submodule update --init &&
 		# and we have no alternates:
-		test_must_fail test_alternate_is_used .git/modules/sub/objects/info/alternates sub &&
-		test_must_fail test_path_is_file sub/file1
+		test_path_is_missing .git/modules/sub/objects/info/alternates &&
+		test_path_is_missing sub/file1
 	)
 '
 
@@ -137,7 +137,7 @@ test_expect_success 'ignoring missing submodule alternates passes clone and subm
 		# update of the submodule succeeds
 		git submodule update --init &&
 		# and we have no alternates:
-		test_must_fail test_alternate_is_used .git/modules/sub/objects/info/alternates sub &&
+		test_path_is_missing .git/modules/sub/objects/info/alternates &&
 		test_path_is_file sub/file1
 	)
 '
@@ -182,7 +182,7 @@ check_that_two_of_three_alternates_are_used() {
 	# immediate submodule has alternate:
 	test_alternate_is_used .git/modules/subwithsub/objects/info/alternates subwithsub &&
 	# but nested submodule has no alternate:
-	test_must_fail test_alternate_is_used .git/modules/subwithsub/modules/sub/objects/info/alternates subwithsub/sub
+	test_path_is_missing .git/modules/subwithsub/modules/sub/objects/info/alternates
 }
 
 
-- 
2.26.0.159.g23e2136ad0

