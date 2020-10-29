Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA70CC55179
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CBC420738
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="keazu4ve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732848AbgJ2CQq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 22:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729929AbgJ2CQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 22:16:16 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80494C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:16:16 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id f93so962264qtb.10
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GS4h2QNwoW0z+9ey/+u8HNPPBDVmzVwuGUsdvudWn3I=;
        b=keazu4veC6M1CohyII/Bzok1T23yHpul4GCX+0G+asz3GK2QZ0zYe8ScGhotxpgVtj
         VgyPPgUbKKFQBwdC1ezoNglsKIedbmgTRgEKBZtYfNfy2bRBtObm6KRQii8shgzK1arQ
         UaL4r39k1B0aEbksjrcu/j0Z3s1SaNE2kSCXao1M/Gi5OsaL718BbPbl4EucI94M5FgJ
         UNDtxeRjRqgXQ6w72nd5/vUaQU+jHVsPqk6qiKeLb5BVFGnPzNBcZ72bfwjdhVB4YPtS
         r9L77kBq5W9EhD24Z2bpl97xgGrRng/UG0izk/hLLzjz2tHUjEX5G/KpRzTdb6y0Ql55
         AgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GS4h2QNwoW0z+9ey/+u8HNPPBDVmzVwuGUsdvudWn3I=;
        b=k7YfkDEVxbBSRTeesKXN23jYycvHpJdVgLWdk5CAXLCQC/J7IoVfjofA8f0GJCynE0
         62TkWEquGK4ZeC9G2dlOLae6wOZuyTOEIYBUiO5Kq7Z5T7fqTaSsR8mfClvUthBaSGus
         G5ikkxiofOMN8Mbl1Q/6o3SuzwjCFiiVY8S6ZgG9bmMLLNdpB2YBLK6Z8S3c931RAIoz
         ZshaxwsH1CU9FJQqriSujOUlPr3AwyEDP5gcVum8dBIvxTbwUvQHv4slX5rmf6vAXi+i
         dObT2QZO7dB9rEv+m1duUXItptKzvH90vrTi2XvqgUO9szPcpI6j4VUrl1GiEH0nj6pk
         XV7Q==
X-Gm-Message-State: AOAM530hxH1vt0vz8wYpT0w4hnHskgRzDINj2UWaLiCqh2o5dEdIdZJ6
        f/jD7acfwG9EkI9YgQBzZdaDiNbTpoY4mQ==
X-Google-Smtp-Source: ABdhPJzttrz5K6sYtVYP87CANSniTIUC/NxaVGzqvSRIpydUCdKURBXB9ldZrJmWbripRsJYfEbvsw==
X-Received: by 2002:ac8:221a:: with SMTP id o26mr1849024qto.116.1603937775315;
        Wed, 28 Oct 2020 19:16:15 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id n201sm608371qka.32.2020.10.28.19.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 19:16:14 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [PATCH v3 14/19] builtin/checkout.c: complete parallel checkout support
Date:   Wed, 28 Oct 2020 23:14:51 -0300
Message-Id: <d3d561754a4d5599a5e14560c9e0da55ae627ffb.1603937110.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603937110.git.matheus.bernardino@usp.br>
References: <cover.1603937110.git.matheus.bernardino@usp.br>
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

