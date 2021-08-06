Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0541C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 17:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D305B610FC
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 17:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241438AbhHFRhY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 13:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241257AbhHFRhY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 13:37:24 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0176C0613CF
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 10:37:07 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id hs10so16368627ejc.0
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 10:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Xj0fMzP0T9/vz4bcqds+HXDXtr0Ob+k9v50g5DLV+Ac=;
        b=X8tW4bNANEuHuoSpTMjIpOH+O9dj6qq+gZIubKlRBpPyNQpjP8+owxT2FIqWfny84g
         2UxZz6w3ZErTNCELIwpyW/cWatYwJS9jTBIZait1yyUBfyZ8TZ20xrlg6XHOjaFp8okY
         23B+Fmx5cYcjZ5NZ4TroQnCZb5UADgXj7U+zaeZ6s+a8r4TjtRWbbFgHThWkGCal2Uz9
         1E9OHrdzdUY+mqEfmDty8YRkEDh2VAcYM64RKXEInnH9heXod5fhACY+IbzZ6Lbp7oKh
         ixJSIx8QIU2FvPVjivBFtDT+nxV1b1fT+UFFfZOu3FeMTk7+J4BsylOKG6ip949qq/8A
         TfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Xj0fMzP0T9/vz4bcqds+HXDXtr0Ob+k9v50g5DLV+Ac=;
        b=meaJam4WllBYVIlN0jES78soR6fef+IYBXviIwP9pnlueUBtnPJDvsSRu0KvYC6ZCA
         DUCPFBUD2WBiLZErY8n/9TElc9Zhi6ViyV5ETvPKfWg358Eoqe5+Qllw7izK22J8wc4+
         HoZOlC4tN1mazQvFFpYeAt6EDp/Aqd01TOph8GgokSF956jExOwNljEFPqSPCYcwOtQG
         5tvX1uVBW3hj2mjNG93IN1clUHMpd0drV/wWKGPcLP5KD5Y35xI6T7t2eubfEpTHhQRX
         Ywn5DG1A6ISktcxYQjk0gGAnVuSNKpj9Q8vdA3KpjcVKxsKpdawsZUUD50NGeuljKj/E
         Ns5w==
X-Gm-Message-State: AOAM5327G1N59R70R4oRf/S6FCO5lBjg0EpzbHj1342KbAi5pYJZk8zr
        zEBC7vDpLYc6c+wW5iCp88hhhCXwjLQ=
X-Google-Smtp-Source: ABdhPJxJfdE+/yd6dODUEezthXJysZV7mkt5vD+yOiU5wXHaAI6/Q9EbEg7T2oaTut72xyAMxirB7Q==
X-Received: by 2002:a17:907:72ce:: with SMTP id du14mr10972127ejc.523.1628271425600;
        Fri, 06 Aug 2021 10:37:05 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id i16sm4153194edr.38.2021.08.06.10.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 10:37:05 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [RFC PATCH 00/13] Add bundle-uri: resumably clones, static
 "dumb" CDN etc.
Date:   Fri, 06 Aug 2021 18:26:26 +0200
References: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
 <YQ1JW8hHmG8B/oE3@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YQ1JW8hHmG8B/oE3@google.com>
Message-ID: <87h7g2zd8f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 06 2021, Jonathan Nieder wrote:

> Hi,
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> We're in the 2.33.0 rc cycle, and I'd hoped to have some more prep
>> work for this integrated already, but for now here's something
>> interesting I've been working on for early commentary/feedback.
>>
>> This adds the the ability to protocol v2 for servers to optimistically
>> pre-seed supporting clients with one or more bundles via a new
>> "bundle-uri" protocol extension.
>
> My initial thought here is that even though this includes a comparison
> to packfile URIs, I suspect you're underestimating them. :)
>
> Would it be possible to do the same pre-seeding using the packfile
> URIs protocol?  Nothing stops a server from sending more objects than
> the client asked for.  Is the issue that you want the client to be
> able to list "have"s based on that pack?  Can't the server obtain that
> same information at the same time as it obtains the bundle URL?

Hi. Thanks for taking a quick look.

I think that the changes to Documentation/technical/protocol-v2.txt in
01/13[1] and the Documentation/technical/bundle-uri.txt document added
in 13/13[2] should address these questions.

