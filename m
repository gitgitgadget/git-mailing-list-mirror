Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD59C77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 08:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240177AbjELIDs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 04:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240095AbjELIDn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 04:03:43 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34E21B1
        for <git@vger.kernel.org>; Fri, 12 May 2023 01:03:41 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-19674cab442so1488770fac.3
        for <git@vger.kernel.org>; Fri, 12 May 2023 01:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683878620; x=1686470620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c4EnRVqWdl/VzQ5x3VuDYyJdwa8cKxfkiowgGT/Yv30=;
        b=M3JHGK25nvQotgW7OQt+xS7Dnp5max0rg3PSsyUAHZ9vGytemTtF7ftgclpalRba67
         5U80GQ5lRUw7f8s9bkeKKP6VH1eD/o4Ir7w6BTTJh+cQnX6SSt08NtJB/Z73XGJpFfiM
         5ATzd9VVFblmU0yxFT671JUlamRv+r+375ZfWDZJGSY7e9m9SMdr3qSZQK0rDQO+1sOi
         LKsVQ4Fk3RoUdgLtpdBNh76fbdv7qKizlPfWkq82uec2KismFXekhADW9/YtCeS+JvNQ
         BpnHGmgTckDbwraC7pQ2D2uf42JwFf0PGL67Zew4G1hC4dcj+t1VONHF1AlYgUC50OBd
         qISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683878620; x=1686470620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c4EnRVqWdl/VzQ5x3VuDYyJdwa8cKxfkiowgGT/Yv30=;
        b=GZ97ne+1LnHZjLVRFnAbMEp+JxZ7P1YGDOiYYwlDi/m+Ytzb84OXv1QJXG10Y4jm+9
         BLq9puf6zay6eiHWk7o1rta78ngyjT+A9gbRyIpEO/WvQ75/l7DyN5L4qSSTbMA/Fyix
         yjNPMaBhoEUUZb4B3d1DM4NP7lrY35z3Q+r6lKIYYA8R2VnQIgkLinOadf8Sv66nldcq
         anLmcdoLCSriI0584+6aQvh8kLQ6SoXcPZT8o18vDBzHacKF6E8b34gTZcWrCuJXnUsi
         UMVBUBARzQ+QeGOsX89zIWphtl1NduCfbUFnwHxxtMcpwQVX0++X+nAZnFpIPw6tTz+L
         zghA==
X-Gm-Message-State: AC+VfDwv4q/feDfVhc+kzd13aiOj1CC9oDW7Zu2WNClBqr556nJ5spJR
        qQbShltf7YHPQ/1pLY5SyUoRQhisVL0=
X-Google-Smtp-Source: ACHHUZ7l0Rs+A/bmc9k2JVVPjpWLvlXMJ0LeWWGLBAuqKsEnHYFihkzSrSxx0KGLaZ/hzNiQ4omOIg==
X-Received: by 2002:a05:6870:b146:b0:196:51e7:6454 with SMTP id a6-20020a056870b14600b0019651e76454mr4551224oal.51.1683878620350;
        Fri, 12 May 2023 01:03:40 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id y17-20020a056870381100b00187d06465edsm8803558oal.43.2023.05.12.01.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 01:03:39 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 0/7] diff: fix -s and --no-patch
Date:   Fri, 12 May 2023 02:03:32 -0600
Message-Id: <20230512080339.2186324-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The diff code assumes 0 means the default, and --no-patch means
NO_OUTPUT.

The problem with this approach is that it doesn't allow distinguishing
`git diff --no-patch`, `git diff --patch --no-patch`, and `git diff`.

By introducing a DIFF_FORMAT_DEFAULT (which is not 0) it's now possible
to properly distinguish these arguments, and get rid of
DIFF_FORMAT_NO_OUTPUT which should have never been considered a format,
but the absence of a format.

This fixes an issue Sergey Organov reported.

Up to patch #2 (diff: introduce DIFF_FORMAT_DEFAULT) there are no
functional changes, patch #3 (diff: make DIFF_FORMAT_NO_OUTPUT 0)
achieves the same as a series from Junio Hamano [1] except more
properly. Patch #4 adds a simplified version of Junio's test cases.

Then in patch #5 --no-patch is split from -s, making it work as
intended: negates --patch, but not other formats.

The rest are some niceties.

Now all these work correctly:

 1. git diff --raw
 2. git diff -s --raw
 3. git diff --no-patch
 4. git diff --no-patch --raw
 5. git diff --patch --no-patch --raw
 6. git diff --raw --patch --no-patch

[1] https://lore.kernel.org/git/20230505165952.335256-1-gitster@pobox.com/

Felipe Contreras (7):
  line-log: set patch format explicitly by default
  diff: introduce DIFF_FORMAT_DEFAULT
  diff: make DIFF_FORMAT_NO_OUTPUT 0
  test: add various tests for diff formats with -s
  diff: split --no-patch from -s
  diff: add --silent as alias of -s
  diff: remove DIFF_FORMAT_NO_OUTPUT

 Documentation/diff-options.txt |  6 ++--
 blame.c                        |  6 ++--
 builtin/diff-files.c           |  2 +-
 builtin/diff-index.c           |  2 +-
 builtin/diff-tree.c            |  2 +-
 builtin/diff.c                 |  2 +-
 builtin/log.c                  | 16 +++++++---
 builtin/stash.c                |  4 +--
 builtin/submodule--helper.c    |  2 +-
 combine-diff.c                 | 10 +++---
 diff-merges.c                  |  2 +-
 diff-no-index.c                |  2 +-
 diff.c                         | 56 ++++++++++++++++++----------------
 diff.h                         |  6 +---
 line-log.c                     |  2 +-
 log-tree.c                     |  4 +--
 merge-ort.c                    |  4 +--
 merge-recursive.c              |  4 +--
 notes-merge.c                  |  4 +--
 range-diff.c                   |  4 +--
 revision.c                     |  6 ++--
 t/t4000-diff-format.sh         | 26 ++++++++++++++--
 tree-diff.c                    |  2 +-
 23 files changed, 99 insertions(+), 75 deletions(-)

-- 
2.40.0+fc1

