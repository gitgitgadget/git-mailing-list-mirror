Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0E9C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 00:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED10B60F9E
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 00:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbhHaAwa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 20:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbhHaAw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 20:52:29 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391F0C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 17:51:35 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id r26so22602269oij.2
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 17:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1cMpkXhY4Q8zmA6G+WD0JU+KI+y2i6fRqcN5idKY2Qs=;
        b=he+mZ7VahrR/nPk2dG3NpEVgQkM1r75xqvk0Dx6F9v8QwtrVElRwjWD0pbhSKZkgkg
         MWlOZDrHhaGujHHYm78aryb4QA3vogydGGSYSHNjtCSjBKbLRWfDqbciI3oGRhWdD8nd
         OeZCTSbQbsO2NKhR6oNBZebNMVWwu1Uzb7R6Z2yVCInW+b+H9MBp5vQ5hJmJDoq1g7kz
         +0fWwveECFmw7Oohh7HcoSo2SAv3vekpn7y7Pb/kdo4Om/pb9PFLtz1FvQ6nMxLDcyeY
         zJh/J1gaGpScpZzwuAvDQ0LJaJ4UtvCK3BS5VV0oBMvgz3C33DEX9jNzpk1V8BWL+Gt1
         HyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1cMpkXhY4Q8zmA6G+WD0JU+KI+y2i6fRqcN5idKY2Qs=;
        b=ecQ3xErkuiPvvbdE+Uiwvd2C07YrxT1rpg49o+SZGgD9kzB/3ihRaUFi6tS2a0d92V
         NmenUCxiRegXmhFssIYFfwUTWG1n6NzKDKaGiEwSvHitjS5Mt0eyzJFGvEE7zW+vwL5C
         MfH7QcAcGJt5OZsSjRyxOvUSbYVTd9sziIwuEpgn3bzvVwwch9+8+z8TYPma1FOcLX3W
         fhs1Mf7BFjwR1J4ilKmwGXQ1a2c9rWs2pH4MiUbVpILKeQvbpGwZCYYG2kxroBdBT+1n
         xpTWhM2k/3NvfFsfRf6GiX3xjEVwT5OSkVc2/Ce+t6LSz55pJvXKgL4jbBvqU5qIgL9b
         JbBw==
X-Gm-Message-State: AOAM532NvcEWyM1jltsROn4uaPgD+wdTqpafYY5Umz4aMx88OlfzTNxf
        QBf+c27ymNP3MCYDl68oU5tHDyZFfGA=
X-Google-Smtp-Source: ABdhPJw0i6+On6xNyURXQR1EWXE9i3sm7BngE5j59XVmZBVsg7K5pLoGI3xHtXJ1fgQ5Vs8DTImqJA==
X-Received: by 2002:a05:6808:55c:: with SMTP id i28mr229306oig.169.1630371094061;
        Mon, 30 Aug 2021 17:51:34 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:98ec:40d:44b0:1327])
        by smtp.gmail.com with ESMTPSA id g8sm3581943otk.34.2021.08.30.17.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 17:51:33 -0700 (PDT)
Subject: Re: [PATCH 00/15] [RFC] Upstreaming the Scalar command
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0d1ce3c0-2a19-e97a-bf0f-5f8893c806ea@gmail.com>
Date:   Mon, 30 Aug 2021 20:51:32 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/30/21 5:34 PM, Johannes Schindelin via GitGitGadget wrote:
> tl;dr: This series contributes the Scalar command to the Git project. This
> command provides an opinionated way to create and configure repositories
> with a focus on very large repositories.

I want to give Johannes a big thanks for organizing this RFC. As you
can see from the authorship of the patches, this was an amazingly
collaborative effort, but Johannes led the way by creating a base that
the rest of us could work with, then finally he brought in all of the
gritty details to finish the effort.

> Background
> ==========

...

> The Scalar project
> was created to make that separation, refine the key concepts, and then
> extract those features into the new Scalar command.

When people have asked me how Scalar fits with the core Git client, I
point them to our "Philosophy of Scalar" document [1]. The most concise
summary of our goals since starting Scalar has been that Scalar aligns
with features already within Git that enable scale. I've said several
times that we are constantly making Scalar do less by making Git do more.

[1] https://github.com/microsoft/git/blob/HEAD/contrib/scalar/docs/philosophy.md

Here is an example: when our large, internal customer told us that they
required Linux support for Scalar, we looked at what it would take. We
could have done the necessary platform-specific things to convince .NET
Core to create a long-running process that launched Git maintenance tasks
at different intervals, creating a similar mechanism to the Windows and
macOS services that did those operations. But we also knew that the
existing system was stuck with architectural decisions from VFS for Git
that were not actually in service of how Scalar worked. Instead, we
decided to build background maintenance into Git itself and had our Linux
port of Scalar run "git maintenance start".

Once the Linux port was proven out with Git's background maintenance, we
realized that the window where a user actually interacts with Scalar instead
of Git is extremely narrow: users run "scalar clone" or "scalar register"
and otherwise only run Git commands. The Scalar process does not need to
exist outside of that. (There are some other helpers that can be used in
a pinch to diagnose and fix problems, but they are rarely used. These
commands, such as 'scalar diagnose' can be contributed separately.)

It became clear that for our own needs it would be easier to ship one
installer that included the microsoft/git fork and the Scalar CLI, and
it would be simple to rewrite the Scalar CLI with all of the Git helper
APIs. We organized the code in a way that we thought would be amenable
to an upstream contribution (by placing in contrib/ and using Git code
style).

The thing about these commands is that they are _opinionated_. We rely
on these opinions for important internal users, but we realize that they
are not necessarily optimal for all users. Hence, we did not think it
wise to push those opinions onto the 'git' executable. Having 'scalar'
continue to live as a separate executable made sense to us.

I believe that by contributing Scalar to the full community, that we
create opportunities for Git in the future. For one, users and Git
distributors can opt into compiling Scalar so it is more available
to users who are interested. Another hopeful idea is that maybe this
reinvigorates ideas of how to streamline Git clones for large repos
without users needing to learn each and every knob to twist to get
things working. Since the Scalar CLI is contributed in the full
license of the Git project, pieces of it can be adapted into Git
proper as needed.

I look forward to hearing your thoughts.

Thanks,
-Stolee
