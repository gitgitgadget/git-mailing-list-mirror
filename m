Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF0CC33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 14:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671832187F
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 14:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQ0tEYqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgAGOhx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:37:53 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33301 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgAGOhx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 09:37:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id d139so14356447wmd.0
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 06:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8S9iOj0umGUxEXIXXuzXrVQsCqMXDg2qIjI8Tgh9FVk=;
        b=pQ0tEYqEDUr/oczJJS8P0HROtlsM2fjkDRMAD4lJMupl+RKAaJbmDwTTsmWsbgu3Mg
         wMp+39PGeqL8AaU0TsBTc9zoiyWbam64vVpx75rhOqoBxl7gonfyzMg+hzBThUGnSFoP
         wh7FG1CBcA6KFNo4KeEWRtCcJiiuj7j9wmyAFb5zRuRZ0wC2fsaRrpYMP6YJolUU+E4T
         AL0gBW8YkaP6H4I0MGASEvcW5c2vVXc+wQMn4XKCZZD2tWEfVIB7+okNSuKifCVBdSAN
         0x4Zz+3lzdmvc8AkD83fB3oFSZQ8hxSafaHWyXfxbnQg1YO8JsuFGzlqLjPjKhmuoe26
         7S+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8S9iOj0umGUxEXIXXuzXrVQsCqMXDg2qIjI8Tgh9FVk=;
        b=cuqbZzSVLFoCir0Dz05sV4moyKEzrm1jAD2LKTWUi6vo9GlO2tH3x/2OzqHgaS/LjQ
         wgI0iWOIc5NwKbSZsMV5xlC32VndguYYGL1mrjk0BpN9MEuODZat8pVZumFNxcq7Xk5C
         WpY37yPlcIoquUOe0gqGh6CR8u7E3gKTFlWV2fEuUoLS6LjFdP2ZkE5QbSc5gD6BNTDw
         viyhRnJOtFutRj1iI0ZPgQSwyzo3TdOiHQuyBcYsqc1MO9s9ht/dvL/3fYpw1n9g0z6y
         y4/TiSs/J3895HnaDeDUz5Fb0pVQqPlA1N2oKC+wKWfhki8pE3tIMuuQLST/prz6ENfp
         sG7A==
X-Gm-Message-State: APjAAAVQlaL5zU4cE1awAUB1JVA60XANkKwuGct4FLpjPHL+XAG982jQ
        RBHWXjfTkWi+2lpR65aIGJc=
X-Google-Smtp-Source: APXvYqzi6iRU0acB/BWD1cOlmy2nUHvwaTrvI32uclYx9M3bhtlF5UFDq+qAXBPcX8IUATnd6rCDTw==
X-Received: by 2002:a05:600c:2c13:: with SMTP id q19mr39598528wmg.144.1578407867215;
        Tue, 07 Jan 2020 06:37:47 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-7-145.as13285.net. [92.22.7.145])
        by smtp.gmail.com with ESMTPSA id f16sm13589wrm.65.2020.01.07.06.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 06:37:46 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 01/15] rebase: extend the options for handling of empty
 commits
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com,
        Elijah Newren <newren@gmail.com>
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
 <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
 <1c2b77e94d63f86590ca934855066eca278f576e.1577217299.git.gitgitgadget@gmail.com>
Message-ID: <404424d7-f520-8f89-efef-ca03e66fcd43@gmail.com>
Date:   Tue, 7 Jan 2020 14:37:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1c2b77e94d63f86590ca934855066eca278f576e.1577217299.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

Thanks for working on this series, I think making the sequencer the 
default backend is a good idea. I have a few reservations about this 
path though...

On 24/12/2019 19:54, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Extend the interactive machinery with the ability to handle the full
> spread of options for how to handle commits that either start or become
> empty (by "become empty" I mean the changes in a commit are a subset of
> changes that exist upstream, so the net effect of applying the commit is
> no changes).  Introduce a new command line flag for selecting the
> desired behavior:
>     --empty={drop,keep,ask}
> with the definitions:
>     drop: drop empty commits
>     keep: keep empty commits
>     ask:  provide the user a chance to interact and pick what to do with
>           empty commits on a case-by-case basis

I think we want to distinguish between commits that are empty before
rebasing and those that become empty when they are rebased. --keep-empty 
explicily only applies to commits that are already empty. Cherry-pick
has distinct options for those two cases. If I've explicitly created an 
empty commit then I want to keep it but I don't want to keep commits 
that become empty because the changes they contain are already upstream.

