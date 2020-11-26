Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85840C56202
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 12:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2662E20DD4
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 12:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCVm8MGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389601AbgKZMnP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 07:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388830AbgKZMnP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 07:43:15 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF9EC0613D4
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 04:43:14 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id lt17so2763165ejb.3
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 04:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=t5cZqBlC9kk5vlJtcJHss/o/LFKaB22LSzuxYwmd9gk=;
        b=NCVm8MGkMfKeIcc0NMlMG3Y4dNlwaw9I8GZgqgn9sxd47YtSXXDx1DF3Yu8RZ7vlGY
         ObAv5inp5L3m/q4/OfUm2giEmUIdJUSgR/Nnhq7N2+9eGwJKqRGYtNKwJ3hLjcgcHFUC
         P+lKlnZxnDX8QOXwioevXYx5PZB0POlsycz81/iRl7WZ1gecO8ava3Y0JIQVywLbZZzt
         2TketgFHR1aUheOQHolQFQZ/PBKgF7Jrnq2T5/azJBD7XB0w07YY8eMO/jxNEPqJs0B7
         6lrTLD5P3aWii4eWiQ0X0pclZjjN6EgFiWInoI/TJxnp1jhTiQAA3wvKoJzHajIMqaCo
         +W5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=t5cZqBlC9kk5vlJtcJHss/o/LFKaB22LSzuxYwmd9gk=;
        b=E7ME09z3+EA/fR109EUuRRzBJUtVgmAvQ9CSMqLRAeFq3TPsEydHSF+mqAkK5mJgCi
         rNdhIWvVGVbjDu8HEX7cO3HQ+vhQfJRLh/DqA3hDv4MZrGUkoFKVRa2yUgZz+CnsuN2u
         6ptDE85ofu5bTqnkCdscuhVNOIVygYnVvwB6QBX8RShfpueexfuJoKmKXTOIDavCkZws
         qpwWvdsPsowPWuOpi6lY1udkMZUruLJBZNYrvI69IesmjCC8/zfhQ3yWB5e69MJ0H9tD
         AEg6eekG0ixJ4Ou0js2UvH0VZMxSuIDNx7PH1kS2Bvxx2C8bq1ZJaG/rhYSbQDA2bUBJ
         6hYw==
X-Gm-Message-State: AOAM5334sqRRVPn/0MP+0I91QsRXCj8XSS9JZvecEe7LEQsLG7eovnbS
        e6lMfSsx5LCxcULjmRURWsk=
X-Google-Smtp-Source: ABdhPJyOQCM7GbkRhq5NrwoZpsRBD6yQ4Q9XlBbgOSdTPjdVl74GsisxVgb+LvgUZrqZW88nl4wbTw==
X-Received: by 2002:a17:906:2452:: with SMTP id a18mr2535010ejb.66.1606394593460;
        Thu, 26 Nov 2020 04:43:13 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id n15sm3112864eje.112.2020.11.26.04.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 04:43:12 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH 07/12] fsck: add new "extra" checks for "mktag"
References: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net> <20201126012854.399-8-avarab@gmail.com> <X79hCWF8jDZBw/NG@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <X79hCWF8jDZBw/NG@coredump.intra.peff.net>
Date:   Thu, 26 Nov 2020 13:43:11 +0100
Message-ID: <87tutcnva8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 26 2020, Jeff King wrote:

> On Thu, Nov 26, 2020 at 02:28:49AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Add optional "extra" checks to fsck, these are needed to eventually
>> replace the custom not-quite-fsck code in mktag.c.
>>=20
>> The mktag checks differ from fsck_tag() in several ways, one of those
>> is that fsck doesn't know how to refuse an object with custom headers,
>> and isn't strict about header and body newline separation.
>>=20
>> Teach it how to optionally report these. I thought the best way to do
>> that given the current structure of the code was to add a new "extra"
>> category in addition to error/warn/info.
>
> Hmm, this new severity (and the extra options bit) feels a bit
> backwards. We are already passing the information on what we find to the
> report() callback. It seems like that is the place that should be
> deciding what is important and what is not.
>
> Unfortunately the defaults are somewhat backwards here. We'd have to
> teach the fsck callbacks to ignore these harmless entries, rather than
> teaching the mktag caller that they need to be respected.
>
> So probably the extra bit in options to say "do these extra tag checks"
> is the least-bad thing. But then why do we need to put them in their own
> EXTRA section? The only caller that wants them would treat them as
> errors.

Right, it'll be hidden behind options->extra, so I could just make them
ERROR. I guess I was thinking it would be confusing to stick stuff in
the middle of ERROR that wasn't on by default, e.g. I've sometimes
skimmed that macro definition and saw "ah, bad parent sha1 is an error",
as in transfer.fsckObjects would reject it.

So I'm slightly on the fence about keeping it as it is, what do you
think?

> I'm slightly on the fence on whether mktag really needs to enforce the
> "unknown header" thing at all. Sure, we don't encourage them, but it's a
> plumbing tool one could use to experiment with new headers. I guess the
> downside is that a typo'd header would not be caught.

The problem is that since verify_headers() in fsck.c wants to allow it,
there's no way for it to distinguish a fat-fingerd "didn't separate the
body from the headers" v.s. actually wanting a custom header in some
cases.

>> Under --strict the "info"
>> becomes a "warn" and "warn" becomes "error". Existing users of
>> fsck's (and others, e.g. index-pack) --strict option rely on this.
>
> Yeah, this is a weirdness I think we should eventually fix (along with
> re-prioritizing some of the existing checks). I'm wary of doing anything
> that further cements that somewhat broken world-view (keep in mind that
> "index-pack --strict" is not "do fsck more strictly" but "do fsck at
> all").

*nod*, will note that.

>> I'm not changing fsck_commit() to validate commit objects like this
>> either, we could do that, but unlike in the tag case that code
>> wouldn't be used anywhere. If someone wants to write a "mkcommit" they
>> which behaves like "mktag" they can borrow or refactor this logic for
>> use in fsck_commit().
>
> Seems reasonable.
>
> -Peff

