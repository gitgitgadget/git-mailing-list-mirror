Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9621C388F9
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59F1820796
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDhVsjPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgJ3Dmo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 23:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgJ3Dmf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 23:42:35 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE78C0613DD
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:56 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id k27so5356122oij.11
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qOJxQ7Gp9vO6NQOwsHIkhlAXSJ9DFR4iru5x8tMjHYs=;
        b=sDhVsjPS42SzsUZh5C0RsnOjqrXIIJirnjRk5ycA+Pf7MDM5Zf69wEWjnFo7v4MPtI
         nZR6SgxSDL1flAlXg7EPv9+1n0rpMC5fAjai3mWX3XgCSLrls701fwOAG7Etwn8CdqPr
         fUxFnLYVqWa0A4TVVO5mBQWRQGm6vCS7Ikn9HyvjC0Zow4pgcyMx72/0V/bsHVZGlfPu
         Oy/pbRFxJpYVUlQfoDJ0bV+xkVF1f9UOm+hWHA684oG/b8lBZF5RN0x1E6u9/Qg68FUs
         KvfmfcUGUaSmezxufmzjJ6dpPpMD+Eung28st4Rn36Dsi8ccEjk6Wu6CqQlW6ZwQjb+B
         r9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qOJxQ7Gp9vO6NQOwsHIkhlAXSJ9DFR4iru5x8tMjHYs=;
        b=rKxk8S6Cok04Xo8CwaR4hxJB8ETULclMoFzTmlNsntPkeC9ow+cG6G2Au/NtF5oMlz
         x+MWfzY97Wz5xfs1/NlaQMTOra5qzjkT47daul6wwGPeFZBWHldtXjGPZdLwX4mj+3yo
         qbZxCrEsp/0z2GxNPstkulf040ZoYutquWvbFGdglx2pMc3IeLkGyXkzsOQUuacbdnq5
         HGKGeQbvqo4NuNE9N4lN6QOIovNkjoTn3BAzc/4Qb94OuiFQlK2JeAovAIrMU7eAkaiO
         52JuXgNeaxqu2mf4KFSRW2w0Abj5uWQ5woLXncJixItcoUf4gvGmAND+qhDXSsEA/FJI
         u6WQ==
X-Gm-Message-State: AOAM532MdLu5vmZSOQEKXOBjLe16IHwkLhqme8KSU9GfQ7Nx1GFOOW7O
        6YhuOrvTj5a5wKwylKICAS7EdDkZa/HNgw==
X-Google-Smtp-Source: ABdhPJyH1WjV9BnSNOsQCLSBGPaO9+aTipT2BolIjLYwsURSMtd9qMdpNCvHGrCWG2p3O2exIn5V3A==
X-Received: by 2002:aca:df0a:: with SMTP id w10mr263084oig.118.1604029315324;
        Thu, 29 Oct 2020 20:41:55 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id x13sm1047063otg.66.2020.10.29.20.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 20:41:54 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 12/20] merge-ort: have process_entries operate in a defined order
Date:   Thu, 29 Oct 2020 20:41:23 -0700
Message-Id: <20201030034131.1479968-13-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.56.ga287c268e6.dirty
In-Reply-To: <20201030034131.1479968-1-newren@gmail.com>
References: <20201030034131.1479968-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We want to handle paths below a directory before needing to handle the
directory itself.  Also, we want to handle the directory immediately
after the paths below it, so we can't use simple lexicographic ordering
from strcmp (which would insert foo.txt between foo and foo/file.c).
Copy string_list_df_name_compare() from merge-recursive.c, and set up a
string list of paths sorted by that function so that we can iterate in
the desired order.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index f4bf1baf78..31c16edd3d 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -324,6 +324,33 @@ static int detect_and_process_renames(struct merge_options *opt,
 	return clean;
 }
 
+static int string_list_df_name_compare(const char *one, const char *two)
+{
+	int onelen = strlen(one);
+	int twolen = strlen(two);
+	/*
+	 * Here we only care that entries for D/F conflicts are
+	 * adjacent, in particular with the file of the D/F conflict
+	 * appearing before files below the corresponding directory.
+	 * The order of the rest of the list is irrelevant for us.
+	 *
+	 * To achieve this, we sort with df_name_compare and provide
+	 * the mode S_IFDIR so that D/F conflicts will sort correctly.
+	 * We use the mode S_IFDIR for everything else for simplicity,
+	 * since in other cases any changes in their order due to
+	 * sorting cause no problems for us.
+	 */
+	int cmp = df_name_compare(one, onelen, S_IFDIR,
+				  two, twolen, S_IFDIR);
+	/*
+	 * Now that 'foo' and 'foo/bar' compare equal, we have to make sure
+	 * that 'foo' comes before 'foo/bar'.
+	 */
+	if (cmp)
+		return cmp;
+	return onelen - twolen;
+}
+
 /* Per entry merge function */
 static void process_entry(struct merge_options *opt,
 			  const char *path,
@@ -414,23 +441,41 @@ static void process_entries(struct merge_options *opt,
 {
 	struct hashmap_iter iter;
 	struct strmap_entry *e;
+	struct string_list plist = STRING_LIST_INIT_NODUP;
+	struct string_list_item *entry;
 
 	if (strmap_empty(&opt->priv->paths)) {
 		oidcpy(result_oid, opt->repo->hash_algo->empty_tree);
 		return;
 	}
 
+	/* Hack to pre-allocate plist to the desired size */
+	ALLOC_GROW(plist.items, strmap_get_size(&opt->priv->paths), plist.alloc);
+
+	/* Put every entry from paths into plist, then sort */
 	strmap_for_each_entry(&opt->priv->paths, &iter, e) {
+		string_list_append(&plist, e->key)->util = e->value;
+	}
+	plist.cmp = string_list_df_name_compare;
+	string_list_sort(&plist);
+
+	/*
+	 * Iterate over the items in reverse order, so we can handle paths
+	 * below a directory before needing to handle the directory itself.
+	 */
+	for (entry = &plist.items[plist.nr-1]; entry >= plist.items; --entry) {
+		char *path = entry->string;
 		/*
 		 * WARNING: If ci->merged.clean is true, then ci does not
 		 * actually point to a conflict_info but a struct merge_info.
 		 */
-		struct conflict_info *ci = e->value;
+		struct conflict_info *ci = entry->util;
 
 		if (!ci->merged.clean)
-			process_entry(opt, e->key, e->value);
+			process_entry(opt, path, ci);
 	}
 
+	string_list_clear(&plist, 0);
 	die("Tree creation not yet implemented");
 }
 
-- 
2.29.1.56.ga287c268e6.dirty

