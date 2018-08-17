Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEF701F954
	for <e@80x24.org>; Fri, 17 Aug 2018 13:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbeHQQT6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 12:19:58 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:5419 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbeHQQT6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 12:19:58 -0400
Received: from [192.168.2.201] ([92.22.43.193])
        by smtp.talktalk.net with SMTP
        id qecCfl8ngdJAeqecDfYc2w; Fri, 17 Aug 2018 14:16:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1534511794;
        bh=zY+Pxzd52KmQNPwlbfSuYWDN2MoDHJOBUTB6YrNbQYs=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AyeKK+eP9tG7uxYl3lFSX2NS4+YVuvzz2teLB43W3suf7uU53fZcd6DNXFzabghv3
         2yQ8d84oVBPz73EdcNW9JSGmTZxBLbL7eacIK/ysdrbxPneVmWEzvgNj1pfI/nCizs
         kAnHMaxF0h7elKfGGet1Koyu1OjZ41ZJdrFVNBf8=
X-Originating-IP: [92.22.43.193]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=0uAVYj1wOgJByxYeJIV+0Q==:117
 a=0uAVYj1wOgJByxYeJIV+0Q==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=Wc9hyadQa9qOOr0WIfsA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v6 11/20] rebase -i: rewrite complete_action() in C
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com
References: <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180810165147.4779-1-alban.gruin@gmail.com>
 <20180810165147.4779-12-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <330b949f-f4ce-5e61-b1f6-4dc0c83a7d1a@talktalk.net>
Date:   Fri, 17 Aug 2018 14:16:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180810165147.4779-12-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfNFM4FtH25tq4+iupnfObBWLUggUxeVk/L7sOKXYMlncfdBJK/KOo655AG0yZ66lP8gmSZcOnFw0h5WObYLzzcUQMdCMH0S1ry4jNBSj4jVfeA0ZI3cz
 ftdG0eE82YqvyJ+ddVmk7jVU6dhegbn1fDy781mzxBZ1w1tY6hU2lqEVDGwtBawo+bfF/YxXa+YSOFCrOFKWcEVfhPWpsUMOxfu3A+Hh5c9AcFOfn67qHZCV
 PshpNuVONXAjJYbGw1Y8F43FsdLA+op8c7g5A1UK1+FE5REyHo6QWeEKPLS0uJfoeozKMXMGZ0MGo8q6+Vn5AveCdjBojrOqeFesSZaPUwCEV+zfovOUg+Ft
 babepm4HhDvMBBd8InZfk1i+R9VI1VfrQoAtAhMrqxGye53Ma/PzBLI7EQoB4XqqNkLz6EOP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

The interdiff from v5 to v6 looks good, I think the changes you have
made the the other patches in this series are fine, I've just got a
couple of small comments below about this one.

Best Wishes

Phillip