Or perhaps not, but they're my currently my best effort to explain the
differences between the two and how they interact. So I think it's best
to point to those instead of coming up with something in this reply,
which'll inevitably be an incomplete rewrite of much of that.

In short, there are use-cases that packfile-uri is inherently unsuitable
for, or rather changing the packfile-uri feature to support them would
pretty much make it indistinguishable from this bundle-uri mechanism,
which I think would just add more confusion to the protocol.

> The reason I ask is that this contains a number of differences
> relative to packfile URIs, most noticeably the use of bundles instead
> of packfiles as the format for the static content.  If we were
> starting from scratch and chose this design _instead_ of packfile URIs
> then that could make sense (though there are issues with the bundle
> format that we can also go into), but in a world where people are also
> using packfile URIs it makes for a kind of confusing UX.  Is a server
> operator expected to put both kinds of files on CDN and double their
> storage bill?  Is this meant as an alternative, a replacement, or
> something that combines well together with the packfile URIs feature?
> What does the intended end state look like?

The two are complimentary, i.e. it's meant as something that combines
well with packfile-uri. One (packfile-uri) is meant as a dumb
pre-seeding of objects from static URLs that happens pre-negotiation.

The other (packfile-uri) is a post-negotiation mechanism for giving a
client not only a PACK, but complimenting it with a URI, together they
two form one logical complete PACK. (I know that you know this, but for
anyone reading along...).

> Projects like chromium have been using packfile URIs in production for
> about 11 months now and it's been working well.  Because of that, I'd
> be interested in understanding its shortcomings and improving it in
> place --- or in other words, I want _you_ to benefit from them instead
> of having to create an alternative to them.  Alternatively, if the
> packfile URIs protocol is fundamentally flawed, then I'd like us to
> understand that early and act on it instead of creating a parallel
> alternative and waiting for it to bitrot.

I don't think there's any real shortcomings of packfile-uri in the senes
that it makes sense to improve it in the direction of this bundle-uri
mechanism, they're simply doing different things at different phases in
the dialog.

When packfile-uri was initially being discussed I was interested in
getting something like what this bundle-uri mechanism to be a part it,
but it was clear from discussions with Jonathan Tan that he was taking
packfile-uri in a very different direction. Links to those discussions:

    https://lore.kernel.org/git/87k1hv6eel.fsf@evledraar.gmail.com/
    https://lore.kernel.org/git/87pnpbsra8.fsf@evledraar.gmail.com/
    https://lore.kernel.org/git/87zh35okzy.fsf@evledraar.gmail.com/

A demo of this feature playing nice with a server that supports
packfile-uri, although I haven't actually gotten it to also send me a
packfile-uri if I pre-seed with bundles (perhaps it's only doing it on
full clones?):

    git -c fetch.uriprotocols=3Dhttps \
        -c transfer.injectBundleURI=3D"https://vm.nix.is/~avar/noindex/code=
search-git-master.bdl" \
        -c transfer.injectBundleURI=3D"https://vm.nix.is/~avar/noindex/code=
search-git-recent.bdl" \
        clone --bare https://chromium.googlesource.com/chromiumos/codesearc=
h.git /tmp/codesearch.git

Will emit:
=20=20=20=20
    Cloning into bare repository '/tmp/codesearch.git'...
    Receiving bundle (1/2): 100% (322661/322661), 89.66 MiB | 0 bytes/s, do=
ne.
    Resolving deltas: 100% (142478/142478), done.
    Receiving bundle (2/2): 100% (69378/69378), 5.51 MiB | 0 bytes/s, done.
    Resolving deltas: 100% (52558/52558)completed with 4 local objects
    remote: Total 1958 (delta 4), reused 1958 (delta 4)
    Receiving objects: 100% (1958/1958), 1.60 MiB | 0 bytes/s, done.
    Resolving deltas: 100% (4/4)completed with 3 local objects
    Checking connectivity: 393997, done.

I.e. I produced a combination of bundles going up to a commit at the
start of this month, so that last "Receiving objects" is the only
dynamic fetching of objects via the negotiation.

1. https://lore.kernel.org/git/RFC-patch-01.13-4e1a0dbef5-20210805T150534Z-=
avarab@gmail.com/
2. https://lore.kernel.org/git/RFC-patch-13.13-1e657ed27a-20210805T150534Z-=
avarab@gmail.com/
