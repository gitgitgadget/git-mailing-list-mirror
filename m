Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DB8C4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 07:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbiL3H2c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 02:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbiL3H2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 02:28:24 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03F818E08
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 23:28:22 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so12261408wmb.2
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 23:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nqa2DMjXohc5ZdGF/5POLR4SSHEAn6SS3Cw+rLCKpaA=;
        b=SWVxmMEJEojar1AWLTWfbMUL+nTX9kSNC6MEFayrEJFB3SOvi5YHOMxYqc35QwrH7a
         KqlmNj193xo5oUOwC/r8Q4WHTb3NOP6pQDxM/OZp2TbggM2y/bRxDYLCQFS6c+aa3B4r
         OQjiJAdiVuT86toZrs4kxXYWWKPUoHrLeyq2xIU88f4ObFBAr8cvAZKsRgVP0YB3FyJn
         yC6vaxwtBJmx3CYjN8uIo2TYJQ5rk01YRrLXvzVh5Vo7z6OxEMpOcEJR88WDqJqY402y
         czKfaIdbxRDU/a1k1wmvDzFkDwT/kEaYpCTu8N5Fz+PW6iSX4cpbLyde8FzytDxN1N4H
         qufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nqa2DMjXohc5ZdGF/5POLR4SSHEAn6SS3Cw+rLCKpaA=;
        b=JY9g9qq18G5IFELhGIvuWhN9M52jGkvbEj8Qp4LdIUoQKc9XE7loHK0rrKVicDDZOg
         dYmMIW73MLexTCwiO3YPtxYqxfHvVnf1307s466IMRCy10FqteLawmk2wOLy13ePI8wv
         BvZr7MpNcfAVzBEhDmgtflGJWz9khf5nehXgH1X7qqIDhVlADMwEO+QalpqcFlO3bv++
         pFcVFalHdyKLVOeflVyjqVhejXZbdUUuQRj4Ky1aCW9nIt4rST/TyNpvT2gmOoFsroTu
         Bkty9MkcgUp+tuBXIraPDeUQzSOBGBMNlx4CSfZo1FhCsr3t+sDjvXpaPBeCHFv2fWdI
         5RRA==
X-Gm-Message-State: AFqh2ko/+kMfD7+yK7nxj04/4Ck1cDuTN2EJ+HwqQV/xtdLAxeGkcpzb
        5XQ6hVvBTayVQzJiBVe5qt3OPQyMRvy/Fw==
X-Google-Smtp-Source: AMrXdXvVvREsgd6AfdzHeo5GbYcAEhsoO1wH1b8yKDtyvjt5uLZbyyqs19dyNN0bfAFF50Z+3XSPyQ==
X-Received: by 2002:a05:600c:3596:b0:3cf:497c:c4f5 with SMTP id p22-20020a05600c359600b003cf497cc4f5mr22866168wmq.13.1672385301110;
        Thu, 29 Dec 2022 23:28:21 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b003d998412db6sm6526449wmn.28.2022.12.29.23.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 23:28:20 -0800 (PST)
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
Subject: [PATCH 03/10] rebase & sequencer API: fix get_replay_opts() leak in "rebase"
Date:   Fri, 30 Dec 2022 08:28:08 +0100
Message-Id: <patch-03.10-3e9c4df61fe-20221230T071741Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
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

Re the "I experimented with...", the earlier version can be seen at
https://github.com/avar/git/commit/7a150d1b7e2; It's the commit I
linked to from
https://lore.kernel.org/git/221108.864jv9sc9r.gmgdl@evledraar.gmail.com/
(which is mentioned in the CL).

 builtin/rebase.c                       |  2 ++
 sequencer.c                            | 13 +++++++------
 sequencer.h                            |  1 +
 t/t3405-rebase-malformed.sh            |  1 +
 t/t3412-rebase-root.sh                 |  1 +
 t/t3423-rebase-reword.sh               |  1 +
 t/t3437-rebase-fixup-options.sh        |  1 +
 t/t3438-rebase-broken-files.sh         |  2 ++
 t/t7402-submodule-rebase.sh            |  1 +
 t/t9106-git-svn-commit-diff-clobber.sh |  1 -
 t/t9164-git-svn-dcommit-concurrent.sh  |  1 -
 11 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 7141fd5e0c1..91bf55be6e6 100644
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
diff --git a/sequencer.c b/sequencer.c
index 655ae9f1a72..e29a97b6caa 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -351,15 +351,16 @@ static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
 	return buf.buf;
 }
 
-static void replay_opts_release(struct replay_opts *opts)
+void replay_opts_release(struct replay_opts *opts)
 {
-	free(opts->gpg_sign);
-	free(opts->reflog_action);
-	free(opts->default_strategy);
-	free(opts->strategy);
+	FREE_AND_NULL(opts->gpg_sign);
+	FREE_AND_NULL(opts->reflog_action);
+	FREE_AND_NULL(opts->default_strategy);
+	FREE_AND_NULL(opts->strategy);
 	for (size_t i = 0; i < opts->xopts_nr; i++)
 		free(opts->xopts[i]);
-	free(opts->xopts);
+	opts->xopts_nr = 0;
+	FREE_AND_NULL(opts->xopts);
 	strbuf_release(&opts->current_fixups);
 }
 
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
diff --git a/t/t3423-rebase-reword.sh b/t/t3423-rebase-reword.sh
index 4859bb8f722..2fab703d615 100755
--- a/t/t3423-rebase-reword.sh
+++ b/t/t3423-rebase-reword.sh
@@ -2,6 +2,7 @@
 
 test_description='git rebase interactive with rewording'
 
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
2.39.0.1153.g589e4efe9dc

