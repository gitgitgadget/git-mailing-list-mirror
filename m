Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37556C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 11:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243960AbiFCLPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 07:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242706AbiFCLPg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 07:15:36 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F83C3C483
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 04:15:35 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id d5-20020a05600c34c500b0039776acee62so4658076wmq.1
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 04:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EkpR+QQ+khwjP7C/sfiYkep4cDRqQOpIr9XF0Qv72R8=;
        b=cEEnspcTorJ9zlIQ/Xygb5lKR/GK1l78TK7rR9Q6CATqgqphyTTvedTvjuST3Hjgrx
         4F8MDBMANWDxxc4fRleCFcw8URCbA1ZGGnZm/vcFRCrY/h0/bnR8ir8Done1wlauMVdP
         FHOmqB5eSYQC6e8NpgTek70lN2S0jCnWdXW9gbXl8FJMw2LGVNafWBl8ALGd8LpFxxkK
         rDUTnc2w5Vg/IVzvJavsfVesFP7kR2JiZmfatXqhhMdGKdailoRY/z4nVPBZN/BxxCgk
         teupAmKlSk/WbDyzCjYcgnF9NwfqwnRGGoR6S2a9iK8IWkGtqQtq9HC9G7cCG/BhaMMo
         2A0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EkpR+QQ+khwjP7C/sfiYkep4cDRqQOpIr9XF0Qv72R8=;
        b=w/61lzvV5qpVBhlDps13QlSnQSbuDfgtk002NfYsHyvS09GawXbuCzF6Gc21ZOm7NP
         aGzchUGx71RQlebjnRDcuOpF/RTaavZyLz/dz7hQMTLJdfmC2IiAwXOLiEN+qQjQVgid
         hTyQHLjC6KMHTzEkgUiDfdIlZznd/kU+XETq7lgJePOqd5uDlY48IXll5FXnKtBBAeQe
         pybh3Yfcv1UOs+tKWan0jcV4NwwYw74NSq8wW/8tLbLIWdDk8gHVE7lK89FWjpKbyGpz
         VfELzuBs61xotjtWersr4N1CEqQTGnDe0NGL1M5OE1lknXYMH/XTnGiuauauymIE3cHF
         eaYQ==
X-Gm-Message-State: AOAM530m5ZJ2fHDnVzWSxQqs7w2qj8iBMyEg5rdMUoSbVXQi0QD3vR2a
        2Pg4gyhbojvhBZx4YsXAsHPHdAO8uKVeFw==
X-Google-Smtp-Source: ABdhPJwg45h1Cgbly5IMoCoX4UXvoZogZ+Wv5AYnnB6HSOW9OwNBurc/zepixe5XlMqfPi3cgcpoxw==
X-Received: by 2002:a1c:29c3:0:b0:350:9797:b38f with SMTP id p186-20020a1c29c3000000b003509797b38fmr37892010wmp.22.1654254933346;
        Fri, 03 Jun 2022 04:15:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h24-20020adfa4d8000000b0020d0a57af5esm7184357wrb.79.2022.06.03.04.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 04:15:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/7] tests: don't assume a .git/info for .git/info/attributes
Date:   Fri,  3 Jun 2022 13:15:06 +0200
Message-Id: <patch-v2-4.7-64292c20c84-20220603T110506Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1119.g5a713b43bd4
In-Reply-To: <cover-v2-0.7-00000000000-20220603T110506Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com> <cover-v2-0.7-00000000000-20220603T110506Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change those tests that assumed that a .git/info directory would be
created for them when writing .git/info/attributes to explicitly
create the directory by setting "TEST_CREATE_REPO_NO_TEMPLATE=1"
before sourcing test-lib.sh, and using the "--template=" argument to
"git clone".

The change here in here in t7814-grep-recurse-submodules.sh would
continue "succeeding" with only the "TEST_CREATE_REPO_NO_TEMPLATE=1"
part of this change. That's because those tests use
"test_expect_failure", so they'd "pass" without this change, as
"test_expect_failure" by design isn't discerning about what failure
conditions it'll accept.

