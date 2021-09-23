Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB23C433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 00:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A7276109E
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 00:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhIWAz5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 20:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238631AbhIWAzw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 20:55:52 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83318C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 17:54:21 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ee50so16948580edb.13
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 17:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=uO4WZfYkURg+Jqy0QivIQAK/mfLL2vr62l+5J5nlQpA=;
        b=CV/LiQK1/H07MLGP4lXy5z1s1Y+xOHom7mUsWbiL1UvcQaoHQ5a1e98CTWXq75JxXd
         F2PCKYQR/EKy1cTEhDfjB/9JTtbjPhMVoKVEtsnuFGpBKXZMF54mS1XLg/RvuE0w65KN
         92bqnlH1FigCKiFXY0r8O4ZTJW1poBna0mBIDsYYgHgbW0D2wGKLQux+MzwoFIf3wf5O
         bNweUQmTSE95vQ/Vi5ILjD9VBI6L+j2ecHHWFde5lHybUOvnc6IqFc/+hLbV3cAJHpD2
         KaxgYU96+b6iW92cx+fR95EyqM8A/KEQlmcpSu3sdmdtWNaYqxgODWUdceYIuj2Pu8PS
         DVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=uO4WZfYkURg+Jqy0QivIQAK/mfLL2vr62l+5J5nlQpA=;
        b=De5NfD0x7OoTOiNejkBl3H1VAHoMjSH3IwtbyNGK8C0heRCc88pj4zMKOaihj5nKy6
         I4Pd9PKxXwrVeflTL4TDa+nGliJFmyHIpaL2mfkaCaraYKDDKigIzMG4kUZsO2u7lHpl
         Q32b0m45xlNdPOlo2jhOUqamX4Sp5jGTwIKZB3ueARu2g34iUUHsZ5tWrQU4jdXSzFKJ
         4Ol4Q/mtuy9k3/v6acdK/FOaTxoRBAA0w5bh2Gc7eXAFCVu3fcN1fzZkYKHcEMYUd2uN
         wCufDTFu+VKtqkbhXJXlZAXdTOQ/azkBpzfC13iOtAkXSbjimoCkf32rdtmd/kC5wIAS
         EX8w==
X-Gm-Message-State: AOAM530TX76BbmEYr77aOsQKVuIasJv9YOOIvdWj57zmGzS2TL0GDDZz
        EFRj2sTMIjJBCLGhRfgWNNc=
X-Google-Smtp-Source: ABdhPJzvEA1GVL7OHBPcbMXLxNLlrW8a7oSLqMXQwZXILp20IHUxzc17To8tverFloPqyrAGXI4a9Q==
X-Received: by 2002:a17:906:9b87:: with SMTP id dd7mr2315877ejc.99.1632358460033;
        Wed, 22 Sep 2021 17:54:20 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e3sm1834541ejr.118.2021.09.22.17.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 17:54:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH 1/5] grep: stop modifying buffer in strip_timestamp
Date:   Thu, 23 Sep 2021 02:53:15 +0200
References: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
 <YUlVsLkFGRfRqpKG@coredump.intra.peff.net>
 <CAPUEsphSyZB-vtubjYhN_5Gy3Zv0HQ=fH=+G8kMYzJyrOLXPxQ@mail.gmail.com>
 <CAPig+cQnC1LLPtuC0qVX7EQ_ki4pev6scRox3utA45XeLHfGig@mail.gmail.com>
 <YUlw6V7AL8l6mbSh@coredump.intra.peff.net>
 <YUl+w8Tn3jqfLqt2@carlos-mbp.lan>
 <7d791c04-d122-1eb9-a84c-939294817395@web.de>
 <YUnrI10DXLElenKZ@coredump.intra.peff.net>
 <87v92t8wlp.fsf@evledraar.gmail.com>
 <YUuQJUSl/jrnQR7n@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YUuQJUSl/jrnQR7n@coredump.intra.peff.net>
Message-ID: <87y27o5cxx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 22 2021, Jeff King wrote:

> On Tue, Sep 21, 2021 at 11:02:31PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>>=20
>> On Tue, Sep 21 2021, Jeff King wrote:
>>=20
>> > On Tue, Sep 21, 2021 at 09:37:23AM +0200, Ren=C3=A9 Scharfe wrote:
>> >
>> >> > @@ -965,9 +953,12 @@ static int match_one_pattern(struct grep_pat *=
p, char *bol, char *eol,
>> >> >  		bol +=3D len;
>> >> >  		switch (p->field) {
>> >> >  		case GREP_HEADER_AUTHOR:
>> >> > -		case GREP_HEADER_COMMITTER:
>> >> > -			strip_timestamp(bol, &eol);
>> >> > +		case GREP_HEADER_COMMITTER: {
>> >> > +			char *em =3D memrchr(bol, '>', eol - bol);
>> >> > +			if (em)
>> >> > +				eol =3D em + 1;
>> >>=20
>> >> The old code documents the intent via the function name.  The new one
>> >> goes into the nitty-gritty without further explanation, which I find
>> >> harder to read.
>> >
>> > Agreed. I do think the conversion is functionally correct, but it
>> > doesn't strike me as worth the change.
>>=20
>> As far as some general improvement in thish area it seems to me that
>> this whole subthread is losing the forest for the trees.
>
> I'd definitely agree with that. :)
>
>> It probably makes sense to split up that commit.c code into something
>> that can give you structured output, i.e. headers with types and
>> start/end points for interesting data, then in grep.c we won't need a
>> strip_anything(), or strrchr() or memrchr() or whatever.
>
> I don't disagree with any of this, either, but I think it's a separate
> (and much more complicated) topic than what this series is dealing with.
> So my preference would be to take this as an immediate improvement, and
> let anything like that get built on top.
>
>> It would also be a lot faster for grepping if we could offload more of
>> this work to the regex engine, particularly if we've got a more capable
>> engine like PCREv2.
>>=20
>> In many cases we're splitting lines ourselves, when we could have the
>> engine work in a multi-line mode, or translate the user's --author match
>> into something that can match the raw commit header. So have an implicit
>> /^author /m anchor if we're matching author headers, instead of having
>> grep.c string-twiddle that around one line at a time.
>
> Ditto here. Multi-line matching may make things a lot more efficient,
> but I think is out of scope for this series. That seems like an
> interesting area for future work.

Indeed, *way* outside this series. I'm I think the change you suggested
here makes sense for this change, just pointing out that for any
follow-up changes it's much more worthwhile to consider a few more
stackframes than just the 1-2 that involve those strings in that
particular form.
