Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D8E71F597
	for <e@80x24.org>; Sun, 29 Jul 2018 10:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbeG2MDO (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 08:03:14 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:37231 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbeG2MDN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 08:03:13 -0400
Received: by mail-lj1-f179.google.com with SMTP id v9-v6so7982054ljk.4
        for <git@vger.kernel.org>; Sun, 29 Jul 2018 03:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o6KdBRv+nN1JzXBL70aPcOlzHX5jZd+s4CCdzrlwqgo=;
        b=hikBEc19hrs7OoRssTa+ZdCuV4WPLtSbBQrSTaX0MIAcAiModaXvxdo9Dt34dLK/km
         yFarP8H31VVUQH9TEegFlkAUptFK9e7jSJQkxYdNn8g89Ecw44O/QFbVltUNGc1xkUnk
         FJPdrtKWFXZA2j/qFDbMwW+UcO2CYi4LFH2nuKTawpvvvY7uQQz0bAXQdivJq9crWSs1
         RScSBI5daIUGErSP6p7j12AXgJbp2AoCeBjpgoGuMk6PG+IlD7/OwCOgsrwD/3fSQyns
         8h0+pU+l1iQElTPku4v5eD0X0pSwqellQjb6zz19zKG0YEQ2mJimdivLo2Wrn8Qc4tpp
         udpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o6KdBRv+nN1JzXBL70aPcOlzHX5jZd+s4CCdzrlwqgo=;
        b=TuhCG+IUWJoxfV5nqRTtbNPqAgu5dxtNj9D1t/wbPLz6mGfhiqSh/mw5KFZ02+ApNd
         N+Nb351w1cl+6AKqHVI9IcX3fqvnBgit84G/ThdQxX9kZyEZDTsr9TTJ4GqUZeU9HlqT
         Ot0HsF6k99gfZU0yGI4WUt+/l9F/ZNawQ6mgh/LI4fbZJ083E7WTpdXPWpqPnCOeyfux
         remC3nyj4DtwMWDvyrJlWcakaSNB/8LDxn5ISk8vphN8XzqvBfwcQryY8DpZ/G93udV2
         1Wwm0407URQlC6IHqU8DFpB0MEXGkZIhBMj/3f3psticxEwiwgSRZae/QutFPhjF8IWu
         MNVQ==
X-Gm-Message-State: AOUpUlGy59sTXuhzOwxnpF6FzzB+O67CVQHFLbzIuLMMCn5L3OQfodB/
        lM2/j8UyOSFUv0AnLkiLG1Q=
X-Google-Smtp-Source: AAOMgpcK699tsH9zI+UyZ9Wla51IjFWrD6lhZj+X9WE/czltXfHnxxHya/Rs8KHZkisboKEOJaFTZQ==
X-Received: by 2002:a2e:1984:: with SMTP id 4-v6mr10206576ljz.35.1532860393590;
        Sun, 29 Jul 2018 03:33:13 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id q72-v6sm1529212lja.6.2018.07.29.03.33.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 03:33:12 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        peartben@gmail.com, peff@peff.net
Subject: [PATCH v2 3/4] unpack-trees: reduce malloc in cache-tree walk
Date:   Sun, 29 Jul 2018 12:33:05 +0200
Message-Id: <20180729103306.16403-4-pclouds@gmail.com>
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

This is a micro optimization that probably only shines on repos with
deep directory structure. Instead of allocating and freeing a new
cache_entry in every iteration, we reuse the last one and only update
the parts that are new each iteration.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 unpack-trees.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 39566b28fb..c33ebaf001 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -694,6 +694,8 @@ static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
 {
 	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
 	struct unpack_trees_options *o = info->data;
+	struct cache_entry *tree_ce = NULL;
+	int ce_len = 0;
 	int i, d;
 
 	if (!o->merge)
@@ -708,30 +710,39 @@ static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
 	 * in the first place.
 	 */
 	for (i = 0; i < nr_entries; i++) {
-		struct cache_entry *tree_ce;
-		int len, rc;
+		int new_ce_len, len, rc;
 
 		src[0] = o->src_index->cache[pos + i];
 
 		len = ce_namelen(src[0]);
-		tree_ce = xcalloc(1, cache_entry_size(len));
+		new_ce_len = cache_entry_size(len);
+
+		if (new_ce_len > ce_len) {
+			new_ce_len <<= 1;
+			tree_ce = xrealloc(tree_ce, new_ce_len);
+			memset(tree_ce, 0, new_ce_len);
+			ce_len = new_ce_len;
+
+			tree_ce->ce_flags = create_ce_flags(0);
+
+			for (d = 1; d <= nr_names; d++)
+				src[d] = tree_ce;
+		}
 
 		tree_ce->ce_mode = src[0]->ce_mode;
-		tree_ce->ce_flags = create_ce_flags(0);
 		tree_ce->ce_namelen = len;
 		oidcpy(&tree_ce->oid, &src[0]->oid);
 		memcpy(tree_ce->name, src[0]->name, len + 1);
 
-		for (d = 1; d <= nr_names; d++)
-			src[d] = tree_ce;
-
 		rc = call_unpack_fn((const struct cache_entry * const *)src, o);
-		free(tree_ce);
-		if (rc < 0)
+		if (rc < 0) {
+			free(tree_ce);
 			return rc;
+		}
 
 		mark_ce_used(src[0], o);
 	}
+	free(tree_ce);
 	if (o->debug_unpack)
 		printf("Unpacked %d entries from %s to %s using cache-tree\n",
 		       nr_entries,
-- 
2.18.0.656.gda699b98b3

