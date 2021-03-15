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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86465C43381
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 23:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63BB564F5F
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 23:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbhCOXoK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 19:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhCOXoF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 19:44:05 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095A3C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 16:44:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id y16so9574034wrw.3
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 16:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qu/MeerlVw8UocVidkpG/iFWarasxUfOP3gU1GtYLtQ=;
        b=HK+mI/FLXpKxRdC34NfTVSdjULgpRDvggwk9QKiiwWW7qyniLq+1Bn6OcxNdJI0q9+
         3n3eS2xROZ01IPn1SwhvXOiH03rLx1+i99CF7SNw+BKBILXSSny5BZ9K8VbeCdtfywUQ
         TYeGNiX8AZ2NZ+TqMSMJ8BIUj9I8cIoxn5lfpeJAvXSX9N1qmyljzVcF2Vg8y+u9Djka
         XE5xp26xhLJBES/JMG3IqGP/FBOJiaIuoHZfY4yUVAANrKsmIbDhHsXl/srE7KLEnMPW
         PnKp5SJvvOnik+TszIu6eS0IRFtHuvRWVoVbhUnGZWWOjlek5bbweLV1Wflafc/5TfrA
         702Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qu/MeerlVw8UocVidkpG/iFWarasxUfOP3gU1GtYLtQ=;
        b=mdv2GsCZ/+DQELr7uE4cYf5qBQH7B6Llb0nEtFOyWLalsQFUVy8f7/2zOj5Zffe2AK
         vZ34SyT0ak3si00c+nc/epIaN3HT5wtuECCXHH7kfgaW/DUULw77iwNXORxG3MwDZLpM
         0zWI8ik/gpT3nQQ+aoEXvnNzI7ESQeCD+U4m7d7t8j/6+O1Uygv4JreRDR5PYdqhs01v
         VaXdUfdQxQdFs2LTRRmAZ5zQk90AKtqu5cVjx8nI8n4sq63/M/585RTyNCam9HoaPK0h
         vRSdkc0eQvxBXu8pYUSiGPviUu3cVy3dJ7sWeFPEagtr/c992/3X6l/BD6nk3+9w5tKo
         59xQ==
X-Gm-Message-State: AOAM532KXUvS/udGq31jPyDqZU9y6vKG2D7Hrc2GAlC9nPOzCQfoMA4j
        SkxE2f+auKmrhm+i1FmOWz/tTResiubDkg==
X-Google-Smtp-Source: ABdhPJzT+VtWq4pTuo58EMl+ZS/f0HFVcuhurjfE9SjSVKMeJbMpRaj2+W3+Xs9c/GSn6tqPknB7fg==
X-Received: by 2002:adf:c40b:: with SMTP id v11mr1880569wrf.320.1615851843540;
        Mon, 15 Mar 2021 16:44:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z7sm20417268wrt.70.2021.03.15.16.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 16:44:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/9] ls-files: refactor away read_tree()
Date:   Tue, 16 Mar 2021 00:43:39 +0100
Message-Id: <20210315234344.28427-5-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
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
 builtin/ls-files.c | 74 +++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 41 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 74d572a3e4a..db53e2c8e6d 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -423,7 +423,7 @@ static int get_common_prefix_len(const char *common_prefix)
 
 static int read_one_entry_opt(struct index_state *istate,
 			      const struct object_id *oid,
-			      const char *base, int baselen,
+			      struct strbuf *base,
 			      const char *pathname,
 			      unsigned mode, int stage, int opt)
 {
@@ -434,13 +434,13 @@ static int read_one_entry_opt(struct index_state *istate,
 		return READ_TREE_RECURSIVE;
 
 	len = strlen(pathname);
-	ce = make_empty_cache_entry(istate, baselen + len);
+	ce = make_empty_cache_entry(istate, base->len + len);
 
 	ce->ce_mode = create_ce_mode(mode);
 	ce->ce_flags = create_ce_flags(stage);
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
 				  mode, stage,
 				  ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
 }
@@ -464,44 +464,11 @@ static int read_one_entry_quick(const struct object_id *oid, struct strbuf *base
 				void *context)
 {
 	struct index_state *istate = context;
-	return read_one_entry_opt(istate, oid, base->buf, base->len, pathname,
+	return read_one_entry_opt(istate, oid, base, pathname,
 				  mode, stage,
 				  ADD_CACHE_JUST_APPEND);
 }
 
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
-	err = read_tree_recursive(r, tree, "", 0, 1, match, fn, istate);
-	if (fn == read_one_entry || err)
-		return err;
-
-	/*
-	 * Sort the cache entry -- we need to nuke the cache tree, though.
-	 */
-	cache_tree_free(&istate->cache_tree);
-	QSORT(istate->cache, istate->cache_nr, cmp_cache_name_compare);
-	return 0;
-}
-
 /*
  * Read the tree specified with --with-tree option
  * (typically, HEAD) into stage #1 and then
@@ -518,6 +485,8 @@ void overlay_tree_on_index(struct index_state *istate,
 	struct pathspec pathspec;
 	struct cache_entry *last_stage0 = NULL;
 	int i;
+	read_tree_fn_t fn = NULL;
+	int err;
 
 	if (get_oid(tree_name, &oid))
 		die("tree-ish %s not found.", tree_name);
@@ -540,9 +509,32 @@ void overlay_tree_on_index(struct index_state *istate,
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
2.31.0.rc2.211.g1d0b8788b3

