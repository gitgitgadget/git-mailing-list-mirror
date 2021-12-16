Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A86BC433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 19:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241152AbhLPT5f (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 14:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhLPT5c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 14:57:32 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46D5C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 11:57:32 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id c6-20020aa781c6000000b004a4fcdf1d6dso166630pfn.4
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 11:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wcb/QdscrDDOSvVxUWxH0RxtMNxV6c7LoE/lpSKIiq8=;
        b=VrNlXBReTEBn3wC+Kj3PyYiIzGc5gpujLcZxoAV0VysIiMX2ERGhD06YvvrSod93mp
         dnem/KZE2ZNqlcJtSl9VrlQk0iPaCPuSWtQ9FCX/Uh7ZgA8dthElcfjQS1RloY4JR6dw
         7qNCohxnUU1kyVzUl0wAlCOiWz9236ej0wSLDnse4qR6esGA0eNa9IW6ISsmufo4H4Nh
         STTkZFMj7mH7RaFFNyMo7hU/g+Z6YORtA5uVJrsZhdiuk666vhm6gniBPLlemNdH1q2z
         /M7aea0dgJ3RJMOUuDHSkQ+zzFj3b3JMw+2dWYqpX32bKvpS6Y7zcYHcG8g7qNhrwZcz
         FTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wcb/QdscrDDOSvVxUWxH0RxtMNxV6c7LoE/lpSKIiq8=;
        b=KUnQ6i01EYzqSbKTi1Io81L9+qCnBEd7KbX/wn/+97Lmt/QgmgpZQglEXwta0i5JkQ
         Vsg+kOqQL/XJ+9L1nemBDP31njUZkmPAwb31mS6WmdHqoLRHDuD7UPUt1OlPktKDuXbR
         DKF8V4ggenZBcoWkyce8U+jGL591m7ltxUJBpEPN2LCESuVvSEE0KTtsgglfnSsm3G+6
         ESd1UHHo11tWPO3VcnIIIrnmD3xOwN3iQDRMX4G1KsR4nnnjIAwPn9WPUBarP5Z3CJe2
         yo1TCMc4WECiyOGrALG8rwZXEf73QFMKfrMyMM5Kp1mM4A0OuhkSmw38gE7u/SKH8SKZ
         sOog==
X-Gm-Message-State: AOAM532NQpE28qlKLbpKAvX3CvsKaEopRpyrPvt+9Nqd959T6eNJlIyN
        x1BsoOmOUUYmRtgnTLrOHLbGikQtk/otyA==
X-Google-Smtp-Source: ABdhPJy6qqbA0yUr5n4ZWDchcADJfWPvKO6mGCjqcavWepcXVuAUcb4RODjtshRiQbPjpUqJ2wpNRT+MP24JpQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1903:b0:4b1:3b26:25c4 with SMTP
 id y3-20020a056a00190300b004b13b2625c4mr15588651pfi.9.1639684651975; Thu, 16
 Dec 2021 11:57:31 -0800 (PST)
Date:   Thu, 16 Dec 2021 11:57:20 -0800
In-Reply-To: <43d6f83fedc022c44d6a3be249e7fd8cd2a25007.1639524556.git.steadmon@google.com>
Message-Id: <kl6lo85g8grj.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1639524556.git.steadmon@google.com> <43d6f83fedc022c44d6a3be249e7fd8cd2a25007.1639524556.git.steadmon@google.com>
Subject: Re: [PATCH v6 1/3] branch: accept multiple upstream branches for tracking
From:   Glen Choo <chooglen@google.com>
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> --- a/branch.c
> +++ b/branch.c
> @@ -49,25 +49,41 @@ static int should_setup_rebase(const char *origin)
>  	return 0;
>  }
>  
> -static const char tracking_advice[] =
> -N_("\n"
> -"After fixing the error cause you may try to fix up\n"
> -"the remote tracking information by invoking\n"
> -"\"git branch --set-upstream-to=%s%s%s\".");
> -
> -int install_branch_config(int flag, const char *local, const char *origin, const char *remote)
> +/**
> + * Install upstream tracking configuration for a branch; specifically, add
> + * `branch.<name>.remote` and `branch.<name>.merge` entries.
> + *
> + * `flag` contains integer flags for options; currently only
> + * BRANCH_CONFIG_VERBOSE is checked.
> + *
> + * `local` is the name of the branch whose configuration we're installing.
> + *
> + * `origin` is the name of the remote owning the upstream branches. NULL means
> + * the upstream branches are local to this repo.
> + *
> + * `remotes` is a list of refs that are upstream of local
> + */
> +static int install_branch_config_multiple_remotes(int flag, const char *local,
> +		const char *origin, struct string_list *remotes)

Very helpful description. I got slightly confused when I first reviewed
this, so having the comments will help future readers a lot.

