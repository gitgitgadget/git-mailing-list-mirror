Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836CAC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 08:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 699B66113D
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 08:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348143AbhIHIan (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 04:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343797AbhIHIam (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 04:30:42 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FE9C061757
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 01:29:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q26so1971921wrc.7
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 01:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rYlesStfd2WQNMGrKUNbD2OPdQmWiXeYgEAZmRB2QLk=;
        b=R0y3M2MUeW8bfPyFuplRkM3l5zyRtYaKNX28N89qT1r9ErpPUBRg74owi0+cbfpG0C
         zo23Y1EZDVN6l2uI6L5xftve0f/0u5W4GIkTxBmuA/Xw87EzYVIAbUZ8dFXhJzU0Q8aX
         gnTYn09SN3EDnmD8SiWvlQR//luXrWumWflQU48B9tQ8kHW5O2znezSaMN6D5+wHq6y3
         9+Oj9eGgRVhcNs9KPGXSCuJMYLvg6y9QFUk9qCcIrn9u51cRYGKchiVc5IIS7J8OSk1N
         FRAEfAINyDku9FjOPNj1gLl9xJ4FW+wykz2H4LhcEXYa2bDYgG//oYG2aY94ThiFTHwg
         Yq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rYlesStfd2WQNMGrKUNbD2OPdQmWiXeYgEAZmRB2QLk=;
        b=ascgwQGiB6QyJ9WXCdI0/dqCO/cfh6c/PWdibjdccmKMf6VAyWQCfnkesqeGo4eg3o
         FAHehga55YlWBaXQdhoVdvWeTTc5OVeT1XzyRn6khE2jlaKAeyJ8BqQ5PaBSTb5NlTHb
         hMSMknSEiUyscHPeybb0rqSAwVwVDfHSMK4R6g3tDRx1wTt3C/vg+pez9jjVqw1ZmD6u
         2gQknJr3Oo+1uGnBMPjQA1whp9XZFBoKdbSCDJ0l6HkzVsKclNJoUGj0M32gkGfusYTt
         m8QmUWqCqIKUVkBitHj/ESvzPh2z/F3x8HQ9HfkwptPdDzYeJ2QPF9qBWPMUawTUDArM
         buKQ==
X-Gm-Message-State: AOAM530/v5ml76TdHF3N2c3OoJxazfslM8YvnxDGr4fO/AhW4adH3+wn
        kk3mdTugkMieHMTE0IgChoInGgAAHOQ=
X-Google-Smtp-Source: ABdhPJz1+Jtc3W4fbGN8FPYFxj5a3IjRKTRKir5ORt7KHNfGVBDqLmS86+7yo/R87o+WfIFk8RhB+Q==
X-Received: by 2002:a05:6000:124f:: with SMTP id j15mr2681044wrx.101.1631089773154;
        Wed, 08 Sep 2021 01:29:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15sm1267272wms.38.2021.09.08.01.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 01:29:32 -0700 (PDT)
Message-Id: <aade3ca574063a73d849a0081e4653a7f30eda78.1631089771.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1032.git.1631089771.gitgitgadget@gmail.com>
References: <pull.1032.git.1631089771.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 08:29:30 +0000
Subject: [PATCH 1/2] commit-graph: when closing the graph, also release the
 slab
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The slab has information about the commit graph. That means that it is
meaningless (and even misleading) when the commit graph was closed.

This seems not to matter currently, but we're about to fix a
Windows-specific bug where `git pull` does not close the object store
before fetching (risking that an implicit auto-gc fails to remove the
now-obsolete pack file(s)), and once we have that bug fix in place, it
does matter: after that bug fix, we will open the object store, do some
stuff with it, then close it, fetch, and then open it again, and do more
stuff. If we close the commit graph without releasing the corresponding
slab, we're hit by a symptom like this in t5520.19:

	BUG: commit-reach.c:85: bad generation skip 9223372036854775807
	> 3 at 5cd378271655d43a3b4477520014f02213ad1546

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit-graph.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/commit-graph.c b/commit-graph.c
index 3860a0d8477..09984455150 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -713,6 +713,7 @@ static void close_commit_graph_one(struct commit_graph *g)
 	if (!g)
 		return;
 
+	clear_commit_graph_data_slab(&commit_graph_data_slab);
 	close_commit_graph_one(g->base_graph);
 	free_commit_graph(g);
 }
-- 
gitgitgadget

