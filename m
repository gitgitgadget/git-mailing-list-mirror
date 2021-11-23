Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20125C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 19:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237500AbhKWToS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 14:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbhKWToR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 14:44:17 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C282C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 11:41:09 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id 8so360758qtx.5
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 11:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+094aKsU6kwco3bFErZIwzlCc4W8cq27BOTdXLtpW2E=;
        b=EkqankgEOZFvwzb5YzuJ0G7WtHAL38YXx8J2mKTSU7opwelXiLhD7z9d+GGOzJXZYP
         5+CctPcU+3oeRqbFWh3+mS6gp5v+iJxuSDQtaS2lnjVT/4QvIvtufOsE+YqXuv+pfwYL
         G543P2RZkAfTnKRcSNSh2+YG+LcaXjPoa02kRPQdP6hxWYAmvJVSBXpmsqgldOLLqcet
         ND97zGR3qnKhSAoRR3ebTi/TeP9Aj4wmzez3QsAy454TMH1xtk2XDK18jSe4688ktBMT
         KPdRiQO3SQJAcy6wJifpxtw2oTjbRvUpBDeSERaae1vG+88SRvpnpGdu790TuG0sskrW
         tq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+094aKsU6kwco3bFErZIwzlCc4W8cq27BOTdXLtpW2E=;
        b=RFQfzQjdo+h1iXY08oegqojx0SbJQh9E1cMyNkGR8GAIrPrlbJ1A45Ycdy3zekMsUt
         PyAaE2eKb29WdGeOjIZ0uktwZ4/RIxvOx2Omh1edeIsXpKBgL1Qaueg2arSlS0nJM5MT
         Va8RlPpEgG2Y08Ww0lx5ScjTp7iK9DGZRtXdnNL0/Kw+6tHIFolYeRsw3uqECLosZXbf
         f6QRpSXdaFQctnRqdnk155zSho5BbCyyM5yCEjfJ02NbS+69RDJGyUkUf2eRk8sh85Mm
         YLN3dxBoCsvhK7kg0jqv0KQM+W/WJlt8QPxvQmqRIP2nYqY29OO3GnBl8sr81IpILcxB
         VWag==
X-Gm-Message-State: AOAM5328krMDrlp/D7O1ayufknSaKfCgkvc6j7iUEg0sOcrrGr2uEmpg
        MSfc/9MEXzFXytR5bd/YNjSg1MknRynipg==
X-Google-Smtp-Source: ABdhPJyVpwi+irZEZnl80c68OyukQd6lsTWutX72W9AOYzK4060uUmb6O1KrVgj+MhlGwWty+XjFOA==
X-Received: by 2002:a05:622a:1004:: with SMTP id d4mr9198243qte.95.1637696468128;
        Tue, 23 Nov 2021 11:41:08 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id d16sm6201417qtn.59.2021.11.23.11.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 11:41:07 -0800 (PST)
Subject: Re: [PATCH 4/4] branch: add --recurse-submodules option for branch
 creation
To:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20211122223252.19922-1-chooglen@google.com>
 <20211122223252.19922-5-chooglen@google.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <3ad3941c-de18-41bf-2e44-4238ae868d79@gmail.com>
Date:   Tue, 23 Nov 2021 14:41:06 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211122223252.19922-5-chooglen@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen,

Le 2021-11-22 à 17:32, Glen Choo a écrit :
> Add a --recurse-submodules option when creating branches so that `git
> branch --recurse-submodules topic` will create the "topic" branch in the
> superproject and all submodules. Guard this (and future submodule
> branching) behavior behind a new configuration value
> 'submodule.propagateBranches'.
> 
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>   Documentation/config/advice.txt    |   3 +
>   Documentation/config/submodule.txt |   9 ++

We would need to add the new flag to Documentation/git-branch.txt,
and also probably update the documentation of 'submodule.recurse'
in 'Documentation/config/submodule.txt'.

