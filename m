Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2163BC432BE
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 12:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1EDD60ED4
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 12:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbhGWLeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 07:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbhGWLeA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 07:34:00 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B447EC061757
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 05:14:33 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o3-20020a05600c5103b029024c0f9e1a5fso3121804wms.4
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 05:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jAH3N7M82HZ3MrUhNbVmtE5vAv7GcKpkAAhbEgb1yGY=;
        b=fySswi2zjqOqc5RiyHdOftrUUTQDIilITamxV0hvTRUoCOv9BJ/Ehre+nQJPrdrulA
         oXZpASlu4cCwSz2MMVV9ln3IYV7HtcAmfrqmrnhsXMPniMU2G39ig3RGau9b1oFoiqUW
         PXljtVg3rYnnNIQJtDcYMBJZnVYqdC8QJ16/MuaexLLm1OaHnE1mkL2+9/S8lDlDKj80
         WvtW3hjGXMZevk0i5TETig9ASivjV929cvKrB625J0Gl6Ro5gXQuCU6LLlNaR3fnsYAq
         rlFSDAs/xjzjQT6mWPoG9vR6amE/kySeugL8SZO6jZ9UIwc50FLXrrDkcF2OccMj3OJk
         bkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jAH3N7M82HZ3MrUhNbVmtE5vAv7GcKpkAAhbEgb1yGY=;
        b=TQx/WNXWH0/eFim+GsFNVjhBmKAnAHc7sd2ah8atXgoKcn31cisv0qzi/8HBYpcAa+
         XtYOzqsHShBcJtPwCKCmrAWJw16NeYLu2a0yg3YsXwliK7iiHaqzhcvzsDhhSbuSAYKG
         lv33EYEhK7DhaPZPLTIDHXYPIvxgMW0gOWj+gVo0fEVFh4Upb+352NjwxLeW1t+YPa88
         hiV+nAbxQfalRm0tcW5o9pf58tp6aZLlGR9UUbDX5pi/3Xjp3FPHx59ml2PVchN1GyzB
         0VZTCcWHlyWpBASCFaNKJk6+IfwX9M7PxUWVnnsX5NM20YljfkyVm2qe5rYYio2E0wAC
         vDjQ==
X-Gm-Message-State: AOAM531Tfwfb+oEhmDDcjM9r/r5HGeBjedZvBQ0Orp6YW91OVUz/OK/B
        vUnxmYakxlYRYOphQN565PrJCcUT7Cg=
X-Google-Smtp-Source: ABdhPJw3oR5QPrIJx/6CINeRVBJWk/hEyWh3ccn3qPbU0LVAnyzoAkWm0Zik7K/dW2Vq8IKQov+CpQ==
X-Received: by 2002:a7b:cc16:: with SMTP id f22mr2272783wmh.99.1627042472407;
        Fri, 23 Jul 2021 05:14:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w9sm27826039wmc.19.2021.07.23.05.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 05:14:32 -0700 (PDT)
Message-Id: <85016e679eb77cbb17edc9b6849251893a5e9ec2.1627042470.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1002.git.1627042470.gitgitgadget@gmail.com>
References: <pull.1002.git.1627042470.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Jul 2021 12:14:27 +0000
Subject: [PATCH 1/4] merge: add missing word "strategy" to a message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The variable 'best_strategy' holds the name of the merge strategy that
resulted in fewer conflicts, if several strategies were tried. When
that's the case but the best strategy was not the first one tried, we
inform the user which strategy was the "best" one before recreating the
merge and leaving the conflicted files in the tree.

This informational message is missing the word "strategy", so it shows
something like:

    Using the recursive to prepare resolving by hand.

Fix that.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 builtin/merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index a8a843b1f54..74797b6c7a6 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1715,7 +1715,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	else {
 		printf(_("Rewinding the tree to pristine...\n"));
 		restore_state(&head_commit->object.oid, &stash);
-		printf(_("Using the %s to prepare resolving by hand.\n"),
+		printf(_("Using the %s strategy to prepare resolving by hand.\n"),
 			best_strategy);
 		try_merge_strategy(best_strategy, common, remoteheads,
 				   head_commit);
-- 
gitgitgadget

