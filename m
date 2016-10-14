Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0660B1F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 13:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932822AbcJNNYd (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:24:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:59710 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932482AbcJNNYP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:24:15 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MOjMY-1c14UI1tHa-0067U9; Fri, 14 Oct 2016 15:15:52
 +0200
Date:   Fri, 14 Oct 2016 15:15:51 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 00/25] Prepare the sequencer for the upcoming rebase -i
 patches
In-Reply-To: <cover.1476120229.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1476450940.git.johannes.schindelin@gmx.de>
References: <cover.1476120229.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:KWQdr9mTEXMBhR5YU/T1jKTwIO0z9Whya3Q2EhcDfgtbMKHB684
 kLthlsYbgLzG1XugsnNtez3k8HuZpaY3SroMUOZHdks1QY+0XN7512j8w60A9GGVveWwwxN
 nmsgVd2eBKOaIxWPYkbzFmy7hgB8gdSZjzFvIiRgYVNIZkel6azX7uIh+LOd4Kp22Zs/PBP
 SFySEwEJyH2jO3BG7VViA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rW+oI+TDJjQ=:V8f/JiRzgQKIu1nyCkpeYN
 6LYCFAi41SgDqsqwOvdpetiW3jMwQNePJLrPn+8eRUOyPB+nUqexoV+aza7YY5nI2OZJeZm8f
 TCCE0N6FdEN9quv8qoXZafCxdZt4SkV5WJqXE6qfu3fKXJt3QrWBti8fzQ/y2f6+bb97eWLvc
 ydWkRS0GjVPKXr7E9aVmAlojJZ79I8oqxHkUo7N6t/FUmp++pCWCpR61JFhpNMH/tn5QnBKEj
 vHS8Bk7J+Y3iwIcPsdhQJ02QP768J6l32On51KTe/e3mT+8m9WJkyDnOUIoqa02cEU/r9znCM
 p5/FmxPSIJ90Rcng2AeInUCE+pjME6dtuXM7V5q5rAoNq1ZnbO5wF+IccfyKMbCvsiYBNps+t
 7KnIIPZCXRT0YDOUOUCl2wFXcxzW1NNrZ1yGABPboiPsZudReRe2a7w1geiZeop59iMtWNSr0
 gGmKpK4Y7qQTjL4k424a1IO23cXKbzGMDFRF7WsHJNQZYipZA5vKEPTj8vw2rdaEUMtoVIcIF
 6sz7JOpjOGcYMLaL+VcDfkZjuuTU8CKKEbctYlogJIzqonFiTBNIKYqNLZcA1A9Dau2052ohS
 q0z+kDRU0u92+2/oe0f1g/xTC1V1iI1PNYTbBI4sTc/Ajh1J2wNzO00PsuIaHOEXvl1xQj5ej
 ZxPtXibNxPgxJEOWLferxh1kHj/VTJRqoCPu5nMbgslO0wTGf9iv2OpE65CH1bq5yW32oFonL
 QP3mLXZTg453iJUHn8tt7Qa7InNN61f5qQk9bS2H1r0qO+wKLzc5tig7GDOH/jfL5E6L5PspB
 yV88lPB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series marks the '4' in the countdown to speed up rebase -i
by implementing large parts in C (read: there will be three more patch
series after that before the full benefit hits git.git: sequencer-i,
rebase--helper and rebase-i-extra). It is based on the `libify-sequencer`
patch series I submitted earlier.

The patches in this series merely prepare the sequencer code for the
next patch series that actually teaches the sequencer to run rebase -i's
commands.

The reason to split these two patch series is simple: to keep them at a
sensible size.

The two patch series after that are much smaller: a two-patch "series"
that switches rebase -i to use the sequencer (except with --root or
--preserve-merges), and a couple of patches to move several pretty
expensive script processing steps to C (think: autosquash).

The end game of this patch series is a git-rebase--helper that makes
rebase -i 5x faster on Windows (according to t/perf/p3404). Travis says
that even MacOSX and Linux benefit (4x and 3x, respectively).

I have been working on this since early February, whenever time allowed,
and it is time to put it into the users' hands. To that end, I already
integrated the whole shebang into Git for Windows 2.10.0 and 2.10.1
where it has been running without complaints (and some quite positive
feedback).

Changes vs v3:

- fixed TRANSLATORS: comment to help the tool extracting those comments.

