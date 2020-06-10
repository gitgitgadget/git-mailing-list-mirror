Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CC3C433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 17:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DA4B2072E
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 17:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzkI0t4j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbgFJRMC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbgFJRMC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 13:12:02 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC271C03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 10:12:00 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m7so1193207plt.5
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 10:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CaxGR3LJcS9FDTxnfhmkGTA2iry5JAiNujeIvlo7UiI=;
        b=WzkI0t4j/4B9S8nP2j2UYrCbf/kDCyw2WNWFeECLx0LZPlOZVmuNpTnegWV/gjin0J
         Xb49l3QRKgKnBIfyMkA2jgyXaZYDUcUtMpA2sFgVWWkO+yr82AuFFxs64sVSp3w0e1J2
         WVA1emuIPU+3iyuD9iVDA7hiKQokTjwc3+fbbooUn7ebKa7Q25oQC6LxHIwAoNDOSex+
         lj4d/iTEStMRgBtC5M4ZflDGzN39auTDOtTXR2TZOYNqVbZADdO3kzyNuo0h2+EysMwe
         94YdyruFqPQUBBl/5NFbcpXqHJwLd1K5q7B0jP6iAeSZdpFKbj4dxV22q5nmOBVWqmUg
         jyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CaxGR3LJcS9FDTxnfhmkGTA2iry5JAiNujeIvlo7UiI=;
        b=n2lGS2HOiH19UDUORW5zw3AW/72BJ6w1nIOMMGkc3Loi0CvAJ1ZCHnOVtD79RuRbzi
         H/GeLIN5OpaDzC90Gvr86tvCWyQmVLC/Yb6tXBEGOSL7LH//4UzJzc5JcGzMZadgt40F
         mggeExpVWFBQQZfTKzRg78SYaxTfyxmtAZx53mdLpLh749ojWLsYcKs4DVbJqcw+q2B1
         b+/EpSoMChA6got6NuJruV+HC6O6fHLORr432Cz5Tc6X9tfr5rwAsImSLiulLw1qL25O
         EPh2ez3G972iFPBP4Kz9dNCasNFU3+SqZJa2A02gE+jm6ed2pkg0iriP2Ekq7HJOHQvv
         LHiQ==
X-Gm-Message-State: AOAM533E3+Ida5TsMgAZ6GPD9pAC7DxDq0pxtl29SJ+jyok6eje0rqHH
        cncpaOLMZHCvF9jLWP1WBzG98EsDOcA=
X-Google-Smtp-Source: ABdhPJxQEKwcESiRGXc/oqFN8+Nf+vhLfqYnjEq99EMlN2xdGPNb+OpXOp51HV0SSxWMhIxOKKStyg==
X-Received: by 2002:a17:90b:88b:: with SMTP id bj11mr4142143pjb.51.1591809120206;
        Wed, 10 Jun 2020 10:12:00 -0700 (PDT)
Received: from konoha ([103.37.201.173])
        by smtp.gmail.com with ESMTPSA id a11sm470166pff.39.2020.06.10.10.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 10:11:59 -0700 (PDT)
Date:   Wed, 10 Jun 2020 22:41:53 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     pclouds@gmail.com, jonathanmueller.dev@gmail.com,
        gitster@pobox.com, ramsay@ramsayjones.plus.com, git@vger.kernel.org
Subject: Re: [PATCH v2 6/7] worktree: generalize candidate worktree path
 validation
Message-ID: <20200610171153.GA39055@konoha>
References: <20200610063049.74666-1-sunshine@sunshineco.com>
 <20200610063049.74666-7-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610063049.74666-7-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/06 02:30, Eric Sunshine wrote:
> "git worktree add" checks that the specified path is a valid location
> for a new worktree by ensuring that the path does not already exist and
> is not already registered to another worktree (a path can be registered
> but missing, for instance, if it resides on removable media). Since "git
> worktree add" is not the only command which should perform such
> validation ("git worktree move" ought to also), generalize the the
> validation function for use by other callers, as well.

There is an extra 'the' after generalize.

> -static void validate_worktree_add(const char *path, const struct add_opts *opts)
> +/* check that path is viable location for worktree */
> +static void check_candidate_path(const char *path,
> +				 int force,
> +				 struct worktree **worktrees,
> +				 const char *cmd)
>  {
> -	struct worktree **worktrees;
>  	struct worktree *wt;
>  	int locked;
>  
>  	if (file_exists(path) && !is_empty_dir(path))
>  		die(_("'%s' already exists"), path);
>  
> -	worktrees = get_worktrees(0);
>  	wt = find_worktree_by_path(worktrees, path);
>  	if (!wt)
> -		goto done;
> +		return;

Should we do a 'return 1' on failure instead of just a blank 'return' so
that we can denote failure of finding a worktree?

>  	locked = !!worktree_lock_reason(wt);
> -	if ((!locked && opts->force) || (locked && opts->force > 1)) {
> +	if ((!locked && force) || (locked && force > 1)) {
>  		if (delete_git_dir(wt->id))
> -		    die(_("unable to re-add worktree '%s'"), path);
> -		goto done;
> +		    die(_("unusable worktree destination '%s'"), path);
> +		return;
>  	}
>  
>  	if (locked)
> -		die(_("'%s' is a missing but locked worktree;\nuse 'add -f -f' to override, or 'unlock' and 'prune' or 'remove' to clear"), path);
> +		die(_("'%s' is a missing but locked worktree;\nuse '%s -f -f' to override, or 'unlock' and 'prune' or 'remove' to clear"), cmd, path);

Let's wrap this to 72 characters at maximum per line maybe? Meaning that
the error message gets split into 2 lines.

> -		die(_("'%s' is a missing but already registered worktree;\nuse 'add -f' to override, or 'prune' or 'remove' to clear"), path);
> -
> -done:
> -	free_worktrees(worktrees);
> +		die(_("'%s' is a missing but already registered worktree;\nuse '%s -f' to override, or 'prune' or 'remove' to clear"), cmd, path);

Similarly here.

>  
>  static int add_worktree(const char *path, const char *refname,
> @@ -324,8 +323,12 @@ static int add_worktree(const char *path, const char *refname,
>  	struct commit *commit = NULL;
>  	int is_branch = 0;
>  	struct strbuf sb_name = STRBUF_INIT;
> +	struct worktree **worktrees;
>  
> -	validate_worktree_add(path, opts);
> +	worktrees = get_worktrees(0);
> +	check_candidate_path(path, opts->force, worktrees, "add");
> +	free_worktrees(worktrees);
> +	worktrees = NULL;
>  
>  	/* is 'refname' a branch or commit? */
>  	if (!opts->detach && !strbuf_check_branch_ref(&symref, refname) &&

It is necessary to call 'free_worktrees(worktrees)' at the end right?
The 'get_worktrees()' function states that
    The caller is responsible for freeing the memory from the returned
    worktree(s).
