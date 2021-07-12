Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA634C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D89E61221
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbhGLRqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 13:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbhGLRqf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 13:46:35 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC2BC0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:43:45 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id m3so4954414qkm.10
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QfHT6JXKj+Hb+m/N6sAJVhy84Ve6TkNh0e8t5YKxE4A=;
        b=mcGoXLouAuxYpKl6pzo31u8MiyFooFVN/oNRPeyCSyGmstWfjVKV/ONywFUsvdQ4Gu
         bUdwaDjW091E4AvNSVtPk0CZIcFqmXsnbBWDoYopgpAHgtGoXoiLL9sADsdO9iRiO4VY
         qyR0ks/sQ76Dd/HKlGFOUMufSat6v4bt41T7oMEcagHDlhYz+3vHJDfveRlAI4fhSkhe
         cz3FrUSxfT1gcy56a7XiYLQE8ZGH15T4TbeQnY3GqtHrN0EF67NMeQaRw6z7RMAri7lM
         VQjbe2Ujp3iD45dW4shOx90sfOCmkAmi17FfFpz3SGYGblfCiP9lyAy7Gu9YMA2pbwzd
         KXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QfHT6JXKj+Hb+m/N6sAJVhy84Ve6TkNh0e8t5YKxE4A=;
        b=DV42RxlDnMUKBy4RJ5bavUtq4XUVL1nBA8FSzIb9PU3md/GB8ICK0Kn0pYGecr43rz
         otzLUW/Gy9cbR4huTj+/1XLuTCBNxZBeIR24UZU0HDTovMMrDu7nGe89O+5Evw6JXHSR
         PT3ECf3c5m0ND/XEI7A+T2GFnm87v0VCm5vkbB0WrIRjDMyJ6HbzqUF9qYduT2zHTa9u
         NDCqh99wrIOAoEp4bLGK04x+Tpg/FPFRFmszIuN10plY1xaGYlhKwjxIHNGRj3I2dwcx
         YzMfbJ4GFUgkPTjnDOvSvK9588YqPPLJa5q4PWT+FfUeOG6tBdinynzq1vZG9yaVPIGL
         dHkA==
X-Gm-Message-State: AOAM5336/Y3SZmHl5g1pCaRJe3ro/gRH/fRq2LvXyMiEq1kYbYdiyQ6g
        VaYJGhjN0K+T4jKFNwOJdss=
X-Google-Smtp-Source: ABdhPJy8Fha6mO9l6053QD5MhPR+KukxPipN5jo0g8a2xVpu5hXBC7PFbdabmgC4txKcWtpRmFk21g==
X-Received: by 2002:a37:e4f:: with SMTP id 76mr4061600qko.44.1626111824875;
        Mon, 12 Jul 2021 10:43:44 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id l9sm5704194qtk.51.2021.07.12.10.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 10:43:44 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] extra: new concept of extra components
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Luke Shumaker <lukeshu@lukeshu.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20210710234629.17197-1-felipe.contreras@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <c530dedb-8cad-2a73-5b56-a32173046382@gmail.com>
Date:   Mon, 12 Jul 2021 13:43:42 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210710234629.17197-1-felipe.contreras@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Felipe,

Le 2021-07-10 à 19:46, Felipe Contreras a écrit :
> This patch series introduces the concept of extra components. These are
> components which are not yet part of the core but are good enough for
> distributions to ship, and in fact, they already do.
> 
> This benefits everyone:
> 
>   1. Distribution packagers that just want to do `make install`
>   2. People who download git's source code and just want to do
>      `make install`
>   3. Developers who have no idea what's production-level quality in
>      contrib/ and just want to do `make install`.
> 
> For now they'll have to do `make install install-extra`. But if the
> result is deemed correct, we might choose to add "install-extra" to the
> "install" target.

I agree with the end goal of this series. I myself carry a patch that adds an
'install-completion' target to the main Makefile that I apply before installing
Git from 'master'.

> 
> The measuring stick I'm using to gauge if a component in contrib belongs
> in extra is simple: are we already running tests for them with
> 'make test'? If the answer is "yes, we do run tests", then the answer is
> "yes, it belongs in contrib".

OK, this seems about right, it should cover prompt and completion, but...

> 
> We might want to move more components from contrib to extra once their
> tests are being run reliably.
> 
> And we might move some components from the core which aren't really part
> of the core to extra, like gitk, git-gui, git-p4, and git-svn.
> 
> For now only contrib/completion and contrib/workdir are graduated to the
> new area.

... when I read this I went "what is this workdir thing, it must date from before
'git worktree' was added". And combing through the history, it does. The latest
commit to the script is e32afab7b0 (git-new-workdir: don't fail if the target
directory is empty, 2014-11-26), which describes as v2.3.0-rc0~60^2. And
'git worktree' was shipped in Git 2.5, 2015-07-27.

Looking at the tests, I see two uses of 'git-new-workdir':
$ git grep  -p 'new-workdir'
t1021-rerere-in-workdir.sh=28=test_expect_success SYMLINKS 'rerere in workdir' '
t1021-rerere-in-workdir.sh:30:56:       "$SHELL_PATH" "$TEST_DIRECTORY/../contrib/workdir/git-new-workdir" . work &&
t1021-rerere-in-workdir.sh:41:50:# For the purpose of helping contrib/workdir/git-new-workdir users, we do not
t1021-rerere-in-workdir.sh=44=test_expect_failure SYMLINKS 'rerere in workdir (relative)' '
t1021-rerere-in-workdir.sh:46:56:       "$SHELL_PATH" "$TEST_DIRECTORY/../contrib/workdir/git-new-workdir" . krow &&
t3000-ls-files-others.sh=75=test_expect_success SYMLINKS 'ls-files --others with symlinked submodule' '
t3000-ls-files-others.sh:87:57:         "$SHELL_PATH" "$TEST_DIRECTORY/../contrib/workdir/git-new-workdir" ../sub sub &&

So they are not really testing this script per se, more like testing rerere and ls-files
in a worktree created by 'git-new-workdir'. I do not think this enough justification
to include 'git new-workdir' in 'extra/', since 'git worktree add' does the same thing
and is a builtin command. Even if its "BUGS" section in the doc says it's "in general [...]
still experimental", an experimental builtin is better than a 'contrib' script, no ?

Cheers,

Philippe.
