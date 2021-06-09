Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61D2C48BCF
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 19:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9B86613FE
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 19:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhFITbC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 15:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhFITbC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 15:31:02 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2059DC06175F
        for <git@vger.kernel.org>; Wed,  9 Jun 2021 12:29:07 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id l15-20020a05683016cfb02903fca0eacd15so1168468otr.7
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 12:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HZm2M7K1HVTYuM7R6FtXmJPCbIRnDeK1ZUMAVnj+u04=;
        b=LJGZ6gagnJU6dvKBXkiWlKr6GgfRG3Wg08JFy5C8avMjAGx4tVQMiJW3cY327iGBoi
         5YvmacxknV54b3k1vUHgJAZGYH35QDxXtZE/Xgbsc/E/u2iG7mCtBkiXxt3z+GP4G9cU
         251dit5qO6uC8XGIyuC7oI9Cq97rnsvncroFz/EJVtcz76ks6d7gwvXUmxZiC8iEcY7z
         Hj/NaxvONZoHWuk/7x9cMo/aSt3RWmxlRqZ3TlCNuI63GTPF2DyTz7T8U4PRK87M9+KL
         Yb6bXN+mBP8arOa7l1MQPIPTM+LwGyI9sKwxVvOro5e3JVOsqxVMEzBomtQYH+Tkr2cz
         kkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HZm2M7K1HVTYuM7R6FtXmJPCbIRnDeK1ZUMAVnj+u04=;
        b=OOpCuG6cFzUut3KOPkP2+mcYiqExKozJJ73PUcvaOIWaPTGIixWnOY5XT+3D30CsHE
         AqlpbqyqLASgOrUsUx1oumpvl3tRGRz4sutZ6req9smicEFiDbKntwxeZUSn8W+BSFPz
         ikmqoddue5hwG3OOxCr4gWwEUVfGDHFj7oYMgGPxvr3gr+JRgpCXW9djWYkTyLC3m6A5
         a1DhpaqWsF+XFGp6nd7hTIr/adR2HGvZb9pMMMLdG24yjwGpjXOIJbB2Sv1IEYR9zI59
         DnQzu2zvhXhn4i56V4xz2H80cEr04d5AMQ97XCBzcX8xkz8qmf7yQ2WGrH98gCbhxLvZ
         I4PA==
X-Gm-Message-State: AOAM530nHxC/Ik/6X7sTr4xN2QDJ5r0db+YYkpEc6QB64FopprpheHsW
        U+/DjWxHvd0aw5NYINhe1Biz39R2uyi0LA==
X-Google-Smtp-Source: ABdhPJxtFry0uzdhQpkf0HegrDDJrkSUxWl4H/ANQqtYarLX73NXfAiB2QJ6T2tIV52tAem4xZZGDw==
X-Received: by 2002:a9d:206:: with SMTP id 6mr873462otb.31.1623266945998;
        Wed, 09 Jun 2021 12:29:05 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id w13sm175809otp.10.2021.06.09.12.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 12:29:05 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
Date:   Wed,  9 Jun 2021 14:28:42 -0500
Message-Id: <20210609192842.696646-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.2.g41be0a4e50
In-Reply-To: <20210609192842.696646-1-felipe.contreras@gmail.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Virtually everyone is using it, and it's one of the first things we
teach newcomers in order to resolve conflicts efficiently.

Let's make it the default.

