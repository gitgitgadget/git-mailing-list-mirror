Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 483601FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 23:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751705AbdFHXly (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 19:41:54 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35084 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751506AbdFHXlx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 19:41:53 -0400
Received: by mail-pf0-f176.google.com with SMTP id l89so22167733pfi.2
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 16:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lvMZ2NW0oL6zdhTkB3kgOodBdJwoHfyls/9CtOx9+OQ=;
        b=JoMw0vl23pzxSdZcsHk19Pfgh4fK2HemBjJ79mraPcPIaZ9izqcSUGpnnRwNEooEUh
         ZAtqzVtNB2zVy3EICIYjlfvFe+16RrMLnTTmWM4bEinN1EFQqWFViYf+HptzrcCQ0cLa
         2Uu2fs0FpcOXlFnhuEJqob3b9vP2CaNs103Su9U26UKN+cX7iA3TeX8IztzJze1xqzI5
         2BsR+HItIevPj3AfbqvS9XUy4TvAKeW4RIkDbk4vApO/85TLdAXohIOMA9YcGO5Ggygd
         noohJRVBLTaHkaKH0JERYHOyul26NKkJP1ySf4guFqNY7GemeiEwcjEuRvy+9gfXUgfy
         TVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lvMZ2NW0oL6zdhTkB3kgOodBdJwoHfyls/9CtOx9+OQ=;
        b=Z1KJFJ+6chGbwXSK2kdDqw+NzdIuawBZcP4gv52a5gqrsv5pui4ExhOu+fzRrUbuXV
         zgkWFwvSLTZlSHR1hfjZA5CpPsuIxxEHHEO8Jy5zyhFOPIDhsjBU3qwfO/UntiHIyUSJ
         TfXhMWMBJpHRYgmNBWCXebeDGJg6NISNXXdawjl1TW9sPKgLN63z8d+9Dm66vx7HADhl
         SKXfcw27uPQW8dFRyIAohB1eNvoNKSiSVaqBV18okvPCxTI6NV/YZaVS2zGHneb9gL/G
         i61oyOorABUEcipRjJDsiINYKfUBiN4fByMVJTlusenP7VlnxYser9JSPIyVlQPsO9i9
         iJ5g==
X-Gm-Message-State: AODbwcCkxCDNQa/KmKjgoZS0akh9Wgn/dLzQGyU6wC4OaFuwikqgRg1Q
        BcMVC8uaQw3t6/tDEFOrSg==
X-Received: by 10.98.110.138 with SMTP id j132mr38901998pfc.51.1496965311831;
        Thu, 08 Jun 2017 16:41:51 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m65sm11745237pfg.94.2017.06.08.16.41.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 16:41:50 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 22/32] ls-files: convert overlay_tree_on_cache to take an index
Date:   Thu,  8 Jun 2017 16:40:50 -0700
Message-Id: <20170608234100.188529-23-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc-goog
In-Reply-To: <20170608234100.188529-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
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
index 805da4915..3d98084fb 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -254,7 +254,8 @@ static int list_paths(struct string_list *list, const char *with_tree,
 
 	if (with_tree) {
 		char *max_prefix = common_prefix(pattern);
-		overlay_tree_on_cache(with_tree, max_prefix ? max_prefix : prefix);
+		overlay_tree_on_index(&the_index, with_tree,
+				      max_prefix ? max_prefix : prefix);
 		free(max_prefix);
 	}
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 620487a77..a5ceeb052 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -432,7 +432,8 @@ static int get_common_prefix_len(const char *common_prefix)
  * that were given from the command line.  We are not
  * going to write this index out.
  */
-void overlay_tree_on_cache(const char *tree_name, const char *prefix)
+void overlay_tree_on_index(struct index_state *istate,
+			   const char *tree_name, const char *prefix)
 {
 	struct tree *tree;
 	struct object_id oid;
@@ -447,8 +448,8 @@ void overlay_tree_on_cache(const char *tree_name, const char *prefix)
 		die("bad tree-ish %s", tree_name);
 
 	/* Hoist the unmerged entries up to stage #3 to make room */
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
 		if (!ce_stage(ce))
 			continue;
 		ce->ce_flags |= CE_STAGEMASK;
@@ -461,11 +462,11 @@ void overlay_tree_on_cache(const char *tree_name, const char *prefix)
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
@@ -680,7 +681,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		 */
 		if (show_stage || show_unmerged)
 			die("ls-files --with-tree is incompatible with -s or -u");
-		overlay_tree_on_cache(with_tree, max_prefix);
+		overlay_tree_on_index(&the_index, with_tree, max_prefix);
 	}
 	show_files(&dir);
 	if (show_resolve_undo)
diff --git a/cache.h b/cache.h
index 02ab5f801..73724a3ad 100644
--- a/cache.h
+++ b/cache.h
@@ -1993,7 +1993,8 @@ extern int ws_blank_line(const char *line, int len, unsigned ws_rule);
 #define ws_tab_width(rule)     ((rule) & WS_TAB_WIDTH_MASK)
 
 /* ls-files */
-void overlay_tree_on_cache(const char *tree_name, const char *prefix);
+void overlay_tree_on_index(struct index_state *istate,
+			   const char *tree_name, const char *prefix);
 
 char *alias_lookup(const char *alias);
 int split_cmdline(char *cmdline, const char ***argv);
-- 
2.13.1.508.gb3defc5cc-goog

