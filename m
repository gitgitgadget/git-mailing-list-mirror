Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3104C55179
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63A7D20782
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="JhW2rckV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732142AbgKDUeV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732121AbgKDUeU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:34:20 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FF1C0613D4
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 12:34:20 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id bl9so10570296qvb.10
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 12:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GS4h2QNwoW0z+9ey/+u8HNPPBDVmzVwuGUsdvudWn3I=;
        b=JhW2rckV46P4RjC8z33RoNwucYWfQapoijHmdi+HfzX412B5g0xD2bWDXzZVYLvzY/
         QwAm5YLjKf8z2wTT5H0YwanV1ogd7M6fsrs49g4oPR8gm8rAE1B6RzrVwsiggtqXcIcw
         OaC1MCJRD5iLzCBgLwToFYC22VDy5Fc9TsP+qbwSlD0FQEg2HvV8J3AEaUAO5KHugzLP
         gtecIFM84R3vyT0odFLVC0XOaBsbFR6r8Nivjp7bi90+kpM+ZWOZC20vzUsvknJHoaNl
         xwtgcejOGMUCR513zVk3lI9zjYNf+BthYx+4FJiBQW7YmY2iT0IgEEaclTMbn+KJuZTl
         2rXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GS4h2QNwoW0z+9ey/+u8HNPPBDVmzVwuGUsdvudWn3I=;
        b=FbUlG6WTVr9K3jDsvXx2dy0N1QSVYVwbbT+rP104LH+pmxcdJl7Wu/qxQc3kGbEC2a
         HRBldYTxrh5yUmaVHrSlvtnSn8L2GYSX3N31YclSp8pDh5JaSDWemLIGupBqLsPWjG53
         jV8fpP+pO7Y+8qMPhOhWcXP0CeqvYmnKrohxpYzsHWpLAW0f98LSPcUx7YhPIc1VjMiJ
         XIr2tLjCYUYOJetuYH/7aHL3LvSVps9LuWqtMVQ60V1fnFcJncFLzYxVhveK9wZh4FUT
         MW1HywD/RXB/drsI/65hc53eR5OukDky1YEnIn9IMCd2f3rc7S7Jw9YbE6VO8bqGgm5O
         7ZMQ==
X-Gm-Message-State: AOAM530Asmq9AA7hanszsqsRW/utNVaAO10sSENAv33j+aLrGA91Y6s3
        PdwIN7B+VD786T1gU4/oopLSNW4HXbVyQA==
X-Google-Smtp-Source: ABdhPJzuHY8TK4k9DKoN6cPxvSZx4cJPCYKGbxbESSLodsM1W9uwWO7ZgFrpDDS4RWLiUo8a0qvWDw==
X-Received: by 2002:ad4:4e84:: with SMTP id dy4mr22354604qvb.47.1604522058779;
        Wed, 04 Nov 2020 12:34:18 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id m15sm1100971qtc.90.2020.11.04.12.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:34:18 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [PATCH v4 14/19] builtin/checkout.c: complete parallel checkout support
Date:   Wed,  4 Nov 2020 17:33:13 -0300
Message-Id: <fb9f2f580c5ae02bbeb8117c85bc24307320aa59.1604521276.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604521275.git.matheus.bernardino@usp.br>
References: <cover.1604521275.git.matheus.bernardino@usp.br>
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

