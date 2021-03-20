Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D96C433E4
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 22:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2406B61935
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 22:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhCTWil (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 18:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhCTWiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 18:38:16 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBF6C061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 15:38:16 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e9so12756715wrw.10
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 15:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t0ENW6XsIibWSiV1sjw5lieszxwXektVEGr49xearz8=;
        b=MlOFjYu6yKFJ5JxvEEzmdq8fhBpcLMV5iqooFqam6jGZd7GaJIkTraZFLQBA1/RqK5
         e8EIp2drMxISJJtqedj62xHimeTr2aL0MtV2Na0IEyz3J4TsBhEDWmLWseemRTZuEQdK
         0NClYdo/yTnWTa/L4sV+sBJlAnV0Vo1B8JvyLuNV/A8Dd7wgFiwwBO6Hm/UO2HQelKhH
         Ra1I8HCZYRhWW/lDfDFIDJsA1/5yUucAAICCwmZySCThZvbH4XWeqHnCwIntfsfQFDKX
         APXWLQyfTCeUq4chVhb8YgPYz3nTJSh2a8wVA2O1XzbWR/goRJH2kTNOyjiAu3H7JdoJ
         zAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t0ENW6XsIibWSiV1sjw5lieszxwXektVEGr49xearz8=;
        b=ltvVgefpZVThHrbN1RoXuZDyTKPE7SBBJ88OM70JeDVImuCaHCFbey5eJ72108D/5V
         V7/cjMB51lmgfWHMwJCJH84M3+4OAvMzdTyZbQ9asiGBHP3nJRDMvQTohNFD7xmyU8tL
         dar8Pt3VyWekqt3ToVmWkkyRMVSEQeygWfbGPwW7YJwCEQNj+GLrztoPAHBlA3mtUqQX
         yAl2PGoDI9lSf9+jv9rMGebf30S2Y1YuZNGGkDVQU9l0ePT3tunOopMGE240F9Afp5dX
         2aJ+vGy6zugiHIJeaAEmldmte036QJdb+wVchp7D7JxJ7daSu3p6w7WYOiF90ToQV1Qr
         TpHQ==
X-Gm-Message-State: AOAM531vGjan9qlO2Qrsir8TxkmQTiOV57fVHwiQf1qhO6E9OJO5eR2A
        FYPQuy6vqRnpavmN/xO9x5Sy6WQHosl2BQ==
X-Google-Smtp-Source: ABdhPJzmud+Z8KErj9HJd26C0wlymG7bjS5icYP+83dDTDrH/fHVhBvk4KV3zeXTZXeebSyaiA5m4w==
X-Received: by 2002:a5d:534e:: with SMTP id t14mr10837613wrv.202.1616279894983;
        Sat, 20 Mar 2021 15:38:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v2sm21472697wmj.1.2021.03.20.15.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 15:38:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 5/8] ls-files: refactor away read_tree()
Date:   Sat, 20 Mar 2021 23:37:48 +0100
Message-Id: <30c3abfe9b9af8202fb69bb67267cbbd5d09b60a.1616279653.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.286.gc175f2cb894
In-Reply-To: <cover.1616279653.git.avarab@gmail.com>
References: <xmqqpmzxy939.fsf@gitster.g> <cover.1616279653.git.avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor away the read_tree() function into its only user,
overlay_tree_on_index().

First, change read_one_entry_opt() to use the strbuf parameter
read_tree_recursive() passes down in place. This finishes up a partial
refactoring started in 6a0b0b6de99 (tree.c: update read_tree_recursive
callback to pass strbuf as base, 2014-11-30).

