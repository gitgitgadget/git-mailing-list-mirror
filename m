Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A8CC433F5
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 04:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC7CF60EE9
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 04:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbhKFElc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 00:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhKFElc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 00:41:32 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B07C061570
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 21:38:51 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id c8so23185482ede.13
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 21:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=r6VUbF1ae8rk25q1Eoz/hnzBEUBfKPpJIBRoN7LmKT0=;
        b=qDHyIDVIQsfrQ0maxLfvwjd5fEgEgoBZztrgK2mkMWSw9iTVX5zLHOcWTBtU8/fg4S
         C+ZndeBo4Vmd/MZ7ORE3BMAeTU/N6//pp1zKKYMgGKyJtvdgeVQgqZGWnbvM3S+zWl4c
         oD03cUgxZP0Oe2fjkadkV9I5csdeYUmJhKKwPctOO3tNNIzwTGRcrqaX9cNFS3wfYmOx
         l6mKvc3eXCbOk8LfdBiiY7GG5L4BdfMKT46C118uVbAGS6QehPhJ2+V5Lyl5tTa1PX8L
         /+LnBpsdVxFiap06XF+hyDvhkvihhmPIzMKINMlhq7rSjQZfcv1WIj5Uh97qIOQTgQk5
         R+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=r6VUbF1ae8rk25q1Eoz/hnzBEUBfKPpJIBRoN7LmKT0=;
        b=HE74rzxvd//6yj3dQU/SYBEoPK+i2v7GZTzL4tA1qK1Bxi+k2KtnfiYwQG/Q0ybUsX
         Kg/xwo5hVhKrCI4kvTIwyU0b2jHzlIsoHQvrC5XGHFv0BDocCgtWvpnWmj6NaAJB+Tvb
         oF5T0VRfTDVW4ny6w3WzF5ul4KvpMc5uWWwq96T89LoKX3OGlQv67SiV8CDbKJRLPHt1
         7tqn/6UpssyaoldmoZuueI+RmmC+BlgFXYteIp8qzbvRJYGLvIAu9reINXgGscRpXmPu
         Fn9zV04/Y74EV2bv4O1FOCvn6lZeD5hYqzbGXVv3pwhDlq41hsMbyjOgTkmm3c43JQQZ
         EriA==
X-Gm-Message-State: AOAM532WlbCJBlBKJWW1+9fIF/f6p9Z5JPvWLlLwtXLr9nAfP3Rulc+H
        ep6hfaTwUlH2WoZV6t95EjSAEeaD3m3VdQ==
X-Google-Smtp-Source: ABdhPJztfTqzeCOD0y0hI954lhysRncxNPeTQ7XGEI6Kgo0KIOoDthK3ekhQr37ClKUzTyisc1h2RQ==
X-Received: by 2002:a17:907:62a5:: with SMTP id nd37mr79510349ejc.114.1636173530097;
        Fri, 05 Nov 2021 21:38:50 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 25sm5505530edw.19.2021.11.05.21.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 21:38:49 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mjDTc-000Zpm-S4;
        Sat, 06 Nov 2021 05:38:48 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 01/10] command-list.txt: sort with "LC_ALL=C sort"
Date:   Sat, 06 Nov 2021 05:26:04 +0100
References: <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
 <cover-v3-00.10-00000000000-20211105T135058Z-avarab@gmail.com>
 <patch-v3-01.10-c385e84c04c-20211105T135058Z-avarab@gmail.com>
 <xmqqbl2yw7b6.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <xmqqbl2yw7b6.fsf@gitster.g>
Message-ID: <211106.867ddlhp9j.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 05 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> In a subsequent commit I'll change generate-cmdlist.sh to use C sort
>> order, and without this change we'd be led to believe that that change
>> caused a meaningful change in the output,
>
> What I found misleading in this sentence (which hasn't changed after
> I pointed it out in the previous iterations) is that[...]

I tried to clarify what you raised in the previous iteration with the
new paragraph after the one you're quoting. I.e.:

    Note that this refers to the sort order of the lines in
    command-list.txt, a subsequent commit will also change how we treat
    the sort order of the "category" fields, but that's unrelated to this
    change.

> command-list.txt is an input file, and if the sort order used in the
> script that reads this to produce some other file as its output
> changes, nobody will be "led to believe" anything.  Not unless/until
> which output file to look at and compare between revisions.

I'd read your comment on the previous iteration as you being unclear on
whether we were changing the sort order of lines in the file, or the
category fields found within those lines.

We don't sort the lines, and never have, just the fields, and within
this series we stop doing that sorting (as it ends up in an OR'd
bitfield, so it doesn't matter).

> Is this talking about the order of entries in command-list.h file?
>
> Also, if the script sorts the input, whether it is in C locale or
> other locale, it would not matter how the input originally is
> sorted, as the input does not have duplicated entries to make sort
> stability matter, no?

This change is just to make this consistent for human editors. I think
we re-sort this wherever we display this in git, whether that's via
help.c or the completion powered by git.c.