This generates a ton of changes in the tests. Although we probably will
want to update them to use th new default, override the configuration so
we use the old one for now.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config/merge.txt           | 12 +++++-----
 Documentation/git-merge-file.txt         |  2 ++
 Documentation/git-merge.txt              | 28 +++++++-----------------
 Documentation/git-rerere.txt             |  2 +-
 Documentation/gitattributes.txt          |  6 ++---
 Documentation/technical/rerere.txt       |  3 +--
 Documentation/user-manual.txt            |  6 ++++-
 t/t2023-checkout-m.sh                    |  2 ++
 t/t3310-notes-merge-manual-resolve.sh    |  2 ++
 t/t3311-notes-merge-fanout.sh            |  2 ++
 t/t3404-rebase-interactive.sh            |  2 ++
 t/t3507-cherry-pick-conflict.sh          |  2 ++
 t/t4017-diff-retval.sh                   |  2 ++
 t/t4048-diff-combined-binary.sh          |  2 ++
 t/t4200-rerere.sh                        |  2 ++
 t/t4300-merge-tree.sh                    |  2 ++
 t/t6402-merge-rename.sh                  |  2 ++
 t/t6403-merge-file.sh                    |  2 ++
 t/t6404-recursive-merge.sh               |  2 ++
 t/t6416-recursive-corner-cases.sh        |  2 ++
 t/t6417-merge-ours-theirs.sh             |  2 ++
 t/t6418-merge-text-auto.sh               |  2 ++
 t/t6422-merge-rename-corner-cases.sh     |  2 ++
 t/t6423-merge-rename-directories.sh      |  1 +
 t/t6428-merge-conflicts-sparse.sh        |  1 +
 t/t6432-merge-recursive-space-options.sh |  2 ++
 t/t6440-config-conflict-markers.sh       |  8 +++----
 t/t7201-co.sh                            |  2 ++
 t/t7506-status-submodule.sh              |  1 +
 xdiff-interface.c                        |  2 +-
 30 files changed, 70 insertions(+), 38 deletions(-)

diff --git a/Documentation/config/merge.txt b/Documentation/config/merge.txt
index cb2ed58907..2dba937dd0 100644
--- a/Documentation/config/merge.txt
+++ b/Documentation/config/merge.txt
@@ -1,10 +1,10 @@
 merge.conflictStyle::
-	Specify the style in which conflicted hunks are written out to
-	working tree files upon merge.  The default is "merge", which
-	shows a `<<<<<<<` conflict marker, changes made by one side,
-	a `=======` marker, changes made by the other side, and then
-	a `>>>>>>>` marker.  An alternate style, "diff3", adds a `|||||||`
-	marker and the original text before the `=======` marker.
+	Specify the style in which conflicted hunks are written out to working
+	tree files upon merge. The default is "diff3", which shows a `<<<<<<<`
+	conflict marker, changes made by one side, a `|||||||` marker, the
+	original text, a `=======` marker, changes made by the other side, and
+	then a `>>>>>>>` marker. A simpler mode "merge" omits the `|||||||`
+	marker and the original text.
 
 merge.defaultToUpstream::
 	If merge is called without any commit argument, merge the upstream
diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
index f856032613..7d8e74c872 100644
--- a/Documentation/git-merge-file.txt
+++ b/Documentation/git-merge-file.txt
@@ -30,6 +30,8 @@ normally outputs a warning and brackets the conflict with lines containing
 
 	<<<<<<< A
 	lines in file A
+	|||||||
+	lines in merge base
 	=======
 	lines in file B
 	>>>>>>> B
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 3819fadac1..14dadf2e16 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -233,7 +233,7 @@ final result verbatim.  When both sides made changes to the same area,
 however, Git cannot randomly pick one side over the other, and asks you to
 resolve it by leaving what both sides did to that area.
 
-By default, Git uses the same style as the one used by the "merge" program
+By default, Git uses a similar style to the one used by the "merge" program
 from the RCS suite to present such a conflicted hunk, like this:
 
 ------------
@@ -242,6 +242,8 @@ ancestor, or cleanly resolved because only one side changed.
 <<<<<<< yours:sample.txt
 Conflict resolution is hard;
 let's go shopping.
+|||||||
+Originally there's no conflict.
 =======
 Git makes conflict resolution easy.
 >>>>>>> theirs:sample.txt
@@ -249,17 +251,12 @@ And here is another line that is cleanly resolved or unmodified.
 ------------
 
 The area where a pair of conflicting changes happened is marked with markers
