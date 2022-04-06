Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139C9C433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 12:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiDFNAT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 09:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiDFM71 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 08:59:27 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4353DBC9C
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 02:24:05 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b24so1833483edu.10
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 02:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=3hMM6tbg5GZQo3o++W/LO58UUqIPCVAlBzZfvg4oGtU=;
        b=FUqXjBx9zwvI9lxxnvxfc4+tMf6lAto7e1d3sYXvbZR3ylwWbQbHyCWG+kQlKrocXL
         d9vV3j45t6JPYAYtTGfScfqyjidRAkI2mSCnSAGQBcKSDiIls0ceN8W1Y10h4zZ91jCL
         DsRHlBUXaWuVvSjhNtTHjS8cxxoI9lhKdbNbk/FYELsc/PqYDprUW+yxulOj/Yh2yH+p
         2kRptivgzcxFccn2X1JSSOCMzzbKyQjgmGfBsjN/g1lRHYyoDjP4JHc1E9xk0WrTQwOp
         qWoiEktf6wsTGxPgtof1ZOdPe6ZrwqbK5izSNQSQpXH6DfkWe8x7jPR0QKLehES2S34c
         QtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=3hMM6tbg5GZQo3o++W/LO58UUqIPCVAlBzZfvg4oGtU=;
        b=HB/5QJosGVGYBGdLwZABO7616CcC9zdWWFKSHf7OuxYWAzUcx7Zon0IqAJWpr2Kslz
         Wmuzt/Pv3cR2b3s2GY2STT8bzczPrG9vz051gZNWR93lvucPeLg/8Rk98mN4DQJxkYQC
         M2rrmsE651YaTeLCmKmfQLBBnISr/0oVYYehgOGozPQr01D2szhcDGY6sHPWRY5Obwlv
         5Vc2nCLvD4WretBShHojOWsmzGC2D8LRNkK2ILnMorLRe7UxYjrOgzyaZ2wwuiwWkWGX
         CgP4AizKkeN3xJfEdLwOo5KqfxKvIEwuDJY4l2z+o1vNlHYoc9qIC4AphvKT5oR1kl7W
         IsHA==
X-Gm-Message-State: AOAM533kXyZr5sdaZUCgw/kkTX9PIqcwjo2nSU949ZcZkPZnjfX/+nrO
        MJ/HqZGSB0NdrWsSLOrpowQ=
X-Google-Smtp-Source: ABdhPJx0W+c4XjBshXtuL9n9hqGYe1sm+MVVv4BmabV+48YZikY1oIybmVfBQ/gLNGo7C0mFn2GxQw==
X-Received: by 2002:aa7:d70e:0:b0:419:1e2c:e1ea with SMTP id t14-20020aa7d70e000000b004191e2ce1eamr7765671edq.202.1649237012471;
        Wed, 06 Apr 2022 02:23:32 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z2-20020a17090674c200b006e13403964asm6411114ejl.77.2022.04.06.02.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 02:23:31 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nc1sw-000bHs-Qm;
        Wed, 06 Apr 2022 11:23:30 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 3/4] builtin/stash: provide a way to export stashes
 to a ref
Date:   Wed, 06 Apr 2022 11:05:28 +0200
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220329214941.2018609-1-sandals@crustytoothpaste.net>
 <20220329214941.2018609-4-sandals@crustytoothpaste.net>
 <220331.86pmm2swm9.gmgdl@evledraar.gmail.com>
 <YkwgGjj0JIcOhlMH@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YkwgGjj0JIcOhlMH@camp.crustytoothpaste.net>
Message-ID: <220406.86fsmqefal.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 05 2022, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2022-03-31 at 01:56:01, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Tue, Mar 29 2022, brian m. carlson wrote:
>>=20
>> > diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
>> > index 6e15f47525..162110314e 100644
>> > --- a/Documentation/git-stash.txt
>> > +++ b/Documentation/git-stash.txt
>> > @@ -20,6 +20,7 @@ SYNOPSIS
>> >  'git stash' clear
>> >  'git stash' create [<message>]
>> >  'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
>> > +'git stash' export ( --print | --to-ref <ref> ) [<stash>...]
>> >=20=20
>> >  DESCRIPTION
>> >  -----------
>> > @@ -151,6 +152,12 @@ store::
>> >  	reflog.  This is intended to be useful for scripts.  It is
>> >  	probably not the command you want to use; see "push" above.
>> >=20=20
>> > +export ( --print | --to-ref <ref> ) [<stash>...]::
>> > +
>>=20
>> I think this extra \n here isn't needed.
>
> All the rest of the entries have it that way.  Junio likes it, you
> don't, but it's consistent with the rest of the file and I'm just
> following along.

