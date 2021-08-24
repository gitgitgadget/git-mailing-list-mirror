Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E1AC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 22:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E76456101A
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 22:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhHXWcB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 18:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhHXWcA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 18:32:00 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9D1C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 15:31:15 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r19so33939147eds.13
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 15:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=wSRh8WwKQ3bQ1wBU9jal43XQokr9XjFLy5eHPqOlSdQ=;
        b=IuIT+mPNPvMByE9jUHePbBVC0SW/x+eFo0uYMM91Y0PPfQtV/l7ExI/brveNkJBhSe
         X5pLzUy2eFmWV4FsBIN7ZXuFgdHkw7CpbprSir9VdasoD19xno7Tn5TD0V7dmkuMutdG
         u+EEzHk3Owupia18xOF8sqW+zKngEQAKtgUXyqvyLQpNK/Q35ZQIi1P+UjZz/mYKNB1J
         nwkVLjxtkNGxAL9dT/TRtdlGuyMktYKjTXj3HpP2HsY829E03hLI8nLFbyifEYLbbvKZ
         Xyyu0HBNs4Rf0aMEXLLbsZY1kArX0stFTmYMQHaPnoBzzNGv7I0j52+gFSvyApMO1TbL
         8EZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=wSRh8WwKQ3bQ1wBU9jal43XQokr9XjFLy5eHPqOlSdQ=;
        b=QvAI+5FZyf/uvCM8VwxRG8T7662VoNJ2/e1PXXJtXz6Gyw1Y9gTQU2PHG9S6fBovHZ
         m9nXKjHJqKC5iTAxaCqlZeV594PY9HsD16Hr7VFG6yw1nzoiqQIRglDJoikflKv1O8DI
         IVF6VHeIEZI759pnx+VIbovOlJMUvztgGVtN3J+PPsqK8LxpWlpnOtxy9mBTRYr9WwN+
         L7issgtdqSqnIUG5cYV3w8an8WHeSfYlNJKrxxRN4qwmEp1t9eBMmLJ4ZW3UVvBHnusW
         oG4glsYNBztx5BgdGCwt3LWaYY7Ytrqg1iNzPK9tsV0SJfLW2HAE9A/nDUf73upvE1CG
         sMbg==
X-Gm-Message-State: AOAM530KWpTXhoDSd7C8iYgeDEN/j4mnpkcOgw/btHKyIAKJtmlkWP3o
        neqx5+xSjnY3igbENRLQspiV+Vhmn+yjIg==
X-Google-Smtp-Source: ABdhPJxLWMyWKpjUskopfQ7ipP1ovk3T5099xWlj4J1CrVmeqrPqtqtAVWq2aVQhwExoQhRP8SA37w==
X-Received: by 2002:a05:6402:1d1b:: with SMTP id dg27mr4109865edb.59.1629844273885;
        Tue, 24 Aug 2021 15:31:13 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i23sm8427057edr.72.2021.08.24.15.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 15:31:13 -0700 (PDT)
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
Date:   Wed, 25 Aug 2021 00:00:22 +0200
References: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
        <e7fe220b-2877-107e-8f7e-ea507a65feff@gmail.com>
        <87k0kcfdg0.fsf@evledraar.gmail.com>
        <c56bec68-bf00-f3b0-74b4-fd3e47319000@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <c56bec68-bf00-f3b0-74b4-fd3e47319000@gmail.com>
Message-ID: <871r6ieaq7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 23 2021, Derrick Stolee wrote:

