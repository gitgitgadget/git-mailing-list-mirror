Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC1EC433DB
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 13:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49EE964E70
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 13:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhBLNcP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 08:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbhBLNbX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 08:31:23 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8F8C0617AB
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 05:30:04 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id u16so949306wmq.1
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 05:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DYMvkgxqG0ytZexsNHOdwioTmQGfVTFgltb24BdnVf0=;
        b=GIcOYZ9PEW/mDEN4l7Ch+lwV++k/dUgXc3ksrCCqWfgHiTJdhd/RHjsXjGh12l5Cqc
         2k///TsbzJReP33ADF5Ik4Nw05KeGjlZ0ykt1IqGoA4z+D2Pskhk7P6tRVGX5OWtP78I
         PtYa4+gXDLHC6Ken/VESRRP27qjcuX3lqjul//fFgQ1fSTbkD3aGH8v8c9uRYOex1XSf
         +KWwndczZXLYTGe6f7Dm7Y+hcuxxlaAupcvd7kqvDbmiIC/uBfuCzp7mHx0ibXJX/2q8
         yy/JAzoVLO9v8Kj5sxXa8Zh0r4bAYsPwbtKDa+RLf0h4PVH93hsmgQuoEQDQ6UAlVY/t
         3QZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DYMvkgxqG0ytZexsNHOdwioTmQGfVTFgltb24BdnVf0=;
        b=QHGUgPqd2D3zGjvDHENjvyL0l22AchpHR47V74S1cf2XpH8ghzf0n85zdcBvk63+bp
         Ptk8gjIcxTunZoXCrOSX5/ArOOnAicVGOyEnbalbKdZKgmfu8hLZdKkytE4hkhNueMqR
         cC1nHgYtNXXpiAGO5w60r/Rfk/YIdr91SWvDp6jCiMEcAB1YW75+9edSpd8adPj1UxMN
         m4Pzud8vJiwN/MygwOMc8N0/D633f0HQm8I/0GgBI/88HDuV4gZKBsrGLewXunD2og2P
         WyQhONv5PLdfz3BgdizPH3v7a0DMBHeBVHbobCMfAGCOKTJossAG1DVHU2D+TR09hP0L
         dC0g==
X-Gm-Message-State: AOAM531KexGDY8B1MvoZHRUx3c//vo1Zt2u7TKbf6Ts6RRMoaHpiMvOQ
        FwltZXlU2wZxpgxY1BN2prfwL1XIx5iEsQ==
X-Google-Smtp-Source: ABdhPJwzNUh4Z3iH18cumxiQUsHz2I2LwstF6YoR1UytlpX2tYrJMzvdG+Plrzw7H0n3YhxMziTtdw==
X-Received: by 2002:a1c:bc46:: with SMTP id m67mr2779370wmf.82.1613136602852;
        Fri, 12 Feb 2021 05:30:02 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 13sm14060682wmj.11.2021.02.12.05.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 05:30:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/11] test libs: rename "diff-lib" to "lib-diff"
