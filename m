Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC88C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 14:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0664613AD
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 14:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhHWOXZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 10:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhHWOXY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 10:23:24 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09011C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 07:22:42 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ia27so15211869ejc.10
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 07:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=EXLqAKeMFwR2reSXRfvtJt/jvJl12Wb9F57I8Fn9F54=;
        b=B7E9KKL1o3Ao3u8cCQLjD1wRWwNTunNDyd2gDqWbadKJLJPzZnPOQ89BK7n7ShyJGq
         KK7ZcDedjpnqJzK7SDHGUwAQuu3igoNozyvDUCjqf1GXQ7LK/p77olDv456RYn5XSppy
         +aS10qnSNCdcePPtWoEVem/UmZ087es+2LCR7dD/EMZUdgALBeyz4U/g8fcvyJ+2DAFS
         I1yYUI8MkkDujG9H0j9JD0HkpgEVL6Tn4lN4xdl2epUpZsBpxEzoxXF+8S920FwKfIeQ
         Y43bwdaGo6Gou8+YKKvBbG4ykKg9zf8WnFubjcUC1B34AH6/i6Goip8Wkr010iBU6F3Y
         TW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=EXLqAKeMFwR2reSXRfvtJt/jvJl12Wb9F57I8Fn9F54=;
        b=F9woMl6xHqlRy4/fdecdCn9Pjm+tHbZYXFlIdufOpN1HXTXXit/W72eeuuKlnZs5sA
         hKQKRtqUMAT48WlAh1J5afEbgaNJkhX6kWnYkHpDSzw1AiOQYFlQGc4rpKCS4wwfADNB
         JAO2OtApUJiUQVEKhwdBooskN+zosPCQ+IEKMONcXcFu1zT3M7tWiQ/oGyPXAUGP0THw
         7rJLcfTUNf+sPbprheWmxEFB6IBs4Kzi5v5HKtqY+E+D0WmyGz6VKyXVVCU/xxEMjujS
         RwVjZRD9aDlh0xD3qiYIimw4g42DDdnUOQd5ktotr+R1LP/6DN8l3/StHBxxc2F4TZRo
         fgMg==
X-Gm-Message-State: AOAM5305oKFtuLK3k2O4kskNWFFAbnG9tpXW3KD9ExVFPvoLejw/m+hk
        3f5jFdP51cIijX7C6rRxuSJhyqRsG+uJEUCu
X-Google-Smtp-Source: ABdhPJxEZ1Ixj6OZ+Fxlwp8+rgSR0UXtjfdtfHraxYpXBlL23Hy9ADVRA1RCXo1bnwBNWZsfCCJAsw==
X-Received: by 2002:a17:906:fb91:: with SMTP id lr17mr35876233ejb.110.1629728560331;
        Mon, 23 Aug 2021 07:22:40 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z10sm7462053ejg.3.2021.08.23.07.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 07:22:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 00/13] Add bundle-uri: resumably clones, static
 "dumb" CDN etc.
Date:   Mon, 23 Aug 2021 15:28:42 +0200
References: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
 <e7fe220b-2877-107e-8f7e-ea507a65feff@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <e7fe220b-2877-107e-8f7e-ea507a65feff@gmail.com>
Message-ID: <87k0kcfdg0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 10 2021, Derrick Stolee wrote:

> On 8/5/2021 11:07 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:> We'r=
e in the 2.33.0 rc cycle, and I'd hoped to have some more prep
>> work for this integrated already, but for now here's something
>> interesting I've been working on for early commentary/feedback.
>
> I've taking a brief look at the code, but mostly have thoughts about the
> core idea based on reading the documentation. I'll keep my feedback here
> restricted to that, especially because I saw some thoughts from Jonathan
> that question the idea.

Thanks a lot for taking a look, and sorry about the very late reply. I
was away from the computer for a while (on vacation).

>> This adds the the ability to protocol v2 for servers to optimistically
>> pre-seed supporting clients with one or more bundles via a new
>> "bundle-uri" protocol extension.
>
> To make sure I understand things correctly, I'm going to rewrite the
> description of the feature in my own words. Please correct me if I have
> misread something.

Thanks. I'll probably try to steal some of this summary...

