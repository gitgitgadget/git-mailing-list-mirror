Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EA7C433E5
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 14:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BDF820674
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 14:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sp+broI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgGXOZz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGXOZz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 10:25:55 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC95C0619D3
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 07:25:55 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id k18so6970304qtm.10
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 07:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HWFuLlXY5P9HspdmE17Se/yDryWlxpyvQ1XQu1lTb3E=;
        b=Sp+broI+9qhvp1mKx+lq10C8mRIA4KADqRo41CewSlQQFOJ2k/gXLzsN+SAHZN/FX/
         kCFOwDNFKK3AjEP7nvwTZHzssnywroAfLg5A4BzmdSSUQA9G5nHfhdFcBHpBgrRQrkh2
         iYX3E/LKqn009WGqkTvT2FvqZZnweNDPjoImy2v8gisGmVE78fqj/w9/R5ioBP0XN/Zh
         0XXx/AVHB/5metWoZDjQ+Ar4I8CzYDEnEi45MgO7stWLu9Z1KDdty8YYVAzgIOxlPeaT
         oMbxoSG0A8UAUO0AX2UwoZrYUwDFEtlhikIvlTJtnue38dQ0rhbDdJO6dR/i5pqxkJod
         5P0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HWFuLlXY5P9HspdmE17Se/yDryWlxpyvQ1XQu1lTb3E=;
        b=i0QrO7ELJ7Fo3+VijAeNcthbpdYuy34rY5KZbOx03zFf3Eq2Crz5UyXVMFwaaMKC1p
         pg0D4eEwaH3XDdgUQOKabeCGTVMLt7SqrqcYNAPPOSLG74ZkM3yd7ifR4ek11C0TaajH
         iksqTyrcQYQ2bWXuvspUaASNUgp4cRBTr6BTtsxcLrO8woW9DxHqYQdzag2mWt+QMqrb
         uVMBgtIfWsP6aN7AGgQxuLV0L4+jNACp/cCrmueyacYTmDgc2yxKEDmR06maBoSL376c
         A+oDc+SUFjsUusQJewbj7Avh9Rau2v+SE/DQVUDcA05hf9uA9THrbK69IJaO4FbjnPXb
         12+w==
X-Gm-Message-State: AOAM531jqc3CKgHTmwBiv5zyb47fRbSG0MHZqirZ1HkPiRQtE7ccGi5k
        njG1k3tI5xda7BtoL6vup0A=
X-Google-Smtp-Source: ABdhPJzoEAqu6ynkVCs0AJG60HP3K8VbnvQHL4dHEIsIVsZHvbz0SRZZY3XZLMqQ4Zk9vGx5on8uoA==
X-Received: by 2002:ac8:4d5c:: with SMTP id x28mr10087354qtv.35.1595600754067;
        Fri, 24 Jul 2020 07:25:54 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:dd66:75cb:8c22:1387? ([2600:1700:e72:80a0:dd66:75cb:8c22:1387])
        by smtp.gmail.com with ESMTPSA id s5sm6670244qke.120.2020.07.24.07.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 07:25:53 -0700 (PDT)
Subject: Re: [PATCH v2 08/18] maintenance: add prefetch task
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <3165b8916d2d80bf72dac6596a42c871ccd4cbe6.1595527000.git.gitgitgadget@gmail.com>
 <xmqqwo2uosvz.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <52fc3f5a-281c-a0cb-d897-3866315913a1@gmail.com>
Date:   Fri, 24 Jul 2020 10:25:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <xmqqwo2uosvz.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/23/2020 4:53 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
>> index 9204762e21..0927643247 100644
>> --- a/Documentation/git-maintenance.txt
>> +++ b/Documentation/git-maintenance.txt
>> @@ -53,6 +53,18 @@ since it will not expire `.graph` files that were in the previous
>>  `commit-graph-chain` file. They will be deleted by a later run based on
>>  the expiration delay.
>>  
>> +prefetch::
>> +	The `fetch` task updates the object directory with the latest objects
> 
> s/fetch/prefetch/ most likely.
> 
>> +	from all registered remotes. For each remote, a `git fetch` command
>> +	is run. The refmap is custom to avoid updating local or remote
> 
> s/remote/remote-tracking/ definitely.  Do not forget the hyphen
> between the two words.
> 
> I think it made the above unnecessarily confusing that you ended a
> sentence after "is run".  It gives a wrong impression that you'd be
> doing a "real fetch", which you need to dispel with a follow up
> description of the refmap.
> 
> 	For each remote, a `git fetch` command is run with a refspec
> 	to fetch their branches (those in their `refs/heads`) into
> 	our `refs/prefetch/<remote>/` hierarchy and without auto
> 	following tags (the configured refspec in the repository is
> 	ignored).
> 
>> +	branches (those in `refs/heads` or `refs/remotes`). Instead, the
>> +	remote refs are stored in `refs/prefetch/<remote>/`. Also, tags are
>> +	not updated.
>> ++
>> +This means that foreground fetches are still required to update the
>> +remote refs, but the users is notified when the branches and tags are
> 
> s/is notified/are notified/???
> 
>> +updated on the remote.
> 
> Often, when one needs to say "X.  This means Y.", X is a suboptimal
> way to explain what needs to be conveyed to the readers.  But this
> is not such a case.  Unlike the "This means" that is often an
> attempt to rephrasing a poor explanation given first, this gives an
> implication.
> 
> But let's not start with a negative impression (i.e. even with
> prefetch, I still have to do X?  What's the point???), but let them
> feel why it is a good thing.  Perhaps (continuing my previous
> rewrite):
> 
> 	This is done to avoid disrupting the remote-tracking
> 	branches---the end users expect them to stay unmoved unless
> 	they initiate a fetch.  With prefetch task, however, the
> 	objects necessary to complete a later real fetch would
> 	already be obtained, so the real fetch would go faster.  In
> 	the ideal case, it will just become an update to bunch of
> 	remote-tracking branches without any object transfer.
> 
> or something like that?  

