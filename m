Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0417C433E6
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 13:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9960E64EFA
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 13:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhBYNXa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 08:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbhBYNXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 08:23:25 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129BFC06174A
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 05:22:45 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id a2so3965972qtw.12
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 05:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U7EPx87eyrZKkY6w47l9z+8uEzNh0IUuOwpH332WmlI=;
        b=ovbVLmUngNwf5aRQK+SpooCMpBxJ+n8pRjg8RAtg3c8RLZNBoZfVumEhTyxYt5ZOYh
         eXgDeB6eEZtMXGqGCPqjUP/tbw9ejgduKGbyssnV9yIXUgNCgBfOQ7TfO+AgWTJLvDu7
         Z7/AZk/rZbZJ9K1uw217GKPVCFpRK7xUGIwvLm+j5PdgVGeCQJM9qnMzrmw4z5i5RiNO
         aXKwpPargE5IjWJvVs1kQkmaOs/V0XJKjeNJLwgmeh2EVKyvQtAfnUrB5iBY+9QVPZTw
         Xvx/CPP70eC/eK0e1bWw72ro9EN9aeQW1Yo4LsDK4Z/beyRikNqhJPyT2uAASW8xVyeb
         CYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U7EPx87eyrZKkY6w47l9z+8uEzNh0IUuOwpH332WmlI=;
        b=couiIK7B/AZpCGk477dsQeDXStRglsQ7QcmJxueF6t1G7obOepkKik4Qb7dT4nsEJc
         PqIzhzwpKCDeOKK5hKgWAYBPz5cHTW947QPONX1t16iY4OA4duB/lbBmSJIDbsakG/bD
         +Z1zFAcwfbDEGx871cAGTdwufh/s50ZRfZbHmebL4aTOScHnvyW5EYRLWg6DiR8XAMCT
         EkXgfmEs1VaCqFJrJRjeT3/vRQBRI4H2xtxYSSQ27UEub9GFqlsgz9HMKfesfg8C/KK1
         waz2EuLpg9wLPyWi3Wyy8C8pgmyEZcZRWDEvXz0h+jEvA+2J2lUOXum0Z2cx/ghqpxgY
         IOhA==
X-Gm-Message-State: AOAM531nwt+XcUwD6LH1igJEEzpCPGzTqhXcnMft5bqQrZe1M70ks+p9
        mbTWK3IPXldft65EY93YfLTf3SaZt58=
X-Google-Smtp-Source: ABdhPJxNQgannyo3E3rAlFeYW8iscyfm/kvCJNbD84BEYXiLDQBckTlqskLZv7MWT+dRhgi5IWhpyw==
X-Received: by 2002:ac8:6684:: with SMTP id d4mr784112qtp.4.1614259364079;
        Thu, 25 Feb 2021 05:22:44 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id 18sm2871982qkr.77.2021.02.25.05.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 05:22:43 -0800 (PST)
Subject: Re: Help for the git patch with "---"
From:   Philippe Blain <levraiphilippeblain@gmail.com>
To:     =?UTF-8?B?5ruV6b6Z?= <dyroneteng@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
References: <CADMgQST4wSH+bt5auGuO6KYoQzyrkhnY2RY4Q1jGLVczGrMG+Q@mail.gmail.com>
 <CADMgQSR8cOJs_XGuArqRoRxes6RxxgitMvDFYhpYVGxg6A2VZQ@mail.gmail.com>
 <25082af3-e8fd-e9d6-e980-43871c5b4840@gmail.com>
Message-ID: <e87e2ad1-e133-54d3-3f3d-8602ac242f64@gmail.com>
Date:   Thu, 25 Feb 2021 08:22:42 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <25082af3-e8fd-e9d6-e980-43871c5b4840@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 2021-02-25 à 08:14, Philippe Blain a écrit :
> Hi Dyrone,
> 
> [CC-ing the list]
> 
> Le 2021-02-25 à 04:36, 滕龙 a écrit :
--snip--
>> I decide to remove it from the PR.
>>
>> So, did I deal the right way this time?
> 
> Well, if you are sending a subsequent version of your patch series,
> this space is usually used to summarize in words what
> has changed since the last version of the patch series.
> For example, for your v4 you could have written:
> 
> Changes since v3:
> - Improved <that> following comment from <insert reviewer name>
> - Reworded the commit message
> - etc.
> 
> This is a explained in the MyFirstContribution tutorial [1]. I would
> encourage you to do that if your series needs a v5 (I haven't read it yet).
> It's also a way to make sure that you modified your patch to account
> for all feedback you got in earlier iterations.
> 

Another thing: GitGitGadget adds a "CC:" footer in the PR description with
the email of every person that responds to your patch series on the mailing
list. This is then used to CC these persons when sending further iterations of
the series. So you should *not* remove these "CC:" footer when you update the PR
description to summarize you changes for each new version.