On 10/08/2018 17:51, Alban Gruin wrote:
> 
> This rewrites complete_action() from shell to C.
> 
> A new mode is added to rebase--helper (`--complete-action`), as well as
> a new flag (`--autosquash`).
> 
> Finally, complete_action() is stripped from git-rebase--interactive.sh.
> 
> The original complete_action() would return the code 2 when the todo
> list contained no actions.  This was a special case for rebase -i and
> -p; git-rebase.sh would then apply the autostash, delete the state
> directory, and die with the message "Nothing to do".  This cleanup is
> rewritten in C instead of returning 2.  As rebase -i no longer returns
> 2, the comment describing this behaviour in git-rebase.sh is updated to
> reflect this change.
> 
> The message "Nothing to do" is now printed with error(), and so becomes
> "error: nothing to do".  Some tests in t3404 check this value, so they
> are updated to fit this change.
> 
> The first check might seem useless as we write "noop" to the todo list
> if it is empty.  Actually, the todo list might contain commented
> commands (ie. empty commits).  In this case, complete_action() won’t
> write "noop", and will abort without starting the editor.
> 
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  builtin/rebase--helper.c      |  12 +++-
>  git-rebase--interactive.sh    |  53 ++----------------
>  git-rebase.sh                 |   2 +-
>  sequencer.c                   | 102 ++++++++++++++++++++++++++++++++++
>  sequencer.h                   |   4 ++
>  t/t3404-rebase-interactive.sh |   2 +-
>  6 files changed, 122 insertions(+), 53 deletions(-)
> 
> diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
> index bed3dd2b95..01b3333958 100644
> --- a/builtin/rebase--helper.c
> +++ b/builtin/rebase--helper.c
> @@ -13,13 +13,13 @@ static const char * const builtin_rebase_helper_usage[] = {
>  int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  {
>  	struct replay_opts opts = REPLAY_OPTS_INIT;
> -	unsigned flags = 0, keep_empty = 0, rebase_merges = 0;
> +	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, autosquash = 0;
>  	int abbreviate_commands = 0, rebase_cousins = -1;
>  	enum {
>  		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
>  		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
>  		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, PREPARE_BRANCH,
> -		CHECKOUT_ONTO
> +		CHECKOUT_ONTO, COMPLETE_ACTION
>  	} command = 0;
>  	struct option options[] = {
>  		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
> @@ -29,6 +29,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
>  		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
>  			 N_("keep original branch points of cousins")),
> +		OPT_BOOL(0, "autosquash", &autosquash,
> +			 N_("move commits that begin with squash!/fixup!")),
>  		OPT__VERBOSE(&opts.verbose, N_("be verbose")),
>  		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
>  				CONTINUE),
> @@ -57,6 +59,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  			    N_("prepare the branch to be rebased"), PREPARE_BRANCH),
>  		OPT_CMDMODE(0, "checkout-onto", &command,
>  			    N_("checkout a commit"), CHECKOUT_ONTO),
> +		OPT_CMDMODE(0, "complete-action", &command,
> +			    N_("complete the action"), COMPLETE_ACTION),
>  		OPT_END()
>  	};
>  
> @@ -110,5 +114,9 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  		return !!prepare_branch_to_be_rebased(&opts, argv[1]);
>  	if (command == CHECKOUT_ONTO && argc == 4)
>  		return !!checkout_onto(&opts, argv[1], argv[2], argv[3]);
> +	if (command == COMPLETE_ACTION && argc == 6)
> +		return !!complete_action(&opts, flags, argv[1], argv[2], argv[3],
> +					 argv[4], argv[5], autosquash);
> +
>  	usage_with_options(builtin_rebase_helper_usage, options);
>  }
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index b68f108f28..59dc4888a6 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -127,54 +127,6 @@ init_revisions_and_shortrevisions () {
>  	fi
>  }
>  
> -complete_action() {
> -	test -s "$todo" || echo noop >> "$todo"
> -	test -z "$autosquash" || git rebase--helper --rearrange-squash || exit
> -	test -n "$cmd" && git rebase--helper --add-exec-commands "$cmd"
> -
> -	todocount=$(git stripspace --strip-comments <"$todo" | wc -l)
> -	todocount=${todocount##* }
> -
> -cat >>"$todo" <<EOF
> -
> -$comment_char $(eval_ngettext \
> -	"Rebase \$shortrevisions onto \$shortonto (\$todocount command)" \
> -	"Rebase \$shortrevisions onto \$shortonto (\$todocount commands)" \
> -	"$todocount")
> -EOF
> -	git rebase--helper --append-todo-help ${keep_empty:+--keep-empty}
> -
> -	has_action "$todo" ||
> -		return 2
> -
> -	cp "$todo" "$todo".backup
> -	collapse_todo_ids
> -	git_sequence_editor "$todo" ||
> -		die_abort "$(gettext "Could not execute editor")"
> -
> -	has_action "$todo" ||
> -		return 2
> -
> -	git rebase--helper --check-todo-list || {
> -		ret=$?
> -		git rebase--helper --checkout-onto "$onto_name" "$onto" \
> -		    "$orig_head" ${verbose:+--verbose}
> -		exit $ret
> -	}
> -
> -	expand_todo_ids
> -
> -	test -n "$force_rebase" ||
> -	onto="$(git rebase--helper --skip-unnecessary-picks)" ||
> -	die "Could not skip unnecessary pick commands"
> -
> -	git rebase--helper --checkout-onto "$onto_name" "$onto" "$orig_head" \
> -	    ${verbose:+--verbose}
> -	require_clean_work_tree "rebase"
> -	exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
> -	     --continue
> -}
> -
>  git_rebase__interactive () {
>  	initiate_action "$action"
>  	ret=$?
> @@ -193,5 +145,8 @@ git_rebase__interactive () {
>  		$revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
>  	die "$(gettext "Could not generate todo list")"
>  
> -	complete_action
> +	exec git rebase--helper --complete-action "$shortrevisions" "$onto_name" \
> +		"$shortonto" "$orig_head" "$cmd" $allow_empty_message \
> +		${autosquash:+--autosquash} ${keep_empty:+--keep-empty} \
> +		${verbose:+--verbose} ${force_rebase:+--no-ff}
>  }
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 7973447645..51a6db7daa 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -219,7 +219,7 @@ run_specific_rebase () {
>  	if test $ret -eq 0
>  	then
>  		finish_rebase
> -	elif test $ret -eq 2 # special exit status for rebase -i
> +	elif test $ret -eq 2 # special exit status for rebase -p
>  	then
>  		apply_autostash &&
>  		rm -rf "$state_dir" &&
> diff --git a/sequencer.c b/sequencer.c
> index a56a781539..ae1f44de2f 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -30,6 +30,7 @@
>  #include "oidset.h"
>  #include "commit-slab.h"
>  #include "alias.h"
> +#include "rebase-interactive.h"
>  
>  #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>  
> @@ -53,6 +54,9 @@ static GIT_PATH_FUNC(rebase_path, "rebase-merge")
>   * file and written to the tail of 'done'.
>   */
>  GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
> +static GIT_PATH_FUNC(rebase_path_todo_backup,
> +		     "rebase-merge/git-rebase-todo.backup")
> +
>  /*
>   * The rebase command lines that have already been processed. A line
>   * is moved here when it is first handled, before any associated user
> @@ -4499,6 +4503,104 @@ int skip_unnecessary_picks(struct object_id *output_oid)
>  	return 0;
>  }
>  
> +int complete_action(struct replay_opts *opts, unsigned flags,
> +		    const char *shortrevisions, const char *onto_name,
> +		    const char *onto, const char *orig_head, const char *cmd,
> +		    unsigned autosquash)
> +{
> +	const char *shortonto, *todo_file = rebase_path_todo();
> +	struct todo_list todo_list = TODO_LIST_INIT;
> +	struct strbuf *buf = &(todo_list.buf);
> +	struct object_id oid;
> +	struct stat st;
> +
> +	get_oid(onto, &oid);
> +	shortonto = find_unique_abbrev(&oid, DEFAULT_ABBREV);
> +
> +	if (!lstat(todo_file, &st) && st.st_size == 0 &&
> +	    write_message("noop\n", 5, todo_file, 0))
> +		return error_errno(_("could not write '%s'"), todo_file);
> +
> +	if (autosquash && rearrange_squash())
> +		return -1;
> +
> +	if (cmd && *cmd)
> +		sequencer_add_exec_commands(cmd);
> +
> +	if (strbuf_read_file(buf, todo_file, 0) < 0)
> +		return error_errno(_("could not read '%s'."), todo_file);
> +
> +	if (parse_insn_buffer(buf->buf, &todo_list)) {
> +		todo_list_release(&todo_list);
> +		return error(_("unusable todo list: '%s'"), todo_file);
> +	}
> +
> +	if (count_commands(&todo_list) == 0) {
> +		apply_autostash(opts);
> +		sequencer_remove_state(opts);
> +		todo_list_release(&todo_list);
> +
> +		return error(_("nothing to do"));
> +	}
> +
> +	strbuf_addch(buf, '\n');
> +	strbuf_commented_addf(buf, Q_("Rebase %s onto %s (%d command)",
> +				      "Rebase %s onto %s (%d commands)",
> +				      count_commands(&todo_list)),
> +			      shortrevisions, shortonto, count_commands(&todo_list));
> +	append_todo_help(0, flags & TODO_LIST_KEEP_EMPTY, buf);
> +
> +	if (write_message(buf->buf, buf->len, todo_file, 0)) {
> +		todo_list_release(&todo_list);
> +		return error_errno(_("could not write '%s'"), todo_file);
> +	}

write_message() prints an error message if it fails so I think this call
to error_errno() is not needed

> +
> +	if (copy_file(rebase_path_todo_backup(), todo_file, 0666))
> +		return error(_("could not copy '%s' to '%s'."), todo_file,
> +			     rebase_path_todo_backup());
> +
> +	if (transform_todos(flags | TODO_LIST_SHORTEN_IDS))
> +		return error(_("could not transform the todo list"));
> +
> +	strbuf_reset(buf);
> +
> +	if (launch_sequence_editor(todo_file, buf, NULL)) {
> +		apply_autostash(opts);
> +		sequencer_remove_state(opts);
> +		todo_list_release(&todo_list);
> +
> +		return -1;
> +	}
> +
> +	strbuf_stripspace(buf, 1);
> +	if (buf->len == 0) {
> +		apply_autostash(opts);
> +		sequencer_remove_state(opts);
> +		todo_list_release(&todo_list);
> +
> +		return error(_("nothing to do"));
> +	}
> +
> +	todo_list_release(&todo_list);
> +
> +	if (check_todo_list()) {
> +		checkout_onto(opts, onto_name, onto, orig_head);
> +		return -1;
> +	}
> +
> +	if (transform_todos(flags & ~(TODO_LIST_SHORTEN_IDS)))
> +		return error(_("could not transform the todo list"));
> +
> +	if (opts->allow_ff && skip_unnecessary_picks(&oid))
> +		return error(_("could not skip unnecessary pick commands"));
> +
> +	checkout_onto(opts, onto_name, oid_to_hex(&oid), orig_head);

checkout_onto() can fail if it would overwrite untracked files, so do we
need to check its return value here?

> +	if (require_clean_work_tree("rebase", "", 1, 1))
> +		return -1;
> +
> +	return sequencer_continue(opts);
> +}
> +
>  struct subject2item_entry {
>  	struct hashmap_entry entry;
>  	int i;
> diff --git a/sequencer.h b/sequencer.h
> index fcbcd246c2..d58766c6d7 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -92,6 +92,10 @@ int transform_todos(unsigned flags);
>  enum missing_commit_check_level get_missing_commit_check_level(void);
>  int check_todo_list(void);
>  int skip_unnecessary_picks(struct object_id *output_oid);
> +int complete_action(struct replay_opts *opts, unsigned flags,
> +		    const char *shortrevisions, const char *onto_name,
> +		    const char *onto, const char *orig_head, const char *cmd,
> +		    unsigned autosquash);
>  int rearrange_squash(void);
>  
>  extern const char sign_off_header[];
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 496d88d7d6..12d3ed8396 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -76,7 +76,7 @@ test_expect_success 'rebase --keep-empty' '
>  '
>  
>  cat > expect <<EOF
> -Nothing to do
> +error: nothing to do
>  EOF
>  
>  test_expect_success 'rebase -i with empty HEAD' '
> 

