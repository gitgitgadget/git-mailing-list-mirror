Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0940C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 20:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A452461606
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 20:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbhBIUhA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 15:37:00 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50005 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbhBIUeG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 15:34:06 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BBE2410C1F9;
        Tue,  9 Feb 2021 15:32:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rhkpdFXACypX2MrxxNwg5Yc2Bo4=; b=kdqk7e
        i+92c6tghEoIA22XvZkEvXi4EblA1pMlYSZDnaQDX2YQKR524Ruu/GUmYn3pNHrQ
        XyE9Or00NWPtaZuuB+uxJUD1HAKDLdZUfa88QcGl4K0tizH8dAD3JnqsZDtX6TKe
        bpX/9DwJJ+jPAwaNiDt0t9ooaLsLO+cWjUlzI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZjGgHoq+nCcnCor5XqZY7t5abpiyWvGy
        bMevauD3RZd0nyoESxc4JQZkMVo/ovPGGSx04UTxmd+NURwm1kysNtLAoy/cSeUK
        yxubgbXFcBFYwQfWU5QypcDBM4xcUtNn6FHlCvBa3a158RXZ+bYa4KcNbQoQlLmc
        1w53S0Qpx3c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B4A8910C1F8;
        Tue,  9 Feb 2021 15:32:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 04EE010C1F4;
        Tue,  9 Feb 2021 15:32:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        dscho <johannes.schindelin@gmx.de>,
        Li Linchao <lilinchao@oschina.cn>
Subject: Re: [PATCH v3] builtin/clone.c: add --reject-shallow option
References: <pull.865.v2.git.1612773119.gitgitgadget@gmail.com>
        <pull.865.v3.git.1612793576910.gitgitgadget@gmail.com>
Date:   Tue, 09 Feb 2021 12:32:44 -0800
In-Reply-To: <pull.865.v3.git.1612793576910.gitgitgadget@gmail.com> (Li
        Linchao via GitGitGadget's message of "Mon, 08 Feb 2021 14:12:56
        +0000")
Message-ID: <xmqqy2fx0yoj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F7C5D392-6B15-11EB-8F5D-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Li Linchao via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: lilinchao <lilinchao@oschina.cn>
>
> In some scenarios, users may want more history than the repository
> offered for cloning, which mostly to be a shallow repository, can
> give them.

Sorry, but I find this hard to understand.  Are you saying that most
of the repositories that users try to clone from are shallow?

> But users don't know it is a shallow repository until
> they download it to local, users should have the option to refuse
> to clone this kind of repository, and may want to exit the process
> immediately without creating any unnecessary files.

This one on the other hand is easy to understand, but we would
probably need something like s/But/But because/.

> Althought there is an option '--depth=x' for users to decide how
> deep history they can fetch, but as the unshallow cloning's depth
> is INFINITY, we can't know exactly the minimun 'x' value that can
> satisfy the minimum integrity, so we can't pass 'x' value to --depth,
> and expect this can obtain a complete history of a repository.

Hmph, that is an interesting point.  This makes me wonder if we can
achieve the same without adding a new option at the UI level (e.g.
by allowing "--depth" to take "infinity" and reject cloning if we
find out that the origin repository is a shallow one).  But we can
worry about it later once after we get the machinery driven by the
UI right.

> In other scenarios, given that we have an API that allow us to import
> external repository, and then perform various operations on the repo.

Sorry, but I do not understand what you want to say with these two
lines ("Given that X and Y" needs to be followed by a concluding
statement, e.g. "Given that we have API to import and operate, we
can do Z"---you are missing that "we can do Z" part).

> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index 02d9c19cec75..af5a97903a05 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -15,7 +15,7 @@ SYNOPSIS
>  	  [--dissociate] [--separate-git-dir <git dir>]
>  	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
>  	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
> -	  [--[no-]remote-submodules] [--jobs <n>] [--sparse]
> +	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--reject-shallow]

Isn't it "--[no-]reject-shallow"?  Offering the negation from the
command line is essential if "[clone] rejectshallow" configuration
is allowed to set the default to true.

> +--reject-shallow::
> +	Don't clone a shallow source repository. In some scenarios, clients
> +	want the cloned repository information to be complete. Otherwise,
> +	the cloning process should end immediately without creating any files,
> +	which can save some disk space. This can override `clone.rejectshallow`
> +	from the configuration:
> +
> +	--------------------------------------------------------------------
> +	$ git -c clone.rejectshallow=false clone --reject-shallow source out
> +	--------------------------------------------------------------------
> +
> +	While there is a way to countermand a configured "I always refuse to
> +	clone from a shallow repository" with "but let's allow it only this time":
> +
> +	----------------------------------------------------------------------
> +	$ git -c clone.rejectshallow=true clone --no-reject-shallow source out
> +	----------------------------------------------------------------------


This is way too verbose and gives unnecessary details that readers
already know or do not need to know (e.g. setting configuration from
the command line and immediately override it from the command line
is not something end-users would EVER need to do---only test writers
who develop Git would need it).  Something like

    Fail if the source repository is a shallow repository.  The
    `clone.rejectShallow` configuration variable can be used to
    give the default.   

would be sufficient.  All readers ought to know when a configuration
and command line option exist, the latter can be used to override
the default former gives, and it is *not* a job for the description
of an individual option to teach them to such a detail like the
above does.

> +static int option_no_shallow = -1;  /* unspecified */
> +static int config_shallow = -1;    /* unspecified */

Hmph.  I would have expected the usual "prepare a single variable
and initialize it to the default, read the config to set it, and
then parse the command line to overwrite it" sequence would suffice
so it is puzzling why we want two separate variables here.

Let's read on to find out.

> @@ -90,6 +92,8 @@ static struct option builtin_clone_options[] = {
>  	OPT__VERBOSITY(&option_verbosity),
>  	OPT_BOOL(0, "progress", &option_progress,
>  		 N_("force progress reporting")),
> +	OPT_BOOL(0, "reject-shallow", &option_no_shallow,
> +		 N_("don't clone shallow repository")),
>  	OPT_BOOL('n', "no-checkout", &option_no_checkout,
>  		 N_("don't create a checkout")),
>  	OPT_BOOL(0, "bare", &option_bare, N_("create a bare repository")),
> @@ -858,6 +862,9 @@ static int git_clone_config(const char *k, const char *v, void *cb)
>  		free(remote_name);
>  		remote_name = xstrdup(v);
>  	}
> +	if (!strcmp(k, "clone.rejectshallow")) {
> +		config_shallow = git_config_bool(k, v);
> +	}
>  	return git_default_config(k, v, cb);
>  }

