Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EFCC433B4
	for <git@archiver.kernel.org>; Sat, 15 May 2021 07:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80734613F1
	for <git@archiver.kernel.org>; Sat, 15 May 2021 07:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbhEOHlA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 03:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhEOHk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 03:40:59 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B511DC06174A
        for <git@vger.kernel.org>; Sat, 15 May 2021 00:39:46 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id f12so1164471ljp.2
        for <git@vger.kernel.org>; Sat, 15 May 2021 00:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=FZYvzuUf34v80WGDxaxPGU4JJEC9TvMzMVPRKw5WO6A=;
        b=bNb0RPdgcXm0BrgOJDk3PCMGOi/PsxK/ivpeEDjF+kjHMKo4Va1ivfxPlm3XaIKmkJ
         7jV6FtoC0g+D/iEk8vPOIXBQTZWwXjDD3t1Fx50eXI9Py6MEZS7KsG2cjCirKIMvJnFX
         r41OBZmdCW3A8jdIy4zFP/cEvqya6DXl/TzbbAW5SUVl6dZc3+A8yFRA62RXrBl9Amx1
         jbXz0DJHqH8rX/snby4A3o2cicAucYPYXPCIt8rx8NYo24ctyIUQSlk9c05Pk3wL68A9
         u/M5zE9/PB3B6fU6SDJB08huV6ZgSxUnMa11X+pNqPY+I8Vtydv9pafvdAIcjLpvEXfA
         MnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=FZYvzuUf34v80WGDxaxPGU4JJEC9TvMzMVPRKw5WO6A=;
        b=pPL1bkl/SCuJ59T6jGmP/+hk93vtO2crXqe0/7qPe+m66zxVULD8DTb9LQ/jfenTyg
         aztA0zSyntzEFrndAfODn8Hev3oXwADOlcNZV8Yv1dHUjyj9Xk9uyddwvtSQ948PWQtK
         I1TYHCOUOPUO2ULPI8vHBPMQW66D1UZbxKw4oydXQg6sLJrvk4idb87nd0MsjzDd9dFT
         0eCCy0ojPnfK347l7Ql6KUQV+XepcmgGHJsnYEwWMa3U2QDKiOv1nYjab+6nQj9HlZyT
         kN1u3F319ABrYeA+lseh3seposTKpYXC3n0utzu7q3Jidy1RIqd77b2aH/0Y4hIizB/h
         ITIg==
X-Gm-Message-State: AOAM530XW/M6eR01Ck2/VnEKrtLzp0+YCjnwL6YXGWWpAo5WzgMGVTYI
        AqKFrUMbR7wvaGYXma208yWa0eeVZpo=
X-Google-Smtp-Source: ABdhPJzOJlwW6coQ0/011v79bDYKtzJAc+5/E5Hlbf8iHpAbtYaZOyyl0dTeZGGk3hDxSAfvzZ+Lfw==
X-Received: by 2002:a2e:99cd:: with SMTP id l13mr20211992ljj.89.1621064384368;
        Sat, 15 May 2021 00:39:44 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id o5sm1821576ljj.103.2021.05.15.00.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 00:39:43 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Rebase options via git pull
References: <87r1iakbyn.fsf@osv.gnss.ru> <xmqq1raabd5d.fsf@gitster.g>
        <8735upsmg9.fsf@evledraar.gmail.com>
Date:   Sat, 15 May 2021 10:39:43 +0300
In-Reply-To: <8735upsmg9.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 14 May 2021 11:14:53 +0200")
Message-ID: <87r1i8fnsw.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Fri, May 14 2021, Junio C Hamano wrote:
>
>> Sergey Organov <sorganov@gmail.com> writes:
>>
>>> Is there a way to specify additional options for "git rebase" when it's
>>> invoked via:
>>>
>>>   git pull --rebase
>>>
>>> ? What if rebase is used implicitly due to "pull.rebase" being set
>>> accordingly?
>>>
>>> In particular, I'd like to be able to:
>>>
>>>   git pull --rebase --no-fork-point
>>>
>>> but it doesn't work.
>>>
>>> From documentation is looks like "git pull --rebase" is still a
>>> second-class citizen. There is whole section about merge options in the
>>> manual, and none about rebase options.
>>
>> Yeah, it does feel like so.
>>
>> Just like we can pass merge-strategy specific options via -X<opt>=<val>,
>> e.g.
>>
>>     $ git pull -Xsubtree=gitk git://ozlabs.org/~paulus/gitk.git
>>
>> to ask the command to invoke "git merge -Xsubtree=gitk" after
>> fetching from the remote repository, we should allow rebase specific
>> options via a similar mechanism, e.g. -Yno-fork-point=yes (or
>> something along that line---exact syntax does not matter).
>>
>> But I do not think there currently is anything like that.
>
> It seems much cleaner to do a bit of refactoring of their respective
> parse options specs to have "pull" understand the relevant subset of
> rebase or merge options depending on its mode, we do something similar
> in "rebase" depending on the "rebase stage" you're in.
>
> That has the added benefit over your suggestion of us catching any error
> in the passed option right away, as opposed to finding you typo'd
> -Xno-spork-point when we get to running "rebase".
>
> We also probably want to lib-ify the rebase logic enough that "pull" can
> run it directly without spawning another process eventually, at that
> point borrowing this "pass arg as-is to the driver program" syntax would
> become even weirder.

This sounds much better indeed!

To add to the issue, there has always been confusion that in case of
conflicts one should either do:

   git merge --continue

or:

  git rebase --continue

depending on current configuration. So

  git pull --continue

would be much appreciated, I think.

Thanks,
Sergey Organov
