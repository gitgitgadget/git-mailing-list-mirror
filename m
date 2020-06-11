Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C66C433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 11:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A94D12078D
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 11:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFr5G4LN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgFKLct (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgFKLct (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 07:32:49 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98CDC08C5C1
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 04:32:48 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id y1so4231456qtv.12
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 04:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cn4aKU6f4ZOsFXywcseLDiRMXjvmPM0UfEYvci1eTk8=;
        b=QFr5G4LNRKqXenMbIeFlYybCuJ07vIpWIwbYPRfiWRnTNPzPyEja0H3aMq7k/j+Q7B
         tSMnLl1kjk13yk0DQnUVCstpuXlV9tlzDLzODblhrsmCN6EdI02QpFrd6GVCwKuCs9Ox
         98fvzwvmkKC1ALBFoUxU5MvMM0aET56RAhk0vAMPnEX2sT+bcciRIziZJRJfCXJm4T86
         vaRHl9oNClhwWsUdA1hHu/3XfDErKq2H47qX3zKhp5HYd/luFfMEfy1+XFxLYkTTa2ab
         ngoTNZHt5KOq3ByQUfGGwlR5rAoTejRoZAOiqHItKJ2/cLyFHOXQbSQ/Yd7bwa1pgjaN
         LWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cn4aKU6f4ZOsFXywcseLDiRMXjvmPM0UfEYvci1eTk8=;
        b=tIWWN4O6xN8wROo8uAfbGZaksAKzk1ZF0rFwZ4+dZ4lfD2on09lXLJOWwNup7C0LUY
         NjnjPYDQs8RrBtA/qIa5xbcy8Dnb9XRGEysyeXwRUsyD5Um4wCzxuWsXMM3ZWuJKHPk2
         eyKYQ5EiyidCaiOOD6A6AxOEaH0iMgXFlagJk+YUusBznkc71P+dO/h0qHRtDCv4kGK7
         r7G0fG1M8UQyS2NJFklzLb7HaH5QO7yPNGqh/u6QRJrogcB1fwbifuO9n6v9eEpdv6un
         6ptnISVH/fCey+8ZzM/hyd6PdPZAJIfmJR5nxrh6lKZXga5n5YWv/oPWjsQ6Gu1/1Fmf
         2cSQ==
X-Gm-Message-State: AOAM533IU0hlMFpmbJpDu92vzBp5HSOL1XJk2e4A0D2AiMJscEYY35uo
        SLsoqVjzqct2KIsQUsIuO1Q=
X-Google-Smtp-Source: ABdhPJzAY7yRlOynk/Q7R6VvmGSGrabHfHSKc6K/1pkhzXfvzBIOz6Pp6rUCnIikltmFrtSZNFLIAw==
X-Received: by 2002:ac8:1844:: with SMTP id n4mr7792447qtk.142.1591875167995;
        Thu, 11 Jun 2020 04:32:47 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id v59sm2198516qte.96.2020.06.11.04.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 04:32:47 -0700 (PDT)
Subject: Re: [PATCH] git-sparse-checkout: clarify interactions with submodules
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     matheus.bernardino@usp.br, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>
References: <pull.805.git.git.1591831009762.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c135d73b-1688-7ea7-5b98-8cc6418cd4ff@gmail.com>
Date:   Thu, 11 Jun 2020 07:32:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <pull.805.git.git.1591831009762.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/10/2020 7:16 PM, Elijah Newren via GitGitGadget wrote:
> +If your repository contains one or more submodules, then submodules
> +are populated based on interactions with the `git submodule` command.
> +Specifically, `git submodule init -- <path>` will ensure the submodule
> +at `<path>` is present, while `git submodule deinit [-f] -- <path>`
> +will remove the files for the submodule at `<path>` (including any
> +untracked files, uncommitted changes, and unpushed history).  Similar
> +to how sparse-checkout removes files from the working tree but still
> +leaves entries in the index, deinitialized submodules are removed from
> +the working directory but still have an entry in the index.
> +
> +Since submodules may have unpushed changes or untracked files,
> +removing them could result in data loss.  Thus, changing sparse
> +inclusion/exclusion rules will not cause an already checked out
> +submodule to be removed from the working copy.  Said another way, just
> +as `checkout` will not cause submodules to be automatically removed or
> +initialized even when switching between branches that remove or add
> +submodules, using `sparse-checkout` to reduce or expand the scope of
> +"interesting" files will not cause submodules to be automatically
> +deinitialized or initialized either.
> +
> +Further, the above facts mean that there are multiple reasons that
> +"tracked" files might not be present in the working copy: sparsity
> +pattern application from sparse-checkout, and submodule initialization
> +state.  Thus, commands like `git grep` that work on tracked files in
> +the working copy may return results that are limited by either or both
> +of these restrictions.

This new version looks great. I have nothing to add.

-Stolee
