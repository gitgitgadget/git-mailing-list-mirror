Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A3321FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbdEaVp1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:45:27 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34494 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751238AbdEaVpX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:45:23 -0400
Received: by mail-pf0-f174.google.com with SMTP id 9so18589688pfj.1
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QgEMNos161e/tuj7TenkPCxJNYAWA0T7Vvg/DfaTUjA=;
        b=lcmOOswbzVmQCWokorDJNrmPSP1F6HJKZfXbZP9G76UBPS7lAb1buRcREnX8vv3m2i
         Md8a2XgZTgGhvGzfz5t2noZYj+r9VdSxn9DL8iYmZkBM66WfpSD+2Y8GHhLTeBcAYSV2
         SqsD7SvE0lWs+MMbY2oO53DxXsgPp9hQAprU5Ws5Vjlt1JciebLai3bMjvyAxRpQ6J2Q
         nQjbYNjAxnJo5Mt6hk2pXCRcabGQSiCzL7KSkOySz9M0+XRuI1mLRhO/+jeTgSIzDgYc
         Hhl7jO7LX854ORK+5W0sgxuZ8ZSRMDcpNBR/iQsS41t5Jcau+651heNvt7FbdypxRP6n
         Cw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QgEMNos161e/tuj7TenkPCxJNYAWA0T7Vvg/DfaTUjA=;
        b=NfUtERoKijp548MBdWfjx4XDoDuYKNkq8K4THkUeiLl+9fnUtfv+Z1vnElKiF9Kher
         Sb7EPCVw2zORTzFz83PSWYqtbfQMYvAbVryBKr3PT1+OwvAFTTFh+rw1mhd/E+e8pUoy
         2TTK9bpAkCNcitb7yGnKsUPY36xk5ed2kKTTHuu4en6ZjUDYD7ZTaSJlM1WAn5mGbBde
         Otcbx26XpNeD1jAlqnMzGOiD2zSu4lxKVnDBFmLeq59bdiyxZ9BngcRcLlfCD2UZ53WT
         DXiz23OvJNfD9VS5wSxoguuxHtbalBW5lauXakD/tnRpwRTNkxRgPWqiLmeQMLiqsgLb
         n+5Q==
X-Gm-Message-State: AODbwcD5XBSthVgVxmmoN5NqJQJc37ahoNN1tyMsU3sSg0on6NQWWu6W
        rEgDuh185TjSBBXTFaiz8A==
X-Received: by 10.98.75.6 with SMTP id y6mr33305000pfa.157.1496267117535;
        Wed, 31 May 2017 14:45:17 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 187sm26952745pgj.66.2017.05.31.14.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:45:16 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 28/31] ls-files: convert show_files to take an index
Date:   Wed, 31 May 2017 14:44:14 -0700
Message-Id: <20170531214417.38857-29-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index e2d8fb7f6..3061af2c5 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -329,7 +329,7 @@ static int ce_excluded(struct dir_struct *dir, struct index_state *istate,
 	return is_excluded(dir, istate, ce->name, &dtype);
 }
 
-static void show_files(struct dir_struct *dir)
+static void show_files(struct index_state *istate, struct dir_struct *dir)
 {
 	int i;
 
@@ -337,17 +337,17 @@ static void show_files(struct dir_struct *dir)
 	if (show_others || show_killed) {
 		if (!show_others)
 			dir->flags |= DIR_COLLECT_KILLED_ONLY;
-		fill_directory(dir, &the_index, &pathspec);
+		fill_directory(dir, istate, &pathspec);
 		if (show_others)
-			show_other_files(&the_index, dir);
+			show_other_files(istate, dir);
 		if (show_killed)
-			show_killed_files(&the_index, dir);
+			show_killed_files(istate, dir);
 	}
 	if (show_cached || show_stage) {
-		for (i = 0; i < active_nr; i++) {
-			const struct cache_entry *ce = active_cache[i];
+		for (i = 0; i < istate->cache_nr; i++) {
+			const struct cache_entry *ce = istate->cache[i];
 			if ((dir->flags & DIR_SHOW_IGNORED) &&
-			    !ce_excluded(dir, &the_index, ce))
+			    !ce_excluded(dir, istate, ce))
 				continue;
 			if (show_unmerged && !ce_stage(ce))
 				continue;
@@ -358,12 +358,12 @@ static void show_files(struct dir_struct *dir)
 		}
 	}
 	if (show_deleted || show_modified) {
-		for (i = 0; i < active_nr; i++) {
-			const struct cache_entry *ce = active_cache[i];
+		for (i = 0; i < istate->cache_nr; i++) {
+			const struct cache_entry *ce = istate->cache[i];
 			struct stat st;
 			int err;
 			if ((dir->flags & DIR_SHOW_IGNORED) &&
-			    !ce_excluded(dir, &the_index, ce))
+			    !ce_excluded(dir, istate, ce))
 				continue;
 			if (ce->ce_flags & CE_UPDATE)
 				continue;
@@ -372,7 +372,7 @@ static void show_files(struct dir_struct *dir)
 			err = lstat(ce->name, &st);
 			if (show_deleted && err)
 				show_ce_entry(tag_removed, ce);
-			if (show_modified && ce_modified(ce, &st, 0))
+			if (show_modified && ie_modified(istate, ce, &st, 0))
 				show_ce_entry(tag_modified, ce);
 		}
 	}
@@ -686,7 +686,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			die("ls-files --with-tree is incompatible with -s or -u");
 		overlay_tree_on_index(&the_index, with_tree, max_prefix);
 	}
-	show_files(&dir);
+	show_files(&the_index, &dir);
 	if (show_resolve_undo)
 		show_ru_info(&the_index);
 
-- 
2.13.0.506.g27d5fe0cd-goog

