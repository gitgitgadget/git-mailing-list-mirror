Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4C8C433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 16:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC4E16144B
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 16:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbhD2Qfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 12:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbhD2Qfw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 12:35:52 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79538C06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 09:35:05 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id b21so4714964ljf.11
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 09:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QjXHokTcaiw3wHpuK7qNgPssVJ6jhnqvBnlj3hHQXpo=;
        b=Pp3W1quOHOMzhqjhj0JAHILgnTKRfaCmljVVYN9T7Mzu9IeN/PvbHh/bqLqMql9jt/
         i884s9i6wZ+Ne3xe+nwbn0/mK9gusYTkT3UXBYUUe6Dw2reEZqfo1udLpsGTwAb3SzE2
         RxG8hJZJy9R0krZtsGwMxqSLqI825HtZiBtWKEmXstfx2KmEwgnACrfAkHuU6tU65/Wk
         5tfFQ/V1wK3LxM1HhYmrhmHAxmHv5TApA/ls7y81amVxha9eX21of4EjD6F/X1yzmF/k
         W31h/ZFLuPh0zKKO9nUZ6foVQqNVuq2yDo74JveEkJXzGel4xy0jpNSPpEsUFIdZYL5f
         bxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=QjXHokTcaiw3wHpuK7qNgPssVJ6jhnqvBnlj3hHQXpo=;
        b=FSKdwPKPQ5s3zWbHHx3JFXzAylzwdPwICXbOJfbBy7yrdktc2PQButsft0vF4/tI36
         c3KCPHWHDMecWkdlJnPITq8qcXJ1FV/Uxv5XO0ww/h3ubaOSKG8VEWNt3EwYeMPkr4wH
         q2/UzrCDg83rh3qfP1OwQMPQip+6gRZOS1SSW8g9ALMrPNX6uMTx6MjiD0ioifxjEWRc
         dDWyK6QutY43oMv/Gvfv4b0AedSb8zrxbnNKODzoyMCWtuVsA2fXzaNCnKOcmxs7LY5/
         gbsznvk6/qOPPSwFyPKRJUlMnGbVisOtCbvuAk/OK3f87HfSZyhySmB5VXVh22ZIgJre
         PwSg==
X-Gm-Message-State: AOAM532B/kB3gtLBvwLFOjrtVd0vzERStB091JC0KFdnfxo99CfulhGF
        68FlIB4rscluOc1kZnua4h/URqwcSA4=
X-Google-Smtp-Source: ABdhPJyOP2tWZZcBAkDMAiNYbdmyoEE5Zhsk7wfGZZwNB5it68Ln4rxxGnPCUL1lJEHCX26ysTk5GQ==
X-Received: by 2002:a05:651c:212a:: with SMTP id a42mr338785ljq.505.1619714103758;
        Thu, 29 Apr 2021 09:35:03 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t184sm24412lff.208.2021.04.29.09.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 09:35:03 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Why doesn't `git log -m` imply `-p`?
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <xmqqwnsl93m3.fsf@gitster.g> <87im45clkp.fsf@osv.gnss.ru>
        <CAMMLpeS4pkP_xRw_qT3mCTP4hS3iLP9TwdDf8LV+3+an9aJ3Hw@mail.gmail.com>
Date:   Thu, 29 Apr 2021 19:35:02 +0300
In-Reply-To: <CAMMLpeS4pkP_xRw_qT3mCTP4hS3iLP9TwdDf8LV+3+an9aJ3Hw@mail.gmail.com>
        (Alex Henrie's message of "Thu, 29 Apr 2021 09:25:44 -0600")
Message-ID: <87eeet9hhl.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> On Wed, Apr 28, 2021 at 9:22 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Alex Henrie <alexhenrie24@gmail.com> writes:
>>
>> > Why do -c and -cc imply -p, but -m does not? I tried to use both `git
>> > log -c` and `git log -m` today and was confused when the latter didn't
>> > produce any output. Could we change this behavior in a future version
>> > of Git?
>>
>> "[alias] lm = log -m" can be used when you only want the logs
>>
>>     $ git lm maint..master
>>
>> or when you want to also view patches your preference is to see all
>> sides of diffs of merges
>>
>>     $ git lm -p maint..mater
>>
>> but depending on who you are that may be of dubious utility.
>>
>> It is best to move on, writing it off as historical accident, and
>> embrace the new --diff-merges=m option, instead of wasting time on
>> pondering "why", because accidents do not have to have a deep reason
>> behind them ;-)
>
> If the behavior is an idiosyncratic accident of dubious utility, let's
> replace it with something that makes sense and is useful :-) If we
> make -m imply -p then no alias is necessary, `git log` would display
> the log without diffs and `git log -m` would display the log with all
> the diffs.
>
> On Thu, Apr 29, 2021 at 6:38 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> As the final purpose of all this is to have -m as user-friendly short
>> option, I'd incline to finally let it imply -p, as --diff-merges=m now
>> covers another side of the coin.
>>
>> What do you think?
>
> I am 100% in favor of that proposal, and I can work on the code this
> weekend.

No need to bother. If we agree, I'll send a patch atop of my recent
changes that make -m format configurable.

Alternatively, we can add a configuration option, or let -m imply -p
only when -m format is explicitly configured by the user.

-- Sergey Organov
