Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C10BC433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 23:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 367F561159
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 23:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbhKJXrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 18:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbhKJXrO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 18:47:14 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6522AC061766
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 15:44:26 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id x10so4825377ioj.9
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 15:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SAOQrtINgtBFxweJGnDNxW+oLjS6h+NPoz0x+BBiqGY=;
        b=NniPTmEKcCMd7VRRxxipfwuvEhpgQep8eVZAAqPAj/+DTVxPnAqHW+vvxGdnHLsRXm
         eQXgJNqO+Q5SkiV15pOUB6yfsKmsxrpRKNSQpPodrBCJA1ALkvmjrdZgS+6gC2WOgHBr
         +cFjsSXHYgDsmKCvo8HeQHmDnAqQybVzlFaD1/TOFban7h/WIGFd7dFiKMPMR6T4+W+6
         3VCVqHgv3XwzIRs8BAP8ud0WUHgmzyCH0hVedVphTYUSmXs3qm7hzWIkq5RFHSufbFgR
         v+SDTg16oRSon6t/F1q8Evxg6dxNmoQwcLhgIKIsMjw/TVteF4mDclQDjBt6ytjzDBFh
         JKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SAOQrtINgtBFxweJGnDNxW+oLjS6h+NPoz0x+BBiqGY=;
        b=rGEd55ojsRpUZFIbXBDStpWAppOdYjv2M5tEZsuST08EZVE0CKrebh9BypdYB0+YWI
         4weHlcwRAnIoB1+G1YW1Uyk7lW+/++oLRs5o+XIEUee9FoWLSmo2gkZU1/7qxnuTHHWD
         X85nYuANByrxkquynQxVLblTP3OTTQoQTeFwbwGEkcSKEelbNdF+8Vam6US/Lvy46cn1
         bLG6E71uN4T5kfZsmCdil8Tk4wjsmqWxPOCo16Wb1Jy1TDGO27ezYZQV2/lTd7DDQtHt
         7tFL7gzx6V7ohm9aPzeTJIIy2skMq0604/oA1VT4jp/otN9d9TBUKep9zHp0EtyrSjij
         V07A==
X-Gm-Message-State: AOAM5327uBFOADOF8w3/GlKNOArCtnEwa5hoHSJStb+Dav6aiO8xcwR7
        sNejAARuuecBsL6b+vl7q3C0A80tHKgLU/233EuAy0tIzfGrufpT
X-Google-Smtp-Source: ABdhPJwC2O9Aa9ArQf6vssoNw8ZPiS5h6K2Oo628mD7WcTEhokR5/a3/5YPd6rMIdQKisNufRyX2TP1rRwwCgstUfAM=
X-Received: by 2002:a05:6602:3d3:: with SMTP id g19mr2023362iov.42.1636587865623;
 Wed, 10 Nov 2021 15:44:25 -0800 (PST)
MIME-Version: 1.0
References: <a6098f98946bd9cc1186ab9c83d917566c78b805.1635532975.git.gitgitgadget@gmail.com>
 <20211108230111.1101434-1-jonathantanmy@google.com> <211109.86mtmedrhr.gmgdl@evledraar.gmail.com>
In-Reply-To: <211109.86mtmedrhr.gmgdl@evledraar.gmail.com>
From:   Ivan Frade <ifrade@google.com>
Date:   Wed, 10 Nov 2021 15:44:14 -0800
Message-ID: <CANQMx9U2sRB9Qm3zxvpOwn8cqRYyA0S0jJ2=JsspJ5hcRd_XOA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] fetch-pack: redact packfile urls in traces
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com,
        git@vger.kernel.org, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 8, 2021 at 5:53 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
...
>... Let's just:
>
>  1. Start reading the section
>  2. Turn off tracing
>  3. Parse the URIs as we go
>  3. When done (or on the fly), scrub URIs, log any backlog suppressed tra=
ce, and turn on tracing again

This is a more generic redacting mechanism, but I understood that
there is no need for it. Previous comments went in the direction of
removing generality (e.g. not looking for a URI anywhere in the
packet, but specifically for the packfile line format) and now this
patch is very specific to redact packfile-uri lines in the protocol.

> Instead of:
>
>  1. Set a flag to scrub stuff
>  2. Because of the disconnect between fetch-pack.c and pkt-line.c,
>     effectively implement a new parser for data we're already going to be
>     parsing some microseconds later during the course of the request.

pkt-line is only looking for the "<n-hex-chars>SP" shape. True that it
encodes some protocol knowledge, but it is hardly a new parser.

> That "turn off the trace" could be passing down a string_list/strbuf, or
> even doing the same via a nev member in "struct packet_reader", both
> would be simpler than needing to re-do the parse.

Saving the lines and delaying the tracing could also produce weird
outputs, no? e.g. 3 lines received, the second doesn't validate, the
program aborts and the trace doesn't show any of the lines that caused
the problem. Or we would need to iterate in parallel through lines and
saved-log-lines assuming they match 1:1. Nothing unsolvable, but I am
not sure it is worthy the effort now.

Thanks,
