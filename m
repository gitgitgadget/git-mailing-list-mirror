Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3FBC07E95
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 22:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAB8D613E7
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 22:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhGDW5x (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 18:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhGDW5x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 18:57:53 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A2EC061574
        for <git@vger.kernel.org>; Sun,  4 Jul 2021 15:55:17 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id i8so6847731wrp.12
        for <git@vger.kernel.org>; Sun, 04 Jul 2021 15:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=0+l1XWngPw7jZOWeRg1gZhWf8iz+tWPN9q+0YF+HWIk=;
        b=eo1ha2yF+SMVdzvoPyKa21z9Og558p3hjAIkZt+XSrqNDp2HZRh05QrCo1WwnGIoxH
         32BE9ZRvPjfJRCTjPwqBIKbXZXsj4IhMYq0CzUAGnPpOkK065xuVQrd1ZI1tPQ0sGtO6
         xQ02U6e0LDi/ghI23KtW0TIvF8NQCZroCDp/CjlpGbsjGnD2xBUBGQtoylhlQjCIrzfK
         iTySAPWlIVFc975dczcBcsftk+Sn4Op75wfuovZKhO6GQcuq44k4CjbD03LCEzmpuNnX
         ZCLCQoFhHYFjJa/W79pj3Z3oRDkvewXXa0DYOFADQN+i1bMLPxSZ+cCsXIDaBoDcw+GC
         dFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=0+l1XWngPw7jZOWeRg1gZhWf8iz+tWPN9q+0YF+HWIk=;
        b=KYSfbuhDVkdLuDwFArE7vnEzwyvzFCnZEZEt4DrA9P1uDY6gPAR7EXbAm2aZwoanOB
         jukQ1dgSuaFMUUOLkiZPsFCvUeHgxZReI4ZGWZblLqy1nT3Co48TePHcY27ZBmoclFog
         x1Gig/dXKrsAXmZSZXxCND92gOtibwwF3jZTV3VV/D4p+CAFqdtlFF8tR+4XjDZVo6lR
         ditF04XDtL1QS38p4PAjNjdjtYnpf7i/ZcrmAeRLHjID6DWdHLH55diYR4bV8Llb9MiX
         /5SMvausdOqOqIxZcwmT8CPx2hkVJp4qpeJC/4baaxexLS/l+ANzk3szGVKyP5U9QQLf
         uWEQ==
X-Gm-Message-State: AOAM530paPqeG/Z6LuIogmjoX2QypdUnAopxC4LwTum2MIBXuHbgOFae
        WmmglQ/Jlj+gU/H5GobFEcHelGyPYrg=
X-Google-Smtp-Source: ABdhPJw579csaOisNiFXZgV1Y3BidEPDxgjQizJBFt+HZmYdttbBiePau0ghuZ4v7oa7SxFOFpYMjw==
X-Received: by 2002:adf:9d8a:: with SMTP id p10mr11825401wre.127.1625439315790;
        Sun, 04 Jul 2021 15:55:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b9sm13166209wrh.81.2021.07.04.15.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 15:55:15 -0700 (PDT)
Message-Id: <pull.878.v3.git.1625439315.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.v2.git.1625347592.gitgitgadget@gmail.com>
References: <pull.878.v2.git.1625347592.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 04 Jul 2021 22:55:07 +0000
Subject: [PATCH v3 0/7] ci: speed-up the Windows parts of our GitHub workflow
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series upgrades to newer versions of a couple GitHub Actions we
use, and also streamlines the Windows jobs using the relatively new
setup-git-for-windows-sdk Action
[https://github.com/marketplace/actions/setup-git-for-windows-sdk] (Git for
Windows is running with this Action for a while now, getting all the kinks
out).

This patch series should also address the problem where seen was pushed so
rapidly that the windows-test jobs failed because they no longer checked out
the identical revision as the windows-build job.

Changes since v2:

 * Made the handwaving make [...] NO_GETTEXT comment in the commit message
   of the patch "artifacts-tar: respect NO_GETTEXT" more explicit, by
   setting NO_GETTEXT to a bogus value as required by make.
 * Added an explicit NO_GETTEXT=YesPlease to the make artifacts-tar
   invocation in the vs-build job, as well as an explanation in the
   corresponding commit message why this explicit mention is technically not
   required.

Changes since v1:

 * Added a patch to fix make NO_GETTEXT=Yep artifacts-tar (not to include
   .mo files), as suggested by Matthias Aßauer in the GitGitGadget PR, which
   should fix the CI failure in seen that Junio pointed out. The bug was
   unhidden by mr/cmake fixing the CMake build (which ignored NO_GETTEXT
   before).

Dennis Ameling (1):
  ci(vs-build): build with NO_GETTEXT

Johannes Schindelin (6):
  ci: use the new GitHub Action to download git-sdk-64-minimal
  ci (vs-build): use `cmd` to copy the DLLs, not `powershell`
  ci: upgrade to using actions/{up,down}load-artifacts v2
  ci(windows): transfer also the Git-tracked files to the test jobs
  artifacts-tar: respect NO_GETTEXT
  ci: accelerate the checkout

 .github/workflows/main.yml | 157 +++++++++++--------------------------
 Makefile                   |   5 +-
 2 files changed, 50 insertions(+), 112 deletions(-)


base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-878%2Fdscho%2Fuse-setup-git-for-windows-sdk-action-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-878/dscho/use-setup-git-for-windows-sdk-action-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/878

Range-diff vs v2:

 1:  2e4db688deb = 1:  2e4db688deb ci: use the new GitHub Action to download git-sdk-64-minimal
 2:  6b12fe2284c = 2:  6b12fe2284c ci (vs-build): use `cmd` to copy the DLLs, not `powershell`
 3:  c256bbf4b1c = 3:  c256bbf4b1c ci: upgrade to using actions/{up,down}load-artifacts v2
 4:  59dc44428fb = 4:  59dc44428fb ci(windows): transfer also the Git-tracked files to the test jobs
 5:  c31d2e7f44a ! 5:  64f7b1f4e23 artifacts-tar: respect NO_GETTEXT
     @@ Commit message
          artifacts-tar: respect NO_GETTEXT
      
          We obviously do not want to bundle `.mo` files during `make
     -    artifacts-tar NO_GETTEXT`, but that was the case.
     +    artifacts-tar NO_GETTEXT=Yep`, but that was the case.
      
          To fix that, go a step beyond just fixing the symptom, and simply
          define the lists of `.po` and `.mo` files as empty if `NO_GETTEXT` is
 6:  8bab4c17b8a ! 6:  2c4cd9dd1c8 ci(vs-build): build with NO_GETTEXT
     @@ Commit message
          We already build Git for Windows with `NO_GETTEXT` when compiling with
          GCC. Let's do the same with Visual C, too.
      
     +    Note that we do not technically _need_ to pass `NO_GETTEXT` explicitly
     +    in that `make artifacts-tar` invocation because we do this while `MSVC`
     +    is set (which will set `uname_S := Windows`, which in turn will set
     +    `NO_GETTEXT = YesPlease`). But it is definitely nicer to be explicit
     +    here.
     +
          Signed-off-by: Dennis Ameling <dennis@dennisameling.com>
     +    Helped-by: Matthias Aßhauer <mha1993@live.de>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## .github/workflows/main.yml ##
     @@ .github/workflows/main.yml: jobs:
           - name: MSBuild
             run: msbuild git.sln -property:Configuration=Release -property:Platform=x64 -maxCpuCount:4 -property:PlatformToolset=v142
           - name: bundle artifact tar
     +@@ .github/workflows/main.yml: jobs:
     +         VCPKG_ROOT: ${{github.workspace}}\compat\vcbuild\vcpkg
     +       run: |
     +         mkdir -p artifacts &&
     +-        eval "$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=YesPlease ARTIFACTS_DIRECTORY=artifacts 2>&1 | grep ^tar)"
     ++        eval "$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=YesPlease ARTIFACTS_DIRECTORY=artifacts NO_GETTEXT=YesPlease 2>&1 | grep ^tar)"
     +     - name: zip up tracked files
     +       run: git archive -o artifacts/tracked.tar.gz HEAD
     +     - name: upload tracked files and build artifacts
 7:  88a44863cd0 = 7:  db54bf9a779 ci: accelerate the checkout

-- 
gitgitgadget
