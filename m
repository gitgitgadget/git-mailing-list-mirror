Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158F4C54EBD
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 12:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjALMq2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 07:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjALMqN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 07:46:13 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE6C13E02
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:46:09 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id v6so1455836ejg.6
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcx3cjAGTOQrSwbZIv3mB8StURZGy/RmwM0Kb5HLt38=;
        b=afEv7eYcIQ3aMrZ+q+Z3UD0dd893r8nMArKzsh0KYtkjjHyVsQsa+kX0SNI5R6P08U
         rCDcr1edrTr1Mwje6sR9r5T+MtjNkytr3nUdQDAUgyAcpbad9wLhpUYzNhL8BsMBDY2/
         09yAbJCQ7YrsGnZ/VrQbOobZNlrlRB/uz6JJ+4aySVPuvfT9Z9V33hW39VTRM+NrX3xY
         UyTIdjicVGibmMtv1SjW6SEc5hupKwaj3FQdEBJivKe/nKAD+/NBz867PdUiTZg/t8Zv
         LjKPgI4+CbuHwRp7FpfIS5gDDikNIR0qpwdbxB8PuZwW77QvVfY8zZAY6QK7IYKBQiem
         llOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcx3cjAGTOQrSwbZIv3mB8StURZGy/RmwM0Kb5HLt38=;
        b=LWAjMYHbf0xHJcR3OxRFGgNev+tJ6KcvQLQeCcxp0moEtrq8xyqGdZFCPsM+iFlzTO
         zQ9gVxpGrgJWYv96E4AAYICByfQvKfLg8wxz4zsMQvgUgFk9JgNkPOXJmblheVcigAAX
         GrWE3cGyxRLUaHDZQz7lv7G6aYIHBjLygnGuRYbfAps3Hyumq1PmAMU+yxuI8FShWdOm
         mz0/tt8azenH+ruSCjuztKHrH+tujXcpbEUinu3mtQBBbP0KJ3uwgRExkF6yswbHqQEs
         6IWHKDBBI1Vz0/Z22ERgX1m2EL8fLRl9A4EDs8IojdNl/n4+czpgc9tKQEJjeRcA3xcm
         0k1g==
X-Gm-Message-State: AFqh2kpJ9AnqjH+Sy8mfCiLB91DMOQb6rQ9Z2eQvnnXY2HkkLnvtOFRI
        vYRNlUg1RBH0fLd0kTVXANSphCpN3h7WCg==
X-Google-Smtp-Source: AMrXdXtJ/bT4lGVIhlLq1HpWPJ8EWuKzqh12tStWgfd9Fd8N8nN5+Usstnazugcwxo7GL/emM+QbYg==
X-Received: by 2002:a17:907:73c1:b0:7e8:cf25:4b9c with SMTP id es1-20020a17090773c100b007e8cf254b9cmr60290106ejc.59.1673527567952;
        Thu, 12 Jan 2023 04:46:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v17-20020a170906293100b007be301a1d51sm7373523ejd.211.2023.01.12.04.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 04:46:07 -0800 (PST)
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
Subject: [PATCH v2 3/9] rebase & sequencer API: fix get_replay_opts() leak in "rebase"
Date:   Thu, 12 Jan 2023 13:45:55 +0100
Message-Id: <patch-v2-3.9-f06f565ceaf-20230112T124201Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1205.g2ca064edc27
In-Reply-To: <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the recently added replay_opts_release() function non-static and
use it for freeing the "struct replay_opts" constructed by the
get_replay_opts() function in "builtin/rebase.c". See [1] for the
initial addition of get_replay_opts().

To safely call our new replay_opts_release() we'll need to change all
the free() to a FREE_AND_NULL(), and set "xopts_nr" to "0" after we
loop over it and free() it (the free() in the loop doesn't need to be
a FREE_AND_NULL()).

This is because in e.g. do_interactive_rebase() we construct a "struct
replay_opts" with "get_replay_opts()", and then call
"complete_action()". If we get far enough in that function without
encountering errors we'll call "pick_commits()" which (indirectly)
calls sequencer_remove_state() at the end.

But if we encounter errors anywhere along the way we'd punt out early,
and not free() the memory we allocated. Remembering whether we
previously called sequencer_remove_state() would be a hassle, so let's
make it safe to re-invoke replay_opts_release() instead.

I experimented with a change to be more paranoid instead, i.e. to
exhaustively check our state via an enum. We could make sure that we:

- Only allow calling "replay_opts_release()" after
  "sequencer_remove_state()", but not the other way around.

- Forbid invoking either function twice in a row.

But such paranoia isn't warranted here, let's instead take the easy
way out and FREE_AND_NULL() this.

See [2] for the initial implementation of "sequencer_remove_state()",
which assumed that it should be removing the full (including on-disk)
rebase state as a one-off.

1. 73fdc535d26 (rebase -i: use struct rebase_options to parse args,
   2019-04-17)
2. 26ae337be11 (revert: Introduce --reset to remove sequencer state,
   2011-08-04)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c                       | 4 ++++
 builtin/revert.c                       | 2 ++
 sequencer.c                            | 5 ++---
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
 19 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 7141fd5e0c1..5859a5387d8 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -301,6 +301,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 	}
 
 cleanup:
+	replay_opts_release(&replay);
 	string_list_clear(&commands, 0);
 	free(revisions);
 	free(shortrevisions);
@@ -343,6 +344,7 @@ static int run_sequencer_rebase(struct rebase_options *opts)
 		struct replay_opts replay_opts = get_replay_opts(opts);
 
 		ret = sequencer_continue(the_repository, &replay_opts);
+		replay_opts_release(&replay_opts);
 		break;
 	}
 	case ACTION_EDIT_TODO:
@@ -558,6 +560,7 @@ static int finish_rebase(struct rebase_options *opts)
 
 		replay.action = REPLAY_INTERACTIVE_REBASE;
 		ret = sequencer_remove_state(&replay);
+		replay_opts_release(&replay);
 	} else {
 		strbuf_addstr(&dir, opts->state_dir);
 		if (remove_dir_recursively(&dir, 0))
@@ -1331,6 +1334,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
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
index d385bea2bed..5d8c68912a1 100644
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
@@ -359,6 +359,7 @@ static void replay_opts_release(struct replay_opts *opts)
 	free(opts->strategy);
 	for (size_t i = 0; i < opts->xopts_nr; i++)
 		free(opts->xopts[i]);
+	opts->xopts_nr = 0;
 	free(opts->xopts);
 	strbuf_release(&opts->current_fixups);
 }
@@ -385,8 +386,6 @@ int sequencer_remove_state(struct replay_opts *opts)
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
2.39.0.1205.g2ca064edc27

