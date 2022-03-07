Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5F1C4332F
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242584AbiCGMua (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242552AbiCGMuY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:50:24 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090194DF6A
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:49:30 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t11so23108962wrm.5
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XBMUQkY4jpQYr5/gFMSdhagGKyrXa3TcW9YCQZhGqaU=;
        b=RbHUeeEu2eVv55rCn+F3gC4EiTbAfPF9PZqvkuzz1VU1ZIbOc0sxBEhShXPuhkQPLP
         OqnXbAQwtBSh769wYWKu2Uw6TcUKs3iLEPydhHezeWcuqIWPErf28CtO1D19op+fWsMQ
         yt1i4UmfELP5G97ESVWTi6E4DmSym1ltZNNmXrcEpJI/j3NnBTcvYIo9B/jD2FChTKAr
         8a7V7QUlTInJ0/0BS0eEFOqw2dhPwCJhFrnZVMdQoewNvpcdXaSGUNkUYM3dxQeo6A13
         c0Rkfp0UzC1SOzDHpbnD7NMP7Qsp+GAHxEYtjdWBfi+VZ1OHuFvJebaJtR3FHWlf2QCz
         r2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XBMUQkY4jpQYr5/gFMSdhagGKyrXa3TcW9YCQZhGqaU=;
        b=nqD5wKwUddsFvFOfegwkL6++XNbnCi5PdRnUsSvwC6TmvLTXPWvYSz/yCZ/698CDda
         7wsj1ld4k5Pz5p7cxZP0zZT72DpgMzaFfLkIb3mQMZYO1A+s9RJajG7d/yEl8c+AwPwr
         Jclrd8rT+KsXcp2r3PmT6ieU0H9ujRzGxOREAyve9gYjh2dz20n7E3oMSrmVhVz/xbYY
         ouIYBUGUfMtSMhXiQhFm0Bc6yNsES8VY4ItvJE+WQJIk1N2WGruQ40aQRjgZKgbPlikX
         FOoYite4sK75CqN+TBQpOrasYySOJDoplPjfKLN6bdsWgShmpSAq65WLscYnrH6SLZK+
         C73w==
X-Gm-Message-State: AOAM532HSi3cv4jA6to9U6SrlGEZPj+zp4pnSq6jQDGMu4vyd7SqXqe+
        rfIk1df9clZ22Z52ObAPSlbf/EgfCSSZ3w==
X-Google-Smtp-Source: ABdhPJxF7EggU8aW6hPbakL9HTYT6iv2yQJy7WdIcTEjCrHQ/rXagCcxYd1jSTmOdwPSZ/m9eNdq2w==
X-Received: by 2002:a05:6000:22c:b0:1f0:ff85:948d with SMTP id l12-20020a056000022c00b001f0ff85948dmr8033166wrz.494.1646657368373;
        Mon, 07 Mar 2022 04:49:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a1c7503000000b0038100e2a1adsm12729091wmc.47.2022.03.07.04.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:49:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/15] diff tests: don't ignore "git diff" exit code in "read" loop
Date:   Mon,  7 Mar 2022 13:48:56 +0100
Message-Id: <patch-v2-05.15-b1aeac3f68e-20220307T124817Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1242.gfeba0eae32b
In-Reply-To: <cover-v2-00.15-00000000000-20220307T124817Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com> <cover-v2-00.15-00000000000-20220307T124817Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a test pattern that originated in f1af60bdba4 (Support 'diff=pgm'
attribute, 2007-04-22) so that we'll stop using "git diff" on the
left-hand-side of a pipe, and thus ignoring its exit code.

Rather than use intermediate files let's rewrite these tests to a much
simpler but more exhaustive "test_tmp" where we'll ignore certain
fields in the output.

Note that this is not a faithful conversion of the previous
"read/test" in some cases, as we were ignoring more fields there than
we strictly needed to. Now we'll "test_cmp" everything we can, and
only ignore the likes of paths to $TEMPDIR etc.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4020-diff-external.sh | 104 ++++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 51 deletions(-)

diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 879ee04d291..1219f8bd4c0 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -24,16 +24,12 @@ test_expect_success setup '
 '
 
 test_expect_success 'GIT_EXTERNAL_DIFF environment' '
-
-	GIT_EXTERNAL_DIFF=echo git diff | {
-		read path oldfile oldhex oldmode newfile newhex newmode &&
-		test "z$path" = zfile &&
-		test "z$oldmode" = z100644 &&
-		test "z$newhex" = "z$ZERO_OID" &&
-		test "z$newmode" = z100644 &&
-		oh=$(git rev-parse --verify HEAD:file) &&
-		test "z$oh" = "z$oldhex"
-	}
+	cat >expect <<-EOF &&
+	file $(git rev-parse --verify HEAD:file) 100644 file $(test_oid zero) 100644
+	EOF
+	GIT_EXTERNAL_DIFF=echo git diff >out &&
+	cut -d" " -f1,3- <out >actual &&
+	test_cmp expect actual
 
 '
 
@@ -52,15 +48,14 @@ test_expect_success 'GIT_EXTERNAL_DIFF environment and --no-ext-diff' '
 test_expect_success SYMLINKS 'typechange diff' '
 	rm -f file &&
 	ln -s elif file &&
