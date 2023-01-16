Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F52C677F1
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 17:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjAPR7m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 12:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbjAPR6p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 12:58:45 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0A825E3F
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 09:41:50 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id j16-20020a05600c1c1000b003d9ef8c274bso18383571wms.0
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 09:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IdUj7nF775Z77tkBkChdAuUqGNjbijlQNF6bHr72EVA=;
        b=kGXZpzjsN86wQT/92Iwi4gbJpEWwsPf3MrxAjBWoylylso4zfKhP0m8+JcbN9T2MIC
         xblB4Y1lyVXTFtuvNFkOscyhs3VSIs5/CFS+piLfJ3Zapmm39Z6+Xgmwt/+JG0gR5H0r
         uAbuVD6jw3nDkY7ibI6+nynuquRrhT1rTODSBjXXpytPsmtlpoNUqWprSacB56IRVReL
         BU46+iIfZdUEbGyY9c+B27RDgCYZTfR7eQiVAdtKfjFvzZVipS9eD5tWUJYue7mIe9Ys
         AK9pAHRuUWZI3XhuMr84GpQA3NLQZeyZuC1lHLySBjM7aBxTeChUwejs/1278Wm/WjrR
         LM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IdUj7nF775Z77tkBkChdAuUqGNjbijlQNF6bHr72EVA=;
        b=ooSdjPUBPEiHNN0tMF5bUdKwuqQoeF4gtYs+JdoRIb9XFmnLX292g5kNy8mKOSxJ78
         B9FXcjaHVF2y8RGEfbGztlXPhYx7UohkXMEOldKa/nHj/h4K1b3hHGEaJE6xP8FTvB5s
         0J5NYOsQOJ9h2PoIjevrsLoA18IYXYTDJ6u0mC7lnZTCFxACG3EUW8eXSA1RxHgO8Ss8
         1SaZgCuRt7041h1+yuyspHlbmaLDtOTPI4ZLLfg7h0wfSClxRoUwZ4lvkWqS1KqHEIq6
         gPfFQUsSPPeL1xTlPJTMu7iR8n8PTJkd4gBVPpmGFUZKkLXYsqY3IRCMCGxt4+HL8Fhf
         Dm+Q==
X-Gm-Message-State: AFqh2koW7LzmhrE/U+DKRKVD1HO2d3nKLwF7pX1yZ9PVHOzko84Ua3f6
        SIi5RJhQX68pO4eckAY+ZULsYO/QUz8=
X-Google-Smtp-Source: AMrXdXsi2veAtgT6h3uQxqCPfDLR6m7FUSHjAzBReUcqWySgrKKZnA0PKVYdbZiswXkFm31n4jCPbQ==
X-Received: by 2002:a05:600c:3c83:b0:3d9:e5d3:bf with SMTP id bg3-20020a05600c3c8300b003d9e5d300bfmr277005wmb.32.1673890909250;
        Mon, 16 Jan 2023 09:41:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bq14-20020a5d5a0e000000b002bdf2739cabsm6965141wrb.1.2023.01.16.09.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 09:41:48 -0800 (PST)
Message-Id: <pull.1464.git.1673890908453.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Jan 2023 17:41:48 +0000
Subject: [PATCH] branch: improve advice when --recurse-submodules fails
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

'git branch --recurse-submodules start from-here' fails if any submodule
present in 'from-here' is not yet cloned (under
submodule.propagateBranches=true). We then give this advice:

   "You may try updating the submodules using 'git checkout from-here && git submodule update --init'"

If 'submodule.recurse' is set, 'git checkout from-here' will also fail since
it will try to recursively checkout the submodules.

Improve the advice by adding '--no-recurse-submodules' to the checkout
command.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    branch: improve advice when --recurse-submodules fails
    
    Hi Glen,
    
    This is a small improvement I thought about when looking at that code
    recently.
    
    Cheers,
    
    Philippe.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1464%2Fphil-blain%2Fbranch-recurse-improve-advice-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1464/phil-blain/branch-recurse-improve-advice-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1464

 branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/branch.c b/branch.c
index d182756827f..e5614b53b36 100644
--- a/branch.c
+++ b/branch.c
@@ -756,7 +756,7 @@ void create_branches_recursively(struct repository *r, const char *name,
 				_("submodule '%s': unable to find submodule"),
 				submodule_entry_list.entries[i].submodule->name);
 			if (advice_enabled(ADVICE_SUBMODULES_NOT_UPDATED))
-				advise(_("You may try updating the submodules using 'git checkout %s && git submodule update --init'"),
+				advise(_("You may try updating the submodules using 'git checkout --no-recurse-submodules %s && git submodule update --init'"),
 				       start_commitish);
 			exit(code);
 		}

base-commit: 4dbebc36b0893f5094668ddea077d0e235560b16
-- 
gitgitgadget
