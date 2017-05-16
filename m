Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7838201A4
	for <e@80x24.org>; Tue, 16 May 2017 07:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751752AbdEPHgY (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 03:36:24 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34632 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751677AbdEPHgW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 03:36:22 -0400
Received: by mail-qt0-f193.google.com with SMTP id l39so19358586qtb.1
        for <git@vger.kernel.org>; Tue, 16 May 2017 00:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=tP+QSiGcPU5Ugz1SpDQ/AKNHhtMM3wV2cbSeRLJafd8=;
        b=D0jSHWFHiX5SgCrBX4uAMcWf94pLeeru5UtantWV+Xi1XR914+iGi6T2won25BbGrZ
         zrpvr0tsr7BqHtlS6roKxIMZNZAYoQIRfnnioNMrP9GBkKLm35pa/1iez/3T0uY8Pi2v
         tClFNMWe/z+TCVv7GkQ1qj87LDUspRL/BLXZNDMeuPdf5Eizn7II8pxTHb7sS76p2nhn
         QNEgxlxGXF63bhlfC5pZgrLLi4oUpUtxQqwYrZVtJ85cZjwe1sGstkuh/bxZp6QFBerB
         Qs05Sv+9LwSHJ3WgYtlHezu8TkBfausn9Gu6LqOCYlDBByuoSMxd7beIg5XOFKi2gpYi
         CDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=tP+QSiGcPU5Ugz1SpDQ/AKNHhtMM3wV2cbSeRLJafd8=;
        b=LXgJYcRwrAO+Nyk+Iau+FM/xdKeoSZbah/8QsMJSxz5yay43qrunVtZAlz2F/PDUP8
         P7MoVvxuuL6xf3s7E0U5fsuq+K5TE4e5WEKi/U8JO/VVhOdh+oHLJnFkC/39rDc+lX5V
         uDOAMJhN2lejXLRLUnGlLSdcQb3nw/CbYvBSEJgh5JgRq5AyNXs1JC9JTlqjUgHWGCmk
         +7NxbXdgGyiXI9i+Fx3Nz7DiZKY9mn1Yr/LE9ZNJwJP+UAFtwv/FniOMj2i9WDnK45cg
         +n6Z/q2FbDYc616N/bF4srHQPlOeBOodxN7cWfNlZrTkYnGRy8668EPnrrYjcYxi07NP
         SCCA==
X-Gm-Message-State: AODbwcD38GInJVW2LlspZHu+1rvyvXPNpvRVlLR1mGOK2pG9yvZGTHrI
        zYd10hvZX74gcCOQRXM=
X-Received: by 10.237.36.251 with SMTP id u56mr8527799qtc.154.1494920176176;
        Tue, 16 May 2017 00:36:16 -0700 (PDT)
Received: from localhost.localdomain (cpe-98-14-117-223.nyc.res.rr.com. [98.14.117.223])
        by smtp.gmail.com with ESMTPSA id i51sm10374103qte.28.2017.05.16.00.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 May 2017 00:36:15 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v3 6/8] clean: teach clean -d to skip dirs containing ignored files
Date:   Tue, 16 May 2017 03:34:21 -0400
Message-Id: <20170516073423.25762-7-sxlijin@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170516073423.25762-1-sxlijin@gmail.com>
References: <20170516073423.25762-1-sxlijin@gmail.com>
In-Reply-To: <20170505104611.17845-1-sxlijin@gmail.com>
References: <20170505104611.17845-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is an implicit assumption that a directory containing only
untracked and ignored files should itself be considered untracked. This
makes sense in use cases where we're asking if a directory should be
added to the git database, but not when we're asking if a directory can
be safely removed from the working tree; as a result, clean -d would
assume that an "untracked" directory containing ignored files could be
deleted.

To get around this, we teach clean -d to collect ignored files and skip
over so-called "untracked" directories if they contain any ignored
files (while still removing the untracked contents of such dirs).

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 builtin/clean.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index d861f836a..25f3efce5 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -859,7 +859,7 @@ static void interactive_main_loop(void)
 
 int cmd_clean(int argc, const char **argv, const char *prefix)
 {
-	int i, res;
+	int i, j, k, res;
 	int dry_run = 0, remove_directories = 0, quiet = 0, ignored = 0;
 	int ignored_only = 0, config_set = 0, errors = 0, gone = 1;
 	int rm_flags = REMOVE_DIR_KEEP_NESTED_GIT;
@@ -911,6 +911,9 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 				  " refusing to clean"));
 	}
 
+	if (remove_directories)
+		dir.flags |= DIR_SHOW_IGNORED_TOO | DIR_KEEP_UNTRACKED_CONTENTS;
+
 	if (force > 1)
 		rm_flags = 0;
 
@@ -932,7 +935,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 	fill_directory(&dir, &pathspec);
 
-	for (i = 0; i < dir.nr; i++) {
+	for (k = i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
 		int matches = 0;
 		struct stat st;
@@ -954,10 +957,35 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		    matches != MATCHED_EXACTLY)
 			continue;
 
+		// skip any dir.entries which contains a dir.ignored
+		for (; k < dir.ignored_nr; k++) {
+			if (cmp_dir_entry(&dir.entries[i],
+						&dir.ignored[k]) < 0)
+				break;
+		}
+		if ((k < dir.ignored_nr) &&
+				check_dir_entry_contains(dir.entries[i], dir.ignored[k])) {
+			continue;
+		}
+
+		// current entry does not contain any ignored files
 		rel = relative_path(ent->name, prefix, &buf);
 		string_list_append(&del_list, rel);
+
+		// skip untracked contents of an untracked dir
+		for (j = i + 1;
+			 j < dir.nr &&
+			     check_dir_entry_contains(dir.entries[i], dir.entries[j]);
+			 j++);
+		i = j - 1;
 	}
 
+	for (i = 0; i < dir.nr; i++)
+		free(dir.entries[i]);
+
+	for (i = 0; i < dir.ignored_nr; i++)
+		free(dir.ignored[i]);
+
 	if (interactive && del_list.nr > 0)
 		interactive_main_loop();
 
-- 
2.12.2