> On 8/23/2021 9:28 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Tue, Aug 10 2021, Derrick Stolee wrote:
>>=20
>>> On 8/5/2021 11:07 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:> We=
're in the 2.33.0 rc cycle, and I'd hoped to have some more prep
>
> (I'll skip the parts where you agree with me.)
>
>>> 3. The bundle-uri feature is focused on "clone" scenarios, and I don't =
see
>>>    how it could be used to help "fetch" scenarios. To be fair, I also h=
ave
>>>    been vocal about how the packfile-uri feature is very hard to make
>>>    helpful for the "fetch" scenario. The benefits to "clone" seem to be
>>>    worth the effort alone. I think the bundle-api doubles-down on that
>>>    being the core functionality that matters, and that is fine by me. It
>>>    sacrifices the flexibility of the packfile-uri with a lower maintena=
nce
>>>    burden for servers that want to implement it.
>>=20
>> Not correct, I'm going to have it handle incremental fetches.
>>=20
>> What *is* correct is that the initial RFC patches here entirely punt on
>> it (I only hook them into clone.c, no fetch.c).
>>=20
>> I focused on the "clone" case to get to a MVP earlier, and as you note I
>> think in practice most users of this will want to only use it for clone
>> bootstrapping, and won't care so much about the incremental case.
>>=20
>> But for the "fetch" case we'd simply start fetching the N bundles in
>> parallel, and read their headers, then abort fetching any whose header
>> declares tips that we already have.
>
> To save network time, we would need to read data as it is streaming
> from the network and stop the download when we realize we don't need
> the bundle? This seems wasteful, but I'm willing to see it work in
> reality before judging it too harshly.

The common case would be making a Range request to get (what's most
likely to contain) the header, so not deciding on the fly while we're
redundantly getting data we may not use from the server.

But yes, I think for that incremental case it's likely to be better to
skip it entirely for small-ish fetches, both for client & server.

An out by default here is that a server operator would be unlikely to
configure this if they don't suspect that it's helping their use-case.

I also wonder if I shouldn't make it explicit from day 1 in the spec
that either the first listed bundle is always one without prereqs, so we
could short-circuit this on "fetch" for what's likely to be the common
case of a server operator who's only interested in this for "clone",
i.e. without any incremental bundles.

It would mostly close the door (or rather, result in redundant requests
for) someone who wants incremental-only bundles, but I can't imagine
anyone using this at all would want that, but maybe...

> It would be better if the origin Git server could see the tips that
> the user has and then only recommend bundles that serve new data.
> That requires a closer awareness of which bundles contain which
> content.

Once we're imagining this happening after the user sends over the tips
they have we're really starting to talk about something that's pretty
much indistinguishable from packfile-uri.

I.e. that happen after ls-refs & fetch negotiation, whereas bundle-uri
happens after ls-refs, but pre-negotiation.

"Pretty much" because we can imagine that instead of the server sending
the packfile-uri they'd send some hybrid of bundle-uri and packfile-uri
where instead of sending a PACK they say "oh if you want these tips
here's a bundle that has most/all of it, fetch that and get back to me".

Except the "get back to me" probably can't happen, the client would
either need to keep the server waiting as they fetch that
hybrid-bundle-uri, or disconnect, fetch it, and then re-do the
negotiation.

I can see how it might be useful if you're generating incremental
bundles anyway, but I think mostly I'd just say "well, use packfile-uri
then", but maybe I'm not being imaginative enough ... :)

>> So e.g. for a repo with a "big" bundle that's 1 week old, and 7
>> incremental bundles for the last 7 days of updates we'd quickly find
>> that we only need the last 3 if we updated 4 days ago, based on only
>> fetching their headers.
>
> I can attest that using time-based packs can be a good way to catch
> up based on pre-computed pack-files instead of generating one on
> demand. The GVFS protocol has a "prefetch" endpoint that gives all
> pre-computed pack-files since a given timestamp. (One big difference
> is that those pack-files contain only commits and trees, not blobs.
> We should ensure that your proposal can extend to bundles that serve
> filtered repos such as --filter=3Dblob:none.)

I may be wrong, and I'm at all familiar with the guts of these filtering
mechanisms, but would that even be possible? Doesn't that now involve
the server sending over a filtered PACK payload without the blobs per
client request?

Whereas a bundle per my understanding must always be complete as far as
a commit range goes, i.e. it can have prereqs, but those prereqs are
commits, not arbitrary OIDs. But maybe arbitrary OIDs (i.e. the OIDs of
the missing blob/trees etc.) would work, I haven't tried to manually
craft such a thing...

> The thing that works especially well with the GVFS protocol is that
> if we are missing a reachable object from one of those pack-files,
> then it is downloaded as a one-off request _when needed_. This allows
> the pack-files to be computed by independent cache servers that have
> their own clocks and compute their own timestamps and generate these
> pack-files as "new objects I fetched since the last timestamp".

I *think* that's covered by the above, but not sure, i.e. we're still
discussing these filtered PACKs I think...

> This is all to say that your timestamp-based approach will work as
> long as you are very careful in how the incremental bundles are
> constructed. There can really only be one list of bundles at a time,
> and somehow we need those servers to atomically swap their list of
> bundles when they are reorganized.

The current implementation theoretically racy in that we could have
bundle uris on the server defined in different parts of config (e.g. via
includes), and have a A..F "big", bundle, then F..G, G..H etc, but in
the middle of a swap-out a client might see A..E, F..G.

I think in practice the general way we read/write config in one location
should alleviate that, and for any remaining races the client will
handle it gracefully, i.e. we'll fetch that A..E try to apply (or
rather, read fail on reading the prereqs in the header) F..G on top of
it, fail and just fall back on a negotiation from E, rather than the
expected G.

