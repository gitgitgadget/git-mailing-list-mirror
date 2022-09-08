Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D374C54EE9
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 21:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiIHVJM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 17:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIHVJL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 17:09:11 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7177895ADC
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 14:09:10 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id pj10so8559834pjb.2
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 14:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=OGoJ//QBapHaVwK+rTJs/dLEM0FFrBY73QrPejVGwZo=;
        b=pnsyMqwCVIFetYRr6FpCwW9+OeHiMlh2uDeKvMVM0Xbr1HCt+Mw8itAmSWMOYuCOFi
         29tRvfOCP9EIHUhLXX4ZRyVnpVdIGk4aTuwyc+SPSnWWJn8Vaj0apZ4J9BbTy/DsJ7/T
         5gZ4aRsutpBcnjFL4jRSbdxmKRBrPMUcDE5nJUrd+2348aX1O7OK9vv1vapUcUU8cS6S
         rnyElTjGBm/RNavAwUOHDvsa64ARkxTHH4Q3PggXQhQH32KJU9q1oG/EHuBbI5FA1rzZ
         cEdWME4mLiZoLrm08X/RULc83RqWhKETlzGuJoX5WckITYOJX6X+FHzgxbK0lEqOCmn7
         9Q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=OGoJ//QBapHaVwK+rTJs/dLEM0FFrBY73QrPejVGwZo=;
        b=YpIYsrog6SZ9Ce+aFZQXzsam4DUcvSHbeNSohxpTNTZNgYo8ugugD2O78HVh+l/xEA
         KeBlluWw4yIr3nccAVJIwOM1jNuTcmbU7JVUu1J/i1oMVKMnbEADoEafq7PJayZOY3Xo
         TV0EGomYmCopbsAoEoTRo+ZDmdj1uUhFB6gG6I8Df/nS1a6pAFidcn1ibb5x9vjNXMrI
         7euHsXmFzDXWl1H/na+R6Oobqz0M1rDcoO0Z0J/nupBtf8fn3AxcRVNAJZtole0qgt3P
         SPZlrBxL/dh7k02+M8ezZg0imcqA8/3/RdhawrMZzQc7nSblDvSYxham/5Ch971sDgUc
         IceA==
X-Gm-Message-State: ACgBeo3osD54wgoQi6ydSGWeRF868ucUHDW90yXg1SXXxTeCP+V6R4V1
        mtpabyZ8uGI3MeKj9h0ZTe8=
X-Google-Smtp-Source: AA6agR6WotO7BjDE+AY/fyNmlc6/NRYoIJiiTL/rowdIMZdQBEm5WhNibFsC3GqYddBFFDP2R4jCyw==
X-Received: by 2002:a17:902:f604:b0:172:75a4:33ea with SMTP id n4-20020a170902f60400b0017275a433eamr10470329plg.7.1662671349904;
        Thu, 08 Sep 2022 14:09:09 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id jc3-20020a17090325c300b00174abcb02d6sm10596352plb.235.2022.09.08.14.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 14:09:09 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] tests: replace mingw_test_cmp with a helper in C
References: <pull.1309.git.1659106382128.gitgitgadget@gmail.com>
        <xmqqwnbv7trp.fsf@gitster.g>
        <354qp59q-r4r3-1971-5o09-71q224911orp@tzk.qr>
        <b21d2b60-428f-58ec-28b6-3c617b9f2e45@web.de>
        <xmqq7d2fywvr.fsf@gitster.g>
        <q044qs1r-n8p3-1617-so32-02s1r88186sp@tzk.qr>
Date:   Thu, 08 Sep 2022 14:09:08 -0700
In-Reply-To: <q044qs1r-n8p3-1617-so32-02s1r88186sp@tzk.qr> (Johannes
        Schindelin's message of "Thu, 8 Sep 2022 22:54:40 +0200 (CEST)")
Message-ID: <xmqqbkrpo9or.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > Why not use "git diff --no-index --ignore-cr-at-eol"?  Do you even need
>> > to wrap it?
>>
>> Hmph.  That surely sounds sensible if it works, and I offhand do not
>> see why it shouldn't work.
>
> Is this a reversal of the stance you took in your reply in
> https://lore.kernel.org/git/7vps7xrfxa.fsf@assigned-by-dhcp.cox.net/ to my
> suggestion to replace `cmp` by `diff --no-index` (in that mail referred to
> as patch [7/8])?

cox.net?  It is a lifetime ago and the world has changed.  Hopefully
that "diff --no-index" has matured a lot to earn more confidence by
us than it had back then.

> If I recall correctly, you clarified outside of that thread that "I do not
> think it is a good enough reason to make the tests slower" was you being
> concerned about employing the entire diff machinery instead of doing a
> simple byte-for-byte comparison.

Is it still relevant, now that we are talking about text-cmp that
ignores cr-at-eol, to bring a random remark about byte-for-byte
comparison from more than 10 years ago?

> Just because it is easier to review a one-liner to switch from essentially
> `cmp` to `git diff --no-index --ignore-cr-at-eol` does not mean that it is
> reasonable: it would cause us to blast out that much more CO2, just for
> our one-time convenience.

Measurement, in tons per year, is needed, or please stop talking
about CO2.  It is not that funny.

Developer cycle time is easier to measure and more meaningful.  

It would be much faster to run a byte-for-byte-with-ignore-cr-at-eol
comparison than running "diff --no-index --ignore-cr-at-eol" on
files with meaningful sizes.  But comparison between "expect" and
"actual", which are typically at most several lines long?  Wouldn't
the overhead to spawn a process dwarf everything else, especially on
Windows, whether it is your byte-for-byte-with-ignore-cr-at-eol
program or "git diff"?


