Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D556BC433F5
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 08:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD3DC60FDA
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 08:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhJ3IGD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 04:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbhJ3IGB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 04:06:01 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254B7C061570
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 01:03:31 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z20so46767419edc.13
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 01:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=0nOof5vNEOW/9ldZEvEsXt+NQ4R+1LYZkm/wKftEMK0=;
        b=HROaq1eLNnZo75K8DFIKoQ5Y4W4DJYTAekMnZxWYP3moMrRbQ65tHU7H7+Bym54PiL
         0uxzBHo65nQYPzFL6JNFivcvYWT0QMw+hdshjbZj7qtgTE9EyeLzuzYObGJDWIY4tshg
         yrNyIHBU8mbVZI07yKe/CajP3pcIEO3M4n3jOWpHa4nLBsd4oTaog6S3ihJ4YSuUTvi+
         /Ygw/wnXAnn3w1KMIsD4qfxjpukeZRu9Ojo4Lg846HhS8rCaQhgCZmwX5kYPJSmPTwdB
         2MubhDo3j2CGwYI6x20kwVLmB+M/9iF6I8IXWioKslFi3jESN4D1Xj2SKY5ApHTmkOcf
         ssJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=0nOof5vNEOW/9ldZEvEsXt+NQ4R+1LYZkm/wKftEMK0=;
        b=wJyHYFGAOsrX0e94YPmtoXgBrWzAztVzxx738EGiG3QUzPuQl5Szmwn4EJWAn4K/nR
         yR8dimiz1yPLiKNsTINT4vkfr0NvWiiAea9XlS/efjGB3Q/z2iuqVV6NAupgwn1Os53p
         5VkVJwZlLErzbuoBea1vnuYjU5Ef7FhUpnMNd23IxuV6wFg8W5lLi3oOVzuhks0Bs56e
         sQ/bFNXzTOIyRAMiVQmnE3RxIoDXcZeQ8IP6PCa/NoA/ZRiJbb0wvd1zLeA37Z6O/3FO
         5t0ifzFDvinUp1iXdbDBqf0EgrCp2JDhm/I5zeZn03Hph9khAQUZLSRFtsF/WG7Kmw8B
         z+Ag==
X-Gm-Message-State: AOAM530WkTl2a7+K+o71DLgqf20ITDknwbcpZftCrjFpH6TT57yfULCe
        PCbCjONfB/qj3ntWke7SBth2cm1HgGE=
X-Google-Smtp-Source: ABdhPJzPdJEvZNmKtKZ/ISctnelB+Ajr/oqBp9hTB327wx2jcAsB5pMNr9ifBeADRex8nGFVBM5yxg==
X-Received: by 2002:a05:6402:3489:: with SMTP id v9mr21502709edc.130.1635581009184;
        Sat, 30 Oct 2021 01:03:29 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bw25sm3940365ejb.20.2021.10.30.01.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 01:03:28 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mgjKp-0026uM-O4;
        Sat, 30 Oct 2021 10:03:27 +0200
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
Subject: Re: [PATCH 0/3] bundle-uri: "dumb" static CDN offloading, spec &
 server implementation
Date:   Sat, 30 Oct 2021 09:21:38 +0200
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com>
 <c9c4e1e7-aaa2-bbad-355b-8439fad93fa7@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <c9c4e1e7-aaa2-bbad-355b-8439fad93fa7@gmail.com>
Message-ID: <211030.86mtmr3po0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 29 2021, Derrick Stolee wrote:

> On 10/25/2021 5:25 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> This implements a new "bundle-uri" protocol v2 extension, which allows
>> servers to advertise *.bundle files which clients can pre-seed their
>> full "clone"'s or incremental "fetch"'s from.
>>=20
>> This is both an alternative to, and complimentary to the existing
>> "packfile-uri" mechanism, i.e. servers and/or clients can pick one or
>> both, but would generally pick one over the other.
>>=20
>> This "bundle-uri" mechanism has the advantage of being dumber, and
>> offloads more complexity from the server side to the client
>> side.
>
> Generally, I like that using bundles presents an easier way to serve
> static content from an alternative source and then let Git's fetch
> negotiation catch up with the remainder.
>
> However, after inspecting your design and talking to some GitHub
> engineers who know more about CDNs and general internet things than I
> do, I want to propose an alternative design. I think this new design
> is simultaneously more flexible as well as promotes further decoupling
> of the origin Git server and the bundle contents.
>
> Your proposed design extends protocol v2 to let the client request a
> list of bundle URIs from the origin server. However, this still requires
> the origin server to know about this list. [...]

Interesting, more below...

> Further, your implementation focuses on the server side without
> integrating with the client.

Do you mean these 3 patches we're discussing now? Yes, that's the
server-side and protocol specification only, because I figured talking
about just the spec might be helpful.

But as noted in the CL and previously on-list I have a larger set of
patches to implement the client behavior, an old RFC version of that
here (I've since changed some things...):
https://lore.kernel.org/git/RFC-cover-00.13-0000000000-20210805T150534Z-ava=
rab@gmail.com/

I mean, you commented on those too, so I'm not sure if that's what you
meant, but just for context...

> I propose that we flip this around. The "bundle server" should know
> which bundles are available at which URIs, and the client should contact
> the bundle server directly for a "table of contents" that lists these
> URIs, along with metadata related to each URI. The origin Git server
> then would only need to store the list of bundle servers and the URIs
> to their table of contents. The client could then pick from among those
> bundle servers (probably by ping time, or randomly) to start the bundle
> downloads.

I hadn't considered the server not advertising the list, but pointing to
another URI that has the list. I was thinking that the server would be
close enough to whatever's generating the list that updating the list
there wouldn't be a meaningful limitation for anyone.

But you seem to have a use-case for it, I'd be curious to hear why
specifically, but in any case that's easy to support in the client
patches I have.

There's a point at which we get the list of URIs from the server, to
support your case the client would just advertise the one TOC URI.

Then similarly to the "packfile-uri" special-case of handling a *.bundle
instead of a PACK that I noted in [1], the downloader would just spot
"oh this isn't a bundle, but list of URIs, and then fetch those (even
recursively), and eventually get to *.bundle files.