>   advice.c                           |   1 +
>   advice.h                           |   1 +
>   branch.c                           | 123 ++++++++++++++
>   branch.h                           |   6 +
>   builtin/branch.c                   |  28 +++-
>   builtin/submodule--helper.c        |  33 ++++
>   t/t3207-branch-submodule.sh        | 249 +++++++++++++++++++++++++++++
>   9 files changed, 452 insertions(+), 1 deletion(-)
>   create mode 100755 t/t3207-branch-submodule.sh
> 
> diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
> index 063eec2511..e52262dc69 100644
> --- a/Documentation/config/advice.txt
> +++ b/Documentation/config/advice.txt
> @@ -116,6 +116,9 @@ advice.*::
>   	submoduleAlternateErrorStrategyDie::
>   		Advice shown when a submodule.alternateErrorStrategy option
>   		configured to "die" causes a fatal error.
> +	submodulesNotUpdated::
> +		Advice shown when a user runs a submodule command that fails
> +		because `git submodule update` was not run.
>   	addIgnoredFile::
>   		Advice shown if a user attempts to add an ignored file to
>   		the index.
> diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
> index ee454f8126..c318b849aa 100644
> --- a/Documentation/config/submodule.txt
> +++ b/Documentation/config/submodule.txt
> @@ -72,6 +72,15 @@ submodule.recurse::
>   	For these commands a workaround is to temporarily change the
>   	configuration value by using `git -c submodule.recurse=0`.
>   
> +submodule.propagateBranches::
> +	[EXPERIMENTAL] A boolean that enables branching support with
> +	submodules. This allows certain commands to accept
> +	`--recurse-submodules` (`git branch --recurse-submodules` will
> +	create branches recursively), and certain commands that already
> +	accept `--recurse-submodules` will now consider branches (`git
> +	switch --recurse-submodules` will switch to the correct branch
> +	in all submodules).

Looking at the rest of the patch, this just implements 'branch --recurse-submodules', right ?
i.e. 'git switch' and 'git checkout' are left alone for
now, so I think this addition to the doc should only mention 'git branch'.

