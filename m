Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD49C433EF
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 23:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB2E610A5
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 23:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240661AbhIRXQv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 19:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhIRXQv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 19:16:51 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF938C061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 16:15:26 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id y132so10168135wmc.1
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 16:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=hy0lPZwhVShay78xNvd4HGWnALQ8cII2YG9NEgHA+uU=;
        b=kYEVsXlzdpYz363CTFlInDZSkXkkoQccWNCF9b8YSS+Wx0v578QJg1i5DlMXyMcQra
         1TQNdY9q5FOhdE7yx3gZhrNrzKWjXF5RWoX0B4Pe28LV2CnWHvB6b0MUczFONt1g/vq2
         rh7d1wx+pWmhZ1MiN8bMLXQXXcalI7UGGlhapk+0NdD1yTDIPqOzkbpusfEITzCDj8DP
         c49hCUBgxFRnR9TMqz96UGuBFwRTBRjVZale26fm6DpUtLVFZ/uK8SdMxE4m1i8OIfNb
         4P+3CW+cigCbsyGYRzzjQfhdUVTvu3hijqd2lnrw5Zy0uA9ErNP2G7dl7Z76p5FM3vIl
         xFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hy0lPZwhVShay78xNvd4HGWnALQ8cII2YG9NEgHA+uU=;
        b=6Ul4uWzz2+v+C0ybGyRD40da3K3fYkQR/POjaZEeOD+BBsGzxUyhKgO7aO8WLs67ZA
         COro9AQ0SQI4TWYl9aql1WEXRkSGmXJrGE41/ymrsDawRtiUiEpZmXEP4FrCjdm1XIXq
         mrbE5ijtNcVe+8J6N8IRhRx199ZN06aznE7gqWvpx/Za/pqs2ALno5BYtej/sSRvMvz8
         kUzWuVgCIc9Z3ee0EH9+lwEcLVrK4oVcPJITR8al9Ts/Vi9BRxX5hdZaauAHrJw+7wM1
         WprCgBQqzAVB2GGSdTI7LhLOKxozy+AgxBdrrUzhWgvFQb7DzeOeoVGK3juNxzU9na5G
         iz9g==
X-Gm-Message-State: AOAM532i0UW9KFejf709REuvaPT9QX9F7bd/l2VlBScNpXMbIDefBdMy
        KWFghy6KMLH0k/7OU/53dBk4bSebGH0=
X-Google-Smtp-Source: ABdhPJx4GshTl/6mw4OYI5ILNICTrXCBPDTV+b9j03//R3bUbqkImnFNPXF0ha8LRsb949J0si7FCA==
X-Received: by 2002:a7b:cc14:: with SMTP id f20mr17182916wmh.137.1632006925213;
        Sat, 18 Sep 2021 16:15:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6sm10656761wrq.47.2021.09.18.16.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 16:15:24 -0700 (PDT)
Message-Id: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Sep 2021 23:15:17 +0000
Subject: [PATCH 0/6] Fix various issues around removal of untracked files/directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fedor Biryukov <fedor.birjukov@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on en/am-abort-fix.

We have multiple codepaths that delete untracked files/directories but
shouldn't. There are also some codepaths where we delete untracked
files/directories intentionally (based on mailing list discussion), but
where that intent is not documented. Fix the documentation, add several new
(mostly failing) testcases, fix some of the new testcases, and add comments
about some potential remaining problems. (I found these as a side-effect of
looking at [1], though [2] pointed out one explicitly while I was working on
it.)

Note that I'm using Junio's declaration about checkout -f and reset --hard
(and also presuming that since read-tree --reset is porcelain that its
behavior should be left alone)[3] in this series.

SIDENOTE about treating (some) ignored files as precious:

There's another related topic here that came up in the mailing list threads
that is separate even if similar: namely, treating ignored files as precious
instead of deleting them. I do not try to handle that here, but I believe
that would actually be relatively easy to handle. If you leave
unpack_trees_options->dir as NULL, then ignored files are treated as
precious (my original patch 2 made that mistake). There's a few other
locations that already optionally set up unpack_trees_options->dir (a quick
search for "overwrite_ignore" and "overwrite-ignore" will find them), so
we'd just need to implement that option flag in more places corresponding to
the new callsites (and perhaps make a global core.overwrite_ignored config
option to affect all of these). Of course, doing so would globally treat
ignored files as precious rather than allowing them to be configured on a
per-path basis, but honestly I think the idea of configuring ignored files
as precious on a per-path basis sounds like insanity. (We have enough bugs
with untracked and ignored files without adding yet another type. Also,
tla/baz was excessively confusing to me due in part to the number of types
of files and I'd rather not see such ideas ported to git. And, of course,
configuring per-path rules sounds like lots of work for end users to
configure. There may be additional reasons against it.) So, if someone wants
to pursue the precious-ignored concept then I'd much rather see it done as a
global setting. Just my $0.02.

[1] https://lore.kernel.org/git/xmqqv93n7q1v.fsf@gitster.g/ [2]
https://lore.kernel.org/git/C357A648-8B13-45C3-9388-C0C7F7D40DAE@gmail.com/
[3] https://lore.kernel.org/git/xmqqr1e2ejs9.fsf@gitster.g/

Elijah Newren (6):
  t2500: add various tests for nuking untracked files
  Split unpack_trees 'reset' flag into two for untracked handling
  unpack-trees: avoid nuking untracked dir in way of unmerged file
  unpack-trees: avoid nuking untracked dir in way of locally deleted
    file
  Comment important codepaths regarding nuking untracked files/dirs
  Documentation: call out commands that nuke untracked files/directories

 Documentation/git-checkout.txt   |   5 +-
 Documentation/git-read-tree.txt  |   5 +-
 Documentation/git-reset.txt      |   3 +-
 builtin/am.c                     |   6 +-
 builtin/checkout.c               |  10 +-
 builtin/read-tree.c              |  11 +-
 builtin/reset.c                  |  15 +-
 builtin/stash.c                  |   3 +-
 builtin/submodule--helper.c      |   4 +
 builtin/worktree.c               |   5 +
 contrib/rerere-train.sh          |   2 +-
 reset.c                          |   9 +-
 submodule.c                      |   1 +
 t/t1013-read-tree-submodule.sh   |   4 +-
 t/t2500-untracked-overwriting.sh | 244 +++++++++++++++++++++++++++++++
 unpack-trees.c                   |  56 +++++--
 unpack-trees.h                   |   4 +-
 17 files changed, 359 insertions(+), 28 deletions(-)
 create mode 100755 t/t2500-untracked-overwriting.sh


base-commit: c5ead19ea282a288e01d86536349a4ae4a093e4b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1036%2Fnewren%2Funtracked_removal-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1036/newren/untracked_removal-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1036
-- 
gitgitgadget
