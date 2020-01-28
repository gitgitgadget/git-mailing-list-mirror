Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CB6C32771
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 02:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8FB2467C
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 02:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OicuzZPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgA1CKX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 21:10:23 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33527 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgA1CKX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 21:10:23 -0500
Received: by mail-pl1-f193.google.com with SMTP id ay11so4484005plb.0
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 18:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3rIAQnWZY2yYvy/VsezDjxe1SHAKlFBSkocRZtVQ474=;
        b=OicuzZPeV1mbLfYJSAlQ8fimLaaDkXUnCMwm1zqHlyxKwdYoW7tHCJnYggRSdBGEbH
         c/5UuTEkIXFfb7iAP22g3aL4ZLmOGMZxemyUDoWf2n7IiFzE889pYcHymwdQOXNJHKmv
         g2Is9vf/D1X2f+C3Q++JHtpNUbcahHL7Yj5E4KCKJs+pjGmGTBkGjXV/xsbHLRJ2+eix
         0Jur782zcJEfdfcNUoe9eWt6pHsyT+1Y5MexROeLOZtfJBqZwCFC0s+uupLOwaK39ta8
         Ws/egevauAbvOt38BWeijQmpGm0f4O3kWcr7vCMbArsB0wBXCHncuVqt9BU+iFqwZmFn
         6nfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3rIAQnWZY2yYvy/VsezDjxe1SHAKlFBSkocRZtVQ474=;
        b=OnP35W/Ex9pwnDGo0mIEbfhxt+NaPByZuFpxWgS52MGN8qSgLf3jWq0U4OahAmFbM6
         1b8b3XM+0MLzPGj9k1H5Z8O6m8UheG/t9rLJr2BMipZjXBlBjItQTP0GCviBaYRMG+K5
         sbKGF7mPklV0cU/N6niOAvjmTbuG3oohQkSz1cUdu34bGBR1k+LwDjwjP7okN6k9LgSX
         s0juhwjiuAm62TuyFhUiVpcF7A0gERmRaDyN/jwpSlpcO6sVqb7LZhkz1iDAW8diu1Ga
         I0oRsNk27L5A45yRj9AYLYSUkzwLHHxSEduhJ7pzWujBh1xcL6E7hdRNMszkERHGAeiO
         FhaA==
X-Gm-Message-State: APjAAAUSjUdpTwnASG7IxetRWL7Et4yTpJ14pJ3EMZCyF83PwnV/GPWm
        ckmJgRTTXqw3CM+b82XawwZk3Q==
X-Google-Smtp-Source: APXvYqygL0w/nPVRYhB8KYQm55iL00AWD2c8i+14QM3nKDAMwfXJxejz4re11MZLmOSQBCXJHZ3EqA==
X-Received: by 2002:a17:902:6a88:: with SMTP id n8mr20349505plk.265.1580177421445;
        Mon, 27 Jan 2020 18:10:21 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id i9sm17877654pfk.24.2020.01.27.18.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 18:10:20 -0800 (PST)
Date:   Mon, 27 Jan 2020 18:10:16 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clone: teach --single-branch and --branch during
 --recurse
Message-ID: <20200128021016.GE233139@google.com>
References: <20200108231900.192476-1-emilyshaffer@google.com>
 <20200109081150.GC3978837@coredump.intra.peff.net>
 <20200116223800.GM181522@google.com>
 <20200117210319.GA15460@coredump.intra.peff.net>
 <20200127222019.GA233139@google.com>
 <20200127224914.GB233139@google.com>
 <20200127231007.GB19360@coredump.intra.peff.net>
 <20200128010841.GD233139@google.com>
 <20200128013139.GA38223@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128013139.GA38223@coredump.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 27, 2020 at 08:31:39PM -0500, Jeff King wrote:
> On Mon, Jan 27, 2020 at 05:08:41PM -0800, Emily Shaffer wrote:
> 
> > > Yeah, I do still think that it makes sense for clone to pass along
> > > --single-branch, regardless, and then deal with branch selection problem
> > > separately on top.
> > 
> > Sure; I've got that ready to send shortly. It seems to grab HEAD of the
> > remote for each submodule, and then checkout the specific commit ID the
> > superproject wants - in my test case, that commit ID was a direct
> > ancestor of 'master', so the single branch only got 'master'. I'm not
> > sure how it would work with a commit ID which doesn't exist in the
> > single branch that was fetched; I'll write a test and have a look.
> 
> Yeah, it's definitely worth exploring how that works. I thought we had
> some kind of fallback for when we didn't manage to fetch the object. But
> maybe I am confusing it with the fallback for "we tried to fetch this
> specific object, but the other side doesn't allow that, so we grabbed a
> branch instead".

