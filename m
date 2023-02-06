Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D6BC6379F
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 19:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjBFTIw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 14:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjBFTIv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 14:08:51 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BBA2B094
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 11:08:48 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so9665107wms.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 11:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6vR8GQ5rIUq8qqaqjfGnPRemR6Wta1o/HTk6vZIu1w=;
        b=J+hgsNXiRw0kUKuRL8Rwb0QClAvSS0cZiO2wCmbGYMlOwBgtpSNyz5PnehgDeRNuST
         T3okxcKY7IkEfloI1frzzzuxT6Y6ugi2M5rLAh4R4LHPmwkL5LEuASJArlo5qKQSJ6vX
         1mHhov+wLC3rQQRdmi1vnvmQMI1hK6gW5n7W/ivXiWwR1L0zca8Ef57UjKVFJ5W+mPre
         fGBsKPwxufJgvH/LawHaGhSwHIbVlMFGTeAriIpxrP+J279klOe8HM6hg1vvAJr/4H75
         Gip2uTTiXHxpxdl/xYy3VZ3I9AsVYU8oND2nsx3ewR8tKrPGjEMkfc3MZIoNdVjc5Jzr
         NXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6vR8GQ5rIUq8qqaqjfGnPRemR6Wta1o/HTk6vZIu1w=;
        b=HZqP/YjD8mS1Wisz5RycXDadguzNGzb5QD4h3GOU05wF4pkp433LmpJ7npNDotuhZU
         ji2wW4RhMoav10+WIkkDjdPzaVV5S4ZFBQkEtB1B+p/UhVRWwGkWw4zK/1e5pX7NEC26
         ZjhviyTlpghcOtEK4w8S5AHAq0tRR3QpL7D71DjkvHleQVR2EsLww7zpSVDYKSvakTdk
         23YCCF9xMJ2iLDYYQ0JHHroqjtLyPfbH4QT2TDnvnYzRoSLrw/ey1mQoP1FyeJoR8SqD
         B3gxNK8t0XQ6hI/pbkULIoqDFuO9fO5fVLaSc1xJIJtKQv/B8XBsIlZ2oNoniPfy1g4t
         go7A==
X-Gm-Message-State: AO0yUKVhMtGY3QrYSyzRWirlSzgdtX4V+8ZFn42+lrc06Uml3jLmAcb6
        uRp+qoHSDMdbOHSaHCAM/KTPEZwMjlKTIXok
X-Google-Smtp-Source: AK7set8NznXugpbZIw1//9OuEqlfohFItx9MuJMpUBNebPjGh0uWmUzv2ZI/efWAPif8VN7JIKwxEA==
X-Received: by 2002:a05:600c:330f:b0:3e0:634:ff1b with SMTP id q15-20020a05600c330f00b003e00634ff1bmr764398wmp.4.1675710526887;
        Mon, 06 Feb 2023 11:08:46 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p2-20020a05600c358200b003dc4ecfc4d7sm12538595wmq.29.2023.02.06.11.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 11:08:46 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/8] sequencer API users: fix get_replay_opts() leaks
Date:   Mon,  6 Feb 2023 20:08:08 +0100
Message-Id: <patch-v4-3.8-dbac0501424-20230206T190346Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.ge02fe682bd8
In-Reply-To: <cover-v4-0.8-00000000000-20230206T190346Z-avarab@gmail.com>
References: <patch-v3-7.8-ee8262ab22a-20230118T160600Z-avarab@gmail.com> <cover-v4-0.8-00000000000-20230206T190346Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the replay_opts_release() function added in the preceding commit
non-static, and use it for freeing the "struct replay_opts"
constructed for "rebase" and "revert".

To safely call our new replay_opts_release() we'll need to stop
calling it in sequencer_remove_state(), and instead call it where we
allocate the "struct replay_opts" itself.

This is because in e.g. do_interactive_rebase() we construct a "struct
replay_opts" with "get_replay_opts()", and then call
"complete_action()". If we get far enough in that function without
encountering errors we'll call "pick_commits()" which (indirectly)
calls sequencer_remove_state() at the end.

But if we encounter errors anywhere along the way we'd punt out early,
and not free() the memory we allocated. Remembering whether we
previously called sequencer_remove_state() would be a hassle.

