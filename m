Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E842BC432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 10:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E5920836
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 10:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYm4Gulc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfKYKrc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 05:47:32 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44062 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbfKYKrb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 05:47:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so17325819wrn.11
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 02:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L88pTEcNna9G+rHikBKqnNZYVax91W3Qq7e5WLmQs34=;
        b=gYm4GulcO9BIctB08UWz8Ce+uMv3Jd6MEGEQo3yESo9MPrS/LNUXy50VG9pjQr53QU
         l0v5hS8VideGiR76DtCFL0F6a0B+CxiBjIAvqEkMbjdLrbmAqMd4808mDTW8NurpscmK
         8oQox4+nuczKbZ8gBUuFNVixxImeZ0m6khOBRztEuargSu1NXXBs6Tp3LRA31ShTwC9J
         gaLcOjrhSWvr28Fq4nYoPZhrpsWQIV3MvkwJhrIU//MfrmkCwpykgATPI5MdvGlx4fZt
         zk392TX13cjjcZtWsdaa+ohXKhuPvqtgiG65RaZgAT2aVBS8PgQvymL6EsUa+Q7/t0Kb
         QOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=L88pTEcNna9G+rHikBKqnNZYVax91W3Qq7e5WLmQs34=;
        b=aNdAv4aP+PNU23OqcJyzi0gZrkFePWDE+oZJySy9I+Org3w/wkj+8vzfq6ekAoDevn
         ZzSHvwE65jzIGg0omT5edMg/KdHTreoIhyWsJ11NWUgAb1dexHD5T67TuY+ewa/92vHA
         AU1TdrLfQIE3rPMt1x7oz4vN1Paq/gJE4uc13jtlbZjyqOn38Wa1SyqFSTirfpGDRKlk
         b6EYkoX5s+ALWglpEKe9C5aq7w8oZdTBF7rjD57BoQdaRvgijKpq392Dvvi9NsSj3diP
         9IHdixhD6V3tDz7eWmOaWN/DM/jp92h4tm8dVP+vm+P1x85vkx/5oleJ8WN6ChEIRcX8
         qxmg==
X-Gm-Message-State: APjAAAWbukRHCVX/fcT8Odpx2UKSw50AphYwnUDHYgRDMbsbeB3oMMd3
        3JhhtAplvwVWySEdOPqsh3o=
X-Google-Smtp-Source: APXvYqzp1ljngFZfJjm1CCFr7RYzTHITiLFIJ/g7bdHan0NyExnN3sjjzE9tiyIg8b28sCzBRCGSZw==
X-Received: by 2002:adf:df8e:: with SMTP id z14mr30152842wrl.190.1574678849430;
        Mon, 25 Nov 2019 02:47:29 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-28-211.as13285.net. [92.22.28.211])
        by smtp.gmail.com with ESMTPSA id b2sm10259479wrr.76.2019.11.25.02.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 02:47:28 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer: don't re-read todo for revert and cherry-pick
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <e7c01e0f-8466-c2c5-b53a-a93f941dfb1c@gmail.com>
 <20191123172046.16359-1-szeder.dev@gmail.com>
 <xmqqk17p280y.fsf@gitster-ct.c.googlers.com>
 <8c21662f-6548-a46e-9c87-eb364355cb78@gmail.com>
 <xmqqo8x0zros.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <8881749f-195e-7f24-6f38-3b0a53ef8e1e@gmail.com>
Date:   Mon, 25 Nov 2019 10:47:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqo8x0zros.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 25/11/2019 01:10, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>>> -		} else if (check_todo && !res) {
>>>> +		} else if (is_rebase_i(opts) && check_todo && !res) {
>>>
>>> It is a bit sad that setting of check_todo is not something a single
>>> helper function can decide, so that this is_rebase_i(opts) can be
>>> taken into account when that helper function (the logical place
>>> would be do_pick_commit()) decides to set (or not set) check_todo.
>>>
>>> Unfortunately, that is not sufficient, I suspect.  Why did a47ba3c7
>>> ("rebase -i: check for updated todo after squash and reword",
>>> 2019-08-19) decide to flip check_todo on when running TODO_EXEC?
>>
>> I'm not sure what you mean by this
>>
>> This is what I had before I saw Gábor's patch (the tests are pretty
>> similar but I think we should check that the messages of all the picks
>> are actually edited with --edit - that does not seem to be checked by
>> the current tests)...
> 
> I first thought that unsetting *check_todo in do_pick_commit(), when
> !is_rebase_i(), was a clean solution.  But sadly it is *not* a godo
> equivalent to Gábor's patch, because check_todo can be set to true
> without looking at is_rebase_i() in pick_commits() [*1*]. 

That only happens if we're running a rebase as exec commands are not 
used by cherry-pick and revert so the unconditional setting that remains 
after my suggested fix should be safe. Prior to a47ba3c7 ("rebase -i: 
check for updated todo after squash and reword", 2019-08-19) we always 
checked for an updated todo list after processing an exec command 
without checking is_rebase_i()

Best Wishes

Phillip

> To ignore
> that setting where the variable's value is used, the hunk we see
> above in the beginning of this message is necessary.
> 
> That was what I meant.  I think the "This is what I had before"
> patch matches my "I first thought" version, so we were on the same
> page and both wrong ;-)
> 
> Thanks.
> 
> 
> [Footnote]
> 
> *1* I still do not know why a47ba3c7 ("rebase -i: check for updated
> todo after squash and reword", 2019-08-19) sets check_todo to true
> without looking at is_rebase_i().  If this unconditonal setting in
> TODO_EXEC did not exist, I think your "This is what I had before"
> patch would have been equivalent to Gábor's patch.

