Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806EEC2BD09
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 18:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5370A20661
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 18:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJ/F+10q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfLDSxS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:53:18 -0500
Received: from mail-yw1-f50.google.com ([209.85.161.50]:43684 "EHLO
        mail-yw1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbfLDSxS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 13:53:18 -0500
Received: by mail-yw1-f50.google.com with SMTP id s187so122487ywe.10
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 10:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=JbYDk+QtEY2Vc8sIBcgsv6o0XKGY1pqeWwgB9nW5c7U=;
        b=JJ/F+10qu+TJI6EvPUEDtRVmFXPgdBFa2UF3DZUXeyTvi8WP1o1TKCD6FZRTp7QPim
         6xM0+oR6lavAJtbPTr1yOMQFTkVtPxg/e9fUtU0a+W82+TnTNSotTgtPEWaNZ1pVWKD4
         2b1cHTA1QBVGRE82o1eRleAWSx6HgLMcBbRN5xMbASp/pyjgyTuf/sFyxwdziRP1e8iX
         GU64c+HbJ45J7qbNchTK4XBTxEPyiFj81M3CuDH/Lo/quBTUYtpON7MQlAF+RrMAojor
         ZaMUWENDVDtff/7kCTRqYaw/xv7op1TV+SkcT6o60MtTagMA5DKxOm7YfMTB0HgdpJc7
         fUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JbYDk+QtEY2Vc8sIBcgsv6o0XKGY1pqeWwgB9nW5c7U=;
        b=QFdNNg2iyvWUIg+XYZBr7xmResx18hN9vLMCjOdlphTyPL5Hzr9qebh4S4YOvM2heq
         Q2AfxkwtBHksLFJoAdxS40spHxTU+ORi1sOXusFU0idAgjFsGnTTpBJ/2o48AvM7Srbl
         xKOHlWbaYKwRszXNOL268pV35C2ZM84lgJewO6h8lpIDWWkWl6pqwCX5nOTXZGXOpO2U
         9Si0Xn+mWQYaSRKIJK5ku5kACGcuyyG3xRH0RGhHzJkHNI1G9ShNxbX1ukf33RtDJmwt
         WmohSULhwu1Ix+3oU2nNEsuft1eVPjoVz5R+pXKnrZgQgxx+i3LsZjq0JAmqbwc+K6+z
         846w==
X-Gm-Message-State: APjAAAXHRz0/6TTvcJjILWxbhgRNTlDftotVvoW3NC1ZZlRLykRN+/ff
        jT8lRGoK9V5a0jleN/Wl5UY=
X-Google-Smtp-Source: APXvYqwoEfWG7HAVVU4yA1+OtKnYZ65JOgVEXFZcMym+PZtS209MPw+na4jiKwlt9ZqnAxe/0ZO3AQ==
X-Received: by 2002:a81:4f0d:: with SMTP id d13mr2991492ywb.315.1575485597220;
        Wed, 04 Dec 2019 10:53:17 -0800 (PST)
Received: from [192.168.1.76] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 138sm3322389ywj.94.2019.12.04.10.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 10:53:16 -0800 (PST)
Subject: Re: What's cooking in git.git (Dec 2019, #01; Mon, 2)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <xmqqpnh6yfrl.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bea26b66-ac52-8f0e-9557-c958db7be628@gmail.com>
Date:   Wed, 4 Dec 2019 13:53:10 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <xmqqpnh6yfrl.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/2/2019 9:16 AM, Junio C Hamano wrote:
> * ds/sparse-cone (2019-11-22) 19 commits
>  - sparse-checkout: check for dirty status
>  - sparse-checkout: update working directory in-process for 'init'
>  - sparse-checkout: cone mode should not interact with .gitignore
>  - sparse-checkout: write using lockfile
>  - sparse-checkout: use in-process update for disable subcommand
>  - sparse-checkout: update working directory in-process
>  - sparse-checkout: sanitize for nested folders
>  - unpack-trees: add progress to clear_ce_flags()
>  - unpack-trees: hash less in cone mode
>  - sparse-checkout: init and set in cone mode
>  - sparse-checkout: use hashmaps for cone patterns
>  - sparse-checkout: add 'cone' mode
>  - trace2: add region in clear_ce_flags
>  - sparse-checkout: create 'disable' subcommand
>  - sparse-checkout: add '--stdin' option to set subcommand
>  - sparse-checkout: 'set' subcommand
>  - clone: add --sparse mode
>  - sparse-checkout: create 'init' subcommand
>  - sparse-checkout: create builtin with 'list' subcommand
> 
>  Management of sparsely checked-out working tree has gained a
>  dedicated "sparse-checkout" command.
> 
>  How well is this topic done at this point?

Hopefully this is ready to merge and I can start on the
follow-up topics. I think this is ready enough that any
further comments can be done in follow-up commits.

That said, I thought the topic was in that state before
the 2.24.0 release, but then Szeder found several good
points worthy to address here. He is CC'd to hopefully
comment.

> * ds/fsmonitor-testing (2019-11-22) 11 commits
>  - test-lib: clear watchman watches at test completion
>  - t7519: disable external GIT_TEST_FSMONITOR variable
>  - t7063: disable fsmonitor with status cache
>  - tests: disable fsmonitor in submodule tests
>  - t3600-rm.sh: disable fsmonitor when deleting populated submodule
>  - t3030-merge-recursive.sh: disable fsmonitor when tweaking GIT_WORK_TREE
>  - fsmonitor: disable fsmonitor with worktrees
>  - t1510-repo-setup.sh: disable fsmonitor if no .git dir
>  - t1301-shared-repo.sh: disable FSMONITOR
>  - fsmonitor: do not output to stderr for tests
>  - fsmonitor: disable in a bare repo
> 
>  Updates around testing fsmoitor integration.
> 
>  Will merge to 'next'.

Please hold off. As mentioned in the thread, I didn't do
a very good job of writing my commit messages. I do plan to
get back to this with better descriptions, and that may
motivate others to read the series and provide feedback.

Thanks,
-Stolee
