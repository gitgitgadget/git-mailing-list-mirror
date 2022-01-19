Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F722C433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 01:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350387AbiASBCS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 20:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238548AbiASBCS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 20:02:18 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CAAC061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 17:02:17 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id b13so3575521edn.0
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 17:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=qM8IKAlNiPfCUCzdfMq8uKzB9/MIjvAUTYIHQyJ7Yyc=;
        b=hXUC5mjEOHSU8S0V7FURPUKnRRuEWzUDz8kNKM1oPcCh9PGe5c0A354nJWcawaCOKf
         6cWZSnIZtOeYQpic7cOtbPVZ4URFe3+gc00tusNEnmeho1trmftuGqR4XQGrQCt6XJk/
         q348YsOAnQH2ZKv0rY6oOqch8aCCSbjEuOJBNOd0TDZlXKjN7PcTS2d0jTYNREAjw3Tm
         tWWIK4kJeWqd/fJoX10vpuf4vU7juE5dBtEIW72EZFf8Wg05hPjFNemOGLC6qwEEKIYD
         gLMYpnZQJBomXk23xv5epo2nj5dK198AO9EEF8R+5Xp5drbkulPP+iCUeTD26Mu1cr1S
         4IUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=qM8IKAlNiPfCUCzdfMq8uKzB9/MIjvAUTYIHQyJ7Yyc=;
        b=omD2LRy/67FUoFxe2mKMIG0udGZbHcIcI3JSEcmjT/GEM1oeu+vi/ChvSd7Vo4xwe4
         y6s7TEYAmrE3psR5rD+wwC1qggGjeaJK1lo4SRae4RCF6PTGsPuyAZDFL33efnhww6N2
         zT9hEOylDyZ5/q+vgxXFewkMsHJc+S6TY67XyB1xafkqgpzV0zEu4GfZh2We6VeIAMLe
         jSjC9rfhVWm/nDZXr5qCwGKfLgDM92jzNdzM2EXnAa+WLL+ydiRYX0PMVGKClN+m++Fm
         g+XCW3cJe2h3ccsBaoPWQa0UUQoUPN3kjUQ2hDQDxzgus4202XtMZgsY2yeUNzDHe73F
         ivEw==
X-Gm-Message-State: AOAM532zqr+oSTX4BBu75yqEUfxODswXqmdhMpO1ZWFlEhblAIEp+40p
        4IzuTAK1sV/5bDYB5l9Et/0=
X-Google-Smtp-Source: ABdhPJw9oiiYMYEiP1LDW4vYlaftZ1oHD0+QYoEcCSw144x8djrbfS2OEY3T0+OKQDMVTdoROLs9wA==
X-Received: by 2002:a05:6402:50c6:: with SMTP id h6mr28513975edb.156.1642554135948;
        Tue, 18 Jan 2022 17:02:15 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gn36sm5816944ejc.29.2022.01.18.17.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 17:02:15 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n9zMc-001hbo-O0;
        Wed, 19 Jan 2022 02:02:14 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/13] init: unconditionally create the "info" directory
Date:   Wed, 19 Jan 2022 02:00:56 +0100
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
 <patch-03.13-784b7947512-20211212T201308Z-avarab@gmail.com>
 <db6f47a3-0df3-505b-b391-6ca289fd61b5@gmail.com>
 <211220.86tuf3utv9.gmgdl@evledraar.gmail.com>
 <d2399072-ce9d-b654-42b4-d08d973c488e@gmail.com>
 <220112.86a6g1xgyl.gmgdl@evledraar.gmail.com>
 <102cc731-99ec-57b0-91de-23d5569fd959@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <102cc731-99ec-57b0-91de-23d5569fd959@gmail.com>
Message-ID: <220119.86k0ewo7vt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 18 2022, Derrick Stolee wrote:

> On 1/12/2022 7:42 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Mon, Dec 20 2021, Derrick Stolee wrote:
>>=20
>>> On 12/20/2021 11:13 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>>
>>>> On Mon, Dec 20 2021, Derrick Stolee wrote:
>>>>
>>>>> On 12/12/2021 3:13 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>>>> But we've also grown a hard dependency on this directory within git
>>>>>> itself. Since 94c0956b609 (sparse-checkout: create builtin with 'lis=
t'
>>>>>> subcommand, 2019-11-21) released with v2.25.0 the "git
>>>>>> sparse-checkout" command has wanted to add exclusions to
>>>>>> "info/sparse-checkout". It didn't check or create the leading
>>>>>> directory, so if it's omitted the command will die.
>>>>>
>>>>>> Even if that behavior were fixed we'd be left with older versions of
>>>>>> "git" dying if that was attempted if they used a repository
>>>>>> initialized without a template.
>>>>>
>>>>> This, I don't understand. Why can't we add a
>>>>> safe_create_leading_directories() to any place where we try to
>>>>> create a sparse-checkout file?
>>>>>
>>>>> This would fix situations where older versions were init'd with a
>>>>> different template or if the user deleted the info dir. The change
>>>>> you've made here doesn't fix those cases, which is what you are
>>>>> claiming is the reason to not do the other fix that seems like it
>>>>> would.
>>>>>
>>>>> What am I misunderstanding here?
>>>>
>>>> I'll clarify that a bit in any re-roll.
>>>>
>>>> Pedantically nothing changes, i.e. you can create a repository with an
>>>> empty template now, and it'll break on both the sparse-checkout on that
>>>> version, and any previous version that had that un-noticed issue.
>>>
>>> You continue after this with more motivations for adding 'init'=20
>>> unconditionally, which I am not fighting.
>>>
>>> What I _am_ saying is important is that if we are trying to write
>>> a file to a known location and its parent directory doesn't exist,
>>> then we should create it. Not doing so is a bug and should be
>>> fixed, no matter how rare such a thing is to occur. As you've
>>> shown, it is not required to have an info directory until we need
>>> one (e.g. for sparse-checkout or an excludes file).
>>>
>>> If you're not planning to add that to this series, then I'll add it
>>> to my list. I do think it would fit well into this one, though.
>>=20
>> Just so we'll avoid stepping on each other's toes, what's the status of
>> your plan/non-plan to work on that more isolated fix, perhaps you have
>> one that's unsubmitted?
>
> I do not have one that is unsubmitted. I was hoping that you would
> include it in a v2 to this series. I might have been quicker to
> volunteer to create one had I not been sidelined for two weeks, but
> right now I have a lot to catch up on so don't have the time.

Good to hear that you're better (or back?, not 100% sure what
"sidelined" here means).

I'll try to get to re-rolling it with a fix for that sparse-checkout
issue, hopefully sooner than later. Just wanted to avoid potential
duplicate work.

Thanks.


