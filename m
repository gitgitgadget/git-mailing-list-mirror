Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDA4C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 13:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F16E261058
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 13:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238958AbhG3Nf5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 09:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhG3Nf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 09:35:57 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903EAC061765
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 06:35:52 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id h27so6355665qtu.9
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 06:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=09C8CxVPbSVRk53pTEIrwrXR+/RappFsVlg5/5bd2fw=;
        b=ev1khBPa3kBgLbJZTKI+klDMsTGLlgiceNh/rcTTIeo2MvoJBTL6nrskUXX1Kbjith
         X6hD+ece9qvYPcNsbuzSWoWE/PuLE7NHM4Ckq5/hurXltPMGWlR4AX9QBXTMBe8NIdqs
         QcLyUr+hmImfJGcDLEnoAfpsmMgyr/7MF7zQJv9yaJWdZtB4nDGDTGwZnmcFEo70kmLT
         lUnVR3dgv//gKWnM5GVA3XC8PvbbiC90L8iyIsIye9uCVaeIdm9/igSTngJLSDQTmZli
         1Po9060GY3K5JkQWz3y/1qwat0RyJ+ZD35fHTw8YaE3MvFqFfRkMmrOZyB7Nv/R25pGV
         BGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=09C8CxVPbSVRk53pTEIrwrXR+/RappFsVlg5/5bd2fw=;
        b=qwlQ1Px9INXLkwb9ld9P+g8vfiyknrh0WGTREQX+gkP/33+LqFrXwgy6Tb2+7orK31
         t1Kc1L+cgK9r0OjPldE6EEniihq18RxFpk8iOocDe9mWf5NsODwQpgYj1NGlCUrTwMob
         7wmrXWgZvdBxUeuUSZ6EyzzuGNFGraOicwDoiW86CJrUtoJhE5tRu4wLxQ0adXAqFtUM
         YjwGyq5GD8naSvqpmYq4VspsjoEq+UFTJNu4fOzYGOc0+XNqTAuy4tpvW3+JtVbnjb4u
         4iYpA3eluwKuf96aYpCORA31wKcQroLsjl2Wix6McWbEL+cpMVRJP40OYHxCaiaBi4eC
         6wdA==
X-Gm-Message-State: AOAM533zIu39wgHpOLwXpLi1OVOCvNLbgmNr82WOniFsA5Gy8NYHjkig
        kOdG0tMguhXglrbwjjRk4yY=
X-Google-Smtp-Source: ABdhPJxBCHFK/Fh8KjVD+uVzGX98aXw6fLjqsjVPFCYOJCK75fjGBYgln3SpYgGDIL37h7mzMsM0QQ==
X-Received: by 2002:ac8:682:: with SMTP id f2mr2289325qth.55.1627652151542;
        Fri, 30 Jul 2021 06:35:51 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id k14sm623582qtm.18.2021.07.30.06.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 06:35:51 -0700 (PDT)
Subject: Re: [PATCH 1/1] config: support a default remote tracking setup upon
 branch creation
To:     Ben Boeckel <mathstuf@gmail.com>, git@vger.kernel.org
Cc:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>
References: <20210728135041.501850-1-mathstuf@gmail.com>
 <20210729020125.746206-1-mathstuf@gmail.com>
 <20210729020125.746206-2-mathstuf@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <bcbe13a8-7f22-7564-77cd-674c7b2acbf6@gmail.com>
