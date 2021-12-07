Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B7CC433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 09:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbhLGJLW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 04:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbhLGJLW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 04:11:22 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DDCC061746
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 01:07:51 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id v1so54207923edx.2
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 01:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Jpes4HRnJXoGki+Jdb6MplA5JDtvg6TAtCS7Tzdb4v0=;
        b=oq5yXZ2LfaGosKPJNB6jtZdYjb39DyZT6AKy7EbfL0u+Zd2nnbXl8DKHqgh90Jgvzj
         aG5o1Fn0nFLUqaIEaAoM035paAMTV+6L6QkQTgP+hXie4g4l5/BmKtQfmWnbN8hv3JFK
         AxTi+v4Uj1FFSKugDPTRyY4Z+A/zU3MCbBBFNZp7iKWKZ8r7sUndurHV2wC6N8P8YKqc
         pGVte3zhTrUnRdqPazYzEiJUlGsXLfZ2QZC4yqng4ZU5+jpbVXPo34loodjPcRaHnW7W
         I79Lc1+RDDX2w5SibBzvFG3Ogwmf3b4i+NZP66/PEtCjLqiz7gtswa9iPjjKqkTyqxHd
         tUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Jpes4HRnJXoGki+Jdb6MplA5JDtvg6TAtCS7Tzdb4v0=;
        b=qT+GWJ74Q0je+i4DweSJ/xkYL5w4or1LAWu967S88OtKjuqIHClMmw0mTLa7WKwNoM
         ys3/fHDym48C9xl4tLQ1tRAX7df2Fqjfbf2VEOJamYeifWYiyq/ZoIAp8GWhYbHEMVV+
         BjqKLYJ2b1nc2/BzTXKxCn5DksN1qbi+jH0iLAKP5kgOJbJBBZ7nFF0PgRONmx7Ghq+j
         r5478n8A2zb4WeoSUWC/3FhKM3ii6WC530df5F84UYsrKAzdngr4YTs6FofwEDzhYfpZ
         d1j11YzN9y4nBVxRq0OrUVk+USsqwyOUz6Rwg0H4SYEbg1t4sY+wb31ESOkaE/QCYZ9A
         7arA==
X-Gm-Message-State: AOAM532iCnRbzz3u0p7ygpTtjdpK9SXGUOCWHowr9IRaPbsHJymGMKiS
        QedRMb7Od2AzR3zaBfW8/8/axLcANCHRxw==
X-Google-Smtp-Source: ABdhPJxPPBLYl0M0WrESYeStlVktFTdV5fqXXnXMdaMKM7IVGCyCUz66PFclO9dJd/JQHxsOGLEAfg==
X-Received: by 2002:a05:6402:4312:: with SMTP id m18mr7015281edc.273.1638868069920;
        Tue, 07 Dec 2021 01:07:49 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g15sm8022603ejt.10.2021.12.07.01.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 01:07:49 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1muWRv-00136t-R1;
        Tue, 07 Dec 2021 10:07:47 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, chooglen@google.com,
        emilyshaffer@google.com
Subject: Re: [PATCH v5 1/2] branch: accept multiple upstream branches for
 tracking
Date:   Tue, 07 Dec 2021 09:57:22 +0100
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1638859949.git.steadmon@google.com>
 <ba7d557725e70f2ae8f10ae5992c8168eb97f2fc.1638859949.git.steadmon@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <ba7d557725e70f2ae8f10ae5992c8168eb97f2fc.1638859949.git.steadmon@google.com>
Message-ID: <211207.86mtlcpyu4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 06 2021, Josh Steadmon wrote:

