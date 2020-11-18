Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD282C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 13:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E2DC2467D
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 13:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvL6gLcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbgKRNpD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 08:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgKRNpC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 08:45:02 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90316C0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 05:45:02 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id k27so2787903ejs.10
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 05:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=SLiN9ontjaDQHs/7KPygRTpj7IsrrU9PSgQuNCtnHmg=;
        b=XvL6gLcBjSXC7lq2HBt5Mt2zIR6sRCWOlJClF9U/Nq/JttijUO3ImNxmWwvCide5aJ
         KJH72X/+V3yfIAIXDW0NQKQAhJvy4xzhmiN25jOWWhv+TEdjDeOdva8HdfrmUOdEOiJx
         BbOx4cgyHWTtRw+5yrWYfcLXQYcdga/PjEM1vJMi+rCtB0sN02iuuyG31l/X0M/8+3H4
         kW+MjFiiBFBvjPcumMsZxsDaxRGpETUmTlXVzws/lJWX2TEB3toEj/fJnSyYHPMG93mN
         uTfMTNDxTeqU5QtlmaAAArjUNr3e0e0hxu8rhNr1JFdraZaX36TuSxad8PHmB4kAqhjH
         obfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=SLiN9ontjaDQHs/7KPygRTpj7IsrrU9PSgQuNCtnHmg=;
        b=NiNQ0j+8jMrXMNUq/MYmHSgtosVBR+Qo69SwIxDXfQgmYSWSLlr6UZP/96ho0ca82E
         hL7mLmfYlXwRmk2gOM9MgoajOQJPLSxhv1ICme2RIltSdIoPiW6tmKfXbH9Gd8wK+1o6
         w1tFv/EcdFGoB0+zwJK3QaCD1sQEo/WOHP9HUVxV8BZ+UUegpyiZOkZey8u7UPxlqdak
         PLkNxLtgHs8hoLvUd3LGRVI7xJrzsgCImE2ZkEMJo3K7ilndaj/1H+Se0ASOrEcMKFXs
         bWulkjI+85Aclc93jRhcLYKj5uba8dYXGokMjLzOSWIu8orvMdduoNsKORDBzFsuuyaR
         U4Ew==
X-Gm-Message-State: AOAM531vI8WglBYtEprC9OJt68mR+E+urfhZstiATRhZ0IEZNrv5uBgI
        ElxxQArIZZ4zFQ+QkqY4+7lTu5UjWHZi+g==
X-Google-Smtp-Source: ABdhPJwS8SI9qJ3XjsCy4Bdf/VrtbByEiMRJCFJsZv/+UQRwb6TcOdgjuXeCOfEek0I4K0p5wjmg4Q==
X-Received: by 2002:a17:906:b104:: with SMTP id u4mr23758914ejy.121.1605707101069;
        Wed, 18 Nov 2020 05:45:01 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id x23sm1943524ejs.16.2020.11.18.05.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 05:45:00 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] config: allow specifying config entries via envvar pairs
References: <cover.1605269465.git.ps@pks.im> <44e8dd50c6ea7cbcc5e4fc35c9b9057c0a52038c.1605269465.git.ps@pks.im> <87mtzlflw7.fsf@evledraar.gmail.com> <xmqqy2j1851k.fsf@gitster.c.googlers.com> <20201117023454.GA34754@coredump.intra.peff.net> <873618f4he.fsf@evledraar.gmail.com> <20201117235736.GC642410@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <20201117235736.GC642410@coredump.intra.peff.net>
Date:   Wed, 18 Nov 2020 14:44:59 +0100
Message-ID: <87ft56rd7o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 18 2020, Jeff King wrote:

> On Tue, Nov 17, 2020 at 03:22:05PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > then I'd feel comfortable making it a public-facing feature. And for
>> > most cases it would be pretty pleasant to use (and for the unpleasant
>> > ones, I'm not sure that a little quoting is any worse than the paired
>> > environment variables found here).
>>=20
>> I wonder if something like the git config -z format wouldn't be easier,
>> with the twist that we'd obviously not support \0. So we'd need an
>> optional length prefix. : =3D unspecified.
>>=20
>>     :user.name
>>     Jeff K
>>     :alias.ci
>>     commit
>>     :10:bin.ary
>>     <10 byte string, might have a \n>
>>     :other.key
>>     Other Value
>>=20
>> Maybe that's overly fragile, or maybe another format would be better.
>
> Yeah, length-delimited strings are an alternative that some people think
> is less error-prone than quoting. And we do use pkt-lines. They're also
> a pain for humans to write (it's nicer if they're optional, but when you
> _do_ have to start using them, now you are stuck counting things up).
>
>> I was trying to come up with one where the common case wouldn't
>> require knowing about shell quoting/unquoting, and where you could
>> still do:
>>=20
>>     GIT_CONFIG_PARAMETERS=3D":my.new\nvalue\n$GIT_CONFIG_PARAMETERS"
>>=20
>> Or equivalent, and still just keep $GIT_CONFIG_PARAMETERS as-is to pass
>> it along.
>>=20
>> Your "do not require quoting" accomplishes that, and it's arguably a lot
>n
> Looks like your mail got cut off.

Nothing important, probably :)

> But yeah, the goal of making the quoting optional was to make it
> easier for humans to use for simple cases. It doesn't help at all with
> other programs inserting values, which can just as easily err on the
> side of caution.
>
> BTW, there is another problem with GIT_CONFIG_PARAMETERS (and "git -c"
> in general). The dotted config-key format:
>
>   section.subsection.key
>
> is unambiguous by itself, even though "subsection" can contain arbitrary
> bytes, including dots. Because neither "section" nor "key" can contain
> dots, we can parse from either end, and take the whole middle as a
> subsection (and this is how we do it in the code).
>
> But an assignment string like:
>
>   section.subsection.key=3Dvalue
>
> _is_ ambiguous. We have to parse left-to-right up to the first equals
> (since "value" can contain arbitrary characters, including an equals).
> But "subsection" can have one, too, so we want to parse right-to-left
> there. E.g., in:
>
>   one.two=3Dthree.four=3Dfive
>
> this could be either of:
>
>   - section is "one", key is "two", value is "three.four=3Dfive"
>
>   - section is "one", subsection is "two=3Dthree", key is "four", value is
>     "five"
>
> We currently always parse it as the former (which I think is least-bad
> of the two, since values are more likely than subsections to contain
> arbitrary text with an equals).

Yeah, it's a pain to parse if it's on one line. FWIW that's the main
reason for why the format I suggested moved it to \n-delimited, because
keys can't contain an \n, so you can unambiguously have them be
\n-delimited (as git config -z does).

You do need to worry about a \n in the value, but for the common case
where you don't have a \n there we wouldn't need to provide the length.

Or just provide tooling as you suggested in
<20201118015907.GD650959@coredump.intra.peff.net>, which I like better
than any one format suggestion (including the one I suggsted). I.e. we
can document that:

 - The variable exists
 - You read/write/add to it using a return value from this tool

Which allows for keeping the value itself opaque and open to a future
change.
