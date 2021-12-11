Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604BDC433F5
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 18:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhLKSIQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 13:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhLKSIP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Dec 2021 13:08:15 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F58AC061714
        for <git@vger.kernel.org>; Sat, 11 Dec 2021 10:08:15 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id o17so11499922qtk.1
        for <git@vger.kernel.org>; Sat, 11 Dec 2021 10:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fgaAgGHwuqPe1rvWsu032DzqSZZl5XpQPAh1OJScxO0=;
        b=LzA7KBgJe+LlIATcqf+BDWyBGcD2rIlrCIlnf7YyX6ZVzD/9Gayx+voqSu39NwToII
         QO4absNspqHSsql5+Lpa9Qi+VzOhVgfJyx0jJV2rmoWC8n1Hn3FrMl9UaR/u//avTLDM
         1L622Ow2QuQrzLVbGJjrjG9uGdLWbmAkjjLH6oYF+3hwNOnjLaZLcm8Vov1+OumZlYYI
         CstnT+gClynBEvUfCf/ECrF7Yp2baVgBEFEfJXsGtJV3zO6uI9RpvWGVIXxffM/vRLkO
         Fm6k3QIQDAuzuoc3M9vE6Le1r6fsH1/F73MXD9HbK1LmfRXK0IuLOl39KQ1qKsn1KSJ6
         JEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fgaAgGHwuqPe1rvWsu032DzqSZZl5XpQPAh1OJScxO0=;
        b=hc4nZ+Qj+ODcCtp97iyd56xW5Z4xuE70uB6u+Z6pIzgUnrE9lcYdlA5Hu8AU8fw67t
         s1dzKVbi4IDCYRE3hXFcqEJh/u1xNZ8Qy+ImCaUocbh3zlZ9mP0E5Ap9b1IRrhz1ZLbW
         zAnJqelrEdDHfBxUZhRFvx0gaDs5+epqMF4RGwjXmu4K+BWJeraCHSyEY1d4coMmr8Pb
         PvUy8OxrU7jyJsRZ4bZLq/QyMBcWe0KBkJlWDMvTEkR6tbuaImpNAtK7Ur+PiuRRm4Qm
         kZ0jH8B7IMhRpVXG8UmvnuEw15eyv1apX8UmHb+/ZnAWxxEtsvYiX2fn1WjYkuJs1aVO
         92SQ==
X-Gm-Message-State: AOAM532RuLnEVikKAzPLG8vxUEh0O9FDDy7ylHkQvojaDgX/dDF3XEfo
        VLS3/mhKEt29nM9l/0He3H83EaLX5Bg=
X-Google-Smtp-Source: ABdhPJyID+Mk4hF3oA61VXUjEjok8sefNZplW/FBNrGjmRfh0KHDXthfvyQxzBhuM5T4Hd0M2URS+w==
X-Received: by 2002:ac8:5aca:: with SMTP id d10mr35714530qtd.469.1639246094521;
        Sat, 11 Dec 2021 10:08:14 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id a20sm3308737qkh.63.2021.12.11.10.08.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Dec 2021 10:08:13 -0800 (PST)
Subject: Re: [PATCH v3 4/5] branch: add --recurse-submodules option for branch
 creation
To:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20211206215528.97050-1-chooglen@google.com>
 <20211209184928.71413-1-chooglen@google.com>
 <20211209184928.71413-5-chooglen@google.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <a54c6015-6afb-b25f-d2d2-392bf77e93f0@gmail.com>
Date:   Sat, 11 Dec 2021 13:08:11 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211209184928.71413-5-chooglen@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen,

