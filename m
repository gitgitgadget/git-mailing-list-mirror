Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFD2C2BA19
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 12:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E292A22240
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 12:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JM8glJQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgDFM5k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 08:57:40 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37911 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgDFM5j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 08:57:39 -0400
Received: by mail-ot1-f65.google.com with SMTP id t28so15149913ott.5
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 05:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dj2JuVLrEg8TAt2Xhedhj6qkvmi5PEqtsUq6blBKqFQ=;
        b=JM8glJQZsVqgFrMAinietDDDdV5J8vEari0F6Bb56afAun9xQ4NadNTErpLrFF24WU
         XwK6bRDyRTmcN/SBeXbR61NUStOUW6WUi6hGFCFQiB1dfyI0+JO5co8euL1rRL9kTAQI
         BKYRj6Jlh5CU6wZjp0JsBLyYFSqG0Jls5mdcmdq8pvMcE3VTAtH+lmZMORcjRHo/881q
         TxPFXUImTqDfjRHrFuLJb7fJshdL7hmwTRjm8mdchbHVSbia3dgbz1HDhrfhMd9343ME
         nlxjURrNQ7FQrdYuHuBo9t91IeKhtOh0t60i/LZ/xQvDHh4pCaqy90LeHB61Knt0Dz89
         z2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dj2JuVLrEg8TAt2Xhedhj6qkvmi5PEqtsUq6blBKqFQ=;
        b=C4fjfn9lNyESjZtfIhj/23fPcGj1VVO4IvRZHYySxz0nGpNhRY3DyK/qGOUwtbidZd
         0T5gSfs+ACKrouO7PYFyMsd73fleSg8hO2ceYBVpdjaYTUAs8iyfQuFc170vBr6qPDCq
         DQCTFaeLxJ46l6LNZzdE0z511wF9md4B0H1ygSPVlqDe6dgWGULmtdsjEuQEMugveuUz
         r54ctdiSz8eeWU6SZ7IMIr/mxRGka1rYZIZBDQHnpOJ7/7h/XX2r5DZ5Mptt7Fv8uuYW
         yCDt6uwRmZ5apz8Yt50LOryHoklAQXe+OBeHG8zhj2xdfv6lqbN36TYtc1Q88hklQX11
         CBbA==
X-Gm-Message-State: AGi0PuY5w66MOTojchA6D+UJkxzFOTY7qMfmEc5mBKq6SO3vm/5GbX+Q
        Ai5LRxwx0+Wli6acZd3RYSpVYvu8eKo=
X-Google-Smtp-Source: APiQypKibj0vOZ8UmnA3ekkqzZzBGJ3E4J4MSQA1qBzIKh4P//iO+jAwsB40ooCZHCpQBHhOJN6aKg==
X-Received: by 2002:a9d:6ad2:: with SMTP id m18mr18193628otq.28.1586177858709;
        Mon, 06 Apr 2020 05:57:38 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id u13sm4423789ote.48.2020.04.06.05.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 05:57:38 -0700 (PDT)
Subject: Re: [PATCH 09/15] job-runner: load repos from config by default
To:     phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@google.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
 <9104ae46371a08967805f6ce27586ccade37972a.1585946894.git.gitgitgadget@gmail.com>
 <45ce32bc-8b47-76d6-47ed-03028df55e53@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c276e2a7-5dfc-ad3a-9b80-68c12eef02af@gmail.com>
Date:   Mon, 6 Apr 2020 08:57:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <45ce32bc-8b47-76d6-47ed-03028df55e53@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/5/2020 11:41 AM, Phillip Wood wrote:
> Hi Stolee
> 
> On 03/04/2020 21:48, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The 'git job-runner' command was introduced with a '--repo=<path>'
>> option so a user could start a process with an explicit list of
>> repos. However, it is more likely that we will want 'git
>> job-runner' to start without any arguments and discover the set of
>> repos from another source.
> 
> One thought that occurred to me was that it might be convenient to put
> 'git job-runner $HOME &' in my .bashrc to have it start on login and
> find all the repositories under $HOME without me having to list each
> one (and remember to update the list each time a clone a new repository).
> There are a couple of issues with this
> 1 - We only want to run the jobs once per repo, not for each worktree.
> That should be easy enough to implement by checking if we're in the
> main worktree.

This idea of "please check all (immediate) directories under <dir> for
repositories to run maintenance" is an interesting one. It certainly
could be added later.

Your concern about worktrees is actually not a big deal. Since we check
the config for the "last run" of a job on a repo, we will not run the
same job immediately on a worktree after running it on the original
(unless the interval times are incredibly short).

> 2 - If I start several shells I only want one instance of 'git
> job-runner' to start. One way to handle that would be for the runner
> to hold a lock file in the directory it's given and quit if the lock
> is already taken. It should probably walk up the directory hierarchy
> to check for lock files as well in case I try to start another
> job-runner instance in a subdirectory.

This is an interesting idea. My gut reaction is that we don't want
to prevent users from running multiple processes if they want to. But
if they run the process twice in the same directory then they are
likely to be running on the same set of repos (barring "-c jobs.repo"
or equivalent).

Again, my hope is that we would solve this problem by having a cross-
platform "job service" that makes the user setup of editing .bashrc
irrelevant. Not only is that idea getting push back, we should allow
expert users the ability to customize these steps to their delight.

Thanks,
-Stolee