-	GIT_EXTERNAL_DIFF=echo git diff  | {
-		read path oldfile oldhex oldmode newfile newhex newmode &&
-		test "z$path" = zfile &&
-		test "z$oldmode" = z100644 &&
-		test "z$newhex" = "z$ZERO_OID" &&
-		test "z$newmode" = z120000 &&
-		oh=$(git rev-parse --verify HEAD:file) &&
-		test "z$oh" = "z$oldhex"
-	} &&
+
+	cat >expect <<-EOF &&
+	file $(git rev-parse --verify HEAD:file) 100644 $(test_oid zero) 120000
+	EOF
+	GIT_EXTERNAL_DIFF=echo git diff >out &&
+	cut -d" " -f1,3-4,6- <out >actual &&
+	test_cmp expect actual &&
+
 	GIT_EXTERNAL_DIFF=echo git diff --no-ext-diff >actual &&
 	git diff >expect &&
 	test_cmp expect actual
@@ -70,15 +65,13 @@ test_expect_success 'diff.external' '
 	git reset --hard &&
 	echo third >file &&
 	test_config diff.external echo &&
-	git diff | {
-		read path oldfile oldhex oldmode newfile newhex newmode &&
-		test "z$path" = zfile &&
-		test "z$oldmode" = z100644 &&
-		test "z$newhex" = "z$ZERO_OID" &&
-		test "z$newmode" = z100644 &&
-		oh=$(git rev-parse --verify HEAD:file) &&
-		test "z$oh" = "z$oldhex"
-	}
+
+	cat >expect <<-EOF &&
+	file $(git rev-parse --verify HEAD:file) 100644 $(test_oid zero) 100644
+	EOF
+	git diff >out &&
+	cut -d" " -f1,3-4,6- <out >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success !SANITIZE_LEAK 'diff.external should apply only to diff' '
@@ -101,16 +94,12 @@ test_expect_success 'diff attribute' '
 
 	echo >.gitattributes "file diff=parrot" &&
 
-	git diff | {
-		read path oldfile oldhex oldmode newfile newhex newmode &&
-		test "z$path" = zfile &&
-		test "z$oldmode" = z100644 &&
-		test "z$newhex" = "z$ZERO_OID" &&
-		test "z$newmode" = z100644 &&
-		oh=$(git rev-parse --verify HEAD:file) &&
-		test "z$oh" = "z$oldhex"
-	}
-
+	cat >expect <<-EOF &&
+	file $(git rev-parse --verify HEAD:file) 100644 $(test_oid zero) 100644
+	EOF
+	git diff >out &&
+	cut -d" " -f1,3-4,6- <out >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success !SANITIZE_LEAK 'diff attribute should apply only to diff' '
@@ -132,16 +121,12 @@ test_expect_success 'diff attribute' '
 
 	echo >.gitattributes "file diff=color" &&
 
-	git diff | {
-		read path oldfile oldhex oldmode newfile newhex newmode &&
-		test "z$path" = zfile &&
-		test "z$oldmode" = z100644 &&
-		test "z$newhex" = "z$ZERO_OID" &&
-		test "z$newmode" = z100644 &&
-		oh=$(git rev-parse --verify HEAD:file) &&
-		test "z$oh" = "z$oldhex"
-	}
-
+	cat >expect <<-EOF &&
+	file $(git rev-parse --verify HEAD:file) 100644 $(test_oid zero) 100644
+	EOF
+	git diff >out &&
+	cut -d" " -f1,3-4,6- <out >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success !SANITIZE_LEAK 'diff attribute should apply only to diff' '
@@ -159,14 +144,26 @@ test_expect_success 'diff attribute and --no-ext-diff' '
 test_expect_success 'GIT_EXTERNAL_DIFF trumps diff.external' '
 	>.gitattributes &&
 	test_config diff.external "echo ext-global" &&
-	GIT_EXTERNAL_DIFF="echo ext-env" git diff | grep ext-env
+
+	cat >expect <<-EOF &&
+	ext-env file $(git rev-parse --verify HEAD:file) 100644 file $(test_oid zero) 100644
+	EOF
+	GIT_EXTERNAL_DIFF="echo ext-env" git diff >out &&
+	cut -d" " -f1-2,4- <out >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'attributes trump GIT_EXTERNAL_DIFF and diff.external' '
 	test_config diff.foo.command "echo ext-attribute" &&
 	test_config diff.external "echo ext-global" &&
 	echo "file diff=foo" >.gitattributes &&
-	GIT_EXTERNAL_DIFF="echo ext-env" git diff | grep ext-attribute
+
+	cat >expect <<-EOF &&
+	ext-attribute file $(git rev-parse --verify HEAD:file) 100644 file $(test_oid zero) 100644
+	EOF
+	GIT_EXTERNAL_DIFF="echo ext-env" git diff >out &&
+	cut -d" " -f1-2,4- <out >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'no diff with -diff' '
@@ -212,7 +209,12 @@ test_expect_success 'GIT_EXTERNAL_DIFF generates pretty paths' '
 	touch file.ext &&
 	git add file.ext &&
 	echo with extension > file.ext &&
-	GIT_EXTERNAL_DIFF=echo git diff file.ext | grep ......_file\.ext &&
+
+	cat >expect <<-EOF &&
+	file.ext file $(git rev-parse --verify HEAD:file) 100644 file.ext $(test_oid zero) 100644
+	EOF
+	GIT_EXTERNAL_DIFF=echo git diff file.ext >out &&
+	cut -d" " -f1,3- <out >actual &&
 	git update-index --force-remove file.ext &&
 	rm file.ext
 '
-- 
2.35.1.1242.gfeba0eae32b

