Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF381C33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 22:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B9F20728
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 22:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wKL3iDvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733041AbgAPWiG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 17:38:06 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32993 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbgAPWiG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 17:38:06 -0500
Received: by mail-pg1-f195.google.com with SMTP id 6so10657648pgk.0
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 14:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mrn9SyqwPWSPLtzG5fVudNWUh+c1C8sQcFRg+Nv6oEc=;
        b=wKL3iDvomyaqhNIy/Q1DCd6sEQrTXajNhcR5RI8qvkMV/y75rDM00Oeczk5BsjU4L5
         rUkV8TlJNxap4ZxluW3HASroWf/ZK590dPzmMWPlYki40fta1pcW6zowajAy5msqijRM
         wfWkOXPfcXNVJkMO88G8N46r7gupzFEAAWjLpxkHqUnS6WjhRFvhNemPjoZ11MOLq3XD
         2TcHIHSHx2Jmid7G50NXVde/tlo7yuhNzJqSPNYQJrHcNgEa6a+XbmzwkU3IVLigI+e5
         8bskFfZfdYwymkMTbOVrw/u3Szi0HQXY3o5jvWEBNj+1GmV5qI5ZTpAUTN4g1SIHNIm4
         EDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mrn9SyqwPWSPLtzG5fVudNWUh+c1C8sQcFRg+Nv6oEc=;
        b=BX8zN6JO+Vw6bkh6aLmnN4bQMSKFoJvqNyM+1HZG8cua6gWr9+x36aAftngA7bOdcu
         QZ74i3viTRuOVzSt7EvV5qV44ua6Hn6oEDF+0TApe65NOhkT1anVR7hlHc4AedRJgZDK
         0a6/2eIDXwwOKPIVWssuhcEgUG7DKiUQVsKd9opMk0akKbRkzSI3cwcuXalKRweTTOPn
         QktbeoOWDExbdzefgNzPLDtMUu2h0cDirM6jpySN04iqDpeUTTRb6a+mOJz1H6iqx2Ze
         e5Do3q/IwrgPtMHg1GmpZ6JtERDHb1hvZbU4YU/KV5cX/dYjNwEz9Pj8KFCSjl8hnk/u
         STDg==
X-Gm-Message-State: APjAAAVT9koeWenYmQs8p7BhO3ymd31oU/RfEfUNvYnfmLKEq9NzkNyN
        7bgqtYRdRG7VYOhgDi+gU0l5jmik3no=
X-Google-Smtp-Source: APXvYqwT04AM3ejkAFb4yFGAv5wowkewEdf19tRib07b2lEsdMtucj+gKJs+/sMOGY2YSOvab05IlQ==
X-Received: by 2002:a63:211f:: with SMTP id h31mr40132028pgh.299.1579214285310;
        Thu, 16 Jan 2020 14:38:05 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id i8sm27398946pfa.109.2020.01.16.14.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 14:38:04 -0800 (PST)
Date:   Thu, 16 Jan 2020 14:38:00 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clone: teach --single-branch and --branch during
 --recurse
Message-ID: <20200116223800.GM181522@google.com>
References: <20200108231900.192476-1-emilyshaffer@google.com>
 <20200109081150.GC3978837@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109081150.GC3978837@coredump.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 09, 2020 at 03:11:50AM -0500, Jeff King wrote:
