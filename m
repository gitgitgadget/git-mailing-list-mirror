Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7691720401
	for <e@80x24.org>; Mon, 12 Jun 2017 22:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752789AbdFLWOc (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 18:14:32 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:32919 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752661AbdFLWOa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 18:14:30 -0400
Received: by mail-pg0-f51.google.com with SMTP id f185so50814107pgc.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 15:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xJxeCWW2von9h720qlRG+xjwuoWUB0MQt0tYYfRs85Y=;
        b=NEiALGpXsiKL4DSPGZTyZzbbta0ZS8IhT4ZtYy8nSeuALA7wH1EeU2qMyYsD0l6qr6
         CjkTgtOv3kMjzcbn0RaNn/PTSs7c0udcG35LND2mL7wcMJ9YwWnz9snw1Z+OAKFqbmwH
         jmbLct9ftS20FCVy9Yn9M4Sk+P9dVbGaPhYxAS6HTAmBo9BZ2RDk92AbLHkANHI0bGTF
         3RrfteK473Wfa84lxZpASLUKBrQxEMcr4oiS6y2StGY8h2i2jYLSzs6RH1fHJJS95EV7
         a2TkdhTNbjR5fdUTPITQr/aCM/Wx5b29xXVspoZ0M9BTUNVEcoRTxaK8EAmIs6LXkmdi
         4Rfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xJxeCWW2von9h720qlRG+xjwuoWUB0MQt0tYYfRs85Y=;
        b=Pv/oxYH1wpl/hK4QRvcNOuiM+5VDoLAcjMilH41SlwqrMaUmmLCh2lsgpK6VdrsDNs
         tSUiL8nOL5RHLbWdZiqGcQXAJoUuh9nHGugfmolji9m9uLFXE8NNNtgMYmlqmKjsLNfI
         qoS5fBJKPrEKkgGx9IsARPEUjf52d4Ga9E2zAKvFvSsNmfxS2rFsOeoAAhP4NQ5jFQvN
         rqwFzrQlweP19F4kqB/a6kQqrC6pE7JSxkvcEVxCV6SDXvMKOvEZmbKmr9Jy1Pfxqx6y
         T3vO0G7/HRGJrGTJ+VDficLZYX3poT+piGCfe1VEtO6pmvv7KEdpYAh2OUOfno5mHDqP
         w7VA==
X-Gm-Message-State: AKS2vOzBwh1jY6bvNBjt8+YxlpMWWKG+k7BCs+3FcbTmt0GSNj1IKh7F
        3qxjhVvft1XoAbEOfn+D/Q==
X-Received: by 10.98.156.131 with SMTP id u3mr9809716pfk.16.1497305668651;
        Mon, 12 Jun 2017 15:14:28 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id i68sm22403884pfi.72.2017.06.12.15.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 15:14:27 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 07/17] ls-files: convert overlay_tree_on_cache to take an index
Date:   Mon, 12 Jun 2017 15:13:58 -0700
Message-Id: <20170612221408.173876-8-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <20170612221408.173876-1-bmwill@google.com>
References: <20170612221408.173876-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/commit.c   |  3 ++-
 builtin/ls-files.c | 15 ++++++++-------
 cache.h            |  3 ++-
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index da1ba4c86..78ef319a2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -253,7 +253,8 @@ static int list_paths(struct string_list *list, const char *with_tree,
 
 	if (with_tree) {
 		char *max_prefix = common_prefix(pattern);
-		overlay_tree_on_cache(with_tree, max_prefix ? max_prefix : prefix);
+		overlay_tree_on_index(&the_index, with_tree,
+				      max_prefix ? max_prefix : prefix);
 		free(max_prefix);
 	}
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 93e46ab5f..a78b291ab 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -431,7 +431,8 @@ static int get_common_prefix_len(const char *common_prefix)
  * that were given from the command line.  We are not
  * going to write this index out.
  */
-void overlay_tree_on_cache(const char *tree_name, const char *prefix)
+void overlay_tree_on_index(struct index_state *istate,
+			   const char *tree_name, const char *prefix)
 {
 	struct tree *tree;
 	struct object_id oid;
@@ -446,8 +447,8 @@ void overlay_tree_on_cache(const char *tree_name, const char *prefix)
 		die("bad tree-ish %s", tree_name);
 
 	/* Hoist the unmerged entries up to stage #3 to make room */
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
 		if (!ce_stage(ce))
 			continue;
 		ce->ce_flags |= CE_STAGEMASK;
@@ -460,11 +461,11 @@ void overlay_tree_on_cache(const char *tree_name, const char *prefix)
 			       PATHSPEC_PREFER_CWD, prefix, matchbuf);
 	} else
 		memset(&pathspec, 0, sizeof(pathspec));
-	if (read_tree(tree, 1, &pathspec, &the_index))
+	if (read_tree(tree, 1, &pathspec, istate))
 		die("unable to read tree entries %s", tree_name);
 
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
 		switch (ce_stage(ce)) {
 		case 0:
 			last_stage0 = ce;
@@ -679,7 +680,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		 */
 		if (show_stage || show_unmerged)
 			die("ls-files --with-tree is incompatible with -s or -u");
-		overlay_tree_on_cache(with_tree, max_prefix);
+		overlay_tree_on_index(&the_index, with_tree, max_prefix);
 	}
 	show_files(&dir);
 	if (show_resolve_undo)
diff --git a/cache.h b/cache.h
index 4d92aae0e..5a0e0a9e5 100644
--- a/cache.h
+++ b/cache.h
@@ -2186,7 +2186,8 @@ extern int ws_blank_line(const char *line, int len, unsigned ws_rule);
 #define ws_tab_width(rule)     ((rule) & WS_TAB_WIDTH_MASK)
 
 /* ls-files */
-void overlay_tree_on_cache(const char *tree_name, const char *prefix);
+void overlay_tree_on_index(struct index_state *istate,
+			   const char *tree_name, const char *prefix);
 
 char *alias_lookup(const char *alias);
 int split_cmdline(char *cmdline, const char ***argv);
-- 
2.13.1.518.g3df882009-goog

