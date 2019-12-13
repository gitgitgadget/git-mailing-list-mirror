Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF1BC80D5A
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE502480B
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u9Jbpjcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfLMTmq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 14:42:46 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38390 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbfLMTmq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 14:42:46 -0500
Received: by mail-qk1-f195.google.com with SMTP id k6so178495qki.5
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 11:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=9VbtAiSsmE/Yx5ZOk6kgAs9cdfDiJWdv2JAdAssP8us=;
        b=u9JbpjcdH16RBrW+yJn7KbsvwQRFlgReA8SYBJD2BqteVHE3qE1HNNzJ2mCETuQuw1
         k4jIj53bERRmK6ZqYAZi3fbMa8UShWi56HBFp9jlivIOFbL2AN8C9bhZYiNX53YgHhlF
         XMihuKY5DdNeLN2x85qaTdYBV1q/5Di2Rb9Qbi7ZyfDYiJnr+UfvAF58hhNGI2InXJuA
         D0Jx3a/yuYoEfJ89Cc7bIcCn9Cz/7yigu/Z/HzEoZkSUz+7/27FOlpkEQP11qh+OY3Mr
         Jj71QbsP1JbF2ZgepRgYAyAPF0qkKRlH+a63oGXDoAUN7z0XzZtzdbQ3T09yiADsmgqw
         Tqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9VbtAiSsmE/Yx5ZOk6kgAs9cdfDiJWdv2JAdAssP8us=;
        b=uG+fTIsh4OQ3Uo3eqFellWuvfuNfkBB3qK3CpMBk/XuqM0B0NWNe8M43EMS2CSvyLK
         IQhx7pR8sJ0kTtyLH2y7wSui7FuiTB7uHQF2rSWtk02f653uhdO4VBw8YAIoqHvU1xCr
         lQ7PsRFp/W/et53zJcjmkzzCa17SmX6xvqD5mEo/OFwd4EbdL7nqgC2PXETGp0wtPGBN
         W4mgWeKFmBvGpibiPhpWEhCgAcYzjzNIqqx58v4xcaVfMS6YBmhYdLAvvRZ82Ouw3BpM
         wG0kJG7uqquCsnQvjnzPzUQLj2NYSSde7vMRVaMjOwUD0H7a40TLGTr1CZSYakBIbxmz
         H03Q==
X-Gm-Message-State: APjAAAVPWfJ0eQaCrp37ccWDrqTqNTD6DQxaRoGe6nOw2cCQRKZ4ABNM
        kFNBKw+Q3B2eeZzopYb331Fit2Umujc=
X-Google-Smtp-Source: APXvYqwxPi9f0YgJEK4+BwljKLWybkMmuxdjtxD5jW4CNDxtGFjlESqIMrYTcvzFOjdBactSDt3uqA==
X-Received: by 2002:a05:620a:16ad:: with SMTP id s13mr15182065qkj.388.1576266165374;
        Fri, 13 Dec 2019 11:42:45 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id i14sm2206186qkl.133.2019.12.13.11.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 11:42:44 -0800 (PST)
Subject: Re: [PATCH v5 00/15] git-p4.py: Cast byte strings to unicode strings
 in python3 - Code Review
From:   Ben Keene <seraphire@gmail.com>
To:     Yang Zhao <yang.zhao@skyboxlabs.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Luke Diamand <luke@diamand.org>, Denton Liu <liu.denton@gmail.com>,
        Jeff King <peff@peff.net>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>,
        Git Users <git@vger.kernel.org>
References: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
 <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
 <20191207194756.GA43949@coredump.intra.peff.net>
 <95ead4b6-21bb-1aa2-f16f-888e61a4e4c0@gmail.com>
 <xmqqwob2pzty.fsf@gitster-ct.c.googlers.com>
 <20191211171356.GA72178@generichostname>
 <xmqq1rtapwy1.fsf@gitster-ct.c.googlers.com>
 <CAE5ih78O4_ZPm1sxA=D9Ff-u3ga5Ax1CbvrFg0_E4KrRdUihDQ@mail.gmail.com>
 <xmqq5zimo7r3.fsf@gitster-ct.c.googlers.com>
 <CABvFv3L_oHqiGAcA1QyyQD-YZNeouvNVaqhp65qU2ea3TfuRRQ@mail.gmail.com>
 <7dd1ccdf-7c11-6027-c0b2-0bd95077ff72@gmail.com>
Message-ID: <16668dda-391d-275d-8588-cb1affb35f44@gmail.com>
Date:   Fri, 13 Dec 2019 14:42:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <7dd1ccdf-7c11-6027-c0b2-0bd95077ff72@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 12/12/2019 9:13 AM, Ben Keene wrote:
>
> On 12/11/2019 5:30 PM, Yang Zhao wrote:
>> On Wed, Dec 11, 2019 at 1:46 PM Junio C Hamano <gitster@pobox.com> 
>> wrote:
>>> Luke Diamand <luke@diamand.org> writes:
>>>
>>>> On Wed, 11 Dec 2019 at 17:57, Junio C Hamano <gitster@pobox.com> 
>>>> wrote:
>>>>> Denton Liu <liu.denton@gmail.com> writes:
>>>>>
>>>>>> On Wed, Dec 11, 2019 at 08:54:49AM -0800, Junio C Hamano wrote:
>>>>>>  From what I can tell, Ben agreed to have this series superseded 
>>>>>> by Yang
>>>>>> Zhao's competing series[1].
>>>>> OK.  Let me not worry about this one, then, at least not yet.
>>>>>
>>>> Oh, I hadn't seen Yang's python3 changes!
>> ...
>>>> What do we need to do to get these ready for merging?
>>> Somebody needs to take the ownership of the topic---we cannot afford
>>> to have two independently made topics competing reviewers' attention.
>>>
>>> If Ben wants to drop his version and instead wants to use Yang's
>>> ones, that's OK but Ben probably is in a lot better position than
>>> bystanders like me to review and comment on Yang's to suggest
>>> improvements, if he hasn't done so.  The same for those who reviewed
>>> Ben's series earlier.
>>>
>>> It would make sure that the single topic a combined effort to
>>> produce the best of both topics.  If there is something Ben's
>>> patches did that is lacking in Yang's, it may be worth rebuilding it
>>> on top of Yang's series.

I reviewed Yang's changes and added comments to his commits in
GitHub. Except for using the version number instead of feature
mapping, all of his changes are much simpler and cleaner than
I was proposing and I expect will get adoption more quickly.

I recommend the inclusion of the one change I added previously that
removes the need for the basestring entirely. This moots some of
need for the version checking.

Kind regards,

Ben

