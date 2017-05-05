Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE4C9207B3
	for <e@80x24.org>; Fri,  5 May 2017 19:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755693AbdEETyH (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 15:54:07 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33962 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755676AbdEETyG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 15:54:06 -0400
Received: by mail-pg0-f48.google.com with SMTP id 12so7631856pgc.1
        for <git@vger.kernel.org>; Fri, 05 May 2017 12:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=npAvM8q0Ne5QRN4rPCnbqD54YUMU/FUgn8ycr4KsICw=;
        b=mXxZF8RO3hC1vv9Esf6xiYhCD5BpM8N2MxjJdUJr54+bVS83/n4Zx6r6P1C/upHRgb
         slCXJ3HuNnf1at6enmTp0ggSiDarlwJygtPRUICpQssLCyFNf9uBaIjH706X4ZwqSy1o
         3oH4QKkyrWzmzl7mxtEQquBzjqd3Y7G28/rbZWg3oxVvuah+XU8yWtUBscQstACamzSA
         Je2sVbRI2lGQEk3LVS4jFQAQ7ptOnOxgkar+gZpUkcsXTa13dRk9WchtseBExYpFU3OE
         UCCSPM9cdJ4GmX9/N1NrFvWR1zYQPYePAgHhSSP/i0luj0FO7qh9bT29/RlZrOcp/Kz/
         y41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=npAvM8q0Ne5QRN4rPCnbqD54YUMU/FUgn8ycr4KsICw=;
        b=oS7aaeRysBRkMBrOtElSiyVlSF8RWVKV1Qc6GRvXoNT3Syj+cCAB0jt8HRuy9gyL2t
         Qza6UJB84zWBt9fkm21rcAuxvnbyhWVW9aibdigG61qpR7QQR/bsxOAECvJke44bC2Ll
         JeKm9izRuiPFsQrlDrtLMoVYBKQU+ANbl/UtEG5bXuBqyWbKxUg7tlPLn8lBTAWrl9SJ
         TL8Us/xLBQVK7ZrAOfY2SA0owhaUOBNcDRnWXrVgfi8+Yjdv9JE33nVISKhfuBFgbl1p
         dyMcaP5fHbfE8cx7gER13L7rZHxM5vYk/xuQiohWqs6lu3kLMs7EvTSkFHF6xGgUVMt3
         1JIA==
X-Gm-Message-State: AN3rC/6nT4lWJyG8q11n81S1zKyeCFf2/j/NsC2VYHTgAFPny4YbaetN
        6GdMgWc4unToHKcF
X-Received: by 10.99.152.67 with SMTP id l3mr5439613pgo.97.1494014045733;
        Fri, 05 May 2017 12:54:05 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id r86sm12395967pfb.24.2017.05.05.12.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 12:54:04 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        Johannes.Schindelin@gmx.de, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [RFC 14/14] dir: convert fill_directory to take an index
Date:   Fri,  5 May 2017 12:53:34 -0700
Message-Id: <20170505195334.121856-15-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f-goog
In-Reply-To: <20170505195334.121856-1-bmwill@google.com>
References: <20170505195334.121856-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/add.c      | 2 +-
 builtin/clean.c    | 2 +-
 builtin/grep.c     | 2 +-
 builtin/ls-files.c | 2 +-
 dir.c              | 6 ++++--
 dir.h              | 4 +++-
 wt-status.c        | 2 +-
 7 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 0b52aeced..36cad00ae 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -400,7 +400,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		}
 
 		/* This picks up the paths that are not tracked */
-		baselen = fill_directory(&dir, &pathspec);
+		baselen = fill_directory(&dir, &the_index, &pathspec);
 		if (pathspec.nr)
 			seen = prune_directory(&dir, &pathspec, baselen);
 	}
diff --git a/builtin/clean.c b/builtin/clean.c
index 39866afab..329b68c40 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -930,7 +930,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		       PATHSPEC_PREFER_CWD,
 		       prefix, argv);
 
-	fill_directory(&dir, &pathspec);
+	fill_directory(&dir, &the_index, &pathspec);
 
 	for (i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
diff --git a/builtin/grep.c b/builtin/grep.c
index 65070c52f..ca1344133 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -866,7 +866,7 @@ static int grep_directory(struct grep_opt *opt, const struct pathspec *pathspec,
 	if (exc_std)
 		setup_standard_excludes(&dir);
 
-	fill_directory(&dir, pathspec);
+	fill_directory(&dir, &the_index, pathspec);
 	for (i = 0; i < dir.nr; i++) {
 		if (!dir_path_match(dir.entries[i], pathspec, 0, NULL))
 			continue;
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index ccba227e2..239c18a1f 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -326,7 +326,7 @@ static void show_files(struct dir_struct *dir)
 	if (show_others || show_killed) {
 		if (!show_others)
 			dir->flags |= DIR_COLLECT_KILLED_ONLY;
-		fill_directory(dir, &pathspec);
+		fill_directory(dir, &the_index, &pathspec);
 		if (show_others)
 			show_other_files(dir);
 		if (show_killed)
diff --git a/dir.c b/dir.c
index 4eb8cb6a2..3f3167e55 100644
--- a/dir.c
+++ b/dir.c
@@ -177,7 +177,9 @@ char *common_prefix(const struct pathspec *pathspec)
 	return len ? xmemdupz(pathspec->items[0].match, len) : NULL;
 }
 
-int fill_directory(struct dir_struct *dir, const struct pathspec *pathspec)
+int fill_directory(struct dir_struct *dir,
+		   struct index_state *istate,
+		   const struct pathspec *pathspec)
 {
 	const char *prefix;
 	size_t prefix_len;
@@ -190,7 +192,7 @@ int fill_directory(struct dir_struct *dir, const struct pathspec *pathspec)
 	prefix = prefix_len ? pathspec->items[0].match : "";
 
 	/* Read the directory and prune it */
-	read_directory(dir, &the_index, prefix, prefix_len, pathspec);
+	read_directory(dir, istate, prefix, prefix_len, pathspec);
 
 	return prefix_len;
 }
diff --git a/dir.h b/dir.h
index a23bcd005..17d110693 100644
--- a/dir.h
+++ b/dir.h
@@ -214,7 +214,9 @@ extern int match_pathspec(const struct pathspec *pathspec,
 extern int report_path_error(const char *ps_matched, const struct pathspec *pathspec, const char *prefix);
 extern int within_depth(const char *name, int namelen, int depth, int max_depth);
 
-extern int fill_directory(struct dir_struct *dir, const struct pathspec *pathspec);
+extern int fill_directory(struct dir_struct *dir,
+			  struct index_state *istate,
+			  const struct pathspec *pathspec);
 extern int read_directory(struct dir_struct *, struct index_state *istate,
 			  const char *path, int len,
 			  const struct pathspec *pathspec);
diff --git a/wt-status.c b/wt-status.c
index 308cf3779..9e2d03cd9 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -652,7 +652,7 @@ static void wt_status_collect_untracked(struct wt_status *s)
 		dir.untracked = the_index.untracked;
 	setup_standard_excludes(&dir);
 
-	fill_directory(&dir, &s->pathspec);
+	fill_directory(&dir, &the_index, &s->pathspec);
 
 	for (i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
-- 
2.13.0.rc1.294.g07d810a77f-goog

