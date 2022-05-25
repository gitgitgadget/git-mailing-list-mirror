Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60238C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 13:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240206AbiEYNbG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 09:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237091AbiEYNbC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 09:31:02 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1D336173
        for <git@vger.kernel.org>; Wed, 25 May 2022 06:31:01 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gi33so33214858ejc.3
        for <git@vger.kernel.org>; Wed, 25 May 2022 06:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=BsaIM01oAWaqr04stjCLz16R4xZWIuIrdn1F2meS9Y4=;
        b=MA+DQaCh/TFjcM0bbCGCjtrBBENt9Vi/YL6UcfA5vPTh9lQS5fDwtNGfuwsMsYjuf2
         bgcq0Merx0BIwle1ZIQOLdf9fn0V/4YY1sjhq5YVGd8rw5V0SWcC7V0ZpKBogsH2IdZB
         1kAfN8FFNgwLT4A6vIN2VGGvVcoUnYdIKBzXKX161jPWFxk7FZjq7pxuET51cNckKOCq
         +tv3bsLkun6f47J6XEo1Ws9oJpMkgTvVHo1h7VsuiP2C/N01qNRjz5BAvdhHFTAL00Ml
         0Q6dBOZKJmrKh8lxmsBdFHJIWqI5zXQfq1j2JVGGyJFWtbrD3QcK0/VALQGilLZdj2Jd
         4jdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=BsaIM01oAWaqr04stjCLz16R4xZWIuIrdn1F2meS9Y4=;
        b=34Yc2lj1MeEA6XJU4d0DbwDgffi1DFtrvcY0fgLFKEE+rVHhAQ5udfsLKKlXKLMDAW
         PefSKFmNody91AZzB8IuF7yf2w2S57n3c32NbYctHFuT24yI5qTrlkp+9+WZdNzudVqd
         KvRZucqlEKsrtpJMQbGLNkoWCjgY3bHnatmtPDHMQWKY3//UsqTC1wzwFnfuz1HC5kJf
         roTrmhpBDa/7OdUzk6owHvUzUQcz8rHmV4JRdMT5BzALGQev5j9qLmcwy3Bwl6Ymzj3D
         qYxsj+zd77jllipZOI7VvBb0J20H+znrdSvcwIw/GR9T5lhc7DCx6yNKvkVX4TZgRCVO
         T+hQ==
X-Gm-Message-State: AOAM533LD9uqiZ8Pr4aEUrGLNkd9RpvfsIQSjbVc9+IYPcsdNxLKGhQ/
        oJ7nwCeOVKYdXy3ZEbp1+b0=
X-Google-Smtp-Source: ABdhPJyvw666Q9WKDiQt8IE6jG3Gc0Idxxi0aeIIDWcmKKdHFkPDXlO2yQ7Pkz1/zdjvT1RxwmxbkQ==
X-Received: by 2002:a17:907:3e86:b0:6f5:917:10cc with SMTP id hs6-20020a1709073e8600b006f5091710ccmr27945803ejc.53.1653485459713;
        Wed, 25 May 2022 06:30:59 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id j16-20020a1709066dd000b006fec69696a0sm4018160ejt.220.2022.05.25.06.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:30:58 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ntr6I-003oZ8-7O;
        Wed, 25 May 2022 15:30:58 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH] http.c: clear the 'finished' member once we are done
 with it
Date:   Wed, 25 May 2022 15:27:57 +0200
References: <cover.1651859773.git.git@grubix.eu>
        <3f0e462e86625a3c253653e4a4eefabcd8590bf9.1651859773.git.git@grubix.eu>
        <xmqqtua2jtr0.fsf@gitster.g> <xmqqczgqjr8y.fsf_-_@gitster.g>
        <nycvar.QRO.7.76.6.2205232248360.352@tvgsbejvaqbjf.bet>
        <xmqqr14jluu4.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2205240124280.352@tvgsbejvaqbjf.bet>
        <xmqqa6b7lrw6.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2205241258510.352@tvgsbejvaqbjf.bet>
        <xmqqleuqj1gy.fsf@gitster.g>
        <20220524201639.2gucdkzponddk5qt@carlos-mbp.lan>
        <220524.86mtf6ve89.gmgdl@evledraar.gmail.com>
        <xmqqh75eef0f.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqh75eef0f.fsf@gitster.g>
Message-ID: <220525.86bkvlu4bx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 24 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> It doesn't mean that GCC has additionally proved that we'll later used
>> it in a way that will have a meaningful impact on the behavior of our
>> program, or even that it's tried to do that. See an excerpt from the GCC
>> code (a comment) in [1].
>
> But that means the warning just as irrelevant as "you stored 438 to
> this integer variable".  Sure, there may be cases where that integer
> variable should not exceed 400 and if the compiler can tell us that,
> that would be a valuable help to developers.  But "you stored an
> address of an object that can go out of scope in another object
> whose lifetime lasts beyond the scope" alone is not, without "and
> the caller that passed the latter object later dereferences that
> address here".  We certainly shouldn't -Werror on such a warning
> and bend our code because of it.

I think it says something that 1) we had exactly one of these in our
codebase 2) as we've discussed the pointer isn't actually *needed*
outside the scope of the function, it's just left-over.

Now, if it were used, e.g. let's say we had some code that took the
struct and inspected its members we'd likely have a segfault here, or
worse it would "work", but only on the platforms we'd test at first.

Which isn't the case with a leftover "int finished" holding a 438.

The point of this warning, like so many others, is to ask "hey, do you
really need to be running around with this particular pair of
scissors?".

