Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A74C433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 17:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADF75611C3
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 17:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhIJRU0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 13:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhIJRUI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 13:20:08 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE12C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 10:18:56 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ho42so5636809ejc.9
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 10:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=r0X19CcWLbA/+BpqsYpnBV671DAJ3DfCeHrpRD/CwFE=;
        b=QncoqfteyX6XZk7BIVJEZMyBgeqZo14PYPLoB5uF2pbgDU3ea1+Jxo4yEQeGKJFtlr
         vBMW2wkedZXLdCE5O7HP+2d5MiFEnr6YoE7x+5OALOV+9oBNFh6pfhSlaZx5Jp66CBqv
         F/lKWW15iFH8YveI3f1Y8bPzUMZ6fyeM5h4r18J1sPxRQ8A7qt5elJYYM5cHkFzEsgH8
         75VXcu1rufoBXVRno06giTAtaIBGWs0iUlwhOGMKrCDb/jrxPew2Xwz6/rNDAEl4lXvk
         w4/qxaDb8mGWivSx++utI/fwlKysDRKX9cogClLQ2nFyCHvSXQ5MPSnxlb8RPZ9QjHmN
         Tokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=r0X19CcWLbA/+BpqsYpnBV671DAJ3DfCeHrpRD/CwFE=;
        b=UCCFsugMg7cwkCV8wM/CrsH5IoipeWfwrMXTQ6NqqQuHawqqK+U7KXaqXSi5+fwYSW
         mOCs2uL3ChU7pHC0NGRCy58F1Rs6EGVxjgMR3R0/KAvHWn0QroxvsSQ+4iTMEprd9HnT
         Mc//j/MY2WDRTOgSanrxxVeYibU9li0/fio3trdRN6Bu+IyM0UCDNaip4WdxGN2lOIoc
         VB7VJX6RVKX+o9PaKmtW9Val1A6PSxwx+985gajQSqZOHJJux8d/2NPH12ejuKm5cRa3
         ipo/K1eW+i7KhLkuT1skBNuBC5IZpfz+jbXjODpMyBqm7aMkkJil0oWgzZqqVylzxKUE
         dC2g==
X-Gm-Message-State: AOAM531Q5Drxo0C8SvYqQeEbL0M7Lr0cs1EMiFLQJeyhGrysGJyRoCSD
        7Fa2NcGw67vWdDM2XsL3MSY=
X-Google-Smtp-Source: ABdhPJxEy3bPnbXbU/hSGAdFcLRpnY5VIR61sgBEM7VvR3RFXpOiEK03/VddMWQXukt0f41UO9vWQg==
X-Received: by 2002:a17:906:7802:: with SMTP id u2mr10548083ejm.325.1631294335389;
        Fri, 10 Sep 2021 10:18:55 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m10sm2356830ejx.76.2021.09.10.10.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 10:18:54 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Gwyneth Morgan <gwymor@tilde.club>
Cc:     Fangyi Zhou <me@fangyi.io>, git@vger.kernel.org,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Birger Skogeng Pedersen <birgersp@gmail.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        CB Bailey <cbailey32@bloomberg.net>,
        Christopher =?utf-8?Q?D=C3=ADaz?= Riveros 
        <christopher.diaz.riv@gmail.com>,
        Christopher =?utf-8?Q?D=C3=ADaz?= Riveros <chrisadr@gentoo.org>,
        Ed Maste <emaste@freebsd.org>,
        =?utf-8?Q?Jean-No?= =?utf-8?Q?=C3=ABl?= Avila 
        <jn.avila@free.fr>, Jean-Noel Avila <jean-noel.avila@scantech.fr>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Kazuhiro Kato <kato-k@ksysllc.co.jp>,
        Kazuhiro Kato <kazuhiro.kato@hotmail.co.jp>,
        Kevin Willford <Kevin.Willford@microsoft.com>,
        Kevin Willford <kewillf@microsoft.com>,
        Peter Kaestle <peter@piie.net>,
        Peter Kaestle <peter.kaestle@nokia.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Sibi Siddharthan <sibisiv.siddharthan@gmail.com>,
        Slavica =?utf-8?B?xJB1a2nEhw==?= <slawica92@hotmail.com>,
        Slavica Djukic <slavicadj.ip2018@gmail.com>
