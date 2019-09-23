Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D0241F463
	for <e@80x24.org>; Mon, 23 Sep 2019 18:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfIWSnX (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 14:43:23 -0400
Received: from mout.web.de ([212.227.15.4]:41629 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbfIWSnW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 14:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569264196;
        bh=CyCBtteJ9Jw+HmhAZGGxwjbs8wpqWeP+25I2SV7exDE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VyV7T7ER8P0DI1pDdYuYSii75xSDfJ8YDwFyWVGHo59m8y1Vvewj/z28iP/S6LkJN
         h5oDPZu9xmmFB319WQUhTQpEBpR814QNSY0fQFDRxJorehUQzKuiPRgoVe2KOlmwBx
         VaWCRiKBp4jWXANppTA52eCT5ZJvwwWr0NRe0xxo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.71]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MhfoB-1iYnNn0RWd-00MuWb; Mon, 23
 Sep 2019 20:43:16 +0200
Subject: Re: [PATCH 08/15] name-rev: pull out deref handling from the
 recursion
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20190919214712.7348-9-szeder.dev@gmail.com>
 <5bf3b958-8c95-ae3d-1ae5-df3d57272d8c@web.de>
 <20190920181302.GA26402@szeder.dev> <20190920181407.GB26402@szeder.dev>
 <20190921095718.GA23203@szeder.dev>
 <a507bbd1-88cf-6668-908e-92978fb77930@web.de>
 <20190922190511.GB10866@szeder.dev>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <822d19dc-5202-b67f-5c0c-e5c69a679237@web.de>
Date:   Mon, 23 Sep 2019 20:43:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190922190511.GB10866@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DzVAYRwPOLrdAiI0MOoBxqqs8RlCeyYS9sSlSji1lAjgoW0F0wU
 H1rTS/YltGqd9HqUwNWYDHcfpndsbI3+Ghd76HAfSUtXuWHJWlOzk2fQxNt7UK70vro0J8U
 Rg+dK0lhGKUfgVw4nS2hHrKhRJKP1HakQTfwkaNe+PZBD8AbnMnhD45Lz6cZxXvDho4mIIh
 xHanjdqIMnRu7wwo/094A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eK+2eMIl1No=:6KDGqiAg/L2lSG83ijkFcO
 YtmhMIE4sf7Ql4aegkkcsu/W570Lqu9NoLstqv/yCQovahS+cnemKNrVm26fWdu1VzTrCUcw0
 1b0c1se3x/G0Av0cXfudWOR9cwkvUqm8RcozTpCDX+6mCxcOEOHES6JX0zAbShdrqChGKCQ0E
 KpCTng+r3JafhSKyxNEByyxBDnPtDmzRrXR7eSM+3++rNimtbXGkYfo6INpXdZKeOpORAib4k
 hGoXsv/TNvx70iOUFChq0bwH5WizpluwwMFTMvnc6Nxy0UQa7Wg3GDMkSz5Ew81ayKWbwyRYa
 Y4V5/JqDU78n03MCXJmZwmqUVSiy8B+6XLyRszK28RLKs5prxeD2w0BH1ypAufpZBNVuOluZi
 nmTXX8GA6GTnvOp90WLBhof+pGRemLv34+Vp8Gh1hVfSZPZfblylrvhmHyXHBRhTUFcFZhezS
 22i5ghbnf96BKKHcZZxZ/X6LAfxhy+0VsAo08kvrRABNtnWuFlepkj7lfvwmO9UKaLQrtGI/5
 1XIClmLOcD/Av7XVFpxlemY3bnh6BVxNET9fZNynqxNhB7Rrye4idhhYDd7OXJYwfSF3wA8RC
 PFIOzowZWb2Nem1gn5SnHEaminFSCaXZSIfFsCETUA/QjcwFNLAQUuI8xa3Kr5bCengyg9Bho
 rBwW/j5XOKywp2TzLTQoYOe+hGhnbLHOOmZwI9lFaqkw5t8QBpknghESjgZ9fogJetJlErAvc
 ybDr9IEtavMPvlFLHHsNDcjCYWKjNh9O3vqcSKfOkI/N4/+7Ac6WaMwovMaDJnnYeRjUb77Qq
 pqyZLX3TWwsmztRXIbtiCgoJUPJ/E8oB7quJGJWU4YVBaTIRwFk2mPIrJ4SbLYnPOLZn7M7Iw
 CMUtwm5KdAjll/89hjZHs0Bo+DaeM1HAT/F0CmeE2Jz0ViXTOVV6jZNqhth4AoWw7yOoV7eop
 Q9DyOYqsfC6lcO4rD6gSaegvlwq72ntUoc2TW4Lj9iE7qNhIKYheG7De9d7gyTc/kIrkpLKNX
 qSsGZW8VegBkkPsZ89o07E4j6IvJNRtsTckLPfNuUjEV9AtmIFsw7LIYhnd+emsXFSsZ449jF
 C+EvE3mGeRDzL5eooeHBPv+Cd9auvZ59WGMbYvpdVpmWmb8ZvQ5pp5pqEMnSTPv5aduZVzrVX
 5h5wRzYRxW8Ms0670EmMXfuSBFZxaD12bZikwfD2FfAUJqOBFpWJ56QsoXmb8Vo+PnQ8ksa2+
 AaU1O5Qx+fTZRFy69p9vtI2L53g/EATnIXWU5XQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.09.19 um 21:05 schrieb SZEDER G=C3=A1bor:
> On Sat, Sep 21, 2019 at 02:37:18PM +0200, Ren=C3=A9 Scharfe wrote:
>> Am 21.09.19 um 11:57 schrieb SZEDER G=C3=A1bor:
>>> On Fri, Sep 20, 2019 at 08:14:07PM +0200, SZEDER G=C3=A1bor wrote:
>>>> On Fri, Sep 20, 2019 at 08:13:02PM +0200, SZEDER G=C3=A1bor wrote:
>>>>>> If the (re)introduced leak doesn't impact performance and memory
>>>>>> usage too much then duplicating tip_name again in name_rev() or
>>>>>> rather your new create_or_update_name() would likely make the
>>>>>> lifetimes of those string buffers easier to manage.
>>>>>
>>>>> Yeah, the easiest would be when each 'struct rev_name' in the commit
>>>>> slab would have its own 'tip_name' string, but that would result in
>>>>> a lot of duplicated strings and increased memory usage.
>>>>
>>>> I didn't measure how much more memory would be used, though.
>>>
>>> So, I tried the patch below to give each 'struct rev_name' instance
>>> its own copy of 'tip_name', and the memory usage of 'git name-rev
>>> --all' usually increased.
>>>
>>> The increase depends on how many merges and how many refs there are
>>> compared to the number of commits: the fewer merges and refs, the
>>> higher the more the memory usage increased:
>>>
>>>   linux:         +4.8%
>>>   gcc:           +7.2%
>>>   gecko-dev:     +9.2%
>>>   webkit:       +12.4%
>>>   llvm-project: +19.0%
>>
>> Is that the overall memory usage or just for struct rev_name instances
>> and tip_name strings?
>
> It's overall memory usage, the avarage of five runs of:
>
>   /usr/bin/time --format=3D'%M' ~/src/git/git name-rev --all
>
>> And how much is that in absolute terms?
>
> git:     29801 ->  28514
> linux:  317018 -> 332218
> gcc:    106462 -> 114140
> gecko:  315448 -> 344486
> webkit:  55847 ->  62780
> llvm:   112867 -> 134384

I only have the first two handy, and I get numbers like this with
master:

git, lots of branches with long names: 3075476
git, local clone, single branch:       1349016
linux, single branch:                  1520468

O_o

>> (Perhaps
>> it's worth it to get the memory ownership question off the table at
>> least during the transformation to iterative processing.)
>
> I looked into it only because I got curious, but other than that I
> will definitely play the "beyond the scope of this patch series" card
> :)

