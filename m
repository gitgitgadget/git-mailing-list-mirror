Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148BBC433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 12:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6FE561075
	for <git@archiver.kernel.org>; Tue,  4 May 2021 12:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhEDM1n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 08:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbhEDM1l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 08:27:41 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2846C061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 05:26:45 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id n25so10193104edr.5
        for <git@vger.kernel.org>; Tue, 04 May 2021 05:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=c9tEaDrTNMK4oq/tpYuzARvdYp+NyTtJRhVaTn7E4cU=;
        b=mU1jM+jmb+QzEaOxi6FTHdvhxLuIGKspmpWCxQ3ll1dE+IE9HWBh5t0Uw3rQZsJO0A
         FGA2mHd7/XKhH9TVr5wdvrGD3M6VHtFWK/MCe32+MbZT0y07svuQMG+pbiYU51akANOb
         E6RJeVXDLIG7+ZKEMnUEBNLfrn//Hnym4wvv59M3ecQYLQI46S+oJNhVocO6L++44KBf
         1N7619ewMRZupKf+DVkHx2NgkmvkeUckA57WdwEaczE2KCJUHmCMY0aq8FYRUeRu7Tue
         5FMIVdHz1hPXw5Kj3Dt+KO4yb0+7pKIzlg5kZl19iTvb8JRImFdieU8vnORWI8hp5UWo
         /Idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=c9tEaDrTNMK4oq/tpYuzARvdYp+NyTtJRhVaTn7E4cU=;
        b=DEs5enmdlE+LV73ydUBKiech0sQhOlI3Fn+kOs7kcEgMhOjYyNicAqcqpl412Wthce
         dhRp0bYFymKlTsTnRuSLtcCDHqydQflIk6VrtPcDsEoXB6mTjfzqG/SvmIdvvy3FHaH8
         L027NIbISuFOqXsdofE1lRc620o8+sQqQM6dZxB1xlGcZFI2y3kskZ8XcBq8nKUsDB1u
         wITusk6+dLEJjiuLFg9/L42ineO6dTIjnBRs9VGd719RVEtL5uIxqk8U2Losai+BDcf5
         EngvafjKngHiyVD/N6OqrVtTSCvM+1X+OWiEDF/qiaAS14Xvy0FEZxWkHl1iuDJz+xAv
         fvDA==
X-Gm-Message-State: AOAM531sU66+84yf2s++JkEPzbhHksImdXkb5y0Qpzr82CgmdQQTyWln
        nyLuDTpGaXi+1BoGvNz4mbvWShIaqhE=
X-Google-Smtp-Source: ABdhPJyRiF8V4FWxS0hP1OU4QogfQj2cptUQhRuUb4q51ScGxjYW3v0HAmj5wkOITutGxwN59LoHeA==
X-Received: by 2002:a05:6402:34c5:: with SMTP id w5mr4122371edc.237.1620131204277;
        Tue, 04 May 2021 05:26:44 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id v26sm1367445ejk.66.2021.05.04.05.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 05:26:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/9] fsck_tree(): fix shadowed variable
Date:   Tue, 04 May 2021 12:10:16 +0200
References: <YI12hK4X/gfl3u29@coredump.intra.peff.net>
 <YI12stO48egyiHjv@coredump.intra.peff.net>
 <87y2cwvz9e.fsf@evledraar.gmail.com>
 <YJBZYt8ivlTDHpRM@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YJBZYt8ivlTDHpRM@coredump.intra.peff.net>
Message-ID: <87fsz2wupo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 03 2021, Jeff King wrote:

> On Mon, May 03, 2021 at 01:15:03PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > Commit b2f2039c2b (fsck: accept an oid instead of a "struct tree" for
>> > fsck_tree(), 2019-10-18) introduced a new "oid" parameter to
>> > fsck_tree(), and we pass it to the report() function when we find
>> [...]
>>=20
>> Have you considered just passing down the "obj" instead of the "oid"?
>> It's a bit of a bigger change, but seems to be worth it in this case as
>> the below diff (on top of master) shows. We spend quite a bit of effort
>> peeling an "obj" just to pass oid/type further down the stack.
>
> That would be undoing the point of the referenced commit above. More
> discussion in this thread:
>
>   https://lore.kernel.org/git/20191018044103.GA17625@sigill.intra.peff.ne=
t/
>
> but the gist is:
>
>   - there were bugs caused by looking at the object structs; not having
>     it make sure we can't introduce similar bugs
>
>   - using oids and buffers makes it possible for code to avoid having
>     object structs at all. index-pack could take advantage of this (to
>     reduce memory usage), but nobody has yet written that patch.

Ah, I'd managed to read this series + done some previous fsck hacking
without noticing that recent-ish change.

FWIW I'd been meaning to slowly mutate some of the fsck code somewhat in
the opposite direction. I.e. we have N object parsers now between
{blob,commit,tree,tag,fsck,tree-walk}.c and elsewhere. Ideally we could
share all/most of the logic and piggy-back in fsck on the "main" parser
in some more exhaustive mode.

Unfortunately most of our fsck tests are rather non-exhaustive, so I see
e.g. in reverting some of that on our current test suite e.g. a test in
directory.t6102-rev-list-unexpected-objects was changed from:

    error in commit 536c6159e861ef1ac7967a68324a8e7614632970: missingParent=
: parent objects missing

To:

    error in commit 536c6159e861ef1ac7967a68324a8e7614632970: broken links

So by using the "main" parser in this case we lost the ability to
selectively ignore that error, looks like nobody cared (and the OID
could still be added to the skiplist).

Another thing that got worse (but we arguably never supported well) is
fsck_commit() and expecting to validate at least a single commit
object. Before we'd notice missing parents AFAICT, after we don't at
that entry point, but will of course if entering via fsck_walk().

I don't think any current caller cares, but when I rewrote
builtin/mktag.c recently there was a suggestion to do that "fsck the new
object" for the low-level commit/tree/blob APIs too. Before (and again,
AFACT) that would work to a level of 1, after you'll need to instrument
some limited walk.

Anyway. This inspired me to try re-arranging the "struct object" to be a
superset of "struct object_id", i.e. to make it start with the oid
instead of "parsed" etc. It means you can do this:

	static inline struct object_id *object_to_oid(const struct object *obj)
	{
	        return (struct object_id *)obj;
	}

And change common cases like oid_to_hex(&obj->oid) to
oid_to_hex(object_to_oid(obj)), i.e. a wrapper for a pure cast. Just
that seems to speed up fsck by 1-3%, but I'm not 100% certain yet. The
cachegrind numbers look unambiguously better. This is with gcc and -O3.

More generally we have various other structures that wrap an "oid" in
one way or the other, where the common access pattern is just grabbing
the OID out of it, but it's not the first entry. E.g. "name_entry",
"directory" etc. By re-arranging it like that we could also have a
"object_id_type" which is a 2-member touple of "oid/type", so by having
that "oid/type" first in "struct object" you can cast "struct object" to
"struct object_id_type" for fsck.c use, and further cast a "struct
object_id_type" to "struct object_id" for anything that needs that.

Anyway, right now I don't have anything conclusive. Just thought I'd
poke you/others with the above in case it's an appraoch that's been
tried/considered before.
