Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B67C433E0
	for <git@archiver.kernel.org>; Tue, 19 May 2020 20:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4785207E8
	for <git@archiver.kernel.org>; Tue, 19 May 2020 20:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E68Py4iV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgESUKm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 16:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgESUKl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 16:10:41 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DF7C08C5C0
        for <git@vger.kernel.org>; Tue, 19 May 2020 13:10:40 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j21so331533pgb.7
        for <git@vger.kernel.org>; Tue, 19 May 2020 13:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RS0GgpYUaX3c1C/NTwGb843pQ5nGeiWoOXk/5cX0kO8=;
        b=E68Py4iVavTjKheqM6rnJuuKBFASRcV0I6U3y+05Y/38lpE3PmK77t4jablR0ENfk0
         +lg07CWeVBD6WjoSZZ8AX6Ybifxf/LQufR0k+vfJXCc09Lx7JLEVvlvOIiSX1G3SLXeM
         2g2fcP21yMXa4CmZULIPTqAQmOmEEaINVjm7lWHfb+rtqS45MttXl9qbw9UubUQyCwf2
         18TYVX2yZ3L1OFhcSppn7wYN92KOYn3f+xM8w7JKaYdUNsiu+UbnBfHnG4uAMzIGdND9
         sO9WG9QS9f/yeU5tKjKMMS+2seifD1sW5U/D8A1DYtq1HXqhJcN4c45PXAMMs9p5QVAL
         98wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RS0GgpYUaX3c1C/NTwGb843pQ5nGeiWoOXk/5cX0kO8=;
        b=C5eCovFdS1cTH5joDxoNRWl6Yj0tX+oYHiZOxNamJUacNwwRmVoxCCk2PJINx+HwKH
         ZfiwxtggvReoZWnZGB+Naf0TvAoFL8yuaU0hjsYhFHIeimt+VbGqtzinjEAV972Qnyzj
         5T0uI27SywAPIE3EJdfnu/IYfAZsTLVrL5/hhmDUp01QEzVZtQo7js2dwNjKCNzkFUwz
         U/eQJJwvT5C2xv5d/fjdESIePhdteVWT4sRm5jgj840PX2+FHpQHPw9uY6hRYRdlfjiq
         QG6hJkO92owzi5XOt0xML25UYrqapJChVJ5NkGJQR4vMw1ilhCZRfq+tfZmyNMZ8Fgoa
         ke4Q==
X-Gm-Message-State: AOAM531YHRf7jgWpN8UhrkcD2fgdUeJSCCI3ZXf+Wh+fmOdXdUow4dAu
        Vq01yTIOARR6fP9yV1IJ4m0PWA==
X-Google-Smtp-Source: ABdhPJyOKZzwCkJHtljHX9Q/A8PXu1tWTVVy1b5vIdBDqz+ChLxRu6H+Fysog07/sI0eA4tDyq7Uhw==
X-Received: by 2002:a62:140d:: with SMTP id 13mr790319pfu.31.1589919039606;
        Tue, 19 May 2020 13:10:39 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id y13sm277337pfq.107.2020.05.19.13.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 13:10:38 -0700 (PDT)
Date:   Tue, 19 May 2020 13:10:34 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH] doc: propose hooks managed by the config
Message-ID: <20200519201034.GB196295@google.com>
References: <20191210023335.49987-1-emilyshaffer@google.com>
 <20200420235310.94493-1-emilyshaffer@google.com>
 <20200425205727.GB6421@camp.crustytoothpaste.net>
 <20200506213354.GG77802@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506213354.GG77802@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 06, 2020 at 02:33:54PM -0700, Emily Shaffer wrote:
