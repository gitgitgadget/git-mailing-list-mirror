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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23A8C43333
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9701D20754
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKFlEGbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgCVA4H (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 20:56:07 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:39456 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgCVA4G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 20:56:06 -0400
Received: by mail-pl1-f176.google.com with SMTP id m1so4238625pll.6
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 17:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CjVlM/V8uCGKUp3mciin+PqSvNs49cWT/2HLr1Z1rKs=;
        b=dKFlEGbzhQ1uQ1vpZPpl8UdzIDXzDu1RxmQD6T98Y55HdcpjfTowMwliRjjGoNaBfS
         DB6rsPhtROnbI0mGIYYsCCKqyz6NiKNuh3nVQv4uUdHux/6TggFn/14yPl2Yae99xrQE
         b8d6uI0EQZkX1KG+9s/rFf4rdq/E6IAM5p9SI1AR4P8/WMue+20XHmwJdvGRvy9fadgL
         Nxf2wCn/VMwf88eNf/1GiDBvvQkGHVnbmvsZrFdRxIOY9xZRE9OAJvkzeEEHeTVmpsJ5
         KXf47KBZgxwhmw6+RbImKhYwueuibS+DtoN5ZtgfhS+YT4UKhLc6IlU3NCZmVeAXbHC4
         rYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CjVlM/V8uCGKUp3mciin+PqSvNs49cWT/2HLr1Z1rKs=;
        b=r+TqP3hFKvztZYJh+GPEpfOqlGLJ4Xm8pkQ64VLVflCqzqlmNjUfy6LRtLPMUqWg6D
         BXWrD/D4Q3kzUvPYSC7Sz85iYXtXQztiSn3U1dFT4E9WlTmCJE6jxxvnkPxDZY/CbchB
         BZP0Tyv1Tg4x/YinAbVfdnZXj214D2rojwK7OejEHJZMxyrtj/be7YIsG2UhoW9LJsiX
         4KPfiKn4KawYISvTLbmeEyVQYNzaOMHszOq92BhacnLSr/L/ZrequXhIk2E2FQnTYdDc
         CTZb9Z3JOa+pnXEWifUNu30HiWInC+acb9eHwQj30hINyl27UHxy8SRW4QG874QMLTVy
         hbwg==
X-Gm-Message-State: ANhLgQ2qT2T+6+/VC53pBAdByl4etEOWI/AXi6leXvJHN+vMgJQzyCV/
        /3RY7jbU8CeTnuYKoyvI5Kve+0HU
X-Google-Smtp-Source: ADFU+vudZy6Uzljja52SHQOqEceWaOaPr6QPBs2BeDOuRtjgh2e2alxNORopu0UAm5wlLgKbKUvKqw==
X-Received: by 2002:a17:90a:b94a:: with SMTP id f10mr17085762pjw.62.1584838565459;
        Sat, 21 Mar 2020 17:56:05 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id r7sm9235641pfg.38.2020.03.21.17.56.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 17:56:04 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 3/6] t5003: skip conversion test if unzip -a is unavailable
Date:   Sun, 22 Mar 2020 07:55:14 +0700
Message-Id: <ddeeefeae2acec37a36ab90d98215b585b22df96.1584838133.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d
In-Reply-To: <cover.1584838133.git.congdanhqx@gmail.com>
References: <cover.1584838133.git.congdanhqx@gmail.com>
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
2.26.0.rc2.310.g2932bb562d

