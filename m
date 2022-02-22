Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A69BC433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 21:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbiBVVzr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 16:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbiBVVzn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 16:55:43 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87D6A1BC0
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 13:55:17 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o62-20020a1ca541000000b00380e3cc26b7so1506119wme.0
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 13:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qjX0k/2CPH3awRnb457obI37xs9gGXnVslgcxk2Exu8=;
        b=csCFb+nfizcFcLbR+HUhOS6RW7LBaZaEQBRIRrQMOb/JnlYRAiwNmlUzE8tjPe06e0
         BmAbvCWPV1vRmOacdtkmf8iU780tLjH3IGr8soFy+TG3UYIMsbdd6nWFMZEzd9qc/aV5
         Gtte5ZtPxRR5h1uvgoqKO4h5qOGDhCYf+U5FKGxmNtcVC8raJ0pDy8zMXa1zx10LV3er
         z2idH3wBOj5oYkIAv6cCH34trdHZk2Xd9jLNfe22vHJh7I9D2lnWQ3WPKEE2OaJVW5Rf
         rFRYEHutazO5u/SWOdZ0MPKG0IHuc13imfdg95l7RLcqzduwaDz2LuiGg/r+YTWVT47v
         OfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qjX0k/2CPH3awRnb457obI37xs9gGXnVslgcxk2Exu8=;
        b=fKMERWkJDRvxsQNFgKtZawhQuRtOfrbMgOd9FSHEUVvYFVhQnB9l2HtuNG4msjAccl
         m8jg8EkL8svflhVRbQufpbD3fuVK5OKO3TY/zt/w7GndgUFxvLYZyXoVrJhsua3oFGAO
         QhBS4DHOgEBGws71EWO69/bcO1X5NaqOvsiLXq/0vzoZ89bwy0N4tnYhCCm5ty7Ir46X
         fOZQFfZRemT9UeEvAemWne9wvIars5rV98UEXee9l4irIwjj/xAD5Lv/4rr0lEOkQRwq
         0t/RBq2ODm4IISchBJ6uCzaXdextPbMDf/y+9dfJTl3JP13Qr976M0S8qJQptf2/9UuP
         pPHg==
X-Gm-Message-State: AOAM530QzbBL5kHUEnNfvGx2c1Ldc4Qy71lw4S1g/hVR/6SlPvI+wE+P
        qlBKtZpdYjBWpKVnBpssjZM=
X-Google-Smtp-Source: ABdhPJzvrpsoryaOdM4lxRo6988+ti4V8PlQof1jAVVePnr+LEgbee88IMubWMZOCYPNLeVXbwCSwQ==
X-Received: by 2002:a05:600c:511d:b0:380:e340:bfaf with SMTP id o29-20020a05600c511d00b00380e340bfafmr2764165wms.159.1645566916260;
        Tue, 22 Feb 2022 13:55:16 -0800 (PST)
Received: from localhost.localdomain (176.248.7.93.rev.sfr.net. [93.7.248.176])
        by smtp.gmail.com with ESMTPSA id u12sm39471997wrw.32.2022.02.22.13.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 13:55:15 -0800 (PST)
From:   COGONI Guillaume <cogoni.guillaume@gmail.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, cogoni.guillaume@gmail.com,
        git.jonathan.bressat@gmail.com, git@vger.kernel.org,
        guillaume.cogoni@gmail.com, matthieu.moy@univ-lyon1.fr
Subject: [PATCH v3 2/3] tests: allow testing if a path is truly a file or a directory
Date:   Tue, 22 Feb 2022 22:54:29 +0100
Message-Id: <20220222215430.605254-3-cogoni.guillaume@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220222215430.605254-1-cogoni.guillaume@gmail.com>
References: <xmqqbkz4105s.fsf@gitster.g>
 <20220222215430.605254-1-cogoni.guillaume@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add test_path_is_file_not_symlink(), test_path_is_dir_not_symlink()
and test_path_is_symlink(). Case of use for the first one
in test t/t3903-stash.sh to replace "test -f" because that function
explicitly want the file not to be a symlink.
Give more friendly error message.

Signed-off-by: COGONI Guillaume <cogoni.guillaume@gmail.com>
Co-authored-by: BRESSAT Jonathan <git.jonathan.bressat@gmail.com>
---
 t/t3903-stash.sh        |  6 +++---
 t/test-lib-functions.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 11a0856873..a6ad52db9f 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -390,7 +390,7 @@ test_expect_success SYMLINKS 'stash file to symlink' '
 	rm file &&
 	ln -s file2 file &&
 	git stash save "file to symlink" &&
-	test -f file &&
+	test_path_is_file_not_symlink file &&
 	test bar = "$(cat file)" &&
 	git stash apply &&
 	case "$(ls -l file)" in *" file -> file2") :;; *) false;; esac
@@ -401,7 +401,7 @@ test_expect_success SYMLINKS 'stash file to symlink (stage rm)' '
 	git rm file &&
 	ln -s file2 file &&
 	git stash save "file to symlink (stage rm)" &&
-	test -f file &&
+	test_path_is_file_not_symlink file &&
 	test bar = "$(cat file)" &&
 	git stash apply &&
 	case "$(ls -l file)" in *" file -> file2") :;; *) false;; esac
@@ -413,7 +413,7 @@ test_expect_success SYMLINKS 'stash file to symlink (full stage)' '
 	ln -s file2 file &&
 	git add file &&
 	git stash save "file to symlink (full stage)" &&
-	test -f file &&
+	test_path_is_file_not_symlink file &&
 	test bar = "$(cat file)" &&
 	git stash apply &&
 	case "$(ls -l file)" in *" file -> file2") :;; *) false;; esac
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 85385d2ede..0f439c99d6 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -856,6 +856,16 @@ test_path_is_file () {
 	fi
 }
 
+test_path_is_file_not_symlink () {
+	test "$#" -ne 1 && BUG "1 param"
+	test_path_is_file "$1" &&
+	if test -h "$1"
+	then
+		echo "$1 shouldn't be a symbolic link"
+		false
+	fi
+}
+
 test_path_is_dir () {
 	test "$#" -ne 1 && BUG "1 param"
 	if ! test -d "$1"
@@ -865,6 +875,16 @@ test_path_is_dir () {
 	fi
 }
 
+test_path_is_dir_not_symlink () {
+	test "$#" -ne 1 && BUG "1 param"
+	test_path_is_dir "$1" &&
+	if test -h "$1"
+	then
+		echo "$1 shouldn't be a symbolic link"
+		false
+	fi
+}
+
 test_path_exists () {
 	test "$#" -ne 1 && BUG "1 param"
 	if ! test -e "$1"
@@ -874,6 +894,15 @@ test_path_exists () {
 	fi
 }
 
+test_path_is_symlink () {
+	test "$#" -ne 1 && BUG "1 param"
+	if ! test -h "$1"
+	then
+		echo "Symbolic link $1 doesn't exist"
+		false
+	fi
+}
+
 # Check if the directory exists and is empty as expected, barf otherwise.
 test_dir_is_empty () {
 	test "$#" -ne 1 && BUG "1 param"
-- 
2.25.1

