Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED6561FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751221AbdEaVpN (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:45:13 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36041 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbdEaVpH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:45:07 -0400
Received: by mail-pf0-f181.google.com with SMTP id m17so18554139pfg.3
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9JDeBddcqPq8mRVQLpzebZBidFr86hhD08Wv49GVFFs=;
        b=d8/STwfb9BVBPmnl6zOHtM3VqW8O/bQlpCCillfSbLWXHmpHNAVY0Pp0kgKunYZ0OY
         /SzMrRurVKLVwZgt1uPsPJBPVL/fxkubhqCH6ir3r0BPoin43PkpOpT/xVoXhthrk3Y1
         HVEVlx39jRFH/QIKuW3jjFlzxbPAuMLqlad7zO/dz2NFug2oDjobpFTcdECWj9jBDoIU
         F5ke1D+CIPnn0ZqFM/jCv6CMvlw7Yf0wx55+iTa8ac/chqNvHSsKcCl6oFqzAmsBheH7
         9wzNQv4dkMNbjYpw5oip7gJWopkQlMHfbShJLSo5Ly6XsP4vTrKvs2G3Di1s+esUCU8J
         IApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9JDeBddcqPq8mRVQLpzebZBidFr86hhD08Wv49GVFFs=;
        b=p1MLPjia6DU0crBcBmQOnjvEjp/d1DqXvb/YHW8TMX4G81rby8ObBduopSTcOaE+/q
         ZTujxPWtAbtiQIkPRiTCla2Wd246znbkTtJIoluKmKvnjUZ0wfxJdc5qr351pIyfmC+B
         RQuKkjZfso303pTPCUizT2GXjN/6cMiiYAWaMw3L7dZkVRYhSeMqzDTUwmA+sMo0JjzI
         RxA3bMe2WB/D3h87kiiE0W04QuqR3tYR7lrd5rPQuRIU9AkpJjb0MsU/iRCbdtBsXN99
         sHUr9NXAMUf7O5u2bfympypX6frbx7CcSe0rm+hDeYJMyg4ZtrqpbrZiVHi0snwfo80a
         zTzg==
X-Gm-Message-State: AODbwcALZdxDM6VU+/p3QK/Gdpdr12smyWgyi75EwLjTpSY63zGKWdB6
        OL9wDwnu5VGlVt1o/LA6WQ==
X-Received: by 10.98.11.196 with SMTP id 65mr32610558pfl.110.1496267106298;
        Wed, 31 May 2017 14:45:06 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 187sm26952745pgj.66.2017.05.31.14.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:45:04 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 21/31] ls-files: convert overlay_tree_on_cache to take an index
Date:   Wed, 31 May 2017 14:44:07 -0700
Message-Id: <20170531214417.38857-22-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
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
2.13.0.506.g27d5fe0cd-goog