Using a FREE_AND_NULL() pattern would also work, as it would be safe
to call replay_opts_release() repeatedly. But let's fix this properly
instead, by having the owner of the data free() it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c                       | 4 ++++
 builtin/revert.c                       | 2 ++
 sequencer.c                            | 4 +---
 sequencer.h                            | 1 +
 t/t3405-rebase-malformed.sh            | 1 +
 t/t3412-rebase-root.sh                 | 1 +
 t/t3419-rebase-patch-id.sh             | 1 +
 t/t3423-rebase-reword.sh               | 1 +
 t/t3425-rebase-topology-merges.sh      | 2 ++
 t/t3437-rebase-fixup-options.sh        | 1 +
 t/t3438-rebase-broken-files.sh         | 2 ++
 t/t3501-revert-cherry-pick.sh          | 1 +
 t/t3502-cherry-pick-merge.sh           | 1 +
 t/t3503-cherry-pick-root.sh            | 1 +
 t/t3506-cherry-pick-ff.sh              | 1 +
 t/t3511-cherry-pick-x.sh               | 1 +
 t/t7402-submodule-rebase.sh            | 1 +
 t/t9106-git-svn-commit-diff-clobber.sh | 1 -
 t/t9164-git-svn-dcommit-concurrent.sh  | 1 -
 19 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index c97ce642cf3..2ec3ae0b42e 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -297,6 +297,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 	}
 
 cleanup:
+	replay_opts_release(&replay);
 	free(revisions);
 	free(shortrevisions);
 	todo_list_release(&todo_list);
@@ -338,6 +339,7 @@ static int run_sequencer_rebase(struct rebase_options *opts)
 		struct replay_opts replay_opts = get_replay_opts(opts);
 
 		ret = sequencer_continue(the_repository, &replay_opts);
+		replay_opts_release(&replay_opts);
 		break;
 	}
 	case ACTION_EDIT_TODO:
@@ -553,6 +555,7 @@ static int finish_rebase(struct rebase_options *opts)
 
 		replay.action = REPLAY_INTERACTIVE_REBASE;
 		ret = sequencer_remove_state(&replay);
+		replay_opts_release(&replay);
 	} else {
 		strbuf_addstr(&dir, opts->state_dir);
 		if (remove_dir_recursively(&dir, 0))
@@ -1324,6 +1327,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 			replay.action = REPLAY_INTERACTIVE_REBASE;
 			ret = sequencer_remove_state(&replay);
+			replay_opts_release(&replay);
 		} else {
 			strbuf_reset(&buf);
 			strbuf_addstr(&buf, options.state_dir);
diff --git a/builtin/revert.c b/builtin/revert.c
index f2d86d2a8f9..1cab16bf3ed 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -251,6 +251,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	if (opts.revs)
 		release_revisions(opts.revs);
 	free(opts.revs);
+	replay_opts_release(&opts);
 	return res;
 }
 
@@ -267,5 +268,6 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	free(opts.revs);
 	if (res < 0)
 		die(_("cherry-pick failed"));
+	replay_opts_release(&opts);
 	return res;
 }
diff --git a/sequencer.c b/sequencer.c
index b6392b43204..1547fb98597 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -351,7 +351,7 @@ static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
 	return buf.buf;
 }
 
-static void replay_opts_release(struct replay_opts *opts)
+void replay_opts_release(struct replay_opts *opts)
 {
 	free(opts->gpg_sign);
 	free(opts->reflog_action);
@@ -385,8 +385,6 @@ int sequencer_remove_state(struct replay_opts *opts)
 		}
 	}
 
-	replay_opts_release(opts);
-
 	strbuf_reset(&buf);
 	strbuf_addstr(&buf, get_dir(opts));
 	if (remove_dir_recursively(&buf, 0))
