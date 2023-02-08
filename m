Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E24C636CC
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 11:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjBHLuH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 06:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjBHLts (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 06:49:48 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A969749024
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 03:49:43 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id a10so12981539edu.9
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 03:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ERmKRC+G3qes22ouVuyiqxWWS1r6QIw7tKE008vrNXE=;
        b=e77HjX5yBCmzghCampgOVam5g2cTOdEAkUg1UZBhEGBkIRnxk6OY3xrUwCu/9rubQp
         nBpVcREyyfbbLeaI4h4pHaSzgplszVSzzfdFqvFJpf6rnZ94oXR/FG3AuE4cIgtneOZh
         DfUyQuChYoFgTK9ln47vk9sbYopmCAix6csfrDQRg5MJiaFBGJGOC/t+YjsoARlteI1x
         tr3tThIK0T1FulHKC7mpREOZ4FRrfA+AfUsKa6r0ULwRJ957kuOkWD2QQntIiVyeptJm
         2nnwROm/RDsdmsRU91fhcgTRxMmBPHH7JPbtiuN4642RRPTbD9OP3hDsIwpfH9CvZs2z
         P93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ERmKRC+G3qes22ouVuyiqxWWS1r6QIw7tKE008vrNXE=;
        b=lXjj/KFK2eme7AIYG/iIgyM6Suy16hMgXCjwZMdLsFR/KezH4WQ+9VZ6u544iStpqz
         57KLz8+aPnEQL19GhoupJ5JSqguW5Tprm7CjUWFKZYFVkmj6pzeq0apDjZpjUQ/mvQDW
         7ZaTcG8Z0eiHsgIgPeduCKHCNLrPeZ+0StOSfH+igwCEnXIlxwNy16gImODhd9RxnUWh
         RRIeVtcFmj6ETEeEP46yYqV32XtTC3onAFv44CfjkxuyBuuS9eFU9HA082+7BHyT3Bt6
         eVHnRqCmikIaQaSqSqb4ZYl2rUxo/xdzihhLfqAQdrOIdl4pfV1GvNCZysSlzDw63qzQ
         CEkA==
X-Gm-Message-State: AO0yUKVe32fLmYBopFP8GlK/kfSiYfbv2aRP2Tn996ibe1O01RMRsHqQ
        YMUF51aAzZFxt57IvVrWQ6o=
X-Google-Smtp-Source: AK7set/+O8+uPD4LYwgeR02jseMSEfZYEZ8ixzzoK3dHgCIxIVInzQyuLDgwdJUhxCcc6h1uipgobA==
X-Received: by 2002:a50:c30e:0:b0:4ab:15e6:12d0 with SMTP id a14-20020a50c30e000000b004ab15e612d0mr430343edb.37.1675856981985;
        Wed, 08 Feb 2023 03:49:41 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id s19-20020a170906a19300b008898c93f086sm8170129ejy.71.2023.02.08.03.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 03:49:41 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPixI-001IN6-2T;
        Wed, 08 Feb 2023 12:49:40 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Eli Schwartz <eschwartz93@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [RFC PATCH 1/1] Document a fixed tar format for interoperability
Date:   Wed, 08 Feb 2023 12:07:44 +0100
References: <20230205221728.4179674-1-sandals@crustytoothpaste.net>
        <20230205221728.4179674-2-sandals@crustytoothpaste.net>
        <230206.86lela4ebq.gmgdl@evledraar.gmail.com>
        <Y+LYQYMS7ruvRbNW@tapette.crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <Y+LYQYMS7ruvRbNW@tapette.crustytoothpaste.net>
Message-ID: <230208.86wn4sz8a3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 07 2023, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2023-02-06 at 22:18:47, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Maybe there are other changes in the proposed spec that put it at odds
>> with such a goal, it's unclear to me if this is the only difference.
>
> As mentioned in the description, that doesn't address trees, which have
> never been consistent traditionally.

You mention "[...]it produces identical results for identical trees,
regardless of hash algorithm". I'm not familiar with how we encode trees
differently based on the hash algorithm. Do we stick the tree OID in
there somewhere, or is it something else?

IOW do these trees vary within the same hash algorithm, or is it another
special-case where we now produce a different tarball with SHA-1 and
SHA-256 with commits, but also with trees?

B.t.w. are there some options to tar(1) to make it dump these headers
you're describing? I coludn't find anything when looking, it looks like
libtar might support it, but I was hoping for something more compatible
with my lazyness :)