Date:   Fri, 30 Jul 2021 09:35:49 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729020125.746206-2-mathstuf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 2021-07-28 à 22:01, Ben Boeckel a écrit :
> The `branch.autoSetupMerge` works well today for setting up tracking a
> local branch, but there is no easy mechanism to automatically set up a
> remote tracking situation for workflows which use a single set of
> branches for integration without specifying `--track` to every branch
> creation command or branching directly from the remote ref. This patch
> adds the following configuration values:
> 
>    - `branch.defaultRemote`: initializes `branch.<name>.remote` if not
>      otherwise given;
>    - `branch.defaultMerge`: initializes `branch.<name>.merge` if not
>      otherwise given.
> 
> These effectively make branch creation commands such as `git branch`,
> `git switch`, and `git checkout -b` have an implicit `-t
> ${branch.defaultRemote}/${branch.defaultMerge}` argument and is
> equivalent to doing:
> 
>      $ git branch new-topic      # or another branch creation command
>      $ git branch --set-upstream-to=${branch.defaultRemote}/${branch.defaultMerge} new-topic
> 
> In a fork-based workflow where contributions to the main project flow in
> through forks of the main repository rather than pushing directly to it
> (not uncommon of forge-hosted projects), the following setup may be
> used:
> 
>      $ git config remote.pushDefault myfork    # push to `myfork` by default
>      $ git config push.default simple          # the default
>      $ git config branch.autoSetupMerge always # always setup tracking

OK, so if I understand correctly this exisiting setting has to be changed
to 'always' for the new settings you are adding to take effect, right ?
I think this does make sense, reading the description of 'branch.autoSetupMerge',
but maybe it should be spelled explicitely in the text of the commit message,
and not just mentioned here in this terminal session excerpt.

>      $ git config branch.defaultRemote origin  # track from `origin`
>      $ git config branch.defaultMerge main     # track the `main` branch

Small nit: maybe I would invert these two, so it can read:

       $ git config branch.defaultMerge main     # track the `main` branch ...
       $ git config branch.defaultRemote origin  # ... from `origin`
