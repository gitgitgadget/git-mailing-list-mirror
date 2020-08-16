Return-Path: <SRS0=m/NF=B2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1E9C433E1
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 06:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 470A82065C
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 06:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qR0exCh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgHPG7P (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Aug 2020 02:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgHPG7O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Aug 2020 02:59:14 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79722C061786
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 23:59:14 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 9so10709251wmj.5
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 23:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=o+NT3mjfl1uyPOqkU4gZpZjyOt0Hbnii4eBQDAp66Tk=;
        b=qR0exCh3azVw6DEqdy2ma0Qy40ikKE3hSW+XyLCkJQby64htDyfGGpP/uPd1HEfxH/
         +zKnutj81NLovxIFZjqmye/uZQbN0a9I5YN3KGUpfO72JonetxQ3y4CTirWGDmg06eeN
         nblqoY4bGxWwzFj63dSyAt8RBiyRjiaNNXE3ewuBE7q96klQ61r04a0P2Tqe2KAJseyu
         GwxD/kJK9pqfHzBqJejvX2vcy2s7j7GLd0iAEwTs+ORZpdEAepGZOmZfflN6PAHxCXO8
         b+tfuT4GQbkPP6jSvCCl35fZgvbyyKf8jlXbCReyfVh81ukQfd4B7OiWrEkfZKfELaE6
         /0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=o+NT3mjfl1uyPOqkU4gZpZjyOt0Hbnii4eBQDAp66Tk=;
        b=OqLAp/H6fhD3OhxB/LuimDrSVNKGjnqHaADBAiokICVP6WnM0HAYqiVYm+lOSFP2BC
         Kd0pKP9G5//+vepdlk8H9OpfCq4gXdKQfHRdYkJU3/2AMMIFNNmNPp2zS0k+DMePxcJ+
         nNeCmx3OS+dcrE464/RbniahgY7vMSzooAcskz6Avb8s3n963sNSTk8sq3OFBvuXNRI7
         LIwIdNNOks+MtWXp2dPt7r17dPgZhEewlYfGD1Gi+vkMcBrWwbTvJiHM0EYKxLTZZ6mb
         Rp2kVv5Pbw/nk1j4jAxPcewe9PgSczRWcHOTnlCAcbCLGmYwOAj0DS8Q0qRaQe04bBtH
         tgpA==
X-Gm-Message-State: AOAM531UMcXetQmw67EkM6GadQdxpMNBnfmEI0zPfvrViApud0BgjQB/
        g4uZ7GvpmphmQeyWRFvbDrmHPtE7o5o=
X-Google-Smtp-Source: ABdhPJwxqibzPtxcH3cYp6hgZSQRSCeBy2CD9/7BypFHe4xUT5uGzhn6k7Q9QO+pVh7YoHMgtieqTA==
X-Received: by 2002:a1c:e919:: with SMTP id q25mr9319907wmc.123.1597561153066;
        Sat, 15 Aug 2020 23:59:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d23sm25224497wmd.27.2020.08.15.23.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 23:59:12 -0700 (PDT)
Message-Id: <pull.831.git.git.1597561152.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Aug 2020 06:59:08 +0000
Subject: [PATCH 0/3] Clean up some memory leaks in and around dir.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some memory leaks in dir.c were making it hard for me to find my own leaks
in merge-ort. I followed a few threads and tried to both clean up the leaks
and make the API less prone to incorrect use.

Elijah Newren (3):
  dir: fix leak of parent_hashmap and recursive_hashmap
  dir: make clear_directory() free all relevant memory
  dir: fix problematic API to avoid memory leaks

 builtin/add.c          |  4 ++--
 builtin/check-ignore.c |  4 ++--
 builtin/clean.c        | 12 ++++--------
 builtin/grep.c         |  3 ++-
 builtin/ls-files.c     |  4 ++--
 builtin/stash.c        |  7 ++-----
 dir.c                  | 23 ++++++++++++++++++-----
 dir.h                  | 21 +++++++++++----------
 merge.c                |  3 ++-
 wt-status.c            |  8 ++------
 10 files changed, 47 insertions(+), 42 deletions(-)


base-commit: 878e727637ec5815ccb3301eb994a54df95b21b8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-831%2Fnewren%2Fdir_memory_cleanup-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-831/newren/dir_memory_cleanup-v1
Pull-Request: https://github.com/git/git/pull/831
-- 
gitgitgadget