> We also have bad permissions for pax headers (always 666), which is
> something we've tried to fix before and is not something we want to
> carry on with.

I'm concerned that you're expanding the scope of a "stable" tar format
to necessarily include one-off fixing various things we've regretted
over the years.

Maybe that *needs* to happen, but so far I don't see why, you've
described:

* We include the OID in the metadata
* Something like that, but for trees?
* The sucky 0666 permissions we'd like to fix.
* We don't serialize timestamps (which is now optional, depending on how
  you invoke it)

I really applaud your efforts here, but I don't see if that's the extent
of the changes why the v1 and default format shouldn't be something that
produces identical results to "git archive" as it stands today.

Then a v1/v2 is just this pseudocode, isn't it?

 	switch (version) {
	case 1:
		break; /* warts and all */
	case 2:
		include_oid =3D 0;
		satanic_permissions =3D 0;
		no_timestamps =3D 1;
		break;
	}

The reason we haven't promised to support an archive format isn't
because we didn't find every aspect of it aesthetically pleasing, but
because we didn't want to commit to some bug-for-bug compatibility with
whatever the code is doing right now.

Now that you've done the work to specify it, it turns out that a
proposed format you'd like going forward is almost identical to what we
currently emit, to the point that supporting that as a v1 seems rather
trivial (but again, I may still be missing something).

We have a huge long-tail of users in the wild, forcing those users to go
through a one-time breakage of their existing archives if we could avoid
that by making v1 the current format seems entirely unnecessary.

I totally see your point about wanting byte-for-byte the same archives
out of the SHA-1 and SHA-256 version of the same repo, I think that's a
good goal, and it's also a good goal to get rid of these other warts.

But I don't see why it needs to be required, or even the default.

> You specifically sent a patch stating that we're not guaranteeing that
> format, and I agree with that assessment.  I'm proposing a format that
> we would guarantee and which does not have any of the historical baggage
> or warts that we don't want to keep.

Per the above I just don't see why that's a criteria. I think we should
be weighing the benefits of changing the existing default "git archive"
output v.s. the cost of maintaining the delta to some v2 wart-less
format.

> This format also doesn't serialize timestamps; everything is at the
> Epoch.  Again, that's because serializing a commit and its tree or even
> a tag and its commit would produce different results.

This seems like further scope creep, and in this particular case I don't
see how *always* doing that helps you with reputability.

I.e. for the cases where we're now given a top-level tree it's obvious
how this helps, we encode the time(), so every time it's different.

But in the case where we get a commit (or tag) ID we use the timestamp
in the commit (or tag?) envelope.

When producing a release archive, or packing up a given commit that's
therefore going to be stable, even between SHA-1 and SHA-256, although
those two would differ if the OID is put in the header, but that's
another matter.

If I understand you correctly here you seem to be in pursuit of another
goal entirely, which is that you'd like the same output for different
commits if they're TREESAME.

Or, if you have a bunch of release archives a very nice attribute of
this is that with a bunch of similar archives on the same FS you could
e.g. benefit more from block-level deduplication.

All of which is cool, but I don't see why it needs to be a hard
requirement in the design.

>> But I don't see why we need bit-for-bit compatible output between SHA-1
>> and SHA-256 git repos for the reasons noted in the linked-to reply, and
>> removing this will remove a *really useful* aspect of our tar format,
>> which is that you can grab an arbitrary tarball, and see what commit
>> it's produced from.
>
> True, but this is a highly obscure feature and I've never used it
> outside of testing.

