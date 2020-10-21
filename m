Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79DFC388F9
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 13:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72AAB221FC
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 13:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPTCQbsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438328AbgJUNYi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 09:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409348AbgJUNYi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 09:24:38 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23976C0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 06:24:38 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c194so2206324wme.2
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 06:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=YR+8l7kM4H4Ssr0oCWzz1RxSWeitX2I66F5bAhNTgjI=;
        b=FPTCQbshAUs9N0rP6HwdbCUEu+Ep9FZPqOMWNkBTNRIJYlAByqPq3zb1BDjfBlzDjv
         h/lakQHFpJjp6nfJgNB+qhV2Lk4Y97V2b5eJ4EmNF/eyT67guoaxsX/jtiY+3bzVSuIJ
         R21xJ7Je+4Stm4euihopZM+bULfKSfyBXIIpJYGvGGIrMP0fXiv8schSeCeCklqN46LJ
         BV9A7IeSpVCpPic2UKudkMIzONMdVgwZcJotNuYvRaZc8Zhbp7ifbmWl/51WHyTrNe39
         x9V26HTbtzzjNYpsEbRzsjN+Tbm+PsMtSIoUwLrJ+0O8fb7/YqMF58qnlhghOj0lgghb
         J53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YR+8l7kM4H4Ssr0oCWzz1RxSWeitX2I66F5bAhNTgjI=;
        b=npCreM8D3TyvoZ3Qtmgx344Uihv1vflipMom+op51WWiDP/Zgqa2z5PSsGbX89cx6o
         OEygERgewHgpt/tIsGnZ7C80giAnv+4mbIYARAEgw6pcgny/aNfZhcxQNuV2oJMzP26k
         7Ql8GmMILw0hqKk4HjGa6oSnkGxfxUTSsNBVYHFlAJmQoKq/j1gFZo+2n/62k+mZBn6G
         eW/BhA5zsIxZu72dXTBgVH62YV9/hxHHId8sFjo+h9rLCGcdI03dK2jNAb5ww5RyWQks
         OhxD7mo/Jn7/xa0CWmipu25txT9W8tyxpvdwZTZa43JgwS3xozsS0mSLCINqFXtqoisF
         SWXg==
X-Gm-Message-State: AOAM533dksyeuPerp4kiGe5N58JcLOtRYdF2H0BRpIC+fTSS6GVUqJHu
        qP9irO2sXt2lYwxoSD1nfTmiwlidPJs=
X-Google-Smtp-Source: ABdhPJzibrmNuRWfT6EXy8sSTATj0Zsr9QpE93nvi0qaHAbNECkQgF3oiUA4/lVJvE3Q/GRZt8oAgw==
X-Received: by 2002:a7b:cf15:: with SMTP id l21mr3511727wmg.3.1603286676634;
        Wed, 21 Oct 2020 06:24:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q8sm3923154wro.32.2020.10.21.06.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 06:24:36 -0700 (PDT)
Message-Id: <pull.894.git.git.1603286675709.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Oct 2020 13:24:35 +0000
Subject: [PATCH] sequencer: remove duplicate rollback_lock_file() call
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit 2b6ad0f4bc ("rebase --rebase-merges: add support for octopus
merges", 2017-12-21) introduced a case where rollback_lock_file() was
unconditionally called twice in a row with no intervening commands.
Remove the duplicate.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    sequencer: remove duplicate rollback_lock_file() call

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-894%2Fnewren%2Fremove-duplicate-sequencer-code-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-894/newren/remove-duplicate-sequencer-code-v1
Pull-Request: https://github.com/git/git/pull/894

 sequencer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 00acb12496..baff51035e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3689,7 +3689,6 @@ static int do_merge(struct repository *r,
 				NULL, 0);
 		rollback_lock_file(&lock);
 
-		rollback_lock_file(&lock);
 		ret = run_command(&cmd);
 
 		/* force re-reading of the cache */

base-commit: 69986e19ffcfb9af674ae5180689ab7bbf92ed28
-- 
gitgitgadget