-`<<<<<<<`, `=======`, and `>>>>>>>`.  The part before the `=======`
-is typically your side, and the part afterwards is typically their side.
-
-The default format does not show what the original said in the conflicting
-area.  You cannot tell how many lines are deleted and replaced with
-Barbie's remark on your side.  The only thing you can tell is that your
-side wants to say it is hard and you'd prefer to go shopping, while the
-other side wants to claim it is easy.
+`<<<<<<<`, `=======`, and `>>>>>>>`.  The part before the `|||||||`
+is typically your side, and the part after `=======` is typically their side.
+In-between is the original code.
 
-An alternative style can be used by setting the "merge.conflictStyle"
-configuration variable to "diff3".  In "diff3" style, the above conflict
+An more basic style can be used by setting the "merge.conflictStyle"
+configuration variable to "merge".  In "merge" style, the above conflict
 may look like this:
 
 ------------
@@ -268,21 +265,12 @@ ancestor, or cleanly resolved because only one side changed.
 <<<<<<< yours:sample.txt
 Conflict resolution is hard;
 let's go shopping.
-|||||||
-Conflict resolution is hard.
 =======
 Git makes conflict resolution easy.
 >>>>>>> theirs:sample.txt
 And here is another line that is cleanly resolved or unmodified.
 ------------
 
-In addition to the `<<<<<<<`, `=======`, and `>>>>>>>` markers, it uses
-another `|||||||` marker that is followed by the original text.  You can
-tell that the original just stated a fact, and your side simply gave in to
-that statement and gave up, while the other side tried to have a more
-positive attitude.  You can sometimes come up with a better resolution by
-viewing the original.
-
 
 HOW TO RESOLVE CONFLICTS
 ------------------------
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index 4cfc883378..89b0820995 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -159,7 +159,7 @@ resolve.
 
 Running the 'git rerere' command immediately after a conflicted
 automerge records the conflicted working tree files, with the
-usual conflict markers `<<<<<<<`, `=======`, and `>>>>>>>` in
+usual conflict markers `<<<<<<<`, `|||||||`, `=======`, and `>>>>>>>` in
 them.  Later, after you are done resolving the conflicts,
 running 'git rerere' again will record the resolved state of these
 files.  Suppose you did this when you created the test merge of
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 83fd4e19a4..b767215ac2 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -1042,10 +1042,10 @@ text::
 
 	Usual 3-way file level merge for text files.  Conflicted
 	regions are marked with conflict markers `<<<<<<<`,
-	`=======` and `>>>>>>>`.  The version from your branch
-	appears before the `=======` marker, and the version
+	`|||||||`, `=======` and `>>>>>>>`.  The version from your branch
+	appears before the `|||||||` marker, and the version
 	from the merged branch appears after the `=======`
-	marker.
+	marker. In-between is the original.
 
 binary::
 
diff --git a/Documentation/technical/rerere.txt b/Documentation/technical/rerere.txt
index af5f9fc24f..38b44f4430 100644
--- a/Documentation/technical/rerere.txt
+++ b/Documentation/technical/rerere.txt
@@ -42,8 +42,7 @@ get a conflict like the following:
     >>>>>>> AC
 
 Doing the analogous with AC2 (forking a branch ABAC2 off of branch AB
-and then merging branch AC2 into it), using the diff3 conflict style,
-we get a conflict like the following:
+and then merging branch AC2 into it), we get a conflict like the following:
 
     <<<<<<< HEAD
     B
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index f9e54b8674..3ddde87482 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1243,6 +1243,8 @@ files with conflicts will have conflict markers added, like this:
 -------------------------------------------------
 <<<<<<< HEAD:file.txt
 Hello world
+|||||||
+Original
 =======
 Goodbye
 >>>>>>> 77976da35a11db4580b80ae27e8d65caf5208086:file.txt
@@ -1276,9 +1278,11 @@ diff --cc file.txt
 index 802992c,2b60207..0000000
 --- a/file.txt
 +++ b/file.txt
-@@@ -1,1 -1,1 +1,5 @@@
+@@@ -1,1 -1,1 +1,7 @@@
 ++<<<<<<< HEAD:file.txt
  +Hello world
