Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D30CC63777
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 00:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3ADF207F7
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 00:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElIvMjRJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387960AbgLAAUJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 19:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729387AbgLAAUI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 19:20:08 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C42EC0613CF
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 16:19:22 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id ck29so330110edb.8
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 16:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yNcRkHot1wXbnd58bfA2i3QQ0bA3m1RHog0k0JsmVmI=;
        b=ElIvMjRJB23boLG97y1c/bdoErtz7I6rOX5Pw+aYV6Zmsiv5ktSpl9QPeAouX2v0a9
         eR8D+RTIg97o373QdStPQMM560unOBqXcuib7WCr7kOBvF2X0tGM3XFYdcuEkVMNYMPa
         SQYc8Aqgrx1+ZrJrrBRmprU5JBjuw4l2RXno20J2sIb0RSSn12wUdz1p4cFa6EWS5Q+U
         yy+yDkHRSHGjEmqW145zfK5d+Ly6r/zUW40ufVXcm++sVJ56TtUCk3MvuujewidKL80c
         IoI7N5TFmk178eHqlT1mn3mAPfmWKBR7gVatX3/7u8Jn+MI451h53/t6tTcnM+kso2xg
         WJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yNcRkHot1wXbnd58bfA2i3QQ0bA3m1RHog0k0JsmVmI=;
        b=BNMbBupsus6nm8lqplNhjNpvDLe3SaaUEVovQjircEqxLQL5kYJPkBl/iFs3xUV4Kk
         otRYt9d2hCtvF6jYk2QCjbEeJCk79ORspcL/UUbT2XgLDBOL1WUSxwT/y1NnWjCLVzaF
         iumQtnEvR/nTaK0F0UdDKyOpez4FUzynOAPM9o+FVTgoDFJMcgq3/JL6xcZOSjiq9Pla
         y+RIFDStGnB+e0j3nNeGRpT/qL5gpyb9fvEghTqqMm15HTJL275XfWJ5LjOCLNdpeuDJ
         za06d84BWBOu1X/RK4tdWTVc8Smt+VKoNXaOmqV1soT3T8sdSngI6A4uTu5pV7S2rx8p
         SPQw==
X-Gm-Message-State: AOAM532JySredu8QgIf/1Vze0po8giYWrO6S3taUr0SL03+QUg4wJIrz
        BNEuw1ATH7jNDc5dJUz2XM0=
X-Google-Smtp-Source: ABdhPJzV/fC9Fs+Kz0p+nYqMND3RoR6VuF1/OW2nzp1WtP0Eof6XeyK0vRu7+YkDwcwIT3f4z512Fw==
X-Received: by 2002:a05:6402:30ab:: with SMTP id df11mr271831edb.361.1606781961319;
        Mon, 30 Nov 2020 16:19:21 -0800 (PST)
Received: from szeder.dev (62-165-236-118.pool.digikabel.hu. [62.165.236.118])
        by smtp.gmail.com with ESMTPSA id oq14sm16260ejb.119.2020.11.30.16.19.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 16:19:20 -0800 (PST)
Date:   Tue, 1 Dec 2020 01:19:18 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?Q?Vojt=C4=9Bch?= Knyttl <vojtech@knyt.tl>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: Re: What did you do before the bug happened? (Steps to reproduce
 your issue)
Message-ID: <20201201001918.GG8396@szeder.dev>
References: <CANVGpwZGbzYLMeMze64e_OU9p3bjyEgzC5thmNBr6LttBt+YGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANVGpwZGbzYLMeMze64e_OU9p3bjyEgzC5thmNBr6LttBt+YGw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Thanks for your report!

On Mon, Nov 30, 2020 at 11:11:20PM +0100, Vojtěch Knyttl wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> 1. Create a commit with hash-issueId, eg. '#87 Fix wrong indent'

Note that to end up with an empty commit message after the fixup it's
important to have a single-line commit message starting with a '#'
character.

> 2. Create a second commit with any commit message.
> 3. Use interactive rebase and 'f'ixup the second commit to the first one.
> 
> What did you expect to happen? (Expected behavior)
> 
> I expect a single commit with message: '#87 Fix wrong indent'

I agree that this is indeed the desired behavior, because 'git rebase'
should not cleanup unmodified commit messages.

It used to work before 18633e1a22 (rebase -i: use the rebase--helper
builtin, 2017-02-09) (released in v2.13.0), but after that it errored
out with "Aborting commit due to empty commit message" [1].

The scripted interactive rebase created fixup commits with 'git commit
--amend --no-verify -F <file>', which uses the 'whitespace' cleanup
mode, and thus didn't remove comments.  The builtin interactive
rebase/sequencer, however, invoked 'git commit -n --amend -F <file>
--cleanup=strip', i.e. it explicitly specified that comments must be
removed.


[1] The current behavior (i.e. empty commit message instead of that
    error) is the result of b00bf1c9a8 (git-rebase: make
    --allow-empty-message the default, 2018-06-27) (released in
    v2.19.0).



> What happened instead? (Actual behavior)
> 
> There is a commit with empty commit message. This happens without any
> warning and one notices even too late.
> 
> What's different between what you expected and what actually happened?
> 
> The commit message disappeared as it was probably treated as a comment.
> 
> Anything else you want to add:
> 
> [System Info]
> git version:
> git version 2.28.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Darwin 20.1.0 Darwin Kernel Version 20.1.0: Sat Oct 31 00:07:11
> PDT 2020; root:xnu-7195.50.7~2/RELEASE_X86_64 x86_64
> compiler info: clang: 11.0.3 (clang-1103.0.32.62)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /usr/local/bin/bash
> 
> [Enabled Hooks]
> pre-commit
