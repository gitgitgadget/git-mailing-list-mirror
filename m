Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1414C433EF
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 13:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5ACA6101C
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 13:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhISNtW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 09:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhISNtI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 09:49:08 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC35FC061574
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 06:47:42 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id q3so50002390edt.5
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 06:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=o1j9bihziGudxc/aQ7Kdf2W0LP30UIZvFqzTilJnu+I=;
        b=BTeWf/cPUvMAOMBGERnNNOiMenfEb8oeGPppW64XADbwNcs6Qhq7dfJQju70biPCmD
         XKRJJQjiu4U0O5TxTIoLMxuaRwYr+m7dfzqIeiR0PW7zWm79s8WtNLOiAQdcfuK/MeRV
         LlPArBqnJL1evdI0zWtpBjKMabnbLCNP7s/D1GM+R7c8ddHS98iHO5vjkmSCI9UUer0J
         BBjYnVxB10+ig8kVntKqXGnivIviwu4gJvIzAeyOFpVpsxQTLIsuYqASLUEhStZAdgek
         gFet4cacnrCHfERt5jqyeA0mzuM6wQ9GhwuqR7AN4o7h6AstBfMJYJoRD7gzwTXotq0L
         r6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=o1j9bihziGudxc/aQ7Kdf2W0LP30UIZvFqzTilJnu+I=;
        b=wbdRp6dbFekwaN7bT/7K0LlxDHSBWdSLWRccIbAHOGHjLZfVP5dg8aexNfwUt/uqXV
         7LvUh3Ca1cd/fRW1sxMvwIwpgzB4WdWjvTnW0lmZo64CKNGB8Tl3sSYM9Dpbh0HnzGIJ
         CvXJrj/4ul4sPnXWlg8oyed4qFtfybx2JeH5sG91df0dTaFfP7X/jYwXNClQmQy4mQhT
         PVeHKJQDJfnTLV/g7b5IT53Y3DRSBwkpsOSlx1FsMoU8LU9dhB30tiTkkhLVd6l5HzoC
         SlR0DbpR8vmVlp8rGiNH7lMZRJ01tJzLOOZcvyBNkgzUgnLwogHkFBMi5hgmMQa96MWX
         0vEw==
X-Gm-Message-State: AOAM5336iPWKP/KEDPeO7rodarJGQ6DIg29VEjTLUe33PuGcxe9MHHf0
        JPPscLSvthb1E7U9fYXiZxbEtsy30dh4fQ==
X-Google-Smtp-Source: ABdhPJzvd/TYlaCsyhk2WmVq7C2GKm/xqG41aFpDrUkcEXgZWTU0Whle1jYCnrI+HRZvrmTgz7VvFA==
X-Received: by 2002:a17:906:85d8:: with SMTP id i24mr22999629ejy.451.1632059261195;
        Sun, 19 Sep 2021 06:47:41 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ec3sm1854527edb.72.2021.09.19.06.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 06:47:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Fedor Biryukov <fedor.birjukov@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/6] t2500: add various tests for nuking untracked files
Date:   Sun, 19 Sep 2021 15:44:55 +0200
References: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
 <b634136a74b37a6f73bc3038f79031e040423883.1632006923.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <b634136a74b37a6f73bc3038f79031e040423883.1632006923.git.gitgitgadget@gmail.com>
Message-ID: <871r5kd6dg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 18 2021, Elijah Newren via GitGitGadget wrote:

> +	test_create_repo reset_$1 &&

s/test_create_repo/git init/ these days (also for the rest).

> +		mkdir foo.t &&
> +		echo precious >foo.t/file &&
> +		cp foo.t/file expect &&
> +
> +		test_must_fail git reset --merge work 2>error &&
> +		test_cmp expect foo.t/file &&
> +		grep "Updating.*foo.t.*would lose untracked files" error

The test is ambiguous about whether we complain about foo.t/file, or
foo.t, if there was foo.t{file,file-two} would we complain just once or
twice?

I think it's just the directory, but probably worthwhile for the test to
make the distinction. If it's a "a/sub/dir/file" do we complain about
"a/" or "a/sub/dir/" ?
