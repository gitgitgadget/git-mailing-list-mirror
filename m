Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F61AC4332D
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7057820757
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCCfcILW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgCVA4L (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 20:56:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36145 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgCVA4J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 20:56:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id i13so5517652pfe.3
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 17:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xhjB6OpE2jsvt0Qsr3VT+X0Amcl8TSJfdeWJ9T/KVuI=;
        b=MCCfcILWE3rdqd98mggBabtOZL5CnyYQscBmzUkTwZWrVgssn17KtA8z/PVee3vlw3
         Sz8HQu/PXLlUJaznD/BdcFHvyxhgDpA4lIFBMoE/POu6sExl/+30/BI6z6KrlEzbZIyT
         VPGMbEjegDDnDS3Cu6Vxw2r6xDEkVOWn3Jv6+nV6zTy8pf1BNM19JBLU/Lku1Dvs8M0K
         mXyG9Zo99q0k1gI80Bgw/Ab6lgza57NZKGzSw2Q0Dk6JP4JHEz7TeivZRVzFvsHK0iwb
         HjJC1Qbxd1CTfwWA8TELVSxcFPiSAS9uxZSbdNDzspMAGYBIW98yRYzWpmIe6lUyr3uv
         +v2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xhjB6OpE2jsvt0Qsr3VT+X0Amcl8TSJfdeWJ9T/KVuI=;
        b=iQPQsl3/aXitBudOV8uHCD0GUdsaY2M8KL2O43Js7nLIc5yZSDJuwfzRLARnO/cqIy
         aCHVWUM4Lcgz+oKVtxzglxCD0B7mDWQUZSLPa1P1zrrydYtUZ58ZdZd4KrAsgp3wFiHA
         GLGQg7NsL4stjtRnWH8lradtP66jt8xEL2x8uPeIrMhlu9HoOrAucMxQP+WvNUuSzzBW
         y9EeNbGwkZKzKPchAKIvhz52O305f52FWSmNgof5sKN5/67RdMF+RCD9ItaIcF+oBfcF
         aNFyr3qamcUTM5CMjbllE44n7EckXA2n8j5yw2ImkXWX7mYj3oQZVQRoBW3cjwOoWdsY
         OX0A==
X-Gm-Message-State: ANhLgQ2Pw7I6gJ9RksvpCMOiYGBKub+uSk68QuzvgGCOwlpBb677zT3S
        YJIC4tyUJ6aR4pdVZtr4GfPxcJIN
X-Google-Smtp-Source: ADFU+vv+6jdIyGOCTQ9w6h+gm1Y/MjfXpraPQwLVw1KnKW6xYea137Jy5cjhHE4QLTnHuKfv3mYl1Q==
X-Received: by 2002:a63:161e:: with SMTP id w30mr15456465pgl.110.1584838568549;
        Sat, 21 Mar 2020 17:56:08 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id r7sm9235641pfg.38.2020.03.21.17.56.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 17:56:06 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 4/8] t5003: skip conversion test if unzip -a is unavailable
Date:   Sun, 22 Mar 2020 07:55:15 +0700
Message-Id: <4f0ac0867c4b50edcee4255237f8a122155fd9d2.1584838148.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d
In-Reply-To: <cover.1584838148.git.congdanhqx@gmail.com>
References: <cover.1584838148.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alpine Linux's default unzip(1) doesn't support `-a`.

Skip those tests on that platform.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t5003-archive-zip.sh | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index df1374a312..3b76d2eb65 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -11,6 +11,10 @@ test_lazy_prereq UNZIP_SYMLINKS '
 	test -h symlink
 '
 
+test_lazy_prereq UNZIP_CONVERT '
+	"$GIT_UNZIP" -a "$TEST_DIRECTORY"/t5003/infozip-symlinks.zip
+'
+
 check_zip() {
 	zipfile=$1.zip
 	listfile=$1.lst
@@ -35,33 +39,33 @@ check_zip() {
 	extracted=${dir_with_prefix}a
 	original=a
 
-	test_expect_success UNZIP " extract ZIP archive with EOL conversion" '
+	test_expect_success UNZIP_CONVERT " extract ZIP archive with EOL conversion" '
 		(mkdir $dir && cd $dir && "$GIT_UNZIP" -a ../$zipfile)
 	'
 
-	test_expect_success UNZIP " validate that text files are converted" "
+	test_expect_success UNZIP_CONVERT " validate that text files are converted" "
 		test_cmp_bin $extracted/text.cr $extracted/text.crlf &&
 		test_cmp_bin $extracted/text.cr $extracted/text.lf
 	"
 
-	test_expect_success UNZIP " validate that binary files are unchanged" "
+	test_expect_success UNZIP_CONVERT " validate that binary files are unchanged" "
 		test_cmp_bin $original/binary.cr   $extracted/binary.cr &&
 		test_cmp_bin $original/binary.crlf $extracted/binary.crlf &&
 		test_cmp_bin $original/binary.lf   $extracted/binary.lf
 	"
 
-	test_expect_success UNZIP " validate that diff files are converted" "
+	test_expect_success UNZIP_CONVERT " validate that diff files are converted" "
 		test_cmp_bin $extracted/diff.cr $extracted/diff.crlf &&
 		test_cmp_bin $extracted/diff.cr $extracted/diff.lf
 	"
 
-	test_expect_success UNZIP " validate that -diff files are unchanged" "
+	test_expect_success UNZIP_CONVERT " validate that -diff files are unchanged" "
 		test_cmp_bin $original/nodiff.cr   $extracted/nodiff.cr &&
 		test_cmp_bin $original/nodiff.crlf $extracted/nodiff.crlf &&
 		test_cmp_bin $original/nodiff.lf   $extracted/nodiff.lf
 	"
 
-	test_expect_success UNZIP " validate that custom diff is unchanged " "
+	test_expect_success UNZIP_CONVERT " validate that custom diff is unchanged " "
 		test_cmp_bin $original/custom.cr   $extracted/custom.cr &&
 		test_cmp_bin $original/custom.crlf $extracted/custom.crlf &&
 		test_cmp_bin $original/custom.lf   $extracted/custom.lf
-- 
2.26.0.rc2.310.g2932bb562d

