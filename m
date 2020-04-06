Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2427C2BA19
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 14:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C6A24679
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 14:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKCXqYrW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgDFOm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:42:28 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:36915 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgDFOm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 10:42:28 -0400
Received: by mail-qt1-f178.google.com with SMTP id n17so2875260qtv.4
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 07:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sSWUnhdxjFhH7Vf1TmwxKKkD4jLICAilxvUI1AFgRbs=;
        b=YKCXqYrWiUySGN+CaH02v7DogpVdPUKvyDu1xyc4JnD4pkY+eVoArf85Mk0JoBd5bj
         5N+GLbkE1qiw9ukfcyA1FqUr4FaEN+MSabpT52ksv7CHtnOopz9hpQXSEORyA+gW+IRv
         Hc+ji1BnoCiMKoDSiOzZR8tQf+DJPZs+izKyhKwNe56+rV8SlL3QbATDG71Gh3lx2KWX
         4xqGYv7XxEJ3hIFMo6I8oy+9/JKAdfIJT02NyyBXoDrUYugiQucEU76E7PYwuRm+Ad2J
         96BSe2uF5VtX73UWOsFS35HL5ZO5jMBPFSiddbpU8M/srXeZZoFI1CTMGkt5KnTHCX8d
         DE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sSWUnhdxjFhH7Vf1TmwxKKkD4jLICAilxvUI1AFgRbs=;
        b=G6DYHrUYw+mk9GbHDs7Do7gz8bt99ZkTmCVapVfb76TlW/FMlmVL1CTjcu5+nCumD/
         wjZnLlYNwseKhJL9mcA3pRZtRVcZyEpQhFQouBU8q6gkwdSy7xIbadVM9fVbVeU7E2VS
         P/gG1m6hOoK+wND017nGh01enzEZXrksEx2KNPnNiOCf/RaX8uXe3AO7yoPbhjhifzhU
         iDlQT6FIPPYCBI+I78kP0OJDf1OIaOKMNO90IYwxBp1n0vht77aYBrkxejQNq/YHc6aq
         9FBFzcCiVQe4vDSg3Uk4pPka460es+00758S8FHmBJktSNEzUwS4pH5M7cFcqqxBoBs6
         +vMw==
X-Gm-Message-State: AGi0PubRyRFV/oaBa8Fhbgn980e+NSpHdhY6A5HSbock/SOyqIbGrma3
        GDzRX+Ik2FwnKfQkXMeM9jQ=
X-Google-Smtp-Source: APiQypKnVlDzmomKTSxK8YbloqByU3l19JHFszZPsQ4SQ9gyZC1wOFI244/m+pXcmaap/0ktAlWIhw==
X-Received: by 2002:ac8:36a1:: with SMTP id a30mr20630264qtc.103.1586184146131;
        Mon, 06 Apr 2020 07:42:26 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id l186sm3890593qke.16.2020.04.06.07.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 07:42:25 -0700 (PDT)
Subject: Re: [PATCH 01/15] run-job: create barebones builtin
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
 <665da239774419074a9bae49b9c92b340885bfa3.1585946894.git.gitgitgadget@gmail.com>
 <fc5e6823-ebb3-df58-d7fc-6fb2b58cffe8@gmail.com>
 <xmqqimidybzu.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <208bdbc7-9c8e-5105-0627-7db86135db7b@gmail.com>
Date:   Mon, 6 Apr 2020 10:42:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <xmqqimidybzu.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/5/2020 3:21 PM, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> Hi Stolee
>>
>> On 03/04/2020 21:48, Derrick Stolee via GitGitGadget wrote:
>>> From: Derrick Stolee <dstolee@microsoft.com>
>>>
>>> The 'git run-job' command will be used to execute a short-lived set
>>> of maintenance activities by a background job manager. The intention
>>> is to perform small batches of work that reduce the foreground time
>>> taken by repository maintenance such as 'git gc --auto'.
>>>
>>> This change does the absolute minimum to create the builtin and show
>>> the usage output.
>>>
>>> Provide an explicit warning that this command is experimental. The
>>> set of jobs may change, and each job could alter its behavior in
>>> future versions.
>>>
>>> RFC QUESTION: This builtin is based on the background maintenance in
>>> Scalar. Specifically, this builtin is based on the "scalar run <job>"
>>> command [1] [2]. My default thought was to make this a "git run <job>"
>>> command to maximize similarity. However, it seems like "git run" is
>>> too generic. Or, am I being overly verbose for no reason?
>>
>> Having read through this series I wondered if we wanted a single git
>> command such as 'git maintenance' (suggestions of better names
>> welcome) and then 'git run-job' could become 'git maintenance run',
>> 'git job-runner' would become another subcommand (run-jobs or
>> schedule-jobs?) and the 'git please-run-maintenance-on-this-repo' you
>> mentioned in you email to Junio could become 'git maintenance init'
>> (or maybe setup)
> 
> I had a very similar impression.  In addition to what you already
> said, a few more were:
> 
>  - Why the existing "git repack" isn't such "maintenance" command?
>    IOW why do we even need [01/15]?  After all, "repack" may have
>    started its life as a tool to reorganize the PACKFILES, but it is
>    no longer limited to 'git/objects/pack/*.pack' files with its
>    knowledge about the loose object files and the "--prune" option.
>    Consolidating pieces of information spread across multiple .idx
>    files, reachability bitmaps and commit graph files, into a newer
>    and more performant forms can just be part of "packing the pieces
>    of information in a repository for optimum performance", which is
>    a better way to understand why "repack" has a word 'pack' in its
>    name.

