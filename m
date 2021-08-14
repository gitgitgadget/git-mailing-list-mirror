Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF53BC4338F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 20:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C185160C3E
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 20:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhHNUCY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 16:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhHNUCX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Aug 2021 16:02:23 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5961C061764
        for <git@vger.kernel.org>; Sat, 14 Aug 2021 13:01:54 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id i10-20020a05600c354ab029025a0f317abfso12041976wmq.3
        for <git@vger.kernel.org>; Sat, 14 Aug 2021 13:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3WOs4eYM8yQnI8ki5n2mnNA4ZPX8WundO4DYwRlR8pc=;
        b=aPkJ4Ds6Cg4DvhDRKARv89hPA9qprqyI41yD+9BUD/uUoeKa6njCLsGFGc2a3cTcZ+
         pOu9E+nvr2Gj1sq0w4RvAIghYtC4wlWfMxeSe84oiYgyhcfdU8zZiFd6XWqX7PZxunek
         98CDZo46vFJKaFV4HEcVpdKwjt+GhxeZ8xyxFQ8iBMni4TjCUbqTNrCIOyLO7FhndRVI
         KHSyptbVhYKE/ZNlV6TQ5CUwh69VHbIn1KzMa51H6CCO1QPF8rJS4CITano84SlHxIMg
         aELyIJ0QUqzcB8nljMQcsENq1a+ECt9L5TjY94PN4oGL0f9SEpmqslwGQXt5gCyTmu0e
         vLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3WOs4eYM8yQnI8ki5n2mnNA4ZPX8WundO4DYwRlR8pc=;
        b=fkpp3W4azNwPlOSzI+YWcRVCK/3c8V+oM22ipIrV0949ElvE2YWVrSt0iJfkqSaaZI
         NEl4B/alXXdhBTLZk6mp6Rt7ALdunNNapagYkCN/WvFGK3xEzF1d9t7x1NzLioE1821K
         HwIaY40vns7nRL9kcj5qkVBqK2IpUlHwIys8DuF0ECy81bJHqO6VXgIhcIhWskTGJfNs
         ZTN2kRPL6+HgbpP1VY8j32jAXVr1MhBLZBP7G0EddgLYyWTEF9YLX/oFOe7lq9iEwHSG
         5rmyGQkG1aDLGNqv3gf0wM3ZadeWSp8agDkjMT213UbEWvCJUUQI66E3T4bgq/7z6B2D
         Z90Q==
X-Gm-Message-State: AOAM531WCtuTt49qwiZaiH6ANM65tb+PA/Jd8qw7xE7Zlxm7BW05ffIt
        VXWXlyTG2Mqnh8XQH+WORF8paZXzvng=
X-Google-Smtp-Source: ABdhPJzDGFqIiKHcKTUg8QMusipUQCV/IaNYqbfK4v8FQ29ZwzcU4EIW9NTKN2nIgMoI6uXlqRMQJg==
X-Received: by 2002:a1c:2390:: with SMTP id j138mr8484155wmj.51.1628971313231;
        Sat, 14 Aug 2021 13:01:53 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id z1sm5543419wrv.22.2021.08.14.13.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Aug 2021 13:01:52 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/3] rebase --continue: remove .git/MERGE_MSG
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1013.git.1628587917.gitgitgadget@gmail.com>
 <pull.1013.v2.git.1628775729.gitgitgadget@gmail.com>
 <028c9dfc460b6c00bf481017a07a2a6d37780a76.1628775729.git.gitgitgadget@gmail.com>
 <xmqqa6lluexv.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <549ebc1e-2b3d-786b-6467-40fb521ea0cc@gmail.com>
Date:   Sat, 14 Aug 2021 21:01:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqa6lluexv.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/08/2021 00:01, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> If the user skips the final commit by removing all the changes from
>> the index and worktree with 'git restore' (or read-tree) and then runs
>> 'git rebase --continue' .git/MERGE_MSG is left behind. This will seed
>> the commit message the next time the user commits which is not what we
>> want to happen.
> 
> I just remembered that "git rebase --skip" option exists.  Would it
> have the same issue if used at the last step?

--skip calls rerere_clear() which unlinks .git/MERGE_MSG. This patch 
adds a test for --skip as well as --continue.

Best Wishes

Phillip

> 
> [Footnote]
> 
> I am not saying that it is an error to use "git restore HEAD . &&
> git rebase --continue" when you'd usually use "git rebase --skip".
> 
> Nuking the difference the working tree files and the index has
> relative to HEAD and telling the machinery to continue gives the
> signal that the "conflict resolution" happened to have resulted in
> an empty change, which should yield the same resulting history as
> "git rebase --skip" would, because the resulting empty change should
> be dropped (unless --empty=keep is in effect, that is).
> 
