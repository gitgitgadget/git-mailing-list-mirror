Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD86C433E6
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 20:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B479164F7E
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 20:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbhBDUP0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 15:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239975AbhBDUIi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 15:08:38 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21E3C061786
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 12:07:57 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id a16so6614233wmm.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 12:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=w5pzb6UY/ItrqAbQ1wYo8kS11Juig31WZ6F/0lHdQ38=;
        b=sxIhmPPI7ZjK6S2Ze+AmOPSAXuyEGCE4kCn0yGQUm0drr2VQThExgo+kYyWAf91n2H
         ZlqT6uur9+5V9Fbv7VjFNHxdrfEVSZUkqKU9Mm9+n/VBxgKKbyuU0O/rXcOH3O+CEw/X
         PADfOVjCVIvEG149yuMdYlI3gp0wKw3lVhmeGFTey/32msGPoSZR6F0fx08ESkl5NqVg
         LeJqXSlbIHA9jc3puaozP1PF/koZEbAg6bmiIN5F8FLUZd+PnJnv7jpUtmQkHRaHJPwM
         1I7R3ATL6FLAYOdwY4rFSK1Kzi0Do9gHb5tRVrCK1i0ucYvosrPUS8i2YSHtyFl/w4NK
         JV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=w5pzb6UY/ItrqAbQ1wYo8kS11Juig31WZ6F/0lHdQ38=;
        b=farBhAOxf7gMCYYCa/6Ogb+EBJZnN1woxpbPkLn7WTvsljZoLAHjJ0aWYepNW9/hwW
         sBHU/pwjfdufep5yzuTQAH2I+afFTkH86daHt1CysFoQFdhXnqajP4Hq8aRcHQGHTgcZ
         h+zVyBRqwWw4BtQt/U7ElSCToNIcw9XojY7ScU7yAnZQYXBlUUHw92wnPh2MK5Gqb3EE
         +7TEW1+BPM3Sa4cH/xNz7wIfYZsIU/6JqC1jvOHDrIm0umHkt+vS99doZzgXN6CTcUTS
         sGAaF9YTI9BB5P4iC6Y1BGc6D4Ufq3XNVOA9mxv3H54gC01jEpjLx3j7ucZbqQOXmcLi
         zd9g==
X-Gm-Message-State: AOAM532/r/GFPl587nhm9mKjKYEy3AqDRx1M00stIDpHykYL9t3m7IIr
        H6xmOvY+cXU2HR5/k0jLQ2zK0TLKM2U=
X-Google-Smtp-Source: ABdhPJy8aH7kSY7Nsi7YUAymx387Xcdn87kQK6Likgn5/bUUjV7djmBau88GCfgESlxdeLnuPYvVXg==
X-Received: by 2002:a1c:b1c3:: with SMTP id a186mr761650wmf.8.1612469276222;
        Thu, 04 Feb 2021 12:07:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i6sm8721309wrs.71.2021.02.04.12.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 12:07:55 -0800 (PST)
Message-Id: <pull.869.git.1612469275.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Feb 2021 20:07:48 +0000
Subject: [PATCH 0/6] Optionally restrict range-diff output to "left" or "right" range only
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of my quite common workflows is to see whether an ancient topic branch I
have lying about has made it into Git. Since my local commit OIDs have
nothing to do with the OIDs of the corresponding commits in git/git, my only
way is to fire up git range-diff ...upstream/master, but of course that
output contains way more commits than I care about.

To help this use case, here is a patch series that teaches git range-diff
the --left-only and --right-only options in the end, restricting the output
to those commits and commit pairs that correspond to the commits in the
first and the second range, respectively.

The first part of the series contains cleanup patches that are not strictly
related to the feature I implemented here, but since I already have them, I
figured I could just as well contribute them all together.

This patch series is based on js/range-diff-wo-dotdot.

Johannes Schindelin (6):
  range-diff: avoid leaking memory in two error code paths
  range-diff: libify the read_patches() function again
  range-diff: simplify code spawning `git log`
  range-diff: combine all options in a single data structure
  range-diff: move the diffopt initialization down one layer
  range-diff: offer --left-only/--right-only options

 Documentation/git-range-diff.txt |   9 +++
 builtin/log.c                    |  10 ++-
 builtin/range-diff.c             |  21 +++++--
 log-tree.c                       |   8 ++-
 range-diff.c                     | 101 +++++++++++++++++--------------
 range-diff.h                     |  12 +++-
 t/t3206-range-diff.sh            |  15 +++++
 7 files changed, 118 insertions(+), 58 deletions(-)


base-commit: 43718f6741a87f87bd400bdf5264394e980583c5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-869%2Fdscho%2Frange-diff-left-and-right-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-869/dscho/range-diff-left-and-right-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/869
-- 
gitgitgadget
