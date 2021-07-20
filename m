Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4B3C07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 21:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1C0C60720
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 21:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbhGTUnk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 16:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbhGTUlD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 16:41:03 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765C1C061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 14:21:36 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id dt7so30065ejc.12
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 14:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=PkuMlknHA+976O6737JLZ/mvKKi6xCzQj3PDMJ5m/GA=;
        b=F1BFDTzCjjnpnQtSdtcGSIFOTEbsmTzll7xc3agrKgEnNxgm1UuvtXj1VJzSFCyt1o
         Bi+RAuP6b2jNMMQ7IY7v9VrKyvZrIqyXa0ylEkm8QbdG8iXnDSbgKrYViQQev40hfEC8
         8eiraCjxBz+ef1eHTSAwcubvwIgNhWmKfD05GShBB9xQW7woax6qsCmKSfrZu45M8RAv
         teMr786r/eVaauXNZlJtGbuOiq8eBbINsH6DbYyxs7lFNY2QWwhLpu5OWGLeUZXY6qZT
         tUZW/2RuaZ4ue3S8HTGyMVKHTEzTpydbP5Lppit6QZ7V1K8+HM6FwU7gYVz0lI48xJ9f
         oalQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=PkuMlknHA+976O6737JLZ/mvKKi6xCzQj3PDMJ5m/GA=;
        b=mxeIIFtrn4G0t6xWPU3nBlOM6aElh9c3dlwN1xuTQFOi6Pyv1U3A/PZmZaHSn1rmIE
         0lf7AyYV8f3aFYCXHlqk+IkEd2Y7lt5wusUNoGcx1N/n0QZ77lxmQNxaZ5dtLgmD/oX3
         QYi+GQPZW+zj+xNLGOn/gTlYx6vTKa8VOTZYzNoVtIs6OwYVFDVR6X4fJKqpd61W+asV
         Y0gpuQfpa/xhqHtm29MtOj+PMUdc2+ESjkseaymk6NITjplOTEdDLB9uKPm7n8b6muin
         KGzqlLtJAWmXVCndlS4xIJyUSThy5dYltrwiDPKL5nTSOzLFr5F8kmNE7aryH/K2YYrk
         vrow==
X-Gm-Message-State: AOAM533IP5CrtiXSS3bqU1YiH5WgDNDd2SY6xrHr4jp8yuzm94+O25hG
        RwMli8jsoi2pQI4bFeVqt9I=
X-Google-Smtp-Source: ABdhPJwg/HZW/nMGbxHmeFrgvTNuj+8p5Kdk3Dn2wixr+XZcmnAYJCA5ZL8Ug1UXXS0rQrBtmgI2LQ==
X-Received: by 2002:a17:907:7808:: with SMTP id la8mr35151146ejc.13.1626816094968;
        Tue, 20 Jul 2021 14:21:34 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id w24sm9827055edv.59.2021.07.20.14.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 14:21:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v3 6/6] commit-graph: show usage on "commit-graph
 [write|verify] garbage"
Date:   Tue, 20 Jul 2021 23:17:13 +0200
References: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com>
 <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com>
 <patch-6.6-5c1694e071e-20210720T113707Z-avarab@gmail.com>
 <20210720174739.GA2025@szeder.dev> <20210720175530.GA23408@szeder.dev>
 <YPcU3LSpa/r5nFCP@nand.local>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YPcU3LSpa/r5nFCP@nand.local>
Message-ID: <87lf60vfyn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 20 2021, Taylor Blau wrote:

> On Tue, Jul 20, 2021 at 07:55:30PM +0200, SZEDER G=C3=A1bor wrote:
>> On Tue, Jul 20, 2021 at 07:47:39PM +0200, SZEDER G=C3=A1bor wrote:
>> > On Tue, Jul 20, 2021 at 01:39:45PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> > > Change the parse_options() invocation in the commit-graph code to ma=
ke
>> > > sense. We're calling it twice, once for common options parsing, and
>> > > then for the sub-commands.
>> > >
>> > > But we never checked if we had something leftover in argc in "write"
>> > > or "verify", as a result we'd silently accept garbage in these
>> > > subcommands. Let's not do that.
>> > >
>> > > Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.=
com>
>> > > ---
>> > >  builtin/commit-graph.c  | 10 ++++++++--
>> > >  t/t5318-commit-graph.sh |  5 +++++
>> > >  2 files changed, 13 insertions(+), 2 deletions(-)
>> > >
>> > > diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
>> > > index bf34aa43f22..88cbcb5a64f 100644
>> > > --- a/builtin/commit-graph.c
>> > > +++ b/builtin/commit-graph.c
>> > > @@ -104,7 +104,10 @@ static int graph_verify(int argc, const char **=
argv)
>> > >  	opts.progress =3D isatty(2);
>> > >  	argc =3D parse_options(argc, argv, NULL,
>> > >  			     options,
>> > > -			     builtin_commit_graph_verify_usage, 0);
>> > > +			     builtin_commit_graph_verify_usage,
>> > > +			     PARSE_OPT_KEEP_UNKNOWN);
>> > > +	if (argc)
>> > > +		usage_with_options(builtin_commit_graph_verify_usage, options);
>> >
>> > Checking 'argc' alone is sufficient to catch unsupported parameters.
>> >
>> > Using PARSE_OPT_KEEP_UNKNOWN is not only unnecessary, but arguably
>> > wrong here
>>
>> And it's wrong in 'multi-pack-index' and 'env--helper' as well.
>
> Thanks for spotting. Obviously this one is new, but the one in the midx
> builtin is my fault; I'm not sure why it's there, because it's clearly
> wrong.
>
> So we should definitely fix this instance via a reroll of this series,
> but that still leaves the others up for grabs. =C3=86var, are those (the =
ones
> in the 'multi-pack-index' and 'env--helper' builtins) something that you
> want to clean up while you're working in this area, or would you rather
> that I take care of it?
>
> I don't mind either way, just want to make sure that we don't duplicate
> effort.

I'm all for you picking it up :)

If you wanted to pick up these patches (or some of them) and
partially/entirely replace this series I'd be happy with that too,
i.e. if it makes conflicts etc. easier.

I just re-submitted this now because it's been staring at me in my
"should re-roll at somep point" list for a while...

FWIW if you're poking at this area more generally we really could do
with some standardization around these built-in sub-commands:


    git built-in --here subcommand=20
    git built-in subcommand --or-here

Various commands support one or the other as some confusing amalgamation
of either taking options to "built-in" and/or "subcommand". The sane
thing to do is:

    git --git-options built-in --built-in-options subcommand --just-for-the=
-subcommand

But not everything does that, and some things that should be
--git-options or --built-in-options we take as subcommand options,
e.g. --object-format or whatever.