Le 2021-12-09 à 13:49, Glen Choo a écrit :
> To improve the submodules UX, we would like to teach Git to handle
> branches in submodules. Start this process by teaching `git branch` the
> --recurse-submodules option so that `git branch --recurse-submodules
> topic` will create the "topic" branch in the superproject and its
> submodules.
> 
> Although this commit does not introduce breaking changes, it is
> incompatible with existing --recurse-submodules semantics e.g. `git
> checkout` does not recursively checkout the expected branches created by
> `git branch` yet. To ensure that the correct set of semantics is used,
> this commit introduces a new configuration value,
> `submodule.propagateBranches`, which enables submodule branching when
> true (defaults to false).
> 
> This commit includes changes that allow Git to work with submodules
> that are in trees (and not just the index):
> 
> * add a submodules_of_tree() helper that gives the relevant
>    information of an in-tree submodule (e.g. path and oid) and
>    initializes the repository
> * add is_tree_submodule_active() by adding a treeish_name parameter to
>    is_submodule_active()
> * add the "submoduleNotUpdated" advice to advise users to update the
>    submodules in their trees
> 
> Other changes
> 
> * add a "dry_run" parameter to create_branch() in order to support
>    `git submodule--helper create-branch --dry-run`
> 
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>   Documentation/config/advice.txt    |   3 +
>   Documentation/config/submodule.txt |   8 +

Same comment as I remarked in v1 [1]:

We would need to add the new flag to Documentation/git-branch.txt,
and also probably update the documentation of 'submodule.recurse'
in 'Documentation/config/submodule.txt'.

[1] https://lore.kernel.org/git/3ad3941c-de18-41bf-2e44-4238ae868d79@gmail.com/

>   advice.c                           |   1 +
>   advice.h                           |   1 +
>   branch.c                           | 129 ++++++++++++-
>   branch.h                           |  31 +++-
>   builtin/branch.c                   |  40 +++-
>   builtin/checkout.c                 |   3 +-
>   builtin/submodule--helper.c        |  38 ++++
>   submodule-config.c                 |  35 ++++
>   submodule-config.h                 |  35 ++++
>   submodule.c                        |  11 +-
>   submodule.h                        |   3 +
>   t/t3207-branch-submodule.sh        | 284 +++++++++++++++++++++++++++++
>   14 files changed, 609 insertions(+), 13 deletions(-)
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

I see you added '--init' in the actual message below, but maybe it would be more accurate
to also add it here ?

>   	addIgnoredFile::
>   		Advice shown if a user attempts to add an ignored file to
>   		the index.
> diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
> index ee454f8126..52b35964c0 100644
> --- a/Documentation/config/submodule.txt
> +++ b/Documentation/config/submodule.txt
> @@ -72,6 +72,14 @@ submodule.recurse::
>   	For these commands a workaround is to temporarily change the
>   	configuration value by using `git -c submodule.recurse=0`.
>   
> +submodule.propagateBranches::
> +	[EXPERIMENTAL] A boolean that enables branching support when
> +	using `--recurse-submodules` or `submodule.recurse=true`.
> +	Enabling this will allow certain commands to accept
> +	`--recurse-submodules` and certain commands that already accept
> +	`--recurse-submodules` will now consider branches.
> +	Defaults to false.
> +

Thanks, that updated description seems simpler and more accurate with what
this series is doing.

>   submodule.fetchJobs::
>   	Specifies how many submodules are fetched/cloned at the same time.
>   	A positive integer allows up to that number of submodules fetched

> diff --git a/branch.c b/branch.c
> index 6b9d64cdf9..305154de0b 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -8,6 +8,8 @@


