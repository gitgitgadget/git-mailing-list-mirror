Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2B251FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 23:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbdFHXmP (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 19:42:15 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34488 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751721AbdFHXmK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 19:42:10 -0400
Received: by mail-pg0-f48.google.com with SMTP id v18so20716473pgb.1
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 16:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lXq66nD8oDIP512oPne8dQh8XlAtdTQ70SLBeBLRrNc=;
        b=qLyZhcSQTkNZ/SXOjVv4FkNJyTpbFRgf48yWWY1C/CT0iGSNdjOUylaS1gikl5THGP
         3SambTnqok0QDeks8v+urK1b22gJthrnNjYNLq1xXgMWIOLEvPq0o9e6VtQXm/SsGHF0
         VM+Kac2curFi/3s4mnH+WJWlBfg7eGOZF9LxZudJjQNKu9isJ9O5viyO4LjadRJR/pD5
         gytOHf/SKaRQBI0xLwuRszdQX5VglkZsr3g57n7EdGNZ9fK6676+wFpThhiz/hYTOYKh
         hJJ1vV0dXWQvWnQ3+ZH/kkaAwlt0LPtgdqgM3vhLkw/14sk+ZpZcqW+pSQGxnGvuGBve
         ckfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lXq66nD8oDIP512oPne8dQh8XlAtdTQ70SLBeBLRrNc=;
        b=LLNg/QTziyElL6y51Fg8LE/BLpg9+hpjKD9NFsLUXRRsxttP4ER9/lVCTPVy/1kY+S
         p5nOzP8VFRggclL6Lcg4+767MOWJDRUl3dNHLKktKW7oGP0kFZ26SoriU9xVFAWNJnIB
         BRZNKSlBFCLJwGmGr8etSSyuq6PUlubveDWxFFG4cp1CJ7qSggu/VF72sjCQLZ79XsqV
         8P3rLCTK0dbqNHBvbVMiidVmhjthTggbo35BPv45BlcxKxi1CXI2Ex/KUqWuHlmD3yzR
         BmRKRgg1Y48PCF1Eb9BceoP/IuQQojSkfy+5Plb8JkWGWkLM8i1iRbLLE9alTql4iojo
         7+5A==
X-Gm-Message-State: AODbwcDSagiS5zXYYcPGYyQ/rfiP8iGy/UcIt4Dd0C+Qf8avoP2Fj/3O
        UE1vlMMf9PoX738/Wu5L+Q==
X-Received: by 10.98.192.81 with SMTP id x78mr33551143pff.1.1496965323576;
        Thu, 08 Jun 2017 16:42:03 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m65sm11745237pfg.94.2017.06.08.16.42.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 16:42:02 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 29/32] ls-files: convert show_files to take an index
Date:   Thu,  8 Jun 2017 16:40:57 -0700
Message-Id: <20170608234100.188529-30-bmwill@google.com>
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
2.13.1.508.gb3defc5cc-goog