Moving the rest into overlay_tree_on_index() makes this index juggling
we're doing easier to read.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-files.c | 77 ++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 43 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 3149a2769a3..aa153423b80 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -423,7 +423,7 @@ static int get_common_prefix_len(const char *common_prefix)
 
 static int read_one_entry_opt(struct index_state *istate,
 			      const struct object_id *oid,
-			      const char *base, int baselen,
+			      struct strbuf *base,
 			      const char *pathname,
 			      unsigned mode, int opt)
 {
@@ -434,13 +434,13 @@ static int read_one_entry_opt(struct index_state *istate,
 		return READ_TREE_RECURSIVE;
 
 	len = strlen(pathname);
-	ce = make_empty_cache_entry(istate, baselen + len);
+	ce = make_empty_cache_entry(istate, base->len + len);
 
 	ce->ce_mode = create_ce_mode(mode);
 	ce->ce_flags = create_ce_flags(1);
-	ce->ce_namelen = baselen + len;
-	memcpy(ce->name, base, baselen);
-	memcpy(ce->name + baselen, pathname, len+1);
+	ce->ce_namelen = base->len + len;
+	memcpy(ce->name, base->buf, base->len);
+	memcpy(ce->name + base->len, pathname, len+1);
 	oidcpy(&ce->oid, oid);
 	return add_index_entry(istate, ce, opt);
 }
@@ -450,7 +450,7 @@ static int read_one_entry(const struct object_id *oid, struct strbuf *base,
 			  void *context)
 {
 	struct index_state *istate = context;
-	return read_one_entry_opt(istate, oid, base->buf, base->len, pathname,
+	return read_one_entry_opt(istate, oid, base, pathname,
 				  mode,
 				  ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
 }
@@ -464,42 +464,8 @@ static int read_one_entry_quick(const struct object_id *oid, struct strbuf *base
 				void *context)
 {
 	struct index_state *istate = context;
-	return read_one_entry_opt(istate, oid, base->buf, base->len, pathname,
-				  mode,
-				  ADD_CACHE_JUST_APPEND);
-}
-
-
-static int read_tree(struct repository *r, struct tree *tree,
-		     struct pathspec *match, struct index_state *istate)
-{
-	read_tree_fn_t fn = NULL;
-	int i, err;
-
-
-	/*
-	 * See if we have cache entry at the stage.  If so,
-	 * do it the original slow way, otherwise, append and then
-	 * sort at the end.
-	 */
-	for (i = 0; !fn && i < istate->cache_nr; i++) {
-		const struct cache_entry *ce = istate->cache[i];
-		if (ce_stage(ce) == 1)
-			fn = read_one_entry;
-	}
-
-	if (!fn)
-		fn = read_one_entry_quick;
-	err = read_tree_recursive(r, tree, "", 0, 0, match, fn, istate);
-	if (fn == read_one_entry || err)
-		return err;
-
-	/*
-	 * Sort the cache entry -- we need to nuke the cache tree, though.
-	 */
-	cache_tree_free(&istate->cache_tree);
-	QSORT(istate->cache, istate->cache_nr, cmp_cache_name_compare);
-	return 0;
+	return read_one_entry_opt(istate, oid, base, pathname,
+				  mode, ADD_CACHE_JUST_APPEND);
 }
 
 /*
@@ -518,6 +484,8 @@ void overlay_tree_on_index(struct index_state *istate,
 	struct pathspec pathspec;
 	struct cache_entry *last_stage0 = NULL;
 	int i;
+	read_tree_fn_t fn = NULL;
+	int err;
 
 	if (get_oid(tree_name, &oid))
 		die("tree-ish %s not found.", tree_name);
@@ -540,9 +508,32 @@ void overlay_tree_on_index(struct index_state *istate,
 			       PATHSPEC_PREFER_CWD, prefix, matchbuf);
 	} else
 		memset(&pathspec, 0, sizeof(pathspec));
-	if (read_tree(the_repository, tree, &pathspec, istate))
+
+	/*
+	 * See if we have cache entry at the stage.  If so,
+	 * do it the original slow way, otherwise, append and then
+	 * sort at the end.
+	 */
+	for (i = 0; !fn && i < istate->cache_nr; i++) {
+		const struct cache_entry *ce = istate->cache[i];
+		if (ce_stage(ce) == 1)
+			fn = read_one_entry;
+	}
+
+	if (!fn)
+		fn = read_one_entry_quick;
+	err = read_tree_recursive(the_repository, tree, "", 0, 1, &pathspec, fn, istate);
+	if (err)
 		die("unable to read tree entries %s", tree_name);
 
+	/*
+	 * Sort the cache entry -- we need to nuke the cache tree, though.
+	 */
+	if (fn == read_one_entry_quick) {
+		cache_tree_free(&istate->cache_tree);
+		QSORT(istate->cache, istate->cache_nr, cmp_cache_name_compare);
+	}
+
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 		switch (ce_stage(ce)) {
-- 
2.31.0.286.gc175f2cb894

