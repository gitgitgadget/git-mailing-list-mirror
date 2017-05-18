Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F067201CF
	for <e@80x24.org>; Thu, 18 May 2017 23:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932648AbdERXWo (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 19:22:44 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34310 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754505AbdERXWX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 19:22:23 -0400
Received: by mail-pg0-f44.google.com with SMTP id u28so29536333pgn.1
        for <git@vger.kernel.org>; Thu, 18 May 2017 16:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YasWvcyx714sqzPLmMj88UEkghr12xgGkS+u3MCb6g0=;
        b=gyibPPQnEhm4IEncyNiTKN8DVIyyzgs350Ag0XymPnTy5eMlvhEOqJlljrVrjOkh1K
         PX8riKtrCt0M5hB95e1qGd1bxQdkmfT3Wxj3aqwGvfI6+GL0xzjFR0AoGQLmuW/f+GgS
         nWQwrVPa8FzT0Y2K9EglLcNs/jE/SEjqT9WEFf8ZUiBEgCdz2VAhS2aFZ65B5U7AeN6N
         ArS1NwdhomvVZqdzDdhKPtu9DeXz4CRbVtQpHboBkbqAY/27Gs5zzHJCFe2edWJLwP0i
         KGGpGEUyVCDSN8YMOzdcf1RNW0OLr9qPSLUXwXjnYqZKiyYiXGTZGndOzhdGFHJet3Ih
         ktOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YasWvcyx714sqzPLmMj88UEkghr12xgGkS+u3MCb6g0=;
        b=KyxklPwZy98WGsrMPQ8JlZH/0AV42HbXaK3SV15Q5OG2bT/jJUzLuFdInYvsl/WekX
         1LIiD2cJiV81LJUfV1Ak/vVLVnY4j/bd6YgZmeaKFUccunTSLzZi0GgKixrk1tFpGyHu
         LR8VzeIGFrU7mMvlCfhQV9SAYtLKaZEnTUAORR41S41UrGd+z+ZGtHNu9d8ceIVKZ2Xt
         0GrBYALNpz7rIkTPSsnscTrqNoJtzzdRhWugO3S2NvQtWh28Mf+1Hu2j3HaqBs2GaEvz
         YV5dqj3KWSCPYC2DIsCK4XHyxeqI3xFsqv9FqkVRs6uMSz7+Ky+I/j3DiLqMrxIIiV3H
         So3g==
X-Gm-Message-State: AODbwcAMBg3I0nXxhH167H5w9meJwWQBQ0VNT2KIi7SHV0lFRQfM5gL+
        deMh2/1R3ei5oc07
X-Received: by 10.84.171.195 with SMTP id l61mr7660305plb.147.1495149737621;
        Thu, 18 May 2017 16:22:17 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d3sm12579575pfg.30.2017.05.18.16.22.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 May 2017 16:22:16 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, jrnieder@gmail.com, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [WIP/RFC 07/23] ls-files: convert overlay_tree_on_cache to take an index
Date:   Thu, 18 May 2017 16:21:18 -0700
Message-Id: <20170518232134.163059-8-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169-goog
In-Reply-To: <20170518232134.163059-1-bmwill@google.com>
References: <20170518232134.163059-1-bmwill@google.com>
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
index 1d805f5da..38993bd24 100644
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
index a4ced5a9c..7d306f418 100644
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
 	unsigned char sha1[20];
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
index e1f0e182a..175e58f01 100644
--- a/cache.h
+++ b/cache.h
@@ -2179,7 +2179,8 @@ extern int ws_blank_line(const char *line, int len, unsigned ws_rule);
 #define ws_tab_width(rule)     ((rule) & WS_TAB_WIDTH_MASK)
 
 /* ls-files */
-void overlay_tree_on_cache(const char *tree_name, const char *prefix);
+void overlay_tree_on_index(struct index_state *istate,
+			   const char *tree_name, const char *prefix);
 
 char *alias_lookup(const char *alias);
 int split_cmdline(char *cmdline, const char ***argv);
-- 
2.13.0.303.g4ebf302169-goog