Date:   Fri, 12 Feb 2021 14:29:40 +0100
Message-Id: <20210212132942.17325-10-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210209214159.22815-1-avarab@gmail.com>
References: <20210209214159.22815-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the "diff-lib" to "lib-diff". With this rename and preceding
commits there is no remaining t/*lib* which doesn't follow the
convention of being called t/lib-*.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/.gitattributes                      | 2 +-
 t/{diff-lib.sh => lib-diff.sh}        | 0
 t/{diff-lib => lib-diff}/COPYING      | 0
 t/{diff-lib => lib-diff}/README       | 0
 t/t4000-diff-format.sh                | 2 +-
 t/t4001-diff-rename.sh                | 2 +-
 t/t4003-diff-rename-1.sh              | 6 +++---
 t/t4004-diff-rename-symlink.sh        | 2 +-
 t/t4005-diff-rename-2.sh              | 6 +++---
 t/t4007-rename-3.sh                   | 6 +++---
 t/t4008-diff-break-rewrite.sh         | 6 +++---
 t/t4009-diff-rename-4.sh              | 6 +++---
 t/t4010-diff-pathspec.sh              | 2 +-
 t/t4011-diff-symlink.sh               | 2 +-
 t/t4013-diff-various.sh               | 2 +-
 t/t4015-diff-whitespace.sh            | 2 +-
 t/t4027-diff-submodule.sh             | 2 +-
 t/t4034-diff-words.sh                 | 2 +-
 t/t4038-diff-combined.sh              | 2 +-
 t/t4061-diff-indent.sh                | 2 +-
 t/t4206-log-follow-harder-copies.sh   | 2 +-
 t/t7501-commit-basic-functionality.sh | 2 +-
 t/t9300-fast-import.sh                | 2 +-
 23 files changed, 30 insertions(+), 30 deletions(-)
 rename t/{diff-lib.sh => lib-diff.sh} (100%)
 rename t/{diff-lib => lib-diff}/COPYING (100%)
 rename t/{diff-lib => lib-diff}/README (100%)

diff --git a/t/.gitattributes b/t/.gitattributes
index d778bfad052..dafa17c3e61 100644
--- a/t/.gitattributes
+++ b/t/.gitattributes
@@ -1,6 +1,6 @@
 t[0-9][0-9][0-9][0-9]/* -whitespace
 /chainlint/*.expect eol=lf
-/diff-lib/* eol=lf
+/lib-diff/* eol=lf
 /t0110/url-* binary
 /t3206/* eol=lf
 /t3900/*.txt eol=lf
diff --git a/t/diff-lib.sh b/t/lib-diff.sh
similarity index 100%
rename from t/diff-lib.sh
rename to t/lib-diff.sh
diff --git a/t/diff-lib/COPYING b/t/lib-diff/COPYING
similarity index 100%
rename from t/diff-lib/COPYING
rename to t/lib-diff/COPYING
diff --git a/t/diff-lib/README b/t/lib-diff/README
similarity index 100%
rename from t/diff-lib/README
rename to t/lib-diff/README
diff --git a/t/t4000-diff-format.sh b/t/t4000-diff-format.sh
index e5116a76a1c..cce334981e1 100755
--- a/t/t4000-diff-format.sh
+++ b/t/t4000-diff-format.sh
@@ -7,7 +7,7 @@ test_description='Test built-in diff output engine.
 
 '
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/diff-lib.sh
+. "$TEST_DIRECTORY"/lib-diff.sh
 
 echo >path0 'Line 1
 Line 2
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index c16486a9d41..2f9700742aa 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -7,7 +7,7 @@ test_description='Test rename detection in diff engine.
 
 '
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/diff-lib.sh
+. "$TEST_DIRECTORY"/lib-diff.sh
 
 test_expect_success 'setup' '
 	cat >path0 <<-\EOF &&
diff --git a/t/t4003-diff-rename-1.sh b/t/t4003-diff-rename-1.sh
index df2accb6555..db07ff3eb19 100755
--- a/t/t4003-diff-rename-1.sh
+++ b/t/t4003-diff-rename-1.sh
@@ -7,11 +7,11 @@ test_description='More rename detection
 
 '
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/diff-lib.sh ;# test-lib chdir's into trash
+. "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
 test_expect_success \
     'prepare reference tree' \
-    'cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
+    'cat "$TEST_DIRECTORY"/lib-diff/COPYING >COPYING &&
      echo frotz >rezrov &&
     git update-index --add COPYING rezrov &&
     tree=$(git write-tree) &&
@@ -99,7 +99,7 @@ test_expect_success \
 
 test_expect_success \
     'prepare work tree once again' \
-    'cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
+    'cat "$TEST_DIRECTORY"/lib-diff/COPYING >COPYING &&
      git update-index --add --remove COPYING COPYING.1'
 
 # tree has COPYING and rezrov.  work tree has COPYING and COPYING.1,
diff --git a/t/t4004-diff-rename-symlink.sh b/t/t4004-diff-rename-symlink.sh
index 6e562c80d12..3d495e37bb1 100755
--- a/t/t4004-diff-rename-symlink.sh
+++ b/t/t4004-diff-rename-symlink.sh
@@ -10,7 +10,7 @@ copy of symbolic links, but should not produce rename/copy followed
 by an edit for them.
 '
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/diff-lib.sh
+. "$TEST_DIRECTORY"/lib-diff.sh
 
 test_expect_success SYMLINKS \
     'prepare reference tree' \
diff --git a/t/t4005-diff-rename-2.sh b/t/t4005-diff-rename-2.sh
index d18a80493c2..86479061325 100755
--- a/t/t4005-diff-rename-2.sh
+++ b/t/t4005-diff-rename-2.sh
@@ -6,10 +6,10 @@
 test_description='Same rename detection as t4003 but testing diff-raw.'
 
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/diff-lib.sh ;# test-lib chdir's into trash
+. "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
 test_expect_success 'setup reference tree' '
-	cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
+	cat "$TEST_DIRECTORY"/lib-diff/COPYING >COPYING &&
 	echo frotz >rezrov &&
 	git update-index --add COPYING rezrov &&
 	tree=$(git write-tree) &&
@@ -64,7 +64,7 @@ test_expect_success 'validate output from rename/copy detection (#2)' '
 # nows how to say Copy.
 
 test_expect_success 'validate output from rename/copy detection (#3)' '
-	cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
+	cat "$TEST_DIRECTORY"/lib-diff/COPYING >COPYING &&
 	git update-index --add --remove COPYING COPYING.1 &&
 
 	cat <<-EOF >expected &&
diff --git a/t/t4007-rename-3.sh b/t/t4007-rename-3.sh
index b187b7f6c66..cbb9c62f535 100755
--- a/t/t4007-rename-3.sh
+++ b/t/t4007-rename-3.sh
@@ -7,17 +7,17 @@ test_description='Rename interaction with pathspec.
 
 '
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/diff-lib.sh ;# test-lib chdir's into trash
+. "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
 test_expect_success 'prepare reference tree' '
 	mkdir path0 path1 &&
-	cp "$TEST_DIRECTORY"/diff-lib/COPYING path0/COPYING &&
+	cp "$TEST_DIRECTORY"/lib-diff/COPYING path0/COPYING &&
 	git update-index --add path0/COPYING &&
 	tree=$(git write-tree) &&
 	echo $tree
 '
 
-blob=$(git hash-object "$TEST_DIRECTORY/diff-lib/COPYING")
+blob=$(git hash-object "$TEST_DIRECTORY/lib-diff/COPYING")
 test_expect_success 'prepare work tree' '
 	cp path0/COPYING path1/COPYING &&
 	git update-index --add --remove path0/COPYING path1/COPYING
diff --git a/t/t4008-diff-break-rewrite.sh b/t/t4008-diff-break-rewrite.sh
index b1ccd4102e0..2299f27511b 100755
--- a/t/t4008-diff-break-rewrite.sh
+++ b/t/t4008-diff-break-rewrite.sh
@@ -22,11 +22,11 @@ With -B, this should be detected as two complete rewrites.
 Further, with -B and -M together, these should turn into two renames.
 '
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/diff-lib.sh ;# test-lib chdir's into trash
+. "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
 test_expect_success setup '
-	cat "$TEST_DIRECTORY"/diff-lib/README >file0 &&
-	cat "$TEST_DIRECTORY"/diff-lib/COPYING >file1 &&
+	cat "$TEST_DIRECTORY"/lib-diff/README >file0 &&
+	cat "$TEST_DIRECTORY"/lib-diff/COPYING >file1 &&
 	blob0_id=$(git hash-object file0) &&
 	blob1_id=$(git hash-object file1) &&
 	git update-index --add file0 file1 &&
diff --git a/t/t4009-diff-rename-4.sh b/t/t4009-diff-rename-4.sh
index b63bdf031f5..b1da807f169 100755
--- a/t/t4009-diff-rename-4.sh
+++ b/t/t4009-diff-rename-4.sh
@@ -7,11 +7,11 @@ test_description='Same rename detection as t4003 but testing diff-raw -z.
 
 '
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/diff-lib.sh ;# test-lib chdir's into trash
+. "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
 test_expect_success \
     'prepare reference tree' \
-    'cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
+    'cat "$TEST_DIRECTORY"/lib-diff/COPYING >COPYING &&
      echo frotz >rezrov &&
     git update-index --add COPYING rezrov &&
     orig=$(git hash-object COPYING) &&
@@ -81,7 +81,7 @@ test_expect_success \
 
 test_expect_success \
     'prepare work tree once again' \
-    'cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
+    'cat "$TEST_DIRECTORY"/lib-diff/COPYING >COPYING &&
      git update-index --add --remove COPYING COPYING.1'
 
 git diff-index -z -C --find-copies-harder $tree >current
diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index 65cc703c659..1bbced79ece 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -10,7 +10,7 @@ Prepare:
         path1/file1
 '
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/diff-lib.sh ;# test-lib chdir's into trash
+. "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
 test_expect_success \
     setup \
diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index 717034bb50b..5a25c259fe3 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -7,7 +7,7 @@ test_description='Test diff of symlinks.
 
 '
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/diff-lib.sh
+. "$TEST_DIRECTORY"/lib-diff.sh
 
 # Print the short OID of a symlink with the given name.
 symlink_oid () {
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index ce6aa3914fe..fcc30d8cc26 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -9,7 +9,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/diff-lib.sh
+. "$TEST_DIRECTORY"/lib-diff.sh
 
 test_expect_success setup '
 
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 8c574221b27..2c13b62d3c6 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -7,7 +7,7 @@ test_description='Test special whitespace in diff engine.
 
 '
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/diff-lib.sh
+. "$TEST_DIRECTORY"/lib-diff.sh
 
 test_expect_success "Ray Lehtiniemi's example" '
 	cat <<-\EOF >x &&
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 894a11b224d..94ef77e1dfe 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -3,7 +3,7 @@
 test_description='difference in submodules'
 
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/diff-lib.sh
+. "$TEST_DIRECTORY"/lib-diff.sh
 
 test_expect_success setup '
 	test_tick &&
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 0c8fb39ceda..56f1e62a97b 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -3,7 +3,7 @@
 test_description='word diff colors'
 
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/diff-lib.sh
+. "$TEST_DIRECTORY"/lib-diff.sh
 
 cat >pre.simple <<-\EOF
 	h(4)
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index 09ad491a593..aeac203c424 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -6,7 +6,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/diff-lib.sh
+. "$TEST_DIRECTORY"/lib-diff.sh
 
 setup_helper () {
 	one=$1 branch=$2 side=$3 &&
diff --git a/t/t4061-diff-indent.sh b/t/t4061-diff-indent.sh
index bcf7493740a..7750b87ca16 100755
--- a/t/t4061-diff-indent.sh
+++ b/t/t4061-diff-indent.sh
@@ -7,7 +7,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/diff-lib.sh
+. "$TEST_DIRECTORY"/lib-diff.sh
 
 # Compare two diff outputs. Ignore "index" lines, because we don't
 # care about SHA-1s or file modes.
diff --git a/t/t4206-log-follow-harder-copies.sh b/t/t4206-log-follow-harder-copies.sh
index ad29e65fcba..4871a5dc92f 100755
--- a/t/t4206-log-follow-harder-copies.sh
+++ b/t/t4206-log-follow-harder-copies.sh
@@ -7,7 +7,7 @@ test_description='Test --follow should always find copies hard in git log.
 
 '
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/diff-lib.sh
+. "$TEST_DIRECTORY"/lib-diff.sh
 
 echo >path0 'Line 1
 Line 2
diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index 0f936182e4f..512ae2781fe 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -11,7 +11,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
-. "$TEST_DIRECTORY/diff-lib.sh"
+. "$TEST_DIRECTORY/lib-diff.sh"
 
 author='The Real Author <someguy@his.email.org>'
 
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 3d17e932a0e..3d77701fd4d 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -8,7 +8,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/diff-lib.sh ;# test-lib chdir's into trash
+. "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
 verify_packs () {
 	for p in .git/objects/pack/*.pack
-- 
2.30.0.284.gd98b1dd5eaa7

