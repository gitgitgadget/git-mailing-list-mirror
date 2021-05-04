Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102E3C433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 16:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D13D5613BE
	for <git@archiver.kernel.org>; Tue,  4 May 2021 16:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhEDQ2r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 12:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbhEDQ2q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 12:28:46 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED097C061761
        for <git@vger.kernel.org>; Tue,  4 May 2021 09:27:50 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id u20so9116527qku.10
        for <git@vger.kernel.org>; Tue, 04 May 2021 09:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kZEAYX8O4gX/K6wkQ1F+Tr+BVJRT7DoZQlezwq4K2u4=;
        b=s/pROxKXDVG8+dcXjnq/1ttAZn0Ch9Yu9iGYB6NKw4SrZ8apTza+wpSYmKjF5tTbU5
         s0z/Oj8dLLU2h3H9zwhIfVjF/1bMNIre5RsuzcDlh/2Q9kw+DkXYKJCfU5BhQ1mlOpWZ
         03K5r8Vk7ZmlW1VtVgplaTujaOnq6GDIlIWG2bBPxChS4l3YLDN1vat9CR2BiXbtSS5d
         TtbftalugNl34wFWOM3bul4opyyrQuV7DstG4F/viLd0fpVVxxs/VgbBumf34dl8AlKu
         GjwygpZzNnKfhb1Hs2yMnIkus99GsZ3ek+4REBhju+DICMvaUT7wSLzCveaW8iODaq1F
         TSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kZEAYX8O4gX/K6wkQ1F+Tr+BVJRT7DoZQlezwq4K2u4=;
        b=KuqFx7nifeqOq6iQ/WTcSpBQdzLZfuNEyyfsyE7ooRPCPKRcsscb2cPncBjtFK8EdE
         WuE9l8Z8mTKREbRBv1e54N7VCga2phlPB3ntJ6aIGmx0nIy7bZrw/91+ZmLbwYfLzhg2
         xxkThrvS9VK9pETc878YVGCeGvcDdo74JZOhRRmX01ZABJyn7v7JvRCOYMDQJeLeo5KN
         NXYi2DeZmnFC1CVY+hIU4Xc27qxad8UXVE++K4ywJN0BMOxO7MUfI3/uUKM83Zp9FuyC
         1IX8qGl0ykH0GlcBXu3+Er95Z2ti4Z70O4PmcR11DIoACvKS0CBOYlNTIKX03SmydLdL
         6HSg==
X-Gm-Message-State: AOAM533IZouHw7uhp14XMvuM4nK2Xf5nYot7Doxf73Z2MTzPvbHgTdxi
        czUCgCIbcehMFGhDMiyS1KDNeAsEzEVzdw==
X-Google-Smtp-Source: ABdhPJwrB7C4JOK94PRCA2/DUOHIfMdK9Tn5trykXqJMvX8pfs4bEhTyRmORvkvAB7uJoP5n398mpA==
X-Received: by 2002:a37:7006:: with SMTP id l6mr25359325qkc.137.1620145669691;
        Tue, 04 May 2021 09:27:49 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id x19sm11202689qkx.107.2021.05.04.09.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 09:27:49 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, git@jeffhostetler.com,
        stolee@gmail.com, tboegi@web.de
Subject: [PATCH v3 2/8] builtin/checkout.c: complete parallel checkout support
Date:   Tue,  4 May 2021 13:27:29 -0300
Message-Id: <e8988897876b932b7b0b812addbe3683ad52221f.1620145501.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1620145501.git.matheus.bernardino@usp.br>
References: <cover.1620145501.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pathspec-limited checkouts (like `git checkout *.txt`) are performed by
a code path that doesn't yet support parallel checkout because it calls
checkout_entry() directly, instead of unpack_trees(). Let's add parallel
checkout support for this code path too.

The transient cache entries allocated in checkout_merged() are now
allocated in a mem_pool which is only discarded after parallel checkout
finishes. This is done because the entries need to be valid when
run_parallel_checkout() is called.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/checkout.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index a597f31d53..2632dd9eff 100644
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
 
 	/* TODO: audit for interaction with sparse-index. */
 	ensure_full_index(&the_index);
@@ -387,10 +394,15 @@ static int checkout_worktree(const struct checkout_opts *opts,
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
2.30.1