To me, "git repack" is a specific kind of maintenance. The end result
is a pack-file. Now, "git gc" is a bit more general, because it will
create a pack-file but also update the commit-graph file. Still, its
name is still very specific: it "collects garbage". The goals of this
series are to replace "git gc --auto" with something less invasive.

I'll include an alternate CLI proposal at the end of this message.

>  - Many of the "maintenance" operations this series proposes do make
>    sense, just like other "maintenance" operations we already have
>    in "repack", "prune", "prune-packed" etc., which are welcome
>    additions. 

Thanks. I'm glad these steps make sense. They are definitely more
"incremental" updates than a full repack or GC.
 
>  - Like the individual steps that appear in e.g. "repack", however,
>    some of the individual steps in this series can be triggered by
>    calling underlying tools directly, allowing scripted maintenance
>    commands that suit individual needs better than the canned
>    invocation of "run-job", but I didn't get the impression that the
>    series strives to make sure that all knobs of these individual
>    steps are available to scripters who want to deviate from what
>    "run-job" prescribes.  If it is not doing so, we probably should.
> 
>  - Again, I do not think we want a reimplementation of cron, at or
>    inetd that is not specific to "git" at all.

I expected the job-runner to get some push-back. The design for it in
the current RFC matched how we do it in Scalar more than anything else.
You're probably right that it would be better to leave the "background"
part to the platform.

Of course, not every platform has "cron" but that just means we need a
cross-platform way to launch Git processes on some schedule. That could
be a command that creates a cron job on platforms that have it, and on
Windows it could create a scheduled task instead.

But what should we launch? It should probably be a Git command that
checks config for a list of repositories, then runs "the maintenance
command" on each of those repos.

I'm inserting a break here to draw the eye to a new proposed design:

---

Create a "git maintenance" builtin. This has a few subcommands:

1. "run" will run the configured maintenance on the current repo. This
   should become the single entry point for users to say "please clean
   up my repo." What _exactly_ it does can be altered with config. I'll
   list some possibilities after listing the subcommands.

2. "run-on-repos" uses command-line arguments or config to launch "git
   -C <dir> maintenance run" for all configured directories. The
   intention is that this is launched on some schedule by a platform-
   specific scheduling mechanism (i.e. cron).
   (This subcommand could use a better name.)

3. "schedule" adds the current repository to the configured list of
   repositories for running with "run-on-repos". It will also initialize
   the platform-specific scheduling mechanism. This may be to start the
   schedule for the first time OR to update how frequent "run-on-repos"
   is run, as appropriate.

4. (OPTIONAL) "mode <mode>" adjusts the config for the current repo to
   change the type of maintenance requested for this repo. For example,
   "simple" could just run "git gc --auto" using a normal range.
   "incremental" could run the maintenance tasks from this series.
   Finally, "server" could run maintenance tasks as if we are serving
   the repo to others, so we repack aggressively with full bitmaps, and
   more frequently.

Here are some possible maintenance tasks. Not all of them would
be appropriate to run on the same repo, or at least not with the
same frequency:

* "fetch" : the background fetch from PATCH 3. Appropriate for all modes,
  but perhaps would want users to opt-in to this in the  basic mode.

* "commit-graph" : the incremental commit-graph writes from PATCH 2.
  Appropriate whenever the "fetch" command is being run, but also
  valuable for the "server" mode.

* "gc" : Run "git gc --auto". This would be enabled by default, but
  should be disabled for the "incremental" and "server" modes.

* "repack" : Run "git repack <options>" with appropriate options based
  on config. The "server" mode would include custom delta and bitmap
  options. (I will leave the specifics to those who maintain servers to
  recommend the best options for "server" mode.)

* "loose-objects" : see PATCH 4. Appropriate for "incremental" mode.

* "multi-pack-index" or "incremental-repack" : Run the "pack-files" job
  from PATCH 5. Appropriate for "incremental" mode.

* "pack-refs" : create a packed-refs file or repack the reftable as
  appropriate for those features. (I have less familiarity with these.)

Notice that with this new set of options we could do something rather
dramatic: replace all calls to "git gc --auto" with "git maintenance
run --auto". By default, these would be equivalent. However, "git
maintenance run --auto" is more clear that the behavior is less specific
than "git gc" and could be configured to do something different.

I used an "--auto" option in the suggestion above to help distinguish
between the command being run as a foreground operation instead of a
background operation. Part of setting up a schedule would include
disabling these "foreground" maintenance tasks and relying entirely on
the background tasks instead. The best situation would be to avoid
launching the subprocess at all.

---

What do people think of this alternative? Does this get us closer to an
appropriate level of work for Git to do?

Thanks,
-Stolee
