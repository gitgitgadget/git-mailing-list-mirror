Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E9AC433EF
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 07:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbiDGHai (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 03:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiDGHah (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 03:30:37 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4364FC57
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 00:28:37 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id p15so8956447ejc.7
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 00:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=BMMahf2HCu8DpXUAG0ZrO1HTBCHSqEUYvG6EHCeyfMQ=;
        b=FA2KmWqDKhc6+jQ2kAPD+HzfE8q2IgmmMSvYJm2lekN/FkXSsqxbY8UOZeGMGqYs7S
         oOj42IjSXSuu3T3OP/xCXlFB7kTzWLb/vTPmr1ubkf9oOlz/Eq+aI5tx2JwqeJmpxgCS
         N5KU1KIwhsqaUOCIsz6PzTs42x6wgsJJ3oC13Ic7uYMpKYaSBY18HF/MaFjDVYScccFN
         9/7wlDcG1sm9GReDVtb/jjxw5svyFuL2+GAOXyPnDnog+X6Sfdr7uSexTZJzeKyFbpbT
         MFZTD+xEG6bg+0BvEh2wfK5QHhL1/p+s2k5wa0fPgP9P+f2ogPqk+3eR9gl+veOzQzOT
         XFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=BMMahf2HCu8DpXUAG0ZrO1HTBCHSqEUYvG6EHCeyfMQ=;
        b=jRccwHVK0kbCYpK7pwvX2sTufS5cZGDIZZlilRxF62zRUDQ9A+HgbN2SPL3bu0+5ng
         LMg1EKTl4nWf9+JTH7UH4kG3DC/VNHn8ImfafDN+A2/Z+1i5sDWVLXPXoA12Fj/rUPWF
         NEqkteAhwQwFomze6J8aYJv789mNuGjDRPr9UWAcKnhMto9j/31Ttw3BvN2j7Dbd5nmc
         8xUPlvVn6MQLyWoM++0seH3hqNXM0WIJX2qrJL6dqQ63+PvNAIfH8VjOTjNLlY6gdgUC
         DeMg7PlzbTL8k1ZJFc2/i0NBk9eeKE2VavIjQUlR8D6JLR0CR7BLnU2bbH9yl5J6yEEq
         Ne+w==
X-Gm-Message-State: AOAM5332ExwpSabJKhquN8Dmv2MCub80/iXcpagsY5FvfmkK5wTIkNbC
        akSdGaXiMVDcuVNBOfgQPvg=
X-Google-Smtp-Source: ABdhPJyOhJ62USCjWuM258vOTCEkjhlKPSYVuHfX6k0gjV5N2wquI3rZS2EXrCYZcU9fkN9lGpWCgQ==
X-Received: by 2002:a17:906:dc8d:b0:6db:572b:df24 with SMTP id cs13-20020a170906dc8d00b006db572bdf24mr12088073ejc.193.1649316516201;
        Thu, 07 Apr 2022 00:28:36 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e19-20020a056402105300b004162d0b4cbbsm8815416edu.93.2022.04.07.00.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 00:28:35 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ncMZG-000mEP-Vl;
        Thu, 07 Apr 2022 09:28:34 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Johannes.Schindelin@gmx.de, congdanhqx@gmail.com,
        dyroneteng@gmail.com, martin.agren@gmail.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com, Fabian Stelzer <fs@gigacodes.de>,
        Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [PATCH v2] ls-tree: fix --long implying -r regression in
 9c4d58ff2c3
Date:   Thu, 07 Apr 2022 09:14:40 +0200
References: <9ce4dadf140204e934f7025bb91385c376118940.1649111831.git.steadmon@google.com>
 <patch-v2-1.1-ed83b3b74ab-20220404T234507Z-avarab@gmail.com>
 <xmqqwng2xfi8.fsf@gitster.g> <220406.8635iqdjzl.gmgdl@evledraar.gmail.com>
 <xmqq4k35x4m6.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq4k35x4m6.fsf@gitster.g>
Message-ID: <220407.86y20hcpy5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 06 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>>> +	cat >expect &&
>>>> +	cat <&6 >expect.-d &&
>>>> +	cat <&7 >expect.-r &&
>>>> +	cat <&8 >expect.-t &&
>>>
>>> Let's not go too cute like this.  This forces the caller to remember
>>> which among 6, 7, and 8 corresponds to which option.  It is too ugly
>>> to live.
>>
>> I think it's rather elegant actually, but to be fair it would, per:
>>
>> 	git grep '<&[1-9]| [1-9]<<-'
>>
>> Be the user with the most FD's using this sort of pattern.
>
> Please give a clear explanation why "-d" has to be 6, "-r" 7 and
> "-t" 8, that can be used by developers as a memory aid to help them
> write new tests using the helper.

It's documented when test-lib.sh does the redirection, since Fabian
Stelzer's a6714088e0c (test-lib: make BAIL_OUT() work in tests and
prereq, 2021-12-01).

I guess a bit of archane knowledge not documented there is that FD #5 is
used for the test-lib.sh itself, e.g. BUG(), so if you want that to work
properly you can't touch it.

But everything as of #6 is generally fair game, secondary helpers like
"test_pause" won't work properly, but as far as the test framork is
concerned 6-9 is good.

So I don't really have a better explanation the same on as why pick "int
i" rather than "int x", it's just the prevailing pattern.

> Or justify why the developers have to memorize such a meaningless
> correspondence, if there is no any good reason.

Explained above, I think.

> Alternatively, you can stop abusing the word "elegant".  It is not a
> synonym to "what I wrote" ;-).

The "elegant" part is getting away with passing structured data into a
shell function, which it's generally resistant to.

As much as I'd like to take credit from it I just picked it up from code
Ilya wrote in 0445e6f0a12 (test-lib: '--run' to run only specific tests,
2014-04-30). I didn't know about it before then.

In any case, you merged down Josh's version without these tests for rc1,
so I'm assuming that's a "no" to the upthread "if you'd like to pick
this up with the version with the tests at all" in the context of the RC
period.

So I think we can table this for now, or would you like a version of
this without (a)use of these file descriptors to pass in arguments?
