Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EC3C07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 21:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 183F5613E2
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 21:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhGCV3L (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 17:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhGCV3K (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 17:29:10 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9395CC061762
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 14:26:35 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k16-20020a05600c1c90b02901f4ed0fcfe7so7557085wms.5
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 14:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=skRTpB3D4vludQilDrFKxbcIJ9tYBo6nsYlaCwe2irg=;
        b=efQsvrXd0mM98CwYdDTiTyRDqs7b9qG2wI3Kvtu1SC149mLLa/bNFsA6IHT/zA7QX2
         fDu4EytuFWBwRpTNQmWhqpcqMhpRSq0WZr7c5dnyEXHYao4PY72ZW9vk73ptQTmvQNE7
         cjhNxwX5x2+AcAlS1sLsRbG3zOayIoipQiV4kAVuK/m59zfE+9xMX74edFI5D+Tc9tOk
         KLz4NEHg1Tjrxux647OLkA9/mOyYCpvBDX2SFrWZEjPAbZeO0N67d0Fu+wT80w6znL4H
         WXPcgNBF18U6VZ7yEpR6BAErIXA0avOdY1d+vzcbCGfdtsQtPekliXC/b4V+5tgObvZe
         vyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=skRTpB3D4vludQilDrFKxbcIJ9tYBo6nsYlaCwe2irg=;
        b=oV0bEpgcpiWYomD9H1AFfA+3WPkqBegFMNrnxUdIFbfLYRJk49a8WFmW7nExTKN7Ol
         c9IkVikLnosAQHf3kH4ktpcf4yzL5QAYXMeUNawgQmXEMiEZAYZOGkT8sB7LUyauEFYN
         zqmgjBp6MnVUM4AxAGr0HEf+eD7gpX3v+fUC+hvF6FvltBzcod5hpWF2kYexCORoFeYJ
         fWAX0CxG3IRQYgWP2cBP9JGau5axiYFw8JCOrpWRWD5huOjwAw56IaBK2MhVEs/iEqrD
         7MpxGiQpVPHXT4GSebMvvj47aCFMOp6d1hs7Ll5O9G3/pPfyas5eK0MnhzGImmjjRfqj
         uRUw==
X-Gm-Message-State: AOAM532CeGDFrPMx0p0pv99JVGhK+cRLPoJAN53unFg8oXba44MfWafJ
        t6l8DDuZhurg67j4otauMJyWkV/63C4=
X-Google-Smtp-Source: ABdhPJyu1VR17VrwQKcrp0a2DMhg0fhG8uLihuxInRWPW2vQLoIE3hJNj+VnOUUlv7/NcugfNdNB6Q==
X-Received: by 2002:a7b:c8d9:: with SMTP id f25mr6339209wml.153.1625347594238;
        Sat, 03 Jul 2021 14:26:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 16sm7090378wmk.18.2021.07.03.14.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 14:26:33 -0700 (PDT)
Message-Id: <pull.878.v2.git.1625347592.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.git.1624461857.gitgitgadget@gmail.com>
References: <pull.878.git.1624461857.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 03 Jul 2021 21:26:25 +0000
Subject: [PATCH v2 0/7] ci: speed-up the Windows parts of our GitHub workflow
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-878%2Fdscho%2Fuse-setup-git-for-windows-sdk-action-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-878/dscho/use-setup-git-for-windows-sdk-action-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/878

Range-diff vs v1:

 1:  8da66c425a1 = 1:  2e4db688deb ci: use the new GitHub Action to download git-sdk-64-minimal
 2:  a913af64f9d = 2:  6b12fe2284c ci (vs-build): use `cmd` to copy the DLLs, not `powershell`
 3:  7930465e809 = 3:  c256bbf4b1c ci: upgrade to using actions/{up,down}load-artifacts v2
 4:  1520a9ffb57 = 4:  59dc44428fb ci(windows): transfer also the Git-tracked files to the test jobs
 -:  ----------- > 5:  c31d2e7f44a artifacts-tar: respect NO_GETTEXT
 5:  a5084795ab0 = 6:  8bab4c17b8a ci(vs-build): build with NO_GETTEXT
 6:  e772d8f1d9b = 7:  88a44863cd0 ci: accelerate the checkout

-- 
gitgitgadget
