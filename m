Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB598EB64DA
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 10:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbjGNKGu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 06:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbjGNKGo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 06:06:44 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11EEE44
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 03:06:41 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so6161686a12.1
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 03:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=akorzy-net.20221208.gappssmtp.com; s=20221208; t=1689329200; x=1691921200;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TpdbrH5kDOzlYZnlq6T+4IJMIIyMIznPATHuOnOCyC0=;
        b=N3NhgggEXZorZdIjcsNF1F0JR6WCSPJNwON09Q2GmqkTd0dQDAG0yn4Nw7CupKpiBu
         Cgsm8kVBP0U+Ogks34feORaHy/xV3iBpr4Q5cwGG5iymEXV+g8I5BWrTIN6upiAxTfU8
         7S0b6Vo36VI4b8U7Sxc7bTcHjEbW1jygTVnJpxZJPifmtNo+gNdZsNE4jFowy+99HHjt
         9CCkF9yXurmwsGRxXoTwD8d7Hj9e6SJN0Y6qI/hBTNEG72bTV037pxsuGhJn5bEP7BBo
         lhi4eDUs3ObUeW2ye/RAyxZYyyTfOvdVGehbFpNqMP5kldKNEyXdJdujz39aLFAeic01
         gnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689329200; x=1691921200;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TpdbrH5kDOzlYZnlq6T+4IJMIIyMIznPATHuOnOCyC0=;
        b=PQSwyUk7dheT7dD40V+r2pDqEpCenW6KENYF/Ilwec2WzFMZ0vrA/C2hPy/wwI63tH
         c91CdFC1LyvXDXu0jEaLiJ0VtTV25rhu07K7cjCTy2j708Nl9sCG0GT7ux1oYptX2/0t
         cNxtyOpNdWSqBgxqaJ9o1HxEI/aB/T7YXRU9HDubpDcCTVxFaFrc5f1Eu62C502S/ebC
         Anc5cbSVUcUPO1tpjZIiLlnTfzj3Xdj1HKfMZ5SB6V2QLg3BTV95Xv+G8Duv0DM0xPiG
         uNelpsh860b6M1DSNIdYh1A0VLiGuUZSVvCXbzKft5+NVTPebXpnYxX6bbT90UiNIxhy
         OViw==
X-Gm-Message-State: ABy/qLZ1TQN7k3JhZUhPEH7MBQmcJoCKAbA9Y3CDTNhX2Rh7z/AYB6Bn
        BWEoZX2hMzAjPcq76n1T8sTmF91sOExtvI2DRjQ=
X-Google-Smtp-Source: APBJJlEGbrBJ7NhKLPyFLd9HoUGmuUqvuNzsALpfuKcsPK/IfHnVlm9VvlQ3zN/OgTK1oB7wEWAQYg==
X-Received: by 2002:a05:6402:27c9:b0:51e:5898:a23d with SMTP id c9-20020a05640227c900b0051e5898a23dmr2717599ede.5.1689329199511;
        Fri, 14 Jul 2023 03:06:39 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id n7-20020aa7c447000000b0051e22660835sm5556274edr.46.2023.07.14.03.06.38
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 03:06:38 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-9939fbb7191so347880966b.0
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 03:06:38 -0700 (PDT)
X-Received: by 2002:a17:906:5d16:b0:992:13c7:560 with SMTP id
 g22-20020a1709065d1600b0099213c70560mr2810311ejt.38.1689329197469; Fri, 14
 Jul 2023 03:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <CADWu+UnThMq2M+kCMADP9rZ5c6nL+Hz+z0-OqRnuG2oYVzbvWw@mail.gmail.com>
 <71f7d816-b139-03ab-88fc-7552d65e4498@gmx.de>
In-Reply-To: <71f7d816-b139-03ab-88fc-7552d65e4498@gmx.de>
Reply-To: ak@akorzy.net
From:   =?UTF-8?Q?Aleksander_Korzy=C5=84ski?= <ak@akorzy.net>
Date:   Fri, 14 Jul 2023 12:06:26 +0200
X-Gmail-Original-Message-ID: <CADWu+UmSotSA3Usn=z3C5wBpYp8DWnb0_s1ATv=RKZn+YrERvA@mail.gmail.com>
Message-ID: <CADWu+UmSotSA3Usn=z3C5wBpYp8DWnb0_s1ATv=RKZn+YrERvA@mail.gmail.com>
Subject: Re: Beyond Merge and Rebase: The Upstream Import Approach in Git
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

My responses are inline:

> I know this strategy well, having used it initially to maintain Git for
> Windows' patches on top of Git releases.

It's good to know others are using similar ideas :-)

> However, I soon realized that the delineation between upstream and
> downstream patches was unsatisfactory, in particular when new downstream
> patches are added. In the context of the example above, try to find a `git
> rebase` invocation that rebases the current set of downstream patches:
>
>    o---o---o---o---o---o---o---o  upstream/main
>         \           \
>          \           o'---o'---o'
>           \                     \
>            o---o---o-------------S---o---o---o  main

We have solved that problem with custom scripting. The git-upstream[1]
tool properly rebases the commits in that case. This is one of the
reasons why I would like to see the git-upstream functionality
reimplemented in git itself. With git today, you can't achieve that
with a single `git rebase` command, but you can with a series of
commands. Introducing a new command or switch to git would allow us to
perform that operation with a single command.

