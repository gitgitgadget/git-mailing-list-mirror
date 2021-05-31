Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94FDC47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 04:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABE2A61108
	for <git@archiver.kernel.org>; Mon, 31 May 2021 04:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhEaEDI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 00:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhEaEDG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 00:03:06 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13118C061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 21:01:26 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id z26so4034793pfj.5
        for <git@vger.kernel.org>; Sun, 30 May 2021 21:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=H2EOoofnG6jfM3gH30FCJ69MDINx8moGOsv+lU2WURw=;
        b=QseWiRiJxfAhanTBDPy+7g4jCJE0s/b9W57BNy5pFRURD+vuccl6LaMKquBDRHNfDK
         OvLJnYW60wk0pi71Y0YXl0QhmTt/ri0h9FunwGlCf55XoRQdVwJ2zYQyM8bqnpeGSn2Q
         2dRPXp8ynoW+JECbSqK9PAsx6kuzf4J5kn5Et7jdhxOOiqPhdOqtqZBSZYuLCWRGJQuM
         P5VOFvqh0hJA4VJLbD/ZccklA2rTYy5Gr+AhXmXNQFJCdWIfIfg/nX5Ma9jSQjA0ufzo
         IEvaNj3DzVVUgsOTGfiG+qhEmVAmlNJxPv+DtEz+BST8kXlvtrALC79sJsvlGde8td1L
         hopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H2EOoofnG6jfM3gH30FCJ69MDINx8moGOsv+lU2WURw=;
        b=gpj9EZZprdpGvG/vsOUbwiqEuk1dzbe07Es4aoNzhSKNPjjj4F+3lTbY9nGOjj9wOh
         dYxn4gLGX7PVo37hkxJM+Xkkqa0FNiZTKWLpG5ueEMqeSyoLqDE3qPaOZB+siAjZXE72
         Xr2poQyC9tTqLI/nUA6QEGiBTqIEndyICPK3fKeyzfpxYgo3a4FYVA4vu+j2zAgRYnE1
         3rC4qQVVhjh2UyTyPWEmQ3USe74FGFWpFV/wLwnWYA+dm62KNG6RYXW9MKzWTokk9uQt
         jMhOC3VKGk20O8qX6d0Z9DxKk59ryvIqbrQ9Pk3WtH2LEbMG2HlGNXZleUjMst+dBltT
         PUWg==
X-Gm-Message-State: AOAM530CIFY8yyH+HDww5mnPH0GCvPreKXs7OMkOvzPzzBDGAgvYvWhF
        JzzOUuZ6LHsBGf+s3D3r0lFEyocuuDlesw==
X-Google-Smtp-Source: ABdhPJx+g3fLSRbiOrd3gKC3veUe4KoDbuRe1rk7k2XPCjVa9zKkQmpblZmBju0Lp16/F5lTTdJqtA==
X-Received: by 2002:a63:6c08:: with SMTP id h8mr20740194pgc.226.1622433685328;
        Sun, 30 May 2021 21:01:25 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-39.three.co.id. [116.206.28.39])
        by smtp.gmail.com with ESMTPSA id s15sm6283589pjr.18.2021.05.30.21.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 May 2021 21:01:24 -0700 (PDT)
Subject: Re: Bug when cloning a repository with a default branch called HEAD
To:     =?UTF-8?Q?Bj=c3=b6rn_Kautler?= <Bjoern@kautler.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <CAKChYSqgGRfBh68oj=Gt7q4uyS7D879aQZQiZ1RsyqaDToV+0g@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <07edafe5-d0a2-4a2c-12a2-28c163f6fdda@gmail.com>
Date:   Mon, 31 May 2021 11:01:22 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAKChYSqgGRfBh68oj=Gt7q4uyS7D879aQZQiZ1RsyqaDToV+0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 29/05/21 02.05, Björn Kautler wrote:
> Hi,
> 
> I'm not right now sure why this repo is in this state or how it got
> there, but that doesn't matter.
> But if you clone it, everything is fine.
> And if you then try to fetch it, Git goes havoc:
> 

I'm trying to create minimal reproducible test repo by switching initial 
branch to HEAD:

$ mkdir shark && cd shark
$ git init
$ git checkout -b HEAD

But when I checkout, it returned error as expected:

> fatal: 'HEAD' is not a valid branch name.

Thus I can't reproduce this issue.

> $ git clone https://gitlab.com/Vampire/whelk.git/ && cd whelk &&
> GIT_TRACE=1 git fetch; echo $?
> Cloning into 'whelk'...
> remote: Enumerating objects: 525, done.
> remote: Counting objects: 100% (525/525), done.
> remote: Compressing objects: 100% (227/227), done.
> remote: Total 525 (delta 280), reused 525 (delta 280), pack-reused 0
> Receiving objects: 100% (525/525), 165.63 KiB | 3.52 MiB/s, done.
> Resolving deltas: 100% (280/280), done.
> 21:04:15.761530 exec-cmd.c:237          trace: resolved executable
> dir: C:/Program Files/Git/mingw64/bin
> 21:04:15.765532 git.c:447               trace: built-in: git fetch
> warning: refname 'HEAD' is ambiguous.
> 21:04:15.769530 run-command.c:667       trace: run_command:
> GIT_DIR=.git git remote-https origin
> https://gitlab.com/Vampire/whelk.git/
> 21:04:15.795532 exec-cmd.c:237          trace: resolved executable
> dir: C:/Program Files/Git/mingw64/libexec/git-core
> 21:04:15.799535 git.c:734               trace: exec: git-remote-https
> origin https://gitlab.com/Vampire/whelk.git/
> 21:04:15.799535 run-command.c:667       trace: run_command:
> git-remote-https origin https://gitlab.com/Vampire/whelk.git/
> 21:04:15.832533 exec-cmd.c:237          trace: resolved executable
> dir: C:/Program Files/Git/mingw64/libexec/git-core
> 21:04:16.438060 run-command.c:667       trace: run_command: git
> rev-list --objects --stdin --not --all --quiet --alternate-refs
> 21:04:16.461060 run-command.c:667       trace: run_command: git
> rev-list --objects --stdin --not --all --quiet --alternate-refs
> 21:04:16.475738 exec-cmd.c:237          trace: resolved executable
> dir: C:/Program Files/Git/mingw64/libexec/git-core
> 21:04:16.478705 git.c:447               trace: built-in: git rev-list
> --objects --stdin --not --all --quiet --alternate-refs
> error: multiple updates for 'refs/remotes/origin/HEAD' (including one
> via symref 'refs/remotes/origin/HEAD') are not allowed
>  From https://gitlab.com/Vampire/whelk
>   ! [new branch]      HEAD       -> origin/HEAD  (unable to update local ref)
> error: some local refs could not be updated; try running
>   'git remote prune origin' to remove any old, conflicting branches
> 21:04:16.496254 run-command.c:667       trace: run_command: git
> maintenance run --auto --no-quiet
> 21:04:16.510254 exec-cmd.c:237          trace: resolved executable
> dir: C:/Program Files/Git/mingw64/libexec/git-core
> 21:04:16.512256 git.c:447               trace: built-in: git
> maintenance run --auto --no-quiet
> 1
> 
> Cheers
> Björn
> 

The remote [1] might misconfigured default branch, so instead of 
master/main it pointed to HEAD, and it caused the issue.

Thanks.

[1]: https://gitlab.com/Vampire/whelk

-- 
An old man doll... just what I always wanted! - Clara
