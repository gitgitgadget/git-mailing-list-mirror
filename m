Return-Path: <SRS0=wQ61=DL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1234C41604
	for <git@archiver.kernel.org>; Sun,  4 Oct 2020 01:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90E8220679
	for <git@archiver.kernel.org>; Sun,  4 Oct 2020 01:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHTQ7VTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgJDBRl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Oct 2020 21:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgJDBRk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Oct 2020 21:17:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18F1C0613D0
        for <git@vger.kernel.org>; Sat,  3 Oct 2020 18:17:40 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d4so5106239wmd.5
        for <git@vger.kernel.org>; Sat, 03 Oct 2020 18:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ih0gHlD2IdhZYTWEOoLORHyTPBWjd5PCAUMVhj/cH/Y=;
        b=cHTQ7VTUvRVOp3Q+IKByKJykS9kSSCSzFSZOug+toA06kJMMzZxApVEtWOf6Oe7d6l
         Cj/3g3erbasooIDtx+4hsMBxBvyH1H4Rf0V+bUt/89xyVTdHZyilSeOxysJHdDd5W29P
         LZBp46FOQZHXuaQlBUZ7Z/dghY7O4W1HKT5JC21FVTEjsLTm9BxdD/19sVH3aOTp6+Vf
         b/vBlCvsktafFvsglRlxV6sZVYd8jfhIRjcf2l9hENpfDEnFIqUhoutHCVZib7c1K/Wn
         +xgvClWbJdL0zy/fasP7KKzRHY/RQor+61u9KIUx5CzU97sDLhL2omc/ktzSmxyMogyM
         sTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ih0gHlD2IdhZYTWEOoLORHyTPBWjd5PCAUMVhj/cH/Y=;
        b=gntYN7ahW90Zb/WC4KevsYhwIGfQ9d7P5iB1uRNM3p6vIVyhD3opMbeSbfeI0abDqX
         5PahzRJBjYnBymKR6C3cF0vgM2CTfJYjiY8GcpQv25KNXW7hpECAcp3W9g6+zY4gYPx6
         1P0U9cdRoFsY8hOtlzDVhDovoH743/VDd4YMZas9tKvGgS8DUBGcQn+ENxuWEBEXphjy
         W0lNN7rJ4WQobTWt5Wqw+qHw2WD8ord2h5XyoVUDYX/+uLX/V9MuZ0yxiW4QrAztAr+1
         UDJ2vkte+Mj+ecUbkKDOowKeXMBH4a4XyUJ5BRZvfkb7d4WLhDRdKqXDgp/d+CpBfMNJ
         QJYg==
X-Gm-Message-State: AOAM530PDNPqB7B5kP14qiyy/SX+dv2ne31oCg5YuAIH3+NYneAG9F/z
        O9nO44qXsLWBsJs5xqX1lyD3BRkTRgk=
X-Google-Smtp-Source: ABdhPJyrZyzeZjcstTicPUOoOGcFrC0MaOmzkycrQFBiacr+zWvceAuEjZ0SjN7f962BKN77xkYkaA==
X-Received: by 2002:a7b:cb8c:: with SMTP id m12mr10167855wmi.12.1601774259029;
        Sat, 03 Oct 2020 18:17:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g14sm6987715wrv.25.2020.10.03.18.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 18:17:38 -0700 (PDT)
Message-Id: <pull.861.git.git.1601774257696.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 04 Oct 2020 01:17:37 +0000
Subject: [PATCH] gitsubmodules: add '--recurse-submodules' for 'ls-files'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

`git ls-files` was never taught to respect the `submodule.recurse`
configuration variable, and it seems it is too late now to change that
[1], but still the command is mentioned in 'gitsubmodules(7)' as if it
does respect that config.

Adjust the call in 'gitsubmodules(7)' by adding the
'--recurse-submodules' flag.

While at it, uniformize the capitalization in that file, and use
backticks instead of quotes for Git commands and configuration
variables.

[1] https://lore.kernel.org/git/pull.732.git.1599707259907.gitgitgadget@gmail.com/T/#u

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    gitsubmodules: add '--recurse-submodules' for 'ls-files'

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-861%2Fphil-blain%2Fgitsubmodules-ls-files-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-861/phil-blain/gitsubmodules-ls-files-v1
Pull-Request: https://github.com/git/git/pull/861

 Documentation/gitsubmodules.txt | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
index f9f4e65c9e..891c8da4fd 100644
--- a/Documentation/gitsubmodules.txt
+++ b/Documentation/gitsubmodules.txt
@@ -225,10 +225,10 @@ presence of the .url field.
 Workflow for a third party library
 ----------------------------------
 
-  # add a submodule
+  # Add a submodule
   git submodule add <url> <path>
 
-  # occasionally update the submodule to a new version:
+  # Occasionally update the submodule to a new version:
   git -C <path> checkout <new version>
   git add <path>
   git commit -m "update submodule to new version"
@@ -246,20 +246,23 @@ Workflow for an artificially split repo
   # regular commands recurse into submodules by default
   git config --global submodule.recurse true
 
-  # Unlike the other commands below clone still needs
+  # Unlike most other commands below, clone still needs
   # its own recurse flag:
   git clone --recurse <URL> <directory>
   cd <directory>
 
   # Get to know the code:
   git grep foo
-  git ls-files
+  git ls-files --recurse-submodules
+
+[NOTE]
+`git ls-files` also requires its own `--recurse-submodules` flag.
 
   # Get new code
   git fetch
   git pull --rebase
 
-  # change worktree
+  # Change worktree
   git checkout
   git reset
 
@@ -267,12 +270,12 @@ Implementation details
 ----------------------
 
 When cloning or pulling a repository containing submodules the submodules
-will not be checked out by default; You can instruct 'clone' to recurse
-into submodules. The 'init' and 'update' subcommands of 'git submodule'
+will not be checked out by default; you can instruct `clone` to recurse
+into submodules. The `init` and `update` subcommands of `git submodule`
 will maintain submodules checked out and at an appropriate revision in
-your working tree. Alternatively you can set 'submodule.recurse' to have
-'checkout' recursing into submodules (note that 'submodule.recurse' also
-affects other git commands, see linkgit:git-config[1] for a complete list).
+your working tree. Alternatively you can set `submodule.recurse` to have
+`checkout` recursing into submodules (note that `submodule.recurse` also
+affects other Git commands, see linkgit:git-config[1] for a complete list).
 
 
 SEE ALSO

base-commit: 306ee63a703ad67c54ba1209dc11dd9ea500dc1f
-- 
gitgitgadget