> 
> On Sat, Apr 25, 2020 at 08:57:27PM +0000, brian m. carlson wrote:
> > 
> > On 2020-04-20 at 23:53:10, Emily Shaffer wrote:
> > > +=== Config schema
> > > +
> > > +Hooks can be introduced by editing the configuration manually. There are two new
> > > +sections added, `hook` and `hookcmd`.
> > > +
> > > +==== `hook`
> > > +
> > > +Primarily contains subsections for each hook event. These subsections define
> > > +hook command execution order; hook commands can be specified by passing the
> > > +command directly if no additional configuration is needed, or by passing the
> > > +name of a `hookcmd`. If Git does not find a `hookcmd` whose subsection matches
> > > +the value of the given command string, Git will try to execute the string
> > > +directly. Hook event subsections can also contain per-hook-event settings.
> > 
> > Can we say explicitly that the commands are invoked by the shell?  Or is
> > the plan to try to parse them without passing to the shell?
> 
> Sure. If I didn't make it clear it was by mistake, not by intent.
> 
> > 
> > > +Also contains top-level hook execution settings, for example,
> > > +`hook.warnHookDir`, `hook.runHookDir`, or `hook.disableAll`.
> > > +
> > > +----
> > > +[hook "pre-commit"]
> > > +  command = perl-linter
> > > +  command = /usr/bin/git-secrets --pre-commit
> > > +
> > > +[hook "pre-applypatch"]
> > > +  command = perl-linter
> > > +  error = ignore
> > > +
> > > +[hook]
> > > +  warnHookDir = true
> > > +  runHookDir = prompt
> > > +----
> > > +
> > > +==== `hookcmd`
> > > +
> > > +Defines a hook command and its attributes, which will be used when a hook event
> > > +occurs. Unqualified attributes are assumed to apply to this hook during all hook
> > > +events, but event-specific attributes can also be supplied. The example runs
> > > +`/usr/bin/lint-it --language=perl <args passed by Git>`, but for repos which
> > > +include this config, the hook command will be skipped for all events to which
> > > +it's normally subscribed _except_ `pre-commit`.
> > > +
> > > +----
> > > +[hookcmd "perl-linter"]
> > > +  command = /usr/bin/lint-it --language=perl
> > > +  skip = true
> > > +  pre-commit-skip = false
> > > +----
> > 
> > This seems fine to me.  I like this design and it seems sane.
> > 
> > > +== Implementation
> > > +
> > > +=== Library
> > > +
> > > +`hook.c` and `hook.h` are responsible for interacting with the config files. In
> > > +the case when the code generating a hook event doesn't have special concerns
> > > +about how to run the hooks, the hook library will provide a basic API to call
> > > +all hooks in config order with an `argv_array` provided by the code which
> > > +generates the hook event:
> > > +
> > > +*`int run_hooks(const char *hookname, struct argv_array *args)`*
> > > +
> > > +This call includes the hook command provided by `run-command.h:find_hook()`;
> > > +eventually, this legacy hook will be gated by a config `hook.runHookDir`. The
> > > +config is checked against a number of cases:
> > > +
> > > +- "no": the legacy hook will not be run
> > > +- "interactive": Git will prompt the user before running the legacy hook
> > > +- "warn": Git will print a warning to stderr before running the legacy hook
> > > +- "yes" (default): Git will silently run the legacy hook
> > > +
> > > +If `hook.runHookDir` is provided more than once, Git will use the most
> > > +restrictive setting provided, for security reasons.
> > 
> > I don't think this is consistent with the way the rest of our options
> > work.  What if someone generally wants to disable legacy hooks but then
> > works with a program in a repository that requires them?
> 
> Unfortunately this is something I think my end will want to hold firm
> on. In general we disagree with your statement later about not wanting
> to make the .git/config secure. I see your use case, and I anticipate
> two possible workarounds I'd present:
> 
> 1) If working in that repo for the short term, run `git -c
> hook.runHookDir=yes <command> <arg...>` (and therefore allow the config
> from command line scope, which I'm happy with in general). Maybe
> someone would want to use an alias, hookgit or hg? Just kidding.. ;P
> 
> 2) If you're stuck with that repo for the long term, add
> `hook.<hookname>.command = /path/.git/hooks/<hookname>` lines to the local
> config.
> 
> Yes, those are both somewhat user-unfriendly, and I think we can do
> better... I'll have to think more and see what I can come up with.
> Suggestions welcome.

I thought more about this and today I'm revisiting this work (and
starting on patches!) so I figured I'd close the loop, since it'll be
buried in the next round of the design doc.

Refusing to trust the local config is actually contrary to one of the
tenets I was trying to use when designing this - that we should assume
the .git/config is safe, so that we don't end up with bloat later if
.git/config does become safe. The suggestion I made here to disallow
overrides doesn't fit, so I'll drop it. The implementation will allow a
more local config to turn hookdir hooks back on.

Thanks, all. By way of status update, I think I'll be able to start
working on this more actively starting this week.

 - Emily