Subject: Oddidies in the .mailmap parser & future syntax extensions
Date:   Fri, 10 Sep 2021 18:48:26 +0200
References: <20210910130236.40101-1-me@fangyi.io> <YTt4RymWg+TOEmUf@tilde.club>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YTt4RymWg+TOEmUf@tilde.club>
Message-ID: <877dfocps2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


[Changed subject]

On Fri, Sep 10 2021, Gwyneth Morgan wrote:

> On 2021-09-10 14:02:36+0100, Fangyi Zhou wrote:
>> Similar to a35b13fce0 (Update .mailmap, 2018-11-09).
>> 
>> This patch makes the output of `git shortlog -nse v2.10.0..master`
>> duplicate-free by taking/guessing the current and preferred
>> addresses for authors that appear with more than one address.
>
> The line for Jessica Clarke should probably just be
>
> Jessica Clarke <jrtc27@jrtc27.com>
>
> That works the same and doesn't put a reference to an old name.

It does work exactly the same!

More specifically this is an unintentional bug/misfeature/looseness in
the .mailmap parser, an entry like:

    Foo <foo@example.com> Bar

Is exactly equivalent to:

    Foo <foo@example.com>

I.e. we simply ignore the " Bar" part. The reason for this is that we're
internally treating nonsense input as if the line simply ended there.

Even having documented and tested some of this recently in 05b5ff219c2
(mailmap doc + tests: add better examples & test them, 2021-01-12) I
found this a bit surprising. I probably found out at the time, but
forgot and had to go source spelunking again.

I'd expect:

    Foo <foo@example.com> Bar

To be an alias/shorthand for:

    Foo <foo@example.com> Bar <foo@example.com>

Which is something that might be applicable / useful in some
cases.

E.g. a name might change over time from "Foo", to "Bar", to "Zar", but
just because we're at "Bar" and want to map "Foo" to "Bar", that might
not mean that we'd like to map any future name at the same address
(i.e. the future "Zar") to the same "Foo".

In practice I suspect that's more commonly what people do want to do,
maybe we should warn about it, I did mean to hook some pedantic mode of
the parser at some point up to git-fsck.

More annoying is that this:

    New <foo@example.com> <bar@example.com>
    <foo@example.com> <zar@example.com>

Doesn't mean the same as:

    New <foo@example.com> <bar@example.com>
    New <foo@example.com> <zar@example.com>

I.e. I'd expect the name to map to the empty string, *unless* we saw an
earlier address, i.e. just as we do for the first bar -> foo line (we
map it to a name of "New", we don't map it to an empty name).

So that's some #leftoverbits, perhaps someone somewhere relies on that,
but it seems like an obvious shorthand to have. I can't imagine it being
useful to map to empty names, and much of e.g. git.git's mailmap is
repeated entries with the same name over and over again.

I suppose we could also extend it to new syntax such as:

    New <foo@example.com> <bar@example.com> <zar@example.com>

Doing that would be strictly backwards compatible, i.e. now we'll
entirely ignore the 3rd E-Mail address. It does mean we also
accidentally support things like:

    New <foo@example.com> <bar@example.com> # A comment, because we ignore everything after the 2nd address

But don't tell anyone I told you that :) But that is something that
might technically have inadvertently closed the door to future syntax
extensions, but we could probably do them anyway, or at worst have some
heuristic.

Another useful thing might be to support:

    New <> Old <>

As an explicit mapping of the name "Old" wherever we see it to "New", or:

    New <> Old <>

To change just the name "Old" to "New" everywhere, without considering
the E-Mail address. Both of those are probably too crazy to be useful,
especially since if we supported that we'd logically also support:

    New <> <>

To assign all the commits to the name "New", but retain the address.