>> The client spec is very liberal on "MAY" instead of "MUST" for
>> supporting clients. E.g. a client might sensibly conclude that their
>> most recent commits are recent enough, and that it would probably be a
>> waste of time to fetch the headers of the pointed-to bundles, and just
>> do a normal fetch instead.
>
> Sensible. I wouldn't expect anything less.

*Nod*, but it's useful to note that by comparison with packfile-uri, the
plan here is to have the server and its CDN not have a hard dependency
on one another. I.e. with packfile-uri if your server and CDN have a 99%
availability, your total availability is .99^2 =3D~ 98.01%.

So it's inherently a softer and more optimistic way to handle failures,
and allows server operators who aren't 100% sure of their CDN never
failing them (least clones start failing) to experiment with using one.

>> The response format is also currently:
>>=20
>>     <URI>[ <optional key-value>*]
>>=20
>> And nothing uses the "optional key-value". One of the main things I had
>> in mind was to support something like (none of these key-values are
>> specified currently):
>>=20
>>     https://example.com/big.bundle tip=3Ddeadbeef1
>>     https://example.com/incremental-1.bundle prereq=3Ddeadbeef1 tip=3Dde=
adbeef2
>>     https://example.com/incremental-2.bundle prereq=3Ddeadbeef2 tip=3Dde=
adbeef3
>>=20
>> Or:
>>=20
>>     https://example.com/big.bundle type=3Dcomplete
>>     https://example.com/incremental-1.bundle type=3Dincremental
>>     https://example.com/incremental-2.bundle type=3Dincremental
>>=20
>> I.e. allow the server to up-front to optionally specify some details
>> about the pointed-to-bundles, purely so the client can avoid the work
>> and roundtrip of trying to fetch the headers of N pointed-to bundles
>> just to see which if any it needs for a clone/fetch.
>
> Ok, this seems like a reasonable way forward. If the bundles are
> truly focused on data within a core "trunk" (say, the reflog of
> the default branch) then this works. It gets more complicated for
> repos with many long-lived branches that merge together over the
> span of weeks. I'm talking about extreme outliers like the Windows
> OS repository, so take this concern with a grain of salt. The
> point is that in that world, a single tip isn't enough sometimes.

*Nod*, but note that this would just be a shortcut over using the Range
request to get the header discussed above.

For the Windows repository you could presumably (using git.git as an
example) have bundles for:

    ..master (the big bundle, no prereqs)
    master..next
    next..ds/add-with-sparse-index
    next..ab/serve-cleanup

I.e. ds/add-with-sparse-index are two divergent branches from "next"
that we'd like to get.

A bundle header could of course have N branches and N prereqs, but for
the prereq/tip suggested above we'd handle the common case of a small
number of "big topics" that are likely to diverge quite a bit, which I
imagine the use-case you're noting is like.

>>> One question I saw Jonathan ask was "can we modify the packfile-uri
>>> capability to be better?" I think this feature has enough different goa=
ls
>>> that they could co-exist. That's the point of protocol v2, right? Serve=
rs
>>> can implement and advertise the subset of functionality that they think=
 is
>>> best for their needs.
>>=20
>> *Nod*, I also think as shown with these patches the overall complexity
>> after setting up the scaffolding for a new feature isn't very high, and
>> much of it is going away in some generally useful prep patches I'm
>> trying to get in...
>>=20
>>> I hope my ramblings provide some amount of clarity to the discussion, b=
ut
>>> also I intend to show support of the idea. If I was given the choice of
>>> which feature to support (I mostly work on the client experience, so ta=
ke
>>> my choice with a grain of salt), then I would focus on implementing the
>>> bundle-uri capability _before_ the packfile-uri capability. And that's =
the
>>> best part: more options present more flexibility for different hosts to
>>> make different decisions.
>>=20
>> Thanks again. I'll keep you CC'd on future submissions if that's OK.
>
> Sounds good. I'll try to prioritize review.
>
>> One thing I could really use to move this forward is code review of some
>> of the outstanding serieses I've got, in particular these two are
>> immediately applicable to this one. It's based on the former, and I
>> needed to steal one patch from the latter:
>>=20
>> https://lore.kernel.org/git/cover-v4-00.10-00000000000-20210805T011823Z-=
avarab@gmail.com/
>> https://lore.kernel.org/git/cover-v2-0.4-00000000000-20210823T110136Z-av=
arab@gmail.com/
>
> I'll see what I can contribute here.

Thanks, the reviews on the "unbundle progress" are already very
useful...
