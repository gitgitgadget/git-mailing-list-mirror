Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B05401F404
	for <e@80x24.org>; Fri, 24 Aug 2018 19:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbeHXXdr (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 19:33:47 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:37404 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbeHXXdr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 19:33:47 -0400
Received: by mail-qt0-f176.google.com with SMTP id n6-v6so11478392qtl.4
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 12:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+sb6McCMeBEVvcDizuiISZFzkVceEkoCDRmP6deFafU=;
        b=Wg6tXtM7hpCu0scsK1HyQtw24M4M+oMDuyhvTJcliNgom1LBI+iVB8b2YZ7/6fjxMO
         viF1ciqfmkCkJGln9LgiTTOjbQYk2sT1oO5zMuCGgDUBcUIiFcV+a1flhCpJYjBzeX0h
         YR8lB24Zza6etDYkdaETiv+88KAInHINmpi2O1Wv6lQY3t4rz4b9RFsyheny1/w1KusS
         2ulxKQsyZ78JBCDkTcQYhb/o/RDgniqPbOrih1eBhfX0kWTNonNNdcomlZl21oEXWEYT
         G2TQtdrWzBpjPvsh04gAS9dTwrCbG04Y6u/VYjQ7YuXLTHK7YBiCTQdTfTLRdfsySlJM
         svLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+sb6McCMeBEVvcDizuiISZFzkVceEkoCDRmP6deFafU=;
        b=TmP4CPr6g+DE/knq96NYr/ATeKtmwPg4lP3474mHAH+KFBVUAUN9dn3CW1X6qjW16h
         IjSoEUY5XgGbRumO4fd8vAYiqYdf5u94ebvTr7KfT/6+1IGL0DGVCiZYqa3agBbSsKgJ
         o5I9qExmLf67p7enVurVYjLHTo7iQQaR58VEToZjvvdasKoaYkq8LUNU8Vlgy7TI/3nn
         vaEdYLM1nekqfR4hJRCZrqQwRPq6jpAjMs2kBfSLPSSINC1NY4uoriZ9Bi1DDwSbIKSG
         3tgrV6mi8rE8XeyVeRhGq9QgzUwfXXQ16VqKntzi9ZgCAuNRXxTJ0Yvx93E2tDXm88CE
         sYsg==
X-Gm-Message-State: APzg51CcYYxIRAJrsBotUh8oIT295V28a9715Rp9LwNi4LwIXHll3YOF
        TrhZIb0lP3rAwDuuq7CxLSRO7JKp
X-Google-Smtp-Source: ANB0VdbC2SC0J4BWfHSfrY/VOr6AM1HwD8emLrJk89lLvT2/V3Ifa3Ev3qfJ0yuFfyS6a8TsDNQalQ==
X-Received: by 2002:ac8:25e6:: with SMTP id f35-v6mr3433951qtf.20.1535140662510;
        Fri, 24 Aug 2018 12:57:42 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id d16-v6sm5594153qtd.7.2018.08.24.12.57.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 12:57:41 -0700 (PDT)
Subject: Re: [PATCH v1] read-cache: speed up index load through
 parallelization
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <xmqqin41hs8x.fsf@gitster-ct.c.googlers.com>
 <4c70ea50-5b43-8696-3c46-cf3d658a0ef8@gmail.com>
 <CACsJy8CUPGUhR3girstdqD6YVxOQ6_xE+gacT98KXgqOSPz0dw@mail.gmail.com>
 <CACsJy8BXy_7QbDtF8bY5YzwJf=JUwiODv0zKxoSXeu4rJ+xjwg@mail.gmail.com>
 <2ba0a9f7-8073-e606-d433-490ea605466b@gmail.com>
 <CACsJy8BtSYm0+Ku_+_F3S3aH1vMv5LPb=U4XCn-P-bvn-6yhjw@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <c2994cf0-2530-52ba-bbc0-ba0b61af54c2@gmail.com>
Date:   Fri, 24 Aug 2018 15:57:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8BtSYm0+Ku_+_F3S3aH1vMv5LPb=U4XCn-P-bvn-6yhjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/24/2018 3:00 PM, Duy Nguyen wrote:
> On Fri, Aug 24, 2018 at 8:40 PM Ben Peart <peartben@gmail.com> wrote:
>>
>>
>>
>> On 8/24/2018 2:20 PM, Duy Nguyen wrote:
>>> On Fri, Aug 24, 2018 at 5:37 PM Duy Nguyen <pclouds@gmail.com> wrote:
>>>> On Thu, Aug 23, 2018 at 10:36 PM Ben Peart <peartben@gmail.com> wrote:
>>>>>> Nice to see this done without a new index extension that records
>>>>>> offsets, so that we can load existing index files in parallel.
>>>>>>
>>>>>
>>>>> Yes, I prefer this simpler model as well.  I wasn't sure it would
>>>>> produce a significant improvement given the primary thread still has to
>>>>> run through the variable length cache entries but was pleasantly surprised.
>>>>
>>>> Out of curiosity, how much time saving could we gain by recording
>>>> offsets as an extension (I assume we need, like 4 offsets if the
>>>> system has 4 cores)? Much much more than this simpler model (which may
>>>> justify the complexity) or just "meh" compared to this?
>>>
>>> To answer my own question, I ran a patched git to precalculate
>>> individual thread parameters, removed the scheduler code and hard
>>> coded these parameters (I ran just 4 threads, one per core). I got
>>> 0m2.949s (webkit.git, 275k files, 100 read-cache runs). Compared to
>>> 0m4.996s from Ben's patch (same test settings of course) I think it's
>>> definitely worth adding some extra complexity.
>>>
>>
>> I took a run at doing that last year [1] but that was before the
>> mem_pool work that allowed us to avoid the thread contention on the heap
>> so the numbers aren't an apples to apples comparison (they would be
>> better today).
> 
> Ah.. sorry I was not aware. A big chunk of 2017 is blank to me when it
> comes to git.
> 
>> The trade-off is the additional complexity to be able to load the index
>> extension without having to parse through all the variable length cache
>> entries.  My patch worked but there was feedback requested to make it
>> more generic and robust that I haven't gotten around to yet.
> 
> One more comment. Instead of forcing this special index at the bottom,
> add a generic one that gives positions of all extensions and put that
> one at the bottom. Then you can still quickly locate your offset table
> extension, and you could load UNTR and TREE extensions in parallel too
> (those scale up to worktree size)
> 

That is pretty much what Junio's feedback was and what I was referring 
to as making it "more generic."  The "more robust" was the request to 
add a SHA to the extension ensure it wasn't corrupt and was a valid 
extension.

>> This patch series went for simplicity over absolutely the best possible
>> performance.
> 
> Well, you know my stance on this now :) Not that it really matters.
> 
>> [1]
>> https://public-inbox.org/git/20171109141737.47976-1-benpeart@microsoft.com/
> 
> PS. I still think it's worth bring v4's performance back to v2. It's
> low hanging fruit because I'm pretty sure Junio did not add v4 code
> with cpu performance in mind. It was about file size at that time and
> cpu consumption was still dwarfed by hashing.
> 

I see that as a nice follow up patch.  If the extension exists, use it 
and jump directly to the blocks and spin up threads.  If it doesn't 
exist, fall back to the code in this patch that has to find/compute the 
blocks on the fly.

