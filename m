Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 517671F954
	for <e@80x24.org>; Sat, 18 Aug 2018 14:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbeHRRth (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 13:49:37 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42965 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeHRRth (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 13:49:37 -0400
Received: by mail-lj1-f195.google.com with SMTP id f1-v6so8468111ljc.9
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 07:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PvsEr3crB3o04YXBv+rO4iEx1cKKQJHjOpstgZZheUI=;
        b=sYJSfY1kgr2vYikQZjwA4nQbVHZtioMdMB+3ZrTKvZDSgrXmbafN1rESufkhVfdZXc
         DBP2Xyj5VBxluVctgYjLb2R7QNRSjbV01Uo/c+sSTGDbN+/jzl5A8xFZTwok70nWBh/J
         +DvFpg7jwxeJnIwRSmHTBjhb3875ihwFLtu1S4rZAOVI/s+iYMrXxjgwGB62uA3TeEgE
         IJnFJQxpqOeNILa+TDWi0zolIUfbefH7PZRWCrirytjoa4BwyjimKTCdpRhjsZui/mOW
         HD08MybqLzzKtGaR3Wsgem/z8S1krp63L8eNlkRzbr7S+3rhjpmMemXmsayb1BTrJlM2
         KAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PvsEr3crB3o04YXBv+rO4iEx1cKKQJHjOpstgZZheUI=;
        b=JPQkLBLMRxCjXTwsPtJYFLF6B75vO0WsvZaENhCCxBJ+IaNUp839QMRD2oLtb6A8yz
         y0xqUTnXvC5Wcb17Y6lJuY/qDaOVndggLFmYVg+PxZbJHwYn1Pkoj6cT3SYm4NUJylKb
         RqghrAYVule3dO+RwnD8D5e4yj8XZlRHV3vlBhhFIt23WT/yvTW/w5ivGZP3KPeM+/UO
         VN7yc8RyLJLeJ3NEFjIX7HdWtUdBetOub9ZfI/YDK0dbaEh66xVfR+ETY+NdqLoj+bDZ
         nuQWxuM7wV1AjHRb+pphyzQVCnCklTEWddetHlkYIT+VajLvkcBGw0Tux4fxN9yw6Jss
         hOCg==
X-Gm-Message-State: AOUpUlEKq7JM4SjZ6GhqaGQ4NG/7XSjXzwiuE90puDcUGxly6EM8gAKq
        SRoSAaHpXUkHIQo1erx2IBcBcZWc
X-Google-Smtp-Source: AA+uWPyKYcE5r8P7UX39R8Uw/kFG+p2+0K0QHCY1NskL1+p6flEGc6Q3RMhby6/WyN7kRXJSD4t4Vw==
X-Received: by 2002:a2e:8257:: with SMTP id j23-v6mr26452139ljh.49.1534603300112;
        Sat, 18 Aug 2018 07:41:40 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id b76-v6sm884451lff.53.2018.08.18.07.41.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 07:41:39 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        newren@gmail.com, peartben@gmail.com, peff@peff.net
Subject: [PATCH v5 2/7] unpack-trees: add performance tracing
Date:   Sat, 18 Aug 2018 16:41:23 +0200
Message-Id: <20180818144128.19361-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180818144128.19361-1-pclouds@gmail.com>
References: <20180812081551.27927-1-pclouds@gmail.com>
 <20180818144128.19361-1-pclouds@gmail.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache-tree.c   | 2 ++
 unpack-trees.c | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index 181d5919f0..caafbff2ff 100644
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
index f9efee0836..6d9f692ea6 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -345,6 +345,7 @@ static int check_updates(struct unpack_trees_options *o)
 	struct checkout state = CHECKOUT_INIT;
 	int i;
 
+	trace_performance_enter();
 	state.force = 1;
 	state.quiet = 1;
 	state.refresh_cache = 1;
@@ -414,6 +415,7 @@ static int check_updates(struct unpack_trees_options *o)
 	errs |= finish_delayed_checkout(&state);
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
+	trace_performance_leave("check_updates");
 	return errs != 0;
 }
 
@@ -1285,6 +1287,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	if (len > MAX_UNPACK_TREES)
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
 
+	trace_performance_enter();
 	memset(&el, 0, sizeof(el));
 	if (!core_apply_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
@@ -1357,7 +1360,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 			}
 		}
 
-		if (traverse_trees(len, t, &info) < 0)
+		trace_performance_enter();
+		ret = traverse_trees(len, t, &info);
+		trace_performance_leave("traverse_trees");
+		if (ret < 0)
 			goto return_failed;
 	}
 
@@ -1449,6 +1455,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	o->src_index = NULL;
 
 done:
+	trace_performance_leave("unpack_trees");
 	clear_exclude_list(&el);
 	return ret;
 
-- 
2.18.0.1004.g6639190530

