Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E16C433E1
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 13:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AC4422365
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 13:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pau+DBjz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgGNNqO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgGNNqN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 09:46:13 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833AFC061755
        for <git@vger.kernel.org>; Tue, 14 Jul 2020 06:46:13 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 80so15565258qko.7
        for <git@vger.kernel.org>; Tue, 14 Jul 2020 06:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=juooySfO5M1Smx56YoibJFyAZUgEjeM+6N90QiQ+ouI=;
        b=pau+DBjzlEXSWiqgvn1j8Ko3hokslsX3/8TBafgrDvTVK/iYcP8218aWU6NTJkb6av
         BUPEv2Z9WRewnUU8I4/1Am/NOhKQgOn5pJfkZNPMBzJGs1IK421uZVKALBHCUOn9T8aZ
         qQ0jW9Y7m0SboOncmrPWi6YdC+0LBNsjTNcK58vgk+6FqLuxpPUN/1MP/MognNuzXF7O
         XG/LVt6j8QdzSTmTYheQPnyiAzxiJ/hs52rEwyjJcXm77b4KSdgQfN9JOKXvrDZHsVsO
         jrENo4NTVW+FsQAinhnFBEATUguPe/EJbhOQADyYOrPd04zC8WDhq2c6Xe9dXznFA7mk
         hP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=juooySfO5M1Smx56YoibJFyAZUgEjeM+6N90QiQ+ouI=;
        b=CuBSLqVJowXaW1KwYyCDcQWPXmcZKls5lfT7Lhw1vY/uh0WgWZQAtkNmutCzx0HIIR
         cCalNBrB0+KSJE23APcTv4ev0TWMGQmHYnbYl5BHZDTg2Eu3VUmDxgm536HeOem3+Y+p
         q/IR1x2dcmDzEQTpUEE2YLuVC/YUMzS7v1aUEB6cbZ3kj3ht8H8BevIUXTLS3k17ohOq
         LyivzEGnZZSrba1lnEX8krvqPtjjbiKkS6n+Y2AMTr3JqO94WO6/3muuOIXzSjL7KhAI
         WR1cqlarrwi0e8Aa9hMunx8UA8/yTy9UdOA68ItK3X1npuccOIvb2E3ghz+s94U3Rhnn
         uLzw==
X-Gm-Message-State: AOAM530BWPohzmOcqBf0viECaq2U2edOJvCBRLP5kKu4UOC9ljQ0U5ca
        FpHIKNzy89JKVrJopktIFuM=
X-Google-Smtp-Source: ABdhPJzyNsEZqkwkkwOEyy63xWT3yL765UuPxppgr+6nir3sUx7uewzR2NKbsx89YO2mq6Uqrny+Jg==
X-Received: by 2002:a37:65d2:: with SMTP id z201mr4700495qkb.351.1594734372510;
        Tue, 14 Jul 2020 06:46:12 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f65sm23501652qtd.61.2020.07.14.06.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 06:46:11 -0700 (PDT)
Subject: Re: [PATCH 00/21] Maintenance builtin, allowing 'gc --auto'
 customization
To:     Son Luong Ngoc <sluongng@gmail.com>, gitgitgadget@gmail.com
Cc:     Johannes.Schindelin@gmx.de, congdanhqx@gmail.com,
        derrickstolee@github.com, git@vger.kernel.org, jrnieder@gmail.com,
        peff@peff.net, phillip.wood123@gmail.com,
        sandals@crustytoothpaste.net, steadmon@google.com
References: <CAL3xRKfTTr=Tkq2NY7zUwCSWGHXO2FAwEHKvV2-4AavX9Cs7ow@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f9b2d585-d579-235c-034e-ab7e2c953d16@gmail.com>
Date:   Tue, 14 Jul 2020 09:46:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <CAL3xRKfTTr=Tkq2NY7zUwCSWGHXO2FAwEHKvV2-4AavX9Cs7ow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/13/2020 2:18 AM, Son Luong Ngoc wrote:
> Hi Derrick,
> 
>> This is a second attempt at redesigning Git's repository maintenance
>> patterns. The first attempt [1] included a way to run jobs in the background
>> using a long-lived process; that idea was rejected and is not included in
>> this series. A future series will use the OS to handle scheduling tasks.
>>
>> [1]
>> https://lore.kernel.org/git/pull.597.git.1585946894.gitgitgadget@gmail.com/
>>
>> As mentioned before, git gc already plays the role of maintaining Git
>> repositories. It has accumulated several smaller pieces in its long history,
>> including:
>>
>>  1. Repacking all reachable objects into one pack-file (and deleting
>>     unreachable objects).
>>  2. Packing refs.
>>  3. Expiring reflogs.
>>  4. Clearing rerere logs.
>>  5. Updating the commit-graph file.
> 
> It's worth mentioning 'git worktree prune' as well.

