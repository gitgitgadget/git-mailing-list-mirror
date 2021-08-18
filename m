Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039BAC4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 22:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF17B61056
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 22:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbhHRWli (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 18:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbhHRWlh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 18:41:37 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A59C061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 15:41:02 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id e14so4991411qkg.3
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 15:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n8HpPu0614IhLObSBG7DJ1asFgr1qXTjJXtRTr/+kEg=;
        b=XChi5ZaQVJF80VQMdI6RSQjc5fhMXEen+SDJMZM+KThBnb5Aw0gclvvMutFc6z00Me
         NEIxEGPTFQgZ+cZPEZBX8Q5qCkaMSFhCdeRDlZb0C5TEDuGvvIqNfbGfVgmTbX6QWYpr
         CLj5v9w0wUEkLUGGT7JyJ7FQ2XuJh/RBPT/C0ad/ASgcG+Aa3JxSeEwTpKiC4g47G1jo
         naCB227XTIvOfmsSlKrWUhD627lHw4U/YMpiK9PpihP+1D21M4Rci9LhorHQ8kA2vo47
         flMxWwrd5cAXqvuUCSBj/zo26U5EYo0lCD3H93zdaNvTHs/8ho7rbdrCmZqB92iQjDhP
         4Cvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n8HpPu0614IhLObSBG7DJ1asFgr1qXTjJXtRTr/+kEg=;
        b=JzmYwh6ARXA4hpLfgpiXkJ5ZyqZ3xXIHIdjqRpECTrunabOkhyblOyt8fr2wFLqf6w
         e6nDN895Gah6pGexxztSZtwsyNt7wvRWdtj6g2SXKhnuaESNdSbt71f7BVDeWY1hfKe/
         00EvreI7RIY2GfLUpe9IXVPFtycte3I9/qfPL/pi7rq9RQBShbf8+B1mcczqt6Cme3lV
         YqCf3Uw+gNzlPwZOHfc5JQFetnK4gkanpjEkw+WAtNcZ8r8GexLn+hSdbCsYybpyDyqy
         hG5qHc6gGsuFLhyJrLvUw1R2b3WvCYLdi2wWVEi000o5bWkodw50tiVBb8UbTSc8CTGV
         3dJw==
X-Gm-Message-State: AOAM530nWpcSWfpNRvFVY+cbf54BzZrwk7YBuLsbWjmuPLRkmw7AoRSu
        Md3/EZrAnoGnn53CgfBg/6M=
X-Google-Smtp-Source: ABdhPJzwNxlWwlKEiUPpgE5ymCPFRQNm/tw6RHRFNZUk8iD7tC4QceZLpKNUcIGE7cTJ4c8rgM+RkQ==
X-Received: by 2002:a05:620a:2185:: with SMTP id g5mr664042qka.244.1629326461246;
        Wed, 18 Aug 2021 15:41:01 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id z1sm558763qtj.35.2021.08.18.15.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 15:41:00 -0700 (PDT)
Subject: Re: [PATCH v6] clone: set submodule.recurse=true if
 submodule.stickyRecursiveClone enabled
To:     Mahi Kolla via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Mahi Kolla <mahikolla@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Mahi Kolla <mkolla2@illinois.edu>
References: <pull.1006.v5.git.1628736366133.gitgitgadget@gmail.com>
 <pull.1006.v6.git.1628903396783.gitgitgadget@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <4103806f-6d88-2756-8853-7e16e56ad425@gmail.com>
Date:   Wed, 18 Aug 2021 18:40:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <pull.1006.v6.git.1628903396783.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mahi, Emily and Junio,

Le 2021-08-13 à 21:09, Mahi Kolla via GitGitGadget a écrit :
> From: Mahi Kolla <mkolla2@illinois.edu>
> 
> Based on current experience, when running git clone --recurse-submodules,
> developers do not expect other commands such as pull or checkout to run
> recursively into active submodules. However, setting submodule.recurse=true
> at this step could make for a simpler workflow by eliminating the need for
> the --recurse-submodules option in subsequent commands. To collect more
> data on developers' preference in regards to making submodule.recurse=true
> a default config value in the future, deploy this feature under the opt in
> submodule.stickyRecursiveClone flag.
> 

As I mentioned upthread [1], I'm really not sure that we need a new config
variable. If people want to have "--recurse-submodules" the default behaviour
for all commands that know this flag, they can set 'submodule.recurse' in their
~/.gitconfig, which enables the behaviour for all those commands (except clone
and ls-files). And orgs shipping Git to their devs can set it in their system
gitconfig. I've been using this setup for over two years, with almost zero
adverse effect on repositories that do not contain submodules. The *only* bug that
I encountered that affects git commands when *no* submodules are at play was:

c56c48dd07 (grep: ignore --recurse-submodules if --no-index is given, 2020-01-30)

I understand that once submodule.recurse is set in the global or system config file,
then Git will start recursing in repos that were cloned prior to
that config being enabled, as Emily mentions in [2]. Personnally I think it's a positive
point. That *might* be a deal-breaker for other people,
but in any case it would be good that this alternative - just using 'submodule.recurse'
- is mentioned in the commit message and that it mentions that caveat, i.e. why we need
a separate config.

Le 2021-08-13 à 16:38, Emily Shaffer a écrit :
>  and apparently
> 'submodule.recurse=true' has some weird edge cases for commands which
> are happy to run out-of-repo.

It would be nice if those known edge cases were documented somewhere (on the list,
on Gitgitgadget's issues list or at https://bugs.chromium.org/p/git). Apart from
the 'grep --no-index' glitch that I mentioned above, I did not encounter any
myself.

> Signed-off-by: Mahi Kolla <mkolla2@illinois.edu>
> ---
>      clone: set submodule.recurse=true if submodule.stickyRecursiveClone
>      enabled
>      
>      Based on current experience, when running git clone
>      --recurse-submodules, developers do not expect other commands such as
>      pull or checkout to run recursively into active submodules. However,
>      setting submodule.recurse=true at this step could make for a simpler
>      workflow by eliminating the need for the --recurse-submodules option in
>      subsequent commands. To collect more data on developers' behavior and
>      preferences when making submodule.recurse=true a default, deploy this
>      feature under the opt in submodule.stickyRecursiveClone flag.
>      
>      Signed-off-by: Mahi Kolla mkolla2@illinois.edu

Mahi, you can keep just the "Since v1" part in the GGG PR description (and the
automatically added CC's). No need to also repeat the commit message.

>      
>      Since V1: Made this an opt in feature under a custom
>      submodule.stickyRecursiveClone flag as opposed to feature.experimental.
>      Updated tests to reflect this design change. Also updated commit
>      message. Additionally, I will be contributing from my personal email
>      going forward as opposed to my @google email.
>      
>      cc: Philippe Blain levraiphilippeblain@gmail.com

Small nit: since you used '/submit' several times on Gitgitgadget, the previous version
you sent was actually sent as v5, and this here version is v6. So for next round, you could
write "Changes since v6" :)

> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1006%2F24mahik%2Fmaster-v6
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1006/24mahik/master-v6
> Pull-Request: https://github.com/gitgitgadget/git/pull/1006
> 
> Range-diff vs v5:
> 
>  
>         
>       -+test_expect_success 'feature.experimental flag manipulates submodule.recurse value' '
>       ++test_expect_success 'submodule.stickyRecursiveClone flag manipulates submodule.recurse value' '
>        +
>       -+	test_config_global feature.experimental true &&
>       ++	test_config_global submodule.stickyRecursiveClone true &&
>        +	git clone --recurse-submodules parent clone_recurse_true &&
>        +	test_cmp_config -C clone_recurse_true true submodule.recurse &&
>        +
>       -+	test_config_global feature.experimental false &&
>       ++	test_config_global submodule.stickyRecursiveClone false &&
>        +	git clone --recurse-submodules parent clone_recurse_false &&
>        +	test_expect_code 1 git -C clone_recurse_false config --get submodule.recurse
>        +

OK, so the expectation with 'submodule.stickyRecursiveClone' is that :
-  if it's true, then 'submodule.recurse' is set to true in the clone's local config file.
    That makes sense.
- if it's false, then 'submodule.recurse' is not set in the clone. This means that
   if 'submodule.recurse' is already set in ~/.gitconfig (or the system config file)
   then the clone will respect the configured value. That also makes sense, I think.

> 
>   builtin/clone.c          |  6 ++++++
>   t/t5606-clone-options.sh | 12 ++++++++++++
>   2 files changed, 18 insertions(+)

The new config variable should be documented in Documentation/config/clone.txt (which
gets added to text of the git-config(1) man page).


Cheers,

Philippe.

[1] https://lore.kernel.org/git/xmqqa6le5x1f.fsf_-_@gitster.g/T/#m1c2e522368ec4c9d458fcf6d83e75afab1632306
[2] https://lore.kernel.org/git/YRbYWR+X8vSq8CYe@google.com/
