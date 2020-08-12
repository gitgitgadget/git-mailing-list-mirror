Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97EBC433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 23:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B30F3207DA
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 23:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uxj9UfNz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgHLXwE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 19:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgHLXwE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 19:52:04 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E81BC061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 16:52:03 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 3so3484097wmi.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 16:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=kK0ZDXKK38C2OZDHMgeOlBS9LfGnzM1A1tKPrWLK/hE=;
        b=Uxj9UfNzBKTxE9JbzvWlXGal7fdy0Lj5ux9y+b3efKzzuH/15HuxhmNDG0K97tmCe1
         kqtcFLtLDExAPQTYfS/Araub9iESk6bBqeHGsCdT/zrynvD6OPwTU3AvZa8lOyIUw/5j
         nhQiYHmgiM5MZ3/THWps5bMajnbsMGnPvXIniolzcYiKMqP54s63B2LJYtPt78WfHCy4
         bw8REA1mb03U+QfTGeMj/edTdz5Zntsv9emMZ0EWAgqrCyVqWlpKdnagw8LdTWVXE52X
         z22vwPaBbDec+pA3il2YFrzmHPCWfKprFkTSyIm4PtfNaVZlykdrxoWa6GjqwCB0MGNb
         Xmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kK0ZDXKK38C2OZDHMgeOlBS9LfGnzM1A1tKPrWLK/hE=;
        b=oEno7wftWVy9SdMCxP+ZgFwIAm8TttDlxWLdqcWj8E8P2n5gWBlV1+IkQOYxH0qa7U
         PigMGk5XDM18df2k1epTxkIRnUwpSZXK90BPgt3hsRYeg29ozGFroj4JWGF8WzqwVz7B
         EbfzhbWogvrqYUWfeb+8oehxgXiK5H3Qvkv7a0UsqNq/MVuoR7fLNUQ4/suUbv2iarV0
         1rUazBeK8gzM+fVGP17mXutzGUJqhbLFYQhctkTAu5by8lmlslGpGDo87dPG9eQbKppI
         UxdoqYvicm+ePqFxlEKxJqpEi6GFurHqtSCByIwt6V5Jt0TyhPW3vUFXvVizT7UoHXNg
         nq8g==
X-Gm-Message-State: AOAM530f44yr5q4mhi009z8vx/lY/xLRNV+vt/4P1m2QffD8DNG/jVXk
        F/h002V83gBw0VuF8jgWimDuEZBi
X-Google-Smtp-Source: ABdhPJwfW4wdA09G/nK9wncONUX+lbYuw4rk/FOoRD3mfiQWMW+IAwbJDLUKWZH88gzWG7hU/mYtug==
X-Received: by 2002:a1c:80d0:: with SMTP id b199mr1844171wmd.28.1597276321969;
        Wed, 12 Aug 2020 16:52:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 32sm7373227wrh.18.2020.08.12.16.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 16:52:01 -0700 (PDT)
Message-Id: <pull.701.git.1597276320563.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Aug 2020 23:52:00 +0000
Subject: [PATCH] fetch, pull doc: correct description of '--set-upstream'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>,
        Nathan BERBEZIER <nathan.berbezier@etu.univ-lyon1.fr>,
        Pablo CHABANNE <pablo.chabanne@etu.univ-lyon1.fr>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The '--set-upstream' option to `git fetch` (which is also accepted by
`git pull` and passed through to the underlying `git fetch`) allows
setting the upstream configuration for the current branch. This was
added in 24bc1a1292 (pull, fetch: add --set-upstream option,
2019-08-19).

However, the documentation for that option describes its action as 'If
the remote is fetched successfully, pull and add upstream (tracking)
reference [...]', which is wrong because this option does not cause
neither `git fetch` nor `git pull` to pull: `git fetch` does not pull
and `git pull` always pulls.

Fix the description of that option.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    fetch, pull doc: correct description of '--set-upstream'

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-701%2Fphil-blain%2Ffetch-set-upstream-doc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-701/phil-blain/fetch-set-upstream-doc-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/701

 Documentation/fetch-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 6e2a160a47..ff70625694 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -186,7 +186,7 @@ ifndef::git-pull[]
 endif::git-pull[]
 
 --set-upstream::
-	If the remote is fetched successfully, pull and add upstream
+	If the remote is fetched successfully, add upstream
 	(tracking) reference, used by argument-less
 	linkgit:git-pull[1] and other commands. For more information,
 	see `branch.<name>.merge` and `branch.<name>.remote` in

base-commit: 7814e8a05a59c0cf5fb186661d1551c75d1299b5
-- 
gitgitgadget
