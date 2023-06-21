Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F8EEB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 19:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjFUTfT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 15:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjFUTfR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 15:35:17 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E271726
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 12:35:16 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3113675d582so3893604f8f.3
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 12:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687376114; x=1689968114;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kST0TmfetJovOYyGX28tcAdfbUF/8LAAtn1fLAqCrcs=;
        b=a61rdAtPYbyMFxqAncfNo+sC90aZgYWoFZioZB8r46aA0fR4ZDpy+3fbjXiAl5lV68
         pWrWnoOd/1MlZLCeGuK4XNmdUX8tMMe3KvdbFIXs1hXa0mtthLOuE4foBV2ZpUQ2wTft
         X8AH9fLOFcBJtY769VcPh27iF8P2Um3z8Teti+OOeGCZORP4mg8HPFBUegGS+OH/hteW
         PDmoEJ6MjAfRjQt9XlmJd8DSDgXHnNKOtx7BKpIE9IYF6yJ78+I3FwPkfmUGNGRQiYLx
         fYUEiAYmbBUrHiwfG7sbx8erTfevp90/DW1fH+iRbvOkug0IsPWn2jrN5xolDYLcN1w6
         HQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687376114; x=1689968114;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kST0TmfetJovOYyGX28tcAdfbUF/8LAAtn1fLAqCrcs=;
        b=NWgbyx7EOdOrL3y0b4ogrpiaEtPswKB3btWkE+87ln2WqCCT2plX9ti18Qo6lbSHYO
         +RAbIpQB8KSGRnd9BzlDYh/Rbb4vemxgg3UBjwhSz1yB1NwPSrAh9ZSpEbu8eX4y66YM
         /fdGfgMK8e+nXWA3xygQZ4cq1CUprBD6BVQiIkZRdeP6yIfO4wyGD0M5g5eBBrpbEme+
         QgUUOxBwXLDhUP5fplTudgiwEnBQAebykfQE6SJKSq/5wetOOrHFnYgeQP/wv0P8yaZg
         Q6Q09F2aT8MTdMc5KjIMfq0EdY7Cuy5xD4W+q/WmDNnJrprHnP8xIYzYqAO7iZS7Y7cp
         JEQg==
X-Gm-Message-State: AC+VfDzzEGK4y7Y/WVBXvNNdOaQiU3zoowJxpVMkPdvAMxBYvQWnnkZl
        rROGm9Vgdstr3uRU2v3mFC1JnkQOVqk=
X-Google-Smtp-Source: ACHHUZ7feN67+jl7vStjlUvrGzgyYXc8liXCkTZnAqeoPnwBh7dbsoU2hNrPonUv5jE0pmNVPJfDGg==
X-Received: by 2002:a5d:6a4b:0:b0:30f:c805:5f07 with SMTP id t11-20020a5d6a4b000000b0030fc8055f07mr11745955wrw.17.1687376114109;
        Wed, 21 Jun 2023 12:35:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k10-20020adff5ca000000b0030ae87bd3e3sm5225355wrp.18.2023.06.21.12.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:35:13 -0700 (PDT)
Message-Id: <pull.1515.git.git.1687376112.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Jun 2023 19:35:09 +0000
Subject: [PATCH 0/3] revision: refactor ref_excludes to ref_visibility
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ref_excludes API is used to tell which refs should be excluded. However,
there are times when we would want to add refs to explicitly include as
well. 4fe42f326e (pack-refs: teach pack-refs --include option, 2023-05-12)
taught pack-refs how to include certain refs, but did it in a more manual
way by keeping the ref patterns in a separate string list. Instead, we can
easily extend the ref_excludes API to include refs as well, since this use
case fits into the API nicely.

Refactor the API by renaming it to ref_visibility, and add a ref_visible()
helper that takes into account ref inclusion.

John Cai (3):
  revision: rename ref_excludes to ref_visibility
  revision: add ref_visible() helper
  pack-refs: use new ref_visible() helper

 builtin/pack-refs.c       | 20 ++++----
 builtin/rev-parse.c       | 18 +++----
 refs.h                    |  2 +-
 refs/files-backend.c      | 11 +----
 revision.c                | 98 +++++++++++++++++++++++----------------
 revision.h                | 37 +++++++++++----
 t/helper/test-ref-store.c |  8 ++--
 7 files changed, 111 insertions(+), 83 deletions(-)


base-commit: 6640c2d06d112675426cf436f0594f0e8c614848
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1515%2Fjohn-cai%2Fjc%2Frefactor-ref-excludes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1515/john-cai/jc/refactor-ref-excludes-v1
Pull-Request: https://github.com/git/git/pull/1515
-- 
gitgitgadget
