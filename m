Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D82C433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 11:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CA232074B
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 11:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0iqMrx6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgFJLlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbgFJLlE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 07:41:04 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BECC03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 04:41:04 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w1so1636611qkw.5
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 04:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=egO6gaTxvGzrTl/2FvYe+hNQ5ArX0BFVwIXsoUwBf5U=;
        b=Y0iqMrx6TQAsv+JpoxrkNkL7IP92cxVSq6TXWxNjXZWCtVdOQxeYRS0CbMDj2TNzGZ
         t8NuQfcjC2lNONTjWl4RyWw+XZtV8BywiTFOwQBlFXn0aOQkWR0zB2cYAY4ukc7P0wjg
         SLYwZxuybAGo6cTY/A7WXzVmTKkvOjc5mGkG/21U6lIvH9d5WJflAa748L3RbQu5X5A6
         zS+dmYmJJGumrRBkoA5JAnf7z1uJpSogtwNzgNdl/dEw2FwNCG1E9oxsFArLRVCB4Rxs
         ICr5eNv2ghdOKHshCN94SCGpe2A/X8QSSDuN69YsIlCKiXQeLSNu1YNjGvqkMHcTCcd3
         QwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=egO6gaTxvGzrTl/2FvYe+hNQ5ArX0BFVwIXsoUwBf5U=;
        b=R99J/N9zKB1d+lL+PkE5H8Cig2VSUMmrRVeDR0Sz5Mt7oGzYfGO4PPg/vikI8BJX/M
         +Wg0YA5AB+B+ILiK7XpstnxbYRP6tbeqPXOnwkUXdmGiH+yH7cGAYfQ3lIVu3ZhtlWiz
         psHu0s6cjNIK6QO+HlFj0F5la+7hJrVXQTEvxAnxXQfeheWZZyS5tx2XnE21O3lJlzcm
         vKBVeCLJDgVWGFj1a/ytUju5WqxpvlyqwV2FtWRI9Tg4Tgg+oOZfj4RgPhUIx+b9EBkl
         +iuS4ik7sTV/PRfOIbHO7fgNb6brgGI+8jCnuynSO9CtXTzJU1vaxsRqJ5/i7EsfWBhC
         3qZQ==
X-Gm-Message-State: AOAM531PYEHAD1gFWZm74J2TP1M7is5rKcHmj+chH7JQWjt/EVtvDJBL
        3AD3K2zuVtucG1qVM5sr34k=
X-Google-Smtp-Source: ABdhPJzx0NoxmSC24NiB/Q2++PAadFhip/HUiOn9njfzPv1/bBnSRWA9QM/2WTBhZz61XMT6ym7Bfg==
X-Received: by 2002:a37:a949:: with SMTP id s70mr2520092qke.111.1591789262037;
        Wed, 10 Jun 2020 04:41:02 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id o6sm11426356qkh.28.2020.06.10.04.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 04:41:01 -0700 (PDT)
Subject: Re: [RFC PATCH v2 3/4] grep: honor sparse checkout patterns
To:     Elijah Newren <newren@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <CAHd-oW7_6+Jv+SQG3qh8eRjwJmqnRJKs=_bAV3WaC4-SKkoywg@mail.gmail.com>
 <20200522142611.1217757-1-newren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <562542d2-2a90-8683-a7fa-cbffb2e26bff@gmail.com>
Date:   Wed, 10 Jun 2020 07:40:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <20200522142611.1217757-1-newren@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/22/2020 10:26 AM, Elijah Newren wrote:

Sorry I missed this patch. I was searching all over for patches with
"sparse" or "submodule" in the _subject_. Thanks for calling out the
need for review, Junio!

> Subject: [PATCH] git-sparse-checkout: clarify interactions with submodules
> 
> Ignoring the sparse-checkout feature momentarily, if one has a submodule and
> creates local branches within it with unpushed changes and maybe adds some
> untracked files to it, then we would want to avoid accidentally removing such
> a submodule.  So, for example with git.git, if you run
>    git checkout v2.13.0
> then the sha1collisiondetection/ submodule is NOT removed even though it
> did not exist as a submodule until v2.14.0.  Similarly, if you only had
> v2.13.0 checked out previously and ran
>    git checkout v2.14.0
> the sha1collisiondetection/ submodule would NOT be automatically
> initialized despite being part of v2.14.0.  In both cases, git requires
> submodules to be initialized or deinitialized separately.  Further, we
> also have special handling for submodules in other commands such as
> clean, which requires two --force flags to delete untracked submodules,
> and some commands have a --recurse-submodules flag.
> 
> sparse-checkout is very similar to checkout, as evidenced by the similar
> name -- it adds and removes files from the working copy.  However, for
> the same avoid-data-loss reasons we do not want to remove a submodule
> from the working copy with checkout, we do not want to do it with
> sparse-checkout either.  So submodules need to be separately initialized
> or deinitialized; changing sparse-checkout rules should not
> automatically trigger the removal or vivification of submodules.

