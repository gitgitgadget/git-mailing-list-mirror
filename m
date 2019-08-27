Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 286171F461
	for <e@80x24.org>; Tue, 27 Aug 2019 10:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbfH0KOW (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 06:14:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38348 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfH0KOV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 06:14:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id m125so2385344wmm.3
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 03:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a9qpdHzYjmLrDIAggsgpuPLsUo/rtP7sDMa+KHuz/Ro=;
        b=S86KKmnsGn5QLyq0oS4d6dF5vur8bPFlA7yiZ7NXdA6EVIwbjeK/ErXE/11PkKs0mN
         6hVsckXpJq6YixIl6edaProJPwdhzMdffBAo2rM7Fe33cj7VJg/o0MSDoe0aB/of2Qt2
         UZ6yjTR3m+bF+VqbRSLmnZjU/yFbHsAzs7bc8gCx+ZjqTpQHkrTZS7DETc9lkX0n0ww7
         ftAfl74LJzQlUfKu21uPIOA05j+yl3BIl1LMCALEY8BLb510I+uD+krUM2wlsaF5NmkR
         MgcPCZ27MAyBenig09xVACf2SxA2x4/RUa7t7kfvXIl1ZlGq6Ec8lHxiXPJG3XUrypdg
         Gq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a9qpdHzYjmLrDIAggsgpuPLsUo/rtP7sDMa+KHuz/Ro=;
        b=Jr9qAnudn8qTeS4EVkIibt/UPPYVq4qiY2WUMjnlh5Qw+hSzoz8MSW21PKOylWlDFm
         y8JnAp32uMmIhwOdI7Q230oa4Y+tg00no854wOX997uqD6lr8lglBGifEKUsiZyhMuWw
         8wc0jYoXTmiczQBe8LZjKqBsDTttnrEKIoutWFJVglvZAvUJTJJkK+/Y4hhsXbLrS1MG
         vj8va9e8XttiMLF5ueycjioED+822cngLS1BeXFX7qxhkTQm4K2dKmLWMrQDtTECDyKI
         ZCdoZO+JhRL53u3zOn2wdUcAUn4wmbQcH8YEJiYa9JP1wHN+GaGddAZZYZEMD+Pm2DH3
         +mjg==
X-Gm-Message-State: APjAAAU9lEPSOR23W97dwRDPIADwYU9h77ND+s1WfvD14Prh/8/OCiup
        K50VWY194OyrCguQUzdo3Xp6QmmV
X-Google-Smtp-Source: APXvYqzFgoszoUN33AjXOBN5dSUb/0tH8wAj5Bwf3fSlGLA6ivKbqe1/Me0rL61msIyhou/hKof2PQ==
X-Received: by 2002:a7b:c157:: with SMTP id z23mr27311081wmi.104.1566900858150;
        Tue, 27 Aug 2019 03:14:18 -0700 (PDT)
Received: from localhost ([2.31.128.175])
        by smtp.gmail.com with ESMTPSA id 24sm2773775wmf.10.2019.08.27.03.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 03:14:17 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 1/3] factor out refresh_and_write_cache function
Date:   Tue, 27 Aug 2019 11:14:06 +0100
Message-Id: <20190827101408.76757-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.194.ge5444969c9
In-Reply-To: <20190827101408.76757-1-t.gummerer@gmail.com>
References: <20190827101408.76757-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Getting the lock for the index, refreshing it and then writing it is a
pattern that happens more than once throughout the codebase.  Factor
out the refresh_and_write_cache function from builtin/am.c to
read-cache.c, so it can be re-used in other places in a subsequent
commit.

Note that we return different error codes for failing to refresh the
cache, and failing to write the index.  The current caller only cares
about failing to write the index.  However for other callers we're
going to convert in subsequent patches we will need this distinction.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/am.c | 16 ++--------------
 cache.h      |  9 +++++++++
 read-cache.c | 17 +++++++++++++++++
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 1aea657a7f..e00410e4d7 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1071,19 +1071,6 @@ static const char *msgnum(const struct am_state *state)
 	return sb.buf;
 }
 
