Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F13C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 21:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 197E461242
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 21:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbhIUVKn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 17:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbhIUVKi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 17:10:38 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E591C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 14:09:09 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id dj4so1489410edb.5
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 14:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=aPFC5qBCRbMMbaqthcLYpR2Vvy5j2SElDVkRtXLlvYA=;
        b=fMG17lToVsCLxiRK7aOdJ3x1eJ9zF06QmgRgb+vCQozq2PyYiSHxL1QaHvwEpO2mTH
         srY+jncRslyBqQJ9jrun/H8RGSNJPWE5Wkq3ysodQj3/PVA6EShx0pm6SBVOGM81Mwfi
         yNXX/Yu6dkmWeE0oRLlspVcxjb9/rzQ/Cum9jaE9tZ6ajlxnF2soSJscREb8PV6gMLiP
         +my2WjDpNjzUXGdyftdoRT0MYfuh9ZYBjkB6q8nDf2CU/LroJ4biAa6XWeZCbBgM8oaZ
         cGS+4c/+8NHhWfFlL177Tg3SL0zH+p/Ftnk+coYZuidzLKWgU7ig0ZeSi2j0LVKcS4kv
         lBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=aPFC5qBCRbMMbaqthcLYpR2Vvy5j2SElDVkRtXLlvYA=;
        b=ovjls8+MpKgImgOgUahlxD+fQf0mjGMBePEujPbVUbQnrQG8OEWy4hT1Eu1t0ePvVl
         H1dD6r4Ti0UfQxu/8jvcHZ1oQZn6ZOrtMT+lk4RuAeTl2TlThEevRQ69ze16XBkQo2uA
         yjAtwYXTDThk14UYVDcdPdaiiozn24U/l7ksdqqjcxHYqSU5ORmHO7TTzgwpWhlhEK23
         kjJoY6Uu+5yYViq6WQdyXM5xFLcO2UWuFxB5G3//gsZ85/rf4Caoj6yU90pN0uavhN3b
         iBEXqIVAacc9apMbcsveNr6ZYE844GgydiWa1fmwF5I4FSAjZJP7IyegsA5Ehged6BFP
         MbMw==
X-Gm-Message-State: AOAM531aJ2/SqMmATaVcOC+KfHjCqLR4k/XBbb91KwY317LX4Mdt5a83
        fAgPoi8ucLwpM76R10kfb4I=
X-Google-Smtp-Source: ABdhPJybqjhMxLa+g0yC63Gh1JPoeYCXRc4mGuFufVrdQoCoLsrEFGwdjZm22hqa+nxpwHXntHYIfQ==
X-Received: by 2002:a05:6402:42d5:: with SMTP id i21mr37809486edc.14.1632258547769;
        Tue, 21 Sep 2021 14:09:07 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k16sm44409edr.33.2021.09.21.14.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 14:09:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH 1/5] grep: stop modifying buffer in strip_timestamp
Date:   Tue, 21 Sep 2021 23:02:31 +0200
References: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
 <YUlVsLkFGRfRqpKG@coredump.intra.peff.net>
 <CAPUEsphSyZB-vtubjYhN_5Gy3Zv0HQ=fH=+G8kMYzJyrOLXPxQ@mail.gmail.com>
 <CAPig+cQnC1LLPtuC0qVX7EQ_ki4pev6scRox3utA45XeLHfGig@mail.gmail.com>
 <YUlw6V7AL8l6mbSh@coredump.intra.peff.net>
 <YUl+w8Tn3jqfLqt2@carlos-mbp.lan>
 <7d791c04-d122-1eb9-a84c-939294817395@web.de>
 <YUnrI10DXLElenKZ@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YUnrI10DXLElenKZ@coredump.intra.peff.net>
Message-ID: <87v92t8wlp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 21 2021, Jeff King wrote:

> On Tue, Sep 21, 2021 at 09:37:23AM +0200, Ren=C3=A9 Scharfe wrote:
>
>> > @@ -965,9 +953,12 @@ static int match_one_pattern(struct grep_pat *p, =
char *bol, char *eol,
>> >  		bol +=3D len;
>> >  		switch (p->field) {
>> >  		case GREP_HEADER_AUTHOR:
>> > -		case GREP_HEADER_COMMITTER:
>> > -			strip_timestamp(bol, &eol);
>> > +		case GREP_HEADER_COMMITTER: {
>> > +			char *em =3D memrchr(bol, '>', eol - bol);
>> > +			if (em)
>> > +				eol =3D em + 1;
>>=20
>> The old code documents the intent via the function name.  The new one
>> goes into the nitty-gritty without further explanation, which I find
>> harder to read.
>
> Agreed. I do think the conversion is functionally correct, but it
> doesn't strike me as worth the change.

As far as some general improvement in thish area it seems to me that
this whole subthread is losing the forest for the trees.

We're operating a buffer that has "\n"'s in it, and then we loop and
split it up one line at a time, often just to match author OR
committer.

We then have things like commit_rewrite_person() in revision.c that's
preparing a "fake" commit just for grep.c's use, just for it to strip
those headers down again.

A real improvement in this area IMO would be trying to bridge the gap
between parse_commit_buffer() and grep.c's match_one_pattern().

I.e. we've even parsed this once before in commit.c's
parse_commit_date() by the time it gets to grep.c, now we're just doing
it again.

It probably makes sense to split up that commit.c code into something
that can give you structured output, i.e. headers with types and
start/end points for interesting data, then in grep.c we won't need a
strip_anything(), or strrchr() or memrchr() or whatever.

It would also be a lot faster for grepping if we could offload more of
this work to the regex engine, particularly if we've got a more capable
engine like PCREv2.

In many cases we're splitting lines ourselves, when we could have the
engine work in a multi-line mode, or translate the user's --author match
into something that can match the raw commit header. So have an implicit
/^author /m anchor if we're matching author headers, instead of having
grep.c string-twiddle that around one line at a time.

Just my 0.02.
