Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB156C4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 13:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6127523741
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 13:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDRqM8HV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgIXNp0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 09:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbgIXNp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 09:45:26 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E497DC0613CE
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 06:45:25 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id o5so3222580qke.12
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 06:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MMJpHQD+XzNVsKmm6lHFvaVxHhPHKNbJBJFxDLIsqVE=;
        b=YDRqM8HVoNoCZHY7soe4FXfR1ZrscAJHFMOk5VVnzV/8CzL3THRUBFw874VnFzdOHz
         KZCJA4d0zg3fTTZbhWO6AyKjO1Wl2RGbEt66B835aofJBzG85D0TaRotAfRznXntTF9Q
         S6F0YLk6P/ImzZnsWwYLvwFYuigMpAaZt/W38JUz/995PPhJQqQVzndVzbIgFftVv7CI
         YvON1OnZU3C4FqvXJKL+JHrUGBuzGMj2S7L0+pcI06gub1Z4UK06eMS5QlBrIPymqgWL
         fC+f03dbgruemlRNfk/WPFlLPLvnVdwb8yhjqdmAKnx4u21PU1qbeNG1b1USKIYGPypB
         QwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MMJpHQD+XzNVsKmm6lHFvaVxHhPHKNbJBJFxDLIsqVE=;
        b=pRQycnKI8JbYbjz7LxAiV/bqsOy4M0mAXG1GWqOZSw3pnAza/mLd/J/f+eJ0+I+iVP
         lH2GtPlq2wiFudstM46vOEpd/j/hUbua17cyXoccoBeXWJJYQktHApdi5BgB/QmT0N7n
         EgkQauJzjYCnL3uC1p7Wor49clHU9xtCpNcR1RnRb06cXEz9uqQq61bZNZ0aXs8VfBYe
         e/jP8NaxNREQeYrLx9iRnAZmxiA+YncyZYfjEFsQVNrvc9TtQ4n49Uqecmkbts/IWZrJ
         fzYBzRwTHXAXX7Qjdk6t4hNiFnKf5SbFaoXCf4y7dCqvFhcoAlrE73bB89WQxe5JJ/56
         4lQA==
X-Gm-Message-State: AOAM532caG7dZ9ag2BTOmzZ1rDqprvUa3C+yuttt3TQdFRs2kKtosv/B
        SCD0sdVeiUhSMh3Bl3FRycifvIHwssRa688i
X-Google-Smtp-Source: ABdhPJz1v0xKfcF9hDMEkYBwuhHGy2YBYXfo8pc3WJu6rfV/rvM/RkVjhPRp/r7BKxQ5eta0aIkjrQ==
X-Received: by 2002:a37:48c6:: with SMTP id v189mr4984988qka.378.1600955124907;
        Thu, 24 Sep 2020 06:45:24 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:79a4:d6bb:a424:ecd4? ([2600:1700:e72:80a0:79a4:d6bb:a424:ecd4])
        by smtp.gmail.com with ESMTPSA id p187sm1972928qkd.129.2020.09.24.06.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 06:45:24 -0700 (PDT)
Subject: Re: [PATCH v3 2/8] maintenance: add loose-objects task
To:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        derrickstolee@github.com, dstolee@microsoft.com
References: <75e846456b8ac4a3518ecc9051c927539dd7ff08.1598380599.git.gitgitgadget@gmail.com>
 <20200922230937.906065-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <446e805a-6b83-a6b7-18a3-f99ac85a6fe1@gmail.com>
Date:   Thu, 24 Sep 2020 09:45:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <20200922230937.906065-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/22/2020 7:09 PM, Jonathan Tan wrote:
>> Create a 'loose-objects' task for the 'git maintenance run' command.
>> This helps clean up loose objects without disrupting concurrent Git
>> commands using the following sequence of events:
>>
>> 1. Run 'git prune-packed' to delete any loose objects that exist
>>    in a pack-file. Concurrent commands will prefer the packed
>>    version of the object to the loose version. (Of course, there
>>    are exceptions for commands that specifically care about the
>>    location of an object. These are rare for a user to run on
>>    purpose, and we hope a user that has selected background
>>    maintenance will not be trying to do foreground maintenance.)
>>
>> 2. Run 'git pack-objects' on a batch of loose objects. These
>>    objects are grouped by scanning the loose object directories in
>>    lexicographic order until listing all loose objects -or-
>>    reaching 50,000 objects. This is more than enough if the loose
>>    objects are created only by a user doing normal development.
>>    We noticed users with _millions_ of loose objects because VFS
>>    for Git downloads blobs on-demand when a file read operation
>>    requires populating a virtual file. 
> 
> [snip]
> 
>> This has potential of
>>    happening in partial clones if someone runs 'git grep' or
>>    otherwise evades the batch-download feature for requesting
>>    promisor objects.
> 
> This part is not strictly true, as even when Git lazy-fetches one
> object, it fetches it in the form of a packfile - so maybe remove this
> sentence.

This is a good point. I just did some testing and we do store these
single-object downloads as pack-files. My misunderstanding is due to
my own bias and experience with the GVFS protocol.

I have also heard that "git fetch" might explode some small pack-files
into loose objects, and I guess I expected the same here. However, that
is not the case for partial clone. I'll remove this.

> This is nevertheless a good feature to have - loose objects may not be
> created during lazy fetches, but they definitely are created during
> normal operation (e.g. commits). Git, as a whole, prefers packfiles over
> loose objects, and just packing the loose objects themselves instead of
> running repack (which goes through all reachable objects) is definitely
> better for large repositories.

Thanks,
-Stolee

