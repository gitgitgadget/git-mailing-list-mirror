Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0C3C61DA4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 18:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjCFSsz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 13:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjCFSsv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 13:48:51 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76061ADCF
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 10:48:46 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id m20-20020a17090ab79400b00239d8e182efso14065672pjr.5
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 10:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678128526;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/e1k9fDJuEcMC8EInv3IVSaIKVJ+hiGDeQd4rH1W+w8=;
        b=RV6aZSZL7oeK+a35eJ5nz5/vAXB6hEpTRLB0iOAZSgBB1g5FMmlPPe/UQAuZaIGNrw
         wGnP7SsXkgohI2LeSvdGQUimKwhxM7IWFaYXDxd9UeTXVzdhkpv3VkWt73ucTFGzAjPa
         DIeQbxwmY+h7pxMAUuVgeGrSgRDZxnYaG85ieJW38nRHHLjTzuVKByZbVefn71VJVL+e
         nd8mYH56YA+bq2qFvZjpIfDJMIWAdCHM+4uIUynMFeI/ow/u+N09fq1O7XJzGbiMm2+t
         EYuGzuslPh93RdJAAtYyzhvGQB7icHonCxVeYWQkbTWPEnIHWNjH2L/faagGgCL+Gx1b
         dgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678128526;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/e1k9fDJuEcMC8EInv3IVSaIKVJ+hiGDeQd4rH1W+w8=;
        b=M13VYB3j7BP7/la1b4F28+1q491orlaLpBK50Vpscx0RlDZ2PgefWWsrmahmHzYEls
         bp8mTlwko9ZO9ALmpgY5nzxw/9cPRbC8vutitYpzVfwOTBBbw+kSpNkbVqkoJjuObQBT
         dvSGDMUwY/foTrbJHjjt1T53bc59ZPchh9STenByazRK6hYjwOBnk6/Zvxeu+Sa5MceR
         kCN476g7NgF7TwB21HZcqSXHC4y88R2JbpR2i/4crXx/Kux1BqLCq4FyiCdSqkHU6kti
         gzl/80PkQ+ZVElFcYKc21JhKoTqoTE589RPEae1SaClz5B2nxYtq7NOSuqz+fkXILQim
         gOrQ==
X-Gm-Message-State: AO0yUKWwfYMw+qSEdK6+XHAJ3Wmfn7O19m+TqW534uKGL6YCWaExH1j9
        VJdfHY0NQ4FiYanfsppFXlw=
X-Google-Smtp-Source: AK7set/pwrzV9iqPspzq6cm8/FYtEb6i2SQv/7Yb+5LvleSpxuOfqeuo4JBgRi6ly9zL1MVRGZkCCg==
X-Received: by 2002:a17:902:e54a:b0:19d:1834:92b9 with SMTP id n10-20020a170902e54a00b0019d183492b9mr13001923plf.56.1678128526346;
        Mon, 06 Mar 2023 10:48:46 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id d19-20020a170902aa9300b001932a9e4f2csm7033785plr.255.2023.03.06.10.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 10:48:45 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/8] ahead-behind: create empty builtin
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
        <0fd18b6d740f1e8a6f62a25947bc3ad49c2674a6.1678111599.git.gitgitgadget@gmail.com>
Date:   Mon, 06 Mar 2023 10:48:45 -0800
In-Reply-To: <0fd18b6d740f1e8a6f62a25947bc3ad49c2674a6.1678111599.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 06 Mar 2023
        14:06:31 +0000")
Message-ID: <xmqqzg8p90mq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> For example, we will be able to track all local branches relative to an
> upstream branch using an invocation such as
>
>   git for-each-ref --format=%(refname) refs/heads/* |
>     git ahead-behind --base=origin/main --stdin

Stepping back a bit, this motivating example makes me wonder if

 $ git for-each-ref --format='%(refname) %(aheadbehind)' refs/heads/\*

that computes the ahead-behind number for each ref (that matches the
pattern) based on their own "upstream" (presumably each branch is
configured to track the same, or different, upstreams), or
overrriding @{upstream}, a specified base, i.e.

 $ git for-each-ref --format='%(refname) %(aheadbehind:origin/main)' refs/heads/\*

would be a more intuitive interface to the end-users.

It would probably work well in conjunction with

    git for-each-ref --format='%(refname)' --merged origin/main refs/heads/\*

which is a way to list local branches that are already merged into
the upstream, to have the feature appear in the same command,
perhaps?