Good point. I'll also say "including, but not limited to:"

>> While expiring reflogs, clearing rererelogs, and deleting unreachable
>> objects are suitable under the guise of "garbage collection", packing refs
>> and updating the commit-graph file are not as obviously fitting. Further,
>> these operations are "all or nothing" in that they rewrite almost all
>> repository data, which does not perform well at extremely large scales.
>> These operations can also be disruptive to foreground Git commands when git
>> gc --auto triggers during routine use.
>>
>> This series does not intend to change what git gc does, but instead create
>> new choices for automatic maintenance activities, of which git gc remains
>> the only one enabled by default.
>>
>> The new maintenance tasks are:
>>
>>  * 'commit-graph' : write and verify a single layer of an incremental
>>    commit-graph.
>>  * 'loose-objects' : prune packed loose objects, then create a new pack from
>>    a batch of loose objects.
>>  * 'pack-files' : expire redundant packs from the multi-pack-index, then
>>    repack using the multi-pack-index's incremental repack strategy.
>>  * 'fetch' : fetch from each remote, storing the refs in 'refs/hidden//'.
> 
> As some of the previous discussions [1] have raised, I think 'prefetch' would
> communicate the refs' purpose better than just 'hidden'.
> In-fact, I would suggest naming the task 'prefetch' instead, just to avoid
> potential communication issue between 'git fetch' and 'git maintenance fetch'.
> 
> [1]: https://lore.kernel.org/git/xmqqeet1y8wy.fsf@gitster.c.googlers.com/

Thanks for the reminder. I'll rename the task as you suggest.

>> These tasks are all disabled by default, but can be enabled with config
>> options or run explicitly using "git maintenance run --task=". There are
>> additional config options to allow customizing the conditions for which the
>> tasks run during the '--auto' option. ('fetch' will never run with the
>> '--auto' option.)
>>
>>  Because 'gc' is implemented as a maintenance task, the most dramatic change
>> of this series is to convert the 'git gc --auto' calls into 'git maintenance
>> run --auto' calls at the end of some Git commands. By default, the only
>> change is that 'git gc --auto' will be run below an additional 'git
>> maintenance' process.
>>
>> The 'git maintenance' builtin has a 'run' subcommand so it can be extended
>> later with subcommands that manage background maintenance, such as 'start',
>> 'stop', 'pause', or 'schedule'. These are not the subject of this series, as
>> it is important to focus on the maintenance activities themselves.
>>
>> An expert user could set up scheduled background maintenance themselves with
>> the current series. I have the following crontab data set up to run
>> maintenance on an hourly basis:
>>
>> 0 * * * * git -C /<path-to-repo> maintenance run --no-quiet >>/<path-to-repo>/.git/maintenance.log
> 
> Perhaps the logging should be included inside the maintenance command instead
> of relying on the append here?
> Given that we have 'gc.log', I would imagine 'maintenance.log' is not
> too far-fetched?

I'll research gc.log and how that works.

>> My config includes all tasks except the 'gc' task. The hourly run is
>> over-aggressive, but is sufficient for testing. I'll replace it with daily
>> when I feel satisfied.
>>
>> Hopefully this direction is seen as a positive one. My goal was to add more
>> options for expert users, along with the flexibility to create background
>> maintenance via the OS in a later series.
>>
>> OUTLINE
>> =======
>>
>> Patches 1-4 remove some references to the_repository in builtin/gc.c before
>> we start depending on code in that builtin.
>>
>> Patches 5-7 create the 'git maintenance run' builtin and subcommand as a
>> simple shim over 'git gc' and replaces calls to 'git gc --auto' from other
>> commands.
>>
>> Patches 8-15 create new maintenance tasks. These are the same tasks sent in
>> the previous RFC.
>>
>> Patches 16-21 create more customization through config and perform other
>> polish items.
>>
>> FUTURE WORK
>> ===========
>>
>>  * Add 'start', 'stop', and 'schedule' subcommands to initialize the
>>    commands run in the background.
>>
>>
>>  * Split the 'gc' builtin into smaller maintenance tasks that are enabled by
>>    default, but might have different '--auto' conditions and more config
>>    options.
>>
>>
>>  * Replace config like 'gc.writeCommitGraph' and 'fetch.writeCommitGraph'
>>    with use of the 'commit-graph' task.
>>
>>
>>
>> Thanks, -Stolee
> 
> Thanks,
> Son Luong.

Thank you!
-Stolee

