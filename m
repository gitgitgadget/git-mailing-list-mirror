Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788DEC433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 04:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356854AbiBDEXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 23:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiBDEXL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 23:23:11 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12824C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 20:23:11 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id s5so15410263ejx.2
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 20:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=DnK5IggHJbEkXtUDc3K1I2rStP1XJqdTaHxSFh5Bx/8=;
        b=lAmeaSFSeNRBlQSmlkFk4V+5jBcptcL85cB+AxkkudiF8QU6NZO3nhQXSQ8hrMJX42
         PkdHsCXeQS+HJgxNKXNHo7GxDbQPN2R34fdoRQod47uc3gmnqej3HCT96cb0XdNVWHPw
         86BKFkshSm7UcgunoUeZBJKIRg2OslM8rkRG+56KHRgAt/EVR+DaE+nv+vNWo70dA1zs
         BWpFGWPG4YxcSnSKFkHHFIfPSaHncDWufKs5zuX4fcoXA6Exw85Wj2ncoQSAHin3ERBB
         1Uk7ejB5gs5vHuGo90uTMoh8vJH5dADuBC8IrIWxCzpercde1vjBkzyFK7J6iim8SPci
         kIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=DnK5IggHJbEkXtUDc3K1I2rStP1XJqdTaHxSFh5Bx/8=;
        b=luVI2SjCWrlhVzCginupCfTr9WcjbQB+Y1XWTTjV58kOzifon88JYKNqEpgarFyYl8
         Gh/whbEofOfJ68yATwlO8jltU5DtNqSi2uRFklCoK0P4oErt8hLEZQCz1vIQaSoFo1te
         ys9f7AWmGIswmytZzIVJ36m9ZgEyzpI4jCGil5ntX4LbIszriUfv/KechJwM8xsuSgoF
         OP/yAK+m0ilC2iinUlNQpD2UnfKiIAWTIi69eTum7wl2FJaH0eUn6lpT9QhNKHH2V/5s
         EE2jfhIZ1+LNWFAyibwgh4BfGFE3ns3jYDMqt0grwLHqwpkvewehqo1qSbuKq67krf04
         2Dsg==
X-Gm-Message-State: AOAM530CuwHW3CSyUQp8mcKPW/514NzMcmYpp6UKkxLrLLBv82iKH9cm
        7E7nKbqNPpuesaTBMLCTMV4=
X-Google-Smtp-Source: ABdhPJwYCdPKElUpO/ONr2iiehTntU0esPMMhox5S+CkG8BjuyQ14x0JZyZbkYDA74E98+OrsPW+Mg==
X-Received: by 2002:a17:907:8a1b:: with SMTP id sc27mr933264ejc.300.1643948589299;
        Thu, 03 Feb 2022 20:23:09 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gu2sm235064ejb.221.2022.02.03.20.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 20:23:08 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFq7o-005n6z-5F;
        Fri, 04 Feb 2022 05:23:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Lessley Dennington <lessleydennington@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com,
        johannes.schindelin@gmail.com, Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v5 0/3] completion: sparse-checkout updates
Date:   Fri, 04 Feb 2022 05:21:26 +0100
References: <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com>
 <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com>
 <xmqqo83nr59i.fsf@gitster.g>
 <7033ab1b-7d90-d83c-fc65-33801c6348cc@gmail.com>
 <xmqqy22rpm10.fsf@gitster.g>
 <eb442213-d369-fdcd-c3a3-05239bccb5bf@gmail.com>
 <cb6f65b5-4e02-08af-bea6-141fb6227927@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <cb6f65b5-4e02-08af-bea6-141fb6227927@gmail.com>
Message-ID: <220204.86leyr45w3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 03 2022, Lessley Dennington wrote:

> On 2/3/22 3:59 PM, Lessley Dennington wrote:
>>=20
>> On 2/3/22 3:28 PM, Junio C Hamano wrote:
>>> Lessley Dennington <lessleydennington@gmail.com> writes:
>>>
>>>> On 2/3/22 1:48 PM, Junio C Hamano wrote:
>>>>> "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
>>>>> writes:
>>>>>
>>>>>> This series is based on en/sparse-checkout-set.
>>>>> This has been a very helpful note, but after the topic was merged to
>>>>> 'master' on Jan 3rd, it has become a tad stale.=C2=A0 Let me apply the
>>>>> topic directly on v2.35.0 instead.
>>>>> Thanks.
>>>>
>>>> Thank you for the heads up! I will remove from future versions.
>>>
>>> No problem.
>>>
>>> FWIW, the tip of 'seen' seems to be failing the CI; I haven't looked
>>> into the cause of the breakage.
>>>
>>> =C2=A0=C2=A0 https://github.com/git/git/actions/runs/1792151138
>>>
>>> There is another CI job running on 'seen', whose only difference from
>>> the above version is that this topic has been temporarily ejected:
>>>
>>> =C2=A0=C2=A0 https://github.com/git/git/actions/runs/1792296432
>>>
>>> We'll see if that fails the same way (in which this topic may not
>>> have anything to do with the breakage) or if it passes.
>>>
>>> Thanks.
>> I just merged seen locally and was able to repro the failure. I will
>> submit a fix ASAP.
>
> GitGitGadget CI has passed with the fix, but it is not responding to the
> /submit command. As a heads up, fix may not be submitted until folks who
> are a bit more knowledgeable about GGG than I are available to help
> troubleshoot.

Just an FYI: If you're blocked on GGG it takes 1 minute to click through
to generate an app password for your GMail account.

Then you can use it with git-send-email with config like e.g. this one
I've got:
=20=20=20=20
    $ git config -l|grep -F sendemail.|perl -pe 's/pass=3D\K.*/WORD/g'
    sendemail.smtpserver=3Dsmtp.gmail.com
    sendemail.smtpencryption=3Dssl
    sendemail.smtpuser=3Davarab@gmail.com
    sendemail.confirm=3Dalways
    sendemail.smtppass=3DWORD
    sendemail.xmailer=3Dtrue
    sendemail.to=3Dgit@vger.kernel.org
    sendemail.security.to=3Dgit-security@googlegroups.com
    sendemail.test.to=3Davarab@gmail.com

Then you can submit your patches with git-format-patch + git-send-email.
