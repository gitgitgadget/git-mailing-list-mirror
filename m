Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAC6C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 02:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDB7A61165
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 02:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbhHYCWy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 22:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbhHYCWv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 22:22:51 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE59C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 19:22:06 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso3692525pjq.4
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 19:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tn64yD4CkdTBtMUWRvba34W6G2nDA9wJoGFFbwxrMDk=;
        b=Tr/LIMU7yxtZoV4HF47WX1y7ydoB/FzYle5LzG45TZJfvsXWUSi9ZbrrFNcLzvR7q5
         eyC/nH1g+GT1QNN4LWFIxiWLHtc5213gCU4VDJNsIC/Ep96egTjKUi3b4cwfXFdoa36T
         3gAku8fDdr5ddglngK2Kmc9/+3Hq5ZsRYke5lTcnkGzcpgTKNUPlpbSv4AV7VtY0SLYL
         CZh1bVIB61NQqLZwBSSwL4UdZgD0t6coZEE31O8Xc3dNaDdB2zbzYcI1t8GeP+63+1dz
         C27xOUfuHN07AuPhCJYDdape3rOVXn4U9s/M4EGZqfjzrCkkw1+9bWse0Dte+duJEjGr
         IPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tn64yD4CkdTBtMUWRvba34W6G2nDA9wJoGFFbwxrMDk=;
        b=X/r6atMaus+nbs9tFeY2IxV+Z0cRpuv1Gv/LDDhnLYn2fvezqnM9AKXCjQzbuyyWS3
         7JbAWWlOM21vzt1lQbAMii2dQIaJ1bf27twg8PnOr2lNVA5pOsgLGAjnmWshQLAe4JXj
         7CvtE6mxnK/XOWqy4vFI/Ch7Y9bCzA5DsECIxZXD1FpQN+BKVXrt+Cjmrkb3mDMf28++
         X6Yf1ivfZNIKm/UouYoLn34l+edKa2sE0phnkwI9tLmw8zLL5UIZXPmGyzwD/hspkkJ4
         bfG0xpzuzB55r4Jd9AxE/hm4Oa0vV0iXjjEC5GzXWfcxOZxJkNRPr2oYXzADklt8/O5l
         pTuQ==
X-Gm-Message-State: AOAM5323dDEpYecNAfFV0SMgvxLaayr7dmEsMaZHCYp8zHQNVhOKcd0e
        C21ej8JrDFeCslsFjQ84qzuTeta+mldcPvUo
X-Google-Smtp-Source: ABdhPJxUzYWOQwYfUNETK5QZgf31/zr+/9dmJ47M65eBefVgmZkKcZLS42xP1O4OMZf0MTpsDboieA==
X-Received: by 2002:a17:90b:360c:: with SMTP id ml12mr6612958pjb.158.1629858126271;
        Tue, 24 Aug 2021 19:22:06 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.155])
        by smtp.gmail.com with ESMTPSA id e14sm3628683pjg.40.2021.08.24.19.22.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Aug 2021 19:22:05 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com, dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, jonathantanmy@google.com
Subject: [PATCH v5 00/14] packfile-uris: commits, trees and tags exclusion
Date:   Wed, 25 Aug 2021 10:21:44 +0800
Message-Id: <cover.1629805395.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.456.gec51e24953
In-Reply-To: <cover.1628666093.git.dyroneteng@gmail.com>
References: <cover.1628666093.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v5:

* Support tag objects exclusion (configurable but will repeat download object
data in previous patch)
* Tests and docs modification for tag exclusion feature
* Abstraction of some reusable methods

Teng Long (14):
  pack-objects.c: introduce new method `match_packfile_uri_exclusions`
  Add new parameter "carry_data" for "show_object" function
  packfile-uri: support for excluding commit objects
  packfile-uri: support for excluding tree objects
  packfile-uri.txt: support for excluding commits and trees
  t5702: replace with "test_when_finished" for cleanup
  t5702: support for excluding commit objects
  Add new parameter "carry_data" for "show_commit function
  commit.h: add wrapped tags in commit struct
  object.h: add referred tags in `referred_objects` struct
  packfile-uri: support for excluding tag objects
  packfile-uri.txt: support for excluding tag objects
  t5702: add tag exclusion test case
  pack-objects.c: introduce `want_exclude_object` function

 Documentation/technical/packfile-uri.txt |  38 ++-
 builtin/describe.c                       |   8 +-
 builtin/pack-objects.c                   | 128 ++++++---
 builtin/rev-list.c                       |   6 +-
 bundle.c                                 |   4 +-
 commit.h                                 |   5 +
 list-objects.c                           |  50 ++--
 list-objects.h                           |   4 +-
 object.c                                 |  20 +-
 object.h                                 |  16 +-
 pack-bitmap.c                            |  14 +-
 reachable.c                              |   8 +-
 revision.c                               |  42 ++-
 revision.h                               |   3 +
 shallow.c                                |   4 +-
 t/t5702-protocol-v2.sh                   | 330 ++++++++++++++++++++---
 upload-pack.c                            |   7 +
 17 files changed, 542 insertions(+), 145 deletions(-)

Range-diff against v4:
 -:  ---------- >  1:  73a5b4ccc1 pack-objects.c: introduce new method `match_packfile_uri_exclusions`
 -:  ---------- >  2:  bc8fea97e3 Add new parameter "carry_data" for "show_object" function
 -:  ---------- >  3:  f71b310842 packfile-uri: support for excluding commit objects
 -:  ---------- >  4:  bbb0413cc4 packfile-uri: support for excluding tree objects
 -:  ---------- >  5:  8e5bf4010c packfile-uri.txt: support for excluding commits and trees
 -:  ---------- >  6:  f3b1cba7e1 t5702: replace with "test_when_finished" for cleanup
 -:  ---------- >  7:  3b5f9732b8 t5702: support for excluding commit objects
 1:  19f7670384 =  8:  19f7670384 Add new parameter "carry_data" for "show_commit function
 2:  011e5eaea3 =  9:  011e5eaea3 commit.h: add wrapped tags in commit struct
 3:  824844499f = 10:  824844499f object.h: add referred tags in `referred_objects` struct
 4:  43aa811b65 = 11:  43aa811b65 packfile-uri: support for excluding tag objects
 5:  c83db0055c = 12:  c83db0055c packfile-uri.txt: support for excluding tag objects
 6:  29a52b7a0d = 13:  29a52b7a0d t5702: add tag exclusion test case
 7:  1a7c4c5894 = 14:  1a7c4c5894 pack-objects.c: introduce `want_exclude_object` function
-- 
2.31.1.456.gec51e24953

