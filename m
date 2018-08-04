Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56FCF1F597
	for <e@80x24.org>; Sat,  4 Aug 2018 05:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeHDHg5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 03:36:57 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39423 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbeHDHg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 03:36:57 -0400
Received: by mail-lf1-f65.google.com with SMTP id a134-v6so5550828lfe.6
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 22:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zbioVkR8scOM+C4IvHzdUrtrnih25hdyJ3DCmFnwW5M=;
        b=tcIW7AxrcqPs8BTWJkJQ6FwCTj2tPfiG7KTvvWMmQT1C+PopxtH6aL263DRbFCAoF2
         CEuzEEXHeMzpuRalB2FSg09EtlmHkmYElKFsgUMzN3I+5OyQwWFF0/PVxv0dW1b3+2eb
         fIq/hVGhdoIg9dEAq/lTjqgVRIBApBoVMmwJi1Pf+dGiWDbay+W5xrtiRWG/RQYMV4H7
         TEP3QMIkXXPiugjgsmubaSrbpcl9zM5hUw8Q/nlTXAyw17tuxHRNif2XJOAo59/WcQ+3
         Dlq3i6BV1UNpyAD+MMgkIeg+jYA6AL3X6WVw8Jj3NuPrFlLMXP2KEmvy9GR1QNUC/ytl
         xRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zbioVkR8scOM+C4IvHzdUrtrnih25hdyJ3DCmFnwW5M=;
        b=p5YbcZKklLwrctmNQ/GRC/fZmMe1z/55+kfBrZRxV6NdgJfrbL3KM2AC+xj3PYmOEx
         OzOG2iuCb8vPZm6FPhpXBTDsLG5UoIEsK8HWTDRS3QyeHULAT96NwS6TI9MC5G0WE6RJ
         K8c2H8Nw2bSOe8ZMmTMGBG3i0HhytOyU36tA5GCyUK1x0RMPm/wdMCeEdZPeW+cOZ/oc
         bJBKmiq1zs338iOudM8L4S0gxbLd2YMgHAZ/d5tU0yRdQrwsMRQVaoX5JvQ8AK8iunNG
         Z/WyZDy2gKlnb/nHgrQjJyx9sV/LUe1Gf2NJ0r4J+n7Sz1Qs1KgU70ZSVzzcNnd1kRHk
         tQlw==
X-Gm-Message-State: AOUpUlFCNnS7CFbpgsQXx6UuYu6QZ4RrrJb1g5c/Hv07yXbrrc0sgohY
        mEMiyFAilfn+ANTG+doLc4M=
X-Google-Smtp-Source: AAOMgpdwo8s1xk94kBTH1H7pbnxn6SYyh/pvTOGiwnciVDKTMyR04OP0go7b2Z5VLvOQiPCPfsd8Vw==
X-Received: by 2002:a19:10c4:: with SMTP id 65-v6mr6689194lfq.113.1533361052452;
        Fri, 03 Aug 2018 22:37:32 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id 85-v6sm1044021lft.76.2018.08.03.22.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 22:37:31 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        peartben@gmail.com, peff@peff.net
Subject: [PATCH v3 1/4] unpack-trees: add performance tracing
Date:   Sat,  4 Aug 2018 07:37:20 +0200
Message-Id: <20180804053723.4695-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.656.gda699b98b3
In-Reply-To: <20180804053723.4695-1-pclouds@gmail.com>
References: <20180729103306.16403-1-pclouds@gmail.com>
 <20180804053723.4695-1-pclouds@gmail.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
index cd0680f11e..a32ddee159 100644
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

