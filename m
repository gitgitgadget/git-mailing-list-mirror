Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D3AC4332E
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 14:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3EA208D6
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 14:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApJjJn13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgCSOAw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:00:52 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:33895 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbgCSOAw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 10:00:52 -0400
Received: by mail-pj1-f53.google.com with SMTP id q16so2349672pje.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 07:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TpIw7XkOPi1V5cIWZQ5hZqKQVaFSt5kJcyYTtLbcYDw=;
        b=ApJjJn13llpAwd+xWY3EDPh9NbhRBZo4+3ZQgiQ04vjdgge+xxvqipnWqEfpXBCcmv
         sRdbpGTCMy9f0IrKABSVpOvU6NLjvxhQpCgY05tDXhp2ra/+WHP6e70eY94cDdudvIDh
         TbWZ3B3cahEzbjYCuV8JD1ZWk17iCCjvFU4o3hoI2NSJ1OEKNdK1BsxlUrJ9RdEXfbMX
         24EWrySUAGDcaqXyFHQBhqwMHu2ZIfb7E8McrbkT00yRqeSh0qE/oe3Xnp9IwmwQKohU
         kI1xzxpEJEKr1L7frvvixWGHGc/Hcry/19qT4e5rKWqgNSHVnXcPaacNJsgah7XjVA70
         5qeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TpIw7XkOPi1V5cIWZQ5hZqKQVaFSt5kJcyYTtLbcYDw=;
        b=DR3RJ0ZLTDxP6h/Jb2MTBRqOF8X2B8VwSz3SImuhdetzJ8dSPBIZSadcEfq3QLSGZw
         WI1ctrJ2fCm5UMn6jSQEFzXwivVC13m89vfpBcnhjYgBGfgEVmA7Rh10MZFmEdxqgVIi
         gHnAJZBk2+y1ZhyOE9KyGwKn6OdIf3o+OmpkJkZXlmAdLko9n99jou7lWAi4BlZ+vBIh
         nFCCrHxNiC+RIYZ9gIFFeZbimyKifBJS7PUlp8oe28yJYVAmoT36gQhlsHGwQ8G/WeTh
         DNdfo5o+2v8HbFOURxWxNbqNgJNT5nnXqqy2nqIXvVvR5RK4IRHqhIj1X4poRJ6OqA4k
         Zg0Q==
X-Gm-Message-State: ANhLgQ39qi8VeYN0rus6+BsTYphoUXJhggzNGlW0AE4PBUQtZ9Yuzxek
        +ByOMecVNilSx1aNg5pZB9nofBvj
X-Google-Smtp-Source: ADFU+vuNYmIUPimrnR7C/CmRBX3/BmP8b3qfWpuglVjVWN0XP5fNVKvruCgI2O87Ieo7NBbrm1uEOQ==
X-Received: by 2002:a17:902:eb11:: with SMTP id l17mr3610182plb.52.1584626448921;
        Thu, 19 Mar 2020 07:00:48 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id 189sm2654005pfg.170.2020.03.19.07.00.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 07:00:47 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 3/6] t5003: skip conversion test if unzip -a is unavailable
Date:   Thu, 19 Mar 2020 21:00:04 +0700
Message-Id: <27c7813c0fe81455b675611b9e11fee6ee2a79e9.1584625896.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.234.g969ad452ca
In-Reply-To: <cover.1584625896.git.congdanhqx@gmail.com>
References: <cover.1584625896.git.congdanhqx@gmail.com>
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
 t/t5003-archive-zip.sh | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index 106eddbd85..78fb4bf323 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -15,6 +15,14 @@ test_lazy_prereq UNZIP_SYMLINKS '
 	)
 '
 
+test_lazy_prereq UNZIP_CONVERT '
+	(
+		mkdir unzip-convert &&
+		cd unzip-convert &&
+		"$GIT_UNZIP" -a "$TEST_DIRECTORY"/t5003/infozip-symlinks.zip
+	)
+'
+
 check_zip() {
 	zipfile=$1.zip
 	listfile=$1.lst
@@ -39,33 +47,33 @@ check_zip() {
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
2.26.0.rc2.234.g969ad452ca

