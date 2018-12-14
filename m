Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38C0020A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 09:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeLNJ2Z (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 04:28:25 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:35047 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLNJ2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 04:28:24 -0500
Received: by mail-pf1-f174.google.com with SMTP id z9so2566493pfi.2
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 01:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gyuOfgFHCWybKUewWtds825pIPicxHZ2nmDELcZmxt4=;
        b=U3TkaHbGZDdh4DQFi129AjneIc9AkvU7gzvpA3VUL6NYD4rhWr1N1xzl4y8WTLiN2x
         F4FVpsz2ZqvpER7vt1nfuuTUPzx8PLTUYJCou5mhNu51vOkrevPWCWG4PZ+O2TA2yepG
         pSy+W0PjcGR6gfsSc1ygZamEB6aUJEELl3C2IMDq3/BbEblrj1MpRqROCMY/EG9WnGuN
         +5JafM7ZNsHuUlcOQ4O2jiA0/8ud095Kq+ZHj1ZzCPyFzEVUGw47/OWdMFcsdmaWWJ5u
         Nmg/G1KxwjwV63ZTEVxTzcnFNj9/3hGhTfoQ4l+Ke3Uv22QZbyHTKUYnuCIXrkBCWto9
         Ha7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gyuOfgFHCWybKUewWtds825pIPicxHZ2nmDELcZmxt4=;
        b=hLmgfdRrApSSRVpOYYez23XRoojq81orbeMlezPD5rR4+PTPD45+5PrTG/aX6JZ5yc
         ZNNY9vrq9SHy1xKJuRmg8yk5W7h38iw1BeIYLUEjQDuyAuaJZQhQphQzKdsB1gba9h+A
         CyNQtufcLVlLcrXu2adr/1wDmJnu5SILE6w1i/VPPHGVLrl+xUHYljMFafnRPlbzUEIE
         F1CEIITsVNkgsfYE8pn6k+YT/9sbeiw18pp9ki56x5V0K3iLX7afFRlV3n0HfybYJTz6
         SPz/5o0mjYO4mAkgko4Fle/HRv4JpHxjg6RvRf1+gFUi3ctjka5FL5opy2p5ayvVw+ux
         0lzA==
X-Gm-Message-State: AA+aEWZsVmUYilqNc2xPhmReTiqxBIne7vC//Iyo4A3QE6BKdgN2Imvf
        BICPRrcumefPnwKQD4J3YSc=
X-Google-Smtp-Source: AFSGD/XSQfULWN7AoARKSaOb5FJrL1JrZ1k4/PjXnNADsTK7H5iW7hGNKgo3WEyR/WhsleRIz15sMA==
X-Received: by 2002:a63:6442:: with SMTP id y63mr2025253pgb.450.1544779703449;
        Fri, 14 Dec 2018 01:28:23 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id o4sm8751482pgs.12.2018.12.14.01.28.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 01:28:22 -0800 (PST)
Date:   Fri, 14 Dec 2018 01:28:20 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 1/3] serve: pass "config context" through to individual
 commands
Message-ID: <20181214092820.GB7121@google.com>
References: <20181211104236.GA6899@sigill.intra.peff.net>
 <20181211104342.GA7233@sigill.intra.peff.net>
 <20181214083621.GA7121@google.com>
 <20181214085507.GD11777@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214085507.GD11777@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Fri, Dec 14, 2018 at 12:36:21AM -0800, Jonathan Nieder wrote:
>> Jeff King wrote:

>>> In protocol v2, instead of just running "upload-pack", we have a generic
>>> "serve" loop which runs command requests from the client. What used to
>>> be "upload-pack" is now generally split into two operations: "ls-refs"
>>> and "fetch". The latter knows it must respect uploadpack.* config, but
>>> the former is not actually specific to a fetch operation (we do not yet
>>> do v2 receive-pack, but eventually we may, and ls-refs would support
>>> both operations).
>>
>> I think I'm missing something.  Why wouldn't "ls-refs for push" not pass
>> the information that it's for push as part of the *body* of the ls-refs
>> request?
>
> I don't know. Why doesn't the current "ls-refs" say "ls-refs for fetch"?

Also YAGNI. ;-)

In other words, since the design for push isn't set in stone yet, we had
nothing to be consistent with.  And if there's an option to ls-ref to
indicate whether it's for fetch or for push, then it can default to
fetch.

As an aside, my experience from teaching people about Git protocol is
that the concept of "ls-remote for push" producing a different result
from "git ls-remote" is very confusing.  Given what it is used for, I am
motivated to replace it with something more tailored.

> Certainly if that information was carried from the client request it
> would work fine, and ls-refs would have enough to know which config to
> respect. But I could not find any documentation on this, nor discussion
> of plans for a v2 push.

Interesting.  The last discussion of push v2 plans was in
https://public-inbox.org/git/20180717210915.139521-1-bmwill@google.com/.
Expect to hear more soon.

>                         Since that information isn't passed now, we'd
> have to assume that "ls-refs" without "for-push" always means "for
> fetch".
>
> I'm conceptually OK with that, but if that is the plan for going
> forward, it was not at all obvious to me (and it does feel rather
> implicit).

Don't get me wrong: I haven't wrapped my head around config context
and how it fits into the broader picture yet, but it may be a very
good thing to have.  So please consider this comment to be about the
commit message only.

Based on the motivation you're describing here, I think treating it as
uploadpack and adding a NEEDSWORK comment would be a good way forward.
If we're moving toward a world with more protocol commands that don't
fit in the upload-pack / receive-pack categories, then we need to
figure out in more detail what that world looks like:

- do we keep on adding new endpoints, in the same spirit as
  upload-archive?  If so, what endpoint should a client use to get
  capabilities before it decides which endpoint to use?

- do we merge everything in "git serve" except where a specific
  endpoint is needed for protocol v0 compatibility?  That would lose
  the ability to distinguish fetches from pushes without looking at
  the body of requests (which is useful to some people for monitoring,
  blocking, etc) --- do we consider that to be an acceptable loss?

- once we've decided what the future should look like, how does the
  transition to that future look?

>> Is there some other more immediate motivation for this patch?  In the
>> spirit of YAGNI, I would rather understand that motivation instead of
>> one that in many possible designs would never materialize.
>
> Without this information, in patch 3 ls-refs cannot know to look at
> uploadpack.hiderefs, unless it makes the implicit assumption that it is
> always serving a fetch.

I think that's a reasonable assumption to make, especially if made
explicit using a simple comment. :)

Thanks for explaining,
Jonathan
