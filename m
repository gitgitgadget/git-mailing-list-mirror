Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDDCC433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 17:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A30B61164
	for <git@archiver.kernel.org>; Mon,  3 May 2021 17:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhECR0t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 13:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhECR0t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 13:26:49 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349F3C06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 10:25:55 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id n138so9229461lfa.3
        for <git@vger.kernel.org>; Mon, 03 May 2021 10:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=wjLzKIMPdHVNISJwPGx9OgenrVh1hYKcYWuwyOQ1m7k=;
        b=hDkD+LPJHG5bVhpTpsZWtJ/P07rm5DexliAU3Jniwx116INbTSrI0PgW31DfWjJRV/
         glmdx4CAULes86diMkO54K486/Cw6OV8RnsMd+qPZkrENrUFhrxL5yyDX+fNkjrvVaPZ
         sTLxsX+geoZqMTjDl+gQo7x1av4+2SRiVqwsKCaHxp7e9W+WiAh76JKNRvIRxhho7NhM
         h432ERi7XqEZ9r2X/h9SY5KZaQ6/dfSiqHbueTcOgmrcpKsktg/5iIZ1zfVotHQPznS5
         uJUaPhCBcUh0IrrxdgP8qsYUOEQ74DlHbq34MFzs/X17IoEs0pCcexO+pKwlDEQcUG/T
         XpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wjLzKIMPdHVNISJwPGx9OgenrVh1hYKcYWuwyOQ1m7k=;
        b=NATCsxc6V+hjOERUOJgOlJ1LuFjimkHvWfd7DO0oKt48FW/TeFNk/gCJtm2B8Q2nQx
         gRuGVT1rKpJIpT4SYO8FDCRF26s0pSq2EkLoI3QR66yuvkHKP6hgDpQYRWC4PCeeyhB8
         uAZZGwNWXpAqLkfVLi6bA66SHmIIHE+XBDw0sRTQihQ4je255hoCekv/D/ID6xZgqhap
         J6825zFmlqTxNPZvTl7AAFbZRWVg8Jj4uPWyJnmWqZ6WbjEckle50wIBmlke6+GsQ2Cu
         8B9c98SFipR4fn7uZw/BS+bMECt20pqaYGaaTYqAk+re2zTstJkyQtH/JzE7OVjzcbat
         zU/g==
X-Gm-Message-State: AOAM530bt7J/JgnmtQOQPAi09JExklNpy7UpzEUR/a5fDZycZvhLhlAJ
        p/96ARGE7iFQU6MrDXKweFcuNMW0FINNHmWbGT21EA3xRwJAQw==
X-Google-Smtp-Source: ABdhPJxKX03CrCf0ljoEkSrr/kXkdQ1gLLyIYgtKIYDwFE9lLuvEyYEB9bU4IB6sMm5XxKTruvNvvpJWm+yQeRRUVXU=
X-Received: by 2002:ac2:53aa:: with SMTP id j10mr7254267lfh.524.1620062753736;
 Mon, 03 May 2021 10:25:53 -0700 (PDT)
MIME-Version: 1.0
From:   Mark Amery <markrobertamery@gmail.com>
Date:   Mon, 3 May 2021 18:25:43 +0100
Message-ID: <CAD8jeghpOQoibk0xM0QgLsOwLNw9GdM=4rhYuzV-NSkw8LinMQ@mail.gmail.com>
Subject: Bug: Changing folder case with `git mv` crashes on case-insensitive
 file system
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Attempting to change the case of a folder's name using a command like
`git mv foo FOO` crashes on case-insensitive file systems, like the
default APFS used on Apple Macs.

Here are simple steps to repro this:

    $ mkdir testrepo && cd testrepo && git init
    Initialized empty Git repository in /Users/markamery/testrepo/.git/
    $ mkdir foo && touch foo/bar && git add foo && git commit -m bla
    [master (root-commit) a7e9f5f] bla
    1 file changed, 0 insertions(+), 0 deletions(-)
    create mode 100644 foo/bar
    $ git mv foo FOO
    fatal: renaming 'foo' failed: Invalid argument
    $ echo $?
    128
    $ git status
    On branch master
    nothing to commit, working tree clean

If I create a case-sensitive APFS volume using Disk Utility and try
the commands above on that volume, `git mv foo FOO` works correctly:
it emits no output, exits with a 0 status code, and stages a change
renaming `foo/bar` to `FOO/bar`. However, on my main case-insensitive
volume, `git mv` behaves as shown above: it exits with code 128,
prints an "Invalid argument" error message, and does not stage any
changes.

The command still fails in the same way if you use `git mv --force`
instead of just `git mv`.

Note that previously, `git mv` could not change the case of *file*
names on case-insensitive file systems, until that was fixed in commit
https://github.com/git/git/commit/baa37bff9a845471754d3f47957d58a6ccc30058.
I'm guessing there's a different code path that needs fixing for
changing the case of *folders*.

As far as I can tell, this error has never been reported to the Git
mailing list, but it seems to be encountered frequently;
https://stackoverflow.com/questions/3011625/git-mv-and-only-change-case-of-directory
mentions this bug and has 86000 views.

In case it's relevant, here's my system info as output by `git bugreport`:

    [System Info]
    git version:
    git version 2.31.1
    cpu: x86_64
    no commit associated with this build
    sizeof-long: 8
    sizeof-size_t: 8
    shell-path: /bin/sh
    uname: Darwin 18.7.0 Darwin Kernel Version 18.7.0: Mon Apr 27
20:09:39 PDT 2020; root:xnu-4903.278.35~1/RELEASE_X86_64 x86_64
    compiler info: clang: 11.0.0 (clang-1100.0.33.17)
    libc info: no libc information available
    $SHELL (typically, interactive shell): /bin/bash