> Add a new static variant of install_branch_config() that accepts
> multiple remote branch names for tracking. This will be used in an
> upcoming commit that enables inheriting the tracking configuration from
> a parent branch.
>
> Currently, all callers of install_branch_config() pass only a single
> remote. Make install_branch_config() a small wrapper around
> install_branch_config_multiple_remotes() so that existing callers do not
> need to be changed.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  branch.c | 120 ++++++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 87 insertions(+), 33 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 7a88a4861e..1aabef4de0 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -55,19 +55,24 @@ N_("\n"
>  "the remote tracking information by invoking\n"
>  "\"git branch --set-upstream-to=%s%s%s\".");
>  
> -int install_branch_config(int flag, const char *local, const char *origin, const char *remote)
> +static int install_branch_config_multiple_remotes(int flag, const char *local, const char *origin,
> +		struct string_list *remotes)
>  {
>  	const char *shortname = NULL;
>  	struct strbuf key = STRBUF_INIT;
> -	int rebasing = should_setup_rebase(origin);
> -
> -	if (skip_prefix(remote, "refs/heads/", &shortname)
> -	    && !strcmp(local, shortname)
> -	    && !origin) {
> -		warning(_("Not setting branch %s as its own upstream."),
> -			local);
> -		return 0;
> -	}
> +	int i, rebasing = should_setup_rebase(origin);
> +
> +	if (remotes->nr < 1)
> +		BUG("must provide at least one remote for branch config");

Since it's unsigned IMO this would be clearer: if (!remotes->nr)

> +
> +	if (!origin)
> +		for (i = 0; i < remotes->nr; i++)
> +			if (skip_prefix(remotes->items[i].string, "refs/heads/", &shortname)

For this and others, since you don't use the [i] for anything except
getting the current item using for_each_string_list_item() would be
better.

Partially a nit, partially that I've got another WIP
soon-to-be-submitted topic to fix overflow bugs in that API, and not
having "int i" etc. hardcoded in various places
helps. I.e. for_each_string_list_item() is future-proof.

> +			    && !strcmp(local, shortname)) {
> +				warning(_("Not setting branch %s as its own upstream."),

Better to quote '%s', also s/Not/not/ (lower-case) for all error/warning/die etc.

> +					local);
> +				return 0;
> +			}
>  
>  	strbuf_addf(&key, "branch.%s.remote", local);
>  	if (git_config_set_gently(key.buf, origin ? origin : ".") < 0)
> @@ -75,8 +80,17 @@ int install_branch_config(int flag, const char *local, const char *origin, const
>  
>  	strbuf_reset(&key);
>  	strbuf_addf(&key, "branch.%s.merge", local);
> -	if (git_config_set_gently(key.buf, remote) < 0)
> +	/*
> +	 * We want to overwrite any existing config with all the branches in
> +	 * "remotes". Override any existing config with the first branch, but if
> +	 * more than one is provided, use CONFIG_REGEX_NONE to preserve what
> +	 * we've written so far.
> +	 */
> +	if (git_config_set_gently(key.buf, remotes->items[0].string) < 0)
>  		goto out_err;
> +	for (i = 1; i < remotes->nr; i++)
> +		if (git_config_set_multivar_gently(key.buf, remotes->items[i].string, CONFIG_REGEX_NONE, 0) < 0)
> +			goto out_err;
>  
>  	if (rebasing) {
>  		strbuf_reset(&key);
> @@ -87,29 +101,62 @@ int install_branch_config(int flag, const char *local, const char *origin, const
>  	strbuf_release(&key);
>  
>  	if (flag & BRANCH_CONFIG_VERBOSE) {
> -		if (shortname) {
> -			if (origin)
> -				printf_ln(rebasing ?
> -					  _("Branch '%s' set up to track remote branch '%s' from '%s' by rebasing.") :
> -					  _("Branch '%s' set up to track remote branch '%s' from '%s'."),
> -					  local, shortname, origin);
> -			else
> -				printf_ln(rebasing ?
> -					  _("Branch '%s' set up to track local branch '%s' by rebasing.") :
> -					  _("Branch '%s' set up to track local branch '%s'."),
> -					  local, shortname);
> +		int plural = remotes->nr > 1;

This....

> +		int all_shortnames = 1;
> +		const char *msg_fmt;
> +		struct strbuf ref_string = STRBUF_INIT;
> +
> +		for (i = 0; i < remotes->nr; i++)
> +			if (skip_prefix(remotes->items[i].string, "refs/heads/", &shortname)) {
> +				strbuf_addf(&ref_string, "'%s', ", shortname);
> +			} else {
> +				all_shortnames = 0;
> +				strbuf_addf(&ref_string, "'%s', ", remotes->items[i].string);
> +			}
> +		/* The last two characters are an extraneous ", ", so trim those. */
> +		strbuf_setlen(&ref_string, ref_string.len - 2);

languages RTL in around way wrong the be to going is thing of sort This.

:)

We deal with this in most other places by just formatting a list of
branches. E.g. in the ambiguous object output:

    https://lore.kernel.org/git/patch-v5-4.6-36b6b440c37-20211125T215529Z-avarab@gmail.com/

> +
> +		if (all_shortnames && origin) {
> +			if (rebasing && plural)
> +				msg_fmt = "Branch '%s' set up to track remote branches %s from '%s' by rebasing.";
> +			else if (rebasing && !plural)
> +				msg_fmt = "Branch '%s' set up to track remote branch %s from '%s' by rebasing.";
> +			else if (!rebasing && plural)
> +				msg_fmt = "Branch '%s' set up to track remote branches %s from '%s'.";
> +			else if (!rebasing && !plural)
> +				msg_fmt = "Branch '%s' set up to track remote branch %s from '%s'.";

...and this is hardcoding plural rules used in English that don't apply
in a lot of other languages...

> +
> +			printf_ln(_(msg_fmt), local, ref_string, origin);
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
> +			if (all_shortnames && !origin && rebasing && plural)
> +				msg_fmt = "Branch '%s' set up to track local branches %s by rebasing.";
> +			if (all_shortnames && !origin && rebasing && !plural)
> +				msg_fmt = "Branch '%s' set up to track local branch %s by rebasing.";
> +			if (all_shortnames && !origin && !rebasing && plural)
> +				msg_fmt = "Branch '%s' set up to track local branches %s.";
> +			if (all_shortnames && !origin && !rebasing && !plural)
> +				msg_fmt = "Branch '%s' set up to track local branch %s.";
> +			if (!all_shortnames && origin && rebasing && plural)
> +				msg_fmt = "Branch '%s' set up to track remote refs %s by rebasing.";
> +			if (!all_shortnames && origin && rebasing && !plural)
> +				msg_fmt = "Branch '%s' set up to track remote ref %s by rebasing.";
> +			if (!all_shortnames && origin && !rebasing && plural)
> +				msg_fmt = "Branch '%s' set up to track remote refs %s.";
> +			if (!all_shortnames && origin && !rebasing && !plural)
> +				msg_fmt = "Branch '%s' set up to track remote ref %s.";
> +			if (!all_shortnames && !origin && rebasing && plural)
> +				msg_fmt = "Branch '%s' set up to track local refs %s by rebasing.";
> +			if (!all_shortnames && !origin && rebasing && !plural)
> +				msg_fmt = "Branch '%s' set up to track local ref %s by rebasing.";
> +			if (!all_shortnames && !origin && !rebasing && plural)
> +				msg_fmt = "Branch '%s' set up to track local refs %s.";
> +			if (!all_shortnames && !origin && !rebasing && !plural)
> +				msg_fmt = "Branch '%s' set up to track local ref %s.";

...in English you've got one dog, then dogs, so == 1 and >1, but in
various other languages it's:

    git grep Plural-Forms -- po

Anyway, this is easily solved, and even with less verbosity, see:

    git grep -E -W '\bQ_\('

For examples of how to use the magic of libintl to do this for you.

> +
> +			printf_ln(_(msg_fmt), local, ref_string);

...also s/Branch/branch/ for all of them/.

>  		}
> +
> +		strbuf_release(&ref_string);
>  	}
>  
>  	return 0;
> @@ -121,11 +168,18 @@ int install_branch_config(int flag, const char *local, const char *origin, const
>  	advise(_(tracking_advice),
>  	       origin ? origin : "",
>  	       origin ? "/" : "",
> -	       shortname ? shortname : remote);
> +	       remotes->items[0].string);
>  
>  	return -1;
>  }
>  
> +int install_branch_config(int flag, const char *local, const char *origin, const char *remote) {

nit: overly long line..
> +	struct string_list remotes = STRING_LIST_INIT_DUP;

nit: an extra \n after variable decls...

> +	string_list_append(&remotes, remote);
> +	return install_branch_config_multiple_remotes(flag, local, origin, &remotes);
> +	string_list_clear(&remotes, 0);
> +}
> +
>  /*
>   * This is called when new_ref is branched off of orig_ref, and tries
>   * to infer the settings for branch.<new_ref>.{remote,merge} from the

