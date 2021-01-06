Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BB1C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 11:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D011423104
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 11:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbhAFLgj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 06:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbhAFLgj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 06:36:39 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74B7C06134C
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 03:35:58 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id p14so2143011qke.6
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 03:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P+tclsDwMB7ljR6HQLw5SpGAKxeTzh1Z8gc9tx0D0SM=;
        b=oPXG/dVZ+rRPIwCUCWwJMqgAQez/ILoBuBXPHZv+TTLpkMUog/XOGEpcljV5oRrO1k
         lndw+4CYcGbBYjF24Ozf1TUlwxZ7HPYgshUyWENNELfy9hj3cixhnOP/DfEupNFDdV9V
         fyCY3bIO8CSBUU5pdCUjtUSdj3XSJXU+BNZZ/YQuGoRooXUnBrWxLL5nvEtTeO20jBrM
         l0ihxoDNHuz6fNmdBzGSrqDMdZEWD1kr8UUxYsyWo5TUkqQa4afJ0g5zBfwru66Fq5QA
         7MhSgewZTfcjE3L66/Q5olTusc7Wgq5jqNQLpIcdfe4D27RNILDXP9WhD0bVUrIejsWB
         aFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P+tclsDwMB7ljR6HQLw5SpGAKxeTzh1Z8gc9tx0D0SM=;
        b=WIbd22dp37xn+6Zse0YlrDUxPLJCOQ88wnnuiPAmWhSJ6l0NXeaQF04C/bpmBz58SK
         bbbiyVGjVK0LhAmEI26f+yOygk/+9TMV9BzgMUyvZm9TfLX++R7+0/MqQBHpyEZEFZH0
         dVJyrjsx1yC0XsVxqam7WuSmr88A6zbI5Et/dZXE1cGf55uUwPZBVtNMee3NW8v8bPYH
         9KT5IGCgIEkErk0Q78/PZTpZVHb/3ixbpJcWPycm9YBJ7sLhqCf5QgLw8IKgKAHFG2DG
         W/L9wMCsB6v4Dl1s7SF99bZZPbg2r0+gFDzFsZFSZc0AbLDtyU0Nfr8Aye/L8LRkRs7o
         qAoA==
X-Gm-Message-State: AOAM530q3/KPcM96RnZqI5Yldp4Rib0cQwiYyPSnki1nvXrmUY67AWqI
        Z/l/FgLGZK9CYOZoaTX5Ol4=
X-Google-Smtp-Source: ABdhPJwvu7wy8EQQ4GOLyAvS6NwGZgdtlTGJ94w9rpBgxLbA1ksM9JxS77cEpPrCrAAaof5pYuUVmA==
X-Received: by 2002:a05:620a:147a:: with SMTP id j26mr3782508qkl.190.1609932954994;
        Wed, 06 Jan 2021 03:35:54 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id c7sm1150749qkm.99.2021.01.06.03.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 03:35:54 -0800 (PST)
Subject: Re: [PATCH 00/12] Remove more index compatibility macros
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
 <xmqqczyiwwgl.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a93359c3-66bf-80bc-f053-4742563163d0@gmail.com>
Date:   Wed, 6 Jan 2021 06:35:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <xmqqczyiwwgl.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/5/2021 10:55 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> My strategy for update-index was to create static globals "repo" and
>> "istate" that point to the_repository and the_index, respectively. Then, I
>> was able to remove macros one-by-one without changing method prototypes
>> within the file.
> 
> Knee-jerk reaction: swapping one pair of global with another?  Would
> that give us enough upside?  It may allow some codepaths involved to
> work on an in-core index instance that is different from the_index,
> but does not make them reentrant.

My intention was to reduce the use of globals in libgit.a while keeping
with existing patterns of static globals in the builtin code. While
this can be thought of "module variables" instead of true globals, they
aren't exactly desirable. In v2, these static globals are temporary to
the series and are completely removed by the end.

The new patch sequence can hopefully be seen as "this preprocessor
macro was expanded" and then "static globals are replaced with
method parameters" which are pretty straightforward.

> Do we now have callers that actually pass an in-core index instance
> that is different from the_index, and more importantly, that fail
> loudly if the codepaths involved in this conversion forgets to
> update some accesses to the_index not to the specified one?
> 
> If not, ... 
> 
>> In total, this allows us to remove four of the compatibility macros because
>> they are no longer used.
> 
> ... a conversion like this, removing the use of the compatibility
> macros for the sake of removing them, invites future headaches by
> leaving untested code churn behind with potential bugs that will
> only get discovered after somebody actually starts making calls
> with the non-default in-core index instances.

Perhaps I had misunderstood the state of the conversion project. I
thought that the full conversion was just paused because Duy moved
on to other things. I thought it might be valuable to pick up the
baton while also thinking about the space.

If this is _not_ a valuable project to continue, then I can hold
off for now.

Unfortunately, we'll never know if everything is safe from assuming
the_index until the macro itself is gone. It helps that libgit.a
doesn't use it at 

> I've come to know the competence of you well enough to trust your
> patches like patches from other proficient, prolific and prominent
> contributors (I won't name names, but you know who you are), but we
> are all human and are prone to introduce bugs.

That means a lot, thanks. And yes, I'm well aware that bugs can be
introduced. I've added my share.

> That's all my knee-jerk impression before actually reading the
> series through, though.  I'll certainloy know more after reading
> them.

I look forward to your thoughts.

Thanks,
-Stolee