> This presents a new capability for protocol v2 that allows a server to
> notify a client that they can download a bundle to bootstrap their object
> database, and then come back to the origin server to "catch up" the
> remaining new objects since that bundle via a fetch negotiation.
>
> This idea is similar to the packfile-uri feature in that it offloads some
> server load to a dumb data store (like a CDN) but differs in a few key
> ways:
>
> 1. The bundle download does not need to be controlled by the server, and
>    the server doesn't even need to know its contents. The client will
>    discover the content and share its view in a later negotiation.

Correct.

> 2. The packfile-uri could advertise a pack that contains only the large
>    reachable blobs, and hence could use the "happy path" for bitmaps to
>    compute a packfile containing all reachable objects except these large
>    blobs. For the bundle-uri feature to mimic this, the blobs would need
>    to be reachable from refs (perhaps shallow tags?) but it would not be
>    clear that the negotiation would prevent redownloading those files.
>    This is an area to explore and expand upon.

Correct that this isn't handled currently.

The few paragraphs below are mostly a (hopefully helpful) digression.

Despite what I said in
https://lore.kernel.org/git/87h7g2zd8f.fsf@evledraar.gmail.com/ about
packfile-uri and bundle-uri playing nicely together there are cases
where they won't. They won't error out or anything, just that combining
them in those cases won't make much sense.

In particular if you now use packfile-uri to exclude one giant blob from
your early history, you can't use bundle-uri to serve up that early
history without also including that blob (as we'll expect the bundles to
be connected).

That property isn't inherent though, in the same way that we're clever
about .gitmodules checking we could make note of any missing content and
do a full connectivity check at the end.

But if you're using packfile-uri for that "one big blob on a CDN" I
don't see why you wouldn't be happy to serve it up in your bundle, so I
don't see much of a practical reason for further work in that area.

And yes, you do run into limitations in the general negotiation
mechanism eventually (which to be fair, we probably wouldn't care about
before bundle-uri). E.g. we can't say we HAVE a blob OID currently
(server expects commit OID).

I don't see why it *couldn't* be supported though, and would be handled
under the hood with the same happy path for bitmaps that we use for
packfile-uri exclusions now...

> 3. The bundle-uri feature is focused on "clone" scenarios, and I don't see
>    how it could be used to help "fetch" scenarios. To be fair, I also have
>    been vocal about how the packfile-uri feature is very hard to make
>    helpful for the "fetch" scenario. The benefits to "clone" seem to be
>    worth the effort alone. I think the bundle-api doubles-down on that
>    being the core functionality that matters, and that is fine by me. It
>    sacrifices the flexibility of the packfile-uri with a lower maintenance
>    burden for servers that want to implement it.

Not correct, I'm going to have it handle incremental fetches.

What *is* correct is that the initial RFC patches here entirely punt on
it (I only hook them into clone.c, no fetch.c).

I focused on the "clone" case to get to a MVP earlier, and as you note I
think in practice most users of this will want to only use it for clone
bootstrapping, and won't care so much about the incremental case.

But for the "fetch" case we'd simply start fetching the N bundles in
parallel, and read their headers, then abort fetching any whose header
declares tips that we already have.

So e.g. for a repo with a "big" bundle that's 1 week old, and 7
incremental bundles for the last 7 days of updates we'd quickly find
that we only need the last 3 if we updated 4 days ago, based on only
fetching their headers.

The client spec is very liberal on "MAY" instead of "MUST" for
supporting clients. E.g. a client might sensibly conclude that their
most recent commits are recent enough, and that it would probably be a
waste of time to fetch the headers of the pointed-to bundles, and just
do a normal fetch instead.

The response format is also currently:

    <URI>[ <optional key-value>*]

And nothing uses the "optional key-value". One of the main things I had
in mind was to support something like (none of these key-values are
specified currently):

    https://example.com/big.bundle tip=3Ddeadbeef1
    https://example.com/incremental-1.bundle prereq=3Ddeadbeef1 tip=3Ddeadb=
eef2
    https://example.com/incremental-2.bundle prereq=3Ddeadbeef2 tip=3Ddeadb=
eef3

Or:

    https://example.com/big.bundle type=3Dcomplete
    https://example.com/incremental-1.bundle type=3Dincremental
    https://example.com/incremental-2.bundle type=3Dincremental

