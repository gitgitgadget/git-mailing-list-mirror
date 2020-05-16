Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A262C433DF
	for <git@archiver.kernel.org>; Sat, 16 May 2020 10:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2837206D4
	for <git@archiver.kernel.org>; Sat, 16 May 2020 10:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8JxhwZc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgEPKhx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 06:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726212AbgEPKhx (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 06:37:53 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F584C061A0C
        for <git@vger.kernel.org>; Sat, 16 May 2020 03:37:53 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q24so2232237pjd.1
        for <git@vger.kernel.org>; Sat, 16 May 2020 03:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GFOfppgc+MrildXgTrk0u126fzla51DgYk1PE0+ifxc=;
        b=s8JxhwZcKOeF8cTCL3l2hbyjyTWE4tf/uh0kdscJwY4zv1ArHFOZENMKPeRhHh8Wz0
         1HsLlBLMreiCZ91vnc4U+sYz237eV1+1BDe7gb+FY6AC00wps09hJnbVFLwPNnIkSwIN
         4O/UH3qNxjz19SRTjlXV/YWaI4IjRtckg3A330khmD244nfkcA6RJYTk8ZPpOxnXLcYe
         aOWChtw7V6sPsKYbGmR3IU/dYnUetSv3IdPd8PTCQYPy3ISDKol7xy+iz96u2bYeM2i5
         BqYH1+LS0Y5Ip5+8wDBOz0fN436CqO6KM2m1v/CihGdFrGURQYhhhyyG3sUWblgWF1bC
         CWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GFOfppgc+MrildXgTrk0u126fzla51DgYk1PE0+ifxc=;
        b=n5cRrpHpNsNy0JsK5F/5StAru+J6R855ceeq3g0JP3nJmns7LtSXDWlRJ2oNbRMVwM
         c6HOJ0E+JYBzdxJMGsMhBXt1jAjdZicnFDq5bIprdUKFo2LibWi2M6nhQz+tgMWHBjQj
         iBxj0QMdEypIpp47qj1BhbF0RkH6zgthCJ02sYO7mIxnf+pnHpbWshsMebTjjbgV+OGy
         t9bVNi6N2DP+TbgnjFZ3KZL1/uV/HNlmFe1aRTYbEpZgEBLX8KZ0EllyAac2Tse2RHMM
         Fg5mu6zlqWR4un/z5lmQEe17DmRkuZlbXfBWeaIekr/h2dBGrIC0gfs/VcOGYipdnbK9
         Azdw==
X-Gm-Message-State: AOAM530MHUTsNqZojBIzQf6q7XHyxrqloR2LZ1DXc+//yBlgRLcVXGF9
        t32hujD1pYqWce0BP9I29Vw=
X-Google-Smtp-Source: ABdhPJw9u6j7ZmKPwmifKJYQhh6c6BLpZDq/Om3EOfC39cMYywFOVqB/tZb3M3uwklH7ei428nomow==
X-Received: by 2002:a17:902:b948:: with SMTP id h8mr7388211pls.309.1589625472338;
        Sat, 16 May 2020 03:37:52 -0700 (PDT)
Received: from konoha ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id 78sm3686132pgd.33.2020.05.16.03.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 03:37:51 -0700 (PDT)
Date:   Sat, 16 May 2020 16:07:44 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, gitster@pobox.com
Subject: Re: [PATCH 1/2] submodule: port subcommand 'set-branch' from shell
 to C
Message-ID: <20200516103744.GA25211@konoha>
References: <20200513201737.55778-1-shouryashukla.oo@gmail.com>
 <20200514101013.GA28018@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514101013.GA28018@generichostname>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/05 06:10, Denton Liu wrote:
> > +	const char *path;
> > +	char *config_name;
> > +
> > +	struct option options[] = {
> > +		OPT__QUIET(&quiet, N_("Suppress output for setting default tracking branch of a submodule")),
> > +		OPT_BOOL(0, "default", &opt_default, N_("Set the default tracking branch to master")),
> > +		OPT_BOOL(0, "branch", &opt_branch, N_("Set the default tracking branch to the one specified")),
> 
> This should use OPT_STRING and accept a string argument instead of using
> the implicit command-line ordering.

I actually was not able to understand the point of this change until I
tried it out myself. It has made the code more aethetic as well as less
redundant. Thanks a ton!

> > +		OPT_END()
> > +	};
> > +	const char *const usage[] = {
> > +		N_("git submodule--helper set-branch [--quiet] (-d|--default) <path>"),
> > +		N_("git submodule--helper set-branch [--quiet] (-b|--branch) <branch> <path>"),
> > +		NULL
> > +	};
> > +
> > +	argc = parse_options(argc, argv, prefix, options, usage, 0);
> > +
> > +	if ((!opt_branch && !opt_default))
> > +		die(_("At least one of --branch and --default required"));
> 
> Error messages in Git are generally written without capitalising the
> first letter of the sentence.

Corrected. BTW, many other subcommands have this problem (the error
messages as well as the options start with a caps and end with a
fullstop). Should they be corrected or let them be as is?

> > +
> > +	if (opt_branch) {
> > +		if (opt_default)
> > +			die(_("--branch and --default do not make sense"));
> 
> This error message should be qualified, perhaps with something like "do
> not make sense together".

Done!

> The same arguments for the above apply to this case too. Actually, the
> only place where they both really differ is in the call to
> config_set_in_gitmodules_file_gently(). Can you do all of your argument
> checks together? Something like
> 
> 	if (!!new_branch == opt_default)
> 		usage_with_options(usage, options);
> 
> Then the call to config_set_in_gitmodules_file_gently() could look like
> this:
> 
> 	config_name = xstrfmt("submodule.%s.branch", path);
> 	config_set_in_gitmodules_file_gently(config_name, new_branch ? new_branch : NULL);
> 	free(config_name);
> 
> and we wouldn't need the ifs at all.
> 

Sure, I have made the changes.

Regards,
Shourya Shukla
