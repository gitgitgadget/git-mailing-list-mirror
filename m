Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BF8C433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 12:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 200492070A
	for <git@archiver.kernel.org>; Wed, 20 May 2020 12:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpoRDdwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgETMPl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 08:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETMPk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 08:15:40 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E03CC061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 05:15:40 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r22so1324655pga.12
        for <git@vger.kernel.org>; Wed, 20 May 2020 05:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0kOs+nz+2ibAQkChhSxXlK2+/3vKShfFKXuilBpCo3s=;
        b=hpoRDdwSiI22rp/QxZBeRRqHkd9paIBma5jsnFLs/sX3exsC2arCE0Jjonk+o1IUdd
         8U1F7HJX7/C2x8RuYs/Eg9gMxiWVPKUKgzyG7BL85/WC1AuoszLF/Sc/UdRT4tiRqQVR
         cYTe8Sspe7yzslCf7jLyiRjcrt5VcPLoi2tYnNxdabPT7YcxDXX94hBTcxSyN8pad6zG
         pvJ81GryLNvWDamtYbm3SHAL4eH+xLzw62B8dDhlbfYSBaDWi9IUvzkB0/G6kGVHvtYX
         /eiL2npXcu+mbM8OWsdttGNr3+f276pNC7NxWynsofb0j3WVr5CbgdcRHiNRcyJTaR1f
         Y1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0kOs+nz+2ibAQkChhSxXlK2+/3vKShfFKXuilBpCo3s=;
        b=ogCZ4DdJK1jT3v7uf9YqGE5kn0WL5rjjMDQL6BLHNYLY6xcfvbPDzEpNdJsfIdVc2u
         gwPlgGIrKuarehfxJuJx16+i/bKaVUrusRbR0FrolRXaP4dtVoUzQsmpLYVzic85PSWY
         imBZXblXNDfx9waqIgoap50oNXSm7F6rRycTN8GWj0WFfd1vzN6kz/FTrdaaUra8yRg0
         1NDudUmJ/8CHk0c5mb9wubqNVWcrMxjV3W011wJrLp9/5aopck5shXuOx71p0c+jy35v
         wyXnOlxFXfCUW7NsFxINKW8jbK/yGZcsiRRaToOJS4ZBU6AnalGtNdLF+FvpYM70UepY
         Yfyg==
X-Gm-Message-State: AOAM531gY/S0EKKxy082/aeqXFfb7kmKVetvpWbqiQ9lEJJXc1wHaK9k
        2iGCub0cA4EJm0Hc7N6qoL4=
X-Google-Smtp-Source: ABdhPJxKDnzt7ZF/hslb9w5S0QRJkedO+PA+VLnQh3WgxZHOlS4AcqeDcEVH2Xdln9/eJKhhtMGMAQ==
X-Received: by 2002:aa7:9510:: with SMTP id b16mr4075265pfp.265.1589976938778;
        Wed, 20 May 2020 05:15:38 -0700 (PDT)
Received: from konoha ([103.37.201.172])
        by smtp.gmail.com with ESMTPSA id o14sm2149319pfp.89.2020.05.20.05.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 05:15:37 -0700 (PDT)
Date:   Wed, 20 May 2020 17:45:30 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     christian.couder@gmail.com, kaartic.sivaraam@gmail.com,
        gitster@pobox.com, liu.denton@gmail.com, git@vger.kernel.org,
        congdanhqx@gmail.com
Subject: Re: [PATCH v2] submodule: port subcommand 'set-branch' from shell to
 C
Message-ID: <20200520121530.GA7992@konoha>
References: <20200519182654.33318-1-shouryashukla.oo@gmail.com>
 <CAPig+cSKFBFdNXA52f5f0q3SetA2btmkXeqyHNw-qwJ5ECq5mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cSKFBFdNXA52f5f0q3SetA2btmkXeqyHNw-qwJ5ECq5mQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Eric!

On 19/05 02:57, Eric Sunshine wrote:
> On Tue, May 19, 2020 at 2:27 PM Shourya Shukla
> <shouryashukla.oo@gmail.com> wrote:
> > Convert submodule subcommand 'set-branch' to a builtin. Port 'set-branch'
> > to 'submodule--helper.c' and call the latter via 'git-submodule.sh'.
> 
> You can reduce the redundancy by writing this as:
> 
>     Convert git-submodule subcommand 'set-branch' to a builtin and
>     call it via 'git-submodule.sh'.

Sure! Will do!

> > +       struct option options[] = {
> > +               OPT__QUIET(&quiet,
> > +                       N_("suppress output for setting default tracking branch of a submodule")),
> 
> This is unusually verbose for a _short_ description of the option.
> Other commands use simpler descriptions. Perhaps take a hint from the
> git-submodule man page:
> 
>     N("only print error messages")),
> 
> However, the bigger question is: Why is the --quiet option even here?
> None of the code in this function ever consults the 'quiet' variable,
> so its presence seems pointless.

I actually wanted to have *some* use of the `quiet` option and delivered
it in the v1, but after some feedback had to scrap it. You may have a
look here:
https://lore.kernel.org/git/20200513201737.55778-2-shouryashukla.oo@gmail.com/

> Looking at the git-submodule documentation, I see that it is already
> documented as accepted --quiet, so it may make some sense for you to
> accept the option here. However, it might be a good idea either to
> have an in-code comment or a blurb in the commit message explaining
> that this C rewrite accepts the option for backward-compatibility (and
> for future extension), not because it is actually used presently.

That seems like a better idea; should I add this comment just above the
`options` array? BTW, the shell version has a comment about this,
see:
https://github.com/git/git/blob/v2.26.2/git-submodule.sh#L727

> > +               OPT_STRING(0, "branch", &opt_branch, N_("branch"),
> > +                       N_("set the default tracking branch to the one specified")),
> 
> Then:
> 
>     N_("set the default tracking branch")),

Seems good!

> > +               OPT_END()
> > +       };
> > +       const char *const usage[] = {
> > +               N_("git submodule--helper set-branch [--quiet] (-d|--default) <path>"),
> > +               N_("git submodule--helper set-branch [--quiet] (-b|--branch) <branch> <path>"),
> > +               NULL
> > +       };
> > +
> > +       argc = parse_options(argc, argv, prefix, options, usage, 0);
> > +
> > +       if (!opt_branch && !opt_default)
> > +               die(_("at least one of --branch and --default required"));
> 
> This wording makes no sense considering that --branch and --default
> are mutually exclusive. By writing "at least one of", you're saying
> that you can use _more than one_, which is clearly incorrect. Reword
> it like this:
> 
>     die(_("--branch or --default required"));

Yeah, I did not realize it until you mentioned this, will correct in the
next version.

> > +       if (opt_branch && opt_default)
> > +               die(_("--branch and --default do not make sense together"));
> 
> A more precise way to say this is:
> 
>     die(_("--branch and --default are mutually exclusive"));

Will that be clear to everyone? What I mean is maybe a person from a
non-mathematical background (someone doing programming as a hobby maybe)
will not grasp at this at one go and will have to search it's meaning
online. Isn't it fine as-is?

> > +       if (argc != 1 || !(path = argv[0]))
> > +               usage_with_options(usage, options);
> > +
> > +       config_name = xstrfmt("submodule.%s.branch", path);
> > +       config_set_in_gitmodules_file_gently(config_name, opt_branch);
> 
> Tracing through the config code, I see that
> config_set_in_gitmodules_file_gently() removes the key if 'opt_branch'
> is NULL, which mirrors the behavior of the shell code this is
> replacing. Good.

Thanks! :)

Regards,
Shourya Shukla