> To summarize, there are two pieces here, that can be implemented at
> different times:
>
> 1. Create a specification for a "bundle server" that doesn't need to
>    speak the Git protocol at all. This could be a REST API specification
>    using well-established standards such as JSON for the table of
>    contents.
>
> 2. Create a way for the origin Git server to advertise known bundle
>    servers to clients so they can automatically benefit from faster
>    downloads without needing to know about bundle servers.
>
> There are a few key benefits to this approach:
>
>  * Further decoupling. The origin Git server doesn't need to know how
>    the bundle server organizes its bundles. This allows maximum flexibili=
ty
>    depending on whether the bundles are stored in something like a CDN
>    (where bundles can't be too big) or some kind of blob storage (where
>    they can have arbitrarily large size).
>
>  * The bundle servers could be run completely independently from the
>    origin Git server. Organizations could run their own bundle servers to
>    host data in the same building as their build farms. As long as they
>    can configure the bundle location at clone/fetch time, the origin Git
>    server doesn't need to be involved.
>
> While I didn't go so far as to create a clear standard or implement a
> prototype in the Git codebase, I created a very simple prototype [1] using
> a python script that parses a JSON table of contents and downloads
> bundles into the Git repository. Then, I made a 'clone.sh' script that
> initializes a repository using the bundle fetcher and fetching the
> remainder from the origin Git server. I even computed static bundles for
> the git.git repository based on where 'master' has been over several days
> in the past month, to give an example of incremental bundles. You can
> test the approach all the way to including the fetch to github.com (note
> how the GitHub servers were not modified in any way for this).
>
> [1] https://github.com/derrickstolee/bundles
>
> There are a lot of limitations to the prototype, but it hopefully
> demonstrates the possibility of using something other than the Git protoc=
ol
> to solve these problems.

In your proposal the TOC bundle itself doesn't need to speak the git
protocol.

But as as soon as we specify such a thing all of that becomes a part of
the git protocol at large in any meaningful way, i.e. git.git's client
and any other client that wants to implement the full protocol at large
would now need to understand not only pkt-line but also ship a JSON
decoder etc.

I don't see an inherent problem with us wanting to support some nested
encoding format as part of the protocol, but JSON seems like a
particularly bad choice. It's specified as UTF-8 only (or rather, "a
Unicode enoding"), so you can't stick both valid UTF-8 and binary data
into it.

Our refs on the other hand don't conform to that, so having a JSON
format means you can never have something that refers to refnames, which
given that we're talking about bundles, whose own header already has
that information.

> Let me know if you are interested in switching your approach to something
> more like what I propose here. There are many more questions about what
> information could/should be located in the table of contents and how it c=
an
> be extended in the future. I'm interested to explore that space with you.

As noted above, the TOC part of this seems interesting, and I don't see
a reason not to implement that.

But as noted in [1] I really don't see why it would be a good idea to
implement a side-format that's encoding a limited subset of what you'd
find in bundle headers.

Specifically on the meta-information you're proposing:

=3D=3D requires

In your example you've added a monolithic "requires" relationship
between bundles, saying "This assumes that the bundles can be ordered".

But that's not something you can assume for actual bundle files,
i.e. the prerequisite relationship is per-reftip, it's not the case that
a given bundle requires another bundle, it's the case that tips found in
them may or may not depend on other prerequisites.

If you're creating bundles that contain only one tip there's a 1=3D1
mapping to what you're proposing with "requires", but otherwise there
isn't.

=3D=3D timestamp

"This allows us to reexamine the table of contents and only download the
bundles that are newer than that timestamp."

We're usually going to be fetching these over http(s), why duplicate
what you can already get if the server just takes care to create unique
filenames (e.g. as a function of the SHA of their contents), and then
provides appropriate caching headers to a client so that they'll be
cached forever?

I think that gives you everything you'd like out of the "timestamp" and
more, the "more" being that since it's part of a protocol that's already
standard you'd have e.g. intermediate caching proxies understanding this
implicitly, in addition to the git client itself.

So on a network that's say locally unpacking https connections to a
public CDN you could have a local caching proxy for your N local
clients, as opposed to a custom "timestamp" value, which only each local
git client will understand.

=3D=3D Generally

Sorry, I've got to run, so I haven't addressed all the things you
brought up, but generally while I think that the TOC idea is a good one.

I don't see a reason for why most/all of the other bits shouldn't be
leaning into either the bundle header (and for any TOC shortcut, dump it
as-is, as noted in [1]), or in the case of "timestamp" lean into the
properties of the transport protocol.

And just generally on overall protocol complexity, wouldn't it be OK if
any such TOC is just in pkt-line format?

We could just provide a git plumbing tool to spew that out, and having
some static server job call that once and ever more serve up a a
plain-file doesn't seem like a big restriction, and would mean that any
git client code wouldn't need to deal with another encoding format.

1. https://lore.kernel.org/git/211027.86a6iuxk3x.gmgdl@evledraar.gmail.com/
