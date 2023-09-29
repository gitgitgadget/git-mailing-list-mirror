Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6E5E7734C
	for <git@archiver.kernel.org>; Fri, 29 Sep 2023 23:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjI2X4u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Sep 2023 19:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjI2X4t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2023 19:56:49 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A00113
        for <git@vger.kernel.org>; Fri, 29 Sep 2023 16:56:47 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9b29186e20aso1263732266b.2
        for <git@vger.kernel.org>; Fri, 29 Sep 2023 16:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696031806; x=1696636606; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9jW9/7zS/tVisw1W5tSA8cxHv3Lj7p0zFbBbfgdL9As=;
        b=dVIgsWmFq14Wtrk7UMgemG/65Qdr6QVAlOfYC8kLUnHvfCIrgn1Oo1nu+4VnLOqtN3
         pRULAMD5u+9oJeN/D6JSqPokki9eg4nyzyI92Xse40NNuB9zcrRNulxUKRL4CKbKCdJm
         NIRE+mimOT13/O8v1fh0MNvvvi93+fPjcPuW1q9SjBF+6E7N5jGgPBgxyQ5QGpagfnBw
         p/ZIg0WekFhz4FJinPSmtc7ADOnotAoaRpa4x5dTrDpW4frHWPAotVlZZFsF8sfBv98/
         Q0yie3acb4lmwf1B30usmdkQ1lQJlAZm/Gmj9vAXJzNBPnMlbTxD/x5biPP527QE0qPB
         3WPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696031806; x=1696636606;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jW9/7zS/tVisw1W5tSA8cxHv3Lj7p0zFbBbfgdL9As=;
        b=t+uZoWCAN6hGlrX79+EyT7tF6qq/NCQ6fSqVMTsq07kQCqR9TGmRq4v/c94g9zDmAh
         FMii1A16PjAzXCo0UhjA8mSc7Pz7T/pcr4R5wVVGEYSTnFjdQxM3Ad4hWnl4L4msR83g
         PC9KVW4XimHUvXWQpPjPgI+61lzXqwwmw1a4c7tVC7gxrvQQOxDuWN7nDl0pZgEeyClu
         SSTY+SfkXIme+m92aqjdDQ9rvBKltSiWN/+xx7819x+32gxJMbClZY6OCUorL6XWDiuX
         /tB8xA3x+JjvkHKs32vE+d5qWoB3xqPzPwQPeXmNy37ncDhE28szIeUmKgmZw7cWJtda
         oCXw==
X-Gm-Message-State: AOJu0YzpevQL79od4rr14k2syvQlb1BS6evYnaXpvnt5oWrZmvOe09a+
        1yrvPUWqsbebKy0qWAk++aMrKlMd3Ixw5uaRgWqQs3NbVZ3OgSm7
X-Google-Smtp-Source: AGHT+IFnZhVfoJt6YOFyXge8d8/GaQf3C19GH7IWj+ZAXkSuTPE1Wn5V5mcxPiHky1VA1dZqLSOp7XUK+tUpZzx/1SA=
X-Received: by 2002:a17:906:29a:b0:9ae:7d2d:f2b1 with SMTP id
 26-20020a170906029a00b009ae7d2df2b1mr4634643ejf.73.1696031805512; Fri, 29 Sep
 2023 16:56:45 -0700 (PDT)
MIME-Version: 1.0
From:   Benjamin Hiller <benhiller@gmail.com>
Date:   Fri, 29 Sep 2023 16:56:19 -0700
Message-ID: <CAPWWTaDE5559vA1qa0zhBid_ep9ht+PxPSDS5YC7Dk0NN8sp9A@mail.gmail.com>
Subject: git grep performance regression on macOS
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

git grep seems to have gotten much slower as of git 2.39 on macOS for
complex extended regexes.
We noticed this because git secrets --scan was running much more
slowly for some people on our team, and eventually realized that it
was due to them using a newer version of git. git secrets runs a git
grep command with an extended regex (this is a somewhat simplified
version of the command, but still shows the performance issue):

git grep -E "(A3T[A-Z0-9]|AKIA|AGPA|AIDA|AROA|AIPA|ANPA|ANVA|ASIA)[A-Z0-9]{=
16}|(\"|')?(AWS|aws|Aws)?_?(SECRET|secret|Secret)?_?(ACCESS|access|Access)?=
_?(KEY|key|Key)(\"|')?\s*(:|=3D>|=3D)\s*(\"|')?[A-Za-z0-9/\+=3D]{40}(\"|')?=
|(\"|')?(AWS|aws|Aws)?_?(ACCOUNT|account|Account)_?(ID|id|Id)?(\"|')?\s*(:|=
=3D>|=3D)\s*(\"|')?[0-9]{4}\-?[0-9]{4}\-?[0-9]{4}(\"|')?"

What did you expect to happen? (Expected behavior)
With git 2.38, that command took under half a second to run on a large repo=
.
Using the git (https://github.com/git/git) repo as an example, it took
0.2s on my laptop.

What happened instead? (Actual behavior)
After 2.39, it now takes over 40 seconds on my laptop with the git repo!

What's different between what you expected and what actually happened?
The command runs much more slowly, though it still does return the
correct result.

Anything else you want to add:
I confirmed that the performance regression was first introduced in
2.39. Additionally, I saw that reverting the change to Makefile from
https://github.com/git/git/commit/1819ad327b7a1f19540a819813b70a0e8a7f798f
fixed the performance regression and the git grep command went back to
taking <1 second. That seems to indicate that switching from Git's
regex library to the native macOS regex library caused this
performance regression, but I haven't investigated beyond that to see
why the native macOS regex library is so much slower.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.42.0
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 22.4.0 Darwin Kernel Version 22.4.0: Mon Mar  6 21:00:41
PST 2023; root:xnu-8796.101.5~3/RELEASE_ARM64_T8103 arm64
compiler info: clang: 14.0.3 (clang-1403.0.22.14.1)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
post-checkout
post-merge
pre-commit
pre-push
