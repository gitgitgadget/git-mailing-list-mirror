Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34813C32771
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 01:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB85D21739
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 01:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TDDx12LW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgA1BIr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 20:08:47 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42384 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgA1BIr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 20:08:47 -0500
Received: by mail-pf1-f195.google.com with SMTP id 4so5746271pfz.9
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 17:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=09ka7+mVypZddNwx/GjrZZTxOP4GWqYCho+NS08vGJE=;
        b=TDDx12LW38rmOuD9NcMGMGTkcQegeokn5Ms46q5mseAbw6DIbtsiO2FvnqH7C9bbpg
         /0PT0ubLvirzix7pEv8WuxdkC1ntfg/H9Q44y1EqIVPQkqnfdh6NuvzrJN63O6aHgzBR
         YvXa9JbdKvK20W3hVfy/YLpg/yybxZNKp8U7+3VlWTn235CyVVekKZAWxAYUu10kyyBv
         xhNBJ3CkjP99tPDACmI68Mgf4pX9g+X5MrzpbcC9T+2ZkZGTryg+5n9/mRAGrU+RgIAx
         S3sxCMPNRud5nlfG83WkWMv2tJGmzfOtenxX5oalKD29+Ms2tvqf8XbKlzbirlnLz6wf
         1bCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=09ka7+mVypZddNwx/GjrZZTxOP4GWqYCho+NS08vGJE=;
        b=q/UpgUptzXEnCUa0wWbeYtB2vsrYQz+7VUT95dS4UUgQVQqI8hYpVXCY/Teuusukqk
         D3hHiV8XqV0VPfwalqUJJ2TjbLqXOHdwG9XpO+7AhnywE3PtBiOafIhsGZrkj2CJpTfW
         YOVFlzK2Npv6+n22PU6gVf9Ipn7SpsX5O5lk3JJ3tnL7w0Ysoi5/8oIAfBIChVPTFHGz
         d5+3SByZ0CqvEwkjCUdJ59w8yQBx7AASfGGkM2wDlpPURZ6SNgcn517D4auEILcr9PMQ
         62jBk2luxoyJhrQVUUrcJ2QqPhDHFSvzYvdd6e0YaEucxfW/80Dgl8Nm2rVqV/c9TSBn
         ZlkQ==
X-Gm-Message-State: APjAAAUSDKEXyh3wGgBtp72Dx0FRqIP0QmwTc5Vrc92vhto0m9328Hr6
        uCKGnlMsGGOFfY1QfO8S8NRFjUbuv7Y=
X-Google-Smtp-Source: APXvYqyyM/jrrXg6rGnNr2rGISsMs+aV1m2PXNNz/vOvDPPIYv2FakdwtPAb3KFP+Wq199zGAy62oQ==
X-Received: by 2002:a62:1b07:: with SMTP id b7mr1422042pfb.186.1580173726518;
        Mon, 27 Jan 2020 17:08:46 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id i66sm17308154pfg.85.2020.01.27.17.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 17:08:45 -0800 (PST)
Date:   Mon, 27 Jan 2020 17:08:41 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clone: teach --single-branch and --branch during
 --recurse
Message-ID: <20200128010841.GD233139@google.com>
References: <20200108231900.192476-1-emilyshaffer@google.com>
 <20200109081150.GC3978837@coredump.intra.peff.net>
 <20200116223800.GM181522@google.com>
 <20200117210319.GA15460@coredump.intra.peff.net>
 <20200127222019.GA233139@google.com>
 <20200127224914.GB233139@google.com>
 <20200127231007.GB19360@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127231007.GB19360@coredump.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 27, 2020 at 06:10:07PM -0500, Jeff King wrote:
