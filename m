Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4ACAC433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 02:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8821764F6A
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 02:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhBCCtI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 21:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhBCCtG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 21:49:06 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71295C061573
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 18:48:25 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a9so14854839ejr.2
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 18:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=g/mZOjleZ1NQoe8WWE6ROq6OIQLzYWKXr1a7IXE7lhw=;
        b=HJ/fu0cwrHDzXQ/UiQHyscLm/TZfeAHYQ+DLdKQoRtqoxMy+iFWyYUEWf+h4Ab/67x
         1Z9Aa0gXJWejHR1AbQsTlcWBiEAlXhI5Pyphn6BHFmN/L88uJYpP/0Z4HbVtTK1bXcHu
         +hCmVQiOLt8clmbdLntEVFvLUHwF695y93jP0pU/CtL2pIDGomoNboUwTwFtWetyzK5K
         0O9lq1s1hTAjbjy3HEiLMejpAUQKaMwMl9FNS2adutvck/hmVfQ+Z2t8pOjzQIzWHK9Y
         mh9xFq+rznO4qcfmxkpOtMmOT3GKL99mH2HcSAaEcMkpygtAf5TGtz41Mugi18Q/W8Kq
         0VHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=g/mZOjleZ1NQoe8WWE6ROq6OIQLzYWKXr1a7IXE7lhw=;
        b=euoIvv94NNFp2aNj53sODuP5xvKe9DTdZ42b0615V0texo2LjfEGXkqDH05FGLkUWy
         Fh/N6b293iCmG+dhfJPNtpB+4x1/YABxHYYAk6YESuyghvETaRBOVzgjRjnEFiLBCOvi
         fauhNYWcSfz9KptwIAr/fRLsNRCMU2UTDc4FACZAkI3NlmcP1nB71Vlhx+TZuJIur6SW
         v/HrXsQZJ2DMixay2DtGVGIP/Y149WHAi5Rgv46sueELlRkNQzULNNVlwTG8Tis10aMl
         JKhrI2D0o81mNEJCdwEeaJjnm5PSuTFEV8BF9xuYT4SimbQZBMGb6CDE0kJLSXwswNfN
         c28g==
X-Gm-Message-State: AOAM530E7+E7gXQSKdFJS8eFOvcDh6F1jYEaUSiB84LSsTncCIB082x1
        cmJOSRTyl2pFzBPa5XFQdGYH2Gn3OFc=
X-Google-Smtp-Source: ABdhPJxiQlaicIVeS1z42vrpiwJrlH3s8vwNnXfKZYdUQAb3LD88OHM/7KJRJvlhKkxYtjbE2doZoQ==
X-Received: by 2002:a17:906:b50:: with SMTP id v16mr969831ejg.298.1612320504097;
        Tue, 02 Feb 2021 18:48:24 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id l13sm222898edq.37.2021.02.02.18.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 18:48:23 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Vincent Lefevre <vincent@vinc17.net>
Subject: Re: git fails with a broken pipe when one quits the pager
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
 <8735yhq3lc.fsf@evledraar.gmail.com>
 <20210131033652.GK623063@zira.vinc17.org>
 <87o8h4omqa.fsf@evledraar.gmail.com>
 <20210201103429.GT623063@zira.vinc17.org>
 <87im7cng42.fsf@evledraar.gmail.com>
 <20210201144857.GB24560@zira.vinc17.org>
 <87a6snokrr.fsf@evledraar.gmail.com>
 <5772995f-c887-7f13-6b5f-dc44f4477dcb@kdbg.org>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <5772995f-c887-7f13-6b5f-dc44f4477dcb@kdbg.org>
Date:   Wed, 03 Feb 2021 03:48:22 +0100
Message-ID: <87o8h1euix.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 01 2021, Johannes Sixt wrote:

> Am 01.02.21 um 16:44 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> On Mon, Feb 01 2021, Vincent Lefevre wrote:
>>> On 2021-02-01 13:10:21 +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>> So we've got the SIGPIPE to indicate the output wasn't fully
>>>> consumed.
>>>
>>> But the user doesn't care: he quit the pager because he didn't
>>> need more output. So there is no need to signal that the output
>>> wasn't fully consumed. The user already knew that before quitting
>>> the pager!
>>=20
>> As noted above, this is assuming way too much about the functionality of
>> the pager command. We can get a SIGPIPE without the user's intent in
>> this way. Consider e.g. piping to some remote system via netcat.
>
> That assumption is warranted, IMO. Aren't _you_ stretching the meaning
> of "pager" too far here? A pager is intended for presentation to the
> user. If someone plays games with it, they should know what they get.

FWIW I replied to this in
https://lore.kernel.org/git/87r1lxeuoj.fsf@evledraar.gmail.com/

Whatever anyone thinks of the virtues of passing down SIGHUP having e.g
a nc to a remote box be your pager isn't all that unusual.