> On Wed, Jan 08, 2020 at 03:19:00PM -0800, Emily Shaffer wrote:
> 
> > Subject: clone: teach --single-branch and --branch during --recurse
> 
> A minor nit, but this subject confused me for a moment. I think we'd
> usually say "teach" for a new feature being implemented, and this is
> really just about passing along the existing features. Something like:
> 
>   clone: pass --single-branch and --branch when recursing submodules
> 
> would have been a bit more obvious (to me anyway).
> 
> > Previously, performing "git clone --recurse-submodules --single-branch"
> > resulted in submodules cloning all branches even though the superproject
> > cloned only one branch. Pipe --single-branch and its friend, --branch,
> > through the submodule helper framework to make it to 'clone' later on.
> 
> Since I don't really use submodules, I don't have much data or even
> intuition to go on. But could this be a regression for some situations?
> E.g., imagine I have a repo "parent" whose branch "foo" has a submodule
> "child", but "child" only has a branch "bar". What happens now if I "git
> clone --recurse-submodules --single-branch -b foo parent", and what will
> happen after this patch?
> 
> I think it works before, but doesn't now.
> 
> Setting up like this:
> 
>   git init child
>   (
>   	cd child
>   	git checkout -b bar
>   	echo whatever >file
>   	git add file
>   	git commit -m 'child commit'
>   )
>   
>   git init parent
>   cd parent
>   git checkout -b foo
>   git submodule add $PWD/../child
>   git commit -m 'add submodule'
> 
> if I use the current tip of master, I get:
> 
>   $ git clone --recurse-submodules --single-branch -b foo parent cur
>   Cloning into 'cur'...
>   done.
>   Submodule 'child' (/home/peff/tmp/parent/../child) registered for path 'child'
>   Cloning into '/home/peff/tmp/cur/child'...
>   done.
>   Submodule path 'child': checked out 'b5cbfcc9fec3b7d67e305468624fed2ba1aa4758'
> 
>   $ git -C cur/child log -1 --oneline | cat
>   b5cbfcc child commit
> 
> with your patch, I get:
> 
>   $ git.compile clone --recurse-submodules --single-branch -b foo parent new
>   Cloning into 'new'...
>   done.
>   Submodule 'child' (/home/peff/tmp/parent/../child) registered for path 'child'
>   Cloning into '/home/peff/tmp/new/child'...
>   warning: Could not find remote branch foo to clone.
>   fatal: Remote branch foo not found in upstream origin
>   fatal: clone of '/home/peff/tmp/parent/../child' into submodule path '/home/peff/tmp/new/child' failed
>   Failed to clone 'child'. Retry scheduled
>   Cloning into '/home/peff/tmp/new/child'...
>   warning: Could not find remote branch foo to clone.
>   fatal: Remote branch foo not found in upstream origin
>   fatal: clone of '/home/peff/tmp/parent/../child' into submodule path '/home/peff/tmp/new/child' failed
>   Failed to clone 'child' a second time, aborting
> 
>   $ git -C new/child log -1 --oneline | cat
>   11acb3a add submodule
> 
> (there's nothing checked out in the submodule).
> 
> I have no idea how common this kind of thing would be, and I expect in
> most cases your patch would do what people want. But we might need to be
> better about retrying without those options when the first clone fails.

Yeah, that's interesting. A retry sounds like a pretty solid approach,
although if someone's being cautious and using --single-branch I wonder
if that's really something they want (since that's avoiding grabbing
extraneous branches).

I suppose at the very least, --single-branch without --branch should
become recursive. Whether --branch should become recursive, I'm not
totally sure.

The two scenarios I see in conflict are this:
- Superproject branch "foo"
  - submodule A branch "foo"
  - submodule B branch "foo"
and
- Superproject branch "foo"
  - submodule A branch "bar"
  - submodule B branch "baz"

If we propagate --branch, the first scenario Just Works, and the second
scenario requires something like:

 git clone --recurse-submodules=no --single-branch --branch foo https://superproject
 git submodule update --init --single-branch --branch bar A/
 git submodule update --init --single-branch --branch baz B/

(I guess if the superproject knows what branch it wants for all the submodules,
you could also just do "git submodule update --init --single-branch" and
have it go and ask for all of them.)

If we don't propagate --branch, the second scenario Just Works, and the
first scenario requires something like:

 git clone --recurse-submodules=no --single-branch --branch foo https://superproject
 git submodule update --init --single-branch --branch foo

(That is, I think as long as 'update' takes --branch, even if it's not
passed along by 'clone', it should still work OK when delegating to
everyone.)

Let me know if I misunderstood what you were worried about.

I don't use submodules heavily for myself either. I'll try and ask
around a little to see what folks want, at least here. The ergonomics
seem pretty similar, so I guess it comes down to having explicit
documentation.

> 
> -Peff
