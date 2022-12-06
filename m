Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC030C4708C
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 02:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbiLFCer (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 21:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbiLFCen (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 21:34:43 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C7B1E719
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 18:34:40 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id v8so18435827edi.3
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 18:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mnTBg7Fr5eD/i8jc2V1oYNN5oATXLT8+j0yia00TMQ8=;
        b=jxe6RdjvKD2b7p2dXcLZscX1HHdSOSoCnA0KS5fPYs60A27tC82PN1vc/LtnXBg2Un
         yXha9VCPi48/Nu12lzG3LSUDtpfnmzgf2r8dV9l672nOO9A6Y1e0YGXYBi30e3tW3n0q
         0Pqs3zqjop2BGc1GQKvqXTpwKxL2xrwDEKhaZlbQJS/LpG2ogeqBp6LvwYi06OGosWVA
         udj6fBxP4rnFfi15VKtip1lKtYv2/cKe+/yPXVnYVVZjF3zL/wG2kSdBRQ2NWB/mx1Ww
         PxcsdRDLbrdQNSqZqdouCNL/JBzgZ5e83sxzIcMyRd9nDWrLthJJ17rq2sdyocoQL6Er
         RPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mnTBg7Fr5eD/i8jc2V1oYNN5oATXLT8+j0yia00TMQ8=;
        b=QBC4ypufWR14h6Yyuo6nXYB7BB5/pOLJJnmzqWox0+gxU+UMV722M/7VNIdCF1E006
         oIZl1urTil+cmYB0gogzB0Bn6sCcxtYwMF0rwswggedosaJvNZSoO2tHGGBHYgBkwTa3
         83E+VaTTyJ18XQ3ZlYXcxKJygc7FS7YSmLEFZbn2YxtqhkWh06qaTCyD8SuXSP394yWY
         WVzfvSLX4huID9sQ5ssV6gDO/IPRZLC2jzAqLSDUECrKzJAmv184ruMDD7TxDqdkwnPr
         4hSxbdhYNJ/ic8I99Da2TPe2xLKL0nnVSVnlBgVw+HMgxB6yHBD7sgvlNMRlAz3IXlQk
         bVNA==
X-Gm-Message-State: ANoB5pkZwUoXAgqdEK9oEMk1MS1mmKKUmLw69Zda+iOj0KSxJsZaKl2y
        /CIHebcxOapEYfAxB7ZAuPs=
X-Google-Smtp-Source: AA0mqf6PQe6gl+DW22C1elGg9CE1rAGSBWIZtLfWOK1F7QiOnqb9PMiwG/u1xKRk8qFGphH71ELffA==
X-Received: by 2002:a50:e603:0:b0:46c:ff45:68e9 with SMTP id y3-20020a50e603000000b0046cff4568e9mr2252002edm.90.1670294078885;
        Mon, 05 Dec 2022 18:34:38 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id h23-20020a1709060f5700b007bfacaea851sm6788354ejj.88.2022.12.05.18.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 18:34:38 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p2Nn3-003Qn6-2i;
        Tue, 06 Dec 2022 03:34:37 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, phillip.wood@dunelm.org.uk,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] test-lib.sh: discover "git" in subdirs of
 "contrib/buildsystems/out"
Date:   Tue, 06 Dec 2022 03:19:57 +0100
References: <663b93ef-0c89-a5f6-1069-b4be97915d20@dunelm.org.uk>
        <patch-1.1-f27d8bd4491-20221201T162451Z-avarab@gmail.com>
        <xmqq5yeuspam.fsf@gitster.g>
        <87f22a55-ee84-2f76-7b9b-924a97f44f89@dunelm.org.uk>
        <221202.86sfhxg2ng.gmgdl@evledraar.gmail.com>
        <Y4qF3iHW2s+I0yNe@coredump.intra.peff.net>
        <221203.86pmd1dyqn.gmgdl@evledraar.gmail.com>
        <Y45/8WnuUnP9gOMo@nand.local>
        <Y46clyoKk9KzFiqj@coredump.intra.peff.net>
        <221206.86zgc1cnc3.gmgdl@evledraar.gmail.com>
        <Y46jT0i/7DhxHzfS@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y46jT0i/7DhxHzfS@coredump.intra.peff.net>
Message-ID: <221206.86mt81claa.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 05 2022, Jeff King wrote:

> On Tue, Dec 06, 2022 at 02:43:17AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > I don't mind having it in-tree if I can ignore it (assuming the project
>> > attitude is the "it's a side thing" from above). It's the CI failures
>> > that make it hard to ignore.
>>=20
>> ...but on this thread-at-large, I'd much rather see us focus on just
>> reviewing the patches I have here than raising the burden of proof to
>> whether we should get rid of it entirely.
>
> Fair. In case it is not obvious, I have no interest in reviewing cmake
> patches. ;) But I will at least stop making noise in the thread.

I'm fine with the running commentary on the future direction, I think
it's also very useful.

I just wanted to also note the need to keep the eyes on the ball a bit
:)

>> If we make the CI failures "soft" failures or move it out-of-tree
>> entirely it would still be useful to be able to run the cmake recipe on
>> *nix.
>
> Agreed.

Just to add my own digression: I asked in some past thread (which I'm
too lazy to dig up) why it was the cmake file couldn't just dispatch to
"make" for most things.

I.e. it needs to at some level be aware of what it's building for the
IDE integration, but for say making a "grep.o" there's no reason it
couldn't be running:

	make grep.o

Instead of:

        cc <args> -o grep grep.c [...]

which requires duplicating much of the Makefile logic (possibly with
some Makefile shim to not consider any dependencies in that case).

Even if we couldn't do that for *.c code for some reason it could do it
e.g. creating the generated *.h files, which is logic we currentnly
duplicate.

The "win+VS build" job even has a hard dependency on GNU make currently,
in needing to run "make artifacts-tar" to get to the "win+VS test"
stage.

But apparently the reason for *that* is that another goal of the
integration was to avoid having to have GNU make installed at all, which
comes in a different package than the one that would ship VS+cmake (or
something?).

Which might be something to re-visit, i.e. maybe we could eventually say
"yes, you can have VS+cmake, but it's not too much to ask that you
install GNU make as a one-off".

Doing that would then reduce the duplication to the point where the
cmake recipe would be a thin shim around the Makefile.

I don't use this development setup, but if the CI job is managing to
download and run GNU make it can't be that hard for an end-user to
similarly install it (but what do I know?).
