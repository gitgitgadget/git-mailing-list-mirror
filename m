Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0FCC433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B7B960F45
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245641AbhIGVGX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 17:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhIGVGW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 17:06:22 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEF0C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 14:05:15 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso283112wmi.5
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 14:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=dCpIvZq4GzaqE2XihCGJvy2kp0m8JUi1Eq+2DMqSBTg=;
        b=UuibjK08bTj+WwdE1xSxndNACMVXHmfjMOD0NibDz9RFP9loXjlLbSV1/zpvUJgaAF
         LwLyXXP4SvzayV43NLXozHnUvhBcYtiDyqR/0+WpMtIvfFD/NroXB1aH8hoQl3aAFk6q
         GHZYT18X//joCURRoJ95H4lmmCDrx/znSyqMRnTcMwkMVkdvbUmBfmnwpI8KwfZf/pS8
         QgTGQ/rz28WNl5JsMKmQlQeI4vFVkNX1D1mcJBFd86fOZfwUDYN5IWtOotQwGyu3FUKo
         KFxhLW1SDn4sZLRyP3mzpqhVUilwqC0g1k6/Hf4N6jAFyjt5kcJehbJ2CWRkXHf9VU7r
         DLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=dCpIvZq4GzaqE2XihCGJvy2kp0m8JUi1Eq+2DMqSBTg=;
        b=VyAARAx1um/eQFq1oaRsPP6WWHVNTGHZHrXVE2inTSFFO1wzzHy6JlIRYV5Jnr+wzL
         qoMtIRSNTNnAwTC66kEV8iKbDmvAb/BkXqtLGuvlPS7NWYdSqUzlrtJYtV5tbchKCOK9
         YhPPNLWoGFgYYUohMsAO90AMV6v5dC66XUCdUkYCJIOMgkGSdqJoyGDENBxmRonp6FCt
         ZgyTAE1gseYjZ80yD2WN75HG/ZXw2QiZPXtwXCC+vuXT0JwCK98uUdI6ijdqalHfP1Zz
         N8iEqUOXmoPBwQaAo4FHPUT/GlGTi71LePVYUGvFuEWzVom7ytxIKR6oDI/Tw7k3fsec
         zE6g==
X-Gm-Message-State: AOAM530cmztkaJQHvkFCq/Vl/ZHN/2/lxq0gxzjnej/bI4d5359y0gQA
        pX4AQ7inhVETcxOOV3+GaqKDNS6OJbs=
X-Google-Smtp-Source: ABdhPJzcWm8qhdVLnLQww2+Q8eSi1/NtGZySCX9FXNLtVe/e7FdJdvF/7Shv2djUXMBONK4odWrxLg==
X-Received: by 2002:a05:600c:a49:: with SMTP id c9mr200569wmq.159.1631048714468;
        Tue, 07 Sep 2021 14:05:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3sm120577wrg.45.2021.09.07.14.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 14:05:13 -0700 (PDT)
Message-Id: <pull.195.v3.git.1631048712.gitgitgadget@gmail.com>
In-Reply-To: <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
References: <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Sep 2021 21:05:01 +0000
Subject: [PATCH v3 00/11] Drop support for git rebase --preserve-merges
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 427c3bd28ab (rebase: deprecate --preserve-merges, 2019-03-11) (which was
included in v2.22.0), we officially deprecated the --preserve-merges
backend. Over two years later, it is time to drop that backend, and here is
a patch series that does just that.

Changes since v2:

 * Removed the no-longer-needed script_snippet variable
 * Enhanced the commit message of the git svn patch to clarify that the
   deprecation happened only in v2.25 there
 * Adjusted code comments that still talked about the removed option
 * Removed some no-longer-needed ACTION_* enum values
 * We now also drop check_todo_list_from_file() because it is no longer
   needed
 * The todo_list_add_exec_commands() function is now scoped to the file
   (because there are no longer any outside users)
 * When users still use the options, they are no longer met by Git's blank
   stares, but by a helpful error message suggesting to use --rebase-merges
   instead

Changes since v1:

 * Rebased onto v2.33.0

