Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 760F42042F
	for <e@80x24.org>; Tue, 13 Dec 2016 15:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933178AbcLMPgK (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:36:10 -0500
Received: from mout.gmx.net ([212.227.17.21]:50700 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932740AbcLMPgA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:36:00 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M1FAK-1capo52732-00tEXc; Tue, 13
 Dec 2016 16:29:10 +0100
Date:   Tue, 13 Dec 2016 16:29:06 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 00/34] Teach the sequencer to act as rebase -i's backend
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lJhx5rw2GseztJOtbxgY5fv8QJkORZ8tMw8oDzbiUqT6OzSo6Bb
 0AoZuO+jyChPybVCuRGzXH+6bylX+FkdY3FB1qNCSysJ+tHiMNJVUjyz6g31dTAy2moHGgP
 Q6uC6BaKWi1eKheR3YPcVcfAHNXJDj+4PKKh4Zxj/wgU9McBBejJhN6easPGZRo552RF5zh
 LWsO9+8EVh6voMhu7+plg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ryO9IBV9O3s=:m42Dw5uiy0wo52Sg9lD3Vh
 Vhf789lhi4/2O/PHmJ2wJGz5rUIc1TzjGdX2HAeKN6n384gNvePq84f2YRqPWdFNQEVP/xsQq
 z1r2Cvnu8K7lag/TRK656m6vLnFjnDHhNROtXkYk9evCuwM3xWT9Nd6V61IgObKOs7QniQeQI
 YVfXNUejflYADDt0MPCHCxHnYdQRqb0/TwmEJEBS/OicogAXKTA/4rZi1xABw9rup36OUFvx1
 pINHFdbXoQanPAmLm63hXhoc4CAF2M9c0X96S87o2Ky0W4dtDtCeFrY6yG9H5f+jMrtif7O6k
 TGdJf1QQtSSdTXVXDSAdeTmC0drYWeWh8rJZH7sdehN3X8WKjtc90N9kYOCcoSkkoiA0eVg5c
 QF3dD/OUaO4fmaGxQRTE26C5mUQiBXYwVYW5SvS9DGTZrudMuqyoWex1oC59uDcK5uykS/wLV
 sHFcO/dVuXHVMN34wgLu6Hc2fLbn6g1NlNkWn47jMWl5Gv6fBlcIJdNoWjRvZ9ZrFlJlK9Xw/
 7oO6fZqr0ZZ4xRHYbZVRR+IfISS9x9qhHRjj26+v1kIZ8keekq+QaaNL/99IvSIc6TqBAN1cq
 u3SCfQ9uf9ESi+r8NSZWl1fqnVYraeNgJbmMlXtm7U1C3kPtx6qMqtg67zRge3UFheLMw2mdl
 uDmvrxrxnzdoqrS3S7KXuwKHAiasyRl/gcF2xh0TPKbJpBOn32A+HIgFbqD3mk4Y/0XR9TGAW
 g38HkvOv/sKbOlF6VJQ8BVP3LXygsUTi1NR1PZ5ub7gyzgf1BJkZFDu8ENAgCiR1DQJhS5CT0
 ZN53FsE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This marks the count down to '3': two more patch series after this
(really tiny ones) and we have a faster rebase -i.

The idea of this patch series is to teach the sequencer to understand
all of the commands in `git-rebase-todo` scripts, to execute them and to
behave pretty much very the same as `git rebase -i --continue` when
called with the newly-introduced REPLAY_INTERACTIVE_REBASE mode.

Most of these patches should be pretty much straight-forward. When not,
I tried to make a point of describing enough background in the commit
message. Please feel free to point out where my explanations fall short.

Note that even after this patch series is applied, rebase -i is still
unaffected. It will require the next patch series which introduces the
rebase--helper that essentially implements `git rebase -i --continue` by
calling the sequencer with the appropriate options.

The final patch series will move a couple of pre- and post-processing
steps into the rebase--helper/sequencer (such as expanding/shrinking the
SHA-1s, reordering the fixup!/squash! lines, etc). This might sound like
a mere add-on, but it is essential for the speed improvements: those
stupid little processing steps really dominated the execution time in my
tests.

Apart from mostly cosmetic patches (and the occasional odd bug that I
fixed promptly), I used these patches since mid May to perform all of my
interactive rebases. In mid June, I had the idea to teach rebase -i to
run *both* scripted rebase and rebase--helper and to cross-validate the
results. This slowed down all my interactive rebases since, but helped
me catch three rather obscure bugs (e.g. that git commit --fixup unfolds
long onelines and rebase -i still finds the correct original commit).

This is all only to say that I am rather confident that the current code
does the job.

Since sending out v1, I integrated all of these patch series
into Git for Windows v2.10.0, where they have been live ever since, and
used by myself (also in a Linux VM, as Git for Windows' master branch
always builds also on Linux and passes the test suite, too).

Just to reiterate why I do all this: it speeds up the interactive rebase
substantially. Even with a not yet fully builtin rebase -i, but just the
part after the user edited the `git-rebase-todo` script.

The performance test I introduced to demonstrate this (p3404) shows a
speed-up of +380% here (i.e. roughly 5x), from ~8.8 seconds to ~1.8
seconds. This is on Windows, where the performance impact of avoiding
shell scripting is most noticable.

On MacOSX and on Linux, the speed-up is less pronounced, but still
noticable, at least if you trust Travis CI, which I abused to perform
that test for me. Check for yourself (searching for "3404.2") here:
https://travis-ci.org/git/git/builds/156295227. According to those logs,
p3404 is speeded up from ~0.45 seconds to ~0.12 seconds on Linux (read:
about 3.5x) and from ~1.7 seconds to ~0.5 seconds on MacOSX (read:
almost 4x).

Please note that the interdiff vs v1 is only of limited use: too many
things changed in the meantime, in particular the prepare-sequencer
branch that went through a couple of iterations before it found its way
into git.git's master branch. So please take the interdiff with a
mountain range of salt.

Changes since v1:

- some grammar touch-ups.

- simplified determining the command string in
  walk_revs_populate_todo().

- removed the beautiful ordinal logic (to print out "1st", "2nd", "3rd"
  etc) and made things consistent with the current `rebase -i`.

- while at it, marked more messages for translation.

- added code-comments to clarify the order, and the sections, of the
  todo_command enum.

- replaced one error(..., strerror(...)) to an error_errno(...).

- downcased error messages

- marked error messages for translation

- adjusted the patches to account for sequencer_entrust() having been
  removed from the prepare-sequencer patch series by request of Junio.

- moved the introduction of write_message_gently() into the patch
  introducing its first usage, i.e. the support for the 'edit' command.

- adjusted some indentations

- prevented an write_in_full() from being called after a failed open()

- inserted a few forgotten strbuf_release() calls


Johannes Schindelin (34):
  sequencer: support a new action: 'interactive rebase'
  sequencer (rebase -i): implement the 'noop' command
  sequencer (rebase -i): implement the 'edit' command
  sequencer (rebase -i): implement the 'exec' command
  sequencer (rebase -i): learn about the 'verbose' mode
  sequencer (rebase -i): write the 'done' file
  sequencer (rebase -i): add support for the 'fixup' and 'squash'
    commands
  sequencer (rebase -i): implement the short commands
  sequencer (rebase -i): write an author-script file
  sequencer (rebase -i): allow continuing with staged changes
  sequencer (rebase -i): remove CHERRY_PICK_HEAD when no longer needed
  sequencer (rebase -i): skip some revert/cherry-pick specific code path
  sequencer (rebase -i): the todo can be empty when continuing
  sequencer (rebase -i): update refs after a successful rebase
  sequencer (rebase -i): leave a patch upon error
  sequencer (rebase -i): implement the 'reword' command
  sequencer (rebase -i): allow fast-forwarding for edit/reword
  sequencer (rebase -i): refactor setting the reflog message
  sequencer (rebase -i): set the reflog message consistently
  sequencer (rebase -i): copy commit notes at end
  sequencer (rebase -i): record interrupted commits in rewritten, too
  sequencer (rebase -i): run the post-rewrite hook, if needed
  sequencer (rebase -i): respect the rebase.autostash setting
  sequencer (rebase -i): respect strategy/strategy_opts settings
  sequencer (rebase -i): allow rescheduling commands
  sequencer (rebase -i): implement the 'drop' command
  sequencer (rebase -i): differentiate between comments and 'noop'
  run_command_opt(): optionally hide stderr when the command succeeds
  sequencer (rebase -i): show only failed `git commit`'s output
  sequencer (rebase -i): show only failed cherry-picks' output
  sequencer (rebase -i): suggest --edit-todo upon unknown command
  sequencer (rebase -i): show the progress
  sequencer (rebase -i): write the progress into files
  sequencer (rebase -i): write out the final message

 run-command.c |   23 ++
 run-command.h |    1 +
 sequencer.c   | 1003 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 sequencer.h   |    4 +-
 4 files changed, 983 insertions(+), 48 deletions(-)


base-commit: 8d7a455ed52e2a96debc080dfc011b6bb00db5d2
Published-As: https://github.com/dscho/git/releases/tag/sequencer-i-v2
Fetch-It-Via: git fetch https://github.com/dscho/git sequencer-i-v2

Interdiff vs v1:

 diff --git a/sequencer.c b/sequencer.c
 index 6ca9d1e09d..41be4cde16 100644
 --- a/sequencer.c
 +++ b/sequencer.c
 @@ -125,7 +125,6 @@ static GIT_PATH_FUNC(rebase_path_autostash, "rebase-merge/autostash")
  static GIT_PATH_FUNC(rebase_path_strategy, "rebase-merge/strategy")
  static GIT_PATH_FUNC(rebase_path_strategy_opts, "rebase-merge/strategy_opts")
  
 -/* We will introduce the 'interactive rebase' mode later */
  static inline int is_rebase_i(const struct replay_opts *opts)
  {
  	return opts->action == REPLAY_INTERACTIVE_REBASE;
 @@ -259,13 +258,13 @@ static const char *action_name(const struct replay_opts *opts)
  {
  	switch (opts->action) {
  	case REPLAY_REVERT:
 -		return "revert";
 +		return N_("revert");
  	case REPLAY_PICK:
 -		return "cherry-pick";
 +		return N_("cherry-pick");
  	case REPLAY_INTERACTIVE_REBASE:
 -		return "rebase -i";
 +		return N_("rebase -i");
  	}
 -	die("Unknown action: %d", opts->action);
 +	die(_("Unknown action: %d"), opts->action);
  }
  
  struct commit_message {
 @@ -548,6 +547,7 @@ static int write_author_script(const char *message)
  {
  	struct strbuf buf = STRBUF_INIT;
  	const char *eol;
 +	int res;
  
  	for (;;)
  		if (!*message || starts_with(message, "\n")) {
 @@ -585,8 +585,9 @@ static int write_author_script(const char *message)
  			strbuf_addch(&buf, *(message++));
  		else
  			strbuf_addf(&buf, "'\\\\%c'", *(message++));
 -	strbuf_addstr(&buf, "'\n");
 -	return write_message(&buf, rebase_path_author_script());
 +	res = write_message(buf.buf, buf.len, rebase_path_author_script(), 1);
 +	strbuf_release(&buf);
 +	return res;
  }
  
  /*
 @@ -771,16 +772,25 @@ static int allow_empty(struct replay_opts *opts, struct commit *commit)
  		return 1;
  }
  
 +/*
 + * Note that ordering matters in this enum. Not only must it match the mapping
 + * below, it is also divided into several sections that matter.  When adding
 + * new commands, make sure you add it in the right section.
 + */
  enum todo_command {
 +	/* commands that handle commits */
  	TODO_PICK = 0,
  	TODO_REVERT,
  	TODO_EDIT,
  	TODO_REWORD,
  	TODO_FIXUP,
  	TODO_SQUASH,
 +	/* commands that do something else than handling a single commit */
  	TODO_EXEC,
 +	/* commands that do nothing but are counted for reporting progress */
  	TODO_NOOP,
  	TODO_DROP,
 +	/* comments (not counted for reporting progress) */
  	TODO_COMMENT
  };
  
 @@ -812,47 +822,34 @@ static int is_fixup(enum todo_command command)
  	return command == TODO_FIXUP || command == TODO_SQUASH;
  }
  
 -static const char *nth_for_number(int n)
 -{
 -	int n1 = n % 10, n10 = n % 100;
 -
 -	if (n1 == 1 && n10 != 11)
 -		return "st";
 -	if (n1 == 2 && n10 != 12)
 -		return "nd";
 -	if (n1 == 3 && n10 != 13)
 -		return "rd";
 -	return "th";
 -}
 -
  static int update_squash_messages(enum todo_command command,
  		struct commit *commit, struct replay_opts *opts)
  {
  	struct strbuf buf = STRBUF_INIT;
 -	int count;
 +	int count, res;
  	const char *message, *body;
  
  	if (file_exists(rebase_path_squash_msg())) {
  		char *p, *p2;
  
  		if (strbuf_read_file(&buf, rebase_path_squash_msg(), 2048) <= 0)
 -			return error("Could not read %s",
 +			return error(_("could not read '%s'"),
  				rebase_path_squash_msg());
  
 -		if (buf.buf[0] == '\n' || !skip_prefix(buf.buf + 1,
 -				" This is a combination of ",
 -				(const char **)&p))
 -			return error("Unexpected 1st line of squash message:\n"
 -				"\n\t%.*s",
 -				(int)(strchrnul(buf.buf, '\n') - buf.buf),
 -				buf.buf);
 +		if (buf.buf[0] != comment_line_char ||
 +		    !skip_prefix(buf.buf + 1, " This is a combination of ",
 +				 (const char **)&p))
 +			return error(_("unexpected 1st line of squash message:"
 +				       "\n\n\t%.*s"),
 +				     (int)(strchrnul(buf.buf, '\n') - buf.buf),
 +				     buf.buf);
  		count = strtol(p, &p2, 10);
  
  		if (count < 1 || *p2 != ' ')
 -			return error("Invalid 1st line of squash message:\n"
 -				"\n\t%.*s",
 -				(int)(strchrnul(buf.buf, '\n') - buf.buf),
 -				buf.buf);
 +			return error(_("invalid 1st line of squash message:\n"
 +				       "\n\t%.*s"),
 +				     (int)(strchrnul(buf.buf, '\n') - buf.buf),
 +				     buf.buf);
  
  		sprintf((char *)p, "%d", ++count);
  		if (!*p2)
 @@ -868,32 +865,33 @@ static int update_squash_messages(enum todo_command command,
  		const char *head_message, *body;
  
  		if (get_sha1("HEAD", head))
 -			return error("Need a HEAD to fixup");
 +			return error(_("need a HEAD to fixup"));
  		if (!(head_commit = lookup_commit_reference(head)))
 -			return error("Could not read HEAD");
 +			return error(_("could not read HEAD"));
  		if (!(head_message = get_commit_buffer(head_commit, NULL)))
 -			return error("Could not read HEAD's commit message");
 +			return error(_("could not read HEAD's commit message"));
  
  		body = strstr(head_message, "\n\n");
  		if (!body)
  			body = "";
  		else
  			body = skip_blank_lines(body + 2);
 -		if (write_file_gently(rebase_path_fixup_msg(), body, 0))
 -			return error("Cannot write %s",
 -				rebase_path_fixup_msg());
 +		if (write_message(body, strlen(body),
 +				  rebase_path_fixup_msg(), 0))
 +			return error(_("cannot write '%s'"),
 +				     rebase_path_fixup_msg());
  
  		count = 2;
 -		strbuf_addf(&buf, "%c This is a combination of 2 commits.\n"
 -			"%c The first commit's message is:\n\n%s",
 -			comment_line_char, comment_line_char, body);
 +		strbuf_addf(&buf, _("%c This is a combination of 2 commits.\n"
 +				    "%c The first commit's message is:\n\n%s"),
 +			    comment_line_char, comment_line_char, body);
  
  		unuse_commit_buffer(head_commit, head_message);
  	}
  
  	if (!(message = get_commit_buffer(commit, NULL)))
 -		return error("Could not read commit message of %s",
 -			oid_to_hex(&commit->object.oid));
 +		return error(_("could not read commit message of %s"),
 +			     oid_to_hex(&commit->object.oid));
  	body = strstr(message, "\n\n");
  	if (!body)
  		body = "";
 @@ -902,21 +900,23 @@ static int update_squash_messages(enum todo_command command,
  
  	if (command == TODO_SQUASH) {
  		unlink(rebase_path_fixup_msg());
 -		strbuf_addf(&buf, "\n%c This is the %d%s commit message:\n\n%s",
 -			comment_line_char,
 -			count, nth_for_number(count), body);
 +		strbuf_addf(&buf, _("\n%c This is the commit message #%d:\n"
 +				    "\n%s"),
 +			    comment_line_char, count, body);
  	}
  	else if (command == TODO_FIXUP) {
 -		strbuf_addf(&buf,
 -			"\n%c The %d%s commit message will be skipped:\n\n",
 -			comment_line_char, count, nth_for_number(count));
 +		strbuf_addf(&buf, _("\n%c The commit message #%d "
 +				    "will be skipped:\n\n"),
 +			    comment_line_char, count);
  		strbuf_add_commented_lines(&buf, body, strlen(body));
  	}
  	else
 -		return error("Unknown command: %d", command);
 +		return error(_("unknown command: %d"), command);
  	unuse_commit_buffer(commit, message);
  
 -	return write_message(&buf, rebase_path_squash_msg());
 +	res = write_message(buf.buf, buf.len, rebase_path_squash_msg(), 0);
 +	strbuf_release(&buf);
 +	return res;
  }
  
  static void flush_rewritten_pending(void) {
 @@ -940,6 +940,7 @@ static void flush_rewritten_pending(void) {
  		fclose(out);
  		unlink(rebase_path_rewritten_pending());
  	}
 +	strbuf_release(&buf);
  }
  
  static void record_in_rewritten(struct object_id *oid,
 @@ -1013,7 +1014,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
  		parent = commit->parents->item;
  
  	if (get_message(commit, &msg) != 0)
 -		return error(_("Cannot get commit message for %s"),
 +		return error(_("cannot get commit message for %s"),
  			oid_to_hex(&commit->object.oid));
  
  	if (opts->allow_ff && !is_fixup(command) &&
 @@ -1021,7 +1022,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
  	     (!parent && unborn))) {
  		if (is_rebase_i(opts))
  			write_author_script(msg.message);
 -		res |= fast_forward_to(commit->object.oid.hash, head, unborn,
 +		res = fast_forward_to(commit->object.oid.hash, head, unborn,
  			opts);
  		if (res || command != TODO_REWORD)
  			goto leave;
 @@ -1100,8 +1101,8 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
  			const char *dest = git_path("SQUASH_MSG");
  			unlink(dest);
  			if (copy_file(dest, rebase_path_squash_msg(), 0666))
 -				return error("Could not rename %s to "
 -					"%s", rebase_path_squash_msg(), dest);
 +				return error(_("could not rename '%s' to '%s'"),
 +					     rebase_path_squash_msg(), dest);
  			unlink(git_path("MERGE_MSG"));
  			msg_file = dest;
  			edit = 1;
 @@ -1109,7 +1110,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
  	}
  
  	if (is_rebase_i(opts) && write_author_script(msg.message) < 0)
 -		res |= -1;
 +		res = -1;
  	else if (!opts->strategy || !strcmp(opts->strategy, "recursive") || command == TODO_REVERT) {
  		res = do_recursive_merge(base, next, base_label, next_label,
  					 head, &msgbuf, opts);
 @@ -1166,8 +1167,8 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
  	}
  	if (!opts->no_commit)
  fast_forward_edit:
 -		res |= sequencer_commit(msg_file, opts, allow, edit, amend,
 -			cleanup_commit_message);
 +		res = run_git_commit(msg_file, opts, allow, edit, amend,
 +				     cleanup_commit_message);
  
  	if (!res && final_fixup) {
  		unlink(rebase_path_fixup_msg());
 @@ -1317,7 +1318,7 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
  static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
  {
  	struct todo_item *item;
 -	char *p = buf;
 +	char *p = buf, *next_p;
  	int i, res = 0, fixup_okay = file_exists(rebase_path_done());
  
  	for (i = 1; *p; i++, p = next_p) {
 @@ -1335,15 +1336,16 @@ static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
  				i, (int)(eol - p), p);
  			item->command = TODO_NOOP;
  		}
 +
  		if (fixup_okay)
  			; /* do nothing */
  		else if (is_fixup(item->command))
 -			return error("Cannot '%s' without a previous commit",
 +			return error(_("cannot '%s' without a previous commit"),
  				command_to_string(item->command));
  		else if (item->command < TODO_NOOP)
  			fixup_okay = 1;
 -		p = *eol ? eol + 1 : eol;
  	}
 +
  	return res;
  }
  
 @@ -1377,13 +1379,14 @@ static int read_populate_todo(struct todo_list *todo_list,
  	res = parse_insn_buffer(todo_list->buf.buf, todo_list);
  	if (res) {
  		if (is_rebase_i(opts))
 -			return error("Please fix this using "
 -				"'git rebase --edit-todo'.");
 -		return error(_("Unusable instruction sheet: %s"), todo_file);
 +			return error(_("please fix this using "
 +				       "'git rebase --edit-todo'."));
 +		return error(_("unusable instruction sheet: '%s'"), todo_file);
  	}
 +
  	if (!todo_list->nr &&
  	    (!is_rebase_i(opts) || !file_exists(rebase_path_done())))
 -		return error(_("No commits parsed."));
 +		return error(_("no commits parsed."));
  
  	if (!is_rebase_i(opts)) {
  		enum todo_command valid =
 @@ -1408,10 +1411,10 @@ static int read_populate_todo(struct todo_list *todo_list,
  			todo_list->done_nr = count_commands(&done);
  		else
  			todo_list->done_nr = 0;
 -		todo_list_release(&done);
  
  		todo_list->total_nr = todo_list->done_nr
  			+ count_commands(todo_list);
 +		todo_list_release(&done);
  
  		if (f) {
  			fprintf(f, "%d\n", todo_list->total_nr);
 @@ -1467,6 +1470,26 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
  	return 0;
  }
  
 +static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
 +{
 +	int i;
 +
 +	strbuf_reset(buf);
 +	if (!read_oneliner(buf, rebase_path_strategy(), 0))
 +		return;
 +	opts->strategy = strbuf_detach(buf, NULL);
 +	if (!read_oneliner(buf, rebase_path_strategy_opts(), 0))
 +		return;
 +
 +	opts->xopts_nr = split_cmdline(buf->buf, (const char ***)&opts->xopts);
 +	for (i = 0; i < opts->xopts_nr; i++) {
 +		const char *arg = opts->xopts[i];
 +
 +		skip_prefix(arg, "--", &arg);
 +		opts->xopts[i] = xstrdup(arg);
 +	}
 +}
 +
  static int read_populate_opts(struct replay_opts *opts)
  {
  	if (is_rebase_i(opts)) {
 @@ -1480,30 +1503,12 @@ static int read_populate_opts(struct replay_opts *opts)
  				opts->gpg_sign = xstrdup(buf.buf + 2);
  			}
  		}
 -		strbuf_release(&buf);
  
  		if (file_exists(rebase_path_verbose()))
  			opts->verbose = 1;
  
 -		if (read_oneliner(&buf, rebase_path_strategy(), 0)) {
 -			opts->strategy =
 -				sequencer_entrust(opts,
 -						  strbuf_detach(&buf, NULL));
 -			if (read_oneliner(&buf,
 -					  rebase_path_strategy_opts(), 0)) {
 -				int i;
 -				opts->xopts_nr = split_cmdline(buf.buf,
 -					&opts->xopts);
 -				for (i = 0; i < opts->xopts_nr; i++)
 -					skip_prefix(opts->xopts[i], "--",
 -						    &opts->xopts[i]);
 -				if (opts->xopts_nr)
 -					sequencer_entrust(opts,
 -						strbuf_detach(&buf, NULL));
 -				else
 -					strbuf_release(&buf);
 -			}
 -		}
 +		read_strategy_opts(opts, &buf);
 +		strbuf_release(&buf);
  
  		return 0;
  	}
 @@ -1527,7 +1532,7 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
  {
  	enum todo_command command = opts->action == REPLAY_PICK ?
  		TODO_PICK : TODO_REVERT;
 -	const char *command_string = todo_command_strings[command];
 +	const char *command_string = todo_command_info[command].str;
  	struct commit *commit;
  
  	if (prepare_revs(opts))
 @@ -1681,12 +1686,15 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
  		int prev_offset = !next ? 0 :
  			todo_list->items[next - 1].offset_in_buf;
  
 -		if (offset > prev_offset && write_in_full(fd,
 -				todo_list->buf.buf + prev_offset,
 -				offset - prev_offset) < 0)
 -			return error(_("Could not write to %s (%s)"),
 -				done_path, strerror(errno));
 -		close(fd);
 +		if (fd >= 0 && offset > prev_offset &&
 +		    write_in_full(fd, todo_list->buf.buf + prev_offset,
 +				  offset - prev_offset) < 0) {
 +			close(fd);
 +			return error_errno(_("could not write to '%s'"),
 +					   done_path);
 +		}
 +		if (fd >= 0)
 +			close(fd);
  	}
  	return 0;
  }
 @@ -1730,11 +1738,11 @@ static int make_patch(struct commit *commit, struct replay_opts *opts)
  {
  	struct strbuf buf = STRBUF_INIT;
  	struct rev_info log_tree_opt;
 -	const char *commit_buffer = get_commit_buffer(commit, NULL), *subject;
 +	const char *commit_buffer = get_commit_buffer(commit, NULL), *subject, *p;
  	int res = 0;
  
 -	if (write_file_gently(rebase_path_stopped_sha(),
 -			      short_commit_name(commit), 1) < 0)
 +	p = short_commit_name(commit);
 +	if (write_message(p, strlen(p), rebase_path_stopped_sha(), 1) < 0)
  		return -1;
  
  	strbuf_addf(&buf, "%s/patch", get_dir(opts));
 @@ -1748,7 +1756,7 @@ static int make_patch(struct commit *commit, struct replay_opts *opts)
  	log_tree_opt.diffopt.file = fopen(buf.buf, "w");
  	log_tree_opt.diffopt.use_color = GIT_COLOR_NEVER;
  	if (!log_tree_opt.diffopt.file)
 -		res |= error_errno("could not open '%s'", buf.buf);
 +		res |= error_errno(_("could not open '%s'"), buf.buf);
  	else {
  		res |= log_tree_commit(&log_tree_opt, commit);
  		fclose(log_tree_opt.diffopt.file);
 @@ -1758,7 +1766,7 @@ static int make_patch(struct commit *commit, struct replay_opts *opts)
  	strbuf_addf(&buf, "%s/message", get_dir(opts));
  	if (!file_exists(buf.buf)) {
  		find_commit_subject(commit_buffer, &subject);
 -		res |= write_file_gently(buf.buf, subject, 1);
 +		res |= write_message(subject, strlen(subject), buf.buf, 1);
  		unuse_commit_buffer(commit, commit_buffer);
  	}
  	strbuf_release(&buf);
 @@ -1769,11 +1777,13 @@ static int make_patch(struct commit *commit, struct replay_opts *opts)
  static int intend_to_amend(void)
  {
  	unsigned char head[20];
 +	char *p;
  
  	if (get_sha1("HEAD", head))
 -		return error("Cannot read HEAD");
 +		return error(_("cannot read HEAD"));
  
 -	return write_file_gently(rebase_path_amend(), sha1_to_hex(head), 1);
 +	p = sha1_to_hex(head);
 +	return write_message(p, strlen(p), rebase_path_amend(), 1);
  }
  
  static int error_with_patch(struct commit *commit,
 @@ -1806,13 +1816,13 @@ static int error_failed_squash(struct commit *commit,
  	struct replay_opts *opts, int subject_len, const char *subject)
  {
  	if (rename(rebase_path_squash_msg(), rebase_path_message()))
 -		return error("Could not rename %s to %s",
 +		return error(_("could not rename '%s' to '%s'"),
  			rebase_path_squash_msg(), rebase_path_message());
  	unlink(rebase_path_fixup_msg());
  	unlink(git_path("MERGE_MSG"));
  	if (copy_file(git_path("MERGE_MSG"), rebase_path_message(), 0666))
 -		return error("Could not copy %s to %s", rebase_path_message(),
 -			git_path("MERGE_MSG"));
 +		return error(_("could not copy '%s' to '%s'"),
 +			     rebase_path_message(), git_path("MERGE_MSG"));
  	return error_with_patch(commit, subject, subject_len, opts, 1, 0);
  }
  
 @@ -1827,30 +1837,30 @@ static int do_exec(const char *command_line)
  
  	/* force re-reading of the cache */
  	if (discard_cache() < 0 || read_cache() < 0)
 -		return error(_("Could not read index"));
 +		return error(_("could not read index"));
  
  	dirty = require_clean_work_tree("rebase", NULL, 1, 1);
  
  	if (status) {
 -		warning("Execution failed: %s\n%s"
 -			"You can fix the problem, and then run\n"
 -			"\n"
 -			"  git rebase --continue\n"
 -			"\n",
 +		warning(_("execution failed: %s\n%s"
 +			  "You can fix the problem, and then run\n"
 +			  "\n"
 +			  "  git rebase --continue\n"
 +			  "\n"),
  			command_line,
 -			dirty ? "and made changes to the index and/or the "
 -				"working tree\n" : "");
 +			dirty ? N_("and made changes to the index and/or the "
 +				"working tree\n") : "");
  		if (status == 127)
  			/* command not found */
  			status = 1;
  	}
  	else if (dirty) {
 -		warning("Execution succeeded: %s\nbut "
 -			"left changes to the index and/or the working tree\n"
 -			"Commit or stash your changes, and then run\n"
 -			"\n"
 -			"  git rebase --continue\n"
 -			"\n", command_line);
 +		warning(_("execution succeeded: %s\nbut "
 +			  "left changes to the index and/or the working tree\n"
 +			  "Commit or stash your changes, and then run\n"
 +			  "\n"
 +			  "  git rebase --continue\n"
 +			  "\n"), command_line);
  		status = 1;
  	}
  
 @@ -1912,7 +1922,7 @@ static int apply_autostash(struct replay_opts *opts)
  		argv_array_push(&store.args, "-q");
  		argv_array_push(&store.args, stash_sha1.buf);
  		if (run_command(&store))
 -			ret = error(_("Cannot store %s"), stash_sha1.buf);
 +			ret = error(_("cannot store %s"), stash_sha1.buf);
  		else
  			printf(_("Applying autostash resulted in conflicts.\n"
  				"Your changes are safe in the stash.\n"
 @@ -1995,7 +2005,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
  			if (item->command == TODO_EDIT) {
  				struct commit *commit = item->commit;
  				if (!res)
 -					warning("Stopped at %s... %.*s",
 +					warning(_("stopped at %s... %.*s"),
  						short_commit_name(commit),
  						item->arg_len, item->arg);
  				return error_with_patch(commit,
 @@ -2025,7 +2035,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
  			*end_of_arg = saved;
  		}
  		else if (item->command < TODO_NOOP)
 -			return error("Unknown command %d", item->command);
 +			return error(_("unknown command %d"), item->command);
  
  		todo_list->current++;
  		if (res)
 @@ -2046,22 +2056,22 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
  			unsigned char head[20], orig[20];
  
  			if (get_sha1("HEAD", head))
 -				return error("Cannot read HEAD");
 +				return error(_("cannot read HEAD"));
  			if (!read_oneliner(&buf, rebase_path_orig_head(), 0) ||
  					get_sha1_hex(buf.buf, orig))
 -				return error("Could not read orig-head");
 +				return error(_("could not read orig-head"));
  			if (!read_oneliner(&buf, rebase_path_onto(), 0))
 -				return error("Could not read 'onto'");
 +				return error(_("could not read 'onto'"));
  			msg = reflog_message(opts, "finish", "%s onto %s",
  				head_ref.buf, buf.buf);
  			if (update_ref(msg, head_ref.buf, head, orig,
  					REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
 -				return error("Could not update %s",
 +				return error(_("could not update %s"),
  					head_ref.buf);
  			msg = reflog_message(opts, "finish", "returning to %s",
  				head_ref.buf);
  			if (create_symref("HEAD", head_ref.buf, msg))
 -				return error("Could not update HEAD to %s",
 +				return error(_("could not update HEAD to %s"),
  					head_ref.buf);
  			strbuf_reset(&buf);
  		}
 @@ -2072,7 +2082,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
  			};
  
  			if (!read_oneliner(&buf, rebase_path_orig_head(), 0))
 -				return error("Could not read %s",
 +				return error(_("could not read '%s'"),
  					rebase_path_orig_head());
  			strbuf_addstr(&buf, "..HEAD");
  			argv[2] = buf.buf;
 @@ -2099,6 +2109,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
  
  				hook.in = open(rebase_path_rewritten_list(),
  					O_RDONLY);
 +				hook.stdout_to_stderr = 1;
  				argv_array_push(&hook.args, post_rewrite_hook);
  				argv_array_push(&hook.args, "rebase");
  				/* we don't care if this hook failed */
 @@ -2136,12 +2147,12 @@ static int commit_staged_changes(struct replay_opts *opts)
  	int amend = 0;
  
  	if (has_unstaged_changes(1))
 -		return error(_("Cannot rebase: You have unstaged changes."));
 +		return error(_("cannot rebase: You have unstaged changes."));
  	if (!has_uncommitted_changes(0)) {
  		const char *cherry_pick_head = git_path("CHERRY_PICK_HEAD");
  
  		if (file_exists(cherry_pick_head) && unlink(cherry_pick_head))
 -			return error("Could not remove CHERRY_PICK_HEAD");
 +			return error(_("could not remove CHERRY_PICK_HEAD"));
  		return 0;
  	}
  
 @@ -2150,23 +2161,24 @@ static int commit_staged_changes(struct replay_opts *opts)
  		unsigned char head[20], to_amend[20];
  
  		if (get_sha1("HEAD", head))
 -			return error("Cannot amend non-existing commit");
 +			return error(_("cannot amend non-existing commit"));
  		if (!read_oneliner(&rev, rebase_path_amend(), 0))
 -			return error("Invalid file: %s", rebase_path_amend());
 +			return error(_("invalid file: '%s'"), rebase_path_amend());
  		if (get_sha1_hex(rev.buf, to_amend))
 -			return error("Invalid contents: %s",
 +			return error(_("invalid contents: '%s'"),
  				rebase_path_amend());
  		if (hashcmp(head, to_amend))
 -			return error("\nYou have uncommitted changes in your "
 -				"working tree. Please, commit them\nfirst and "
 -				"then run 'git rebase --continue' again.");
 +			return error(_("\nYou have uncommitted changes in your "
 +				       "working tree. Please, commit them\n"
 +				       "first and then run 'git rebase "
 +				       "--continue' again."));
  
  		strbuf_release(&rev);
  		amend = 1;
  	}
  
 -	if (sequencer_commit(rebase_path_message(), opts, 1, 1, amend, 0))
 -		return error("Could not commit staged changes.");
 +	if (run_git_commit(rebase_path_message(), opts, 1, 1, amend, 0))
 +		return error(_("could not commit staged changes."));
  	unlink(rebase_path_amend());
  	return 0;
  }
 @@ -2194,23 +2206,23 @@ int sequencer_continue(struct replay_opts *opts)
  		/* Verify that the conflict has been resolved */
  		if (file_exists(git_path_cherry_pick_head()) ||
  		    file_exists(git_path_revert_head())) {
 -			int ret = continue_single_pick();
 -			if (ret)
 -				return ret;
 +			res = continue_single_pick();
 +			if (res)
 +				goto release_todo_list;
 +		}
 +		if (index_differs_from("HEAD", 0, 0)) {
 +			res = error_dirty_index(opts);
 +			goto release_todo_list;
  		}
 -		if (index_differs_from("HEAD", 0))
 -			return error_dirty_index(opts);
  		todo_list.current++;
  	}
  	else if (file_exists(rebase_path_stopped_sha())) {
  		struct strbuf buf = STRBUF_INIT;
  		struct object_id oid;
  
 -		if (read_oneliner(&buf, rebase_path_stopped_sha(), 1)) {
 -			if (!get_sha1_committish(buf.buf, oid.hash))
 -				record_in_rewritten(&oid,
 -						peek_command(&todo_list, 0));
 -		}
 +		if (read_oneliner(&buf, rebase_path_stopped_sha(), 1) &&
 +		    !get_sha1_committish(buf.buf, oid.hash))
 +			record_in_rewritten(&oid, peek_command(&todo_list, 0));
  		strbuf_release(&buf);
  	}
  

-- 
2.11.0.rc3.windows.1

