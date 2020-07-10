Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2ACCC433E1
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 18:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 868CB207BB
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 18:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nNbDd32s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgGJSrA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 14:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgGJSq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 14:46:58 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7384FC08C5DC
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 11:46:58 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id cm21so2986547pjb.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 11:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PH6dLLRVirfjzk3Xx4cUaYNJqyNwt/UCf08UPDu0nz0=;
        b=nNbDd32sEKITo0Od6i58MdSgnmU/ytANfpx7iaOp4PpXit1FwyCXOQ4lilB8rw3SJc
         m80nq2HnkgSc5wCaNfn9FiIiOF6dYaiVDK/D1cczTex6JrrWbwdhZJ/R6Cz/1Fb6hpcN
         14eKBoJBukU8Fq1vbj6hdyDEQI//ctaTJSKKCAuR5/Dg8Xv8WEbBM6DgFACzsl4t5ULM
         bQ/TYG78GgLlNsx2ZhAkKfxtNYitXFVXIdRL30BgKcUx371fCMrsJmQIpX9ZM8p9bkUA
         2LJQ45iX8PwvTW7nifmcyRUgu/wegJOddEqlYoUC0EN6Knv5xM1GTJAcnKIaQx5RapGN
         icyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PH6dLLRVirfjzk3Xx4cUaYNJqyNwt/UCf08UPDu0nz0=;
        b=ueNJtnGEn2gOAFOahmeQq6NPaViOMmCocIUgy0S0EYp4R+3Y1zkBlztmdODt0KogX/
         LFxEUGHHAevIk7CthgKiR6UALGmEG6R2vR2YxBfCplUO8LfgBkovB9SOZmmO29neCbnA
         oZuoqE61pwJ0sFMUwM+OOBY3ABiD6ZgkRerspQBnpRluEWieIy6GMhSwkjHgv0Hf9zSv
         5+SVYftQnKS84gBD21ZqvFdDItxfMw/CEwkBHCevJZ2a07U2WjgNoam8ug7Z7anXMJnS
         gSfkAhRSHtRFglq4dWbv/8BKCWbjT2Rk6nFPu0X8GghVj9I4G0m3lxBnqVVl9Sh9Ae2c
         FWiQ==
X-Gm-Message-State: AOAM5310jQUgK3bMceV/z0jvf9ikFMnVIX8jXjItUXsIdFi4lpqWlF3W
        sRFWLckMOW7Tx0goeqbjyeBh4w==
X-Google-Smtp-Source: ABdhPJzDjoxBgQ+hD7jctkwkkFabSIQ3LkrZEFuD03ENevxdO6p3Zh9CUm7v6R6zvf95wlyoyHDzWQ==
X-Received: by 2002:a17:902:40a:: with SMTP id 10mr38934580ple.260.1594406817717;
        Fri, 10 Jul 2020 11:46:57 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id c19sm6239124pjs.11.2020.07.10.11.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 11:46:56 -0700 (PDT)
Date:   Fri, 10 Jul 2020 11:46:51 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, congdanhqx@gmail.com,
        phillip.wood123@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 00/21] Maintenance builtin, allowing 'gc --auto'
 customization
Message-ID: <20200710184651.GB3189386@google.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <20200708235719.GA3189386@google.com>
 <ef6e2704-b122-f620-a952-75f3f9efab78@gmail.com>
 <d0d30dab-7883-199a-3beb-48c87cde3550@gmail.com>
 <20200709231624.GE664420@coredump.intra.peff.net>
 <28c72d69-f524-7c4f-4cc3-847ca91cad33@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28c72d69-f524-7c4f-4cc3-847ca91cad33@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 09, 2020 at 07:45:47PM -0400, Derrick Stolee wrote:
> 
> On 7/9/2020 7:16 PM, Jeff King wrote:
> > On Thu, Jul 09, 2020 at 08:43:48AM -0400, Derrick Stolee wrote:
> > 
> >>>> Is it infeasible to ask for 'git maintenance' to learn something like
> >>>> '--on /<path-to-repo> --on /<path-to-second-repo>'? Or better yet, some
> >>>> config like "maintenance.targetRepo = /<path-to-repo>"?
> >>
> >> Sorry that I missed this comment on my first reply.
> >>
> >> The intention is that this cron entry will be simpler after I follow up
> >> with the "background" part of maintenance. The idea is to use global
> >> or system config to register a list of repositories that want background
> >> maintenance and have cron execute something like "git maintenance run --all-repos"
> >> to span "git -C <repo> maintenance run --scheduled" for all repos in
> >> the config.
> >>
> >> For now, this manual setup does end up a bit cluttered if you have a
> >> lot of repos to maintain.
> > 
> > I think it might be useful to have a general command to run a subcommand
> > in a bunch of repositories. Something like:
> > 
> >   git for-each-repo --recurse /path/to/repos git maintenance ...
> > 
> > which would root around in /path/to/repos for any git-dirs and run "git
> > --git-dir=$GIT_DIR maintenance ..." on each of them.
> > 
> > And/or:
> > 
> >   git for-each-repo --config maintenance.repos git maintenance ...
> > 
> > which would pull the set of repos from the named config variable instead
> > of looking around the filesystem.
> 
> Yes! This! That's a good way to make something generic that solves
> the problem at hand, but might also have other applications! Most
> excellent.

I'm glad I wasn't the only one super geeked when I read this idea. I'd
use the heck out of this in my .bashrc too. Sounds awesome. I actually
had a short-lived fling last year with a script to summarize my
uncommitted changes in all repos at the beginning of every session
(dropped because it became one more thing to gloss over) and could have
really used this command.

> 
> > You could use either as a one-liner in the crontab (depending on which
> > is easier with your repo layout).
> 
> The hope is that we can have such a clean layout. I'm particularly
> fond of the config option because users may want to opt-in to
> background maintenance only on some repos, even if they put them
> in a consistent location.
> 
> In the _far_ future, we might even want to add a repo to this
> "maintenance.repos" list during 'git init' and 'git clone' so
> this is automatic. It then becomes opt-out at that point, which
> is why I saw the _far, far_ future.

Oh, I like this idea a lot. Then I can do something silly like

  alias reproclone="git clone --no-maintainenance"

and get the benefits on everything else that I plan to be using
frequently.

 - Emily
