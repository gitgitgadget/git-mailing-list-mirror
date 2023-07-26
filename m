Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61951C001DC
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 13:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbjGZNIg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 09:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjGZNIb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 09:08:31 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09B91FFC
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 06:08:25 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3159d5e409dso706494f8f.0
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 06:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690376904; x=1690981704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6AZgJj5Y88IY4ZJTtEzozoXzCt8kPGCwODt+ePPlnJM=;
        b=CVnCRzjXktxQbz+rTROnLc0mJHu3/mtMA1fsl38t852H4TdrdEewBuFzL5d21CJN2j
         RACYtuInjwwRvpKKh1D5WHJ882mqlNkk92otqIjUpe462jrI++zKbnOUlUTGGGHCqFHa
         Fqd8lchvNUPMzRQ7/GmXx2Mr8cWzcD+duPso01f9Hfu5mqeDxpEucOvoKjfswXjTqVUu
         0gbV3oVhJBO6a74bA9C78RYeeCLzp0q42dvflExUvd3+VjITcTorWAw1xF7vGsOdnyuN
         o+xdwNV0fr0DdB7a6qARnK0i6f4vh1cRhwl1BKnPFgiPHtJEQL2+pen45YiUQPbl33mv
         aM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690376904; x=1690981704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6AZgJj5Y88IY4ZJTtEzozoXzCt8kPGCwODt+ePPlnJM=;
        b=PG7MqbFhH1B+QjorK/5aHcuJtB1KdcHqOVhsAMJRsonCcmz+3mE1UU/JecaTArc5kF
         L/O/K1L6GQsOtCBL2UNZ5QVTjOQYsyc4UbnQFu9e3VRAzo8C4t//Ora92VwvFfpeUfGm
         3Vcq1aYkp5pw6sX2XBlaZLVdS6fu20niqTvlYVWEH6rqxXv1KAw84gEYXJtzd3aDc+5A
         PWtZiPeoymyMNGCLLAB2gzFmZcbwGSqUFEgHoVBXn+KZAIKurpJESsSXe9cCFcsulbEQ
         QneV18mvR9Bd6sOjBFGT5kCQiYGg5kj4twgzsnWQIpIwmv2TGQ4GvEXwexHexskNgI4r
         uu0A==
X-Gm-Message-State: ABy/qLYdsoFlO5MQPImDIJTlNsENVkjJpAMXr1Y/Sxit1FO6b+huW+mF
        h/d/ixoVkfDwkqq5usRx110=
X-Google-Smtp-Source: APBJJlG8B/5waXJG6Sf2fUBr7gfjoD8VAX1vN5vvdldQRxxIr6etJJeBgUdjD56BA01cTxq6RogWhw==
X-Received: by 2002:adf:f8c7:0:b0:311:360e:ea3a with SMTP id f7-20020adff8c7000000b00311360eea3amr4960980wrq.34.1690376904056;
        Wed, 26 Jul 2023 06:08:24 -0700 (PDT)
Received: from [192.168.1.195] ([90.242.235.211])
        by smtp.googlemail.com with ESMTPSA id e1-20020adfe381000000b00313f031876esm19824930wrm.43.2023.07.26.06.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 06:08:23 -0700 (PDT)
Message-ID: <a3526864-dd3a-f95c-72e6-44995a9a460f@gmail.com>
Date:   Wed, 26 Jul 2023 14:08:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 5/6] rebase: fix rewritten list for failed pick
Content-Language: en-US
To:     Glen Choo <chooglen@google.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
 <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
 <f8e64c1b631116367e6e68fcfde711b507a03a94.1682089075.git.gitgitgadget@gmail.com>
 <kl6lmt0sr16k.fsf@chooglen-macbookpro.roam.corp.google.com>
 <fdb605bf-938d-6135-b341-6cf20600abaf@gmail.com>
 <kl6lo7k0ym57.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <kl6lo7k0ym57.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen

On 25/07/2023 17:46, Glen Choo wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>>>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>>>> index c1fe55dc2c1..a657167befd 100755
>>>> --- a/t/t3404-rebase-interactive.sh
>>>> +++ b/t/t3404-rebase-interactive.sh
>>>> @@ -1289,6 +1289,10 @@ test_expect_success 'rebase -i commits that overwrite untracked files (pick)' '
>>>>    	test_cmp_rev HEAD F &&
>>>>    	rm file6 &&
>>>>    	test_path_is_missing .git/rebase-merge/author-script &&
>>>> +	test_path_is_missing .git/rebase-merge/patch &&
>>>> +	test_path_is_missing .git/MERGE_MSG &&
>>>> +	test_path_is_missing .git/rebase-merge/message &&
>>>> +	test_path_is_missing .git/rebase-merge/stopped-sha &&
>>>
>>> This also seems to be testing implementation details, and if so, it
>>> would be worth removing them.
>>
>> With the exception of the "patch" file which exists solely for the
>> benefit of the user this is testing an invariant of the implementation
>> which isn't ideal. I'm worried that removing these checks will mask some
>> subtle regression in the future. I think it is unlikely that the names
>> of these files will change in the future as we try to avoid changes that
>> would cause a rebase to fail if git is upgraded while it has stopped for
>> the user to resolve conflicts. I did think about whether we could add
>> some BUG() statements to sequencer.c instead. Unfortunately I don't
>> think it is that easy for the sequencer to know when these files should
>> be missing without relying on the logic that we are tying to test.
> 
> Unfortunately, it's been a while since I reviewed this patch, so forgive
> me if I'm rusty. So you're saying that this test is about checking
> invariants that we want to preserve between Git versions.

Not really. One of the reasons why testing the implementation rather 
than the user observable behavior is a bad idea is that when the 
implementation is changed the test is likely to start failing or keep 
passing without checking anything useful. I was trying to say that in 
this case we're unlikely to change this aspect of the implementation 
because it would be tricky to do so without inconveniencing users who 
upgrade git while rebase is stopped for a conflict resolution and so it 
is unlikely that this test will be affected by future changes to the 
implementation.

> IIRC, there was an earlier patch would be different from an where we
> tested that author-script is missing, but what we really want is for the
> pick to stop. Is the same thing happening here? E.g. is 'testing for
> missing stopped-sha' a stand-in for 'testing that the rewritten list is
> correct'? If so, it would be nice to test that specifically, but if
> that's infeasible, a clarifying comment will probably suffice.

Yes this patch adds a test to t5407-post-rewrite-hook.sh to do that but 
it only checks a failing "pick" command. The reason I think it is useful 
to add these test_path_is_missing checks is that they are checking 
failing "squash" and "merge" commands as well. Maybe I should just bite 
the bullet see how tricky it is to extend the post-rewrite-hook test to 
cover those cases as well.

Best Wishes

Phillip

