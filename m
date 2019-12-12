Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED431C43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C0B22527
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JY1wt56B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbfLLONq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:13:46 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:32939 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729560AbfLLONp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 09:13:45 -0500
Received: by mail-qv1-f68.google.com with SMTP id z3so1008959qvn.0
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 06:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ojdaFhaYldMm0Cje3T+M4118EK6KoA7HCP00rVUQdiU=;
        b=JY1wt56BMoQVqu/hToxDRJs4ODVUIVRs98yr/x/glF1ZNXRfjP0xq27pr9AiPl8tJu
         1CVdAi5ed35coNYRdw3aCLHcjrgPg7sYbHhQsStxYzCBdQgTkSTWhXGyWct6d4UCV/+b
         kbKbcKA+R/12mUaQKlda7D1bACm+evlOlCo/yUCXzUzgznO/1E1EbbdvNJalaY8pHrTo
         /6zZRxhaTC9dUVPCwuMqpjtxnNuC0txKTX9nUBk62rWMOLoycX+y1EDfjbBj/K4Tl2DE
         V0vn9yUJ+mBh+Hz93MgSoxmRZ279gnXomcIszJEBvNOaxE1BOfslfZ70yTFHi2HjVe+q
         OVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ojdaFhaYldMm0Cje3T+M4118EK6KoA7HCP00rVUQdiU=;
        b=rVwoe74xXwU1GMwyQgigFCDS915P/iq847TdNt8wLoFuxogmSifCRQlHQgaHBlmViu
         OvwdOjQaQBkxGC7dQQuHsYttfpToVXdMP6Q1CtosGfBFYMXzmRAfCrw6twriYk1s6ZQN
         Q3W1b2QJEqmI5zwUIQwRUML1darG/NLXodFwJAuUndxcmQLwB4SiSIwMbcfV7BxP3Z2w
         2rMIB32DskT7JrsKN+tXgApYvTNao634OqcuciKmEnLemIW8bzEi8jrwylQXdaWmJC8W
         KcQOxS+3taJt7zFBY+YFSPRhMTi14Dl4PBwtpTabsJWazOajWFPMV+tuPxXPgFcX5I8p
         6W5g==
X-Gm-Message-State: APjAAAWkP3lzxbx2mMV9EpNnL4qLMiBKjWea7qFPsiKtdNBZn0VvYIEg
        EqZX8ql3UB4kgBZwwfsQYUqq7j08rms=
X-Google-Smtp-Source: APXvYqwN72peqonG1NAOzd9CrN2cuf0hNuXqx3BucOELZeRK2lQT3N5fo+BFN3RUi0p8DcyzfbqmVw==
X-Received: by 2002:a0c:e4cc:: with SMTP id g12mr8362960qvm.237.1576160024544;
        Thu, 12 Dec 2019 06:13:44 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id x34sm2189963qtd.20.2019.12.12.06.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 06:13:43 -0800 (PST)
Subject: Re: [PATCH v5 00/15] git-p4.py: Cast byte strings to unicode strings
 in python3
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
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <7dd1ccdf-7c11-6027-c0b2-0bd95077ff72@gmail.com>
Date:   Thu, 12 Dec 2019 09:13:43 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CABvFv3L_oHqiGAcA1QyyQD-YZNeouvNVaqhp65qU2ea3TfuRRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 12/11/2019 5:30 PM, Yang Zhao wrote:
> On Wed, Dec 11, 2019 at 1:46 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Luke Diamand <luke@diamand.org> writes:
>>
>>> On Wed, 11 Dec 2019 at 17:57, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Denton Liu <liu.denton@gmail.com> writes:
>>>>
>>>>> On Wed, Dec 11, 2019 at 08:54:49AM -0800, Junio C Hamano wrote:
>>>>>  From what I can tell, Ben agreed to have this series superseded by Yang
>>>>> Zhao's competing series[1].
>>>> OK.  Let me not worry about this one, then, at least not yet.
>>>>
>>> Oh, I hadn't seen Yang's python3 changes!
> ...
>>> What do we need to do to get these ready for merging?
>> Somebody needs to take the ownership of the topic---we cannot afford
>> to have two independently made topics competing reviewers' attention.
>>
>> If Ben wants to drop his version and instead wants to use Yang's
>> ones, that's OK but Ben probably is in a lot better position than
>> bystanders like me to review and comment on Yang's to suggest
>> improvements, if he hasn't done so.  The same for those who reviewed
>> Ben's series earlier.
>>
>> It would make sure that the single topic a combined effort to
>> produce the best of both topics.  If there is something Ben's
>> patches did that is lacking in Yang's, it may be worth rebuilding it
>> on top of Yang's series.
> Sorry about the bit of communication mess there. I should have paid
> more attention to who were chiming in to Ben's series and added CCs
> appropriately. The timing was definitely a bit awkward as we were both
> only dedicating part of work-time to the patchsets.


Sorry for the silence, I was heads down on another issue at work.  I had 
tried to pull Yang's work down to my machine and had trouble getting it 
to run under my configuration but I think I had a mixed environment.  
I'm going to reset everything on my machine and try again.  Since I'm 
not a python developer and I won't be able to devote the overall time 
that Yang will, I'm deferring the changeset to Yang's code. I posted the 
code so that the work that I had done would be visible, I didn't mean to 
cause the cross-talk!

>
> The outcome of discussion between Ben and I were that it made the most
> sense to use my set as the base to rebuild his quality-of-life
> changes. My patchset (plus one missing change I've not sent out yet)
> will pass all existing tests. I will take ownership of this merge,
> probably as a separate patchset.


