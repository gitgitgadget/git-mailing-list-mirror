Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CDDC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 13:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61B09600AA
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 13:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbhH3Nbo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 09:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhH3Nbm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 09:31:42 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6D3C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 06:30:49 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id y3-20020a4ab403000000b00290e2a52c71so1870897oon.2
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 06:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3B6lii4VGHBtYpLEdSPn61wBS3M1SrpBvOg/JByMVw4=;
        b=f8PXKY9HoFWhzQ4395jkOujaXU0u43XFXu7yH8+3tpyDaShOEhC1l4zZMiX+ITiYli
         2U6728Gt8S4hiJ9kqBBLyud1gJkMFJUpno1JbznpApDXRB6AEZeIBM2s/I/pzqYiD0Gw
         uP3AgyzUFhBg1dz9awwZFSrCjT34ntXl5K4hFi0LRd9kQZeLoHmS4j/qYGglRzTQzyZs
         LkfRUbX5Y1OYHSTrNbexl4RfkmuTZD+K0e3YBvN/uUtf05wsTphRls/B7XIjhToHdnRg
         2F73KVgbyOzgJT/b4SxsLTX3bddBoPcwhcQmH+6TNDuxEJtkXgAG/qGmkPqfLWza14OK
         /v7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3B6lii4VGHBtYpLEdSPn61wBS3M1SrpBvOg/JByMVw4=;
        b=DzBNZ79H1uLklf0GTjgYn8GQTa2Iyq1nsPKN5MW0FBB+WCpWO2o3eU0dBEShgWKw7P
         HpsD5Ie/eP08gN3TfK2VXqb39wNI1gmKAM+HFZxNyR80/Csqf9XdBhiyZkAyLt/jCWqr
         kypHHsSwE2LqoMDlZyP+uCLrIvi0YsPYavNt48aF359OPkWDMNMocbcRUfVN/02wynmq
         DpIPamqo1MGo1m0rMKITpHWr7VOkCKnAieZzZJF1EFujwOMU62DJUxoukLOfHfmdv3qM
         FvqP8hTEl0aCw7x83TWxQ98QBAPTtT2SXMcNI+WGbcnelFdAzb146RT3F0fYA1QEc2G7
         OtoQ==
X-Gm-Message-State: AOAM5326UlpcPUT6tgyML4ZAcPdDsO0MCITsQ5X/REp8F0M7l1F83s5w
        K7UbNgZs642+usmqPSY9DKQ=
X-Google-Smtp-Source: ABdhPJwoCkc7vvPUeRBcjg+9h4JjKyptH9LRJtJ4NA89+qxsqIHtfBVx382b1qsSWNpQup6+Cx+Mpg==
X-Received: by 2002:a4a:6f4a:: with SMTP id i10mr10247360oof.64.1630330248580;
        Mon, 30 Aug 2021 06:30:48 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:f479:1655:2af5:7e8e? ([2600:1700:e72:80a0:f479:1655:2af5:7e8e])
        by smtp.gmail.com with ESMTPSA id j70sm3247479otj.38.2021.08.30.06.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 06:30:48 -0700 (PDT)
Subject: Re: [PATCH v4 10/10] sparse-checkout: add config to disable deleting
 dirs
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
 <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
 <8d55a6ba2fdf64cee4eb51f3cb6f9808bd0b7505.1629841904.git.gitgitgadget@gmail.com>
 <CABPp-BGeJJBF0ZmS7ZHcqFmXwXmgVH1Uox_6gNHzcacG2vRjVw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d63d5d18-bdb3-e13b-ae36-e7e6cf10be39@gmail.com>
Date:   Mon, 30 Aug 2021 09:30:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGeJJBF0ZmS7ZHcqFmXwXmgVH1Uox_6gNHzcacG2vRjVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/27/2021 4:58 PM, Elijah Newren wrote:
> On Tue, Aug 24, 2021 at 2:51 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The clean_tracked_sparse_directories() method deletes the tracked
>> directories that go out of scope when the sparse-checkout cone changes,
>> at least in cone mode. This is new behavior, but is recommended based on
>> our understanding of how users are interacting with the feature in most
>> cases.
>>
>> It is possible that some users will object to the new behavior, so
>> create a new configuration option 'index.deleteSparseDirectories' that
>> can be set to 'false' to make clean_tracked_sparse_directories() do
>> nothing. This will keep all untracked files in the working tree and
>> cause performance problems with the sparse index, but those trade-offs
>> are for the user to decide.
> 
> I'm not sold that we need anything here, and it sounds like this is
> all being added based on a theoretical concern.  I might not object
> too much normally to trying to address theoretical conerns with new
> features, but:
> 
> * I'm a little concerned that we're adding a configuration option
> (which live forever and are harder to work with
> backward-compatibility-wise) rather than a command line flag.

The issue with a command-line flag is that it would need to be added
to all the commands that reapply the sparse-checkout definition.
Maybe that's just the 'git sparse-checkout (init|set|add|reapply)'
and 'git read-tree' commands, but are there other places where this
logic might be applied in the future?

Also, as more third-party tools integrate with sparse-checkout, I
don't expect users to be directly involved in changing their cone,
so any use of a command-line flag would need to be integrated into
those tools. A config option applies this logic universally, when
needed.

> * It's not clear to me that the option name is what we want.  For
> example, git checkout has a --[no-]overwrite-ignored for overwriting
> ignored files (or not) when switching to a different branch.  git
> merge has the same flags (though only the fast-forwarding backend
> heeds it currently).  This behavior is quite similar to that flag, and
> has the same default of treating ignored files as expendable.  Should
> the naming be more similar?

I'm open to changing the name to more closely match existing naming
conventions, once we've decided if this should be included at all.

> * It's not clear to me that the option has the right level of
> implementation granularity.  If someone wants ignored files to be
> treated as important, should they need to set a
> merge.no_overwrite_ignored AND a checkout.no_overwrite_ignored AND a
> index.deleteSparseDirectories AND other names, or have one high-level
> option that sets all of these behaviors?

These cases have different meanings for why an ignored file is
important. For merge and checkout, the argument is saying "don't
overwrite ignored files if they are to be replaced by a tracked
file". For sparse-checkout, the config is saying "don't delete
ignored files that are leaving the sparse-checkout scope". I think
it is meaningful to say that files that match the .gitignore
patterns but are still tracked are deleted, because sparse-checkout
removes all tracked files.

I'm less convinced that there needs to be a meta-setting that covers
all of these cases simultaneously.

---

As for moving forward, I'm fine skipping this patch if there is no
support for it. I just wanted to demonstrate that it could be done.
Perhaps we wait for the theoretical concern to be a real one, as
requested by a user with a legitimate reason to care?

Thanks,
-Stolee
