Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA2CC77B7A
	for <git@archiver.kernel.org>; Fri, 26 May 2023 18:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243187AbjEZSoM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 May 2023 14:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242986AbjEZSoI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2023 14:44:08 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2207C10CB
        for <git@vger.kernel.org>; Fri, 26 May 2023 11:43:41 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f601c57d8dso8968245e9.0
        for <git@vger.kernel.org>; Fri, 26 May 2023 11:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685126619; x=1687718619;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4r7E2s9fhTFJNZ8wJvm/4lJz7b04xB0Z+0++soQVcKE=;
        b=r/fJdR0dxbGyAMrA4DJL3ne/vo+18ioxqfTjHxlWeerRWEvY6IWcwPPs/bv45zDHD9
         JveRBDKaE/zW9EZ2PQ+Vhl2y2D93rTm4iv9ugkDSGFxWd61AFCrEFA+ISL7ZZ+psUHs2
         JgihkA7kcHUE7KJQlhyOt7CVgWkfVj/g/DCYBb7wUyMi/XAIOZAh0szR6xJKUa5Q2l+8
         FXM0TsL58kR3Mq9wVTQmu2b/TNDy5FCQmI9sFflcrYjx8BRr0/MxSZTKtVJ/zlgJFD80
         VJ4sL6GpvRUbfTT+lbLABtvGWQWaGpMF1D528dsRTXlwn+8qTaMprJg/jJbudmEwXtJO
         DHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126619; x=1687718619;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4r7E2s9fhTFJNZ8wJvm/4lJz7b04xB0Z+0++soQVcKE=;
        b=B0Wr0Pi82XJzXmfZYWNdRWN4EfVPeBQxfZfGpUM5o6CLEQj1lIMab+APdovJKl4B9U
         iBn7m3hiQ6rljuEEVD8ftM5AFw3xOFCj93sECcO2mbdLUWa3f6JL7neiDFD2SZFKx19D
         I3CeA/2XCPN5sHtJiyW0gkUTWJkhnKhFITFJAXic9g3DNXl/b/HVD2N5Afo98JtwlsSo
         rSA3gRYq0EtPx3JqSdOXeLs8LhbS/ftAy/Z7ZAR2lLENz/kl9/NcbVSfy2KXvfUw5f7k
         CG8eGBXx1t8ilUiee0ADfi58Z9fcF8LrTAi0Ta+qnMpvRX/UvKGrJFkeOnqPm33lxUqs
         nHMg==
X-Gm-Message-State: AC+VfDyJNfTbaaJVny2hMhNPjG+rjCBQLtO5jPVN/+VxGzs5YldbJh9Y
        B4LUft64rSn37/1JSi6gxsVIywAayo4=
X-Google-Smtp-Source: ACHHUZ67UsHds0DCjX7sG+RE5phrIWK0RwrgF/3+ovAwOk4hAlSlfEdj593EiQKEu0I4sYMrpYRK5A==
X-Received: by 2002:a7b:c054:0:b0:3f4:2610:5cc5 with SMTP id u20-20020a7bc054000000b003f426105cc5mr2153867wmc.5.1685126619110;
        Fri, 26 May 2023 11:43:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y8-20020a7bcd88000000b003f6038faa19sm9415596wmj.19.2023.05.26.11.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 11:43:38 -0700 (PDT)
Message-Id: <pull.1537.git.1685126617.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 May 2023 18:43:34 +0000
Subject: [PATCH 0/3] Create stronger guard rails on replace refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     vdye@github.com, me@ttaylorr.com, newren@gmail.com,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(This series is based on tb/pack-bitmap-traversal-with-boundary due to
wanting to modify prepare_repo_settings() in a similar way.)

The replace-refs can be ignored via the core.useReplaceRefs=false config
setting. This setting is possible to miss in some Git commands if they do
not load default config at the appropriate time. See [1] for a recent
example of this.

[1]
https://lore.kernel.org/git/pull.1530.git.1683745654800.gitgitgadget@gmail.com/

This series aims to avoid this kind of error from happening in the future.
The idea is to encapsulate the setting in such a way that we can guarantee
that config has been checked before using the in-memory value.

Further, we must be careful that some Git commands want to disable replace
refs unconditionally, as if GIT_NO_REPLACE_REFS was enabled in the
environment.

The approach taken here is to split the global into two different sources.
First, read_replace_refs is kept (but moved to replace-objects.c scope) and
reflects whether or not the feature is permitted by the environment and the
current command. Second, a new value is added to repo-settings and this is
checked after using prepare_repo_settings() to guarantee the config has been
read.

This presents a potential behavior change, in that now core.useReplaceRefs
is specific to each in-memory repository instead of applying the
superproject value to all submodules. I could not find a Git command that
has multiple in-memory repositories and follows OIDs to object contents, so
I'm not sure how to demonstrate it in a test.

Here is the breakdown of the series:

 * Patch 1 creates disable_replace_refs() to encapsulate the global
   disabling of the feature.
 * Patch 2 creates replace_refs_enabled() to check if the feature is enabled
   (with respect to a given repository). This is a thin wrapper of the
   global at this point, but does allow us to remove it from environment.h.
 * Patch 3 creates the value in repo-settings as well as ensures that the
   repo settings have been prepared before accessing the value within
   replace_refs_enabled().

Thanks, -Stolee

Derrick Stolee (3):
  repository: create disable_replace_refs()
  replace-objects: create wrapper around setting
  repository: create read_replace_refs setting

 builtin/cat-file.c       |  2 +-
 builtin/commit-graph.c   |  5 ++---
 builtin/fsck.c           |  2 +-
 builtin/index-pack.c     |  2 +-
 builtin/pack-objects.c   |  3 +--
 builtin/prune.c          |  3 ++-
 builtin/replace.c        |  3 ++-
 builtin/unpack-objects.c |  3 +--
 builtin/upload-pack.c    |  3 ++-
 commit-graph.c           |  4 +---
 config.c                 |  5 -----
 environment.c            |  3 +--
 git.c                    |  2 +-
 log-tree.c               |  2 +-
 replace-object.c         | 23 ++++++++++++++++++++++-
 replace-object.h         | 31 ++++++++++++++++++++++---------
 repo-settings.c          |  2 ++
 repository.h             |  8 ++++++++
 18 files changed, 71 insertions(+), 35 deletions(-)


base-commit: b0afdce5dab61f224fd66c13768facc36a7f8705
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1537%2Fderrickstolee%2Freplace-refs-safety-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1537/derrickstolee/replace-refs-safety-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1537
-- 
gitgitgadget
