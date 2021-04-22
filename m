Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96906C43460
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 15:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6925E6144A
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 15:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237767AbhDVPSn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 11:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237716AbhDVPSm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 11:18:42 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD36C06174A
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 08:18:06 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id v7so18560244qkj.13
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 08:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rs9dAKAw99xqaRokvRc7Ibbzn0q24C9LzMNXl2kVJQI=;
        b=xnhGSyFry58qNpo4ilT+Rp+py1adJw2EvjX3Fdv5oaUVSjaz1+N1cOVKB8CwR34WzB
         +ZFlRBolIXEFa4voF9bGTtWV9zf5XtW10wa7QJwZ7FzCc9iG3kJ4Q4Pqf3iT8C4rHYXL
         AWZb+wQ0fQAl1CzNIceEHoNdAhcPC1QyT4NA9xkOOrFBIHk1VOkbV1NCUSQEb5JfGORa
         UZwTIyDGn/1IsHdhVdOEIcD4+6oO+ryGqYUnUo28zg/CRil8ceNz+66I6vz6zs8Hr1Xo
         5ixVu7DfPkXVzjhYY+d9fOWr1H51IF3ZdnTItzayFJ+mzm2xGl5atUKtJhL2F6wFWukI
         /XgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rs9dAKAw99xqaRokvRc7Ibbzn0q24C9LzMNXl2kVJQI=;
        b=pYq2CPLdZeLO+zmRL3y7fVXXjFvxzhQC0V/W0WrICM3p57Hv83U5RH1A0aUtkPq51m
         uvv/lJpZ2k6/+8K0ZA8ANB8LyhdgxBKRCSmG5Y3bkBBEKGs3SDBjkHwmV3sc5iBuTCDt
         OW8ReQ7pCGr+Y/wJoQ2G3zjiW9qvMI78Uxmxne3AF1BTigsAvA/QMlDSffeBhxX/5xrH
         tgYTX/VDyNOnyAB+wUs8PRaRL+RLgIK5jWI6sXF86dvQggUZxs9fO4kHBdag0ViMGtBa
         ksrCG1Rnc2i3oPwia1SKzMWcN1W1aUzvA0lbtCJFMdloYfa0+rmAp4fsTVnVXoM50wgV
         ddgQ==
X-Gm-Message-State: AOAM533BV6Ofr/j83i9DxG6k+xhVM1qU2/BjC4WSAAtdE64+A4Pxzd65
        ROTyVVAyytoTCS7s/u084rHIkoJttRbh3Q==
X-Google-Smtp-Source: ABdhPJzc+3iQwnuM9UljmN1x+NKCVO/rrIx+Z5wP+3eWwj+5wY8MRk3mK3feipxk+Fk1ylK/gPryCQ==
X-Received: by 2002:a37:6801:: with SMTP id d1mr4141822qkc.363.1619104685398;
        Thu, 22 Apr 2021 08:18:05 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id l16sm2348909qkg.91.2021.04.22.08.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 08:18:05 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, git@jeffhostetler.com
Subject: [PATCH 2/7] builtin/checkout.c: complete parallel checkout support
Date:   Thu, 22 Apr 2021 12:17:48 -0300
Message-Id: <5e0dee7beba083159f4277ddcd9e931859239bde.1619104091.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1619104091.git.matheus.bernardino@usp.br>
References: <cover.1619104091.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is one code path in builtin/checkout.c which still doesn't benefit
from parallel checkout because it calls checkout_entry() directly,
instead of unpack_trees(). Let's add parallel checkout support for this
missing spot as well. Note: the transient cache entries allocated in
checkout_merged() are now allocated in a mem_pool which is only
discarded after parallel checkout finishes. This is done because the
entries need to be valid when run_parallel_checkout() is called.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/checkout.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index db667d0267..b71dc08430 100644
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
2.30.1