> +
>   submodule.fetchJobs::
>   	Specifies how many submodules are fetched/cloned at the same time.
>   	A positive integer allows up to that number of submodules fetched
> diff --git a/advice.c b/advice.c
> index 1dfc91d176..e00d30254c 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -70,6 +70,7 @@ static struct {
>   	[ADVICE_STATUS_HINTS]				= { "statusHints", 1 },
>   	[ADVICE_STATUS_U_OPTION]			= { "statusUoption", 1 },
>   	[ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = { "submoduleAlternateErrorStrategyDie", 1 },
> +	[ADVICE_SUBMODULES_NOT_UPDATED] 		= { "submodulesNotUpdated", 1 },
>   	[ADVICE_UPDATE_SPARSE_PATH]			= { "updateSparsePath", 1 },
>   	[ADVICE_WAITING_FOR_EDITOR]			= { "waitingForEditor", 1 },
>   };
> diff --git a/advice.h b/advice.h
> index 601265fd10..a7521d6087 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -44,6 +44,7 @@ struct string_list;
>   	ADVICE_STATUS_HINTS,
>   	ADVICE_STATUS_U_OPTION,
>   	ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE,
> +	ADVICE_SUBMODULES_NOT_UPDATED,
>   	ADVICE_UPDATE_SPARSE_PATH,
>   	ADVICE_WAITING_FOR_EDITOR,
>   	ADVICE_SKIPPED_CHERRY_PICKS,
> diff --git a/branch.c b/branch.c
> index 528cb2d639..404766d01d 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -8,6 +8,8 @@
>   #include "sequencer.h"
>   #include "commit.h"
>   #include "worktree.h"
> +#include "submodule-config.h"
> +#include "run-command.h"
>   
>   struct tracking {
>   	struct refspec_item spec;
> @@ -345,6 +347,127 @@ void create_branch(struct repository *r, const char *name,
>   	free(real_ref);
>   }
>   
> +static int submodule_validate_branchname(struct repository *r, const char *name,
> +					 const char *start_name, int force,
> +					 int quiet, char **err_msg)
> +{
> +	int ret = 0;
> +	struct child_process child = CHILD_PROCESS_INIT;
> +	struct strbuf child_err = STRBUF_INIT;
> +	child.git_cmd = 1;
> +	child.err = -1;
> +
> +	prepare_other_repo_env(&child.env_array, r->gitdir);
> +	strvec_pushl(&child.args, "branch", "--dry-run", NULL);
> +	if (force)
> +		strvec_push(&child.args, "--force");
> +	if (quiet)
> +		strvec_push(&child.args, "--quiet");
> +	strvec_pushl(&child.args, name, start_name, NULL);
> +
> +	if ((ret = start_command(&child)))
> +		return ret;
> +	ret = finish_command(&child);
> +	strbuf_read(&child_err, child.err, 0);
> +	*err_msg = strbuf_detach(&child_err, NULL);
> +	return ret;
> +}
> +
> +static int submodule_create_branch(struct repository *r, const char *name,
> +				   const char *start_oid,
> +				   const char *start_name, int force,
> +				   int reflog, int quiet,
> +				   enum branch_track track, char **err_msg)
> +{
> +	int ret = 0;
> +	struct child_process child = CHILD_PROCESS_INIT;
> +	struct strbuf child_err = STRBUF_INIT;
> +	child.git_cmd = 1;
> +	child.err = -1;
> +
> +	prepare_other_repo_env(&child.env_array, r->gitdir);
> +	strvec_pushl(&child.args, "submodule--helper", "create-branch", NULL);
> +	if (force)
> +		strvec_push(&child.args, "--force");
> +	if (quiet)
> +		strvec_push(&child.args, "--quiet");
> +	if (reflog)
> +		strvec_push(&child.args, "--create-reflog");
> +	if (track == BRANCH_TRACK_ALWAYS || track == BRANCH_TRACK_EXPLICIT)
> +		strvec_push(&child.args, "--track");
> +
> +	strvec_pushl(&child.args, name, start_oid, start_name, NULL);
> +
> +	if ((ret = start_command(&child)))
> +		return ret;
> +	ret = finish_command(&child);
> +	strbuf_read(&child_err, child.err, 0);
> +	*err_msg = strbuf_detach(&child_err, NULL);
> +	return ret;
> +}
> +
> +void create_submodule_branches(struct repository *r, const char *name,
> +			       const char *start_name, int force, int reflog,
> +			       int quiet, enum branch_track track)
> +{
> +	int i = 0;
> +	char *branch_point = NULL;
> +	struct repository *subrepos;
> +	struct submodule *submodules;
> +	struct object_id super_oid;
> +	struct submodule_entry_list *submodule_entry_list;
> +	char *err_msg = NULL;
> +
> +	validate_branch_start(r, start_name, track, &super_oid, &branch_point);
> +
> +	submodule_entry_list = submodules_of_tree(r, &super_oid);
> +	CALLOC_ARRAY(subrepos, submodule_entry_list->entry_nr);
> +	CALLOC_ARRAY(submodules, submodule_entry_list->entry_nr);
> +
> +	for (i = 0; i < submodule_entry_list->entry_nr; i++) {
> +		submodules[i] = *submodule_from_path(
> +			r, &super_oid,
> +			submodule_entry_list->name_entries[i].path);
> +
> +		if (repo_submodule_init(
> +			    &subrepos[i], r,
> +			    submodule_entry_list->name_entries[i].path,
> +			    &super_oid)) {
> +			die(_("submodule %s: unable to find submodule"),
> +			    submodules[i].name);
> +			if (advice_enabled(ADVICE_SUBMODULES_NOT_UPDATED))
> +				advise(_("You may try initializing the submodules using 'git checkout %s && git submodule update'"),
> +				       start_name);

Apart from what Ævar pointed out about advise() being called after die(),
I'm not sure this is the right advice, because if repo_submodule_init fails
it means there is no .git/modules/<name> directory corresponding to the submodule's
Git repository, i.e. the submodule was never cloned. So it's not guaranteed
that 'git checkout $start_name && git submodule update' would initialize (and clone) it,
not without '--init'.

> +		}
> +
> +		if (submodule_validate_branchname(
> +			    &subrepos[i], name,
> +			    oid_to_hex(
> +				    &submodule_entry_list->name_entries[i].oid),
> +			    force, quiet, &err_msg))
> +			die(_("submodule %s: could not create branch '%s'\n\t%s"),
> +			    submodules[i].name, name, err_msg);

minor nit abour wording: we did not try to create the branch here, we just checked if
creating is possible. So it *might* be confusing (maybe not). Maybe just "can not"
instead of "could not" ?

> +	}
> +
> +	create_branch(the_repository, name, start_name, force, 0, reflog, quiet,
> +		      track);

OK, here we create the superproject branch. This might not be expected when
just reading the name of the function...

> +
> +	for (i = 0; i < submodule_entry_list->entry_nr; i++) {

Here we loop over all submodules, so branches are created even in
inactive submodules... this might not be wanted.

> +		printf_ln(_("submodule %s: creating branch '%s'"),
> +			  submodules[i].name, name);
> +		if (submodule_create_branch(
> +			    &subrepos[i], name,
> +			    oid_to_hex(
> +				    &submodule_entry_list->name_entries[i].oid),
> +			    branch_point, force, reflog, quiet, track,
> +			    &err_msg))
> +			die(_("submodule %s: could not create branch '%s'\n\t%s"),
> +			    submodules[i].name, name, err_msg);
> +
> +		repo_clear(&subrepos[i]);
> +	}
> +}
> +
>   void remove_merge_branch_state(struct repository *r)
>   {
>   	unlink(git_path_merge_head(r));
> diff --git a/branch.h b/branch.h
> index d8e5ff4e28..1b4a635a2f 100644
> --- a/branch.h
> +++ b/branch.h
> @@ -76,6 +76,12 @@ void create_branch(struct repository *r,
>   		   int force, int clobber_head_ok,
>   		   int reflog, int quiet, enum branch_track track);
>   
> +/*
> + * Creates a new branch in repository and its submodules.
> + */
> +void create_submodule_branches(struct repository *r, const char *name,
> +			       const char *start_name, int force, int reflog,
> +			       int quiet, enum branch_track track);
>   /*
>    * Check if 'name' can be a valid name for a branch; die otherwise.
>    * Return 1 if the named branch already exists; return 0 otherwise.
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 5d4b9c82b4..6a16bdb1a3 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -39,6 +39,8 @@ static const char * const builtin_branch_usage[] = {
>   
>   static const char *head;
>   static struct object_id head_oid;
> +static int recurse_submodules = 0;
> +static int submodule_propagate_branches = 0;
>   
>   static int branch_use_color = -1;
>   static char branch_colors[][COLOR_MAXLEN] = {
> @@ -101,6 +103,15 @@ static int git_branch_config(const char *var, const char *value, void *cb)
>   			return config_error_nonbool(var);
>   		return color_parse(value, branch_colors[slot]);
>   	}
> +	if (!strcmp(var, "submodule.recurse")) {
> +		recurse_submodules = git_config_bool(var, value);
> +		return 0;
> +	}
> +	if (!strcasecmp(var, "submodule.propagateBranches")) {
> +		submodule_propagate_branches = git_config_bool(var, value);
> +		return 0;
> +	}
> +
>   	return git_color_default_config(var, value, cb);
>   }
>   
> @@ -621,7 +632,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>   	int delete = 0, rename = 0, copy = 0, force = 0, list = 0, create = 0,
>   	    unset_upstream = 0, show_current = 0, edit_description = 0;
>   	/* possible options */
> -	int reflog = 0, quiet = 0, dry_run = 0, icase = 0;
> +	int reflog = 0, quiet = 0, dry_run = 0, icase = 0,
> +	    recurse_submodules_explicit = 0;
>   	const char *new_upstream = NULL;
>   	enum branch_track track;
>   	struct ref_filter filter;
> @@ -670,6 +682,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>   		OPT_CALLBACK(0, "points-at", &filter.points_at, N_("object"),
>   			N_("print only branches of the object"), parse_opt_object_name),
>   		OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
> +		OPT_BOOL(0, "recurse-submodules", &recurse_submodules_explicit, N_("recurse through submodules")),
>   		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
>   		OPT__DRY_RUN(&dry_run, N_("show whether the branch would be created")),
>   		OPT_END(),
> @@ -713,9 +726,16 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>   	if (create < 0)
>   		usage_with_options(builtin_branch_usage, options);
>   
> +	if (recurse_submodules_explicit && submodule_propagate_branches &&
> +	    !create)
> +		die(_("--recurse-submodules can only be used to create branches"));
>   	if (dry_run && !create)
>   		die(_("--dry-run can only be used when creating branches"));
>   
> +	recurse_submodules =
> +		(recurse_submodules || recurse_submodules_explicit) &&
> +		submodule_propagate_branches;
> +

OK, so we get the new behaviour if either --recurse-submodules was used, or 'submodule.recurse' is true,
and in both case we also need the new submodule.propagateBranches config set.

Why not adding 'branch.recurseSubmodules' instead, with a higher priority than submodule.recurse ?
Is it because then it would be mildly confusing for 'git checkout / git switch' to also honor
a setting named 'branch.*' when they learn the new behaviour ? (I don't think this would be the
first time that 'git foo' honors 'bar.*', so it might be worth mentioning).

Also, why do we quietly ignore '--recurse-submodules' if submodule.propagateBranches is unset ?
Wouldn't it be better to warn the user "hey, if you want this new behaviour you need to
set that config !" ?

I don't have a strong opinion about the fact that you need to set the config in the first
place, but I think it should be mentioned in the commit message why you chose to implement
it that way (meaning, why do we need a config set, instead of adding the config but defaulting it
to true, so that you get the new behaviour by default, but you still can disable it if you do not
want it)...

>   	if (filter.abbrev == -1)
>   		filter.abbrev = DEFAULT_ABBREV;
>   	filter.ignore_case = icase;
> @@ -874,6 +894,12 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>   			FREE_AND_NULL(unused_full_ref);
>   			return 0;
>   		}
> +		if (recurse_submodules) {
> +			create_submodule_branches(the_repository, branch_name,
> +						  start_name, force, reflog,
> +						  quiet, track);
> +			return 0;
> +		}
>   		create_branch(the_repository, branch_name, start_name, force, 0,
>   			      reflog, quiet, track);
>   	} else
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 6298cbdd4e..3ea1e8cc96 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -20,6 +20,7 @@
>   #include "diff.h"
>   #include "object-store.h"
>   #include "advice.h"
> +#include "branch.h"
>   
>   #define OPT_QUIET (1 << 0)
>   #define OPT_CACHED (1 << 1)
> @@ -2983,6 +2984,37 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
>   	return !!ret;
>   }
>   
> +static int module_create_branch(int argc, const char **argv, const char *prefix)
> +{
> +	enum branch_track track;
> +	int quiet = 0, force = 0, reflog = 0;
> +
> +	struct option options[] = {
> +		OPT__QUIET(&quiet, N_("print only error messages")),
> +		OPT__FORCE(&force, N_("force creation"), 0),
> +		OPT_BOOL(0, "create-reflog", &reflog,
> +			 N_("create the branch's reflog")),
> +		OPT_SET_INT('t', "track", &track,
> +			    N_("set up tracking mode (see git-pull(1))"),
> +			    BRANCH_TRACK_EXPLICIT),
> +		OPT_END()
> +	};
> +	const char *const usage[] = {
> +		N_("git submodule--helper create-branch [-f|--force] [--create-reflog] [-q|--quiet] [-t|--track] <name> <start_oid> <start_name>"),
> +		NULL
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options, usage, 0);
> +
> +	if (argc != 3)
> +		usage_with_options(usage, options);
> +
> +	create_branch(the_repository, argv[0], argv[1], force, 0, reflog, quiet,
> +		      BRANCH_TRACK_NEVER);
> +	setup_tracking(argv[0], argv[2], track, quiet, 0);
> +
> +	return 0;
> +}
>   struct add_data {
>   	const char *prefix;
>   	const char *branch;
> @@ -3379,6 +3411,7 @@ static struct cmd_struct commands[] = {
>   	{"config", module_config, 0},
>   	{"set-url", module_set_url, 0},
>   	{"set-branch", module_set_branch, 0},
> +	{"create-branch", module_create_branch, 0},
>   };
>   
>   int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
> diff --git a/t/t3207-branch-submodule.sh b/t/t3207-branch-submodule.sh
> new file mode 100755
> index 0000000000..14ff066e91
> --- /dev/null
> +++ b/t/t3207-branch-submodule.sh
> @@ -0,0 +1,249 @@
> +#!/bin/sh
> +
> +test_description='git branch submodule tests'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-rebase.sh
> +
> +test_expect_success 'setup superproject and submodule' '
> +	git init super &&
> +	test_commit foo &&
> +	git init sub-upstream &&
> +	test_commit -C sub-upstream foo &&
> +	git -C super submodule add ../sub-upstream sub &&
> +	git -C super commit -m "add submodule" &&
> +	git -C super config submodule.propagateBranches true
> +'
> +
> +cleanup_branches() {
> +	super_dir="$1"
> +	shift
> +	(
> +		cd "$super_dir" &&
> +		git checkout main &&
> +		for branch_name in "$@"; do
> +			git branch -D "$branch_name"
> +			git submodule foreach "(git checkout main && git branch -D $branch_name) || true"
> +		done
> +	)
> +} >/dev/null 2>/dev/null
> +
> +# Test the argument parsing
> +test_expect_success '--recurse-submodules should create branches' '
> +	test_when_finished "cleanup_branches super branch-a" &&
> +	(
> +		cd super &&
> +		git branch --recurse-submodules branch-a &&
> +		git rev-parse --abbrev-ref branch-a &&
> +		git -C sub rev-parse --abbrev-ref branch-a
> +	)
> +'
> +
> +test_expect_success '--recurse-submodules should be ignored if submodule.propagateBranches is false' '
> +	test_when_finished "cleanup_branches super branch-a" &&
> +	(
> +		cd super &&
> +		git -c submodule.propagateBranches=false branch --recurse-submodules branch-a &&
> +		git rev-parse branch-a &&
> +		test_must_fail git -C sub rev-parse branch-a
> +	)
> +'
> +
> +test_expect_success '--recurse-submodules should fail when not creating branches' '
> +	test_when_finished "cleanup_branches super branch-a" &&
> +	(
> +		cd super &&
> +		git branch --recurse-submodules branch-a &&
> +		test_must_fail git branch --recurse-submodules -D branch-a &&
> +		# Assert that the branches were not deleted
> +		git rev-parse --abbrev-ref branch-a &&
> +		git -C sub rev-parse --abbrev-ref branch-a
> +	)
> +'
> +
> +test_expect_success 'should respect submodule.recurse when creating branches' '
> +	test_when_finished "cleanup_branches super branch-a" &&
> +	(
> +		cd super &&
> +		git -c submodule.recurse=true branch branch-a &&
> +		git rev-parse --abbrev-ref branch-a &&
> +		git -C sub rev-parse --abbrev-ref branch-a
> +	)
> +'
> +
> +test_expect_success 'should ignore submodule.recurse when not creating branches' '
> +	test_when_finished "cleanup_branches super branch-a" &&
> +	(
> +		cd super &&
> +		git branch --recurse-submodules branch-a &&
> +		git -c submodule.recurse=true branch -D branch-a &&
> +		test_must_fail git rev-parse --abbrev-ref branch-a &&
> +		git -C sub rev-parse --abbrev-ref branch-a
> +	)
> +'
> +
> +# Test branch creation behavior
> +test_expect_success 'should create branches based off commit id in superproject' '
> +	test_when_finished "cleanup_branches super branch-a branch-b" &&
> +	(
> +		cd super &&
> +		git branch --recurse-submodules branch-a &&
> +		git checkout --recurse-submodules branch-a &&
> +		git -C sub rev-parse HEAD >expected &&
> +		# Move the tip of sub:branch-a so that it no longer matches the commit in super:branch-a
> +		git -C sub checkout branch-a &&
> +		test_commit -C sub bar &&
> +		# Create a new branch-b branch with start-point=branch-a
> +		git branch --recurse-submodules branch-b branch-a &&
> +		git rev-parse branch-b &&
> +		git -C sub rev-parse branch-b >actual &&
> +		# Assert that the commit id of sub:second-branch matches super:branch-a and not sub:branch-a
> +		test_cmp expected actual
> +	)
> +'
> +
> +test_expect_success 'should not create any branches if branch is not valid for all repos' '
> +	test_when_finished "cleanup_branches super branch-a" &&
> +	(
> +		cd super &&
> +		git -C sub branch branch-a &&
> +		test_must_fail git branch --recurse-submodules branch-a 2>actual &&
> +		test_must_fail git rev-parse branch-a &&
> +
> +		cat >expected <<EOF &&
> +fatal: submodule sub: could not create branch ${SQ}branch-a${SQ}
> +	fatal: A branch named ${SQ}branch-a${SQ} already exists.
> +
> +EOF
> +		test_cmp expected actual
> +	)
> +'
> +
> +test_expect_success 'should create branches if branch exists and --force is given' '
> +	test_when_finished "cleanup_branches super branch-a" &&
> +	(
> +		cd super &&
> +		git -C sub rev-parse HEAD >expected &&
> +		test_commit -C sub baz &&
> +		git -C sub branch branch-a HEAD~1 &&
> +		git branch --recurse-submodules --force branch-a &&
> +		git rev-parse branch-a &&
> +		# assert that sub:branch-a was moved
> +		git -C sub rev-parse branch-a >actual &&
> +		test_cmp expected actual
> +	)
> +'
> +
> +test_expect_success 'should create branch when submodule is in .git/modules but not .gitmodules' '
> +	test_when_finished "cleanup_branches super branch-a branch-b branch-c" &&
> +	(
> +		cd super &&
> +		git branch branch-a &&
> +		git checkout -b branch-b &&
> +		git submodule add ../sub-upstream sub2 &&
> +		# branch-b now has a committed submodule not in branch-a
> +		git commit -m "add second submodule" &&
> +		git checkout branch-a &&
> +		git branch --recurse-submodules branch-c branch-b &&
> +		git rev-parse branch-c &&
> +		git -C sub rev-parse branch-c &&
> +		git checkout --recurse-submodules branch-c &&
> +		git -C sub2 rev-parse branch-c
> +	)
> +'
> +
> +test_expect_success 'should set up tracking of local branches with track=always' '
> +	test_when_finished "cleanup_branches super branch-a" &&
> +	(
> +		cd super &&
> +		git -c branch.autoSetupMerge=always branch --recurse-submodules branch-a main &&
> +		git -C sub rev-parse main &&
> +		test "$(git -C sub config branch.branch-a.remote)" = . &&
> +		test "$(git -C sub config branch.branch-a.merge)" = refs/heads/main
> +	)
> +'
> +
> +test_expect_success 'should set up tracking of local branches with explicit track' '
> +	test_when_finished "cleanup_branches super branch-a" &&
> +	(
> +		cd super &&
> +		git branch --track --recurse-submodules branch-a main &&
> +		git -C sub rev-parse main &&
> +		test "$(git -C sub config branch.branch-a.remote)" = . &&
> +		test "$(git -C sub config branch.branch-a.merge)" = refs/heads/main
> +	)
> +'
> +
> +test_expect_success 'should not set up unnecessary tracking of local branches' '
> +	test_when_finished "cleanup_branches super branch-a" &&
> +	(
> +		cd super &&
> +		git branch --recurse-submodules branch-a main &&
> +		git -C sub rev-parse main &&
> +		test "$(git -C sub config branch.branch-a.remote)" = "" &&
> +		test "$(git -C sub config branch.branch-a.merge)" = ""
> +	)

don't we have a "config is empty" test helper or something similar ?

> +'
> +
> +test_expect_success 'setup remote-tracking tests' '
> +	(
> +		cd super &&
> +		git branch branch-a &&
> +		git checkout -b branch-b &&
> +		git submodule add ../sub-upstream sub2 &&
> +		# branch-b now has a committed submodule not in branch-a
> +		git commit -m "add second submodule"
> +	) &&
> +	(
> +		cd sub-upstream &&
> +		git branch branch-a
> +	) &&
> +	git clone --branch main --recurse-submodules super super-clone &&
> +	git -C super-clone config submodule.propagateBranches true
> +'
> +
> +test_expect_success 'should not create branch when submodule is not in .git/modules' '
> +	# The cleanup needs to delete sub2:branch-b in particular because main does not have sub2
> +	test_when_finished "git -C super-clone/sub2 branch -D branch-b && \
> +		cleanup_branches super-clone branch-a branch-b" &&
> +	(
> +		cd super-clone &&
> +		# This should succeed because super-clone has sub.
> +		git branch --recurse-submodules branch-a origin/branch-a &&
> +		# This should fail because super-clone does not have sub2.
> +		test_must_fail git branch --recurse-submodules branch-b origin/branch-b 2>actual &&
> +		cat >expected <<-EOF &&
> +		fatal: submodule sub: unable to find submodule
> +		You may reinitialize the submodules using ${SQ}git checkout origin/branch-b && git submodule update${SQ}
> +		EOF
> +		test_must_fail git rev-parse branch-b &&
> +		test_must_fail git -C sub rev-parse branch-b &&
> +		# User can fix themselves by initializing the submodule
> +		git checkout origin/branch-b &&
> +		git submodule update &&
> +		git branch --recurse-submodules branch-b origin/branch-b
> +	)

Considering what has been pointed out above, I'm not sure why this test passes...
Unless I'm missing something.

> +'
> +
> +test_expect_success 'should set up tracking of remote-tracking branches' '
> +	test_when_finished "cleanup_branches super-clone branch-a" &&
> +	(
> +		cd super-clone &&
> +		git branch --recurse-submodules branch-a origin/branch-a &&
> +		test "$(git -C sub config branch.branch-a.remote)" = origin &&
> +		test "$(git -C sub config branch.branch-a.merge)" = refs/heads/branch-a
> +	)
> +'
> +
> +test_expect_success 'should not fail when unable to set up tracking in submodule' '
> +	test_when_finished "cleanup_branches super-clone branch-b" &&
> +	(
> +		cd super-clone &&
> +		git branch --recurse-submodules branch-b origin/branch-b
> +	)
> +'
> +
> +test_done
> 

Cheers,

Philippe.
