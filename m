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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED388C4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 11:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2BC561263
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 11:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhFBLtO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 07:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhFBLtN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 07:49:13 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C710BC061574
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 04:47:29 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n4so1992840wrw.3
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 04:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=YXHyXhNoHmySoP7l8qc7CyXhXYmnYzCTwWUPkwLKLSs=;
        b=e2TmwSjP39bN1uYQsfsfY7JVDUNpQYpX8jVzpbWj2L55TJ+jwSqBwNf7RLW4FY0VyW
         s4QqGTHhO5bOSVOKrKxXQvaqJE3e29kTlFVIfHuUg2I6OfmSG4ZNC9JXUoWQ+bEvBGps
         6pBXQe3UfBS35byuQIPnmIJGLJUyVFBBkx2jBQzyKCsaFmSaHUvllxQv/I2GWmHkGvE3
         0rQGso+wQzoqV+0dNwDhYpIwb4FJr+wyBkjsQby3KLxREL4Re48mjQQ5xhy+1Nb2lS/D
         zgWLfRBZq4GcjT+y2gGl+7AuT+ern0qWda4iCTnatUV/ocHJrUMOyNLnJ7ScrbRAMA+q
         qNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YXHyXhNoHmySoP7l8qc7CyXhXYmnYzCTwWUPkwLKLSs=;
        b=DMgUaQWloogn7G1UwI2gImIOUTYhSgI0CIU5sNXpiV7XYG7fIi5CIR1caaJAayLwWf
         1RCtTsV191+SyDjsZZ/jPr2LE/C+wxfguoOfk6OKgSOS8/pf/SGJ1YX7uyplGXiub2kW
         w1+4kaQd9Uy8m6OB9j9Mo3xItuvBH2D5etkWVDiJ4rVBAADZ2C50dMSJLmZWvaSRM22D
         r2vMC2hsQTWpnC4xE7YPj+hr6ZclOZNTsk4BUk+c1B5oznTZI9q4vjSeoN8zaXsYuBc/
         CX6BJ09H6gexA6ONVmCjy8KeBBpkjiAYnSFjThHhntYXZqeSiPw2UpF0FV97sR2Jk42g
         cA5w==
X-Gm-Message-State: AOAM532VWmfPyI8hDC/5ko88+Fy+1Ln+as5lp7/Nn+UY9BFHJN9YxlDR
        KHOqjzVIi8I0IMOPBT33QEjl30ghl1k=
X-Google-Smtp-Source: ABdhPJy5KrdIQYxG4vZ7BXwSXKxd6/y0b2RLmocUQMgbFBfJEpP+qwwW0TT0kVGu2vkFhaPZv7AuuQ==
X-Received: by 2002:a05:6000:50d:: with SMTP id a13mr31820768wrf.130.1622634448447;
        Wed, 02 Jun 2021 04:47:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o11sm6567991wrq.93.2021.06.02.04.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 04:47:28 -0700 (PDT)
Message-Id: <pull.968.git.1622634446643.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Jun 2021 11:47:26 +0000
Subject: [PATCH] Remove warning that repack only works on non-promisor
 packfiles
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

The git-repack doc clearly states that it *does* operate on promisor
packfiles (in a separate partition), with "-a" specified. Presumably
the statements here are outdated, as they feature from the first doc
in 2017 (and the repack support was added in 2018)

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
    Remove warning that repack only works on non-promisor packfiles
    
    The git-repack doc clearly states that it does operate on promisor
    packfiles (in a separate partition), with "-a" specified. Presumably the
    statements here are outdated, as they feature from the first doc in 2017
    (and the repack support was added in 2018)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-968%2FTaoK%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-968/TaoK/patch-1-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/968

 Documentation/technical/partial-clone.txt | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/Documentation/technical/partial-clone.txt b/Documentation/technical/partial-clone.txt
index 0780d30caca6..a0dd7c66f247 100644
--- a/Documentation/technical/partial-clone.txt
+++ b/Documentation/technical/partial-clone.txt
@@ -242,8 +242,7 @@ remote in a specific order.
   repository and can satisfy all such requests.
 
 - Repack essentially treats promisor and non-promisor packfiles as 2
-  distinct partitions and does not mix them.  Repack currently only works
-  on non-promisor packfiles and loose objects.
+  distinct partitions and does not mix them.
 
 - Dynamic object fetching invokes fetch-pack once *for each item*
   because most algorithms stumble upon a missing object and need to have
@@ -273,9 +272,6 @@ to use those promisor remotes in that order."
 The user might want to work in a triangular work flow with multiple
 promisor remotes that each have an incomplete view of the repository.
 
-- Allow repack to work on promisor packfiles (while keeping them distinct
-  from non-promisor packfiles).
-
 - Allow non-pathname-based filters to make use of packfile bitmaps (when
   present).  This was just an omission during the initial implementation.
 

base-commit: ed125c4f07ba69c53c9f4d74ff395a4bf7854ea7
-- 
gitgitgadget