If we want an option that keeps commits that become empty (Off hand I 
don't know why we would though) we should consider if that option should 
disable --cherry-mark when we create the todo list so that it keeps all 
commits that become empty when they're rebased.

> Note that traditionally, am-based rebases have always dropped commits
> that either started or became empty, while interactive-based rebases
> have defaulted to ask (and provided an option to keep commits that
> started empty).  This difference made sense since users of an am-based
> rebase just wanted to quickly batch apply a sequence of commits, while
> users editing a todo list will likely want the chance to interact and
> handle unusual cases on a case-by-case basis.  

I don't see why it makes sense to drop an empty commit that I've made 
just because it is being rebased. I'm pretty sure the behavor of the 
am-based rebase is a function of `git am` not being able to create empty 
commits.

> However, not all rebases
> using the interactive machinery are explicitly interactive anymore.  In
> particular --merge was always meant to behave more like --am: just
> rebase a batch of commits without popping up a todo list.
> 
> If the --empty flag is not specified, pick defaults as follows:
>     explicitly interactive: ask
>     --exec: keep (exec is about checking existing commits, and often
>                   used without actually changing the base.  Thus the
>                   expectation is that the user doesn't necessarily want
>                   anything to change; they just want to test).
>     otherwise: drop

I'm not sure I like changing the behavior based on --exec, I see what
you're getting at but it has the potential to be confusing. What if I
want to rearrange the commits without changing the base - why must I
specify --empty=keep there but not if I add --exec to the command line?

> Also, this commit makes --keep-empty just imply --empty=keep, and hides
> it from help so that we aren't confusing users with different ways to do
> the same thing.  (I could have added a --drop-empty flag, but then that
> invites users to specify both --keep-empty and --drop-empty and we have
> to add sanity checking around that; it seems cleaner to have a single
> multi-valued option.)  This actually fixes --keep-empty too; previously,
> it only meant to sometimes keep empty commits, in particular commits
> which started empty would be kept.  But it would still error out and ask
> the user what to do with commits that became empty.  Now it keeps empty
> commits, as instructed.

It certainly changes the behavior of --keep-empty but I'm not sure it 
"fixes" it. If I have some empty commits I want to keep as placeholders 
then that's different from wanting to keep commits that become empty 
because their changes are upstream but --cherry-mark didn't detect them.

In summary I'm in favor of making it easier to drop commits that become 
empty but not tying that to the handling of commits that are empty 
before they are rebased.

I'm also not happy that the deprecation of --keep-empty suddenly makes 
--no-keep-empty an error.

> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/git-rebase.txt      | 35 ++++++------
>  builtin/rebase.c                  | 83 +++++++++++++++++++++++++---
>  rebase-interactive.c              |  4 +-
>  rebase-interactive.h              |  2 +-
>  sequencer.c                       | 74 +++++++++++++++++++------
>  sequencer.h                       |  6 ++-
>  t/t3421-rebase-topology-linear.sh |  4 +-
>  t/t3424-rebase-empty.sh           | 89 +++++++++++++++++++++++++++++++
>  t/t3427-rebase-subtree.sh         | 16 +++---
>  9 files changed, 263 insertions(+), 50 deletions(-)
>  create mode 100755 t/t3424-rebase-empty.sh
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 1d0e2d27cc..ff32ca1080 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -258,9 +258,25 @@ See also INCOMPATIBLE OPTIONS below.
>  	original branch. The index and working tree are also left
>  	unchanged as a result.
>  
> +--empty={drop,keep,ask}::
> +	How to handle commits that become empty (because they contain a
> +	subset of already upstream changes) or start empty.  With drop
> +	(the default), commits that start or become empty are dropped.
> +	With keep (implied by --exec), such commits are kept.  With ask
> +	(implied by --interactive), the rebase will halt when an empty
> +	commit is applied allowing you to choose whether to drop it or
> +	commit it.  Also with ask, if the rebase is interactive then
> +	commits which start empty will be commented out in the todo
> +	action list (giving you a chance to uncomment).
> ++
> +Note that this has no effect on commits which are already upstream (as
> +can be checked via `git log --cherry-mark ...`), which are always
> +dropped by rebase.
> ++
> +See also INCOMPATIBLE OPTIONS below.
> +
>  --keep-empty::
> -	Keep the commits that do not change anything from its
> -	parents in the result.
> +	Deprecated alias for what is now known as --empty=keep.
>  +
>  See also INCOMPATIBLE OPTIONS below.
>  
> @@ -569,6 +585,7 @@ are incompatible with the following options:
>   * --interactive
>   * --exec
>   * --keep-empty
> + * --empty=
>   * --edit-todo
>   * --root when used in combination with --onto
>  
> @@ -580,6 +597,7 @@ In addition, the following pairs of options are incompatible:
>   * --preserve-merges and --ignore-whitespace
>   * --preserve-merges and --committer-date-is-author-date
>   * --preserve-merges and --ignore-date
> + * --preserve-merges and --empty=
>   * --keep-base and --onto
>   * --keep-base and --root
>  
> @@ -588,19 +606,6 @@ BEHAVIORAL DIFFERENCES
>  
>  There are some subtle differences how the backends behave.
>  
> -Empty commits
> -~~~~~~~~~~~~~
> -
> -The am backend drops any "empty" commits, regardless of whether the
> -commit started empty (had no changes relative to its parent to
> -start with) or ended empty (all changes were already applied
> -upstream in other commits).
> -
> -The interactive backend drops commits by default that
> -started empty and halts if it hits a commit that ended up empty.
> -The `--keep-empty` option exists for the interactive backend to allow
> -it to keep commits that started empty.
> -
>  Directory rename detection
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index ddf33bc9d4..6903249307 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -50,8 +50,16 @@ enum rebase_type {
>  	REBASE_PRESERVE_MERGES
>  };
>  
> +enum empty_type {
> +	EMPTY_UNSPECIFIED = -1,
> +	EMPTY_DROP,
> +	EMPTY_KEEP,
> +	EMPTY_ASK
> +};
> +
>  struct rebase_options {
>  	enum rebase_type type;
> +	enum empty_type empty;
>  	const char *state_dir;
>  	struct commit *upstream;
>  	const char *upstream_name;
> @@ -77,7 +85,6 @@ struct rebase_options {
>  	const char *action;
>  	int signoff;
>  	int allow_rerere_autoupdate;
> -	int keep_empty;
>  	int autosquash;
>  	int ignore_whitespace;
>  	char *gpg_sign_opt;
> @@ -95,6 +102,7 @@ struct rebase_options {
>  
>  #define REBASE_OPTIONS_INIT {			  	\
>  		.type = REBASE_UNSPECIFIED,	  	\
> +		.empty = EMPTY_UNSPECIFIED,	  	\
>  		.flags = REBASE_NO_QUIET, 		\
>  		.git_am_opts = ARGV_ARRAY_INIT,		\
>  		.git_format_patch_opt = STRBUF_INIT	\
> @@ -114,6 +122,10 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
>  		replay.allow_rerere_auto = opts->allow_rerere_autoupdate;
>  	replay.allow_empty = 1;
>  	replay.allow_empty_message = opts->allow_empty_message;
> +	replay.drop_redundant_commits = (opts->empty == EMPTY_DROP);
> +	replay.keep_redundant_commits = (opts->empty == EMPTY_KEEP);
> +	replay.ask_on_initially_empty = (opts->empty == EMPTY_ASK &&
> +					 !(opts->flags & REBASE_INTERACTIVE_EXPLICIT));
>  	replay.verbose = opts->flags & REBASE_VERBOSE;
>  	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
>  	replay.committer_date_is_author_date =
> @@ -389,7 +401,10 @@ static int run_rebase_interactive(struct rebase_options *opts,
>  
>  	git_config_get_bool("rebase.abbreviatecommands", &abbreviate_commands);
>  
> -	flags |= opts->keep_empty ? TODO_LIST_KEEP_EMPTY : 0;
> +	flags |= (opts->empty == EMPTY_DROP) ? TODO_LIST_DROP_EMPTY : 0;
> +	flags |= (opts->empty == EMPTY_ASK &&
> +		  opts->flags & REBASE_INTERACTIVE_EXPLICIT) ?
> +			TODO_LIST_ASK_EMPTY : 0;
>  	flags |= abbreviate_commands ? TODO_LIST_ABBREVIATE_CMDS : 0;
>  	flags |= opts->rebase_merges ? TODO_LIST_REBASE_MERGES : 0;
>  	flags |= opts->rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
> @@ -453,6 +468,19 @@ static int run_rebase_interactive(struct rebase_options *opts,
>  	return ret;
>  }
>  
> +static int parse_opt_keep_empty(const struct option *opt, const char *arg,
> +				int unset)
> +{
> +	struct rebase_options *opts = opt->value;
> +
> +	BUG_ON_OPT_NEG(unset);
> +	BUG_ON_OPT_ARG(arg);
> +
> +	opts->empty = EMPTY_KEEP;
> +	opts->type = REBASE_INTERACTIVE;
> +	return 0;
> +}
> +
>  static const char * const builtin_rebase_interactive_usage[] = {
>  	N_("git rebase--interactive [<options>]"),
>  	NULL
> @@ -466,7 +494,10 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>  	struct option options[] = {
>  		OPT_NEGBIT(0, "ff", &opts.flags, N_("allow fast-forward"),
>  			   REBASE_FORCE),
> -		OPT_BOOL(0, "keep-empty", &opts.keep_empty, N_("keep empty commits")),
> +		{ OPTION_CALLBACK, 'k', "keep-empty", &options, NULL,
> +			N_("(DEPRECATED) keep empty commits"),
> +			PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_HIDDEN,

It is all very well deprecating --keep-empty but suddenly making 
'--no-keep-empty' an error goes beyond deprecation. Also I'm not sure 
it's worth changing these options as I think the only user is 
git-rebase--preserve-merges.sh

Best Wishes

Phillip

> +			parse_opt_keep_empty },
>		OPT_BOOL(0, "allow-empty-message", &opts.allow_empty_message,
>  			 N_("allow commits with empty messages")),
>  		OPT_BOOL(0, "rebase-merges", &opts.rebase_merges, N_("rebase merge commits")),
> @@ -1166,7 +1197,7 @@ static int run_specific_rebase(struct rebase_options *opts, enum action action)
>  		opts->allow_rerere_autoupdate ?
>  			opts->allow_rerere_autoupdate == RERERE_AUTOUPDATE ?
>  			"--rerere-autoupdate" : "--no-rerere-autoupdate" : "");
> -	add_var(&script_snippet, "keep_empty", opts->keep_empty ? "yes" : "");
> +	add_var(&script_snippet, "empty", opts->empty == EMPTY_KEEP ? "yes" : "");
>  	add_var(&script_snippet, "autosquash", opts->autosquash ? "t" : "");
>  	add_var(&script_snippet, "gpg_sign_opt", opts->gpg_sign_opt);
>  	add_var(&script_snippet, "cmd", opts->cmd);
> @@ -1360,6 +1391,29 @@ static int parse_opt_interactive(const struct option *opt, const char *arg,
>  	return 0;
>  }
>  
> +static enum empty_type parse_empty_value(const char *value)
> +{
> +	if (!strcasecmp(value, "drop"))
> +		return EMPTY_DROP;
> +	else if (!strcasecmp(value, "keep"))
> +		return EMPTY_KEEP;
> +	else if (!strcasecmp(value, "ask"))
> +		return EMPTY_ASK;
> +
> +	die(_("unrecognized empty type '%s'; valid values are \"drop\", \"keep\", and \"ask\"."), value);
> +}
> +
> +static int parse_opt_empty(const struct option *opt, const char *arg, int unset)
> +{
> +	struct rebase_options *options = opt->value;
> +	enum empty_type value = parse_empty_value(arg);
> +
> +	BUG_ON_OPT_NEG(unset);
> +
> +	options->empty = value;
> +	return 0;
> +}
> +
>  static void NORETURN error_on_missing_default_upstream(void)
>  {
>  	struct branch *current_branch = branch_get(NULL);
> @@ -1505,8 +1559,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  				 "ignoring them"),
>  			      REBASE_PRESERVE_MERGES, PARSE_OPT_HIDDEN),
>  		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
> -		OPT_BOOL('k', "keep-empty", &options.keep_empty,
> -			 N_("preserve empty commits during rebase")),
> +		OPT_CALLBACK_F(0, "empty", &options, N_("{drop,keep,ask}"),
> +			       N_("how to handle empty commits"),
> +			       PARSE_OPT_NONEG, parse_opt_empty),
> +		{ OPTION_CALLBACK, 'k', "keep-empty", &options, NULL,
> +			N_("(DEPRECATED) keep empty commits"),
> +			PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_HIDDEN,
> +			parse_opt_keep_empty },
>  		OPT_BOOL(0, "autosquash", &options.autosquash,
>  			 N_("move commits that begin with "
>  			    "squash!/fixup! under -i")),
> @@ -1770,8 +1829,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	if (!(options.flags & REBASE_NO_QUIET))
>  		argv_array_push(&options.git_am_opts, "-q");
>  
> -	if (options.keep_empty)
> -		imply_interactive(&options, "--keep-empty");
> +	if (options.empty != EMPTY_UNSPECIFIED)
> +		imply_interactive(&options, "--empty");
>  
>  	if (gpg_sign) {
>  		free(options.gpg_sign_opt);
> @@ -1856,6 +1915,14 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		break;
>  	}
>  
> +	if (options.empty == EMPTY_UNSPECIFIED) {
> +		if (options.flags & REBASE_INTERACTIVE_EXPLICIT)
> +			options.empty = EMPTY_ASK;
> +		else if (exec.nr > 0)
> +			options.empty = EMPTY_KEEP;
> +		else
> +			options.empty = EMPTY_DROP;
> +	}
>  	if (reschedule_failed_exec > 0 && !is_interactive(&options))
>  		die(_("--reschedule-failed-exec requires "
>  		      "--exec or --interactive"));
> diff --git a/rebase-interactive.c b/rebase-interactive.c
> index aa18ae82b7..ad82bf77df 100644
> --- a/rebase-interactive.c
> +++ b/rebase-interactive.c
> @@ -28,7 +28,7 @@ static enum missing_commit_check_level get_missing_commit_check_level(void)
>  	return MISSING_COMMIT_CHECK_IGNORE;
>  }
>  
> -void append_todo_help(unsigned keep_empty, int command_count,
> +void append_todo_help(unsigned no_ask_empty, int command_count,
>  		      const char *shortrevisions, const char *shortonto,
>  		      struct strbuf *buf)
>  {
> @@ -81,7 +81,7 @@ void append_todo_help(unsigned keep_empty, int command_count,
>  
>  	strbuf_add_commented_lines(buf, msg, strlen(msg));
>  
> -	if (!keep_empty) {
> +	if (!no_ask_empty) {
>  		msg = _("Note that empty commits are commented out");
>  		strbuf_add_commented_lines(buf, msg, strlen(msg));
>  	}
> diff --git a/rebase-interactive.h b/rebase-interactive.h
> index 44dbb06311..f531e00ba7 100644
> --- a/rebase-interactive.h
> +++ b/rebase-interactive.h
> @@ -5,7 +5,7 @@ struct strbuf;
>  struct repository;
>  struct todo_list;
>  
> -void append_todo_help(unsigned keep_empty, int command_count,
> +void append_todo_help(unsigned no_ask_empty, int command_count,
>  		      const char *shortrevisions, const char *shortonto,
>  		      struct strbuf *buf);
>  int edit_todo_list(struct repository *r, struct todo_list *todo_list,
> diff --git a/sequencer.c b/sequencer.c
> index 763ccbbc45..d2c11f34b7 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -160,6 +160,9 @@ static GIT_PATH_FUNC(rebase_path_strategy, "rebase-merge/strategy")
>  static GIT_PATH_FUNC(rebase_path_strategy_opts, "rebase-merge/strategy_opts")
>  static GIT_PATH_FUNC(rebase_path_allow_rerere_autoupdate, "rebase-merge/allow_rerere_autoupdate")
>  static GIT_PATH_FUNC(rebase_path_reschedule_failed_exec, "rebase-merge/reschedule-failed-exec")
> +static GIT_PATH_FUNC(rebase_path_drop_redundant_commits, "rebase-merge/drop_redundant_commits")
> +static GIT_PATH_FUNC(rebase_path_keep_redundant_commits, "rebase-merge/keep_redundant_commits")
> +static GIT_PATH_FUNC(rebase_path_ask_on_initially_empty, "rebase-merge/ask_on_initially_empty")
>  
>  static int git_sequencer_config(const char *k, const char *v, void *cb)
>  {
> @@ -1623,7 +1626,7 @@ static int allow_empty(struct repository *r,
>  	empty_commit = is_original_commit_empty(commit);
>  	if (empty_commit < 0)
>  		return empty_commit;
> -	if (!empty_commit)
> +	if (!empty_commit || opts->ask_on_initially_empty)
>  		return 0;
>  	else
>  		return 1;
> @@ -1837,7 +1840,7 @@ static int do_pick_commit(struct repository *r,
>  	char *author = NULL;
>  	struct commit_message msg = { NULL, NULL, NULL, NULL };
>  	struct strbuf msgbuf = STRBUF_INIT;
> -	int res, unborn = 0, reword = 0, allow;
> +	int res, unborn = 0, reword = 0, allow, drop_commit;
>  
>  	if (opts->no_commit) {
>  		/*
> @@ -2042,13 +2045,20 @@ static int do_pick_commit(struct repository *r,
>  		goto leave;
>  	}
>  
> -	allow = allow_empty(r, opts, commit);
> -	if (allow < 0) {
> -		res = allow;
> -		goto leave;
> -	} else if (allow)
> -		flags |= ALLOW_EMPTY;
> -	if (!opts->no_commit) {
> +	drop_commit = 0;
> +	if (opts->drop_redundant_commits && is_index_unchanged(r)) {
> +		drop_commit = 1;
> +		fprintf(stderr, _("No changes -- Patch already applied."));
> +	} else {
> +		allow = allow_empty(r, opts, commit);
> +		if (allow < 0) {
> +			res = allow;
> +			goto leave;
> +		} else if (allow) {
> +			flags |= ALLOW_EMPTY;
> +		}
> +	}
> +	if (!opts->no_commit && !drop_commit) {
>  		if (author || command == TODO_REVERT || (flags & AMEND_MSG))
>  			res = do_commit(r, msg_file, author, opts, flags);
>  		else
> @@ -2501,9 +2511,15 @@ static int populate_opts_cb(const char *key, const char *value, void *data)

This function is used by cherry-pick/revert not rebase do we need to
change it?

>  	else if (!strcmp(key, "options.allow-empty-message"))
>  		opts->allow_empty_message =
>  			git_config_bool_or_int(key, value, &error_flag);
> +	else if (!strcmp(key, "options.drop-redundant-commits"))
> +		opts->drop_redundant_commits =
> +			git_config_bool_or_int(key, value, &error_flag);
>  	else if (!strcmp(key, "options.keep-redundant-commits"))
>  		opts->keep_redundant_commits =
>  			git_config_bool_or_int(key, value, &error_flag);
> +	else if (!strcmp(key, "options.ask_on_initially_empty"))
> +		opts->ask_on_initially_empty =
> +			git_config_bool_or_int(key, value, &error_flag);>  	else if (!strcmp(key, "options.signoff"))
>  		opts->signoff = git_config_bool_or_int(key, value, &error_flag);
>  	else if (!strcmp(key, "options.record-origin"))
> @@ -2612,6 +2628,15 @@ static int read_populate_opts(struct replay_opts *opts)
>  		if (file_exists(rebase_path_reschedule_failed_exec()))
>  			opts->reschedule_failed_exec = 1;
>  
> +		if (file_exists(rebase_path_drop_redundant_commits()))
> +			opts->drop_redundant_commits = 1;
> +
> +		if (file_exists(rebase_path_keep_redundant_commits()))
> +			opts->keep_redundant_commits = 1;
> +
> +		if (file_exists(rebase_path_ask_on_initially_empty()))
> +			opts->ask_on_initially_empty = 1;
> +
>  		read_strategy_opts(opts, &buf);
>  		strbuf_release(&buf);
>  
> @@ -2695,6 +2720,12 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
>  		write_file(rebase_path_cdate_is_adate(), "%s", "");
>  	if (opts->ignore_date)
>  		write_file(rebase_path_ignore_date(), "%s", "");
> +	if (opts->drop_redundant_commits)
> +		write_file(rebase_path_drop_redundant_commits(), "%s", "");
> +	if (opts->keep_redundant_commits)
> +		write_file(rebase_path_keep_redundant_commits(), "%s", "");
> +	if (opts->ask_on_initially_empty)
> +		write_file(rebase_path_ask_on_initially_empty(), "%s", "");
>  	if (opts->reschedule_failed_exec)
>  		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
>  
> @@ -3033,9 +3064,15 @@ static int save_opts(struct replay_opts *opts)

again this is for cherry-pick/revert

>  	if (opts->allow_empty_message)
>  		res |= git_config_set_in_file_gently(opts_file,
>  				"options.allow-empty-message", "true");
> +	if (opts->drop_redundant_commits)
> +		res |= git_config_set_in_file_gently(opts_file,
> +				"options.drop-redundant-commits", "true");
>  	if (opts->keep_redundant_commits)
>  		res |= git_config_set_in_file_gently(opts_file,
>  				"options.keep-redundant-commits", "true");
> +	if (opts->ask_on_initially_empty)
> +		res |= git_config_set_in_file_gently(opts_file,
> +				"options.ask_on_initially_empty", "true");
>  	if (opts->signoff)
>  		res |= git_config_set_in_file_gently(opts_file,
>  					"options.signoff", "true");
> @@ -4691,7 +4728,8 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>  				   struct rev_info *revs, struct strbuf *out,
>  				   unsigned flags)
>  {
> -	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
> +	int drop_empty = flags & TODO_LIST_DROP_EMPTY;
> +	int ask_empty = flags & TODO_LIST_ASK_EMPTY;
>  	int rebase_cousins = flags & TODO_LIST_REBASE_COUSINS;
>  	int root_with_onto = flags & TODO_LIST_ROOT_WITH_ONTO;
>  	struct strbuf buf = STRBUF_INIT, oneline = STRBUF_INIT;
> @@ -4746,6 +4784,8 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>  		is_empty = is_original_commit_empty(commit);
>  		if (!is_empty && (commit->object.flags & PATCHSAME))
>  			continue;
> +		if (is_empty && drop_empty)
> +			continue;
>  
>  		strbuf_reset(&oneline);
>  		pretty_print_commit(pp, commit, &oneline);
> @@ -4754,7 +4794,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>  		if (!to_merge) {
>  			/* non-merge commit: easy case */
>  			strbuf_reset(&buf);
> -			if (!keep_empty && is_empty)
> +			if (is_empty && ask_empty)
>  				strbuf_addf(&buf, "%c ", comment_line_char);
>  			strbuf_addf(&buf, "%s %s %s", cmd_pick,
>  				    oid_to_hex(&commit->object.oid),
> @@ -4922,7 +4962,8 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
>  	struct pretty_print_context pp = {0};
>  	struct rev_info revs;
>  	struct commit *commit;
> -	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
> +	int drop_empty = flags & TODO_LIST_DROP_EMPTY;
> +	int ask_empty = flags & TODO_LIST_ASK_EMPTY;
>  	const char *insn = flags & TODO_LIST_ABBREVIATE_CMDS ? "p" : "pick";
>  	int rebase_merges = flags & TODO_LIST_REBASE_MERGES;
>  
> @@ -4958,11 +4999,13 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
>  		return make_script_with_merges(&pp, &revs, out, flags);
>  
>  	while ((commit = get_revision(&revs))) {
> -		int is_empty  = is_original_commit_empty(commit);
> +		int is_empty = is_original_commit_empty(commit);
>  
>  		if (!is_empty && (commit->object.flags & PATCHSAME))
>  			continue;
> -		if (!keep_empty && is_empty)
> +		if (is_empty && drop_empty)
> +			continue;
> +		if (is_empty && ask_empty)
>  			strbuf_addf(out, "%c ", comment_line_char);
>  		strbuf_addf(out, "%s %s ", insn,
>  			    oid_to_hex(&commit->object.oid));
> @@ -5100,7 +5143,8 @@ int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
>  
>  	todo_list_to_strbuf(r, todo_list, &buf, num, flags);
>  	if (flags & TODO_LIST_APPEND_TODO_HELP)
> -		append_todo_help(flags & TODO_LIST_KEEP_EMPTY, count_commands(todo_list),
> +		append_todo_help(!(flags & TODO_LIST_ASK_EMPTY),
> +				 count_commands(todo_list),
>  				 shortrevisions, shortonto, &buf);
>  
>  	res = write_message(buf.buf, buf.len, file, 0);
> diff --git a/sequencer.h b/sequencer.h
> index e9a0e03ea2..1c3abb661c 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -39,7 +39,9 @@ struct replay_opts {
>  	int allow_rerere_auto;
>  	int allow_empty;
>  	int allow_empty_message;
> +	int drop_redundant_commits;
>  	int keep_redundant_commits;
> +	int ask_on_initially_empty;
>  	int verbose;
>  	int quiet;
>  	int reschedule_failed_exec;
> @@ -134,7 +136,7 @@ int sequencer_rollback(struct repository *repo, struct replay_opts *opts);
>  int sequencer_skip(struct repository *repo, struct replay_opts *opts);
>  int sequencer_remove_state(struct replay_opts *opts);
>  
> -#define TODO_LIST_KEEP_EMPTY (1U << 0)
> +/* #define TODO_LIST_KEEP_EMPTY (1U << 0) */ /* No longer used */
>  #define TODO_LIST_SHORTEN_IDS (1U << 1)
>  #define TODO_LIST_ABBREVIATE_CMDS (1U << 2)
>  #define TODO_LIST_REBASE_MERGES (1U << 3)
> @@ -150,6 +152,8 @@ int sequencer_remove_state(struct replay_opts *opts);
>   * `--onto`, we do not want to re-generate the root commits.
>   */
>  #define TODO_LIST_ROOT_WITH_ONTO (1U << 6)
> +#define TODO_LIST_DROP_EMPTY (1U << 7)
> +#define TODO_LIST_ASK_EMPTY (1U << 8)
>  
>  
>  int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
> diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
> index 325072b0a3..d23e0bf778 100755
> --- a/t/t3421-rebase-topology-linear.sh
> +++ b/t/t3421-rebase-topology-linear.sh
> @@ -230,7 +230,7 @@ test_run_rebase () {
>  test_run_rebase success ''
>  test_run_rebase success -m
>  test_run_rebase success -i
> -test_have_prereq !REBASE_P || test_run_rebase failure -p
> +test_have_prereq !REBASE_P || test_run_rebase success -p
>  
>  test_run_rebase () {
>  	result=$1
> @@ -245,7 +245,7 @@ test_run_rebase () {
>  test_run_rebase success ''
>  test_run_rebase success -m
>  test_run_rebase success -i
> -test_have_prereq !REBASE_P || test_run_rebase failure -p
> +test_have_prereq !REBASE_P || test_run_rebase success -p
>  test_run_rebase success --rebase-merges
>  
>  #       m
> diff --git a/t/t3424-rebase-empty.sh b/t/t3424-rebase-empty.sh
> new file mode 100755
> index 0000000000..9d52e1417f
> --- /dev/null
> +++ b/t/t3424-rebase-empty.sh
> @@ -0,0 +1,89 @@
> +#!/bin/sh
> +
> +test_description='git rebase of commits that start or become empty'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup test repository' '
> +	test_write_lines 1 2 3 4 5 6 7 8 9 10 >numbers &&
> +	test_write_lines A B C D E F G H I J >letters &&
> +	git add numbers letters &&
> +	git commit -m A &&
> +
> +	git branch upstream &&
> +	git branch localmods &&
> +
> +	git checkout upstream &&
> +	test_write_lines A B C D E >letters &&
> +	git add letters &&
> +	git commit -m B &&
> +
> +	test_write_lines 1 2 3 4 five 6 7 8 9 ten >numbers &&
> +	git add numbers &&
> +	git commit -m C &&
> +
> +	git checkout localmods &&
> +	test_write_lines 1 2 3 4 five 6 7 8 9 10 >numbers &&
> +	git add numbers &&
> +	git commit -m C2 &&
> +
> +	git commit --allow-empty -m D &&
> +
> +	test_write_lines A B C D E >letters &&
> +	git add letters &&
> +	git commit -m "Five letters ought to be enough for anybody"
> +'
> +
> +test_expect_success 'rebase --merge --empty=drop' '
> +	git checkout -B testing localmods &&
> +	git rebase --merge --empty=drop upstream &&
> +
> +	test_write_lines C B A >expect &&
> +	git log --format=%s >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'rebase --merge --empty=keep' '
> +	git checkout -B testing localmods &&
> +	git rebase --merge --empty=keep upstream &&
> +
> +	test_write_lines D C2 C B A >expect &&
> +	git log --format=%s >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'rebase --merge --empty=ask' '
> +	git checkout -B testing localmods &&
> +	test_must_fail git rebase --merge --empty=ask upstream &&
> +
> +	test_must_fail git rebase --skip &&
> +	git commit --allow-empty &&
> +	git rebase --continue &&
> +
> +	test_write_lines D C B A >expect &&
> +	git log --format=%s >actual &&
> +	test_cmp expect actual
> +'
> +
> +GIT_SEQUENCE_EDITOR=: && export GIT_SEQUENCE_EDITOR
> +
> +test_expect_success 'rebase --interactive --empty=drop' '
> +	git checkout -B testing localmods &&
> +	git rebase --interactive --empty=drop upstream &&
> +
> +	test_write_lines C B A >expect &&
> +	git log --format=%s >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'rebase --interactive --empty=keep' '
> +	git checkout -B testing localmods &&
> +	git rebase --interactive --empty=keep upstream &&
> +
> +	test_write_lines D C2 C B A >expect &&
> +	git log --format=%s >actual &&
> +	test_cmp expect actual
> +'
> +
> +
> +test_done
> diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
> index bec48e6a1f..468ebc1bef 100755
> --- a/t/t3427-rebase-subtree.sh
> +++ b/t/t3427-rebase-subtree.sh
> @@ -85,23 +85,27 @@ test_expect_failure REBASE_P 'Rebase -Xsubtree --keep-empty --preserve-merges --
>  	verbose test "$(commit_message HEAD)" = "Empty commit"
>  '
>  
> -test_expect_success 'Rebase -Xsubtree --keep-empty --onto commit' '
> +test_expect_success 'Rebase -Xsubtree --empty=ask --onto commit' '
>  	reset_rebase &&
>  	git checkout -b rebase-onto to-rebase &&
> -	test_must_fail git rebase -Xsubtree=files_subtree --keep-empty --onto files-master master &&
> +	test_must_fail git rebase -Xsubtree=files_subtree --empty=ask --onto files-master master &&
>  	: first pick results in no changes &&
> -	git rebase --continue &&
> +	test_must_fail git rebase --skip &&
> +	: last pick was an empty commit that has no changes, but we want to keep it &&
> +	git commit --allow-empty &&
>  	verbose test "$(commit_message HEAD~2)" = "master4" &&
>  	verbose test "$(commit_message HEAD~)" = "files_subtree/master5" &&
>  	verbose test "$(commit_message HEAD)" = "Empty commit"
>  '
>  
> -test_expect_success 'Rebase -Xsubtree --keep-empty --rebase-merges --onto commit' '
> +test_expect_success 'Rebase -Xsubtree --empty=ask --rebase-merges --onto commit' '
>  	reset_rebase &&
>  	git checkout -b rebase-merges-onto to-rebase &&
> -	test_must_fail git rebase -Xsubtree=files_subtree --keep-empty --rebase-merges --onto files-master --root &&
> +	test_must_fail git rebase -Xsubtree=files_subtree --empty=ask --rebase-merges --onto files-master --root &&
>  	: first pick results in no changes &&
> -	git rebase --continue &&
> +	test_must_fail git rebase --skip &&
> +	: last pick was an empty commit that has no changes, but we want to keep it &&
> +	git commit --allow-empty &&
>  	verbose test "$(commit_message HEAD~2)" = "master4" &&
>  	verbose test "$(commit_message HEAD~)" = "files_subtree/master5" &&
>  	verbose test "$(commit_message HEAD)" = "Empty commit"
> 

