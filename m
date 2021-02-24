Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1C5C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 11:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95B7C64E90
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 11:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbhBXLPc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 06:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbhBXLNM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 06:13:12 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003E1C06178B
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 03:12:31 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a22so2342519ejv.9
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 03:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=emejd1/2XlVOdcEADImIG+DGxG8XtOkVoR51sL/yQ4w=;
        b=IYF5awoCrTDmjvitGU1TbumTkDH65Ht3EVGHNmX8Ic/+wVPop6X+6IHBvcRRxXJgh9
         CmCCGS8pdtx+2Yn/WPakTaLzAyORvvSY4K5OLBlkdJCxQT7sV4AA/I+cvXtvNIsHlLnb
         RxN52iw467HcK6Q5vY9dPi4kfircWB3coFZNg5z3bEwMEdz19H+C+KHKu3TRE/BEg5Fy
         G89NBvbtQYRbEoPOO010iSivnSnxwSHz7myfOd8VmChK2i7skEZ+wQJDxSlYQjxTzyvt
         FSQuiLVP5MuX/C36+0LWDEwDGV2A2DgXuGtkpb8pcAZqRGk7SywzdaSQRan4qb09oVs+
         g5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=emejd1/2XlVOdcEADImIG+DGxG8XtOkVoR51sL/yQ4w=;
        b=t3UnPfAMuHU7dIgd3WjHWj2YhvEARO9nzsX19NZJhjUXf47/4fsLMXwKCl2Yraljii
         fZT3W6wn1JwteLNRaxHGIbTXwcwLvLAkcPdOBecSvBZ6qghSAmgEL2jkz+2s6CcJXHDe
         MatT5TuEtdQN/63PgJecbSLlNdSSfJ56bN0hqVmVnDdPbCq0EHEFBgzJ4xcGVHyFQ9Sm
         PGoQABQqtQ/urlKqzn0633NbN3+msoEOIcCxHK7MNAyzW8khs+ouOdR9VbNQOq6hQrvu
         tk3Dk5rn+Z/w6Orq6/nZ0vANPM/JE5TYLHwNHrQPmiZVVQifAYASIV78u0qduGtGg8of
         0nuQ==
X-Gm-Message-State: AOAM53162k615H4FabNfB64V3vi+Q/E3KDFFTevakNjnoWZqmo9FJ5iu
        LW+ZN3pL115gHK1t/OOoaKF2k5i48fPpHQ==
X-Google-Smtp-Source: ABdhPJz5CecVGYLFW1D+cexOUlX5jQXoQ+/jYTPKExAAMB9cNNC9OYGlHZMnPc7CXpWcRfznVcjx2w==
X-Received: by 2002:a17:906:7742:: with SMTP id o2mr18662429ejn.46.1614165150584;
        Wed, 24 Feb 2021 03:12:30 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n19sm1152322ejb.51.2021.02.24.03.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 03:12:29 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 09/27] userdiff tests: match full hunk headers
References: <20210215005236.11313-1-avarab@gmail.com>
        <20210215154427.32693-10-avarab@gmail.com>
        <4bd7bb84-3b75-258e-b488-f66dff6ba6b5@kdbg.org>
        <xmqqsg5vrhha.fsf@gitster.c.googlers.com>
        <1b2cb670-b49b-b478-7f69-6d4c356c8118@kdbg.org>
        <87h7mba3h3.fsf@evledraar.gmail.com> <xmqqk0r6ldrn.fsf@gitster.g>
        <877dmz7wtv.fsf@evledraar.gmail.com>
        <1c5f8cb8-2d99-4279-ba61-4f7720ece277@kdbg.org>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <1c5f8cb8-2d99-4279-ba61-4f7720ece277@kdbg.org>
Date:   Wed, 24 Feb 2021 12:12:27 +0100
Message-ID: <87y2fd7m90.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 23 2021, Johannes Sixt wrote:

> Am 23.02.21 um 14:11 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> On Wed, Feb 17 2021, Junio C Hamano wrote:
>>> Sounds good.  It shouldn't be too hard to satisfy both camps,
>>> i.e. the quoted demonstrates one way to allow test writers to
>>> give expectation in-place in the single test file, and replacing
>>> how it uses "grep" to check the output with test_cmp or whatever
>>> wouldn't make the resulting tests too hard to write and maintain.
>>=20
>> It doesn't satisfy both camps, because I'd like to convert all these
>> tests to test_cmp because for a subsequent refactoring of userdiff.c by
>> me or others I don't know in advance what might break, so I'd like to
>> assert the exact current behavior.
>>=20
>> Whereas your patch provides a way to opt-in individual tests to a
>> test_cmp-alike, but leaves the rest at grepping for the "RIGHT"
>> substring. Failures in the tests who aren't opted-in will be hidden.
>>=20
>> It also means that subsequent changes to the behavior in the form of
>> submitted patches won't be as self-documenting, e.g. I've wondered if we
>> could introduce a case to balance parens in this code (sometimes C
>> function declarations stretch across lines), and there's e.g. the
>> arbitrary limit of 80 bytes on the line (which to be fair, we don't
>> curretly have tests for).
>>=20
>> Anyway, as noted in [1] I don't see how this custom format of grepping
>> stuff out of plain-text files is simpler, particularly when its behavior
>> would start to rely on other things like "# HEADER |right()|" whose
>> behavior is a function of what we grep/sed when/where in the logic
>> driving the tests.
>>=20
>> But if you & Johannes S. disagree with that I don't really say a way
>> forward with this series. I think e.g. squashing 09/27 into the rest
>> would make things simpler/less verbose, but the end-state would still be
>> matching the full hunk line, and if that's not something that's wanted
>> in any shape or form as a default...
>>=20
>> 1. https://lore.kernel.org/git/87h7mba3h3.fsf@evledraar.gmail.com/
>
> I could live with a version of Junio's suggestion that is not opt-in,
> i.e., the checks are mandatory and exact. The important point is that
> there is only one file per test case; that would still count as
> "sufficiently simple" in my book.

So something where the tests in 14-15,17,19/27 would need to go back to
having the config that's part of the test driven by setup in
t/t4018-diff-funcname.sh, and the contents of a test file being e.g. (to
take the test from 25/27):

    # HEADER |package main|
    package main

    import "fmt"
    // ChangeMe

?