+++|||||||
+++Original
 ++=======
 + Goodbye
 ++>>>>>>> 77976da35a11db4580b80ae27e8d65caf5208086:file.txt
diff --git a/t/t2023-checkout-m.sh b/t/t2023-checkout-m.sh
index 7b327b7544..219c82532a 100755
--- a/t/t2023-checkout-m.sh
+++ b/t/t2023-checkout-m.sh
@@ -9,6 +9,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+git config merge.conflictstyle merge # TODO: use the default
+
 test_expect_success setup '
 	test_tick &&
 	test_commit both.txt both.txt initial &&
diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index d3d72e25fe..cbd5d8302e 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -7,6 +7,8 @@ test_description='Test notes merging with manual conflict resolution'
 
 . ./test-lib.sh
 
+git config --global merge.conflictstyle merge # TODO: use the default
+
 # Set up a notes merge scenario with different kinds of conflicts
 test_expect_success 'setup commits' '
 	test_commit 1st &&
diff --git a/t/t3311-notes-merge-fanout.sh b/t/t3311-notes-merge-fanout.sh
index 5b675417e9..4aeaa05c15 100755
--- a/t/t3311-notes-merge-fanout.sh
+++ b/t/t3311-notes-merge-fanout.sh
@@ -7,6 +7,8 @@ test_description='Test notes merging at various fanout levels'
 
 . ./test-lib.sh
 