> On Mon, Jan 27, 2020 at 02:49:14PM -0800, Emily Shaffer wrote:
> 
> > > >   - make sure that .gitmodules has enough information about which branch
> > > >     to use for each submodule
> > > 
> > > Hum. I don't work with them day to day, but aren't we already in that
> > > state? Is that not what the 'branch' option for each submodule means?
> > 
> > I've been corrected off-list that the 'branch' in .gitmodules is used
> > during 'git submodule update --remote', but not during 'git submodule
> > init' or 'git clone --recurse-submodules'. Then, for the problem in
> > discussion for this thread, it seems like a better choice is something
> > like 'git clone --recurse-submdoules --use-gitmodules' or whatever we
> > want to call it - e.g., rather than fetching the branch where the server
> > knows HEAD, ask the .gitmodules to figure out which branch?
> 
> Oof, I should have read this message before responding to the other one. ;)
> 
> > It seems like that ought to live separately from --single-branch. In the
> > case where you very strictly only want to fetch one branch (not two
> > branches) I suppose you'd want something like 'git clone
> > --recurse-submodules --single-branch --branch=mysuperprojectbranch
> > --use-gitmodules' to make sure that only one branch per repo comes down.
> > 
> > With n submodules of various naming schemas, provenance, etc., I don't
> > think there's a good case for recursing --branch one way or another; it
> > seems like filling out some config is the way to go.
> 
> Yeah, I do still think that it makes sense for clone to pass along
> --single-branch, regardless, and then deal with branch selection problem
> separately on top.

Sure; I've got that ready to send shortly. It seems to grab HEAD of the
remote for each submodule, and then checkout the specific commit ID the
superproject wants - in my test case, that commit ID was a direct
ancestor of 'master', so the single branch only got 'master'. I'm not
sure how it would work with a commit ID which doesn't exist in the
single branch that was fetched; I'll write a test and have a look.

> 
> > I guess we could also teach it to take some input like
> > --submodule-branch-spec=foo.txt, and/or a multiply provided
> > --submodule-branch foo=foobranch --submodule-branch bar/baz=bazbranch.
> > 
> >   [foo.txt]
> >   foo=foobranch
> >   bar/baz=bazbranch
> > 
> > With that approach, then someone gets a little more flexibility than
> > relying on what the .gitmodules has set up.
> 
> Yeah, I agree that the most general form is being able to specify the
> mapping for each individually. At first I wondered why you'd ever _not_
> want to just use the branches specified in .gitmodules. But I suppose
> that gets embedded in the superproject history, which gets awkward as
> those commits move between branches. E.g., for an android-like project,
> you don't want to make a commit that says "use branch devel for all
> submodules" on the devel branch of your superproject. Eventually that
> will get merged to master, and you'd have to remember to switch it back
> to "master".

Yeah, or I suppose I might be doing something weird, like wanting to run
integration tests for the whole project on changes in just one
submodule, or something.

> So for the simple case, you probably do want to be able to say "use this
> branch for cloning all submodules".

I think it still makes sense to call this out explicitly, yes? Or do you
think that should just be the default?

> 
> For the complex cases, you'd need that full mapping. But I think it may
> be worth it to punt on that for now. Even if we eventually added such a
> feature, I think we'd still want the simpler version anyway (because
> when you _can_ use it, it's going to be much easier). So there's nothing
> lost by doing the minimal thing now and waiting to see if more complex
> use cases even show up.
> 
> Another thing occurs to me, though: should the binding of this submodule
> default branch be written to disk (e.g., a config option)? I'm thinking
> specifically that if you do:
> 
>   git clone --submodule-branch=devel -b devel superproject
> 
> and then later, you "git fetch" and find that somebody has added a new
> submodule, you'd presumably want the devel branch of that, too?

This made me think - I wonder if it makes sense to take
--submodule-branch as a wildcarded spec instead. So in your case, I
could say,

  git clone --submodule-branch *=devel -b devel superproject

And then I don't need to do anything differently for 'git fetch' later.
This also opens the door for some repos getting special treatment:

  git clone --submodule-branch-file=foo.txt -b dev example

  foo.txt:
  curl=stable-1.2.3
  nlohmann=v2.28
  example-*=dev
  *=master

(specifying specific versions for some source dependencies, dev branches
for submodules which are associated with with 'example' superproject and
might be getting active development, and a wild guess for everything
else)

I think that also tends to match the glob-expansion configs we use for
other things. One thing sticking out to me about the idea of providing
--submodule-branch is that you need to know what's in the repo before
you clone it the first time, which being able to use globbing like this
kind of helps with. But then, I suppose if you don't know what you're
looking for, you're not also looking for a very precise filter on your
clone ;)

 - Emily