This is a good summary of how submodules decide to be present or not.

> I believe the previous wording in git-sparse-checkout.txt about
> submodules was only about this particular issue.  Unfortunately, the
> previous wording could be interpreted to imply that submodules should be
> considered active regardless of sparsity patterns.  Update the wording
> to avoid making such an implication.  It may be helpful to consider two
> example situations where the differences in wording become important:

You are correct, the wording was unclear. Worth fixing.

> In the future, we want users to be able to run commands like
>    git clone --sparse=moduleA --recurse-submodules $REPO_URL
> and have sparsity paths automatically set up and have submodules *within
> the sparsity paths* be automatically initialized.  We do not want all
> submodules in any path to be automatically initialized with that
> command.

INTERESTING. You are correct that it would be nice to have one
feature that describes "what should be present or not". The in-tree
sparse-checkout feature (still in infancy) would benefit from a
redesign with that in mind.

I am interested as well in the idea that combining "--sparse[=X]"
with "--recurse-submodules" might want to imply that the submodules
themselves are initialized with sparse-checkout patterns.

These ramblings are of course off-topic for the current patch.

> Similarly, we want to be able to do things like
>    git -c sparse.restrictCmds grep --recurse-submodules $REV $PATTERN
> and search through $REV for $PATTERN within the recorded sparsity
> patterns.  We want it to recurse into submodules within those sparsity
> patterns, but do not want to recurse into directories that do not match
> the sparsity patterns in search of a possible submodule.

(snipping way the old paragraph and focusing on the new text)

> +If your repository contains one or more submodules, then those submodules
> +will appear based on which you initialized with the `git submodule`
> +command.

This sentence is awkward. Here is a potential replacement:

  If your repository contains one or more submodules, then submodules are
  populated based on interactions with the `git submodule` command.
  Specifically, `git submodule init -- <path>` will ensure the submodule at
  `<path>` is present while `git submodule deinit -- <path>` will remove the
  files for the submodule at `<path>`. Similar to sparse-checkout, the
  deinitialized submodules still exist in the index, but are not present in
  the working directory.

That got a lot longer as I was working on it. Perhaps add a paragraph break
before the next bit.

>  Submodules may have additional untracked files or code stored on

To emphasize the importance of the following "to avoid data loss" statement,
you could mention that when a submodule is removed from the working directory,
then so is all of its Git data such as objects and branches. If that data was
not pushed to another repository, then deinitializing a submodule can result
in loss of important data. (Also: maybe I'm wrong about that?)

> +other branches, so to avoid data loss, changing sparse inclusion/exclusion

Edit: other branches. To avoid data loss, ...

> +rules will not cause an already checked out submodule to be removed from
> +the working copy.  Said another way, just as `checkout` will not cause
> +submodules to be automatically removed or initialized even when switching
> +between branches that remove or add submodules, using `sparse-checkout` to
> +reduce or expand the scope of "interesting" files will not cause submodules
> +to be automatically deinitialized or initialized either.  Adding or
> +removing them must be done as a separate step with `git submodule init` or
> +`git submodule deinit`.

This final sentence may be redundant if you include reference to init/deinit
earlier in the section.

> +This may mean that even if your sparsity patterns include or exclude
> +submodules, until you manually initialize or deinitialize them, commands
> +like grep that work on tracked files in the working copy will ignore "not
> +yet initialized" submodules and pay attention to "left behind" ones.

I don't think that "left behind" is a good phrase here. It feels like
they've been _dropped_ instead of _persisted despite sparse-checkout
changes_.

Perhaps:

  commands like `git grep` that work on tracked files in the working copy
  will pay attention only to initialized submodules, regardless of the
  sparse-checkout definition.

Thanks for pointing out how complicated this scenario is! It certainly
demands a careful update like this one.

-Stolee

