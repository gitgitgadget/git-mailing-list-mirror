Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 583911F954
	for <e@80x24.org>; Sat, 18 Aug 2018 14:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbeHRRtm (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 13:49:42 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41809 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbeHRRtm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 13:49:42 -0400
Received: by mail-lj1-f196.google.com with SMTP id y17-v6so8478826ljy.8
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 07:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UOx2c/FMw6kJWtJ34/AscO1xrVRHNwAfTVSERHciNIw=;
        b=CLKm99Aq4g16hMaQfHd8tAr6y5maw+eOmrDTwzZ5NYccot3PQYvRuZOYVFUM7Hz+ok
         4u36Npv68sab0E8m0qXhVe77bJ2xV85RokzS526E1lbybC6DW5quG7Nxo2PaoTmbc5Pa
         6yUPF5wFdi0xoRUEmgx0Y6sR2ZoOJD1iGNrtF5hDVtD8xN3BbIwl6MvbNodlC3RUr4d1
         RIb/PZqPNkQumUg2ym53ts0BFQRLEy1xjUoe7/LBUbZCVLZ5V5MnNfOKYdJZLTD/Mwcl
         PplTSB0texSyCBQPbyfVI8PKDmavPYFgRm37ktX4IIm/WwbqkpaxT4jVa5oCW1kECscL
         0eQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UOx2c/FMw6kJWtJ34/AscO1xrVRHNwAfTVSERHciNIw=;
        b=BCJujZ0LQNcpTWlwgbrLk2joQwIcNjPYLK6o1Nv9GG6jWdSapfyjqNtVoQRXXHdUbb
         83NHmsrSOtQJt9oF2GMTnltiVNe7G2cUIilvPv+Uid//Eo4k5xVXVStIFhwfoADB8eqb
         6pwjn1MJ7ZnGmKFy3bv8I50B1DVj9hdL0xWYroi4Uzj9K/ibGXHCjuD28Fgjm5hatL9A
         7mFxWZKRa6lK0pgsEYPn60KKO/WeqtShis0cmmWMhG22r7cT2Vc2xJwNhNWNrpNucyHk
         C60f1e51E7WC5e8E45IQY055MJqJhozZsXt7Wo3w3QtQ2oPSN5qceGRUArNDICsxH/to
         2Zlw==
X-Gm-Message-State: AOUpUlELfciNvStPekBfyK3KReCtBEMzUYIHNGNOz6CfQiBU8nKVgN2p
        5dtfL7z0HU6GhFRQcagNj2s=
X-Google-Smtp-Source: AA+uWPwt5G0ZIIP9LaSFZnFc8tcC810iD9qzovLP/tC4CHHLB3CHSL59wFB/gEOm8jEdu2+kuX1NRA==
X-Received: by 2002:a2e:9e55:: with SMTP id g21-v6mr11243303ljk.116.1534603304977;
        Sat, 18 Aug 2018 07:41:44 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id b76-v6sm884451lff.53.2018.08.18.07.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 07:41:44 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        newren@gmail.com, peartben@gmail.com, peff@peff.net
Subject: [PATCH v5 6/7] unpack-trees: add missing cache invalidation
Date:   Sat, 18 Aug 2018 16:41:27 +0200
Message-Id: <20180818144128.19361-7-pclouds@gmail.com>
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

Any changes to the output index should be (confusingly) marked in the
source index with invalidate_ce_path(). This is used to make sure we
still have valid untracked cache and cache-tree extensions in the end.

We do a pretty good job of invalidating except in two places.
verify_clean_subdirectory() is part of verify_absent() and
verify_absent_sparse(). The former is usually called by merged_entry()
or directly in threeway_merge(). The latter is obviously used by
sparse checkout.

In these three call sites, only merged_entry() follows up with
invalidate_ce_path(). The other two don't, but they should not trigger
this ce removal because this is about D/F conflicts [1]. But let's be
safe and invalidate_ce_path() here as well.

The second place is keep_entry() which is also used by threeway_merge()
to keep higher stage entries. In order to reuse cache-tree we need to
invalidate these paths as well. It's not a problem in the past because
whenever a higher stage entry is present, cache-tree will not be
created [2]. Now we salvage cache-tree even when higher stage entries
are present, we need more invalidation.

[1] c81935348b (Fix switching to a branch with D/F when current branch
    has file D. - 2007-03-15)

[2] This is probably too strict. We should be able to create and save
    cache-tree for the directories that do not have conflict entries
    in cache_tree_update(). And this becomes more important when
    cache-tree plays bigger role in terms of performance.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 unpack-trees.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index aa80b65ee1..bc43922922 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1774,6 +1774,7 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 			if (verify_uptodate(ce2, o))
 				return -1;
 			add_entry(o, ce2, CE_REMOVE, 0);
+			invalidate_ce_path(ce, o);
 			mark_ce_used(ce2, o);
 		}
 		cnt++;
@@ -2033,6 +2034,8 @@ static int keep_entry(const struct cache_entry *ce,
 		      struct unpack_trees_options *o)
 {
 	add_entry(o, ce, 0, 0);
+	if (ce_stage(ce))
+		invalidate_ce_path(ce, o);
 	return 1;
 }
 
-- 
2.18.0.1004.g6639190530