Ok, so I gave it a try. Some well-trimmed trace output:

1) git clone --recurse-submodules --single-branch <url> (the branch in
question is remote's HEAD)
 - Normal clone of superproject
 - git submodule--helper update-clone --progress --require-init
   --single-branch --
 - ultimately...
 - git clone --no-checkout --progress --separate-git-dir
   '/.../super_clone/.git/modules/sub'
   --single-branch --
   '/path/to/submodule/source'
   '/path/to/submodule/destination'
 - git checkout -f -q <ID of submodule's HEAD>

2) git clone --recurse-submodules --single-branch --branch other <url>
  'other' points to a commit of 'sub' which is not an ancestor of 'sub''s
  current HEAD.
 - Normal clone of superproject identical to 1)
 - git submodule--helper update-clone --progress --require-init
   --single-branch --
 - ultimately...
 - git clone --no-checkout --progress --separate-git-dir
   '/.../super_clone/.git/modules/sub'
   --single-branch --
   '/path/to/submodule/source'
   '/path/to/submodule/destination'
 - git fetch origin <ID of submodule's other branch>
 - git checkout -f -q <ID of submodule's other branch>

So, somewhere in the submodule machinery, it looks like we check if we
have the commit in question, and if not, we do another fetch. So in this
case, we reach to the server twice per submodule.

On the bright side, it doesn't fall over; on the dim side, I'd think
we could ask for this ref up front along with whatever branch HEAD is.
I thought there was a way we could tell the server we want 'master' as
well as '58c34ed'?

> 
> > > So for the simple case, you probably do want to be able to say "use this
> > > branch for cloning all submodules".
> > 
> > I think it still makes sense to call this out explicitly, yes? Or do you
> > think that should just be the default?
> 
> Yes, I think it should be a separate option from "--branch".
> 
> > This made me think - I wonder if it makes sense to take
> > --submodule-branch as a wildcarded spec instead. So in your case, I
> > could say,
> > 
> >   git clone --submodule-branch *=devel -b devel superproject
> > 
> > And then I don't need to do anything differently for 'git fetch' later.
> > This also opens the door for some repos getting special treatment:
> > 
> >   git clone --submodule-branch-file=foo.txt -b dev example
> > 
> >   foo.txt:
> >   curl=stable-1.2.3
> >   nlohmann=v2.28
> >   example-*=dev
> >   *=master
> 
> If we write it all as config, I think things may get simpler. IIRC,
> there is already submodule.*.foo config in .git/config (that can mirror
> and override what's in .gitmodules).

Hm. But at clone time, there is no .git/config yet, which is why I
proposed a file passed in at the command line. Although it does seem to
make sense to write down those preferences in the .git/config after.

I guess you could pass in configs at the command line, though, and then
you don't have to massage it to write your config after fetch.

> So if we had some config option for "clone this branch for the submodule
> instead of HEAD", then that means you can do:
> 
>   git clone -c submodule.foo.clonehead=devel ...
> 
> and the result would be used by the submodule code, but also saved for
> future invocations. Likewise, if there's no "clonehead" config for a
> particular submodule, if we fall back to submodule.defaultclonehead,
> then you could do:
> 
>   git clone -c submodule.defaultclonehead=devel ...
> 
> and it would also be saved as the default for future submodules.  And
> all without having to invent a new submodule-branch-file format.
> 
> The name "clonehead" isn't great.

Au contraire - it might be my new go-to insult. ;)

> I'm not sure if this ought to be submodule.*.branch (since I don't
> quite know what that's used for). I think you'll have to explore that
> a bit.
> 
> > I think that also tends to match the glob-expansion configs we use for
> > other things. One thing sticking out to me about the idea of providing
> > --submodule-branch is that you need to know what's in the repo before
> > you clone it the first time, which being able to use globbing like this
> > kind of helps with. But then, I suppose if you don't know what you're
> > looking for, you're not also looking for a very precise filter on your
> > clone ;)
> 
> Yeah; the scheme I outlined above only allow specifying the value for
> one submodule, or the fallback default. It wouldn't allow arbitrary
> globbing. But I also suspect nobody wants that. If you know what the
> submodules are, then you can set up config for each. If you don't, then
> "everything" is the only glob that makes sense.

Yeah, I suspect you're right and this fancy globbing falls under YAGNI.

 - Emily
