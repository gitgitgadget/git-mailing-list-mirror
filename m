Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92055C433DF
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 11:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AD4420772
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 11:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPTJ9pkR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgGILVC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 07:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgGILVC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 07:21:02 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7164C061A0B
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 04:21:01 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id k18so1368868qke.4
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 04:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NBHGPhQX0CwC0uDx06KWN/tCDGP/aMshcbdBn/frRrY=;
        b=XPTJ9pkRf6jNPru5Pnjbf+HBXc6sx5CQPi6/rc1Ex8/s7vyHs07+P6sbhdcD/mc3nw
         /BXpL0NbY6U8uXvtQxz410PZ54YrVuEeYhWHzNgltoSLGAvida/Z9AvhHkEVmMp1XsM7
         Rrkwi1EaGgZTzkGmFJwM8PC1b1/AEBGmYkmf0TMM3ityE2HfUFM8qlYJvy+et1HVYThi
         AbC5X3TUStjjswX3wmRTDG4nBhgnFiazt01F01Z8DWGH99mGW7uj2JUyNthNFCGN90NX
         JrPO1/EZqKKX2sDs6nqkCISzYrgY4DPsUDgR7VX9+o2FKdqKBmh8Ro3eR48fXycXRHe/
         L4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NBHGPhQX0CwC0uDx06KWN/tCDGP/aMshcbdBn/frRrY=;
        b=ctoqOKdYezJb6pljLPutnNVl0GUNaIx1Gh77KAxg0GdZDS7ciV1ZZZAZ17MR7M73+0
         C5xgSrjX+Shw+jGmkEGP0KCH0FSXfApK+zbNv+3C6TOma0btokHUNuYEZrz8d8IYgsgr
         ajleE9UEW4mYk4zfHnfsdVthMPYr779GxMjEs6QrY/eHn7iuola8S5KkNmX8yncPt0i+
         5cG+c60MgKzdZtOxP0J1hopbKGVhjXWwAgXoi+QWjQV9jwgNHZpTC/F1GztLldzz3JCD
         5C5ZhBhlLw0WcayzzJvHWzEijehWVyI7GhJn7tqlcz4mNN1j5uBJELNkZuQvM3BU/l2M
         nnQQ==
X-Gm-Message-State: AOAM5318so1W0+mqkJuXmuPbyaUkScyLbaxNn/Il5+2VTHFDALSWJgE4
        0twtSXDoalFOr5EG9P8zmG8=
X-Google-Smtp-Source: ABdhPJxLM+VNHZ8qEEVlTWjXywmrdHWgusjERq0E3gdsw8iHGEgHtDgSLj2dWbh5jhK+scUdMZuhyw==
X-Received: by 2002:a05:620a:1301:: with SMTP id o1mr64355022qkj.223.1594293660981;
        Thu, 09 Jul 2020 04:21:00 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id m7sm3451219qti.6.2020.07.09.04.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 04:21:00 -0700 (PDT)
Subject: Re: [PATCH 00/21] Maintenance builtin, allowing 'gc --auto'
 customization
To:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <20200708235719.GA3189386@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ef6e2704-b122-f620-a952-75f3f9efab78@gmail.com>
Date:   Thu, 9 Jul 2020 07:21:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200708235719.GA3189386@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/8/2020 7:57 PM, Emily Shaffer wrote:
> On Tue, Jul 07, 2020 at 02:21:14PM +0000, Derrick Stolee via GitGitGadget wrote:
>>
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
>>
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
>>
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
> One thing I wonder about - now I have to go and make a new crontab
> (which is easy) or Task Scheduler task (which is a pain) for every repo,
> right?
> 
> Is it infeasible to ask for 'git maintenance' to learn something like
> '--on /<path-to-repo> --on /<path-to-second-repo>'? Or better yet, some
> config like "maintenance.targetRepo = /<path-to-repo>"?
> 
>>
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
> 
> For me, I'd prefer to see 'git maintenance run' get bigger and 'git gc
> --auto' get smaller or disappear. Is there a plan towards that
> direction, or is that out of scope for 'git maintenance run'? Similar
> examples I can think of include 'git annotate' and 'git pickaxe'.

Thanks for these examples of prior work. I'll keep them in mind.

>>  * Split the 'gc' builtin into smaller maintenance tasks that are enabled by
>>    default, but might have different '--auto' conditions and more config
>>    options.
> 
> Like I mentioned above, for me, I'd rather just see the 'gc' builtin go
> away :)

My hope is that we can absolutely do that. I didn't want to start that
exercise yet, as I don't want to disrupt existing workflows more than
I already am.

It is important to recognize that there are already several "tasks" that
run inside 'gc' including:

1. Expiring reflogs.
2. Repacking all reachable objects.
3. Deleting unreachable objects.
4. Packing refs.

Before trying to "remove" the gc builtin, we would want these to be
represented in the 'git maintenance run' as tasks.

In that direction, I realized after submitting that I should rename
the 'pack-files' task in this submission to 'incremental-repack'
instead, allowing a later 'full-repack' task to represent the role
of that step in the 'gc' task. Some users will prefer one over the
other. Perhaps this incremental/full distinction makes it clear that
there are trade-offs in both directions.

Thanks,
-Stolee
