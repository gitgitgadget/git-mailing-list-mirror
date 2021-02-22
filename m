Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81282C433DB
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 03:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DF1E64EDB
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 03:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhBVDKK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Feb 2021 22:10:10 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:39386 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbhBVDKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Feb 2021 22:10:09 -0500
Received: by mail-ed1-f46.google.com with SMTP id h10so19998172edl.6
        for <git@vger.kernel.org>; Sun, 21 Feb 2021 19:09:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4gVP9N6yuwizFMR6JDDQN13kwmMh8A1LFjG3NGaKE+A=;
        b=LTYeHVZlow7nU9+dkPOHZ/FLO+zGJDVWUBejGHm7c+qw1LOnigPZDVQGNyDXRlbm7t
         Vrue6GIsn9BnzAQZbWTWq3w9kpaMnHv3uZ4FTldLeLQxhsq9IQL96QbHQEp1ZPfcTNaF
         NhA0AietiJPHfs3VGNJxKQEyv+P5CZUusL74EqegbjlGP5NrHtUVvio9bBP9Ybi3ZMsT
         l6BsCU8dV6tFSaSS+I1t6aQpUu9huiD0/uw63nVdMTeLuUqhUAqP0KJO6p+faRvyg9eQ
         GEM79jh3yGA/zHtSY0uTHwsdpyfqysupjsFcctgzmBG+YHXN9ItmB/mil/eQ6K0HeDbY
         ZZFw==
X-Gm-Message-State: AOAM531t0lnnmT+1CkIct7LVPxkQ62H93W6YgFgZsYxRxKz5MgxGxcnJ
        93PapAweJz+J9/bo+zCp2GcRLbgBzbEGC9BD6os=
X-Google-Smtp-Source: ABdhPJxTtfFHYJYRWtdc7DaDjovjtS0t0VwVphL1pLFjJGZ7to4YIyAytxkr6BtkGxNRXNPG3HGF769gCZ3xLqA6ZGc=
X-Received: by 2002:aa7:cb0d:: with SMTP id s13mr20076011edt.221.1613963367734;
 Sun, 21 Feb 2021 19:09:27 -0800 (PST)
MIME-Version: 1.0
References: <d57023d9f13d178dc95d7a74751923b80d1a5939.1607522429.git.gitgitgadget@gmail.com>
 <20210222004112.99268-1-stefanbeller@gmail.com> <CAPig+cT9ZUqkOZWZS3+gEd3soh-xyfxu2yvQ_gY-LMgVV-rAiw@mail.gmail.com>
In-Reply-To: <CAPig+cT9ZUqkOZWZS3+gEd3soh-xyfxu2yvQ_gY-LMgVV-rAiw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 21 Feb 2021 22:09:16 -0500
Message-ID: <CAPig+cT9FDZ78mTmuvaOyzhc+JKV3U8DRBfFRezWr2bsW4gmGA@mail.gmail.com>
Subject: Re: [PATCH] refs: introduce API function to write invalid null ref
To:     Stefan Beller <stefanbeller@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Git List <git@vger.kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>, hanwenn@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 21, 2021 at 8:20 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> The reason I ask is that the bit of code in
> builtin/worktree.c:add_worktree() which this patch targets is itself a
> hack to work around the shortcoming in which is_git_directory() won't
> consider the newly-created worktree as being legitimate if it doesn't
> have a well-formed HEAD ref. [...]

By the way, the only reason the hack of creating a temporary HEAD
(containing arbitrary OID) is needed is that add_worktree() shells out
to invoke one of git-update-ref or git-symbolic-ref. It is that
shell-out to invoke a Git command which triggers the necessity of
pacifying is_git_directory()...

> On the other hand, I could see this as acceptable if "invalid" is
> removed from the function name and if it accepts an OID to write
> rather than unconditionally writing a zero-ID. In that case, it would
> become a generally useful function without the bad smells associated
> with the too-special-purpose write_invalid_head_ref().

... so, a much cleaner fix would be to stop shelling out to set up
HEAD in the newly-created worktree, and instead call C API to perform
those functions (update-ref and symbolic-ref) directly. If that C API
does not yet exist, then it should be added.