Johannes Schindelin (11):
  t5520: do not use `pull.rebase=preserve`
  remote: warn about unhandled branch.<name>.rebase values
  tests: stop testing `git rebase --preserve-merges`
  pull: remove support for `--rebase=preserve`
  rebase: drop support for `--preserve-merges`
  git-svn: drop support for `--preserve-merges`
  rebase: drop the internal `rebase--interactive` command
  rebase: remove obsolete code comment
  rebase: stop mentioning the -p option in comments
  rebase: remove a no-longer-used function
  sequencer: restrict scope of a formerly public function

 .github/workflows/main.yml                |    1 -
 .gitignore                                |    1 -
 Documentation/config/branch.txt           |    4 -
 Documentation/config/pull.txt             |    4 -
 Documentation/git-pull.txt                |    6 +-
 Documentation/git-rebase.txt              |   51 -
 Documentation/git-svn.txt                 |    1 -
 Makefile                                  |    2 -
 builtin/pull.c                            |    9 +-
 builtin/rebase.c                          |  335 +------
 builtin/remote.c                          |    3 +
 contrib/completion/git-completion.bash    |    2 +-
 git-rebase--preserve-merges.sh            | 1057 ---------------------
 git-svn.perl                              |    1 -
 git.c                                     |    1 -
 rebase-interactive.c                      |   29 -
 rebase-interactive.h                      |    2 -
 rebase.c                                  |    5 +-
 rebase.h                                  |    1 -
 sequencer.c                               |    4 +-
 sequencer.h                               |    2 -
 t/t3404-rebase-interactive.sh             |   76 --
 t/t3408-rebase-multi-line.sh              |   10 -
 t/t3409-rebase-preserve-merges.sh         |  130 ---
 t/t3410-rebase-preserve-dropped-merges.sh |   90 --
 t/t3411-rebase-preserve-around-merges.sh  |   80 --
 t/t3412-rebase-root.sh                    |   37 -
 t/t3414-rebase-preserve-onto.sh           |   85 --
 t/t3418-rebase-continue.sh                |   15 -
 t/t3421-rebase-topology-linear.sh         |   19 -
 t/t3422-rebase-incompatible-options.sh    |   11 -
 t/t3425-rebase-topology-merges.sh         |  151 ---
 t/t3427-rebase-subtree.sh                 |   26 +-
 t/t5520-pull.sh                           |   24 +-
 t/t7505-prepare-commit-msg-hook.sh        |    1 -
 t/t7517-per-repo-email.sh                 |   13 -
 t/test-lib.sh                             |    4 -
 37 files changed, 33 insertions(+), 2260 deletions(-)
 delete mode 100644 git-rebase--preserve-merges.sh
 delete mode 100755 t/t3409-rebase-preserve-merges.sh
 delete mode 100755 t/t3410-rebase-preserve-dropped-merges.sh
 delete mode 100755 t/t3411-rebase-preserve-around-merges.sh
 delete mode 100755 t/t3414-rebase-preserve-onto.sh


base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-195%2Fdscho%2Fdrop-rebase-p-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-195/dscho/drop-rebase-p-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/195

