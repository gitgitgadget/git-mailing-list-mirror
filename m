Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44A0C1F597
	for <e@80x24.org>; Sun, 29 Jul 2018 10:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbeG2MDL (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 08:03:11 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39373 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbeG2MDL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 08:03:11 -0400
Received: by mail-lj1-f196.google.com with SMTP id l15-v6so7982967lji.6
        for <git@vger.kernel.org>; Sun, 29 Jul 2018 03:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WD5fo0f0i8WIWWA0SBVHDz6/stm9DiZ8dj3YwdAI2dg=;
        b=VKhHJ4LblbLxYwebe2WTtnyas1h7EiaPtHcJZ4E5TwI5zJr1ysLa17K8ZpaRIDksWs
         9PXLNH2NWKKUSp/SzaE63dfBtnPMk1OQxiuCcgAM9+TiQwUMNUC2JXLbTYjzDXkpZyAX
         x9JPnJMuBcjO9n3P1uEg5ZoEqCtbtTwkV0Npo8XJ3H/yoUMkUhdbq8o5BsQxD+lU4qib
         2yjkx0OlHws1h8p6TQmkC+8D/Fww0q4HSZuZejh/y0hx9kOxwVrM7nvJfDRzixOS4QUF
         N/+L0H4veMz71fiPlC0Zluf3Qd3P9tvt8EllWnKQPqCjMKiAOkTGi8TFB27F4iVz8tMa
         dFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WD5fo0f0i8WIWWA0SBVHDz6/stm9DiZ8dj3YwdAI2dg=;
        b=ZrUoGG4gWB9TGJjCA51nePJVY/l5+Mj0iueQg9H5YF8ZyuyH47aJ2834UUyTUfnwVw
         Zyz8MHX/xv/YY24n0bZRoxTt0L2RalDBeNhJ6ZMCLrVxbrb10xYaOmyFBxKFgmVupetk
         8cO1p2MVJv1wvv4ja/V6BouJyiMuCBkEiD0+jyjYQURjZmY6OGspBGKXHtEjgn7qlIHz
         5FgsqR9wiYJRM16OQZTU+jZRQFRhGzYqD4jZI1rfdyzU6zqg4rZhZnT3Iz3ZYrI8xL5I
         8QcU3Th9IQh6r7hIpnbqaLZOT7UwRZ4yRW++7nxLHyf4PqOXDQcT001w9CzEgWvG8age
         FT+g==
X-Gm-Message-State: AOUpUlHJOwcR+9kn+qJfaIzxhIkdZNgvhsCUoYx5tnX2LI33bhT3scjC
        XFwxELFy/a2SZeENUIGNVG0=
X-Google-Smtp-Source: AAOMgpeX/oRAAdb6ZA9nBwe/F58l1v1W+ruThe2zElCpuZ/gYOn3COI1IzOATCf33TFM9BaQmWYOiw==
X-Received: by 2002:a2e:e3:: with SMTP id e96-v6mr10481598lji.82.1532860391285;
        Sun, 29 Jul 2018 03:33:11 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id q72-v6sm1529212lja.6.2018.07.29.03.33.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 03:33:10 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        peartben@gmail.com, peff@peff.net
Subject: [PATCH v2 1/4] unpack-trees.c: add performance tracing
Date:   Sun, 29 Jul 2018 12:33:03 +0200
Message-Id: <20180729103306.16403-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.656.gda699b98b3
In-Reply-To: <20180729103306.16403-1-pclouds@gmail.com>
References: <20180727154241.GA21288@duynguyen.home>
 <20180729103306.16403-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We're going to optimize unpack_trees() a bit in the following
patches. Let's add some tracing to measure how long it takes before
and after. This is the baseline ("git checkout -" on gcc.git, 80k
files on worktree)

    0.018239226 s: read cache .git/index
    0.052541655 s: preload index
    0.001537598 s: refresh index
    0.168167768 s: unpack trees
    0.002897186 s: update worktree after a merge
    0.131661745 s: repair cache-tree
    0.075389117 s: write index, changed mask = 2a
    0.111702023 s: unpack trees
    0.000023245 s: update worktree after a merge
    0.111793866 s: diff-index
    0.587933288 s: git command: /home/pclouds/w/git/git checkout -

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache-tree.c   | 2 ++
 unpack-trees.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/cache-tree.c b/cache-tree.c
index 6b46711996..0dbe10fc85 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -426,6 +426,7 @@ static int update_one(struct cache_tree *it,
 
 int cache_tree_update(struct index_state *istate, int flags)
 {
+	uint64_t start = getnanotime();
 	struct cache_tree *it = istate->cache_tree;
 	struct cache_entry **cache = istate->cache;
 	int entries = istate->cache_nr;
@@ -437,6 +438,7 @@ int cache_tree_update(struct index_state *istate, int flags)
 	if (i < 0)
 		return i;
 	istate->cache_changed |= CACHE_TREE_CHANGED;
+	trace_performance_since(start, "repair cache-tree");
 	return 0;
 }
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 66741130ae..dc58d1f5ae 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -352,6 +352,7 @@ static int check_updates(struct unpack_trees_options *o)
 	struct progress *progress = NULL;
 	struct index_state *index = &o->result;
 	struct checkout state = CHECKOUT_INIT;
+	uint64_t start = getnanotime();
 	int i;
 
 	state.force = 1;
@@ -423,6 +424,7 @@ static int check_updates(struct unpack_trees_options *o)
 	errs |= finish_delayed_checkout(&state);
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
+	trace_performance_since(start, "update worktree after a merge");
 	return errs != 0;
 }
 
@@ -1275,6 +1277,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	int i, ret;
 	static struct cache_entry *dfc;
 	struct exclude_list el;
+	uint64_t start = getnanotime();
 
 	if (len > MAX_UNPACK_TREES)
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
@@ -1423,6 +1426,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 			goto done;
 		}
 	}
+	trace_performance_since(start, "unpack trees");
 
 	ret = check_updates(o) ? (-2) : 0;
 	if (o->dst_index) {
-- 
2.18.0.656.gda699b98b3

