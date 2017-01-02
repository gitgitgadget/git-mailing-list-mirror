Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C342205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755521AbdABP0T (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:26:19 -0500
Received: from mout.gmx.net ([212.227.15.19]:58902 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753185AbdABP0R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:26:17 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0McmS9-1c6g6V0jMv-00HxhO; Mon, 02
 Jan 2017 16:26:02 +0100
Date:   Mon, 2 Jan 2017 16:25:59 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 00/38] Teach the sequencer to act as rebase -i's backend
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hQ/i94oiX3w6z+5rZydsnHPdd3ACvfWspvjHZdBezlgS4NTf+WN
 RjI0JKHmSffnZQeBBYkSn8r/4lWB2HRcqtU9NFk4E+r2OHmroX92vlWjUd+kFmmje1/Dvw+
 RJO/L472xBcn1yvBUivKohw2cMrYJjO6aafAhkAgxu7QQ4TY0efqCv4KSxu00WpFj8mDtey
 AYai/lqCwHLl9mcU1eLCg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:waYRixZ1hEI=:Y+aWcnCyP7VRkRKZB0vqDu
 mQtZgKeE9g7jdu7ZuabcFxTaG5oxu1Knig0h/yg3NAUGBMOm8tC9PS3IlUCmkOA8KGlXJ6mTl
 6DKENRmgiqUYI4K+MttkkTukK/HpsymmclBfJvTwiyIbZ6LWXc6K5vjvt/8BnPjBn+A0ucknt
 TpTxzz5It7DI64nu89m/PKW95gQFqPJDBVfSuhSnONgYrkIrhmqNUxutW+zXS8/9gNv5tD+qE
 u0ju84vY3Uejj2rWGtpUtgXErkhQ8MGerVYT3syjGpJ3OfN7DFGYJr+YnEUKrE50o7A3OaH7o
 WQQ6LRkfTQNIws+221Zcj1Pjt+m4O59Tbd87eIsW5eGEtLrYZUcn8ORw600/vgfeJV1ssU9bk
 Q9ChRgPbVf+riAL32retxFmlejwb3liY+Gt7lIW2H1PbDHedKKpJD+06xoOMgY8AgrbVXqkMz
 Pd23OtkLqcn7MCTPzXgiUGMHZlp7itXCETCn2vL4OT+Oh5R0jugRkSBcXHo2ktiBVcxdEfCzY
 89cYHoPFlUxL0ziAv+TAFkXpL7MltCskL7eHykifROaj8I5+1I/GqcSviyW5dG2v5Fwxvt3au
 pnvmbEr742uXkVLx0VuZJLWyhFA/+14orZtsJjmSUS4P7IKebkP35d6AyEIhachVhQHZG8EPO
 PsM0IMfRat6yRAKpMqyTX3CajXemaKHwuKzGsG2W4Szy+jeXMfDndwR85tJcY8E2STFK0GyUy
 aqxYnDUC1ekVgukQJ5yHOxemOGvfD0muUacWUWp6a2FgHQjlqDVL3GBiJPyqPLr3ICR1hkWft
 iaxMQMo
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

Changes since v2:

- fixed a TRANSLATORS: comment

- added a comment to clarify why save_todo() does not write the current
  command to git-rebase-todo

- fixed the comment for "stopped-sha" that said that a long commit name
  is stored in that file, when it is in fact an abbreviated one

- consistently put the "else" keyword on the same line as the preceding
  closing brace, if any (this adds two patches to the already large
  patch series, sorry)

- completely revamped the update_squash_messages() function to make it
  more obvious why it does not overflow its buffer, and to fix it when
  using it with localised messages

- now the sequencer code uses find_commit_subject() consistently to find
  the commit message (it does not use the subject's length returned by
  the find_commit_subject() function, of course); this adds yet another
  patch to this already large patch series, sorry.

- introduced an is_noop() function (as opposed to testing <= TODO_NOOP
  manually) to make the code less magic.

- fixed two potential leaks of get_commit_buffer()'s returned buffer

- fixed leaks in the error code paths when trying to update the ref at
  the end

- renamed read_author_script() into read_env_script() to reflect that
  it would accept any environment setting, and made it much more
  readable

- completely reworked the strategy how to suppress the output of
  successful cherry-picks: instead of introducing
  RUN_HIDE_STDERR_ON_SUCCESS, the code now uses pipe_command() to catch
  the output itself, so that it can be shown in case of error

- replaced a spawned `diff-tree` command by code using the diff functions
  directly


Johannes Schindelin (38):
  sequencer: avoid unnecessary curly braces
  sequencer: move "else" keyword onto the same line as preceding brace
  sequencer: use a helper to find the commit message
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
  sequencer: make reading author-script more elegant
  sequencer: use run_command() directly
  sequencer (rebase -i): show only failed `git commit`'s output
  sequencer (rebase -i): show only failed cherry-picks' output
  sequencer (rebase -i): suggest --edit-todo upon unknown command
  sequencer (rebase -i): show the progress
  sequencer (rebase -i): write the progress into files
  sequencer (rebase -i): write out the final message

 sequencer.c | 1105 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 sequencer.h |    4 +-
 2 files changed, 1013 insertions(+), 96 deletions(-)


base-commit: e05806da9ec4aff8adfed142ab2a2b3b02e33c8c
Published-As: https://github.com/dscho/git/releases/tag/sequencer-i-v3
Fetch-It-Via: git fetch https://github.com/dscho/git sequencer-i-v3

Interdiff vs v2:

 diff --git a/run-command.c b/run-command.c
 index 5bb957afdd..ca905a9e80 100644
 --- a/run-command.c
 +++ b/run-command.c
 @@ -589,29 +589,6 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
  	cmd.clean_on_exit = opt & RUN_CLEAN_ON_EXIT ? 1 : 0;
  	cmd.dir = dir;
  	cmd.env = env;
 -
 -	if (opt & RUN_HIDE_STDERR_ON_SUCCESS) {
 -		struct strbuf buf = STRBUF_INIT;
 -		int res;
 -
 -		cmd.err = -1;
 -		if (start_command(&cmd) < 0)
 -			return -1;
 -
 -		if (strbuf_read(&buf, cmd.err, 0) < 0) {
 -			close(cmd.err);
 -			finish_command(&cmd); /* throw away exit code */
 -			return -1;
 -		}
 -
 -		close(cmd.err);
 -		res = finish_command(&cmd);
 -		if (res)
 -			fputs(buf.buf, stderr);
 -		strbuf_release(&buf);
 -		return res;
 -	}
 -
  	return run_command(&cmd);
  }
  
 diff --git a/run-command.h b/run-command.h
 index 65a21ddd4e..dd1c78c28d 100644
 --- a/run-command.h
 +++ b/run-command.h
 @@ -72,7 +72,6 @@ extern int run_hook_ve(const char *const *env, const char *name, va_list args);
  #define RUN_SILENT_EXEC_FAILURE 8
  #define RUN_USING_SHELL 16
  #define RUN_CLEAN_ON_EXIT 32
 -#define RUN_HIDE_STDERR_ON_SUCCESS 64
  int run_command_v_opt(const char **argv, int opt);
  
  /*
 diff --git a/sequencer.c b/sequencer.c
 index c0aeb4f5f7..0e7d2ca5c8 100644
 --- a/sequencer.c
 +++ b/sequencer.c
 @@ -102,7 +102,7 @@ static GIT_PATH_FUNC(rebase_path_author_script, "rebase-merge/author-script")
  static GIT_PATH_FUNC(rebase_path_amend, "rebase-merge/amend")
  /*
   * When we stop at a given patch via the "edit" command, this file contains
 - * the long commit name of the corresponding patch.
 + * the abbreviated commit name of the corresponding patch.
   */
  static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha")
  /*
 @@ -464,8 +464,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
  
  	if (active_cache_changed &&
  	    write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
 -		/*
 -		 * TRANSLATORS: %s will be "revert", "cherry-pick" or
 +		/* TRANSLATORS: %s will be "revert", "cherry-pick" or
  		 * "rebase -i".
  		 */
  		return error(_("%s: Unable to write new index file"),
 @@ -524,8 +523,7 @@ static int write_author_script(const char *message)
  			/* Missing 'author' line? */
  			unlink(rebase_path_author_script());
  			return 0;
 -		}
 -		else if (skip_prefix(message, "author ", &message))
 +		} else if (skip_prefix(message, "author ", &message))
  			break;
  		else if ((eol = strchr(message, '\n')))
  			message = eol + 1;
 @@ -560,18 +558,17 @@ static int write_author_script(const char *message)
  }
  
  /*
 - * Read the author-script file into an environment block, ready for use in
 - * run_command(), that can be free()d afterwards.
 + * Read a list of environment variable assignments (such as the author-script
 + * file) into an environment block. Returns -1 on error, 0 otherwise.
   */
 -static char **read_author_script(void)
 +static int read_env_script(struct argv_array *env)
  {
  	struct strbuf script = STRBUF_INIT;
  	int i, count = 0;
 -	char *p, *p2, **env;
 -	size_t env_size;
 +	char *p, *p2;
  
  	if (strbuf_read_file(&script, rebase_path_author_script(), 256) <= 0)
 -		return NULL;
 +		return -1;
  
  	for (p = script.buf; *p; p++)
  		if (skip_prefix(p, "'\\\\''", (const char **)&p2))
 @@ -583,19 +580,12 @@ static char **read_author_script(void)
  			count++;
  		}
  
 -	env_size = (count + 1) * sizeof(*env);
 -	strbuf_grow(&script, env_size);
 -	memmove(script.buf + env_size, script.buf, script.len);
 -	p = script.buf + env_size;
 -	env = (char **)strbuf_detach(&script, NULL);
 -
  	for (i = 0; i < count; i++) {
 -		env[i] = p;
 +		argv_array_push(env, p);
  		p += strlen(p) + 1;
  	}
 -	env[count] = NULL;
  
 -	return env;
 +	return 0;
  }
  
  static const char staged_changes_advice[] =
 @@ -628,19 +618,18 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
  			  int allow_empty, int edit, int amend,
  			  int cleanup_commit_message)
  {
 -	char **env = NULL;
 -	struct argv_array array;
 -	int opt = RUN_GIT_CMD, rc;
 +	struct child_process cmd = CHILD_PROCESS_INIT;
  	const char *value;
  
 +	cmd.git_cmd = 1;
 +
  	if (is_rebase_i(opts)) {
  		if (!edit) {
 -			opt |= RUN_COMMAND_STDOUT_TO_STDERR;
 -			opt |= RUN_HIDE_STDERR_ON_SUCCESS;
 +			cmd.stdout_to_stderr = 1;
 +			cmd.err = -1;
  		}
  
 -		env = read_author_script();
 -		if (!env) {
 +		if (read_env_script(&cmd.env_array)) {
  			const char *gpg_opt = gpg_sign_opt_quoted(opts);
  
  			return error(_(staged_changes_advice),
 @@ -648,39 +637,47 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
  		}
  	}
  
 -	argv_array_init(&array);
 -	argv_array_push(&array, "commit");
 -	argv_array_push(&array, "-n");
 +	argv_array_push(&cmd.args, "commit");
 +	argv_array_push(&cmd.args, "-n");
  
  	if (amend)
 -		argv_array_push(&array, "--amend");
 +		argv_array_push(&cmd.args, "--amend");
  	if (opts->gpg_sign)
 -		argv_array_pushf(&array, "-S%s", opts->gpg_sign);
 +		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
  	if (opts->signoff)
 -		argv_array_push(&array, "-s");
 +		argv_array_push(&cmd.args, "-s");
  	if (defmsg)
 -		argv_array_pushl(&array, "-F", defmsg, NULL);
 +		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
  	if (cleanup_commit_message)
 -		argv_array_push(&array, "--cleanup=strip");
 +		argv_array_push(&cmd.args, "--cleanup=strip");
  	if (edit)
 -		argv_array_push(&array, "-e");
 +		argv_array_push(&cmd.args, "-e");
  	else if (!cleanup_commit_message &&
  		 !opts->signoff && !opts->record_origin &&
  		 git_config_get_value("commit.cleanup", &value))
 -		argv_array_push(&array, "--cleanup=verbatim");
 +		argv_array_push(&cmd.args, "--cleanup=verbatim");
  
  	if (allow_empty)
 -		argv_array_push(&array, "--allow-empty");
 +		argv_array_push(&cmd.args, "--allow-empty");
  
  	if (opts->allow_empty_message)
 -		argv_array_push(&array, "--allow-empty-message");
 +		argv_array_push(&cmd.args, "--allow-empty-message");
  
 -	rc = run_command_v_opt_cd_env(array.argv, opt, NULL,
 -			(const char *const *)env);
 -	argv_array_clear(&array);
 -	free(env);
 +	if (cmd.err == -1) {
 +		/* hide stderr on success */
 +		struct strbuf buf = STRBUF_INIT;
 +		int rc = pipe_command(&cmd,
 +				      NULL, 0,
 +				      /* stdout is already redirected */
 +				      NULL, 0,
 +				      &buf, 0);
 +		if (rc)
 +			fputs(buf.buf, stderr);
 +		strbuf_release(&buf);
 +		return rc;
 +	}
  
 -	return rc;
 +	return run_command(&cmd);
  }
  
  static int is_original_commit_empty(struct commit *commit)
 @@ -786,6 +783,11 @@ static const char *command_to_string(const enum todo_command command)
  	die("Unknown command: %d", command);
  }
  
 +static int is_noop(const enum todo_command command)
 +{
 +	return TODO_NOOP <= command;
 +}
 +
  static int is_fixup(enum todo_command command)
  {
  	return command == TODO_FIXUP || command == TODO_SQUASH;
 @@ -799,36 +801,33 @@ static int update_squash_messages(enum todo_command command,
  	const char *message, *body;
  
  	if (file_exists(rebase_path_squash_msg())) {
 -		char *p, *p2;
 +		struct strbuf header = STRBUF_INIT;
 +		char *eol, *p;
  
  		if (strbuf_read_file(&buf, rebase_path_squash_msg(), 2048) <= 0)
  			return error(_("could not read '%s'"),
  				rebase_path_squash_msg());
  
 +		p = buf.buf + 1;
 +		eol = strchrnul(buf.buf, '\n');
  		if (buf.buf[0] != comment_line_char ||
 -		    !skip_prefix(buf.buf + 1, " This is a combination of ",
 -				 (const char **)&p))
 +		    (p += strcspn(p, "0123456789\n")) == eol)
  			return error(_("unexpected 1st line of squash message:"
  				       "\n\n\t%.*s"),
 -				     (int)(strchrnul(buf.buf, '\n') - buf.buf),
 -				     buf.buf);
 -		count = strtol(p, &p2, 10);
 +				     (int)(eol - buf.buf), buf.buf);
 +		count = strtol(p, NULL, 10);
  
 -		if (count < 1 || *p2 != ' ')
 +		if (count < 1)
  			return error(_("invalid 1st line of squash message:\n"
  				       "\n\t%.*s"),
 -				     (int)(strchrnul(buf.buf, '\n') - buf.buf),
 -				     buf.buf);
 -
 -		sprintf((char *)p, "%d", ++count);
 -		if (!*p2)
 -			*p2 = ' ';
 -		else {
 -			*(++p2) = 'c';
 -			strbuf_insert(&buf, p2 - buf.buf, " ", 1);
 -		}
 -	}
 -	else {
 +				     (int)(eol - buf.buf), buf.buf);
 +
 +		strbuf_addf(&header, "%c ", comment_line_char);
 +		strbuf_addf(&header,
 +			    _("This is a combination of %d commits."), ++count);
 +		strbuf_splice(&buf, 0, eol - buf.buf, header.buf, header.len);
 +		strbuf_release(&header);
 +	} else {
  		unsigned char head[20];
  		struct commit *head_commit;
  		const char *head_message, *body;
 @@ -840,20 +839,22 @@ static int update_squash_messages(enum todo_command command,
  		if (!(head_message = get_commit_buffer(head_commit, NULL)))
  			return error(_("could not read HEAD's commit message"));
  
 -		body = strstr(head_message, "\n\n");
 -		if (!body)
 -			body = "";
 -		else
 -			body = skip_blank_lines(body + 2);
 +		find_commit_subject(head_message, &body);
  		if (write_message(body, strlen(body),
 -				  rebase_path_fixup_msg(), 0))
 +				  rebase_path_fixup_msg(), 0)) {
 +			unuse_commit_buffer(head_commit, head_message);
  			return error(_("cannot write '%s'"),
  				     rebase_path_fixup_msg());
 +		}
  
  		count = 2;
 -		strbuf_addf(&buf, _("%c This is a combination of 2 commits.\n"
 -				    "%c The first commit's message is:\n\n%s"),
 -			    comment_line_char, comment_line_char, body);
 +		strbuf_addf(&buf, "%c ", comment_line_char);
 +		strbuf_addf(&buf, _("This is a combination of %d commits."),
 +			    count);
 +		strbuf_addf(&buf, "\n%c ", comment_line_char);
 +		strbuf_addstr(&buf, _("This is the 1st commit message:"));
 +		strbuf_addstr(&buf, "\n\n");
 +		strbuf_addstr(&buf, body);
  
  		unuse_commit_buffer(head_commit, head_message);
  	}
 @@ -861,25 +862,21 @@ static int update_squash_messages(enum todo_command command,
  	if (!(message = get_commit_buffer(commit, NULL)))
  		return error(_("could not read commit message of %s"),
  			     oid_to_hex(&commit->object.oid));
 -	body = strstr(message, "\n\n");
 -	if (!body)
 -		body = "";
 -	else
 -		body = skip_blank_lines(body + 2);
 +	find_commit_subject(message, &body);
  
  	if (command == TODO_SQUASH) {
  		unlink(rebase_path_fixup_msg());
 -		strbuf_addf(&buf, _("\n%c This is the commit message #%d:\n"
 -				    "\n%s"),
 -			    comment_line_char, count, body);
 -	}
 -	else if (command == TODO_FIXUP) {
 -		strbuf_addf(&buf, _("\n%c The commit message #%d "
 -				    "will be skipped:\n\n"),
 -			    comment_line_char, count);
 +		strbuf_addf(&buf, "\n%c ", comment_line_char);
 +		strbuf_addf(&buf, _("This is the commit message #%d:"), count);
 +		strbuf_addstr(&buf, "\n\n");
 +		strbuf_addstr(&buf, body);
 +	} else if (command == TODO_FIXUP) {
 +		strbuf_addf(&buf, "\n%c ", comment_line_char);
 +		strbuf_addf(&buf, _("The commit message #%d will be skipped:"),
 +			    count);
 +		strbuf_addstr(&buf, "\n\n");
  		strbuf_add_commented_lines(&buf, body, strlen(body));
 -	}
 -	else
 +	} else
  		return error(_("unknown command: %d"), command);
  	unuse_commit_buffer(commit, message);
  
 @@ -956,9 +953,8 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
  	}
  	discard_cache();
  
 -	if (!commit->parents) {
 +	if (!commit->parents)
  		parent = NULL;
 -	}
  	else if (commit->parents->next) {
  		/* Reverting or cherry-picking a merge commit */
  		int cnt;
 @@ -1036,14 +1032,9 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
  		next = commit;
  		next_label = msg.label;
  
 -		/*
 -		 * Append the commit log message to msgbuf; it starts
 -		 * after the tree, parent, author, committer
 -		 * information followed by "\n\n".
 -		 */
 -		p = strstr(msg.message, "\n\n");
 -		if (p)
 -			strbuf_addstr(&msgbuf, skip_blank_lines(p + 2));
 +		/* Append the commit log message to msgbuf. */
 +		if (find_commit_subject(msg.message, &p))
 +			strbuf_addstr(&msgbuf, p);
  
  		if (opts->record_origin) {
  			if (!has_conforming_footer(&msgbuf, NULL, 0))
 @@ -1065,8 +1056,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
  		else if (file_exists(rebase_path_fixup_msg())) {
  			cleanup_commit_message = 1;
  			msg_file = rebase_path_fixup_msg();
 -		}
 -		else {
 +		} else {
  			const char *dest = git_path("SQUASH_MSG");
  			unlink(dest);
  			if (copy_file(dest, rebase_path_squash_msg(), 0666))
 @@ -1241,8 +1231,7 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
  		if (skip_prefix(bol, todo_command_info[i].str, &bol)) {
  			item->command = i;
  			break;
 -		}
 -		else if (bol[1] == ' ' && *bol == todo_command_info[i].c) {
 +		} else if (bol[1] == ' ' && *bol == todo_command_info[i].c) {
  			bol++;
  			item->command = i;
  			break;
 @@ -1312,7 +1301,7 @@ static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
  		else if (is_fixup(item->command))
  			return error(_("cannot '%s' without a previous commit"),
  				command_to_string(item->command));
 -		else if (item->command < TODO_NOOP)
 +		else if (!is_noop(item->command))
  			fixup_okay = 1;
  	}
  
 @@ -1533,8 +1522,7 @@ static int create_seq_dir(void)
  		error(_("a cherry-pick or revert is already in progress"));
  		advise(_("try \"git cherry-pick (--continue | --quit | --abort)\""));
  		return -1;
 -	}
 -	else if (mkdir(git_path_seq_dir(), 0777) < 0)
 +	} else if (mkdir(git_path_seq_dir(), 0777) < 0)
  		return error_errno(_("could not create sequencer directory '%s'"),
  				   git_path_seq_dir());
  	return 0;
 @@ -1667,6 +1655,10 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
  	const char *todo_path = get_todo_path(opts);
  	int next = todo_list->current, offset, fd;
  
 +	/*
 +	 * rebase -i writes "git-rebase-todo" without the currently executing
 +	 * command, appending it to "done" instead.
 +	 */
  	if (is_rebase_i(opts))
  		next++;
  
 @@ -1739,7 +1731,7 @@ static int make_patch(struct commit *commit, struct replay_opts *opts)
  {
  	struct strbuf buf = STRBUF_INIT;
  	struct rev_info log_tree_opt;
 -	const char *commit_buffer = get_commit_buffer(commit, NULL), *subject, *p;
 +	const char *subject, *p;
  	int res = 0;
  
  	p = short_commit_name(commit);
 @@ -1766,6 +1758,7 @@ static int make_patch(struct commit *commit, struct replay_opts *opts)
  
  	strbuf_addf(&buf, "%s/message", get_dir(opts));
  	if (!file_exists(buf.buf)) {
 +		const char *commit_buffer = get_commit_buffer(commit, NULL);
  		find_commit_subject(commit_buffer, &subject);
  		res |= write_message(subject, strlen(subject), buf.buf, 1);
  		unuse_commit_buffer(commit, commit_buffer);
 @@ -1805,8 +1798,7 @@ static int error_with_patch(struct commit *commit,
  			"Once you are satisfied with your changes, run\n"
  			"\n"
  			"  git rebase --continue\n", gpg_sign_opt_quoted(opts));
 -	}
 -	else if (exit_code)
 +	} else if (exit_code)
  		fprintf(stderr, "Could not apply %s... %.*s\n",
  			short_commit_name(commit), subject_len, subject);
  
 @@ -1854,8 +1846,7 @@ static int do_exec(const char *command_line)
  		if (status == 127)
  			/* command not found */
  			status = 1;
 -	}
 -	else if (dirty) {
 +	} else if (dirty) {
  		warning(_("execution succeeded: %s\nbut "
  			  "left changes to the index and/or the working tree\n"
  			  "Commit or stash your changes, and then run\n"
 @@ -1878,7 +1869,7 @@ static int is_final_fixup(struct todo_list *todo_list)
  	while (++i < todo_list->nr)
  		if (is_fixup(todo_list->items[i].command))
  			return 0;
 -		else if (todo_list->items[i].command < TODO_NOOP)
 +		else if (!is_noop(todo_list->items[i].command))
  			break;
  	return 1;
  }
 @@ -1888,7 +1879,7 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
  	int i;
  
  	for (i = todo_list->current + offset; i < todo_list->nr; i++)
 -		if (todo_list->items[i].command < TODO_NOOP)
 +		if (!is_noop(todo_list->items[i].command))
  			return todo_list->items[i].command;
  
  	return -1;
 @@ -2021,21 +2012,18 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
  					intend_to_amend();
  				return error_failed_squash(item->commit, opts,
  					item->arg_len, item->arg);
 -			}
 -			else if (res && is_rebase_i(opts))
 +			} else if (res && is_rebase_i(opts))
  				return res | error_with_patch(item->commit,
  					item->arg, item->arg_len, opts, res,
  					item->command == TODO_REWORD);
 -		}
 -		else if (item->command == TODO_EXEC) {
 +		} else if (item->command == TODO_EXEC) {
  			char *end_of_arg = (char *)(item->arg + item->arg_len);
  			int saved = *end_of_arg;
  
  			*end_of_arg = '\0';
  			res = do_exec(item->arg);
  			*end_of_arg = saved;
 -		}
 -		else if (item->command < TODO_NOOP)
 +		} else if (!is_noop(item->command))
  			return error(_("unknown command %d"), item->command);
  
  		todo_list->current++;
 @@ -2055,40 +2043,60 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
  				starts_with(head_ref.buf, "refs/")) {
  			const char *msg;
  			unsigned char head[20], orig[20];
 -
 -			if (get_sha1("HEAD", head))
 -				return error(_("cannot read HEAD"));
 +			int res;
 +
 +			if (get_sha1("HEAD", head)) {
 +				res = error(_("cannot read HEAD"));
 +cleanup_head_ref:
 +				strbuf_release(&head_ref);
 +				strbuf_release(&buf);
 +				return res;
 +			}
  			if (!read_oneliner(&buf, rebase_path_orig_head(), 0) ||
 -					get_sha1_hex(buf.buf, orig))
 -				return error(_("could not read orig-head"));
 -			if (!read_oneliner(&buf, rebase_path_onto(), 0))
 -				return error(_("could not read 'onto'"));
 +					get_sha1_hex(buf.buf, orig)) {
 +				res = error(_("could not read orig-head"));
 +				goto cleanup_head_ref;
 +			}
 +			if (!read_oneliner(&buf, rebase_path_onto(), 0)) {
 +				res = error(_("could not read 'onto'"));
 +				goto cleanup_head_ref;
 +			}
  			msg = reflog_message(opts, "finish", "%s onto %s",
  				head_ref.buf, buf.buf);
  			if (update_ref(msg, head_ref.buf, head, orig,
 -					REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
 -				return error(_("could not update %s"),
 +					REF_NODEREF, UPDATE_REFS_MSG_ON_ERR)) {
 +				res = error(_("could not update %s"),
  					head_ref.buf);
 +				goto cleanup_head_ref;
 +			}
  			msg = reflog_message(opts, "finish", "returning to %s",
  				head_ref.buf);
 -			if (create_symref("HEAD", head_ref.buf, msg))
 -				return error(_("could not update HEAD to %s"),
 +			if (create_symref("HEAD", head_ref.buf, msg)) {
 +				res = error(_("could not update HEAD to %s"),
  					head_ref.buf);
 +				goto cleanup_head_ref;
 +			}
  			strbuf_reset(&buf);
  		}
  
  		if (opts->verbose) {
 -			const char *argv[] = {
 -				"diff-tree", "--stat", NULL, NULL
 -			};
 -
 -			if (!read_oneliner(&buf, rebase_path_orig_head(), 0))
 -				return error(_("could not read '%s'"),
 -					rebase_path_orig_head());
 -			strbuf_addstr(&buf, "..HEAD");
 -			argv[2] = buf.buf;
 -			run_command_v_opt(argv, RUN_GIT_CMD);
 -			strbuf_reset(&buf);
 +			struct rev_info log_tree_opt;
 +			struct object_id orig, head;
 +
 +			memset(&log_tree_opt, 0, sizeof(log_tree_opt));
 +			init_revisions(&log_tree_opt, NULL);
 +			log_tree_opt.diff = 1;
 +			log_tree_opt.diffopt.output_format =
 +				DIFF_FORMAT_DIFFSTAT;
 +			log_tree_opt.disable_stdin = 1;
 +
 +			if (read_oneliner(&buf, rebase_path_orig_head(), 0) &&
 +			    !get_sha1(buf.buf, orig.hash) &&
 +			    !get_sha1("HEAD", head.hash)) {
 +				diff_tree_sha1(orig.hash, head.hash,
 +					       "", &log_tree_opt.diffopt);
 +				log_tree_diff_flush(&log_tree_opt);
 +			}
  		}
  		flush_rewritten_pending();
  		if (!stat(rebase_path_rewritten_list(), &st) &&
 @@ -2195,8 +2203,7 @@ int sequencer_continue(struct replay_opts *opts)
  	if (is_rebase_i(opts)) {
  		if (commit_staged_changes(opts))
  			return -1;
 -	}
 -	else if (!file_exists(get_todo_path(opts)))
 +	} else if (!file_exists(get_todo_path(opts)))
  		return continue_single_pick();
  	if (read_populate_opts(opts))
  		return -1;
 @@ -2216,8 +2223,7 @@ int sequencer_continue(struct replay_opts *opts)
  			goto release_todo_list;
  		}
  		todo_list.current++;
 -	}
 -	else if (file_exists(rebase_path_stopped_sha())) {
 +	} else if (file_exists(rebase_path_stopped_sha())) {
  		struct strbuf buf = STRBUF_INIT;
  		struct object_id oid;
  

-- 
2.11.0.rc3.windows.1