> 
> With this setup, branches will automatically be set up to track
> `origin/main` while being pushed to `myfork` by default. Some tools
> (at least Vim's fugitive plugin) will show the commit differences
> between both the tracking branch and the default push target. This
> allows such tools to easily show "what needs to be merged?", "what has
> happened on the target branch since this topic has been created?", and
> "what is my status against my fork's current status?" at a glance.
> 
> Additionally, with the `extensions.worktreeConfig` setting, when a
> separate work tree which is used for changes against a different branch
> (e.g., a branch tracking a prior release), the `branch.defaultMerge`
> setting may be changed independently, e.g., to `maint`.

This last paragraph is not explicitely needed, as nothing relating to
'extensions.worktreeConfig' is changed here right ? It's just the normal
way that this setting works.

> 
> Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
> ---
>   Documentation/config/branch.txt | 14 ++++++++++++
>   branch.c                        | 22 ++++++++++---------
>   branch.h                        |  2 ++
>   config.c                        | 10 +++++++++
>   environment.c                   |  2 ++
>   t/t3200-branch.sh               | 39 +++++++++++++++++++++++++++++++++
>   6 files changed, 79 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
> index cc5f3249fc..ab5cd2c1ed 100644
> --- a/Documentation/config/branch.txt
> +++ b/Documentation/config/branch.txt
> @@ -1,3 +1,17 @@
> +branch.defaultRemote::
> +	Tells 'git branch', 'git switch' and 'git checkout' to set up new branches
> +	so that it will track a branch on the specified remote. This can be
> +	used, in conjunction with `branch.defaultMerge`, in projects where
> +	branches tend to target a single branch. This will be used to
> +	initialize the "branch.<name>.remote" setting.
> +
> +branch.defaultMerge::
> +	Tells 'git branch', 'git switch' and 'git checkout' to set up new branches
> +	so that it will track a branch with this name. This can be used, in
> +	conjunction with `branch.defaultRemote` in projects where branches tend
> +	to target a single branch. This will be used to initialize the
> +	"branch.<name>.merge" setting.

For the two setting above, if 'branch.autoSetupMerge' must be set to 'always' for
the settings to work, I think it should be explicitely mentioned.

> +
>   branch.autoSetupMerge::
>   	Tells 'git branch', 'git switch' and 'git checkout' to set up new branches
>   	so that linkgit:git-pull[1] will appropriately merge from the
> diff --git a/branch.c b/branch.c
> index 7a88a4861e..097d5af647 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -60,6 +60,8 @@ int install_branch_config(int flag, const char *local, const char *origin, const
>   	const char *shortname = NULL;
>   	struct strbuf key = STRBUF_INIT;
>   	int rebasing = should_setup_rebase(origin);
> +	const char *actual_origin = origin ? origin : git_branch_remote;
> +	const char *actual_remote = remote ? remote : git_branch_merge;
>   
>   	if (skip_prefix(remote, "refs/heads/", &shortname)
>   	    && !strcmp(local, shortname)
> @@ -70,12 +72,12 @@ int install_branch_config(int flag, const char *local, const char *origin, const
>   	}
>   
>   	strbuf_addf(&key, "branch.%s.remote", local);
> -	if (git_config_set_gently(key.buf, origin ? origin : ".") < 0)
> +	if (git_config_set_gently(key.buf, actual_origin ? actual_origin : ".") < 0)
>   		goto out_err;
>   
>   	strbuf_reset(&key);
>   	strbuf_addf(&key, "branch.%s.merge", local);
> -	if (git_config_set_gently(key.buf, remote) < 0)
> +	if (git_config_set_gently(key.buf, actual_remote) < 0)
>   		goto out_err;
>   
>   	if (rebasing) {
> @@ -88,27 +90,27 @@ int install_branch_config(int flag, const char *local, const char *origin, const
>   
>   	if (flag & BRANCH_CONFIG_VERBOSE) {
>   		if (shortname) {
> -			if (origin)
> +			if (actual_origin)
>   				printf_ln(rebasing ?
>   					  _("Branch '%s' set up to track remote branch '%s' from '%s' by rebasing.") :
>   					  _("Branch '%s' set up to track remote branch '%s' from '%s'."),
> -					  local, shortname, origin);
> +					  local, shortname, actual_origin);
>   			else
>   				printf_ln(rebasing ?
>   					  _("Branch '%s' set up to track local branch '%s' by rebasing.") :
>   					  _("Branch '%s' set up to track local branch '%s'."),
>   					  local, shortname);
>   		} else {
> -			if (origin)
> +			if (actual_origin)
>   				printf_ln(rebasing ?
>   					  _("Branch '%s' set up to track remote ref '%s' by rebasing.") :
>   					  _("Branch '%s' set up to track remote ref '%s'."),
> -					  local, remote);
> +					  local, actual_remote);
>   			else
>   				printf_ln(rebasing ?
>   					  _("Branch '%s' set up to track local ref '%s' by rebasing.") :
>   					  _("Branch '%s' set up to track local ref '%s'."),
> -					  local, remote);
> +					  local, actual_remote);
>   		}
>   	}
>   
> @@ -119,9 +121,9 @@ int install_branch_config(int flag, const char *local, const char *origin, const
>   	error(_("Unable to write upstream branch configuration"));
>   
>   	advise(_(tracking_advice),
> -	       origin ? origin : "",
> -	       origin ? "/" : "",
> -	       shortname ? shortname : remote);
> +	       actual_origin ? actual_origin : "",
> +	       actual_origin ? "/" : "",
> +	       shortname ? shortname : actual_remote);
>   
>   	return -1;
>   }
> diff --git a/branch.h b/branch.h
> index df0be61506..7d7990dda7 100644
> --- a/branch.h
> +++ b/branch.h
> @@ -14,6 +14,8 @@ enum branch_track {
>   };
>   
>   extern enum branch_track git_branch_track;
> +extern const char* git_branch_remote;
> +extern const char* git_branch_merge;
>   
>   /* Functions for acting on the information about branches. */
>   
> diff --git a/config.c b/config.c
> index f33abeab85..a46c5a43a1 100644
> --- a/config.c
> +++ b/config.c
> @@ -1599,6 +1599,16 @@ static int git_default_branch_config(const char *var, const char *value)
>   			return error(_("malformed value for %s"), var);
>   		return 0;
>   	}
> +	if (!strcmp(var, "branch.defaultremote")) {
> +		if (!value)
> +			return config_error_nonbool(var);
> +		return git_config_string(&git_branch_remote, var, value);
> +	}
> +	if (!strcmp(var, "branch.defaultmerge")) {
> +		if (!value)
> +			return config_error_nonbool(var);
> +		return git_config_string(&git_branch_merge, var, value);
> +	}
>   
>   	/* Add other config variables here and to Documentation/config.txt. */
>   	return 0;
> diff --git a/environment.c b/environment.c
> index 2f27008424..d550deabbd 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -60,6 +60,8 @@ int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
>   char *check_roundtrip_encoding = "SHIFT-JIS";
>   unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
>   enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
> +const char* git_branch_remote = NULL;
> +const char* git_branch_merge = NULL;

