Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 296131F597
	for <e@80x24.org>; Tue, 26 Jun 2018 22:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754723AbeFZWok (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 18:44:40 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46453 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754681AbeFZWoj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 18:44:39 -0400
Received: by mail-wr0-f194.google.com with SMTP id t6-v6so41466wrq.13
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 15:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6+VkYTxlKnDT4m/pclSNTbUjr9kITxfuKLKsKDPtgfs=;
        b=h7QvqPWVrtKObxn4Of60lcult41yvnH6kB6Xg9ps/EPHv1joV4eHDee5ZwVi2SiX4Y
         qucs6VeZh7tFBWVOmbGmA+LB29ipSc5NpYYuzLFG/bQ7toNvqagFzshdGLGfrYLSrNYg
         fN/HN+4PQf1LSmKSiNaqtwFuwqinGphrTLWqvIbGGkAzDuii9OeGQp5UMudKLvo/nmD2
         /4ffPam1sllx+Yua/o/Sd+u2pj3d4zmvEAFBMuVrKCZ/+w1Uh7qJShQEDR68OASQOp8B
         y4paGaqDwGdGC1Dvf8T4UJxA+JFszCUPYijOd+fzMdr5tAXU11W3iE9ziD/CDhj3Z3UJ
         NYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6+VkYTxlKnDT4m/pclSNTbUjr9kITxfuKLKsKDPtgfs=;
        b=g3oOLrE4FqX7sbBXkk03Fc2VJwgN+6feCyaKo9gzg5r657J5mXzJTeYdlwjgLfPp9b
         FKyj/i5u4SEGYCenVikesbSCJHvbsWDORcFpmZrCYwt5W00bwa9dpd7PRY3Yc9/e7h4e
         JErfsbkAU4gTCfQTqj8Sfhcv54IPegh5GJG6sbYKkTHGsIcLU6Zj1GJK31Exp8YMifAL
         G9XvlTZGw2I5bqoacZszaypAO1OsuLxljhoBvtWvUlIFZjSZg64XbTA3IzwY7oITwomA
         /KSX9D4peurhn8OusVs8kv3Hojg1BD62Z8bV2pXQ1JirJPjWC/pXidzdsySwWDki0AzX
         ZiXA==
X-Gm-Message-State: APt69E09I+pBNzJZKcmVm75UqJSr/PNW41HNKoEhzaf2d++3+9YGZa92
        VknBRzp+1Eh2u43aIW9khRY=
X-Google-Smtp-Source: AAOMgpdI10hUdkoL6BvdmoRKLplmBP+S+Lc6mpLuGgXPPA3RqbaE60KFKvGRhNUw5kt9jbkQSnaVQg==
X-Received: by 2002:adf:b219:: with SMTP id u25-v6mr2966531wra.1.1530053077660;
        Tue, 26 Jun 2018 15:44:37 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s124-v6sm3544318wmf.47.2018.06.26.15.44.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 15:44:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ian Campbell <ijc@hellion.org.uk>
Cc:     Michael Barabanov <michael.barabanov@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] filter-branch: skip commits present on --state-branch
References: <20180623043639.7727-1-michael.barabanov@gmail.com>
        <20180626040733.30757-1-michael.barabanov@gmail.com>
        <1530039484.9819.8.camel@hellion.org.uk>
Date:   Tue, 26 Jun 2018 15:44:36 -0700
In-Reply-To: <1530039484.9819.8.camel@hellion.org.uk> (Ian Campbell's message
        of "Tue, 26 Jun 2018 19:58:04 +0100")
Message-ID: <xmqq1scti2wb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ian Campbell <ijc@hellion.org.uk> writes:

> On Mon, 2018-06-25 at 21:07 -0700, Michael Barabanov wrote:
>> The commits in state:filter.map have already been processed, so don't
>> filter them again. This makes incremental git filter-branch much
>> faster.
>> 
>> Also add tests for --state-branch option.
>> 
>> Signed-off-by: Michael Barabanov <michael.barabanov@gmail.com>
>
> Acked-by: Ian Campbell <ijc@hellion.org.uk>

Thanks.

>
>> ---
>>  git-filter-branch.sh     |  1 +
>>  t/t7003-filter-branch.sh | 15 +++++++++++++++
>>  2 files changed, 16 insertions(+)
>> 
>> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
>> index ccceaf19a..5c5afa2b9 100755
>> --- a/git-filter-branch.sh
>> +++ b/git-filter-branch.sh
>> @@ -372,6 +372,7 @@ while read commit parents; do
>>  	git_filter_branch__commit_count=$(($git_filter_branch__commi
>> t_count+1))
>>  
>>  	report_progress
>> +	test -f "$workdir"/../map/$commit && continue
>>  
>>  	case "$filter_subdir" in
>>  	"")
>> diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
>> index ec4b160dd..e23de7d0b 100755
>> --- a/t/t7003-filter-branch.sh
>> +++ b/t/t7003-filter-branch.sh
>> @@ -107,6 +107,21 @@ test_expect_success 'test that the directory was
>> renamed' '
>>  	test dir/D = "$(cat diroh/D.t)"
>>  '
>>  
>> +V=$(git rev-parse HEAD)
>> +
>> +test_expect_success 'populate --state-branch' '
>> +	git filter-branch --state-branch state -f --tree-filter
>> "touch file || :" HEAD
>> +'
>> +
>> +W=$(git rev-parse HEAD)
>> +
>> +test_expect_success 'using --state-branch to skip already rewritten
>> commits' '
>> +	test_when_finished git reset --hard $V &&
>> +	git reset --hard $V &&
>> +	git filter-branch --state-branch state -f --tree-filter
>> "touch file || :" HEAD &&
>> +	test_cmp_rev $W HEAD
>> +'
>> +
>>  git tag oldD HEAD~4
>>  test_expect_success 'rewrite one branch, keeping a side branch' '
>>  	git branch modD oldD &&