I.e. allow the server to up-front to optionally specify some details
about the pointed-to-bundles, purely so the client can avoid the work
and roundtrip of trying to fetch the headers of N pointed-to bundles
just to see which if any it needs for a clone/fetch.

This peeking behind the curtain would always yield to the source of
truth of inpecting the bundle header/content itself, so it would be
purely an optional client hint. It's also not as flexible as a full
bundle header (e.g. can't supply N tips or N prereqs, but for the common
case of "one big history" it should work nicely.

But maybe this use for key-value headers would be a premature
optimization, I haven't actually benchmarked it...

> The biggest benefit that I see is that the Git server does not need to
> worry about whether the bundle has an exact set of data that it expects.
> There is no timing issue about whether or not the exact packfile is seede=
d.
> Instead, the server could have a fixed URL for its bundle and update its
> contents (atomically) at any schedule without worrying about concurrent
> clones being interrupted. From an operational perspective, I find the
> bundle-uri a better way to offload "clone" load.

Thanks, yeah. That's pretty the main reason I hacked this up when we
already have packefile-uri, being able to e.g. have a dumb cronjob
(which may not even run) optimistically handle your CDN offloading.

> This also depends on that following "git fetch" being easy to serve. In
> that sense, it can be beneficial to be somewhat aware of the bundles that
> are being served: can we store the bundled refs as reachability bitmaps so
> we have those available for the negotiation in the following "git fetch"
> operations? This choice seems specific to how the server is deciding to
> create these bundles.

Yeah, one of the first things I'm experimenting with on the server side
(but haven't yet) is to generate bundles on the one hand, and being
aware of the last generated bundle do the equivalent of pre-populating
the pack-objects hook cache in anticipation of pre-seeded clients coming
in.

> It also presents interesting ideas for how to create the bundle to focus
> on some core portion of the repo. The "thundering herd" of CI machines
> that re-clone repos at a high rate will also be likely to use the
> "--single-branch" option to reduce the refs that they will ask for in the
> negotiation. In that sense, we won't want a snapshot of all refs at a
> given time and instead might prefer a snapshot of the default branch or
> some set of highly-active branches.

Yes, the current RFC MVP I have is rather dumb about this, but it's an
easy follow-up change along with the "fetch" support to e.g. have a
server have one "big" bundle of just its main branch in anticipation of
--single-branch --no-tags fetches, and then the next bundle is the delta
between that and the other branches.

So the first is master, the second is master..next, master..seen + tags
etc. The client from ls-refs what tips it wants, so it can then ignore
or retrieve the bundles as appropriate.

A server operator can then play around with what they think might be the
optimal arrangement and split-up of bundles.

They obviously can't handle all cases, e.g. if you have a bundle with
"master" and clone just git.git's "todo" branch with these current
patches you'll get redundant objects you don't need currently, but a
slightly smarter client will be ignoring that bundle-uri.

> One question I saw Jonathan ask was "can we modify the packfile-uri
> capability to be better?" I think this feature has enough different goals
> that they could co-exist. That's the point of protocol v2, right? Servers
> can implement and advertise the subset of functionality that they think is
> best for their needs.

*Nod*, I also think as shown with these patches the overall complexity
after setting up the scaffolding for a new feature isn't very high, and
much of it is going away in some generally useful prep patches I'm
trying to get in...

> I hope my ramblings provide some amount of clarity to the discussion, but
> also I intend to show support of the idea. If I was given the choice of
> which feature to support (I mostly work on the client experience, so take
> my choice with a grain of salt), then I would focus on implementing the
> bundle-uri capability _before_ the packfile-uri capability. And that's the
> best part: more options present more flexibility for different hosts to
> make different decisions.

Thanks again. I'll keep you CC'd on future submissions if that's OK.

One thing I could really use to move this forward is code review of some
of the outstanding serieses I've got, in particular these two are
immediately applicable to this one. It's based on the former, and I
needed to steal one patch from the latter:

https://lore.kernel.org/git/cover-v4-00.10-00000000000-20210805T011823Z-ava=
rab@gmail.com/
https://lore.kernel.org/git/cover-v2-0.4-00000000000-20210823T110136Z-avara=
b@gmail.com/
