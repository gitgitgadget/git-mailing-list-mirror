Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98538C77B7A
	for <git@archiver.kernel.org>; Thu, 18 May 2023 13:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjERNPW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 09:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjERNOa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 09:14:30 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6031FE4
        for <git@vger.kernel.org>; Thu, 18 May 2023 06:13:38 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f427118644so19691295e9.0
        for <git@vger.kernel.org>; Thu, 18 May 2023 06:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684415614; x=1687007614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BxKbVprvw6kseoaqUVivDW61OB1Hj7cRkdBYSsxmBZA=;
        b=HF5EDCtIZkd76sYYbbIJ4lAn2x+nb/QgcWi0OKWaT28qmtLdT+t6Sj13bXCT60BBf9
         +VDxjzjqlwHubCRqNWgBv4Kx7+SQ29aYWfuvme3NvajE2Xg1mos0rc4i/6O0CRYVTcAS
         Rr0BCDIsE6HHuWCAbslRzrOmoqadSgBjpAyiXDJWH46/wtL3KJdrSGC8kwgwkstjY+8M
         /sQukAN8uXCL9b7N9b07buh4jV4CnpiFD0MsIZXHoSLKhQBQCsGnzN2wFrnBOgvPu3r4
         BLLWxlTFHxMMpPImnLCOJSZSExCnfRzqChP/RTJYsVrFpC/rt3VMD/Or1rspGubkeJdp
         H38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684415614; x=1687007614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BxKbVprvw6kseoaqUVivDW61OB1Hj7cRkdBYSsxmBZA=;
        b=EpNDOMyqKNRDxO8Zz3RJhKFCyrHXBsqImUho8QK3UxbKkJRn2uVojmiCtiXCIPJmbt
         pScJiRe9qKPWN8yB67AdpFNA3/Q4iUb4l9+pRhgelQElh8Hf2gQYaCX2Q61NLoZe3cfF
         gngy5CActmbD1qtYsfhrqQibbxfpryxua77gKxmTe28ZusYyTiJpaBptiq0qyeCopYzB
         qNMOrKQ02zq0w+Vhg2VdMEAtkUUPKqfgDktbJcDQ9fsveQKbgksm6UnOneG2xKpyrbpB
         Qg3hwumsy7L+ayK3FVOuWoCaPEXXGXeVoyRxHhjnJonTHQv1aqEnv1ScUsdXVeJgXsMI
         QiFg==
X-Gm-Message-State: AC+VfDy23O8UKofuxBCoOE/4f2UqWplJVQ1tGUU5T6o/szLFTDMfNgYd
        Dhcw1qT4zOMwNXuurKxI/x0=
X-Google-Smtp-Source: ACHHUZ67C8idiAd9AvKTjnozmw6e7Alp7KzVtPli4Fyq2EOcidNQ1b5U9qWFyIwFKFmOGoizZBkrEg==
X-Received: by 2002:a1c:4b16:0:b0:3f1:7bac:d411 with SMTP id y22-20020a1c4b16000000b003f17bacd411mr1494879wma.39.1684415614134;
        Thu, 18 May 2023 06:13:34 -0700 (PDT)
Received: from [192.168.1.195] ([90.255.142.254])
        by smtp.googlemail.com with ESMTPSA id w10-20020adfee4a000000b0030649242b72sm2106978wro.113.2023.05.18.06.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 06:13:33 -0700 (PDT)
Message-ID: <669532af-fa0b-5dea-7da2-ac5caa0560c8@gmail.com>
Date:   Thu, 18 May 2023 14:13:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH RFC v2 2/4] unit tests: Add a project plan document
Content-Language: en-US
To:     steadmon@google.com, git@vger.kernel.org
Cc:     calvinwan@gmail.com, szeder.dev@gmail.com, chooglen@google.com,
        avarab@gmail.com, gitster@pobox.com, sandals@crustytoothpaste.net
References: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
 <20230517-unit-tests-v2-v2-2-21b5b60f4b32@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230517-unit-tests-v2-v2-2-21b5b60f4b32@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/05/2023 00:56, steadmon@google.com wrote:
> Describe what we hope to accomplish by implementing unit tests, and
> explain some open questions and milestones.

Thanks for adding this.

