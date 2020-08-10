Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD35FC433DF
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A299A206DA
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="2Q6xbdqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgHJVfc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgHJVfc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 17:35:32 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29419C061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:35:32 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 77so9872859qkm.5
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FcoQ2JwemdUdgjV7jH1TeoZsMmV/7yQxaQifCDX/Q+U=;
        b=2Q6xbdqAau+txXPshCtHv05jQFwDwqrK0RWIfRVM7OjUTeSwqC6EK5T2Rck6d0UczS
         xfB9w+rCfTEFwlvQBy1jFG5erS6pyUDYl6OKpH1froYozpZWVsjrlpRFDuEszY3E4ar8
         3ES0M0WQZA1LDxkAP9o1ySOrtI82MG6ZySEU8CivquKfhxOLp4DLY4qljMU/iUQWFIkO
         HhPk6mFJlqlx0f+guDgQdNakB2DnwiHpO/01kYZ8LmPNghx62ZDUAOmSZDojw8zzHlR8
         6wvpYbYMNAsZwkQqb3nxtrVDN878sy2gDMqV8jCBTLGI9YmeOUAGVNNUTc5faVz9frRC
         MFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FcoQ2JwemdUdgjV7jH1TeoZsMmV/7yQxaQifCDX/Q+U=;
        b=AvGHFDlVEqVKjpZ1vTC+eW0Bkv6FlLf+89jqVcusy8eXhrW1D+NDsbrag+TlnClmYF
         D6o9EVw9N2MbhqvWn6GBSEqRnUYihKDLpPzTMa0a2r++TbzYrxCw/UlKgJMLA63WsU0b
         cgUqY1CcyUO9gYfGTNI8sfKMp9NqERdjOK0KikhCWuJ7Jm40bSdU8ub902AjkylUiZXa
         /ylnBSAC/bp8a1vFieW3AM0Pmmu5Gl9s7E1rNVE5pXVL/4mMDjso/P5QQQvqf2Vp/XAD
         2zbmSpmhT9xhULNh2bO3mVQNR7qSFhuqZTlSOIA9SqI6pPxC0zDnLMi9g+wxC1hjJlHt
         LpVw==
X-Gm-Message-State: AOAM53391U3HrsGSTdo4k5YZJuft2XSd8tPbtcbWc2kiKuj6b0WBZxyE
        8/RT2JB0p2pyRoldFEJvr2V/IR8gByw=
X-Google-Smtp-Source: ABdhPJzcUx5CVF1Lq8cyG6DCylLLfr78lKIl4h63DPC3F+4TD5HU+sx7+/u2cHOxp39xNfA3PqYotw==
X-Received: by 2002:a05:620a:123c:: with SMTP id v28mr25811271qkj.366.1597095330915;
        Mon, 10 Aug 2020 14:35:30 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:87c:466:1120:3c2c:21e4:5931])
        by smtp.gmail.com with ESMTPSA id z197sm15370674qkb.66.2020.08.10.14.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:35:30 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [RFC PATCH 15/21] builtin/checkout.c: complete parallel checkout support
Date:   Mon, 10 Aug 2020 18:33:23 -0300
Message-Id: <258b855e49463ed39f0e6865327714c614c786d5.1597093021.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1597093021.git.matheus.bernardino@usp.br>
References: <cover.1597093021.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
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
index 8e4a3c1df0..b9230d5009 100644
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
+	struct mem_pool *ce_mem_pool = NULL;
 
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
+							ce_mem_pool);
 			pos = skip_same_name(ce, pos) - 1;
 		}
 	}
+	if (pc_workers > 1)
+		errs |= run_parallel_checkout(&state, pc_workers, pc_threshold,
+					      NULL, NULL);
+	mem_pool_discard(ce_mem_pool, should_validate_cache_entries());
 	remove_marked_cache_entries(&the_index, 1);
 	remove_scheduled_dirs();
 	errs |= finish_delayed_checkout(&state, &nr_checkouts);
-- 
2.27.0

