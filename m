Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFAF91FDEA
	for <e@80x24.org>; Tue,  9 May 2017 19:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754790AbdEITSl (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 15:18:41 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36373 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753413AbdEITSe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 15:18:34 -0400
Received: by mail-pg0-f44.google.com with SMTP id 64so4386591pgb.3
        for <git@vger.kernel.org>; Tue, 09 May 2017 12:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gHavRLv7soC0jJxMo7VxKx9dXnC0O51on1VIucDvcnU=;
        b=Jb0/uI4FaKpA79K/8H64s50yJ7nn3IRD2kiD+OVPawoT3s97g9Ka5OE37JZQY+r+/N
         3jD4jMzGu341/qP1XXWdaeVLg7mLdBECCrIrNT2vKwhIUi5dvVAO0dqfLXriTrYfDfnP
         LAT9gOFkxDM7cC1gSFDh1pfPwsdGtU7gjd+lEGw3tys2LTKfMZSSQXz7DKbZgHFgLO4N
         NfEJb8GfAfUftGRzC1cSYXkBjEa+EtX17hFs0YF9DCZpZ2djTokaPJh7KRX7zcJULOA1
         3MfgHHRo/jFSDnynjurv9aJWfePCjBhon4doqbX0Pf4aYWUoz4iB5Xuor6RLYaTgS+E+
         ki1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gHavRLv7soC0jJxMo7VxKx9dXnC0O51on1VIucDvcnU=;
        b=aEw7yz/sl60UsNZhJSQ+auOiq4132IVOxPIsoUCgEiw00INFvZBlCuzSyP7/ewdYXs
         LFqVJu4BUe340yXt79xEM+cZVruGyr/Dw4U22TOID7aYC/T3Y/iKRhcLRx09MlHNpa3e
         UZFg67et8fEMQMdudyIkHyrxsIIkjaba/7xzWwxOrGfslAlq9OWuQYEbV2KDWolj9EUF
         mwrr5zVaOfEXXBxb/DDl3BNUMUGqz8xkrlfjS91s7LWQgWtz0ZJV2j9sQ9Fd/vS4lUUi
         UdUcYMnQxGE+0/Yt9grs+VzR9ZrxQ/0ENThPWa68CgjTNn9KSNgHAwox3lGPf6kNHNey
         2RxQ==
X-Gm-Message-State: AODbwcDMcsau90Ua6TZNXM6c6AwbWyEqg5rzhdEDxJVUScDNWaxPpPcD
        Zz4Y0ko44xCyILmT
X-Received: by 10.98.75.6 with SMTP id y6mr1631838pfa.157.1494357512837;
        Tue, 09 May 2017 12:18:32 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id w23sm1124427pfl.133.2017.05.09.12.18.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 May 2017 12:18:32 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 6/8] pathspec: convert find_pathspecs_matching_against_index to take an index
Date:   Tue,  9 May 2017 12:18:03 -0700
Message-Id: <20170509191805.176266-7-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc2.291.g57267f2277-goog
In-Reply-To: <20170509191805.176266-1-bmwill@google.com>
References: <20170509191805.176266-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/add.c          |  4 ++--
 builtin/check-ignore.c |  2 +-
 pathspec.c             | 10 ++++++----
 pathspec.h             |  7 +++++--
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 51d7a5506..4e3bf20c2 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -136,7 +136,7 @@ static char *prune_directory(struct dir_struct *dir, struct pathspec *pathspec,
 			*dst++ = entry;
 	}
 	dir->nr = dst - dir->entries;
-	add_pathspec_matches_against_index(pathspec, seen);
+	add_pathspec_matches_against_index(pathspec, &the_index, seen);
 	return seen;
 }
 
@@ -418,7 +418,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		int i;
 
 		if (!seen)
-			seen = find_pathspecs_matching_against_index(&pathspec);
+			seen = find_pathspecs_matching_against_index(&pathspec, &the_index);
 
 		/*
 		 * file_exists() assumes exact match
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 694e4c61b..446b76dcf 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -97,7 +97,7 @@ static int check_ignore(struct dir_struct *dir,
 	 * should not be ignored, in order to be consistent with
 	 * 'git status', 'git add' etc.
 	 */
-	seen = find_pathspecs_matching_against_index(&pathspec);
+	seen = find_pathspecs_matching_against_index(&pathspec, &the_index);
 	for (i = 0; i < pathspec.nr; i++) {
 		full_path = pathspec.items[i].match;
 		exclude = NULL;
diff --git a/pathspec.c b/pathspec.c
index cff069536..bbd71b48b 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -17,6 +17,7 @@
  * to use find_pathspecs_matching_against_index() instead.
  */
 void add_pathspec_matches_against_index(const struct pathspec *pathspec,
+					const struct index_state *istate,
 					char *seen)
 {
 	int num_unmatched = 0, i;
@@ -32,8 +33,8 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 			num_unmatched++;
 	if (!num_unmatched)
 		return;
-	for (i = 0; i < active_nr; i++) {
-		const struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < istate->cache_nr; i++) {
+		const struct cache_entry *ce = istate->cache[i];
 		ce_path_match(ce, pathspec, seen);
 	}
 }
@@ -46,10 +47,11 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
  * nature of the "closest" (i.e. most specific) matches which each of the
  * given pathspecs achieves against all items in the index.
  */
-char *find_pathspecs_matching_against_index(const struct pathspec *pathspec)
+char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
+					    const struct index_state *istate)
 {
 	char *seen = xcalloc(pathspec->nr, 1);
-	add_pathspec_matches_against_index(pathspec, seen);
+	add_pathspec_matches_against_index(pathspec, istate, seen);
 	return seen;
 }
 
diff --git a/pathspec.h b/pathspec.h
index dd6456d5d..dfb22440a 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -103,7 +103,10 @@ static inline int ps_strcmp(const struct pathspec_item *item,
 		return strcmp(s1, s2);
 }
 
-extern char *find_pathspecs_matching_against_index(const struct pathspec *pathspec);
-extern void add_pathspec_matches_against_index(const struct pathspec *pathspec, char *seen);
+extern void add_pathspec_matches_against_index(const struct pathspec *pathspec,
+					       const struct index_state *istate,
+					       char *seen);
+extern char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
+						   const struct index_state *istate);
 
 #endif /* PATHSPEC_H */
-- 
2.13.0.rc2.291.g57267f2277-goog

