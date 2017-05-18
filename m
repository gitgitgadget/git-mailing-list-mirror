Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49309201CF
	for <e@80x24.org>; Thu, 18 May 2017 23:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754743AbdERXWb (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 19:22:31 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35871 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932637AbdERXW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 19:22:28 -0400
Received: by mail-pg0-f43.google.com with SMTP id x64so29455026pgd.3
        for <git@vger.kernel.org>; Thu, 18 May 2017 16:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nRC3hJoNOnjl4xBYy9RjOhqXEO33gnbg5rP7a4twRCo=;
        b=EsEXJMClkANbeFCgG8XjXgf9r27lKAzjqVFgyhvq2gb2HQuYOE6MVk8pnabZ4hwhRw
         xFSN2y/2LpbaFJnRA5niU2CKzJTbCjSk3SEaBb4K716EXo37uCQZMaMiRKZeHwE2cWTg
         adQQVl+CyMb/HyvSCZ413UfvgLjDyoQHITouDC4eYhC5Ia9wATzTIHDEbYl+jntgCmMl
         NMnX8EgNe8EZw3LCvjMPXUCpY/PBpRX+ZMP47Edil9LEwP3iQEazDRHo3u9BxIM2NjUb
         rpDq5o5Q0Y9upCjQRz9xJaowF9rrnVQ7yuBlZi0qUTUZI/UkuMCfz23IAUJ0sYD2E7+U
         9v1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nRC3hJoNOnjl4xBYy9RjOhqXEO33gnbg5rP7a4twRCo=;
        b=PiHljs35pf/c/rgt6u/G2upRalkUQD3xAfTYzP+s6USOUTMfANXAWc8mFlDwMufgXh
         JWthvf38MzvgxQp0q2lH+cfsnNUt42cuaimWF4TT8j9HIWsfA6C5k1B8dfkZaD/2cYcD
         kKvRJAhPQlFm7upX5CF+cqVYk5OiHJFRObLXAQCvmengUbFGsf9B7ZlhCS9hJKJ9Wx9Q
         D7bP9SWqaeLk1iKHjBZYrHJnrr3xwpFF91god4hgZZ5BCW/vUtnnJMq6cJTIuHZARwtg
         olJ2hN1TUvpGUl5kZhbFYGji4QaRU9EFh07/MFtvCY8YtIhAUK8UfXzbudP1hW0ydGKR
         1TFQ==
X-Gm-Message-State: AODbwcDP1vghs0WqxXWbIXe5ZRXzvSbeYHCyqB5LrIYtxjfLCjk7fVUo
        AjPIJ/GEuTxvn++x
X-Received: by 10.84.231.16 with SMTP id f16mr7930035plk.20.1495149747593;
        Thu, 18 May 2017 16:22:27 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d3sm12579575pfg.30.2017.05.18.16.22.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 May 2017 16:22:26 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, jrnieder@gmail.com, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [WIP/RFC 14/23] ls-files: convert show_files to take an index
Date:   Thu, 18 May 2017 16:21:25 -0700
Message-Id: <20170518232134.163059-15-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169-goog
In-Reply-To: <20170518232134.163059-1-bmwill@google.com>
References: <20170518232134.163059-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 8448b04e8..56fd6644f 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -328,7 +328,7 @@ static int ce_excluded(struct dir_struct *dir, struct index_state *istate,
 	return is_excluded(dir, istate, ce->name, &dtype);
 }
 
-static void show_files(struct dir_struct *dir)
+static void show_files(struct index_state *istate, struct dir_struct *dir)
 {
 	int i;
 
@@ -336,17 +336,17 @@ static void show_files(struct dir_struct *dir)
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
@@ -357,12 +357,12 @@ static void show_files(struct dir_struct *dir)
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
@@ -371,7 +371,7 @@ static void show_files(struct dir_struct *dir)
 			err = lstat(ce->name, &st);
 			if (show_deleted && err)
 				show_ce_entry(tag_removed, ce);
-			if (show_modified && ce_modified(ce, &st, 0))
+			if (show_modified && ie_modified(istate, ce, &st, 0))
 				show_ce_entry(tag_modified, ce);
 		}
 	}
@@ -685,7 +685,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			die("ls-files --with-tree is incompatible with -s or -u");
 		overlay_tree_on_index(&the_index, with_tree, max_prefix);
 	}
-	show_files(&dir);
+	show_files(&the_index, &dir);
 	if (show_resolve_undo)
 		show_ru_info(&the_index);
 
-- 
2.13.0.303.g4ebf302169-goog

