Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6278420401
	for <e@80x24.org>; Mon, 12 Jun 2017 22:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753032AbdFLWOy (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 18:14:54 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35618 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752997AbdFLWOt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 18:14:49 -0400
Received: by mail-pf0-f171.google.com with SMTP id l89so57297218pfi.2
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 15:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8SZW6gfH2jCWFMgZMwpGOoo8YYb0ly0AaAFoXQvyURU=;
        b=RgxVcMDbRclKFVzfOpFwinTWy6OfcOFLFuIb9E8W6pqEAdeoUPPbBwE9qajlGmIDA6
         z/7RfLuTTfdhGOF0Kk25npumftrf8TWWnCbZ/+q6KWYbFY55mkbYTlyS7ah+tQ+c+O00
         t8H8C8zMtbj8fyjIgYwL91wKAqyLgoawpZcRh/7EspK53dBdE2bzKT7QstYMYI+ofjTg
         vPowvQ2NdAejkFhHS0AeJRrYxAMI6bGM1e1aK1MhoU+fmWioljOaEQsHnHoOusx29bqP
         qTZlY/9c8pWOftlsbE4abQGFVIO+ICIkqcbeJwo/6Kjmc1zGAHlwk2cu1+KlKVgVREkb
         6wtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8SZW6gfH2jCWFMgZMwpGOoo8YYb0ly0AaAFoXQvyURU=;
        b=EGXmNBO9eIPNfG9USpQ6oa/EX/2EERYysqqsPrNyJdId/tdM7pXNxNocPHDmB7GVkx
         uQWit57NV2RACl9XFvFbHv/5nGhi0qgnUe1f9Ge835tMrX4JN4V1K24dVBMywBcTXUaa
         Ng9BXVxWdQY5iJlEsgTqefk6lfHzylVHaWW/X8KRaiINxAlcu/d55VIiWxIgd3tdlMZ7
         8chD/wsaaTguYbfj3qWsJIzwuElM+WE3NeQV7Tn1jPE9JUfi2ANVyyvyPlhkKzI/AYYE
         E+KWLcqD+rP791nKvPlxs4ykZnYvn8Uz5H7u7YAT/3nncSsMmjaCUOcD2hVOjeXZaQ3+
         mcFg==
X-Gm-Message-State: AODbwcAT4PLr0SOud9Rw/R5uhVgZzgS4pMQh77mMmuMRh9giRl4IVhDC
        PM3lIgs1EgHPaTFRsUTyhw==
X-Received: by 10.84.232.3 with SMTP id h3mr58656705plk.42.1497305682381;
        Mon, 12 Jun 2017 15:14:42 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id i68sm22403884pfi.72.2017.06.12.15.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 15:14:41 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 15/17] ls-files: convert show_files to take an index
Date:   Mon, 12 Jun 2017 15:14:06 -0700
Message-Id: <20170612221408.173876-16-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <20170612221408.173876-1-bmwill@google.com>
References: <20170612221408.173876-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 927aa6746..55d6f54fd 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -329,7 +329,7 @@ static int ce_excluded(struct dir_struct *dir, struct index_state *istate,
 	return is_excluded(dir, istate, ce->name, &dtype);
 }
 
-static void show_files(struct dir_struct *dir)
+static void show_files(struct index_state *istate, struct dir_struct *dir)
 {
 	int i;
 
@@ -337,33 +337,33 @@ static void show_files(struct dir_struct *dir)
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
 			if (ce->ce_flags & CE_UPDATE)
 				continue;
-			show_ce_entry(&the_index, ce_stage(ce) ? tag_unmerged :
+			show_ce_entry(istate, ce_stage(ce) ? tag_unmerged :
 				(ce_skip_worktree(ce) ? tag_skip_worktree : tag_cached), ce);
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
@@ -371,9 +371,9 @@ static void show_files(struct dir_struct *dir)
 				continue;
 			err = lstat(ce->name, &st);
 			if (show_deleted && err)
-				show_ce_entry(&the_index, tag_removed, ce);
-			if (show_modified && ce_modified(ce, &st, 0))
-				show_ce_entry(&the_index, tag_modified, ce);
+				show_ce_entry(istate, tag_removed, ce);
+			if (show_modified && ie_modified(istate, ce, &st, 0))
+				show_ce_entry(istate, tag_modified, ce);
 		}
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
2.13.1.518.g3df882009-goog