> +void create_branches_recursively(struct repository *r, const char *name,
> +				 const char *start_name,
> +				 const char *tracking_name, int force,
> +				 int reflog, int quiet, enum branch_track track,
> +				 int dry_run)
> +{
> +	int i = 0;
> +	char *branch_point = NULL;
> +	struct object_id super_oid;
> +	struct submodule_entry_list submodule_entry_list;
> +
> +	/* Perform dwim on start_name to get super_oid and branch_point. */
> +	validate_branch_start(r, start_name, BRANCH_TRACK_NEVER, &super_oid,
> +			      &branch_point);
> +
> +	/*
> +	 * If we were not given an explicit name to track, then assume we are at
> +	 * the top level and, just like the non-recursive case, the tracking
> +	 * name is the branch point.
> +	 */
> +	if (!tracking_name)
> +		tracking_name = branch_point;
> +
> +	submodules_of_tree(r, &super_oid, &submodule_entry_list);
> +	/*
> +	 * Before creating any branches, first check that the branch can
> +	 * be created in every submodule.
> +	 */
> +	for (i = 0; i < submodule_entry_list.entry_nr; i++) {
> +		if (submodule_entry_list.entries[i].repo == NULL) {
> +			if (advice_enabled(ADVICE_SUBMODULES_NOT_UPDATED))
> +				advise(_("You may try updating the submodules using 'git checkout %s && git submodule update --init'"),
> +				       start_name);
> +			die(_("submodule '%s': unable to find submodule"),

small nit, maybe write: "unable to find submodule repository" ?

> +			    submodule_entry_list.entries[i].submodule->name);
> +		}
> +
> +		if (submodule_create_branch(
> +			    submodule_entry_list.entries[i].repo,
> +			    submodule_entry_list.entries[i].submodule, name,
> +			    oid_to_hex(&submodule_entry_list.entries[i]
> +						.name_entry->oid),
> +			    tracking_name, force, reflog, quiet, track, 1))

Here, we do not actually use the dry_run argument, since we *always* want to
do a dry run for the submodules...

> +			die(_("submodule '%s': cannot create branch '%s'"),
> +			    submodule_entry_list.entries[i].submodule->name,
> +			    name);
> +	}
> +
> +	create_branch(the_repository, name, start_name, force, 0, reflog, quiet,
> +		      BRANCH_TRACK_NEVER, dry_run);

... whereas for the superproject branch, we use the given dry_run argument...

> +	if (dry_run)
> +		return;
> +	/*
> +	 * NEEDSWORK If tracking was set up in the superproject but not the
> +	 * submodule, users might expect "git branch --recurse-submodules" to
> +	 * fail or give a warning, but this is not yet implemented because it is
> +	 * tedious to determine whether or not tracking was set up in the
> +	 * superproject.
> +	 */
> +	setup_tracking(name, tracking_name, track, quiet, 0);
> +
> +	for (i = 0; i < submodule_entry_list.entry_nr; i++) {
> +		if (submodule_create_branch(
> +			    submodule_entry_list.entries[i].repo,
> +			    submodule_entry_list.entries[i].submodule, name,
> +			    oid_to_hex(&submodule_entry_list.entries[i]
> +						.name_entry->oid),
> +			    tracking_name, force, reflog, quiet, track, 0))

... and if !dry_run, then we do create the branches in the submodules.

That is a little bit hard to follow if you are not careful. Maybe it's just me,
but as I was first reading it I wondered why '0' and '1' were hard-coded as the dry-run
arguments to submodule_create_branch... It would maybe be clearer to use a named
variable ?


> @@ -851,6 +874,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>   		git_config_set_multivar(buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
>   		strbuf_release(&buf);
>   	} else if (!noncreate_actions && argc > 0 && argc <= 2) {
> +		const char *branch_name = argv[0];
> +		const char *start_name = argc == 2 ? argv[1] : head;
> +
>   		if (filter.kind != FILTER_REFS_BRANCHES)
>   			die(_("The -a, and -r, options to 'git branch' do not take a branch name.\n"
>   				  "Did you mean to use: -a|-r --list <pattern>?"));
> @@ -858,10 +884,14 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>   		if (track == BRANCH_TRACK_OVERRIDE)
>   			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead."));
>   
> -		create_branch(the_repository,
> -			      argv[0], (argc == 2) ? argv[1] : head,
> -			      force, 0, reflog, quiet, track);
> -
> +		if (recurse_submodules) {
> +			create_branches_recursively(the_repository, branch_name,
> +						    start_name, NULL, force,
> +						    reflog, quiet, track, 0);

Here again, maybe it would be clearer to use a named variable instead of hard-coding '0' ?

> +			return 0;
> +		}
> +		create_branch(the_repository, branch_name, start_name, force, 0,
> +			      reflog, quiet, track, 0);

Same here.

>   	} else
>   		usage_with_options(builtin_branch_usage, options);
>   

> diff --git a/t/t3207-branch-submodule.sh b/t/t3207-branch-submodule.sh
> new file mode 100755
> index 0000000000..2dd0e2b01f
> --- /dev/null
> +++ b/t/t3207-branch-submodule.sh

The tests look pretty thourough.


> +
> +test_expect_success 'should create branch when submodule is not in HEAD .gitmodules' '

micro-nit: maybe write: HEAD:.gitmodules as this is revision synatx.


Cheers,

Philippe.