- reordered the patch introducing the short_commit_name() function so it
  can be used in the patch revamping the todo parsing right away, as
  opposed to fixing up the find_unique_abbrev() ugliness in a later
  patch.

- backed out the write_message_gently() function of this patch series:
  it is not used by the end of this patch series and would therefore let
  the build fail with DEVELOPER=1. That function is now introduced as
  part of the patch in the sequencer-i series that adds support for the
  'edit' command.

- edited "skip CR/skip LF" to say "strip" instead.

- used xstrdup_or_null() where appropriate.

- abstracted out git_config_string_dup() instead of adding
  near-duplicate code.

- marked the append_new_todo() function as file-local, pointed out by
  Ramsay.

- made the "you have staged changes" advice prettier by moving it out of
  the run_git_commit() function, based on a suggestion by Hannes Sixt.


Johannes Schindelin (25):
  sequencer: use static initializers for replay_opts
  sequencer: use memoized sequencer directory path
  sequencer: avoid unnecessary indirection
  sequencer: future-proof remove_sequencer_state()
  sequencer: eventually release memory allocated for the option values
  sequencer: future-proof read_populate_todo()
  sequencer: refactor the code to obtain a short commit name
  sequencer: completely revamp the "todo" script parsing
  sequencer: strip CR from the todo script
  sequencer: avoid completely different messages for different actions
  sequencer: get rid of the subcommand field
  sequencer: remember the onelines when parsing the todo file
  sequencer: prepare for rebase -i's commit functionality
  sequencer: introduce a helper to read files written by scripts
  sequencer: allow editing the commit message on a case-by-case basis
  sequencer: support amending commits
  sequencer: support cleaning up commit messages
  sequencer: do not try to commit when there were merge conflicts
  sequencer: left-trim lines read from the script
  sequencer: refactor write_message()
  sequencer: remove overzealous assumption in rebase -i mode
  sequencer: mark action_name() for translation
  sequencer: quote filenames in error messages
  sequencer: start error messages consistently with lower case
  sequencer: mark all error messages for translation

 builtin/commit.c              |   2 +-
 builtin/revert.c              |  46 ++-
 sequencer.c                   | 679 ++++++++++++++++++++++++++++--------------
 sequencer.h                   |  23 +-
 t/t3501-revert-cherry-pick.sh |   2 +-
 5 files changed, 492 insertions(+), 260 deletions(-)


base-commit: 3cdd5d19178a54d2e51b5098d43b57571241d0ab
Published-As: https://github.com/dscho/git/releases/tag/prepare-sequencer-v4
Fetch-It-Via: git fetch https://github.com/dscho/git prepare-sequencer-v4