But as we're fixing these sorts of issues across the test suite let's
fix this one too. This issue was spotted with a local merge with
another topic of mine[1], which introduces a stricter alternative to
"test_expect_failure".

1. https://lore.kernel.org/git/cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0003-attributes.sh              | 5 ++++-
 t/t0028-working-tree-encoding.sh   | 2 ++
 t/t5000-tar-tree.sh                | 5 ++++-
 t/t5001-archive-attr.sh            | 5 ++++-
 t/t5002-archive-attr-pattern.sh    | 5 ++++-
 t/t5003-archive-zip.sh             | 5 ++++-
 t/t7814-grep-recurse-submodules.sh | 8 ++++++--
 7 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 143f1005179..f7ee2f2ff0e 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -3,6 +3,7 @@
 test_description=gitattributes
 
 TEST_PASSES_SANITIZE_LEAK=true
+TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
 attr_check_basic () {
@@ -284,7 +285,7 @@ test_expect_success 'using --git-dir and --work-tree' '
 '
 
 test_expect_success 'setup bare' '
-	git clone --bare . bare.git
+	git clone --template= --bare . bare.git
 '
 
 test_expect_success 'bare repository: check that .gitattribute is ignored' '
@@ -315,6 +316,7 @@ test_expect_success 'bare repository: check that --cached honors index' '
 test_expect_success 'bare repository: test info/attributes' '
 	(
 		cd bare.git &&
+		mkdir info &&
 		(
 			echo "f	test=f" &&
 			echo "a/i test=a/i"
@@ -360,6 +362,7 @@ test_expect_success SYMLINKS 'symlinks respected in core.attributesFile' '
 
 test_expect_success SYMLINKS 'symlinks respected in info/attributes' '
 	test_when_finished "rm .git/info/attributes" &&
+	mkdir .git/info &&
 	ln -s ../../attr .git/info/attributes &&
 	attr_check file set
 '
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 82905a2156f..7140960e1a3 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -5,6 +5,7 @@ test_description='working-tree-encoding conversion via gitattributes'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-encoding.sh"
 
@@ -69,6 +70,7 @@ test_expect_success 'check $GIT_DIR/info/attributes support' '
 	test_when_finished "rm -f test.utf32.git" &&
 	test_when_finished "git reset --hard HEAD" &&
 
+	mkdir .git/info &&
 	echo "*.utf32 text working-tree-encoding=utf-32" >.git/info/attributes &&
 	git add test.utf32 &&
 
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 7f8d2ab0a72..de192b52c47 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -24,6 +24,7 @@ commit id embedding:
 
 '
 
+TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
 SUBSTFORMAT=%H%n
@@ -143,6 +144,7 @@ test_expect_success 'populate workdir' '
 test_expect_success \
     'add ignored file' \
     'echo ignore me >a/ignored &&
+     mkdir .git/info &&
      echo ignored export-ignore >.git/info/attributes'
 
 test_expect_success 'add files to repository' '
@@ -157,7 +159,8 @@ test_expect_success 'setup export-subst' '
 '
 
 test_expect_success 'create bare clone' '
-	git clone --bare . bare.git &&
+	git clone --template= --bare . bare.git &&
+	mkdir bare.git/info &&
 	cp .git/info/attributes bare.git/info/attributes
 '
 
diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
index 712ae522994..2f6eef5e372 100755
--- a/t/t5001-archive-attr.sh
+++ b/t/t5001-archive-attr.sh
@@ -2,6 +2,7 @@
 
 test_description='git archive attribute tests'
 
+TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
 SUBSTFORMAT='%H (%h)%n'
@@ -20,6 +21,7 @@ extract_tar_to_dir () {
 
 test_expect_success 'setup' '
 	echo ignored >ignored &&
+	mkdir .git/info &&
 	echo ignored export-ignore >>.git/info/attributes &&
 	git add ignored &&
 
@@ -46,7 +48,8 @@ test_expect_success 'setup' '
 
 	git commit -m. &&
 
-	git clone --bare . bare &&
+	git clone --template= --bare . bare &&
+	mkdir bare/info &&
 	cp .git/info/attributes bare/info/attributes
 '
 
diff --git a/t/t5002-archive-attr-pattern.sh b/t/t5002-archive-attr-pattern.sh
index a66b5ba27e8..78ab75f1bc2 100755
--- a/t/t5002-archive-attr-pattern.sh
+++ b/t/t5002-archive-attr-pattern.sh
@@ -3,6 +3,7 @@
 test_description='git archive attribute pattern tests'
 
 TEST_PASSES_SANITIZE_LEAK=true
+TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
 test_expect_exists() {
@@ -15,6 +16,7 @@ test_expect_missing() {
 
 test_expect_success 'setup' '
 	echo ignored >ignored &&
+	mkdir .git/info &&
 	echo ignored export-ignore >>.git/info/attributes &&
 	git add ignored &&
 
@@ -54,7 +56,8 @@ test_expect_success 'setup' '
 
 	git commit -m. &&
 
-	git clone --bare . bare &&
+	git clone --template= --bare . bare &&
+	mkdir bare/info &&
 	cp .git/info/attributes bare/info/attributes
 '
 
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index d726964307c..a7bbfcb7f75 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -2,6 +2,7 @@
 
 test_description='git archive --format=zip test'
 
+TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
 SUBSTFORMAT=%H%n
@@ -121,6 +122,7 @@ test_expect_success 'prepare file list' '
 test_expect_success \
     'add ignored file' \
     'echo ignore me >a/ignored &&
+     mkdir .git/info &&
      echo ignored export-ignore >.git/info/attributes'
 
 test_expect_success 'add files to repository' '
@@ -139,7 +141,8 @@ test_expect_success 'setup export-subst and diff attributes' '
 '
 
 test_expect_success 'create bare clone' '
-	git clone --bare . bare.git &&
+	git clone --template= --bare . bare.git &&
+	mkdir bare.git/info &&
 	cp .git/info/attributes bare.git/info/attributes &&
 	# Recreate our changes to .git/config rather than just copying it, as
 	# we do not want to clobber core.bare or other settings.
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index a4476dc4922..3ad80526c4c 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -6,6 +6,7 @@ This test verifies the recurse-submodules feature correctly greps across
 submodules.
 '
 
+TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
 GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
@@ -471,8 +472,10 @@ test_expect_failure 'grep --textconv: superproject .gitattributes (from index) d
 test_expect_failure 'grep --textconv: superproject .git/info/attributes does not affect submodules' '
 	reset_and_clean &&
 	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
-	super_attr="$(git rev-parse --git-path info/attributes)" &&
+	super_info="$(git rev-parse --git-path info)" &&
+	super_attr="$super_info/attributes" &&
 	test_when_finished "rm -f \"$super_attr\"" &&
+	mkdir "$super_info" &&
 	echo "a diff=d2x" >"$super_attr" &&
 
 	cat >expect <<-\EOF &&
@@ -516,7 +519,8 @@ test_expect_failure 'grep --textconv correctly reads submodule .git/info/attribu
 	reset_and_clean &&
 	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
 
-	submodule_attr="$(git -C submodule rev-parse --path-format=absolute --git-path info/attributes)" &&
+	submodule_info="$(git -C submodule rev-parse --path-format=absolute --git-path info)" &&
+	submodule_attr="$submodule_info/attributes" &&
 	test_when_finished "rm -f \"$submodule_attr\"" &&
 	echo "a diff=d2x" >"$submodule_attr" &&
 
-- 
2.36.1.1119.g5a713b43bd4

