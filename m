Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50B141F428
	for <e@80x24.org>; Sun, 12 Aug 2018 08:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbeHLKxK (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Aug 2018 06:53:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38270 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeHLKxK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Aug 2018 06:53:10 -0400
Received: by mail-lf1-f66.google.com with SMTP id a4-v6so9256578lff.5
        for <git@vger.kernel.org>; Sun, 12 Aug 2018 01:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hMOx40gSAWgV3VFsPd2Xtkglng9gfYgTl2go1RS6knA=;
        b=NK9OC9X2WLnb0GtiNq0T/cEQKZXYEXu2rEvES+nBH8hXEIX8Aojs8pCDBIAJO9VMc8
         aiuOjbln+Mml/K/sXDogTAwptj45f+CeYYsofhfB4qvmMsURESDA4jtkaAf7pyZTME/o
         /kMKmL8ijDM5/IOU6GK6XID34RSRonktthgTnJDCoTSQf4v1HXJqOnjxbu63Zvfh/EVh
         841Bwzt/A0PdHVY0vNWqsHdtG1/2/G6WUQwSgizMCJauA+i93aKMt36rPDLvaMif9BSw
         cVqsO4Paz8icZJ0F3rnEJ+f+GqfMzcfQa4YFjbil59X/e0rCjGLr7p38Ndk07NhWrDSn
         W95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hMOx40gSAWgV3VFsPd2Xtkglng9gfYgTl2go1RS6knA=;
        b=fENiE3JzcD8kBn4xNBDL/bu0ia609jXxDcJhekqZ8PjmfsYEFnM98BDWcwGLAbpAbg
         BxH5DJ2kFot/frHN9o8R5Fzd+3sMWW5vMTYPHQRqoGY6uTVeQzzGMEsSDH8pJ5UdBS2B
         r9G7e/QcB250WWi47TOKvcV1nqrVsy0bxZ+YqNpJOjOPzAuSnEtnPEwyPAMAqcPc4+7o
         licBapkO+Eykx2Ch1hmup39gDQ9NW+jqKwlIBIZmk/xEcE6FdZuXPycoSW+Fs3WTUaBm
         DmjpTbaOLffGwKnH3hSs05/CLGyaAjT91NTVnj74NRC2Oj5vUbkag3wrsrz6lv+PxTrt
         iDjQ==
X-Gm-Message-State: AOUpUlFJgPw88hIqsCjIRjRZh2z8mrKmSUahyfTG5ZWc6NpouTrcCUYf
        9R6x5gWyGIPC+FcRAI+HS34=
X-Google-Smtp-Source: AA+uWPxqOeJuPnhv+Zfur7exIHGR8K8xNaWDaREEcfp3CsyUCsRIs1fmr1Q3tjarBpfRIryATuiFEg==
X-Received: by 2002:a19:10c4:: with SMTP id 65-v6mr8756022lfq.113.1534061757615;
        Sun, 12 Aug 2018 01:15:57 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id w73-v6sm2769576lfd.57.2018.08.12.01.15.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Aug 2018 01:15:56 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        peartben@gmail.com, peff@peff.net, Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 2/5] unpack-trees: add performance tracing
Date:   Sun, 12 Aug 2018 10:15:48 +0200
Message-Id: <20180812081551.27927-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180812081551.27927-1-pclouds@gmail.com>
References: <20180804053723.4695-1-pclouds@gmail.com>
 <20180812081551.27927-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We're going to optimize unpack_trees() a bit in the following
patches. Let's add some tracing to measure how long it takes before
and after. This is the baseline ("git checkout -" on webkit.git, 275k
files on worktree)

    performance: 0.056651714 s:  read cache .git/index
    performance: 0.183101080 s:  preload index
    performance: 0.008584433 s:  refresh index
    performance: 0.633767589 s:   traverse_trees
    performance: 0.340265448 s:   check_updates
    performance: 0.381884638 s:   cache_tree_update
    performance: 1.401562947 s:  unpack_trees
    performance: 0.338687914 s:  write index, changed mask = 2e
    performance: 0.411927922 s:    traverse_trees
    performance: 0.000023335 s:    check_updates
    performance: 0.423697246 s:   unpack_trees
    performance: 0.423708360 s:  diff-index
    performance: 2.559524127 s: git command: git checkout -

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache-tree.c   | 2 ++
 unpack-trees.c | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index 6b46711996..105f13806f 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -433,7 +433,9 @@ int cache_tree_update(struct index_state *istate, int flags)
 
 	if (i)
 		return i;
+	trace_performance_enter();
 	i = update_one(it, cache, entries, "", 0, &skip, flags);
+	trace_performance_leave("cache_tree_update");
 	if (i < 0)
 		return i;
 	istate->cache_changed |= CACHE_TREE_CHANGED;
diff --git a/unpack-trees.c b/unpack-trees.c
index cd0680f11e..b237eaa0f2 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -354,6 +354,7 @@ static int check_updates(struct unpack_trees_options *o)
 	struct checkout state = CHECKOUT_INIT;
 	int i;
 
+	trace_performance_enter();
 	state.force = 1;
 	state.quiet = 1;
 	state.refresh_cache = 1;
@@ -423,6 +424,7 @@ static int check_updates(struct unpack_trees_options *o)
 	errs |= finish_delayed_checkout(&state);
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
+	trace_performance_leave("check_updates");
 	return errs != 0;
 }
 
@@ -1279,6 +1281,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	if (len > MAX_UNPACK_TREES)
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
 
+	trace_performance_enter();
 	memset(&el, 0, sizeof(el));
 	if (!core_apply_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
@@ -1351,7 +1354,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 			}
 		}
 
-		if (traverse_trees(len, t, &info) < 0)
+		trace_performance_enter();
+		ret = traverse_trees(len, t, &info);
+		trace_performance_leave("traverse_trees");
+		if (ret < 0)
 			goto return_failed;
 	}
 
@@ -1443,6 +1449,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	o->src_index = NULL;
 
 done:
+	trace_performance_leave("unpack_trees");
 	clear_exclude_list(&el);
 	return ret;
 
-- 
2.18.0.1004.g6639190530

