Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F2FC433EF
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 17:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbiBNRhQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 12:37:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiBNRhP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 12:37:15 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFA36541F
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 09:37:07 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d27so24301147wrb.5
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 09:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=sH0vqWgkO3Yes59EijZ1YDQtYpjte7smnD8X21uyTV4=;
        b=ob2JUInd8LMeYZd8oUvnqUE/1Na8/20epM6RO9iu29LqbXOtJWQdW0cqRII4MRdjog
         k5ONmXOD8G4tYBywyWGmr0dBqhyIzfPHA3UF3+IvQO4jdnvtaJV3GiwIw/P+MRQWBqG2
         E4xlP6VOv4rjLN2z9MltY8DW3Qq53HsM5bqeM7+Cu9u7XvHs6M0fvEjaVvvffV+1TGN7
         F6p/oJCPjKYS4Fw0wgdRJSpdUovQMl6zhpMNdGD3fVAREedx/amjNgi5WoWg6LuzkGZA
         k01ssQf3V7NMMKmP2Vlg6z9zcFCNF7NC7toA3zXxLKVt9/981aOAU+lVgzbl38JwIiO/
         upuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sH0vqWgkO3Yes59EijZ1YDQtYpjte7smnD8X21uyTV4=;
        b=7KOPC8NhwhtzQ7GOU1dGC7iIgSAs2Ab7yzqgfveEUS7Lv7nS7zyv0SvhUhIFU/wvtF
         8JXcpPxSeePXpk849OJtXwxv5C2Vjour2jtNNP661d5IKWp+CupTOWl54t/D7U6At3qI
         3hb2Ztqflw9CBzcCrgyp2+xRwYzk7VQQC+Qos/5lQQVKHSMrWbKFdI3JIBF4MgjUWumQ
         RVCitBGZRdra7gT1djEFqlxV/v3yK4d6p8oREYrDHSpHgJKuBhcLf1JZqtjTxuIsy/eZ
         9c6w/NkNnd7fEpBFipMkn99G+6Lq6kwt4mG5mAB1uyutjs+LZcRpb2CtzxobjtbrMQD1
         Hn6Q==
X-Gm-Message-State: AOAM5320m4+ZZjaj64JWIiIwOkTx48UrbBykTt8m5isY+lHk5NR+ny8Q
        LrGxgFed8ZW52/f4ohwYZxi5ecKtqKs=
X-Google-Smtp-Source: ABdhPJzm7/Ek7q79tLcY7gCThwww3qbYyyVeHQtK9Fae2YMq4qPHJ4L+WKL6Q/lz1wEUETH2opEr6g==
X-Received: by 2002:a05:6000:168c:: with SMTP id y12mr63853wrd.265.1644860225655;
        Mon, 14 Feb 2022 09:37:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8sm23747893wro.106.2022.02.14.09.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 09:37:05 -0800 (PST)
Message-Id: <pull.1058.git.1644860224151.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Feb 2022 17:37:04 +0000
Subject: [PATCH] dir: force untracked cache with core.untrackedCache
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The GIT_FORCE_UNTRACKED_CACHE environment variable writes the untracked
cache more frequently than the core.untrackedCache config variable. This
is due to how read_directory() handles the creation of an untracked
cache. The old mechanism required using something like 'git update-index
--untracked-cache' before the index would actually contain an untracked
cache. This was noted as a performance problem on macOS in the past, and
this is a resolution for that issue.

The decision to not write the untracked cache without an environment
variable tracks back to fc9ecbeb9 (dir.c: don't flag the index as dirty
for changes to the untracked cache, 2018-02-05). The motivation of that
change is that writing the index is expensive, and if the untracked
cache is the only thing that needs to be written, then it is more
expensive than the benefit of the cache. However, this also means that
the untracked cache never gets populated, so the user who enabled it via
config does not actually get the extension until running 'git
update-index --untracked-cache' manually or using the environment
variable.

We have had a version of this change in the microsoft/git fork for a few
major releases now. It has been working well to get users into a good
state. Yes, that first index write is slow, but the remaining index
writes are much faster than they would be without this change.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
    dir: force untracked cache with core.untrackedCache
    
    We have seen users in the wild that have had core.untrackedCache
    enabled, but never actually have an untracked cache created for them. We
    have a test in t7063 that shows git status should write the untracked
    cache, so I'm not exactly sure how users are in this state for long.
    
    This patch fixes the situation. I also know of another group that sets
    GIT_FORCE_UNTRACKED_CACHE=1 in their developer environment in order to
    get this behavior.
    
    -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1058%2Fderrickstolee%2Funtracked-cache-write-more-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1058/derrickstolee/untracked-cache-write-more-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1058

 dir.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index d91295f2bcd..79a5f6918c8 100644
--- a/dir.c
+++ b/dir.c
@@ -2936,7 +2936,9 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 
 		if (force_untracked_cache < 0)
 			force_untracked_cache =
-				git_env_bool("GIT_FORCE_UNTRACKED_CACHE", 0);
+				git_env_bool("GIT_FORCE_UNTRACKED_CACHE", -1);
+		if (force_untracked_cache < 0)
+			force_untracked_cache = (istate->repo->settings.core_untracked_cache == UNTRACKED_CACHE_WRITE);
 		if (force_untracked_cache &&
 			dir->untracked == istate->untracked &&
 		    (dir->untracked->dir_opened ||

base-commit: b80121027d1247a0754b3cc46897fee75c050b44
-- 
gitgitgadget
