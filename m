Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00F6C433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 09:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3A9B61186
	for <git@archiver.kernel.org>; Fri, 14 May 2021 09:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbhENJT2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 05:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbhENJT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 05:19:27 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8988FC061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 02:18:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id lg14so1831596ejb.9
        for <git@vger.kernel.org>; Fri, 14 May 2021 02:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=3yY9NJKTJjLNZTWMa4fmyOtRVAPP4nirGAJB9bJ+B6Q=;
        b=bF2spXhzNDz6tbLY81/FGggSS6bmIFmiKkJ6t6CE3cFCn3gqIPGUjmuSS4iFL/w1a1
         ND68uGbHOFBtKzoHjIWh1ddLu9/ncNl4Ske9M7wYcGgDiLTbIJOTLc3W6S2ha8X6uN9a
         AJQ6GA6/MmUWdyycGyhf4jwxfaVRDOwjHUA1f3LwWCyM9QNfujAeFlcqfpmFUl9HvWVb
         oLpTH3duWhnoIjHQA6aSiV+kGH5ZRqM1N+lxhy2S4wCzIXkBy3njp981UiHxJaPEXXpA
         lRZ1kiPO5CTnN8AqV0KSW766E4N1RS4b/BAL+tEMXhh4t7K79EnFtDbFNHS4R/aTFYV3
         zbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=3yY9NJKTJjLNZTWMa4fmyOtRVAPP4nirGAJB9bJ+B6Q=;
        b=qoR4ZZLN2MEKaNenfu3kYdNKeGRsc8k1F8kla+Gg4rkUebhvRZjAa916UFDJN4XpfT
         vLWb/PgU4Gqbd83Hsz8Knt7Pj+FfxIOG22jPToo6f2bxNuZpK7Q5+GHmtEurZOzCLc2R
         YVZcW3rMdb3dVp9ZYxoXUKukctHFfBeWqGhhlfKtpO6hQ+GjQDfrQWLiFJVnWEcIbaug
         Vniy7fspzfxdWYyZADu5cxX8k6Haz3PzNxR5RA1lbzgrM5PgaJwlx/QKTNTI2Fr5y1+O
         5k1qUuqrDpsTjfAbO00jBCwQrlIkUQpL7BkSf9D3HixHPRV3fHcYnsoNKVVmKaukENcb
         jOPw==
X-Gm-Message-State: AOAM530k4IVMFaQTNY/K/8/s2vTTCkQ1hj7R3nSMQNncu1UK+UQXTj5p
        zy0pX/5qoP+fKlE7It0RE1IX36Hw2fM=
X-Google-Smtp-Source: ABdhPJyA7z9h5+IAQhsSPRFd7cLnn2Nu7LuXW1aeOC6AzsEE39/TNaC55SCAhoafKKPNRiASHSeCag==
X-Received: by 2002:a17:906:2ad2:: with SMTP id m18mr48034225eje.44.1620983895235;
        Fri, 14 May 2021 02:18:15 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id rs8sm3299099ejb.17.2021.05.14.02.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 02:18:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org
Subject: Re: Rebase options via git pull
Date:   Fri, 14 May 2021 11:14:53 +0200
References: <87r1iakbyn.fsf@osv.gnss.ru> <xmqq1raabd5d.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqq1raabd5d.fsf@gitster.g>
Message-ID: <8735upsmg9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 14 2021, Junio C Hamano wrote:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Is there a way to specify additional options for "git rebase" when it's
>> invoked via:
>>
>>   git pull --rebase
>>
>> ? What if rebase is used implicitly due to "pull.rebase" being set
>> accordingly?
>>
>> In particular, I'd like to be able to:
>>
>>   git pull --rebase --no-fork-point
>>
>> but it doesn't work.
>>
>> From documentation is looks like "git pull --rebase" is still a
>> second-class citizen. There is whole section about merge options in the
>> manual, and none about rebase options.
>
> Yeah, it does feel like so.
>
> Just like we can pass merge-strategy specific options via -X<opt>=<val>,
> e.g.
>
>     $ git pull -Xsubtree=gitk git://ozlabs.org/~paulus/gitk.git
>
> to ask the command to invoke "git merge -Xsubtree=gitk" after
> fetching from the remote repository, we should allow rebase specific
> options via a similar mechanism, e.g. -Yno-fork-point=yes (or
> something along that line---exact syntax does not matter).
>
> But I do not think there currently is anything like that.

It seems much cleaner to do a bit of refactoring of their respective
parse options specs to have "pull" understand the relevant subset of
rebase or merge options depending on its mode, we do something similar
in "rebase" depending on the "rebase stage" you're in.

That has the added benefit over your suggestion of us catching any error
in the passed option right away, as opposed to finding you typo'd
-Xno-spork-point when we get to running "rebase".

We also probably want to lib-ify the rebase logic enough that "pull" can
run it directly without spawning another process eventually, at that
point borrowing this "pass arg as-is to the driver program" syntax would
become even weirder.