Interdiff vs v3:

 diff --git a/builtin/revert.c b/builtin/revert.c
 index 0a7b5f4..4ca5b51 100644
 --- a/builtin/revert.c
 +++ b/builtin/revert.c
 @@ -166,10 +166,8 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
  		usage_with_options(usage_str, options);
  
  	/* These option values will be free()d */
 -	if (opts->gpg_sign)
 -		opts->gpg_sign = xstrdup(opts->gpg_sign);
 -	if (opts->strategy)
 -		opts->strategy = xstrdup(opts->strategy);
 +	opts->gpg_sign = xstrdup_or_null(opts->gpg_sign);
 +	opts->strategy = xstrdup_or_null(opts->strategy);
  
  	if (cmd == 'q')
  		return sequencer_remove_state(opts);
 diff --git a/sequencer.c b/sequencer.c
 index 86d86ce..1cf70f7 100644
 --- a/sequencer.c
 +++ b/sequencer.c
 @@ -265,12 +265,6 @@ static int write_message(struct strbuf *msgbuf, const char *filename)
  	return res;
  }
  
 -static int write_file_gently(const char *filename,
 -			     const char *text, int append_eol)
 -{
 -	return write_with_lock_file(filename, text, strlen(text), append_eol);
 -}
 -
  /*
   * Reads a file that was presumably written by a shell script, i.e.
   * with an end-of-line marker that needs to be stripped.
 @@ -489,6 +483,20 @@ static char **read_author_script(void)
  	return env;
  }
  
 +static const char staged_changes_advice[] =
 +N_("you have staged changes in your working tree\n"
 +"If these changes are meant to be squashed into the previous commit, run:\n"
 +"\n"
 +"  git commit --amend %s\n"
 +"\n"
 +"If they are meant to go into a new commit, run:\n"
 +"\n"
 +"  git commit %s\n"
 +"\n"
 +"In both cases, once you're done, continue with:\n"
 +"\n"
 +"  git rebase --continue\n");
 +
  /*
   * If we are cherry-pick, and if the merge did not result in
   * hand-editing, we will hit this commit and inherit the original
 @@ -515,18 +523,7 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
  		if (!env) {
  			const char *gpg_opt = gpg_sign_opt_quoted(opts);
  
 -			return error(_("you have staged changes in your "
 -				       "working tree. If these changes are "
 -				       "meant to be\n"
 -				       "squashed into the previous commit, "
 -				       "run:\n\n"
 -				       "  git commit --amend %s\n\n"
 -				       "If they are meant to go into a new "
 -				       "commit, run:\n\n"
 -				       "  git commit %s\n\n"
 -				       "In both cases, once you're done, "
 -				       "continue with:\n\n"
 -				       "  git rebase --continue\n"),
 +			return error(_(staged_changes_advice),
  				     gpg_opt, gpg_opt);
  		}
  	}
 @@ -702,10 +699,8 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
  		return fast_forward_to(commit->object.oid.hash, head, unborn, opts);
  
  	if (parent && parse_commit(parent) < 0)
 -		/*
 -		 * TRANSLATORS: The first %s will be a "todo" command like
 -		 * "revert" or "pick", the second %s a SHA1.
 -		 */
 +		/* TRANSLATORS: The first %s will be a "todo" command like
 +		   "revert" or "pick", the second %s a SHA1. */
  		return error(_("%s: cannot parse parent commit %s"),
  			command_to_string(command),
  			oid_to_hex(&parent->object.oid));
 @@ -885,7 +880,7 @@ static void todo_list_release(struct todo_list *todo_list)
  	todo_list->nr = todo_list->alloc = 0;
  }
  
 -struct todo_item *append_new_todo(struct todo_list *todo_list)
 +static struct todo_item *append_new_todo(struct todo_list *todo_list)
  {
  	ALLOC_GROW(todo_list->items, todo_list->nr + 1, todo_list->alloc);
  	return todo_list->items + todo_list->nr++;
 @@ -939,10 +934,10 @@ static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
  	for (i = 1; *p; i++, p = next_p) {
  		char *eol = strchrnul(p, '\n');
  
 -		next_p = *eol ? eol + 1 /* skip LF */ : eol;
 +		next_p = *eol ? eol + 1 /* strip LF */ : eol;
  
  		if (p != eol && eol[-1] == '\r')
 -			eol--; /* skip Carriage Return */
 +			eol--; /* strip Carriage Return */
  
  		item = append_new_todo(todo_list);
  		item->offset_in_buf = p - todo_list->buf.buf;
 @@ -994,6 +989,16 @@ static int read_populate_todo(struct todo_list *todo_list,
  	return 0;
  }
  
 +static int git_config_string_dup(char **dest,
 +				 const char *var, const char *value)
 +{
 +	if (!value)
 +		return config_error_nonbool(var);
 +	free(*dest);
 +	*dest = xstrdup(value);
 +	return 0;
 +}
 +
  static int populate_opts_cb(const char *key, const char *value, void *data)
  {
  	struct replay_opts *opts = data;
 @@ -1013,22 +1018,10 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
  		opts->allow_ff = git_config_bool_or_int(key, value, &error_flag);
  	else if (!strcmp(key, "options.mainline"))
  		opts->mainline = git_config_int(key, value);
 -	else if (!strcmp(key, "options.strategy")) {
 -		if (!value)
 -			config_error_nonbool(key);
 -		else {
 -			free(opts->strategy);
 -			opts->strategy = xstrdup(value);
 -		}
 -	}
 -	else if (!strcmp(key, "options.gpg-sign")) {
 -		if (!value)
 -			config_error_nonbool(key);
 -		else {
 -			free(opts->gpg_sign);
 -			opts->gpg_sign = xstrdup(value);
 -		}
 -	}
 +	else if (!strcmp(key, "options.strategy"))
 +		git_config_string_dup(&opts->strategy, key, value);
 +	else if (!strcmp(key, "options.gpg-sign"))
 +		git_config_string_dup(&opts->gpg_sign, key, value);
  	else if (!strcmp(key, "options.strategy-option")) {
  		ALLOC_GROW(opts->xopts, opts->xopts_nr + 1, opts->xopts_alloc);
  		opts->xopts[opts->xopts_nr++] = xstrdup(value);

-- 
2.10.1.513.g00ef6dd