-/**
- * Refresh and write index.
- */
-static void refresh_and_write_cache(void)
-{
-	struct lock_file lock_file = LOCK_INIT;
-
-	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
-	refresh_cache(REFRESH_QUIET);
-	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
-		die(_("unable to write index file"));
-}
-
 /**
  * Dies with a user-friendly message on how to proceed after resolving the
  * problem. This message can be overridden with state->resolvemsg.
@@ -1703,7 +1690,8 @@ static void am_run(struct am_state *state, int resume)
 
 	unlink(am_path(state, "dirtyindex"));
 
-	refresh_and_write_cache();
+	if (refresh_and_write_cache(REFRESH_QUIET, COMMIT_LOCK) < 0)
+		die(_("failed to refresh cache"));
 
 	if (repo_index_has_changes(the_repository, NULL, &sb)) {
 		write_state_bool(state, "dirtyindex", 1);
diff --git a/cache.h b/cache.h
index b1da1ab08f..f72392f32b 100644
--- a/cache.h
+++ b/cache.h
@@ -414,6 +414,7 @@ extern struct index_state the_index;
 #define add_file_to_cache(path, flags) add_file_to_index(&the_index, (path), (flags))
 #define chmod_cache_entry(ce, flip) chmod_index_entry(&the_index, (ce), (flip))
 #define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL, NULL)
+#define refresh_and_write_cache(refresh_flags, write_flags) repo_refresh_and_write_index(the_repository, (refresh_flags), (write_flags), NULL, NULL, NULL)
 #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
 #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
 #define cache_dir_exists(name, namelen) index_dir_exists(&the_index, (name), (namelen))
@@ -812,6 +813,14 @@ void fill_stat_cache_info(struct index_state *istate, struct cache_entry *ce, st
 #define REFRESH_IN_PORCELAIN	0x0020	/* user friendly output, not "needs update" */
 #define REFRESH_PROGRESS	0x0040  /* show progress bar if stderr is tty */
 int refresh_index(struct index_state *, unsigned int flags, const struct pathspec *pathspec, char *seen, const char *header_msg);
+/*
+ * Refresh the index and write it to disk.
+ *
+ * Return 1 if refreshing the cache failed, -1 if writing the cache to
+ * disk failed, 0 on success.
+ */
+int repo_refresh_and_write_index(struct repository*, unsigned int refresh_flags, unsigned int write_flags, const struct pathspec *, char *seen, const char *header_msg);
+
 struct cache_entry *refresh_cache_entry(struct index_state *, struct cache_entry *, unsigned int);
 
 void set_alternate_index_output(const char *);
diff --git a/read-cache.c b/read-cache.c
index 52ffa8a313..905d2ddd10 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1472,6 +1472,23 @@ static void show_file(const char * fmt, const char * name, int in_porcelain,
 	printf(fmt, name);
 }
 
+int repo_refresh_and_write_index(struct  repository *repo,
+				 unsigned int refresh_flags,
+				 unsigned int write_flags,
+				 const struct pathspec *pathspec,
+				 char *seen, const char *header_msg)
+{
+	struct lock_file lock_file = LOCK_INIT;
+
+	repo_hold_locked_index(repo, &lock_file, LOCK_DIE_ON_ERROR);
+	if (refresh_index(repo->index, refresh_flags, pathspec, seen, header_msg))
+		return 1;
+	if (write_locked_index(repo->index, &lock_file, write_flags))
+		return error(_("unable to write index file"));
+	return 0;
+}
+
+
 int refresh_index(struct index_state *istate, unsigned int flags,
 		  const struct pathspec *pathspec,
 		  char *seen, const char *header_msg)
-- 
2.23.0.rc2.194.ge5444969c9