I admit that's a bit obscure, but one of those things that really comes
in handy when you need it, I vaguely remember using it once or twice and
being very happy it was there.

But related to that is setting everything to epoch:0, doesn't that mean
that when you unpack say a release archive that in common filesystem
browsers all of the files will be dated in the 70s, as opposed to the
time of release as it is now?

> If you want it, you can have it: you just want the
> default format, which serializes it in the header, and not the extremely
> restricted format I'm proposing here which is designed to never ever
> change.

Okey, so I might have to take back much of what I said about, so you're
not opposed to supporting the current format as a "v1" or whatever,
you'd just like this propsoed "v2" (or "vstable", or whatever) to have
some "blessed" status.

I just don't get why we wouldn't support both, if the delta is as small
as seems to be the case. If that's right this "v2" is less "extremely
restricted" to our current "v1", and more "almost identical", just "a
bit less wart-y".

> We might well decide to add cool new features and useful
> information to the default format, but this one will be fixed forever.

I just don't see the target audience for that. As the issues that
prompted these on-list discussions show we have people in the wild who
deeply care about the current format.

They probably care enough about that that we're likely to try to support
that forever, at least I don't see any currently proposed change to the
format that seems worth breaking things for those users.

So, if that's the case we'd have a v1 (current), this "vstable" (never
changes), and a v2 (v1 + extra neat things), etc.

Then we'd be maintaining 3 formats instead of 2 formats (a "v1" and
"vunstable").

>> Even if you want to retain SHA-1 and SHA-256 interop as far as tar is
>> concerned, an un-discussed alternative is to just stick the SHA-1 OID
>> into the SHA-256 archive.
>>=20
>> For repos that are migrated we envision having such a bi-directional
>> mapping anyway.
>>=20
>> And for those that started out as SHA-256, or where we no longer care
>> about compatibility with old SHA-1, we can just start including the
>> SHA-256 OID, as all compatibility concerns have gone away when we
>> stopped bothering to maintain the mapping, no?
>
> Whether SHA-1 or SHA-256 or both are present in the repo is a local
> decision.  The transition plan specifically anticipates people either
> preferring one hash or the other in output.  The behaviour is not "use
> SHA-1 if there's SHA-1 and use SHA-256 otherwise", because even if
> everyone has SHA-256 and prefers it on their system, some people may
> still have SHA-1 for historical reasons and that would lead to different
> output.

Yes, but who has this issue in practice? In practice people are
producing archives as part of some release process.

As long as they keep using SHA-1 to make release they're fine, at some
point they'll switch over to SHA-256 by default, and then their new
releases will use SHA-256.

If they then have to for some reason go back to an old commit when SHA-1
was the default it might be a tiny hassle, but no more than doing the
same if the format had changed entirely.

> Part of this is because I anticipate that once the interop work is done,
> GitHub may transition repositories on the server to SHA-256 with SHA-1
> interop for existing SHA-1 repositories.  People are still going to have
> a fit if tarball data breaks at some point because the repository owner
> decided to flip the default hash algorithm, and I'm specifically
> proposing a format that is not going to direct hordes of angry users in
> my direction or the repository owner's in that case.  Lots of people are
> going to avoid switching the default hash algorithm if it breaks
> tarballs, and I specifically don't want to encourage people sticking
> with SHA-1 for that reason.

I see that, I don't see how your plan isn't a perfect recipe for
creating the problem you're trying to avoid.

You have tarballs generated with the current format today, 3rd party
systems are dynamically downloading e.g. v1.0.0.tar.gz or whatever, and
expecting it to byte-for-byte match previous downloads.

If you're going to switch to some stable format surely that would either
need to involve massive one-off breakage, or you'd have some "flag day",
from today all new archives are produced with the new "stable" method.

If that "stable" format is different (among other things, but the others
seem equally trival) because you wanted to extract the OID from the
format for SHA-1 and SHA-256 interop, why can't the day the repository
switched to SHA-256 be that flag day?