Let's recap what the automation needs to do. Assume the following situation:

  o---o---o---o---x---o---o---t  tag=v1.2.3  branch=upstream/main
       \           \
        \           a'---b'---c'
         \                     \
          a---b---c-------------S---d---e  branch=main

Let's assume the user has the "main" branch checked out and they want
to import the latest tag from the "upstream/main" branch. The commands
they run are:

git checkout main
git upstream import v1.2.3

The automation should now perform the following:

* create a new branch "import/v1.2.3" starting from tag "v1.2.3"
* rebase a', b', c' onto "import/v1.2.3"
* rebase d, e onto "import/v1.2.3"
* perform the cauterizing merge of "import/v1.2.3" to "main"

Here are important observations:

* the first rebase operates on commits present on the main branch,
starting from the first commit after x, ending with the last commit
before S
* the second rebase operates on commits present on the main branch,
starting from the first commit after S, ending with the tip of main

So the problem boils down to identifying commits x and S. Once we
identify these commits, we can perform the rebases.

To identify x we need to find the most recent common ancestor of
"main" and "v1.2.3". To identify S we need to iterate over branch
"main" starting from x and forward in time until we find the first
merge. That's the logic that needs to be implemented. If that logic
was available under a single command or switch in git, we'd be able to
perform the upstream import operation without a helper script such as
git-upstream.

> This strategy is not without problems, though, which becomes quite clear
> when you accept PRs that are based on commits prior to the most recent
> merging rebase (or rebasing merge, both strategies suffer from the same
> problem): the _next_ merging rebase will not necessarily find the most
> appropriate base commit, in particular when rebasing with
> `--rebase-merges`, causing unnecessary merge conflicts.

This can also be solved with custom logic. Let's consider the scenario
in detail:

  o---o---o---o---x---o---o---t  tag=v1.2.3  branch=upstream/main
       \           \
        \           a'---b'
         \                \
          a---b------------S---c---M---f  branch=main
               \                  /
                d----------------e  branch=topic

As before, the user runs the following commands:

git checkout main
git upstream import v1.2.3

In this case, the automation should rebase d and e between c and f:

  o---o---o---o---x---o---o---t  tag=v1.2.3  branch=upstream/main
       \           \           \
        \           a'---b'     a"--b"--c"--d"--e"--f"
         \                \                          \
          a---b------------S---c---M---f--------------S'  branch=main
               \                  /
                d----------------e  branch=topic

This logic can be implemented as follows. When the automation reaches
the merge commit M, it finds the second parent e and then searches for
the most recent common ancestor of e and main, so that it finds b. The
rebase then operates on commits starting from the first commit after b
and ending with the second parent of M.

The logic above could also be incorporated into git.

> The underlying problem is, of course, the lack of mapping between
> pre-rebase and post-rebase versions of the commits: Git has no idea
> that two commits should be considered identical for the purposes of the
> rebase, even if their SHA-1 differs. And in my hands, the patch ID has
> been a poor tool to address this lack of mapping, almost always failing
> for me. Not even hacked-up `git range-diff` was able to reconstruct the
> mapping reliably enough.
>
> And that problem, as far as I can tell, is still unsolved.

As shown above, we don't actually need to be able to map pre-rebase
and post-rebase versions of the commits in order to correctly perform
the "git upstream import" operation. The "git-upstream" helper script
is a working implementation of the strategy without doing the mapping.

That being said, being able to map pre-rebase and post-rebase versions
of the commits is useful for something else: dropping patches that
have been incorporated upstream. The "git-upstream" script utilizes
two strategies for that purpose. One of them is to use patch-id. The
other one is to use an arbitrary identifier that you attach to the
commit both in the "main" and "upstream/main" branches. In our case,
we have used the Gerrit's Change-Id as the identifier, but it could be
something else. The Gerrit's Change-Id is just a random string added
to the bottom of a commit message by a git commit hook.

> So I switched to a different scheme instead that I dub "merging rebase".
> Instead of finishing the rebase with a merge, I start it with that merge.
> In your example, it would look like this:
>
>    o---o---o---o---o  upstream/main
>         \           \
>          o---o---o---M---o'---o'---o' main

I like Junio's word "cauterize" to describe the special merge :-) So
I'm going to call this strategy "cauterize & rebase" and the strategy
I described in the initial email "rebase & cauterize".

We have also considered "cauterize & rebase" instead of "rebase &
cauterize" and the reason we opted for the latter was peer review in
Gerrit. When we rebase first, we can store the rebased commits on a
temporary import branch and push the import branch to a shared
repository. The import branch then contains everything except for the
last cauterizing merge. We then need to push only the cauterizing
merge into the Gerrit review system. The reviewer then only has to
approve the cauterizing merge to approve the entire "upstream import"
structure. We didn't need to make any changes to the Gerrit review
system to utilize it in that way. These considerations may not apply
to other review systems.

> This strategy was implemented initially in
> https://github.com/msysgit/msysgit/commit/95ae63b8c6c0b275f460897c15a44a7df5246dfb
> and is in use to this day:
> https://github.com/git-for-windows/build-extra/blob/main/shears.sh
> (...)
> https://lore.kernel.org/git/pull.1356.v2.git.1664981957.gitgitgadget@gmail.com/

Thanks for the links, they are useful :-)

With the content of this email in mind, what are your thoughts? Would
you like to see the strategy becoming a first-class feature in git?

Best regards,
Aleksander Korzynski

[1] https://opendev.org/x/git-upstream