>  {
>  	const char *shortname = NULL;
>  	struct strbuf key = STRBUF_INIT;
> +	struct string_list_item *item;
>  	int rebasing = should_setup_rebase(origin);
>  
> -	if (skip_prefix(remote, "refs/heads/", &shortname)
> -	    && !strcmp(local, shortname)
> -	    && !origin) {
> -		warning(_("Not setting branch %s as its own upstream."),
> -			local);
> -		return 0;
> -	}
> +	if (!remotes->nr)
> +		BUG("must provide at least one remote for branch config");
> +	if (rebasing && remotes->nr > 1)
> +		die(_("cannot inherit upstream tracking configuration when rebasing is requested"));

Nit: if we're being pedantic, we cannot inherit upstream tracking
configuration when rebasing is requested with multiple upstream
branches.

But this message is already very niche and loaded with specifics, so
adding "...with multiple upstream branches" might just be more
confusing, so this is a nit.

> @@ -75,8 +91,17 @@ int install_branch_config(int flag, const char *local, const char *origin, const
>  
>  	strbuf_reset(&key);
>  	strbuf_addf(&key, "branch.%s.merge", local);
> -	if (git_config_set_gently(key.buf, remote) < 0)
> +	/*
> +	 * We want to overwrite any existing config with all the branches in
> +	 * "remotes". Override any existing config, then write our branches. If
> +	 * more than one is provided, use CONFIG_REGEX_NONE to preserve what
> +	 * we've written so far.
> +	 */
> +	if (git_config_set_gently(key.buf, NULL) < 0)
>  		goto out_err;
> +	for_each_string_list_item(item, remotes)
> +		if (git_config_set_multivar_gently(key.buf, item->string, CONFIG_REGEX_NONE, 0) < 0)
> +			goto out_err;

We get to use for_each_string_item() now, nice.

> @@ -87,29 +112,42 @@ int install_branch_config(int flag, const char *local, const char *origin, const
>  	strbuf_release(&key);
>  
>  	if (flag & BRANCH_CONFIG_VERBOSE) {
> -		if (shortname) {
> +		const char *name;
> +		struct strbuf ref_string = STRBUF_INIT;
> +
> +		for_each_string_list_item(item, remotes) {
> +			name = item->string;
> +			skip_prefix(name, "refs/heads/", &name);
> +			strbuf_addf(&ref_string, "  %s\n", name);
> +		}
> +
> +		if (remotes->nr == 1) {
> +			struct strbuf refname = STRBUF_INIT;
> +
>  			if (origin)
> -				printf_ln(rebasing ?
> -					  _("Branch '%s' set up to track remote branch '%s' from '%s' by rebasing.") :
> -					  _("Branch '%s' set up to track remote branch '%s' from '%s'."),
> -					  local, shortname, origin);
> -			else
> -				printf_ln(rebasing ?
> -					  _("Branch '%s' set up to track local branch '%s' by rebasing.") :
> -					  _("Branch '%s' set up to track local branch '%s'."),
> -					  local, shortname);
> +				strbuf_addf(&refname, "%s/", origin);
> +			strbuf_addstr(&refname, remotes->items[0].string);
> +
> +			/*
> +			 * Rebasing is only allowed in the case of a single
> +			 * upstream branch.
> +			 */
> +			printf_ln(rebasing ?
> +				_("branch '%s' set up to track '%s' by rebasing.") :
> +				_("branch '%s' set up to track '%s'."),
> +				local, refname.buf);
> +
> +			strbuf_release(&refname);
> +		} else if (origin) {
> +			printf_ln(_("branch '%s' set up to track from '%s':"),
> +				local, origin);
> +			printf("%s", ref_string.buf);

It's not clear to me why the hint contains the word 'from' when it is a
remote ref...

>  		} else {
> -			if (origin)
> -				printf_ln(rebasing ?
> -					  _("Branch '%s' set up to track remote ref '%s' by rebasing.") :
> -					  _("Branch '%s' set up to track remote ref '%s'."),
> -					  local, remote);
> -			else
> -				printf_ln(rebasing ?
> -					  _("Branch '%s' set up to track local ref '%s' by rebasing.") :
> -					  _("Branch '%s' set up to track local ref '%s'."),
> -					  local, remote);
> +			printf_ln(_("branch '%s' set up to track:"), local);
> +			printf("%s", ref_string.buf);

but does not have the word 'from' when it is a local ref. As far as I
can tell, this is the only difference between remote and local refs, and
adding the word 'from' does not seem like a good enough reason to add an
'if' condition. Maybe I missed something here?

This motivates my answer to the question you asked in [1]:

  I removed as many distinctions as possible, as most can still be
  inferred from context. [...] Likewise, we don't need to specify whether
  refs are remote or local: "some-remote/some-branch" vs.
  "a-local-branch" should be understandable without us spelling it out.

I agree that there is adequate context, so I would be ok with the
simplification if there was corresponding code simplification e.g.
dropping "if (origin)". But in its current form, I don't think there is
good enough reason to simplify the message.

Of course, IIUC, this is as simple as dropping 'from' in the "if
(origin)" case.

> @@ -118,14 +156,33 @@ int install_branch_config(int flag, const char *local, const char *origin, const
>  	strbuf_release(&key);
>  	error(_("Unable to write upstream branch configuration"));
>  
> -	advise(_(tracking_advice),
> -	       origin ? origin : "",
> -	       origin ? "/" : "",
> -	       shortname ? shortname : remote);
> +	advise(_("\nAfter fixing the error cause you may try to fix up\n"
> +		"the remote tracking information by invoking:"));
> +	if (remotes->nr == 1)
> +		advise("  git branch --set-upstream-to=%s%s%s",
> +			origin ? origin : "",
> +			origin ? "/" : "",
> +			remotes->items[0].string);
> +	else
> +		for_each_string_list_item(item, remotes)
> +			advise("  git config --add branch.\"%s\".merge %s",
> +				local, item->string);

The advice is now correct, nice! Does the user also need to run "git
config --add branch.%s.remote %s" ?

[1] https://lore.kernel.org/git/Ybk6QsMdeBl6IweW@google.com
