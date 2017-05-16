Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4979D1FAA8
	for <e@80x24.org>; Tue, 16 May 2017 21:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751987AbdEPVLc (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 17:11:32 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33443 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbdEPVL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 17:11:28 -0400
Received: by mail-pf0-f169.google.com with SMTP id e193so86327036pfh.0
        for <git@vger.kernel.org>; Tue, 16 May 2017 14:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=saoq/OtUcoDJqeYe0O4IFny/cxWxXgJ/caK3w9tzX2s=;
        b=wVC5z3A4TdbTMqdbTrDgkNOw2F6XuHls9v0QKUX0teLbTVC4wV60aPJcykpzqLr/kg
         Xn+gr/av/qM4cS/wCkinYHGQzXukaJ3Lzzb9Xp1OSbEUnu5i+/s8Xg1n5nqSHpxgh6kz
         oPUeOOi/ALzneoYR3mAJ+1h71JwrgTpU/LbwlPxbRWdVDKCw41mspTXOLAoQjs5wocQN
         LMVFyPPsYu2JmzuLPy0rMscC9vPLMxHSoB238uYXVDpshbH5J9+A5nLA1ULGJ5Fp3cZ1
         3rbx+oQZ90b924mzuRGkYp5baMQ7xdcd3YTDwUDOIf+CBN+4Bvr+gii2T+mYL9s/uSOm
         5AyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=saoq/OtUcoDJqeYe0O4IFny/cxWxXgJ/caK3w9tzX2s=;
        b=gSHedmp3Cbdy2ahglaPVQVXsm2mTbbtJBy9DZGQkwgTGJ3ZoAkngZ8k0uJY/a843Ad
         aq3zddMX+6xjSEDN7wKqQFhESnhCncpMULsg03mcGuWmnkA07BscUaxGUV4L7faY4kTS
         YgCiobWhylOuBAKjejZs+NBQ9/5d/DOfrh0aNqlys/+ZfSf+UheHlYS7n5+2xox2E0Ji
         jisLQrd96iqrWAhAzUpfZ1GogICA50J6ljAbBGFS8pm1KZBFoprj6wF+Pm3pVurcQDxH
         e8uYybj/fk2JrgCotwNtX/Kb68sfqrN85g/gZsHvgklf43Ujtr/i++F4cYqbwP4pMwIQ
         ZqWA==
X-Gm-Message-State: AODbwcBxKkRDlYwsIKWIzm9GaB3K1O+9oJo5DhygyPwkWUIhljGhYZrt
        vJZG+iRxJodvd1gB
X-Received: by 10.98.32.132 with SMTP id m4mr14614387pfj.131.1494969087378;
        Tue, 16 May 2017 14:11:27 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6c78:c1b9:36d1:fa23])
        by smtp.gmail.com with ESMTPSA id j17sm320pfk.23.2017.05.16.14.11.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 14:11:26 -0700 (PDT)
Date:   Tue, 16 May 2017 14:11:25 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Rannaud <eric.rannaud@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeremy Serror <jeremy.serror@gmail.com>
Subject: Re: [TANGENT] run-command: use vfork instead of fork
Message-ID: <20170516211125.GA74302@google.com>
References: <CA+zRj8X3OoejQVhUHD9wvv60jpTEZy06qa0y7TtodfBa1q5bnA@mail.gmail.com>
 <20170516032503.bzkxmtqpmppxgi75@sigill.intra.peff.net>
 <20170516033736.23cfkouus3p67vhc@sigill.intra.peff.net>
 <20170516164124.GO27400@aiede.svl.corp.google.com>
 <20170516164750.3tw6xlbcbyuu5t72@sigill.intra.peff.net>
 <20170516171540.GG79147@google.com>
 <20170516172307.36hyshwypomlsubx@sigill.intra.peff.net>
 <CA+55aFwB-MWASj7dZWkXWhgd4gvEfoOhL6Fo7kXeJSm9dht4Jg@mail.gmail.com>
 <20170516193557.GA14257@dcvr>
 <CA+55aFygKMJH3BRitQftmtCTx6es93CTR4_y1ULGGE2rSsMyog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFygKMJH3BRitQftmtCTx6es93CTR4_y1ULGGE2rSsMyog@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/16, Linus Torvalds wrote:
> On Tue, May 16, 2017 at 12:35 PM, Eric Wong <e@80x24.org> wrote:
> >
> > Fwiw, most of the vfork preparation was already done by Brandon
> > and myself a few weeks ago, and cooking in pu.
> 
> Oh, interesting. Was that done for vfork(), or is it for something
> else? Some of the changes seem almost overly careful. Is this for
> prep-work porting to some odd environment that doesn't really have a
> MMU at all? There's nothing fundamentally wrong with allocating memory
> after fork().
> 
> But yes, it looks like it helps the vfork case.
> 
>                Linus

I started working on the run-command code when I ran into a deadlock in
'git grep --recurse-submodules'.  When I added support for submodules to
grep I just assumed that launching a process (which atm is unfortunately
the only way to work on a submodule) would work in a multi-threaded
environment.  I was naive and wrong!

The deadlock was due to a malloc lock being held by thread 'A' while
thread 'b' tried to launch a process.  Since that lock was in a
locked-state at the time of forking, it remained in a locked-state with
no hope of ever being released.  So when the child process that thread
'b' spawned tried to malloc a chunk of memory after forking, it
deadlocked.

I didn't catch this in initial testing because gclib registers
atfork_handelers in order to prevent this sort of thing, while libraries
like tcmalloc don't do this.

So to account for this, I worked to make run-command safe to use in the
presence of threads, which had the benefit of also preparing it to be
vfork() ready.

Ultimately I'd like to drop the requirement to spawn a child process to
work on a submodule, but that's going to take a lot more effort.

-- 
Brandon Williams
