Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B1CC433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 09:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFCAF60EB4
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 09:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239778AbhJ0JFT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 05:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236159AbhJ0JFS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 05:05:18 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C44C061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 02:02:53 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so1726473wmz.2
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 02:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=/IWeUYjmmn2+PUekveTrAd+vt30dwLRVN+VsDJfLzK4=;
        b=GQ7SWj0JD+UtvRmcElHgX7Q1FtayDAEbtUtvyRgqV6/IStleKmQFtuwx7aTCnUmnAK
         2jWx06kfl9ioVMRCB6aK4dFvGZMQVFjrxS/hsI/oKpwITJ6cAr5YAgmK2y75ng+FFjBB
         q8AtPOQtJTEHid+SfR/aKnP0y4uncSjdQhhDOSza04rA3udU7kyURYKP1vO/pY+CFM5H
         TXgM4Vs4G4WQQye9OwyD489+ZXkTgZMqXJPD1TxdR7k05bnBXpUnGSovngE/0huid/SK
         HWXuxHCMn9Vb0xsrqU3vwNdATTl4N3c0PaxircD71O9fjLgBj/pNghNBe3cjROyQt+dM
         QRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=/IWeUYjmmn2+PUekveTrAd+vt30dwLRVN+VsDJfLzK4=;
        b=IK6PV+0qZ5Jq+G4LK3nNiJaq7jyCNLvQrNQ3lzvHijXsiIPS73ggaMw08bnrUJZe8L
         KS4CTEZBCFFmNLJ8lPyw4b/uIyv34rzYMubP+Or61r/Xv7nKSZhVfexoCK7GNYhBDitk
         gJHzA08Fawo0n8vx0bP1UcvnoOjbw/UYGQ+Yf1FJUZKdb5TGBGb2gWb58xbbGyJiS4SC
         Ugzd4hnjr8PYBlWSMaKJUx4HmZ83uhIPtgKg4NpQtltsm2cIAMMe4g9RvRRlgetegi8V
         3u0i/1YT1+QJ3vv51LHRR9nG0YJGeMBAcG67yQ3CaEq+f9VPllRsr9WKPABXj081Cnl+
         DsTg==
X-Gm-Message-State: AOAM531S3a7o49yIXK9QOl9AFqKeBY0X338qXcxyJrPZy/ihyiu6iDWk
        eHg+ZCV84LYFmdyfZmAQ1lB1Y2hfVFE=
X-Google-Smtp-Source: ABdhPJzTcENP36DO2ibn3FcCzhg2FfFim4gkogqlc8SokM0PpWvZ9wEtzzTtuqD1E+UXlzi2dbZF8Q==
X-Received: by 2002:a7b:c4c1:: with SMTP id g1mr4382052wmk.2.1635325371239;
        Wed, 27 Oct 2021 02:02:51 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n68sm2755669wmn.13.2021.10.27.02.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 02:02:50 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mfepd-001yf8-Rg;
        Wed, 27 Oct 2021 11:02:49 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        "Robin H . Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH 2/3] protocol v2: specify static seeding of clone/fetch
 via "bundle-uri"
Date:   Wed, 27 Oct 2021 10:29:35 +0200
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com>
 <patch-2.3-3ac0539c053-20211025T211159Z-avarab@gmail.com>
 <7fab28bf-54e7-d0e9-110a-53fad6244cc9@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <7fab28bf-54e7-d0e9-110a-53fad6244cc9@gmail.com>
Message-ID: <211027.86r1c6yh52.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 26 2021, Derrick Stolee wrote:

> On 10/25/2021 5:25 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Add a server-side implementation of a new "bundle-uri" command to
>> protocol v2. As discussed in the updated "protocol-v2.txt" this will
>> allow conforming clients to optionally seed their initial clones or
>> incremental fetches from URLs containing "*.bundle" files created with
>> "git bundle create".
>
> ...
>
>> +DISCUSSION of bundle-uri
>> +^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +The intent of the feature is optimize for server resource consumption
>> +in the common case by changing the common case of fetching a very
>> +large PACK during linkgit:git-clone[1] into a smaller incremental
>> +fetch.
>> +
>> +It also allows servers to achieve better caching in combination with
>> +an `uploadpack.packObjectsHook` (see linkgit:git-config[1]).
>> +
>> +By having new clones or fetches be a more predictable and common
>> +negotiation against the tips of recently produces *.bundle file(s).
>> +Servers might even pre-generate the results of such negotiations for
>> +the `uploadpack.packObjectsHook` as new pushes come in.
>> +
>> +I.e. the server would anticipate that fresh clones will download a
>> +known bundle, followed by catching up to the current state of the
>> +repository using ref tips found in that bundle (or bundles).
>> +
>> +PROTOCOL for bundle-uri
>> +^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +A `bundle-uri` request takes no arguments, and as noted above does not
>> +currently advertise a capability value. Both may be added in the
>> +future.
>
> One thing I realized was missing from this proposal is any interaction
> with partial clone. It would be disappointing if we could not advertise
> bundles of commit-and-tree packfiles for blobless partial clones.
>
> There is currently no way for the client to signal the filter type
> during this command. Not having any way to extend to include that
> seems like an oversight we should remedy before committing to a
> protocol that can't be extended.
>
> (This also seems like a good enough reason to group the URIs into a
> struct-like storage, because the filter type could be stored next to
> the URI.)

I'll update the docs to note that. I'd definitely like to leave out any
implementation of filter/shallow for an initial iteration of this for
simplicity, but the protocol keyword/behavior is open-ended enough to
permit any extension.

I.e. the server can start advertising "bundle-uri=3Dshallow", and future
clients can request arbitrary key-value pairs in addition to just
"bundle-uri" now.

Having said that I think that *probably* this is something that'll never
be implemented, but maybe I'll eat my words there.

The reason is that once we're in the "fetch" dialog with the server, as
we are with "filter" and "shallow" I'd think that we'd be better of just
sending a packfile-uri, since that's tailor-made for that use-case.

But I suppose we could also advertise e.g.:

    <bundle-uri> tip=3D<oid> depth=3D1

Which a client that noticed that it noticed say the --single-branch at
<oid> but with depth=3D1 could use before it ever got to "fetch".

But (and I haven't looked into this really) I'd think that would quickly
get you into having a bundle with a PACK payload that wouldn't be
representable with the current bundle header format, which I think we'd
always want a 1=3D1 mapping of. I.e. you can specify a prereq, but not
leave out trees/blobs etc.

So thoughts on that most welcome, in particular how it could be made
future-proof.