Fair enough.

>> I wonder why regular commits even need a struct name_rev.  Shouldn't
>> only tips and roots need ones?  And perhaps merges and occasional
>> regular "checkpoint" commits, to avoid too many duplicate traversals.
>
> The 'struct rev_name' holds all info that's necessary to determine the
> commit's name.  It seems to be much simpler to just attach one to each
> commit and then retrieve it from the commit slab when printing the
> name of the commit than to come up with an algorithm where only a
> sleect set of commits get a 'struct rev_name', including how to access
> those when naming a commit that doesn't have one.

Sure, the lookup of individual commits is much easier once all commits
have name tags attached.  Preparing that sounds expensive, though.
It's a trade-off favoring looking up lots of names per program run.

>>>  --- >8 ---
>>>
>>> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
>>> index 6969af76c4..62ab78242b 100644
>>> --- a/builtin/name-rev.c
>>> +++ b/builtin/name-rev.c
>>> @@ -88,6 +88,7 @@ static struct rev_name *create_or_update_name(struct=
 commit *commit,
>>>  		set_commit_rev_name(commit, name);
>>>  		goto copy_data;
>>>  	} else if (is_better_name(name, taggerdate, distance, from_tag)) {
>>> +		free((char*) name->tip_name);
>>>  copy_data:
>>>  		name->tip_name =3D tip_name;
>>
>> I would have expected a xstrdup() call here.
>
> But then we'd needed to release the results of all those xstrfmt()
> calls at the callsites of create_or_update_name(), so instead of those
> strdup() calls that you deem unnecessary we would need additional
> free() calls.

Correct.  That would be simpler and shouldn't affect peak memory
usage.

Ren=C3=A9
