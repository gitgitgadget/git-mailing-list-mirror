Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA697C433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 19:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8A872311B
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 19:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbhAWT7S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 14:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbhAWT7E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 14:59:04 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58177C061786
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 11:58:24 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d16so7697302wro.11
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 11:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+A0SHikiMuu/wPZEMUwCv2+0OZd1VZkq05UUFRdHlUA=;
        b=c0ztjakr8he5ZPexu4be7JR8drIz1LvQ9Z1O33bgFw1NOiRAVb6I/fP33wl8CVPtbU
         4QdHUM6A/Sk55xXo5rNs0Tl/ggUjffEIcQbngT5EYZz8az8sRm6UzDUg5XRUH+EorUS3
         RBGQK6kB9bJccmrPNriGrI+puwOvACLOSz0wbeT2HrWYUeXPLAN4AUYBm2gZqCx6i5dK
         V/m2kVIttOw+EHFy8JKFnug0o7/F/FVRP9e9lfUAjk2qrIPjRcgHu7lUlw8RTsBZaUTu
         RElCLwg11uhG9ddHZEBNMDgBKItrrSaS78+y4KxvPinaHlNDFj5djcX/yRCMoRf9T7uB
         orlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+A0SHikiMuu/wPZEMUwCv2+0OZd1VZkq05UUFRdHlUA=;
        b=Msc+PwTqBvBrym11e/WU/jPPGUMvTRjQ7qxSIxO8nWP9hHYLIGe66xUVmj63FZ2jhE
         6Mh1/qQ4xXj09DpTCtXN9eDzi8Z8M9pDxpdSHvpijsallj1tleUAGQwlYK042VtNpphV
         sjc73WCj11xm60cxXXLU5I3OHUbyEI1Hs9De/koYdIhyqvkk3ztCJVuEsziL7y+zX8iL
         adAtIirabBqurkxRbsfIJFadbA6oN+OEV0AuUHLGbuPTbgFpEzpGpNnCUoaQZF7NdbOP
         9xSz8Aiv5C0sWck//Bb/Qpj7+RGY6irEfwlPGJCpQ28xS0cr5ax3vJMN+r33EJmXYuwI
         cxfw==
X-Gm-Message-State: AOAM533HpZOA0MIVWU9wLBMkqlV9C0DjqwYS3Zl/pG2q/bppEk8AOjff
        b44WouJIBAfMXKCAxCV15nU/lCobwKo=
X-Google-Smtp-Source: ABdhPJzmvbCTw0C8Hxy7y7+G4DXaDVSVW1d3FDSKFSfFeLjS/jXX0a4X+L+k+zn4IZkvdaIIliRGmQ==
X-Received: by 2002:adf:81e4:: with SMTP id 91mr10484393wra.161.1611431902985;
        Sat, 23 Jan 2021 11:58:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b4sm4663933wrn.12.2021.01.23.11.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 11:58:22 -0800 (PST)
Message-Id: <1b8b56800948339c0e0387555698bdfdc80a19ad.1611431900.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.839.v3.git.1611431899.gitgitgadget@gmail.com>
References: <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
        <pull.839.v3.git.1611431899.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Jan 2021 19:58:12 +0000
Subject: [PATCH v3 2/9] cache-tree: simplify verify_cache() prototype
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <stolee@gmail.com>,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The verify_cache() method takes an array of cache entries and a count,
but these are always provided directly from a struct index_state. Use
a pointer to the full structure instead.

There is a subtle point when istate->cache_nr is zero that subtracting
one will underflow. This triggers a failure in t0000-basic.sh, among
others. Use "i + 1 < istate->cache_nr" to avoid these strange
comparisons. Convert i to be unsigned as well, which also removes the
potential signed overflow in the unlikely case that cache_nr is over 2.1
billion entries. The 'funny' variable has a maximum value of 11, so
making it unsigned does not change anything of importance.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache-tree.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 60b6aefbf51..acac6d58c37 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -151,16 +151,15 @@ void cache_tree_invalidate_path(struct index_state *istate, const char *path)
 		istate->cache_changed |= CACHE_TREE_CHANGED;
 }
 
-static int verify_cache(struct cache_entry **cache,
-			int entries, int flags)
+static int verify_cache(struct index_state *istate, int flags)
 {
-	int i, funny;
+	unsigned i, funny;
 	int silent = flags & WRITE_TREE_SILENT;
 
 	/* Verify that the tree is merged */
 	funny = 0;
-	for (i = 0; i < entries; i++) {
-		const struct cache_entry *ce = cache[i];
+	for (i = 0; i < istate->cache_nr; i++) {
+		const struct cache_entry *ce = istate->cache[i];
 		if (ce_stage(ce)) {
 			if (silent)
 				return -1;
@@ -180,13 +179,13 @@ static int verify_cache(struct cache_entry **cache,
 	 * stage 0 entries.
 	 */
 	funny = 0;
-	for (i = 0; i < entries - 1; i++) {
+	for (i = 0; i + 1 < istate->cache_nr; i++) {
 		/* path/file always comes after path because of the way
 		 * the cache is sorted.  Also path can appear only once,
 		 * which means conflicting one would immediately follow.
 		 */
-		const struct cache_entry *this_ce = cache[i];
-		const struct cache_entry *next_ce = cache[i + 1];
+		const struct cache_entry *this_ce = istate->cache[i];
+		const struct cache_entry *next_ce = istate->cache[i + 1];
 		const char *this_name = this_ce->name;
 		const char *next_name = next_ce->name;
 		int this_len = ce_namelen(this_ce);
@@ -438,7 +437,7 @@ int cache_tree_update(struct index_state *istate, int flags)
 {
 	int skip, i;
 
-	i = verify_cache(istate->cache, istate->cache_nr, flags);
+	i = verify_cache(istate, flags);
 
 	if (i)
 		return i;
-- 
gitgitgadget