I like this clarification and have adapted it with minimal edits.

>> +	argv_array_pushl(&cmd, "fetch", remote, "--prune",
>> +			 "--no-tags", "--refmap=", NULL);
>> +	strbuf_addf(&refmap, "+refs/heads/*:refs/prefetch/%s/*", remote);
>> +	argv_array_push(&cmd, refmap.buf);
> 
> The command line looks somewhat fishy, but I think it is correct.
> At first glance it looks like a mistake to pass "--refmap=" and the
> refspec "+refs/heads/*:refs/prefetch/origin/*" as separate arguments,
> but I think that is exactly what you want here, i.e.
> 
>  - defeat any refspec in the configuration with "--refmap=<empty>"
> 
>  - give explicit refspec "+refs/heads/*:...", with "--no-tags" to
>    decline auto-following, to tell what exactly are to be fetched
>    and stored where.
> 
> The description in the log message about refmap needs to be
> clarified, though (I've already done so in the above suggested
> rewrite).

I could have made your life easier by referring to b40a50264ac
(fetch: document and test --refmap="", 2020-01-21) in my commit
message. It includes this sentence in Documentation/fetch-options.txt:

  Providing an empty `<refspec>` to the `--refmap` option causes
  Git to ignore the configured refspecs and rely entirely on the
  refspecs supplied as command-line arguments.

>> +static int maintenance_task_prefetch(void)
>> +{
>> +	int result = 0;
>> +	struct string_list_item *item;
>> +	struct string_list remotes = STRING_LIST_INIT_DUP;
>> +
>> +	if (for_each_remote(fill_each_remote, &remotes)) {
>> +		error(_("failed to fill remotes"));
>> +		result = 1;
>> +		goto cleanup;
>> +	}
>> +
>> +	/*
>> +	 * Do not modify the result based on the success of the 'fetch'
>> +	 * operation, as a loss of network could cause 'fetch' to fail
>> +	 * quickly. We do not want that to stop the rest of our
>> +	 * background operations.
>> +	 */
> 
> The loop that runs different tasks abort at the first failure,
> though.  Perhaps that loop needs to be rethought as well?

You're right. These maintenance tasks are intended to be
independent of each other, so let's try all of them and
report a failure after all have been given an opportunity
to run. That makes this failure behavior unnecessary.

>> +	for (item = remotes.items;
>> +	     item && item < remotes.items + remotes.nr;
>> +	     item++)
>> +		fetch_remote(item->string);
>> +
>> +cleanup:
>> +	string_list_clear(&remotes, 0);
>> +	return result;
>> +}
>> +
>>  static int maintenance_task_gc(void)
>>  {
>>  	int result;
>> @@ -871,6 +929,10 @@ static void initialize_tasks(void)
>>  	for (i = 0; i < MAX_NUM_TASKS; i++)
>>  		tasks[i] = xcalloc(1, sizeof(struct maintenance_task));
>>  
>> +	tasks[num_tasks]->name = "prefetch";
>> +	tasks[num_tasks]->fn = maintenance_task_prefetch;
>> +	num_tasks++;
>> +
>>  	tasks[num_tasks]->name = "gc";
>>  	tasks[num_tasks]->fn = maintenance_task_gc;
>>  	tasks[num_tasks]->enabled = 1;
> 
> Two things.
> 
>  - As I said upfront, I do not see the point of preparing the table
>    with code.
> 
>  - The reason why prefetch is placed in front is probably because
>    you do not want to repack before you add more objects to the
>    object store.  But doesn't that imply that there is an inherent
>    ordering that we, as those who are more expert on Git than the
>    end users, prefer?  Is it a wise decision to let the users affect
>    the order of the tasks run by giving command line options in
>    different order in the previous step?

I don't anticipate users specifying --task=<task> very often, as
it requires deep knowledge of the tasks. If a user _does_ use the
option, then we should trust their order as they might have a
good reason to choose that order.

Generally, my philosophy is to provide expert users with flexible
choices while creating sensible defaults for non-expert users.

That said, if this sort is more of a problem than the value it
provides, then I can drop the sort and the duplicate --task=<task>
check.

Thanks,
-Stolee
