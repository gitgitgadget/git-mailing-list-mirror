Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025A7C433E9
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 22:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9EE264FC8
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 22:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhCHW36 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 17:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbhCHW3f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 17:29:35 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1DBC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 14:29:34 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id p15so18112143ljc.13
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 14:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sbjgJuy4GvR26dQmHGer9naE+dHe9pTeAEayKk0YZGg=;
        b=FfpvY7QjmepQpK/u3in+1kix1VvIPcN/iP74fJzrV9EQ257o4wizZDXKqAhB1k0qQ3
         UBP7lCUUlsN3sgQQBa+3sGW/eNKY9P7SSZyY2LrAMlllIZ8Tzj3v16c0xoijAUEK1YgB
         4fegIyR4Loidz0xt2xhNDjgm/8SZYs7i3Wyo3g0FQ6dGlwNeXaqrnd5jL0sqGoU59BO0
         Zy0yVkGRoiqYQZ6FJXd/cvpa0wy8gh4Cjhqm9ErLF7XyzkA4TwrK6nWWSOp7DM0CgbBY
         zzkpLAnYpMF2watwc6PzHOACr4yUlpMgZFWr2UBfETcCy7GgEUCplganV4lNfesI606N
         hX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sbjgJuy4GvR26dQmHGer9naE+dHe9pTeAEayKk0YZGg=;
        b=q/8WiT/gAF2BSSAlNOPmqg0sQla3lU1lCVvZyVYOpYmbggjSC7ymjjTYXogGNlTO8l
         YBs2ORm6Pzy4E3oUk8wlQc+C3ZqAqolawcJ7UvQ1CwM9ZDr8fMhfr8V1UWSOfv1YyQ2D
         ikuN0NNzx4OYd4xtMoB2LTY52K3ujgVq8USYi0Gx6N0FA/iJTv7M9bCm9KRTQSYfTwL6
         CoMgNe7hQrHM8ZM83lNSgII0cp73yX8Njb8TduC1HAQhGQN5g03FTOe36FAg8lwO+4p/
         Wap9al7qUqu7iMzzZsHfQLZZr+WoSILNAwnEqT/a6z4MP+eQMFJP7izrDu8MKsC1sdq6
         FlKQ==
X-Gm-Message-State: AOAM533QCQ7Orj2nrzkR0qjuG1RtusdVrF/fxjM/MjccOxPzI78uNQGU
        QdeHThXTnUOVP7Ji82+SJbXLQHvbSwP2aQbwt5oDDRzq+14=
X-Google-Smtp-Source: ABdhPJwg6zbxqUs52VI4PYeh0jfATpIHqUk1WCFT9mZOmQB+3PdeLo+m/6sUwOB7HZWd5hY2x9QE16lQMfYLLVkR5YU=
X-Received: by 2002:aa7:dc49:: with SMTP id g9mr775049edu.60.1615242567201;
 Mon, 08 Mar 2021 14:29:27 -0800 (PST)
MIME-Version: 1.0
References: <17813b232e9.e48d03c3862272.7793967418558853913@monospace.sh>
In-Reply-To: <17813b232e9.e48d03c3862272.7793967418558853913@monospace.sh>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 8 Mar 2021 14:29:16 -0800
Message-ID: <CAGyf7-F6jbs-HQeCSMjf_y8Y=5ZfME=CjBagAfKUbnP_0vDXqA@mail.gmail.com>
Subject: Re: Performance of "git gc..." is extremely bad in some cases
To:     Anthony Muller <anthony@monospace.sh>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 8, 2021 at 1:32 PM Anthony Muller <anthony@monospace.sh> wrote:
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> git clone https://github.com/notracking/hosts-blocklists
> cd hosts-blocklists
> git reflog expire --all --expire=now && git gc --prune=now --aggressive

--aggressive tells git gc to discard all of its existing delta chains
and go find new ones, and to be fairly aggressive in how it looks for
candidates. This is going to be the primary source of the resource
usage you see, as well as the time.

Aggressive GCs are something you do once in a (very great) while. If
you try this without the --aggressive, how does it look?

>
>
> What did you expect to happen? (Expected behavior)
>
> Running gc on a ~300 MB repo should not take 1 hour 55 minutes when
> running gc on a 2.6 GB repo (LLVM) only takes 24 minutes.
>
>
> What happened instead? (Actual behavior)
>
> Command took 1h 55m to complete on a ~300MB repo and used enough
> resources that the machine is almost unusable.
>
>
> What's different between what you expected and what actually happened?
>
> Compression stage uses the majority of the resources and time. Compression
> itself, when compared to something like zlib or lzma, should not take very long.
> While more may be happening as objects are compressed, the amount of time
> gc takes to compress the objects and the resources it consumed are both
> unreasonable.

The compression happening here is delta compression, not simple
compression like zip. Git searches across the repository for similar
objects and stores them as chains with a base object and (essentially)
instructions for converting that base object into another object.
That's significantly more resource-intensive work than zipping some
data.

>
> Memory: RSS = 3451152 KB (3.29 GB), VSZ = 29286272 KB (27.92 GB)
> Time: 12902.83s user 8995.41s system 315% cpu 1:55:36.73 total

Git offers several knobs that can be used to influence (though not
necessarily control) its resource usage. On 64-bit Linux the defaults
are 1 thread per logical CPU (so hyperthreaded CPUs use double) and
_unlimited_ memory usage per thread. You might want to investigate
some options like pack.threads and pack.windowmemory to apply some
constraints.

>
> I've seen this issue with a number of repos and size of the repo does not
> determine if this happens. LLVM @ 2.6 GB worked flawlessly, a 900 MB
> repo never finished, this 300 MB repo takes forever, and if you test something
> like chromium git will just crash.
>
>
> [System Info]
> hardware: 2.9Ghz Quad Core i7
> git version:
> git version 2.30.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Darwin 19.6.0 Darwin Kernel Version 19.6.0: Tue Jan 12 22:13:05 PST 2021; root:xnu-6153.141.16~1/RELEASE_X86_64 x86_64
> compiler info: clang: 12.0.0 (clang-1200.0.32.28)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /usr/local/bin/zsh
>

Hope this helps!
-b
