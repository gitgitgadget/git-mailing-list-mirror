Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A545C433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 12:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D754610D1
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 12:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbhIVMaa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 08:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhIVMaa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 08:30:30 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404D8C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 05:29:00 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 72so8872683qkk.7
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 05:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Lff5EcSz047CahAItwxsbq2eKA7PZADsyCgYJ3Sbqj4=;
        b=a0JcyHaiEnhgJqcV1QEjtyo+owVotqtQxbtipvBDRww2WbI4hC+nw1izjI7NJYDxjv
         pR7WzWZFuzYReQxyb6zEXMFmkNh7Ngcb8Qf/DmzJXrMjbFjU23AqXMQrVBuQcl5IUsCE
         FTZJlB/e2iOSfY6fZvfimJMpxHTLhj7ohGEAVT7+hMjH820YnSLBOG1Q3lLXgYkZjIWj
         nC0upEyeWi7t8S8xG9aDJnJkSEfrgY8Vf9XURlFTMH/hOxFdraBmd5rfbhDyb8y9PCiU
         IZ7KpP2/cznvU0ZM5R1T+3vMEraafPm4iPvOdo0wQnW+oRCs9C8XuPLRR9TpG7X0+qI7
         wo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lff5EcSz047CahAItwxsbq2eKA7PZADsyCgYJ3Sbqj4=;
        b=RM3o2W6hgAEn40Z3TeqB8yYA1S2JLYxDA8tC+RgVfg2Z7p3FAgJnfRleAKr4de0oE+
         VlTqPZP02+9VP2n4U2pRQV/Ugl5uKPmt+tuFeVWW51zE0OMG+ozQ+KwJzYrij4OJydLe
         HbOyHdWsuS9lrwV9xUOzgal9Pjzhw/lii0upuH551XEnPE/AKn/mB6muMghEAP0yfAYu
         IGGR/zkd9E8hMekl87+ZcPjwWsrW79/18UwwpO7VCSZCqLbSD1kDhp1bQ5PrBBAhMc7m
         TUx4DdrakRYxTiTDKH2S4zOesKSrz94EBrVn+iXIe4Vw0cGkUaIz2NW0/tv5sT7/x+K9
         upKA==
X-Gm-Message-State: AOAM531GZScFHWJgNQdE7TEmbQoNupU2hUaQ3kW5RP0+iYKhLP5SQYja
        nL/gjR/mponiq+yGvem4T7QstoeRXSI=
X-Google-Smtp-Source: ABdhPJz0ZgSGcnhxlexifti1TyYCk7fFqehXDszeiSFefuK3eIuWsSKJ5aRDf1RcuUgl5T7oXswljw==
X-Received: by 2002:a37:9d96:: with SMTP id g144mr21220010qke.23.1632313739108;
        Wed, 22 Sep 2021 05:28:59 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id j2sm1203870qta.84.2021.09.22.05.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 05:28:58 -0700 (PDT)
Subject: Re: [RFC PATCH 2/2] branch: add --recurse-submodules option for
 branch creation
To:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
References: <20210921232529.81811-1-chooglen@google.com>
 <20210921232529.81811-3-chooglen@google.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <084caed9-5854-9fe2-8476-b5325ddac52c@gmail.com>
Date:   Wed, 22 Sep 2021 08:28:57 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210921232529.81811-3-chooglen@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen,

Le 2021-09-21 à 19:25, Glen Choo a écrit :
> When working with a superproject and submodules, it can be helpful to
> create topic branches to coordinate the work between each repository.
> 
> Teach cmd_branch to accept the --recurse-submodules option when creating
> branches. When specified, like
> 
>    git branch --recurse-submodules topic
> 
> git-branch will create the "topic" branch in the superproject and all
> submodules.
> 
> recurse_submodules is only supported for creating a branch. git-branch

small nit: we usually don't refer to the dashed form of commands anymore: 'git branch'
would be preferable.

> will fail if the user attempts to use --recurse-submodules with anything
> other than creating a branch. If a user has submodule.recurse in their
> config, git-branch will use --recurse-submodules for creating a branch,
> but will treat it as unset for any other operation.

That seems like a good starting point.

However, I think that for this new feature, I would prefer *also* having
a new config 'branch.recurseSubmodules' (or similar) that would allow
more granular control than 'submodule.recurse', which influences several
commands. Personnally I have 'submodule.recurse' set to true in my '~/.gitconfig',
because I want the submodules working trees to be updated when I use 'git checkout'
to change branches, 'git grep' to search the working tree, etc., but I usually
do not *work* on the submodules in my project and I would not like new branches
being created in them every time I create a new branch in the superproject.
In other words, 'branch.recurseSubmodules=false' would have higher priority
than 'submodule.recurse=true'.

> 
> There is no easy way to get the remotes of a submodule because remotes.c
> stores state as static variables. As such, branch tracking is disabled
> when using --recurse-submodules.
> 
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---


> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index e575ffb4ff..858831d4cf 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -1421,5 +1421,63 @@ test_expect_success 'invalid sort parameter in configuration' '
>   		test_must_fail git branch
>   	)
>   '
> +# Submodule tests
> +
> 

Most tests for submodules are usually in separate test files. I don't think
this is a set-in-stone rule, but if more tests are coming in the future, maybe
a new test file t????-branch-submodule.sh would be appropriate ? Just a small suggestion.


Thanks for working on this! It's exciting to see new developments
in the submodule area :)

Philippe.
