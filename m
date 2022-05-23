Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECC1C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 18:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiEWSas (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 14:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243261AbiEWSaN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 14:30:13 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5B0149A82
        for <git@vger.kernel.org>; Mon, 23 May 2022 11:05:00 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id wh22so30353502ejb.7
        for <git@vger.kernel.org>; Mon, 23 May 2022 11:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=lV7hZIG3ZlSEiJYbbuitHaTvSPiQXtRRZfYFDww3ckU=;
        b=HvAk4vznZv3LWKcGyxQiSKkwCpUqUWViCRvfU2cGTO64stpq3yFGa2P4Nm/r9Q8oq3
         LtPNx8YRhTxlX2mxXmgcNvx+e6KvVHhc5qcMEY9XOqhRP3r+OFb0pwxC3ff6jSjbab9X
         o5L0Vvfc5EvfYm33AFKcC6Y8cFCBz9eoFzMaB2DU5Itj5l2nywIxxuY8Saeh8BwOkv2I
         PBOsotnjvDMl7DkB99kIAxaPq3joLedl61hLUIfSkrwTOcP7obcVo5DaJWl6grPODvng
         L2AN1KA+UAiXHiZaN61vO1fV8eVSFfF7FYr45uHGyzDQLksrWjAzEY6L/tgusVPuPPW/
         lVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=lV7hZIG3ZlSEiJYbbuitHaTvSPiQXtRRZfYFDww3ckU=;
        b=drRv9Dw7zs6WdnpYQwfJu5ThO+kkTunV0ZRN/AbpDPMdvbw4L+ytIwb7AB4lUlCSIz
         SngQWSeB6noGr3LsCiCycg+kuBB1dJ0aPWVORzsURfWvbcbKCbNp38DFoV0JKK+g9Z37
         pZD1FBBI5BZHTa4WCeqfeNgATkGhLVUDjUee6ycAB12raTi0lWEkBdwGdK69rmYCxbm6
         yxwbiY094xQqb5ibqnwq2SlHdSoICEru1t64Ez2P3suM3NVPY0giT4iuEAUrp1go7VLS
         +p0x9A62gCDKpq2ZcqKA4iEF9ujABH+902fYRG55Xymv4sSh4UToVX55Cczq45cWd63e
         dz5g==
X-Gm-Message-State: AOAM532J35I2udl8Ep6GLJgbB+KYSrltZVQDa1SqzqIsLvz+5TC5G45P
        5xTLnFZEy2RYRmlf89LIpeM=
X-Google-Smtp-Source: ABdhPJxGYlN8SqdXgWOJU8GuomY2KevYxQML03o5SDKcmh5IG5FOEexTNbV999PPoqVmIyKYU+of8w==
X-Received: by 2002:a17:907:3f89:b0:6fe:e7a7:c038 with SMTP id hr9-20020a1709073f8900b006fee7a7c038mr4943906ejc.730.1653329085966;
        Mon, 23 May 2022 11:04:45 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id f26-20020a50fe1a000000b0042617ba63c9sm8701320edt.83.2022.05.23.11.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 11:04:44 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ntCQ7-0030vS-KE;
        Mon, 23 May 2022 20:04:43 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Hrushikesh Rao <hrushikesh20thegreat@gmail.com>,
        git@vger.kernel.org
Subject: Re: Git commands version documentation
Date:   Mon, 23 May 2022 20:01:48 +0200
References: <ccb312dc-c2cc-ca3a-e659-0f87ceec0d15@gmail.com>
        <f3814646-4763-62e1-b64e-d1aab3fdbbc8@iee.email>
        <xmqqr14l87jp.fsf@gitster.g>
        <3067d8e3-15a7-75fc-20d7-90de0fc3fee6@iee.email>
        <220523.861qwkz8kp.gmgdl@evledraar.gmail.com>
        <96cd59ea-ea75-e33e-758f-abe16f9cca0f@iee.email>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <96cd59ea-ea75-e33e-758f-abe16f9cca0f@iee.email>
Message-ID: <220523.86o7zoxgzo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 23 2022, Philip Oakley wrote:

> Hi =C3=86var
>
> On 23/05/2022 14:08, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Mon, May 23 2022, Philip Oakley wrote:
>>
>>> Hi Junio,
>>>
>>> On 23/05/2022 00:35, Junio C Hamano wrote:
>>>> Philip Oakley <philipoakley@iee.email> writes:
>>>>
>>>>> One manual method is to look at the history (blame) for the respective
>>>>> man pages to see when the man page was initially committed, and when
>>>>> appropriate options were added.
>>>>>
>>>>> Maybe use one of the hosting providers GUI if that is your choice e.g.
>>>>> https://github.com/git/git/blame/master/Documentation/git-gc.txt
>>>> I got an impression that blame/log is an overkill for the request,
>>>> which asks for "what tagged version?", to which the answer would be
>>>> to compare the manual pages for each release (or scan the release
>>>> notes), perhaps?
>>>>
>>>>
>>> I was also concerned as to which way the problem was being addressed:
>>> was it a need for a cross reference table for all commands, or was it=20
>>> for just a select few?
>>>
>>> For me, who likes a good UI, I found the GitHub blame UI quite useful
>>> when looking at files from the latter direction. It was much easier to=
=20
>>> scan the blame for the command's documentation page than try and scan
>>> through the endless release notes. Obviously this does expect that our=
=20
>>> documentation is fairly complete, at least at the 'mention an option'
>>> level, even if the occasional nuance didn't reach the docs.
>>>
>>>
>>> I can see that a cli terminal representation is likely to be harder to
>>> scan, and that some hosters don't provide a blame page, so it would be
>>> a 'horses for courses' choice.
>> I think asking a git user to use "git blame" on our own source code is a
>> non-starter in terms of where we'd like to eventually get.=20
>
> "we?"

We as a project.

>> E.g. we could carry a text file in our sources with a list of what
>> commands existed at what versions, and what options they had (as
>> extracted from the parse-options reflection mechanism). Rather than
>> manually maintain such a list we could carry a script to that would
>> attempt to build past releases, for any that were missing we'd attempt
>> to build them and fill in the gaps.
>
> Implicit in this is the choice between parsing the code, or the
> documentation, to determine when options started appearing.

By "extracted from the parse-options reflection" I mean that you could
script this around the same facility we use to dump what options we
support for the bash completion.

See parse-options.c, all users of the API support a hidden option to
dump their supported options, and likewise git.c can dump built-ins and
other known lists of commands.

So in theory this sort of thing should be a relativel simple for-loop
that builds our release tags, for each successful builds lists the
built-ins, and for each of those lists the options.

The options being a bonus, it would already be useful if it just did
command.

> In some ways it sounds very similar to the i18n efforts where the
> 'database' grows with every release. Though capturing the historic
> release progression is probably the hardest part.

As long as we can still build that release it should be pretty easy...

