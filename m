Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F566C761A6
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 01:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjDABaq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 21:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjDABap (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 21:30:45 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D281C1FE
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 18:30:43 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n14so7137290plc.8
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 18:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680312642;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=isi7m3CmGBVO9/Zc4mAL/H6Z4G5hp9dgVygqvTpXSGw=;
        b=eGl7Uzv88VIfGMe8mmqFadjjxx88I3uMsgYuMWqCf2IOtMnOOxNhj7pPITC3tK0dxE
         5h6wVeF+H4MqCjPW+c5ESaBZ3HvAB3JzLhDVLL6W58hbCLTbgIu9fbvsoxxWToqLsStk
         mYUlR73UE/13RDSIbC/ENY4z7Q1/SZnIpqzoklElZZadtN9Wp6HY3XNDsvCGkO0BEPSO
         oGPbMfBE/MhFPUPqlW3itqB9sZ6gRgiRP2jShbazOAEbA2h/y0oAn3/ViFcDcSSpzY/+
         hK5jx45SRe/ys/jbxE6MWxv3OHmjR+5/jilXNmipPaFeVwnvO1Jmnjv8c+nkcTcN543l
         ZNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680312642;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=isi7m3CmGBVO9/Zc4mAL/H6Z4G5hp9dgVygqvTpXSGw=;
        b=jQVh9+2hKlMEykKrd7hCGKWOyLaaAv84NlprnBjrKR+i6OK4m1wR321hM6hbjwo6mH
         cwk8S+aN4Ss8WtIz+XV6t69EHidxQkd25uz7R/2CrkDsYgolN0Y6K+SrCqUQleYPFrPA
         6c9VHI171DylcTeCwsO562nDTGRmQDnpvWBEaodRoyBl76z/vDGXU1BM7BJn9vD+Q43C
         e9uMAN+HWbwhH9sPWetiqqS/JGTi7TE7+Qt+hE7TAeLCCWKIeY+Mcor7ckzvBNpo7On4
         rIy2VJQ6yXfEeCuUs+hcF8to+k70mxgsz1d0/9sk0P8A/TjngTk9RQLh8guVqLPL54Ll
         0WuA==
X-Gm-Message-State: AAQBX9efrkkz3pLj4kH0IF/iqNra6UP/RbU3MzxbWA7ZF78EC4AXwL0b
        2hKF4Dyv9Q/9RlLNSMKN5wA=
X-Google-Smtp-Source: AKy350YLUKBwKUVzymJhi1Zbb4sSZHwQohbdawz8x2pxqqWoYq7Krq7kwpSMBr+GqOjpFDQ2gzZnqg==
X-Received: by 2002:a17:90b:1d0e:b0:23d:bbcb:c97f with SMTP id on14-20020a17090b1d0e00b0023dbbcbc97fmr30350862pjb.1.1680312642398;
        Fri, 31 Mar 2023 18:30:42 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id x5-20020a17090a970500b00234afca2498sm5626855pjo.28.2023.03.31.18.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 18:30:41 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/6] test: make the test suite work with zsh
References: <20230328173932.3614601-1-felipe.contreras@gmail.com>
        <ZCONCVC2ITBJWoBA@tapette.crustytoothpaste.net>
        <xmqqh6u3d119.fsf@gitster.g>
        <CAMP44s0eSDBXZEN9fRPdxV4GKLqckKtujMLDPORDjHfsdypDBQ@mail.gmail.com>
        <xmqqa5zu4ka3.fsf@gitster.g>
        <CAMP44s3xVL0UHCHh2Ei=STTx=grkpvUTfj6o9roe3tL35GhG4Q@mail.gmail.com>
Date:   Fri, 31 Mar 2023 18:30:41 -0700
Message-ID: <xmqqv8igbd8e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> The criteria is more about what our developers are expected to be
>> familiar with, and what is reasonable to force our developers to
>> become sufficiently familiar with.
>
> That is not true.

We probably should agree to disagree.  Let me respond by picking the
first example from your message and then stop.

> This patch 77e572653b (t0050: fix printf format strings for
> portability, 2010-12-21) fixed a problem that was specific with dash.
> Did our developers have to learn the details of such issue? No.

The code before that change was feeding "\xc3\xa4" to printf,
expecting that it would be an acceptable way to spell hexadecimal
byte values, which was wrong.  The commit improved portability by
rewriting them to spell the same byte values in octal.

Yes, our developers have to learn to avoid hexadecimal byte values
and the commit serves as a reminder for them to learn from.  When a
developer writes printf format with '\xCC' hexadecimal, reviewers
would need to catch it as a mistake, and that commit makes a good
reference why we insist on such a rule.

By learning that practice, our developers will be trained to write
scripts that not just work with bash but also with dash, which is a
small good thing.  But still, it *is* forcing our developers to
learn one more rule.

There is a trade off: is it worth supporting dash by forcing our
developers to stick to the rule to write octal and not hex?  dash is
used as the default for some distros and considered one of the
standard ones, and is worth supporting even if we need to stay away
from some stuff people may have picked up from other shells like
bash.

If it were a different shell, the equation may have been different.
If industry standards like POSIX.1 required supporting hex literals,
the equation may also have been different.

	Note: though, we do not blindly say "it is in POSIX, your
        shell behaves differently and we won't support it".

In any case, once we declare that "we aim for our scripts and tests
to work with dash and bash and these other shells", our developers
are forced to stick to intersection of these supported ones.

It takes a judgement call.  And "don't write literals you feed
printf in hex, instead do so in octal, because printf built into
some shells do not like it" is something reasonable to force our
developers to stick to (as it allows "dash" to be thrown into the
set of supported shells).  I however do not see "don't use path or
status or options or 0 as shell variable names" falls into the same
category (even though it may allow "zsh" in native mode to be
included into the supported shells).  Do benefits outweigh
downsides?

And somebody has to draw that line.  Judgement calls are just that.
There are no absolutely right or wrong answers and they will not
please everybody.  Some folks may not agree with where the line gets
drawn.  Tough.

But the job of maintainer is not about being loved by everybody.
Just drawing the line somewhere in order to allow folks to move on,
without having everybody dragged into and getting stuck in endless
arguments, in which there is no absolute right or wrong.  That is
what needs to be done, and that is what I just did.
