Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB4FC2BA16
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 09:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECB3206CC
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 09:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+gM5PNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgDDJdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Apr 2020 05:33:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38596 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgDDJdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Apr 2020 05:33:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id c7so11380438wrx.5
        for <git@vger.kernel.org>; Sat, 04 Apr 2020 02:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7abPRVQVrpbM+O0kwjepA6symRX0jVcPnxW0TjBif0s=;
        b=A+gM5PNmmH4XDz+mcMvFmnlhwm7KBSnFPBT/y4Hf7tJMmAGIgZ6WhJQD5Oe6ovBino
         6Awqrdf8w2RVcQsVYjWLHkM58wwqCNZAgnWfP1LX3knthfo+EPJL008KdeqMrqtGvc0r
         sLqSRsvtuLKXYAXMOpOeBOOziACCnpG1pNAIObcMpHBtffmBMLTlqVeh1Sp8c7iWBLjb
         H5u3RVdnkdiEclAByzZvAiAJCwZPSc0DyAvQdfq7akSt1lzXRAACrclMjdotjTzuytTw
         ACp14NUrLfTPMdoSw1id9cCZTog0VnvEWy3A82gBc3kmfnL+EoGO3C9+99mA2PCtV/6E
         40YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7abPRVQVrpbM+O0kwjepA6symRX0jVcPnxW0TjBif0s=;
        b=Ag8qtX5YeHVLW+4ttBAPQPfjnyyaa+AnuspxBtC6sq4hecOiG6TCvKwlumSIgxNbUn
         CL7ESVHW2UP2/DHfQhETtlxAWM9CwpYvV+/Re6dhTLId18mZ5FKeBzooWiRyYfNJMIVg
         HnN8Tcgm59zzvGWiK1Wouv7iSSCBlbukv5aZ3Li1xDmxLsDaIMl/GdtE0WJ9fOCVH0x/
         qMnx3BlTrDxKNc/SroIwzhrMJ+vZovV3tedKpGFdHgZ3s7OSmIjwyjYTPseGkraKu13y
         W5d5+MUyKNaJ6xHiIrg0DsJI0WtNkDEtJ4kBBlRvoFi9pg9EwPy/CWEgQhZpqIhpuPVd
         TC1g==
X-Gm-Message-State: AGi0PuaCSuFNHMk8SJUAcfi1LnpQUMUhqJb4JVPCV+Ft8QXDv4FIqMOH
        1BBAkiXIxFvYDd/VHyKHvk0=
X-Google-Smtp-Source: APiQypJr35+ipYAH68IkZ2M8ViV64OlO7VSL+6hwxDfoRqrkjt/eptDxZrJi2WEHWoh8+W7PiCXXiw==
X-Received: by 2002:adf:db41:: with SMTP id f1mr14201416wrj.247.1585992803029;
        Sat, 04 Apr 2020 02:33:23 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id j11sm10447076wro.51.2020.04.04.02.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2020 02:33:22 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] git-rebase.txt: add another hook to the hooks section,
 and explain more
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     jrnieder@gmail.com, emilyshaffer@google.com,
        Johannes.Schindelin@gmx.de, Elijah Newren <newren@gmail.com>
References: <pull.749.git.git.1585888520572.gitgitgadget@gmail.com>
 <pull.749.v2.git.git.1585963816430.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <7c1cf1dd-3f70-0c57-ad4f-44453ed565a6@gmail.com>
Date:   Sat, 4 Apr 2020 10:33:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <pull.749.v2.git.git.1585963816430.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 04/04/2020 02:30, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> For more discussion about these hooks, their history relative to rebase,
> and logical consistency between different types of operations, see
>    https://lore.kernel.org/git/CABPp-BG0bFKUage5cN_2yr2DkmS04W2Z9Pg5WcROqHznV3XBdw@mail.gmail.com/
> and the links to some threads referenced therein.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>      git-rebase.txt: add another hook to the hooks section, and explain more
>      
>      Changes since v1:
>      
>       * Updated the wording of the last sentence as per Junio's suggestion.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-749%2Fnewren%2Frebase-and-hooks-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-749/newren/rebase-and-hooks-v2
> Pull-Request: https://github.com/git/git/pull/749
> 
> Range-diff vs v1:
> 
>   1:  29a1ff520ba ! 1:  45a5c1c1ff9 git-rebase.txt: add another hook to the hooks section, and explain more
>       @@ Documentation/git-rebase.txt: Hooks
>        +originally implemented as shell scripts and happened to invoke other
>        +commands like 'git checkout' or 'git commit' that would call the
>        +hooks).  Both backends should have the same behavior, though it is not
>       -+entirely clear which, if any, is correct.  We will likely remove both
>       -+of these hooks in the future.
>       ++entirely clear which, if any, is correct.  We will likely make rebase
>       ++stop calling either of these hooks in the future.
>         
>         Interruptability
>         ~~~~~~~~~~~~~~~~
> 
> 
>   Documentation/git-rebase.txt | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index f7a6033607f..5e0fcd4e9bd 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -684,9 +684,15 @@ Hooks
>   ~~~~~
>   
>   The apply backend has not traditionally called the post-commit hook,
> -while the merge backend has.  However, this was by accident of
> -implementation rather than by design.  Both backends should have the
> -same behavior, though it is not clear which one is correct.
> +while the merge backend has.  In contrast, the apply backend has
> +traditionally called the post-checkout hook while the merge backend
> +has not. 

This is not correct - both backends call the post-checkout hook, but the 
merge backend suppresses any output from it - see 
https://public-inbox.org/git/6c413abc-f48d-5a02-ac8b-09a0fa80b98d@gmail.com/

Best Wishes

Phillip

> However, the calling of these hooks in both cases was by
> +accident of implementation rather than by design (both backends were
> +originally implemented as shell scripts and happened to invoke other
> +commands like 'git checkout' or 'git commit' that would call the
> +hooks).  Both backends should have the same behavior, though it is not
> +entirely clear which, if any, is correct.  We will likely make rebase
> +stop calling either of these hooks in the future.
>   
>   Interruptability
>   ~~~~~~~~~~~~~~~~
> 
> base-commit: 274b9cc25322d9ee79aa8e6d4e86f0ffe5ced925
> 