Range-diff vs v2:

  1:  8da29d539fc =  1:  8da29d539fc t5520: do not use `pull.rebase=preserve`
  2:  acda0f59947 =  2:  acda0f59947 remote: warn about unhandled branch.<name>.rebase values
  3:  cdb9fae4b93 !  3:  e4b683f0cd6 tests: stop testing `git rebase --preserve-merges`
     @@ t/t3425-rebase-topology-merges.sh: test_run_rebase success 'd n o e' --apply
       test_done
      
       ## t/t3427-rebase-subtree.sh ##
     +@@ t/t3427-rebase-subtree.sh: commit_message() {
     + # where the root commit adds three files: topic_1.t, topic_2.t and topic_3.t.
     + #
     + # This commit history is then rebased onto `topic_3` with the
     +-# `-Xsubtree=files_subtree` option in three different ways:
     ++# `-Xsubtree=files_subtree` option in two different ways:
     + #
     +-# 1. using `--preserve-merges`
     +-# 2. using `--preserve-merges` and --keep-empty
     +-# 3. without specifying a rebase backend
     ++# 1. without specifying a rebase backend
     ++# 2. using the `--rebase-merges` backend
     + 
     + test_expect_success 'setup' '
     + 	test_commit README &&
      @@ t/t3427-rebase-subtree.sh: test_expect_success 'setup' '
       	git commit -m "Empty commit" --allow-empty
       '
  4:  b493046134d !  4:  6e45e90abe5 pull: remove support for `--rebase=preserve`
     @@ Commit message
          In preparation for `git-rebase--preserve-merges.sh` entering its after
          life, we remove this (deprecated) option that would still rely on it.
      
     +    To help users transition who still did not receive the memo about the
     +    deprecation, we offer a helpful error message instead of throwing our
     +    hands in the air and saying that we don't know that option, never heard
     +    of it.
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## Documentation/config/branch.txt ##
     @@ contrib/completion/git-completion.bash: __git_complete_config_variable_value ()
       	remote.pushdefault)
      
       ## rebase.c ##
     +@@
     + #include "rebase.h"
     + #include "config.h"
     ++#include "gettext.h"
     + 
     + /*
     +  * Parses textual value for pull.rebase, branch.<name>.rebase, etc.
      @@ rebase.c: enum rebase_type rebase_parse_value(const char *value)
       		return REBASE_FALSE;
       	else if (v > 0)
     @@ rebase.c: enum rebase_type rebase_parse_value(const char *value)
       	else if (!strcmp(value, "merges") || !strcmp(value, "m"))
       		return REBASE_MERGES;
       	else if (!strcmp(value, "interactive") || !strcmp(value, "i"))
     + 		return REBASE_INTERACTIVE;
     ++	else if (!strcmp(value, "preserve") || !strcmp(value, "p"))
     ++		error(_("%s: 'preserve' superseded by 'merges'"), value);
     + 	/*
     + 	 * Please update _git_config() in git-completion.bash when you
     + 	 * add new rebase modes.
      
       ## rebase.h ##
      @@ rebase.h: enum rebase_type {
  5:  eb738b1bf05 !  5:  2d7a4a2c564 rebase: drop support for `--preserve-merges`
     @@ Commit message
          This option was deprecated in favor of `--rebase-merges` some time ago,
          and now we retire it.
      
     +    To assist users to transition away, we do not _actually_ remove the
     +    option, but now we no longer implement the functionality. Instead, we
     +    offer a helpful error message suggesting which option to use.
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## .gitignore ##
     @@ builtin/rebase.c: static int run_am(struct rebase_options *opts)
       {
      -	const char *argv[] = { NULL, NULL };
      -	struct strbuf script_snippet = STRBUF_INIT, buf = STRBUF_INIT;
     -+	struct strbuf script_snippet = STRBUF_INIT;
       	int status;
      -	const char *backend, *backend_func;
       
     @@ builtin/rebase.c: static int run_specific_rebase(struct rebase_options *opts, en
       		BUG("Unhandled rebase type %d", opts->type);
      -		break;
      -	}
     - 
     +-
      -	strbuf_addf(&script_snippet,
      -		    ". git-sh-setup && . %s && %s", backend, backend_func);
      -	argv[0] = script_snippet.buf;
     --
     + 
      -	status = run_command_v_opt(argv, RUN_USING_SHELL);
      -finished_rebase:
       	if (opts->dont_finish_rebase)
       		; /* do nothing */
       	else if (opts->type == REBASE_MERGE)
     +@@ builtin/rebase.c: finished_rebase:
     + 		die("Nothing to do");
     + 	}
     + 
     +-	strbuf_release(&script_snippet);
     +-
     + 	return status ? -1 : 0;
     + }
     + 
     +@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     + 	char *squash_onto_name = NULL;
     + 	int reschedule_failed_exec = -1;
     + 	int allow_preemptive_ff = 1;
     ++	int preserve_merges_selected = 0;
     + 	struct option builtin_rebase_options[] = {
     + 		OPT_STRING(0, "onto", &options.onto_name,
     + 			   N_("revision"),
      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
       			N_("let the user edit the list of commits to rebase"),
       			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
       			parse_opt_interactive),
      -		OPT_SET_INT_F('p', "preserve-merges", &options.type,
     --			      N_("(DEPRECATED) try to recreate merges instead of "
     --				 "ignoring them"),
     ++		OPT_SET_INT_F('p', "preserve-merges", &preserve_merges_selected,
     + 			      N_("(DEPRECATED) try to recreate merges instead of "
     + 				 "ignoring them"),
      -			      REBASE_PRESERVE_MERGES, PARSE_OPT_HIDDEN),
     ++			      1, PARSE_OPT_HIDDEN),
       		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
       		OPT_CALLBACK_F(0, "empty", &options, "{drop,keep,ask}",
       			       N_("how to handle commits that become empty"),
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
       		} else {
       			strbuf_reset(&buf);
       			strbuf_addf(&buf, "%s/interactive", merge_dir());
     +@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     + 			     builtin_rebase_options,
     + 			     builtin_rebase_usage, 0);
     + 
     ++	if (preserve_merges_selected)
     ++		die(_("--preserve-merges was replaced by --rebase-merges"));
     ++
     + 	if (action != ACTION_NONE && total_argc != 2) {
     + 		usage_with_options(builtin_rebase_usage,
     + 				   builtin_rebase_options);
      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
       		usage_with_options(builtin_rebase_usage,
       				   builtin_rebase_options);
  6:  a987e9439af !  6:  913647d8e76 git-svn: drop support for `--preserve-merges`
     @@ Commit message
          We already passed the `--rebase-merges` option to `git rebase` instead,
          now we make this move permanent.
      
     +    As pointed out by Ævar Arnfjörð Bjarmason, in contrast to the
     +    deprecation of `git rebase`'s `--preserve-merges` backend, `git svn`
     +    only deprecated this option in v2.25.0 (because this developer missed
     +    `git svn`'s use of that backend when deprecating the rebase backend
     +    running up to Git v2.22).
     +
     +    Still, v2.25.0 has been released on January 13th, 2020. In other words,
     +    `git svn` deprecated this option over one and a half years ago, _and_
     +    has been redirecting to the `--rebase-merges` option during all that
     +    time (read: `git svn rebase --preserve-merges` didn't do _precisely_
     +    what the user asked, since v2.25.0, anyway, it fell back to pretending
     +    that the user asked for `git svn rebase --rebase-merges` instead).
     +
     +    It is time to act on that deprecation and remove that option after all.
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## Documentation/git-svn.txt ##
  7:  4492cca369c !  7:  b5a16e205e6 rebase: drop the internal `rebase--interactive` command
     @@ Commit message
          It was only used by the `--preserve-merges` backend, which we just
          removed.
      
     +    Helped-by: Alban Gruin <alban.gruin@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## builtin/rebase.c ##
     +@@ builtin/rebase.c: enum action {
     + 	ACTION_ABORT,
     + 	ACTION_QUIT,
     + 	ACTION_EDIT_TODO,
     +-	ACTION_SHOW_CURRENT_PATCH,
     +-	ACTION_SHORTEN_OIDS,
     +-	ACTION_EXPAND_OIDS,
     +-	ACTION_CHECK_TODO_LIST,
     +-	ACTION_REARRANGE_SQUASH,
     +-	ACTION_ADD_EXEC
     ++	ACTION_SHOW_CURRENT_PATCH
     + };
     + 
     + static const char *action_names[] = { "undefined",
      @@ builtin/rebase.c: static const char *action_names[] = { "undefined",
       				      "edit_todo",
       				      "show_current_patch" };
     @@ builtin/rebase.c: static const char *action_names[] = { "undefined",
       {
       	const char *todo_file = rebase_path_todo();
      @@ builtin/rebase.c: static int run_sequencer_rebase(struct rebase_options *opts,
     + 	flags |= opts->rebase_merges ? TODO_LIST_REBASE_MERGES : 0;
     + 	flags |= opts->rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
     + 	flags |= opts->root_with_onto ? TODO_LIST_ROOT_WITH_ONTO : 0;
     +-	flags |= command == ACTION_SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
     + 	flags |= opts->reapply_cherry_picks ? TODO_LIST_REAPPLY_CHERRY_PICKS : 0;
     + 
     + 	switch (command) {
     +@@ builtin/rebase.c: static int run_sequencer_rebase(struct rebase_options *opts,
       
       		break;
       	}
  -:  ----------- >  8:  d23f245b684 rebase: remove obsolete code comment
  -:  ----------- >  9:  6905c8746ba rebase: stop mentioning the -p option in comments
  -:  ----------- > 10:  5bb04ea3f6c rebase: remove a no-longer-used function
  -:  ----------- > 11:  aae9323b25f sequencer: restrict scope of a formerly public function

-- 
gitgitgadget