FWIW I really don't mind. I vaguely thought it might be an ASCIIDOC
syntax error as I'm used to seeing the other form, as e.g. adding an
extra \n before the following "+" is.

But it's not, and it's indeed consistent with the rest. looks good.

>> Can nalloc be moved into the if=3Delse scopes?
>
> It _can_, but it's used in both, so I don't see a particular reason to
> do so.

I don't mind, FWIW the reason is just to save the reader skimming to
track down the various bits of the manual memory allocation.

But as you noted in the v3 reply this can also just use oidset, so ...

>> > +				goto out;
>> > +			}
>> > +		}
>> > +	} else {
>> > +		/*
>> > +		 * Walk the reflog, finding each stash entry, and load data into the
>> > +		 * array.
>> > +		 */
>> > +		for (int i =3D 0;; i++) {
>>=20
>> Aside from the C99 dependency Junio mentioned, this should also be size_=
t.
>
> Nope.  I specifically decided not to do that and mentioned it in the
> cover letter.  Since Windows doesn't let us have nice things like %zu,
> I'm going to switch to int here and be consistent.

You mean to avoid PRIuMAX instead of %d with:

    snprintf(buf, sizeof(buf), "%d", i);

?

> [...(moved around)...]
>> Did you spot my "count down" suggestion in
>> https://lore.kernel.org/git/220311.86bkydi65v.gmgdl@evledraar.gmail.com/
>> on the v1?
>
> I did, and I prefer this approach.  That would be necessary if we were
> using size_t here, but we're not.
> [...]

> I'm not coding for 16-bit systems here and I feel 2 billion stashes is
> sufficient for the needs of the project for the indefinite future
> based on the capabilities of current human beings.

I just thought you might not have seen the v1 feedback, fair enough. And
I'm not going to argue that point here.

Just as an explanation: The reason to use these sorts of patterns isn't
because we might need to support 16 bit in the future, which we won't,
or that I think it's plausible that someone might have >2^31-1 stashes.

It's that we've been changing to larger types across the codebase, and
e.g. in 99d60545f87 (string-list API: change "nr" and "alloc" to
"size_t", 2022-03-07) changing to an unsigned type required changing
such an iterator.

So if we really don't need negative numbers, but are just using -1 as a
value to "stop" in a for-loop it's IMO worth it in general to just stick
with unsigned, it makes things more future-proof.

Also, not gcc or clang, but e.g. HP/UX's aCC compiler screams bloddy
murder about various "why are you assuming unsigned here?" in
comparisons across the codebase, which gcc/clang stay quiet about, to
the point where it downs out other useful warnings it gives about actual
potential issues.

That's not *directly* related to this, which it wouldn't warn about as
it's "int". But generally it's a result of us being loose in mixing
unsigned and signed types when it comes to a count of a number of items
that can't be negative, and won't be exact for "guard clause" code like
this.

And finally, even if we might say that more than 2^31-1 stashes is
insane it's just easier to reason about code where multiple "counts" are
in play if you don't need to carefully think about that aspect.

Anyway, </by-way-of-explanation over>. But just to be clear I think it's
fine that you want to keep this as-is.

>> > +	ret =3D do_export_stash(ref, argc, argv);
>> > +	return ret;
>>=20
>> Aside from the "ret" case above, maybe this would be better if the
>> "action" check became a swith, then the compiler would help check it
>> against the enum, and this wouldn't implicitly be both ACTION_PRINT and
>> ACTION_TO_REF, but could be done via a fall-through.
>
> Normally I'm a big fan of switch statements, but I don't feel in this
> case that it logically represents the current code.  I think, given the
> context, that an if-else is easier to read.

Makes sense. Thanks.