> Change-Id: I182cdc1c15bdd1cbef6ffcf3d216b386f951e9fc
> ---
>   Documentation/Makefile                 |  1 +
>   Documentation/technical/unit-tests.txt | 47 ++++++++++++++++++++++++++++++++++
>   2 files changed, 48 insertions(+)
> 
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index b629176d7d..3f2383a12c 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -122,6 +122,7 @@ TECH_DOCS += technical/scalar
>   TECH_DOCS += technical/send-pack-pipeline
>   TECH_DOCS += technical/shallow
>   TECH_DOCS += technical/trivial-merge
> +TECH_DOCS += technical/unit-tests
>   SP_ARTICLES += $(TECH_DOCS)
>   SP_ARTICLES += technical/api-index
>   
> diff --git a/Documentation/technical/unit-tests.txt b/Documentation/technical/unit-tests.txt
> new file mode 100644
> index 0000000000..7c575e6ef7
> --- /dev/null
> +++ b/Documentation/technical/unit-tests.txt
> @@ -0,0 +1,47 @@
> += Unit Testing
> +
> +In our current testing environment, we spend a significant amount of effort
> +crafting end-to-end tests for error conditions that could easily be captured by
> +unit tests (or we simply forgo some hard-to-setup and rare error conditions).
> +Unit tests additionally provide stability to the codebase and can simplify
> +debugging through isolation. Writing unit tests in pure C, rather than with our
> +current shell/test-tool helper setup, simplifies test setup, simplifies passing
> +data around (no shell-isms required), and reduces testing runtime by not
> +spawning a separate process for every test invocation.
> +
> +Unit testing in C requires a separate testing harness that we ideally would
> +like to be TAP-style and to come with a non-restrictive license.

As we're already using prove as a TAP harness for our existing tests I'd 
prefer not to add another harness unless we really need to. prove allows 
us to run tests in parallel and has options for rerunning only the tests 
that failed last time and for running slow tests first to reduce the 
overall run time.

  I haven't looked at runtests in detail but at a quick glance I'm not 
sure which of those features it supports. I'm also worried about its 
windows compatibility. I see it sets some environment variables that 
some features of the test library require. I'm not sure if we plan to 
use those features, if we do I think we could probably set those paths 
when the tests are compiled.

Are you able to expand on why it needs a non-restrictive license? From a 
technical point of view surely anything that is GPLv2 compatible would 
be fine as that is the license we're already using for our code.

> Fortunately,
> +there already exists a https://github.com/rra/c-tap-harness/[C TAP harness
> +library] with an MIT license (at least for the files needed for our purposes).
> +We might also consider implementing
> +https://lore.kernel.org/git/c902a166-98ce-afba-93f2-ea6027557176@gmail.com/[our
> +own TAP harness] just for Git.

If we do decide to go that route I'm very happy for you or one of your 
colleagues to take that patch forward.

> +We believe that a large body of unit tests, living alongside the existing test
> +suite, will improve code quality for the Git project.

This is slightly off-topic and can be addressed later. One thing that 
occurred to me was that if we end up with hundreds of unit files it 
would be good to link them into a single executable as we do with 
test-tool to avoid wasting time and disc space having to link hundreds 
of individual programs. We'd have to figure out how to run the 
individual tests though if we do that.

> +
> +== Open questions
> +
> +=== TAP harness
> +
> +We'll need to decide on a TAP harness. The C TAP library is easy to integrate,
> +but has a few drawbacks:
> +* (copy objections from lore thread)
> +* We may need to carry local patches against C TAP. We'll need to decide how to
> +  manage these. We could vendor the code in and modify them directly, or use a
> +  submodule (but then we'll need to decide on where to host the submodule with
> +  our patches on top).
> +
> +Phillip Wood has also proposed a new implementation of a TAP harness (linked
> +above). While it hasn't been thoroughly reviewed yet, it looks to support a few
> +nice features that C TAP does not, e.g. lazy test plans and skippable tests.

strictly speaking both those are supported in terms of TAP output by 
c-tap-harness but they're not very friendly to use. For me the big 
difference is that my library provides a set of check* macros and 
functions that automatically print diagnostic messages when a check 
fails and the test framework maintains the pass/fail state based on 
those checks.

Best Wishes

Phillip

> +== Milestones
> +
> +* Settle on final TAP harness
> +* Add useful tests of library-ish code
> +* Integrate with CI
> +* Integrate with
> +  https://lore.kernel.org/git/20230502211454.1673000-1-calvinwan@google.com/[stdlib
> +  work]
> +* Run along with regular `make test` target
> 

