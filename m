Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21CAC433FE
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 01:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B59E6023D
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 01:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238445AbhIFBRF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 21:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhIFBRB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 21:17:01 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81358C061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 18:15:57 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id me10so10136123ejb.11
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 18:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Q0xWpRwUUn/P+13VCL4XWiJgelk4XaSYNf6vpk1ZVu4=;
        b=NSWrQo7p5LeOkRutF5SF+Thdzngbo9rcvMwO2rbaDR8sIUaY128/1kj9aP6RWg4YRM
         xV4jhYu8Wtfstg1c1mBD2+pYOxNivojuuA9sUMq4Y7NCplFdH/T1U888kdFJpCmdWV5v
         +vukDoyOEPoTY8jAaAvsSbWhM+VRn6Nw+/A0Gd5+KN6q8WBdRzzxsXbfjUKUCaWe5RCV
         7Srja6UdoMJjm17WTrAStr0LM5vas+Zxif2a4NV79j+xU8WcDSirFTLmbFfyr0uIUs6l
         bJus6ABqjp30s9yXO3CGX2aTvUimduZ0RSXVgVSS/znE7Dt97crlcYg8kQuApPyliY2m
         1p3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Q0xWpRwUUn/P+13VCL4XWiJgelk4XaSYNf6vpk1ZVu4=;
        b=PmCt+SOAbJm6w/5HFH+1jWq5MxAGs6jIKo25fitzmuGzciz1QNGFNlYKlvUoAlnW6v
         cRvFrdF1FocHN6hyJQQ/WgczG2PE7tPMsGZ1P1BzHhaJySwZErXDbZuOhF/5hWP8/ia0
         FVrM9u3Kk93/s7D8YMA2vllSmr+V7j4IsY198dFD0Tq8+HD4syYDyvo/4EE47f+46VZf
         Nb0CZY3ZYqjEYc8zNPYgNDimrrODfQrqbj1N18am4K5Lrp3Rq3nf48NI+X7bumXnUknh
         ICFCWFujRANGS5k4eY0JXfGJtDolDzLjlW+UmWqHK8fLySZ/GbVv2jSnnQbZWSIt9Z3X
         4iFQ==
X-Gm-Message-State: AOAM530c0gbGH/Rm/eE1hcgz861aMbd+l5CM4FV82slAx5IyBVb44Y3m
        +BV9iM/qdn9xrAczc9MIAiItKIA8y32A1w==
X-Google-Smtp-Source: ABdhPJwcRZI8/eyb+f47X1RiYzrFHIYiyujvo0kZ89zNm/MCKMBqcghLfRLcr+GtH/EAbwxnC7ciVA==
X-Received: by 2002:a17:906:74d:: with SMTP id z13mr11109107ejb.127.1630890955790;
        Sun, 05 Sep 2021 18:15:55 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j22sm3021912ejt.11.2021.09.05.18.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 18:15:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 08/15] scalar: implement the `clone` subcommand
Date:   Mon, 06 Sep 2021 03:12:11 +0200
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
 <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
 <f3223c10788fe836d0322006dc2dcbafe08f6b5b.1630691688.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <f3223c10788fe836d0322006dc2dcbafe08f6b5b.1630691688.git.gitgitgadget@gmail.com>
Message-ID: <8735qipkqd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 03 2021, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This implements Scalar's opinionated `clone` command: it tries to use a
> partial clone and sets up a sparse checkout by default. In contrast to
> `git clone`, `scalar clone` sets up the worktree in the `src/`
> subdirectory, to encourage a separation between the source files and the
> build output (which helps Git tremendously because it avoids untracked
> files that have to be specifically ignored when refreshing the index).

Perhaps it's simpler to just say about that /src/ injection:

    `scalar clone` adds an implicit "/src" subdirectory to whatever
    directory the user provides, with the added stricture on top of
    doing that with "git clone" that the "src" cannot exist already.

...

> +	if (is_directory(enlistment))
> +		die(_("directory '%s' exists already"), enlistment);
> +
> +	dir = xstrfmt("%s/src", enlistment);

Which also seems to suggest a bug here. I.e. if I "git clone <repo>
/tmp/xyz/abc" and Ctrl+C it we'll remove "abc", but leave "xyz"
behind. Since we're creating that "xyz" (or "src") implicitly here an
abort/ctrl+C followed by a retry is going to run into this error, isn't
it?

I.e. it seems what's missing in this state machine is checking if the
directory was there already, and if it isn't add it to the existing
atexit() removals.

Which may be tricky seeing as this is shelling out to "init" then
"fetch" etc, i.e. who removes it? But maybe not.
