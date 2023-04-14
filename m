Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBAAC77B72
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 18:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjDNStL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 14:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDNStJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 14:49:09 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12846199
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 11:49:08 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n17so3249525pln.8
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 11:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681498148; x=1684090148;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=npJxeHV1iTELtPxJJEL40GQDETYkXEwHE255t9U6law=;
        b=peZQXiRlytRRZpjCdR3REBRJA1palKzeHFSO8h6yLi9eS0OvjD4aaSfza4k075Kha4
         RxB4y0ayxMew0yrdIZLHX5zLgZmWlCluiVw0s7EfGCvYt7Re813/ZRAZ5irfk/0HuElR
         CtFfIm9d/X01e+hZaSfJvEhLHIdJqN7tlUCVezCiBE6e/t1iUSfAshDvUUIPnAvG/es5
         dlm+fH5QAuRFraum63/dg6nAKm4LnHp1yrv1wKX8DS99J4THaa7nA73k2LJYQg7d+TO3
         ZUw1klwTAyg9RWslRnHbwVa1HPrGqq0l3oR2x6DNsnmRDoApin91SV9BLR+HpngakuXq
         KPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681498148; x=1684090148;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=npJxeHV1iTELtPxJJEL40GQDETYkXEwHE255t9U6law=;
        b=gyIkZUlTsDXeIAwNpZjzID/tBZItOLRNa6pX4PmCKd6N4hcK98Q9PkCc5GL6Sw7t3K
         Y46KRTE2qfT0CpppGB8C+yPdQrbhIpTexipe+3Wcam0sRZvuwRbQZfnDYufxZb6F+Q8z
         wosRQv4EEeN5Hk0cUqnXmWUQoJk03oUo+SH7xJZDYIU/JCi/tRLJivnnnf+h/zs22jVT
         22W/wxXBP9q1Q1pnQQnOugf6gnuAfuFZFdASwFULbp4oQV0exWhJ1r7VuZ7qafwJkg3w
         /jEfzIOXMKNzESQjMuDqO/DM7D3iyrzgm+436T5dSEshpMn/s54QQGBoindx3MXh9j77
         jBUQ==
X-Gm-Message-State: AAQBX9cdyYrU9xtOECdtU7qSqff9n5m9YRPFWxb4VB0MAkPbKFNPPFGX
        nUegMiIpJhiG6u6MO/8/Mak=
X-Google-Smtp-Source: AKy350ZThVucJnaQx0Uqtt4fnD1M1kmuOFfkRFL7zhbxO999QrzO3pqXb0XsydcAoqMuzNIWr03p6w==
X-Received: by 2002:a17:903:2289:b0:1a5:167f:620f with SMTP id b9-20020a170903228900b001a5167f620fmr5076894plh.15.1681498148144;
        Fri, 14 Apr 2023 11:49:08 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id g9-20020a17090a128900b00233d6547000sm3063987pja.54.2023.04.14.11.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 11:49:07 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 1/5] revisions.txt: document more special refs
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
        <66c7e514157f3c8220eb994cea7c4659d5241042.1681495119.git.gitgitgadget@gmail.com>
Date:   Fri, 14 Apr 2023 11:49:07 -0700
In-Reply-To: <66c7e514157f3c8220eb994cea7c4659d5241042.1681495119.git.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Fri, 14 Apr 2023
        17:58:34 +0000")
Message-ID: <xmqq8reuqoyk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> Some special refs, namely HEAD, FETCH_HEAD, ORIG_HEAD, MERGE_HEAD and
> CHERRY_PICK_HEAD, are mentioned and described in 'gitrevisions', but some
> others, namely REBASE_HEAD, REVERT_HEAD, and BISECT_HEAD, are not.
>
> Add a small description of these special refs.
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  Documentation/revisions.txt | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index 9aa58052bc7..98b8f89bc8d 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -32,8 +32,8 @@ characters and to avoid word splitting.
>    first match in the following rules:
>  
>    . If '$GIT_DIR/<refname>' exists, that is what you mean (this is usually
> -    useful only for `HEAD`, `FETCH_HEAD`, `ORIG_HEAD`, `MERGE_HEAD`
> -    and `CHERRY_PICK_HEAD`);
> +    useful only for `HEAD`, `FETCH_HEAD`, `ORIG_HEAD`, `MERGE_HEAD`,
> +    `REBASE_HEAD`, `REVERT_HEAD`, `CHERRY_PICK_HEAD` and `BISECT_HEAD`);

Adding missing ones and enumerating them indeed is good, but I
wonder if the readers will be helped if they are exposed to the
phrase "pseudoref" here.

	This is usually useful only for the pseudorefs, i.e. `HEAD`,
	`FETCH_HEAD`, ..."

We have definition of it in the glossary, but it does not have an
exhaustive list (and if we want to have an exhausitive list on this
page, the glossary definition of pseudoref may want to point at this
page).

It is an unrelated tangent that shouldn't be added to the
documentation (yet), but didn't we have a plan to limit the
pseudorefs to those names that end with "_HEAD"?

> +`REBASE_HEAD`, during a rebase, records the commit at which the
> +operation is currently stopped, either because of conflicts or an `edit`
> +command in an interactive rebase.

OK.

> +`REVERT_HEAD` records the commit which you are reverting when you
> +run `git revert`.

OK.


> +`BISECT_HEAD` records the current commit to be tested when you
> +run `git bisect --no-checkout`.

OK.

Looking very good.