You are adding to git_clone_config(), so instead of setting the
value to config_shallow, setting the value to the same variable that
will be used in builtin_clone_options[] array should be sufficient.

cmd_clone() begins like so:


	git_config(git_clone_config, NULL);
	argc = parse_options(...);

which means that single variable (let's call it reject_shallow)
can (1) stay to be its initial value if no config or option is
given, (2) if there is config, the git_config() call will cause
that variable assigned, (3) if there is option, parse_options()
call will cause that variable assigned, possibly overwriting the
value taken from the config.

Which is exactly what we want.  So in short, declare just a single

    static int reject_shallow; /* default to false */
    
instead of "option_no_shallow" and "config_shallow", and use it in
both builtin_clone_options[] given to parse_options, and
git_clone_config() that is given to git_config(), and you'd be fine,
I think.

> @@ -963,6 +970,7 @@ static int path_exists(const char *path)
>  int cmd_clone(int argc, const char **argv, const char *prefix)
>  {
>  	int is_bundle = 0, is_local;
> +	int is_shallow = 0;
>  	const char *repo_name, *repo, *work_tree, *git_dir;
>  	char *path, *dir, *display_repo = NULL;
>  	int dest_exists, real_dest_exists = 0;
> @@ -1205,6 +1213,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  
>  	path = get_repo_path(remote->url[0], &is_bundle);
>  	is_local = option_local != 0 && path && !is_bundle;
> +
> +	/* Detect if the remote repository is shallow */
> +	if (!access(mkpath("%s/shallow", path), F_OK)) {
> +		is_shallow = 1;
> +	}

This is only for cloning from a local repository, no?  IOW, path at
this point may even be "git://github.com/git/git/" and checking with
access() does not make sense.

Ah, it is even worse.  get_repo_path() can return NULL, so mkpath()
will crash in such a case.  This must be at least

	if (path && !access(mkpath("%s/shallow", path), F_OK))
		is_shallow = 1;

but I think the logic fits better in the body of "if (is_Local)"
thing that immediately follows.  It is specific to the case where
cloning from a local repository and access(mkpath()) that is about
the local filesystem (as opposed to going through the transport
layer) belongs there.

>  	if (is_local) {
>  		if (option_depth)
>  			warning(_("--depth is ignored in local clones; use file:// instead."));
> @@ -1214,7 +1228,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  			warning(_("--shallow-exclude is ignored in local clones; use file:// instead."));
>  		if (filter_options.choice)
>  			warning(_("--filter is ignored in local clones; use file:// instead."));
> -		if (!access(mkpath("%s/shallow", path), F_OK)) {
> +		if (is_shallow) {
>  			if (option_local > 0)
>  				warning(_("source repository is shallow, ignoring --local"));
>  			is_local = 0;

So, I think the above two hunks are making the code worse.  If we
are to detect and reject cloning from the shallow repository when
going through the transport layer (i.e. "--no-local" or cloning from
"git://github.com/git/git", or "https://github.com/git/git", if it
were a shallow repository), that must be handled separately.

> @@ -1222,6 +1236,25 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	}
>  	if (option_local > 0 && !is_local)
>  		warning(_("--local is ignored"));
> +
> +	if (is_shallow) {
> +		int reject = 0;
> +
> +		/* If option_no_shallow is specified from CLI option,
> +		 * ignore config_shallow from git_clone_config.
> +		 */
> +
> +		if (config_shallow != -1) {
> +			reject = config_shallow;
> +		}
> +		if (option_no_shallow != -1) {
> +			reject = option_no_shallow;
> +		}

I do not think any of the above is necessary with just a single
reject_shallow variable that is initialized to 0, can be set by
git_config() callback, and can further be set by parse_options().

> +		if (reject) {
> +			die(_("source repository is shallow, reject to clone."));
> +		}

> +	}
> +
>  	transport->cloning = 1;
>  
>  	transport_set_option(transport, TRANS_OPT_KEEP, "yes");

I do not see how this change would allow users to reject cloning
http://github.com/git/git, if that repository were shallow, though.
I think that would need changes to the code that interacts with
these transport_* functions we see later part of this functrion.

Thanks.
