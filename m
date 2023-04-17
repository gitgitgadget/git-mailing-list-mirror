Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752EDC77B70
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 12:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjDQMPH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 08:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjDQMPD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 08:15:03 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C294B61AC
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 05:14:31 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id he11-20020a05600c540b00b003ef6d684102so11732794wmb.3
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 05:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681733668; x=1684325668;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=agdwpTrYvocztlyDl6/zA0QMZcfE/sEWq0UwmFy1T54=;
        b=NjF5zsBbfCwyXoEkgcFmZTd/vyXwVDQBvT20oZci4O/rJRyMDxWjbVIuNXtqyZER58
         ArziehILgBLVpyqAojNj515TAs1rBVvLLyIBMajrFpz/J7SZGDaJNtEKho4wgWkje+UN
         zt/qh/SrbeqHr9qrC/6OOWovHVcX3DXw+SiX3sCpUvASQA8rNbkwWvSaDCXDR7e2cfkO
         2gwF87cAB3WpeTYDPEIUazCihdr6r2obUjU0JjItSyKDDv0Y2SifZw852bDfhCh/aofg
         DrFTFSqEw8mJzcsZZCH1RNiJ4ad07kmXA2v/7g94n8xi2q1NdKYDx3+kniRUgn01F+t1
         A1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681733668; x=1684325668;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=agdwpTrYvocztlyDl6/zA0QMZcfE/sEWq0UwmFy1T54=;
        b=FXu5MUHO4pn6eTrUcQrIz099RUmyBVFDI6VmLI1EzrTrl+tdWit9vmHnAWku0h0neM
         lepWDsccqBM4rYOiRKe9deTz+sHNw5nET0BM381RBmjNblGxpTSL9y1WVIf8KqfnYlV2
         W9fD3jQCHKrw7ggTt93wOGDuTobfnSNmBmmUr3l1VMzRcroBc/Z+UwOtUyiJZdr432li
         UQrXxgVdZ5SPD0LnMklx1Ph5M+W6CDU6bfuniXtfDyxLNuyS6fvHmtXFTPIiouL8j8PO
         Wnt0BQ+9H9MwY98mFv8ZUZhQpKWB5XKfEgzgORYTH3cU+yd5WpUUFvuqrqVpAqIE0NrN
         +bsg==
X-Gm-Message-State: AAQBX9eTHgTJQK2FRmu78e/o4vL0RkczawdtO7/sJMOP/m5qRsSOrTMA
        zaO+PnC23E1n1dHLS9P1zlE=
X-Google-Smtp-Source: AKy350Yey/KmmrKMLAOJEn5jFahQh24lRjW+BoEvdK/MvETnjoFSAYG2Vg6OGG/CQt8UVL74N0ufsw==
X-Received: by 2002:a1c:7713:0:b0:3f0:3d41:bda3 with SMTP id t19-20020a1c7713000000b003f03d41bda3mr10462963wmi.5.1681733668454;
        Mon, 17 Apr 2023 05:14:28 -0700 (PDT)
Received: from [192.168.1.195] ([90.253.53.152])
        by smtp.googlemail.com with ESMTPSA id p5-20020a05600c358500b003f09fd301ddsm14697264wmq.1.2023.04.17.05.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 05:14:28 -0700 (PDT)
Message-ID: <98548a5b-7d30-543b-b943-fd48d8926a33@gmail.com>
Date:   Mon, 17 Apr 2023 13:14:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Should --update-refs exclude refs pointing to the current HEAD?
Content-Language: en-US
To:     Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
References: <adb7f680-5bfa-6fa5-6d8a-61323fee7f53@haller-berlin.de>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <adb7f680-5bfa-6fa5-6d8a-61323fee7f53@haller-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan

On 17/04/2023 09:21, Stefan Haller wrote:
> The --update-refs option of git rebase is so useful that I have it on by
> default in my config. For stacked branches I find it hard to think of
> scenarios where I wouldn't want it.
> 
> However, there are cases for non-stacked branches (i.e. other branches
> pointing at the current HEAD) where updating them is undesirable. In
> fact, pretty much always, for me. Two examples, both very similar:
> 
> 1. I have a topic branch which is based off of master; I want to make a
> copy of that branch and rebase it onto devel, just to try if that would
> work. I don't want the original branch to be moved along in this case.
> 
> 2. I have a topic branch, and I want to make a copy of it to make some
> heavy history rewriting experiments. Again, my interactive rebases would
> always rebase both branches in the same way, not what I want. In this
> case I could work around it by doing the experiments on the original
> branch, creating a tag beforehand that I could reset back to if the
> experiments fail. But maybe I do want to keep both branches around for a
> while for some reason.
> 
> Both of these cases could be fixed by --update-refs not touching any
> refs that point to the current HEAD.

I'd use a detached HEAD for the "experimental" rebase and then update 
the branch if the rebase was successful. If you really want to use 
another branch you could try running "git commit --amend --only" before 
rebasing to update the commit date so the two branches don't point to 
the same commit.

We could add a command line option to restrict the branches that are 
updated by --update-refs but I'm not that enthusiastic about it.

> I'm having a hard time coming up
> with cases where you would ever want those to be updated, in fact.

If a user using stacked branches creates a new branch and then realizes 
they need to fix something on the parent before creating any commits on 
the new branch they would want both to be updated. e.g.	
	$ git symbolic-ref HEAD
	refs/heads/topic
	$ git checkout -b another-topic
	# fix a bug in topic - want topic and another-topic to be
	# updated
	$ git rebase -i --update-refs HEAD~2

Best Wishes

Phillip

> Any opinions?
> 
> -Stefan
> 