+git config merge.conflictstyle merge # TODO: use the default
+
 verify_notes () {
 	notes_ref="$1"
 	commit="$2"
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 66bcbbf952..769079a71c 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -32,6 +32,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
+git config merge.conflictstyle merge # TODO: use the default
+
 test_expect_success 'setup' '
 	git switch -C primary &&
 	test_commit A file1 &&
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 014001b8f3..647a40f314 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -281,6 +281,7 @@ test_expect_success \
 
 test_expect_success 'failed cherry-pick describes conflict in work tree' '
 	pristine_detach initial &&
+	git config merge.conflictstyle merge && # TODO: use the default
 	cat <<-EOF >expected &&
 	<<<<<<< HEAD
 	a
@@ -316,6 +317,7 @@ test_expect_success 'diff3 -m style' '
 
 test_expect_success 'revert also handles conflicts sanely' '
 	git config --unset merge.conflictstyle &&
+	git config merge.conflictstyle merge && # TODO: use the default
 	pristine_detach initial &&
 	cat <<-EOF >expected &&
 	<<<<<<< HEAD
diff --git a/t/t4017-diff-retval.sh b/t/t4017-diff-retval.sh
index ed461f481e..04b77af2a4 100755
--- a/t/t4017-diff-retval.sh
+++ b/t/t4017-diff-retval.sh
@@ -7,6 +7,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+git config merge.conflictstyle merge # TODO: use the default
+
 test_expect_success 'setup' '
 	echo "1 " >a &&
 	git add . &&
diff --git a/t/t4048-diff-combined-binary.sh b/t/t4048-diff-combined-binary.sh
index 0260cf64f5..49a56731dd 100755
--- a/t/t4048-diff-combined-binary.sh
+++ b/t/t4048-diff-combined-binary.sh
@@ -6,6 +6,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+git config merge.conflictstyle merge # TODO: use the default
+
 test_expect_success 'setup binary merge conflict' '
 	echo oneQ1 | q_to_nul >binary &&
 	git add binary &&
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 9f8c76dffb..e9ae3d6fde 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -27,6 +27,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+git config merge.conflictstyle merge # TODO: use the default
+
 test_expect_success 'setup' '
 	cat >a1 <<-\EOF &&
 	Some title
diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
index e59601e5fe..f21ccaf0a6 100755
--- a/t/t4300-merge-tree.sh
+++ b/t/t4300-merge-tree.sh
@@ -6,6 +6,8 @@
 test_description='git merge-tree'
 . ./test-lib.sh
 
+git config merge.conflictstyle merge # TODO: use the default
+
 test_expect_success setup '
 	test_commit "initial" "initial-file" "initial"
 '
diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
index 425dad97d5..4f01bbc451 100755
--- a/t/t6402-merge-rename.sh
+++ b/t/t6402-merge-rename.sh
@@ -270,6 +270,7 @@ test_expect_success 'setup for rename + d/f conflicts' '
 	git checkout --orphan dir-in-way &&
 	git rm -rf . &&
 	git clean -fdqx &&
+	git config merge.conflictstyle merge && # TODO: use the default
 
 	mkdir sub &&
 	mkdir dir &&
@@ -871,6 +872,7 @@ test_expect_success 'setup for use of extended merge markers' '
 	git clean -fdqx &&
 	rm -rf .git &&
 	git init &&
+	git config merge.conflictstyle merge && # TODO: use the default
 
 	printf "1\n2\n3\n4\n5\n6\n7\n8\n" >original_file &&
 	git add original_file &&
diff --git a/t/t6403-merge-file.sh b/t/t6403-merge-file.sh
index 2f421d967a..1428dfb5c6 100755
--- a/t/t6403-merge-file.sh
+++ b/t/t6403-merge-file.sh
@@ -3,6 +3,8 @@
 test_description='RCS merge replacement: merge-file'
 . ./test-lib.sh
 
+git config merge.conflictstyle merge # TODO: use the default
+
 test_expect_success 'setup' '
 	cat >orig.txt <<-\EOF &&
 	Dominus regit me,
diff --git a/t/t6404-recursive-merge.sh b/t/t6404-recursive-merge.sh
index eaf48e941e..a3354b8f9a 100755
--- a/t/t6404-recursive-merge.sh
+++ b/t/t6404-recursive-merge.sh
@@ -6,6 +6,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+git config merge.conflictstyle merge # TODO: use the default
+
 # This scenario is based on a real-world repository of Shawn Pearce.
 
 # 1 - A - D - F
diff --git a/t/t6416-recursive-corner-cases.sh b/t/t6416-recursive-corner-cases.sh
index 84f5082366..ac4e69a325 100755
--- a/t/t6416-recursive-corner-cases.sh
+++ b/t/t6416-recursive-corner-cases.sh
@@ -8,6 +8,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
+git config --global merge.conflictstyle merge # TODO: use the default
+
 #
 #  L1  L2
 #   o---o
diff --git a/t/t6417-merge-ours-theirs.sh b/t/t6417-merge-ours-theirs.sh
index ac9aee9a66..b8208a383b 100755
--- a/t/t6417-merge-ours-theirs.sh
+++ b/t/t6417-merge-ours-theirs.sh
@@ -6,6 +6,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+git config merge.conflictstyle merge # TODO: use the default
+
 test_expect_success setup '
 	for i in 1 2 3 4 5 6 7 8 9
 	do
diff --git a/t/t6418-merge-text-auto.sh b/t/t6418-merge-text-auto.sh
index 1e0296dd17..e18f67776c 100755
--- a/t/t6418-merge-text-auto.sh
+++ b/t/t6418-merge-text-auto.sh
@@ -17,6 +17,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+git config merge.conflictstyle merge # TODO: use the default
+
 test_have_prereq SED_STRIPS_CR && SED_OPTIONS=-b
 
 compare_files () {
diff --git a/t/t6422-merge-rename-corner-cases.sh b/t/t6422-merge-rename-corner-cases.sh
index bf4ce3c63d..6bb4b6d968 100755
--- a/t/t6422-merge-rename-corner-cases.sh
+++ b/t/t6422-merge-rename-corner-cases.sh
@@ -9,6 +9,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
+git config --global merge.conflictstyle merge # TODO: use the default
+
 test_setup_rename_delete_untracked () {
 	test_create_repo rename-delete-untracked &&
 	(
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 7134769149..5f6cacd064 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -28,6 +28,7 @@ test_description="recursive merge with directory renames"
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
+git config --global merge.conflictstyle merge # TODO: use the default
 
 ###########################################################################
 # SECTION 1: Basic cases we should be able to handle
diff --git a/t/t6428-merge-conflicts-sparse.sh b/t/t6428-merge-conflicts-sparse.sh
index 7e8bf497f8..18975801db 100755
--- a/t/t6428-merge-conflicts-sparse.sh
+++ b/t/t6428-merge-conflicts-sparse.sh
@@ -25,6 +25,7 @@ test_description="merge cases"
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
+git config --global merge.conflictstyle merge # TODO: use the default
 
 # Testcase basic, conflicting changes in 'numerals'
 
diff --git a/t/t6432-merge-recursive-space-options.sh b/t/t6432-merge-recursive-space-options.sh
index db4b77e63d..5cfe8a4fbd 100755
--- a/t/t6432-merge-recursive-space-options.sh
+++ b/t/t6432-merge-recursive-space-options.sh
@@ -16,6 +16,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+git config merge.conflictstyle merge # TODO: use the default
+
 test_have_prereq SED_STRIPS_CR && SED_OPTIONS=-b
 if test_have_prereq GREP_STRIPS_CR
 then
diff --git a/t/t6440-config-conflict-markers.sh b/t/t6440-config-conflict-markers.sh
index 485ad0eee0..ae0bab37ad 100755
--- a/t/t6440-config-conflict-markers.sh
+++ b/t/t6440-config-conflict-markers.sh
@@ -29,7 +29,7 @@ test_expect_success 'merge' '
 		git commit -a -m left &&
 
 		test_must_fail git merge r &&
-		! grep -E "\|+" content &&
+		grep -E "\|+" content &&
 
 		git reset --hard &&
 		test_must_fail git -c merge.conflictstyle=diff3 merge r &&
@@ -52,7 +52,7 @@ test_expect_success 'merge-tree' '
 		test_commit l content l &&
 
 		git merge-tree initial r l >actual &&
-		! grep -E "\|+" actual &&
+		grep -E "\|+" actual &&
 
 		git -c merge.conflictstyle=diff3 merge-tree initial r l >actual &&
 		grep -E "\|+" actual &&
@@ -77,7 +77,7 @@ test_expect_success 'notes' '
 		git notes add -f -m l initial &&
 
 		test_must_fail git notes merge r &&
-		! grep -E "\|+" .git/NOTES_MERGE_WORKTREE/* &&
+		grep -E "\|+" .git/NOTES_MERGE_WORKTREE/* &&
 
 		git notes merge --abort &&
 		test_must_fail git -c merge.conflictstyle=diff3 notes merge r &&
@@ -104,7 +104,7 @@ test_expect_success 'checkout' '
 
 		fill b d >content &&
 		git checkout --merge master &&
-		! grep -E "\|+" content &&
+		grep -E "\|+" content &&
 
 		git config merge.conflictstyle merge &&
 
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 7f6e23a4bb..11444d5360 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -25,6 +25,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+git config merge.conflictstyle merge # TODO: use the default
+
 test_tick
 
 fill () {
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index 3fcb44767f..90449e80c3 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -253,6 +253,7 @@ test_expect_success 'status with merge conflict in .gitmodules' '
 	test_create_repo_with_commit sub2 &&
 	(
 		cd super &&
+		git config merge.conflictstyle merge && # TODO: use the default
 		prev=$(git rev-parse HEAD) &&
 		git checkout -b add_sub1 &&
 		git submodule add ../sub1 &&
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 19a030fbe2..1447771724 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -299,7 +299,7 @@ int xdiff_compare_lines(const char *l1, long s1,
 	return xdl_recmatch(l1, s1, l2, s2, flags);
 }
 
-int git_xmerge_style = XDL_MERGE_STYLE_MERGE;
+int git_xmerge_style = XDL_MERGE_STYLE_DIFF3;
 
 int git_xmerge_config(const char *var, const char *value, void *cb)
 {
-- 
2.32.0.2.g41be0a4e50

