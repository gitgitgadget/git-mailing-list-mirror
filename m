Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655EEC433B4
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 01:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F4FD6117A
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 01:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbhDCBee (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 21:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235924AbhDCBe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 21:34:29 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF1CC0613E6
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 18:34:25 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso3259266pjb.4
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 18:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R3/k2ydrpYzswL5VuqvsxddLTE33oL2m+3D/xvRyTPg=;
        b=LZA9ChNjFANF8YmgdNliCLMgJc5q9NMpDbzL+KUm+lJAkoJ1QfXPBc/GyhDP20cMI0
         z/dg89zGF7aEffFi3+Mmd/iPH1XexOQxbA8SnBOV4ZVzZsdph0FYComk/6WaFETNJN7N
         4Wci6Og7jVMcBvPgMnEqtbNfUB4OCMFiBBR1Q3D4NWDAASDFjojsMtL1qBBknWY63F/o
         FMsCS6JZ+ZGHEu2qxCjLJFi1y8yrPEsOHHkpEtwMi2XzPvr8pxphQ1iiI63eOVQCPuPY
         QKXQzRc0qOoXK7cfgPq268ZZ7v3CCWkBp86Ai9eNSNtcxPC8G/h+uE8Ca95ibwphAymw
         In5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R3/k2ydrpYzswL5VuqvsxddLTE33oL2m+3D/xvRyTPg=;
        b=PGyOOlpDrLVR536st5lGuzfaYQGTPODofDPbC4TFZovb0vPnIqyLm5jNP7JFFTlb39
         vdVsfKc7SiBGBs/CqS+S0IOxpVShZh1nnXELCnKJpnVHqdRtdM4m8+UcVrIW6E2o6bgJ
         1Jwg91W9kUN81IxlX0kBIftwGvSzLlGEoGcAyAZv48rrQcc13w8U8XnKJvJrmVepAmh4
         1/SYi/UsaMriA9Gw0SHAxMXyqT+jgGZ2ml90eACeQrN+eHGiU9n8Hpy3tkvMmwPCu1KC
         fiwSqqXrAUUmPLWBgbAH07H7ghHG7r7g2p1gB2PpV2DFfotDngpkjRIuObwwD0BsJy5C
         iy8Q==
X-Gm-Message-State: AOAM531WIvpKvTUTvEcwSWWQnH9nZw9SQAcdLWCcxS6Cov1+yOq27Kdi
        DiuhKxY8eEpiGFp6aP4T8GdVMRKLpZo1XmAg2kA=
X-Google-Smtp-Source: ABdhPJyCJFvIbZ7euuVka4lW0inr7+NduLeQtoWG1NOIa37yyqWKDfbMULEjohbMyX2fg3qrWu0DNw==
X-Received: by 2002:a17:902:8347:b029:e7:4a2d:6589 with SMTP id z7-20020a1709028347b02900e74a2d6589mr15409475pln.64.1617413664991;
        Fri, 02 Apr 2021 18:34:24 -0700 (PDT)
Received: from jerry-desktop.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id ot17sm8937518pjb.50.2021.04.02.18.34.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Apr 2021 18:34:24 -0700 (PDT)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org
Cc:     ross@skydio.com, abe@skydio.com, brian.kubisiask@skydio.com,
        Jerry Zhang <jerry@skydio.com>
Subject: [PATCH 0/1] git-apply: Allow simultaneous --cached and --3way options
Date:   Fri,  2 Apr 2021 18:34:09 -0700
Message-Id: <20210403013410.32064-1-jerry@skydio.com>
X-Mailer: git-send-email 2.31.1.164.g5aa78b22ae
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm creating a script/tool that will be able to cherry-pick 
multiple commits from a single branch, rebase them onto a
base commit, and push those references to a remote. 

Ex. with a branch like "origin/master -> A -> B -> C"
The tool will create "master -> A", "master -> B",
"master -> C" and either make local branches or
push them to a remote. This can be useful since code
review tools like github use branches as the basis
for pull requests.

A key feature here is that the above happens without
any changes to the user's working directory or cache.
This is important since those operations will add
time and generate build churn. We use these steps
for synthesizing a "cherry-pick" of B to master.

1. cp .git/index index.temp
2. set GIT_INDEX_FILE=index.temp
3. git reset master -- . (git read-tree also works here, but is a bit slower)
4. git format-patch --full-index B~..B
5. git apply --cached B.patch
6. git write-tree
7. git commit-tree {output of 6} -p master -m "message"
8. either `git symbolic-ref` to make a branch or `git push` to remote

I'm looking to improve the git apply step in #5. 
Currently we can't use --cached in combination with
--3way, which limits some of the usefulness of this method.
There are many diffs that will block applying a patch
that a 3 way merge can resolve without conflicts. Even
in the case where there are real conflicts, performing
a 3 way merge will allow us to show the user the lines
where the conflict occurred. 

With the above in mind, I've created a small patch that
implements the behavior I'd like. Rather than disallow
the cached and 3way flags to be combined, we allow them,
but write any conflicts directly to the cached file. Since 
we're unable to modify the working directory, it seems
reasonable in this case to not actually present the user
with any options to resolve conflicts. Instead, a script
or tool using this command can diff the temporary cache
to get the source of the conflict.

Happy to address any feedback. After I address any major
changes I will add new tests for this path.

All tests passed locally.

Jerry Zhang (1):
  git-apply: Allow simultaneous --cached and --3way options

 Documentation/git-apply.txt |  4 +++-
 apply.c                     | 13 +++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

-- 
2.29.0

