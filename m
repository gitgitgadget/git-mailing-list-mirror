Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E43C3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 15:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC69721973
	for <git@archiver.kernel.org>; Sat,  2 May 2020 15:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eR+Oi9Zw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgEBPIL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 11:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgEBPIL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 May 2020 11:08:11 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7E3C061A0C
        for <git@vger.kernel.org>; Sat,  2 May 2020 08:08:11 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id d17so15359155wrg.11
        for <git@vger.kernel.org>; Sat, 02 May 2020 08:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=vnqyBq14DiKGVexZ1WzGoMNOYiZ3OAiXfde0eTJt9W0=;
        b=eR+Oi9Zw+LZYqAeU8yvJ9iGR/zU6vqZtE1uZviO513Mqfz0O/8I1RN3pCRjX9HjKZu
         hbBiQTJYtzyym81+SbX8VXUczg8kod2VxdkTR7kpLxBjIz8Ui6xfs44kkYJVvJuOn5MM
         IftmzVKkDfRVu0HEPVEUUhcnIQ3cL7pmha9DPXGz7YEOc6D9iltBnhA+1pg2ZM6VVSMN
         +7qK/DZ416iQ6/iwtaOyIu+SkubYpm5fWpJkFF3zI7IB/4+pEUbMqWOP9KKqkQFFep4B
         xrIY9VrRcKOVr0aEaNro5twdBC3WWMSwEYCnrgl/zahFjclqgvAQH8bfanZlRwOKlf0u
         NCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vnqyBq14DiKGVexZ1WzGoMNOYiZ3OAiXfde0eTJt9W0=;
        b=uCRAPTnP2lpps7A6QbzLuHx2fveD4c3N154X9ZD3F8UBATsrWjmoPP1yp/cORj9sJp
         yPc4IZBPIrZnqYKsjcNLHf4z4MIUsDrS+MXqueRzDKzDQ9aru6RoGat4JShTUstidB9x
         Cl0vSwcE3+Pv+bIf51rSejjjfJa+PpYkowadL2NEj/E7k5IwaVF+3ITdtJnlVAO+yPKv
         zJFM1CcnvMAUbRDp98tEMzX7BD3OiknOK0ptiwQrt9dUj5vc/Ubv7ncmCxjN/NMhIfpc
         S/nkDXqkXQkBObYd/HcA/Kxfp+p/e9TbVh36odhnMJz4YW/gxnqW+h/S9vPSCF/eePSm
         7VMA==
X-Gm-Message-State: AGi0PuarEvdM+RVZqFHUX+q1GVmeXmfOCv/Gom++NOx3vdoJg/Wuwh6s
        FeoDtQDCcd8Y1SiEBelOC5gTmsX2
X-Google-Smtp-Source: APiQypKUMaEGhFH6FvRs+FvAhi2QEWamQTK+F+YXIswgIW5Z0aJurs04+51Jgn/UAw/eIKyXCwobZw==
X-Received: by 2002:adf:edc6:: with SMTP id v6mr9494018wro.8.1588432089008;
        Sat, 02 May 2020 08:08:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm4422962wmm.38.2020.05.02.08.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 08:08:08 -0700 (PDT)
Message-Id: <pull.776.git.git.1588432087854.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 02 May 2020 15:08:07 +0000
Subject: [PATCH] ci: respect the [skip ci] convention in our GitHub workflow
 "CI/PR"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It might have been invented by Travis CI (at least it is described here:
https://docs.travis-ci.com/user/customizing-the-build/#skipping-a-build)
to avoid unnecessary builds: if the tip commit message (or for PR
builds, the PR description) contains the needle `[skip ci]`, then the
build is skipped.

Unlike Azure Pipelines, GitHub workflows does not support that feature
out of the box (at least not at the time of writing), but we can
reinstate it manually.

Note: GitHub workflows might implement this at some stage. In the least,
the desire for this feature is expressed, together with some history, at
https://github.community/t5/GitHub-Actions/GitHub-Actions-does-not-respect-skip-ci/m-p/42834

While it is the number five in the kudo ranking of the GitHub Actions
posts, it might take a while given the current state of the world. In
the meantime let's do the manual thing.

Following Travis CI's example, we also add special handling to exclude
the PR build when the PR title or description (or any other part of the
pull request information provided by the GitHub event) contains the
needle `[skip pr]`.

Note: for technical reasons, a PR build will still run if a commit
message contains the needle `[skip ci]` but neither PR title nor
description contain the needle `[skip pr]`: for PR builds, the commit
messages are not part of the payload delivered via the event.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    ci: allow skipping CI/PR builds on GitHub
    
    It was mentioned to me that it might not be totally helpful to run all 
    the builds whenever an in-progress branch is pushed to GitHub. For
    example, if a contributor has dozens of topic branches in flight, they
    might not want to have all of them built whenever a new end-of-day push
    happens.
    
    This patch tries to address that, by following the convention that I
    believe Travis CI invented: if a commit message contains the needle 
    [skip ci], any CI build (i.e. a build triggered by a push) is skipped.
    Likewise, PR builds are skipped when the PR title and/or description
    contains [skip pr].
    
    Ideally, GitHub workflows will support this feature at some stage, but
    until then, we could have this (admittedly not very elegant) workaround.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-776%2Fdscho%2Fskip-ci-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-776/dscho/skip-ci-v1
Pull-Request: https://github.com/git/git/pull/776

 .github/workflows/main.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index fd4df939b50..0e4a280d309 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -7,6 +7,7 @@ env:
 
 jobs:
   windows-build:
+    if: "!contains(toJSON(github.event.commits.*.message), '[skip ci]') && !contains(toJSON(github.event.pull_request), '[skip pr]')"
     runs-on: windows-latest
     steps:
     - uses: actions/checkout@v1
@@ -70,6 +71,7 @@ jobs:
         name: failed-tests-windows
         path: ${{env.FAILED_TEST_ARTIFACTS}}
   vs-build:
+    if: "!contains(toJSON(github.event.commits.*.message), '[skip ci]') && !contains(toJSON(github.event.pull_request), '[skip pr]')"
     env:
       MSYSTEM: MINGW64
       NO_PERL: 1
@@ -154,6 +156,7 @@ jobs:
                           ${{matrix.nr}} 10 t[0-9]*.sh)
         "@
   regular:
+    if: "!contains(toJSON(github.event.commits.*.message), '[skip ci]') && !contains(toJSON(github.event.pull_request), '[skip pr]')"
     strategy:
       matrix:
         vector:
@@ -189,6 +192,7 @@ jobs:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
   dockerized:
+    if: "!contains(toJSON(github.event.commits.*.message), '[skip ci]') && !contains(toJSON(github.event.pull_request), '[skip pr]')"
     strategy:
       matrix:
         vector:
@@ -213,6 +217,7 @@ jobs:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
   static-analysis:
+    if: "!contains(toJSON(github.event.commits.*.message), '[skip ci]') && !contains(toJSON(github.event.pull_request), '[skip pr]')"
     env:
       jobname: StaticAnalysis
     runs-on: ubuntu-latest
@@ -221,6 +226,7 @@ jobs:
     - run: ci/install-dependencies.sh
     - run: ci/run-static-analysis.sh
   documentation:
+    if: "!contains(toJSON(github.event.commits.*.message), '[skip ci]') && !contains(toJSON(github.event.pull_request), '[skip pr]')"
     env:
       jobname: Documentation
     runs-on: ubuntu-latest

base-commit: b34789c0b0d3b137f0bb516b417bd8d75e0cb306
-- 
gitgitgadget