Can the new settings be implemented without adding more global variables ?
I think we are trying to move away from these. Apart from that the code
looks OK to me.

>   enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
>   enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
>   #ifndef OBJECT_CREATION_MODE
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index cc4b10236e..82137e8451 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -797,6 +797,45 @@ test_expect_success 'test tracking setup via --track but deeper' '
>   	test "$(git config branch.my7.merge)" = refs/heads/o/o
>   '
>   
> +test_expect_success 'test tracking setup via branch.default* and --track' '
> +	git config branch.autosetupmerge always &&

You can use 'test_config branch.autosetupmerge always' so that the
config is only active for the duration of the 'test_expect_success' block
(see t/test-lib-functions.sh).

> +	git config branch.defaultremote local &&
> +	git config branch.defaultmerge main &&
> +	git config remote.local.url . &&
> +	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
> +	(git show-ref -q refs/remotes/local/main || git fetch local) &&
> +	git branch --track other/foo my2 &&
> +	git config branch.autosetupmerge false &&
> +	test "$(git config branch.my2.remote)" = other &&

Here and for the following line you can use 'test_cmp_config'.

> +	test "$(git config branch.my2.merge)" = refs/heads/foo
> +'

This tests checks that an explicit '--track' argument overrides the new configs.
I would name it something like "'--track overrides 'branch.default{merge,remote}'"
or something like this. I would also add another test before this one that just
checks that the new settings by themselves work as expected;
i.e. a simple 'git checkout -b' and verifying that the
tracking info is correctly configured according to 'branch.default{merge,remote}'.

> +
> +test_expect_success 'test tracking setup via branch.default* and --no-track' '
> +	git config branch.autosetupmerge always &&
> +	git config branch.defaultremote local &&
> +	git config branch.defaultmerge main &&
> +	git config remote.local.url . &&
> +	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
> +	(git show-ref -q refs/remotes/local/main || git fetch local) &&
> +	git branch --no-track my2 &&
> +	git config branch.autosetupmerge false &&
> +	! test "$(git config branch.my2.remote)" = local &&
> +	! test "$(git config branch.my2.merge)" = refs/heads/main

Here you expect the configs to be absent, so for more clarity you could
do

     git config branch.my2.remote >remote &&
     test_must_be_empty remote

and the same for merge.

> +'
> +
> +test_expect_success 'test tracking setup via branch.default*' '
> +	git config branch.autosetupmerge always &&
> +	git config branch.defaultremote local &&
> +	git config branch.defaultmerge main &&
> +	git config remote.local.url . &&
> +	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
> +	(git show-ref -q refs/remotes/local/main || git fetch local) &&
> +	git branch my2 &&
> +	git config branch.autosetupmerge false &&
> +	test "$(git config branch.my2.remote)" = local &&
> +	test "$(git config branch.my2.merge)" = refs/heads/main
> +'
> +
>   test_expect_success 'test deleting branch deletes branch config' '
>   	git branch -d my7 &&
>   	test -z "$(git config branch.my7.remote)" &&
> 

Oh, so here is the 'just test the new settings' test. Let's move that
one to be before the two others.

Another test that could be added is one that does not change
'branch.autosetupmerge' but sets the new configs, and checks that the
tracking info is *not* set.

Cheers,

Philippe.


