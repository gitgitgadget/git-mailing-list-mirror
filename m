Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE16C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 12:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F6D64EB9
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 12:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhBIMnd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 07:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhBIMnF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 07:43:05 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3687C061786
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 04:42:24 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id g84so5450346oib.0
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 04:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9v6WlIjIyhayQL8CNZJOHzBguEHXfT2zKWvqbqohyqM=;
        b=mToWaeGZ0EzFPiftFxM/DLT7jzkBbt8vQ3FSKCQlsmz9L9Mr3Sk9pbR5/SZqqaEhUQ
         0XaabgLNokNX979sRx6u72RETOfHFljLWJnE5rWLUZIMK/81ojfmc5TY3aIgBBjk8b3L
         sZsJR7hrpuhA2UflhFotSSIM78J7wquKfEvb3eUCESs3m9n09M3HfY6jrrjrKac6jaac
         nGihCeWYB1mTu7aEK7kPvERjIrFFQKKZ6UT03CfuUGcm6kjF2lMxxv84GXEwcI1k1QI+
         SZ6qLw10LO4zgpjoTtWxHj/yN+9xJJWbw80exUAf+c8HS1z4YbbP2j2OR4ScE6CHrXvQ
         Y+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9v6WlIjIyhayQL8CNZJOHzBguEHXfT2zKWvqbqohyqM=;
        b=CDvsSJQcNagiw+hb1WDxPrnZRn82OPEgcxQwMdNTXg281Ii3GTevyxBb1BTKto9zvR
         9xqeXeUT2R6aZL3kPS6ILV11ayvhRpxrp4e91g5MC+TUv4W+IscM/Bxt4OzkGQqYEEHQ
         408/aFE7AgJtsNgR9FNTkhxYs8K+uSvc8NXJdIMcRH6bsbfVfIXyVBNwBJ2Yfou9Erdu
         IooqRZYVC6kkxc0s5onXdnWXfskQcsY8mi56wdfmsgAsnNKVm+Eh6iv6l31nbxw/v5BX
         BlmPX45/CBrDH4k84vRBrVZZV4KL0eV9SHx74JSq1HMhOo+1wWJXurgQ8NEtyM0NRm5L
         ejsg==
X-Gm-Message-State: AOAM533ohFniNPw8GrYErqU6WFTQVs6f0rvQqrKwI4oYzC/LEkf3Ints
        Il4zvItfKh99r8h1QZReylU=
X-Google-Smtp-Source: ABdhPJxqsNOvix0WfLxmPx40B4W8TuvzXgMPFhbRj+GyHZy6eGEqo1+mwGD8mAMvh0hL14AgmrDqUA==
X-Received: by 2002:aca:3944:: with SMTP id g65mr2269723oia.66.1612874544079;
        Tue, 09 Feb 2021 04:42:24 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:7c18:1f04:a165:5ea0? ([2600:1700:e72:80a0:7c18:1f04:a165:5ea0])
        by smtp.gmail.com with UTF8SMTPSA id w10sm540603ote.29.2021.02.09.04.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 04:42:23 -0800 (PST)
Message-ID: <f8df68ee-32a9-4bd1-99d9-4641b582992d@gmail.com>
Date:   Tue, 9 Feb 2021 07:42:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH 1/2] maintenance: add pack-refs task
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sluongng@gmail.com,
        martin.agren@gmail.com, sunshine@sunshineco.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.871.git.1612795943.gitgitgadget@gmail.com>
 <33b7a74af4eb45756c3648eb7b002d06e4ec3563.1612795943.git.gitgitgadget@gmail.com>
 <YCHA991dv0V0hNb+@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <YCHA991dv0V0hNb+@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/8/2021 5:53 PM, Taylor Blau wrote:
> On Mon, Feb 08, 2021 at 02:52:22PM +0000, Derrick Stolee via GitGitGadget wrote:
>> +pack-refs::
>> +	The `pack-refs` task collects the loose reference files and
>> +	collects them into a single file. This speeds up operations that
>> +	need to iterate across many refereences. See linkgit:git-pack-refs[1]
>> +	for more information.
>> +
> 
> Do you think it's worth documenting here or in git-gc(1) that running
> this has the effect of disabling the same step during gc?

It doesn't disable the step during gc.

Perhaps I should use a better term than "extract". The 'gc' task shouldn't
change as we make some of its steps also available as independent tasks.

Instead, users can select a subset of its steps by enabling them directly.
Other such tasks could include:

 * prune-reflog
 * full-repack (as opposed to the existing incremental-repack task)

>> +struct maintenance_run_opts;
>> +static int maintenance_task_pack_refs(struct maintenance_run_opts *opts)
> 
> It may be worth calling this "unused", since you explicitly pass NULL
> below.

Good idea.

>> +	if (pack_refs && maintenance_task_pack_refs(NULL))
>> +		die(FAILED_RUN, "pack-refs");
> 
> Hmm. Am I missing where opting into the maintenance step disables this
> in gc? You suggest that it does in the commit message, but I can't seem
> to see it here.

My commit message suggests wrong.
 
>> +test_expect_success 'pack-refs task' '
>> +	for n in $(test_seq 1 5)
>> +	do
>> +		git branch -f to-pack/$n HEAD || return 1
>> +	done &&
>> +	git maintenance run --task=pack-refs &&
>> +	ls .git/refs/heads/ >after &&
>> +	test_must_be_empty after
> 
> Worth testing that $GIT_DIR/packed-refs exists, too?

That would start breaking if we change the backing store, right? I
want to be sure this doesn't create test breakages with reftable.

I _could_ add a 'test_subcommand' check here, though.

Thanks,
-Stolee
