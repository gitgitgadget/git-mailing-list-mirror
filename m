Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FFBC2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DF552071A
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="YkJZ2gsy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgIVWvR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 18:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgIVWvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 18:51:16 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE286C061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:51:16 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id 19so17091819qtp.1
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GS4h2QNwoW0z+9ey/+u8HNPPBDVmzVwuGUsdvudWn3I=;
        b=YkJZ2gsyP/8wQdrh8FlOGebprhfJPdBHRSNCQyNBMXu3Ypxx7dSz+MeZ0DttzCvyNc
         nWQzOhI1uCuM5gIbxtjKlhyZTsL3r1/5NpQgF6VOD4JU9qC9/osCMyL/u7SAOBOHazMv
         lur6oKmb9vM0nkqLQA/CLviLFxMaD8vqqr98QXP68HzKQovxvmUBPb69b8AyZ6DXZNCy
         AYzoo3e81RX8ET0NhlbzUc00rYtsEAEHTmbiYd9PvsAZkLWDfSiqx2VEBqABqIjO89Lu
         zdkjqUt0iKBm4pfZ4SXBp7BA/rnnZIRwT8TBsflHPFZMkfTxKm1PmLGSZq+4An3+w/G9
         8Q9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GS4h2QNwoW0z+9ey/+u8HNPPBDVmzVwuGUsdvudWn3I=;
        b=HCwlmuZnLKIbWMDdBjdsEDQBS4YYoJ0r/9iyuII6BULYcUFO7qrbp1SLQmRliN0yAH
         +TkUnII4JPh0grclVMt/GbZAuO9ccovvR6By0weWnSYEKLxMKFfXTnxlnZl1/JdoehR4
         E5jHAlWUC3prZG74I7ZnCOKyw+3tU4BU70dpJU6EydQO39DtCpFQ+368j/eUJVsN6RCC
         FlUU8dYpRKJX3HC3M/VBGHa/oHWMdBX443VVPprYYRC1cgtuTsULeS2weLFFCqVHgj1z
         tU+NNAOXy/kQm30AYX44yLANEe1D6FAnX5UhTswed6KBQr4Ltk4j7mgipPVEyUwJYSij
         kalQ==
X-Gm-Message-State: AOAM531n4vhZuMls8qo9wnlrU2J8pNu5BHSz4P7DnbkklyES/lIDoFfz
        5tlnP3PyExrRlMsozkI+mb8jwolVlaPeHA==
X-Google-Smtp-Source: ABdhPJwTxD4q+3riGVosu3t6LIX9OFW8pLY3R923Mz8oIbeHDqaSVD7FD3eWXhKAGqkk9hVkYHb1Bg==
X-Received: by 2002:ac8:4e19:: with SMTP id c25mr7495541qtw.283.1600815075552;
        Tue, 22 Sep 2020 15:51:15 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.96.45])
        by smtp.gmail.com with ESMTPSA id p187sm12342359qkd.129.2020.09.22.15.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 15:51:14 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, chriscool@tuxfamily.org, peff@peff.net,
        t.gummerer@gmail.com, newren@gmail.com
Subject: [PATCH v2 14/19] builtin/checkout.c: complete parallel checkout support
Date:   Tue, 22 Sep 2020 19:49:28 -0300
Message-Id: <d7885a1130b6781a349d2c2647eaabe8d4ca115f.1600814153.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600814153.git.matheus.bernardino@usp.br>
References: <cover.1600814153.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is one code path in builtin/checkout.c which still doesn't benefit
from parallel checkout because it calls checkout_entry() directly,
instead of unpack_trees(). Let's add parallel support for this missing
spot as well. Note: the transient cache entries allocated in
checkout_merged() are now allocated in a mem_pool which is only
discarded after parallel checkout finishes. This is done because the
entries need to be valid when run_parallel_checkout() is called.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/checkout.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index c0bf5e6711..ddc4079b85 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -27,6 +27,7 @@
 #include "wt-status.h"
 #include "xdiff-interface.h"
 #include "entry.h"
+#include "parallel-checkout.h"
 
 static const char * const checkout_usage[] = {
 	N_("git checkout [<options>] <branch>"),
@@ -230,7 +231,8 @@ static int checkout_stage(int stage, const struct cache_entry *ce, int pos,
 		return error(_("path '%s' does not have their version"), ce->name);
 }
 
-static int checkout_merged(int pos, const struct checkout *state, int *nr_checkouts)
+static int checkout_merged(int pos, const struct checkout *state,
+			   int *nr_checkouts, struct mem_pool *ce_mem_pool)
 {
 	struct cache_entry *ce = active_cache[pos];
 	const char *path = ce->name;
@@ -291,11 +293,10 @@ static int checkout_merged(int pos, const struct checkout *state, int *nr_checko
 	if (write_object_file(result_buf.ptr, result_buf.size, blob_type, &oid))
 		die(_("Unable to add merge result for '%s'"), path);
 	free(result_buf.ptr);
-	ce = make_transient_cache_entry(mode, &oid, path, 2, NULL);
+	ce = make_transient_cache_entry(mode, &oid, path, 2, ce_mem_pool);
 	if (!ce)
 		die(_("make_cache_entry failed for path '%s'"), path);
 	status = checkout_entry(ce, state, NULL, nr_checkouts);
-	discard_cache_entry(ce);
 	return status;
 }
 
@@ -359,16 +360,22 @@ static int checkout_worktree(const struct checkout_opts *opts,
 	int nr_checkouts = 0, nr_unmerged = 0;
 	int errs = 0;
 	int pos;
+	int pc_workers, pc_threshold;
+	struct mem_pool ce_mem_pool;
 
 	state.force = 1;
 	state.refresh_cache = 1;
 	state.istate = &the_index;
 
+	mem_pool_init(&ce_mem_pool, 0);
+	get_parallel_checkout_configs(&pc_workers, &pc_threshold);
 	init_checkout_metadata(&state.meta, info->refname,
 			       info->commit ? &info->commit->object.oid : &info->oid,
 			       NULL);
 
 	enable_delayed_checkout(&state);
+	if (pc_workers > 1)
+		init_parallel_checkout();
 	for (pos = 0; pos < active_nr; pos++) {
 		struct cache_entry *ce = active_cache[pos];
 		if (ce->ce_flags & CE_MATCHED) {
@@ -384,10 +391,15 @@ static int checkout_worktree(const struct checkout_opts *opts,
 						       &nr_checkouts, opts->overlay_mode);
 			else if (opts->merge)
 				errs |= checkout_merged(pos, &state,
-							&nr_unmerged);
+							&nr_unmerged,
+							&ce_mem_pool);
 			pos = skip_same_name(ce, pos) - 1;
 		}
 	}
+	if (pc_workers > 1)
+		errs |= run_parallel_checkout(&state, pc_workers, pc_threshold,
+					      NULL, NULL);
+	mem_pool_discard(&ce_mem_pool, should_validate_cache_entries());
 	remove_marked_cache_entries(&the_index, 1);
 	remove_scheduled_dirs();
 	errs |= finish_delayed_checkout(&state, &nr_checkouts);
-- 
2.28.0