diff --git a/sequencer.h b/sequencer.h
index 888c18aad71..3bcdfa1b586 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -158,6 +158,7 @@ int sequencer_pick_revisions(struct repository *repo,
 int sequencer_continue(struct repository *repo, struct replay_opts *opts);
 int sequencer_rollback(struct repository *repo, struct replay_opts *opts);
 int sequencer_skip(struct repository *repo, struct replay_opts *opts);
+void replay_opts_release(struct replay_opts *opts);
 int sequencer_remove_state(struct replay_opts *opts);
 
 #define TODO_LIST_KEEP_EMPTY (1U << 0)
diff --git a/t/t3405-rebase-malformed.sh b/t/t3405-rebase-malformed.sh
index 25243318618..8979bc34073 100755
--- a/t/t3405-rebase-malformed.sh
+++ b/t/t3405-rebase-malformed.sh
@@ -5,6 +5,7 @@ test_description='rebase should handle arbitrary git message'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index 58371d8a547..e75b3d0e07c 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -7,6 +7,7 @@ Tests if git rebase --root --onto <newparent> can rebase the root commit.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 log_with_names () {
diff --git a/t/t3419-rebase-patch-id.sh b/t/t3419-rebase-patch-id.sh
index 7181f176b81..6c61f240cf9 100755
--- a/t/t3419-rebase-patch-id.sh
+++ b/t/t3419-rebase-patch-id.sh
@@ -5,6 +5,7 @@ test_description='git rebase - test patch id computation'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 scramble () {
diff --git a/t/t3423-rebase-reword.sh b/t/t3423-rebase-reword.sh
index 4859bb8f722..2fab703d615 100755
--- a/t/t3423-rebase-reword.sh
+++ b/t/t3423-rebase-reword.sh
@@ -2,6 +2,7 @@
 
 test_description='git rebase interactive with rewording'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t3425-rebase-topology-merges.sh b/t/t3425-rebase-topology-merges.sh
index 63acc1ea4da..a16428bdf54 100755
--- a/t/t3425-rebase-topology-merges.sh
+++ b/t/t3425-rebase-topology-merges.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='rebase topology tests with merges'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index c023fefd681..274699dadb8 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -14,6 +14,7 @@ to the "fixup" command that works with "fixup!", "fixup -C" works with
 "amend!" upon --autosquash.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t3438-rebase-broken-files.sh b/t/t3438-rebase-broken-files.sh
index b92a3ce46b8..c614c4f2e4b 100755
--- a/t/t3438-rebase-broken-files.sh
+++ b/t/t3438-rebase-broken-files.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='rebase behavior when on-disk files are broken'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up conflicting branches' '
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 1f4cfc37449..2f3e3e24169 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -13,6 +13,7 @@ test_description='test cherry-pick and revert with renames
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3502-cherry-pick-merge.sh b/t/t3502-cherry-pick-merge.sh
index 5495eacfec1..1b2c0d6aca6 100755
--- a/t/t3502-cherry-pick-merge.sh
+++ b/t/t3502-cherry-pick-merge.sh
@@ -11,6 +11,7 @@ test_description='cherry picking and reverting a merge
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3503-cherry-pick-root.sh b/t/t3503-cherry-pick-root.sh
index 95fe4feaeee..76d393dc8a3 100755
--- a/t/t3503-cherry-pick-root.sh
+++ b/t/t3503-cherry-pick-root.sh
@@ -5,6 +5,7 @@ test_description='test cherry-picking (and reverting) a root commit'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3506-cherry-pick-ff.sh b/t/t3506-cherry-pick-ff.sh
index 7e11bd4a4c5..b71bad17b85 100755
--- a/t/t3506-cherry-pick-ff.sh
+++ b/t/t3506-cherry-pick-ff.sh
@@ -5,6 +5,7 @@ test_description='test cherry-picking with --ff option'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
index 84a587daf3a..dd5d92ef302 100755
--- a/t/t3511-cherry-pick-x.sh
+++ b/t/t3511-cherry-pick-x.sh
@@ -2,6 +2,7 @@
 
 test_description='Test cherry-pick -x and -s'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 pristine_detach () {
diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
index ebeca12a711..b19792b3269 100755
--- a/t/t7402-submodule-rebase.sh
+++ b/t/t7402-submodule-rebase.sh
@@ -5,6 +5,7 @@
 
 test_description='Test rebasing, stashing, etc. with submodules'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
index 3cab0b9720a..bca496c40e0 100755
--- a/t/t9106-git-svn-commit-diff-clobber.sh
+++ b/t/t9106-git-svn-commit-diff-clobber.sh
@@ -3,7 +3,6 @@
 # Copyright (c) 2006 Eric Wong
 test_description='git svn commit-diff clobber'
 
-TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'initialize repo' '
diff --git a/t/t9164-git-svn-dcommit-concurrent.sh b/t/t9164-git-svn-dcommit-concurrent.sh
index 1465156072e..c8e6c0733f4 100755
--- a/t/t9164-git-svn-dcommit-concurrent.sh
+++ b/t/t9164-git-svn-dcommit-concurrent.sh
@@ -5,7 +5,6 @@
 
 test_description='concurrent git svn dcommit'
 
-TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 
-- 
2.39.1.1425.ge02fe682bd8

