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
	by dcvr.yhbt.net (Postfix) with ESMTP id E7A801F461
	for <e@80x24.org>; Thu, 29 Aug 2019 18:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbfH2S2Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 14:28:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50727 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbfH2S2J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 14:28:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id v15so4740223wml.0
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 11:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fNCEMQP8FCbtf8HiQIYPv4jwNXJ8cQPMolrSHc0GMKM=;
        b=dQH5VKLPx9T16iiRkV1tcmN0GVwUDuGbFKwuE9FsH/swORSqLB6uQXeSQXtPgpzY2l
         j5twijPcQOYft7HOxqyAu4jBwCZs495o6E0GSCwHqgaxZZhGeH2ATjSzFnA572I30YU/
         MWIYiJoO75+wtmAUsiMZjV40qFHSeqLcfRQgDggeKd6ZMGY5Pk9tts+dJPQyb7yZXYui
         XjchwRvHSu3WKsdRdyGQrQqs7N8J3yBWs2ebFKfxQb5um/FAissxLawaa3dIV3uPpibD
         xuAo2DYmBkAW5zCmLw081XdjBAxiqLUCnxoKd2zcYD5D0UK3IRatvTKiMq8LrUu6KsNp
         TNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fNCEMQP8FCbtf8HiQIYPv4jwNXJ8cQPMolrSHc0GMKM=;
        b=lhVCLI1hseDyD+YnMP7RoL4dr6D0ke+/819Oa9KOAPc+AHeFsAnJWMTrcKvBDMmcJw
         Sv7n+6LIZQlwrh07FMDTUnLelhXzU+LacZTfroi9YtQHupXhl7RAFeCJM2CNiZqnns2Z
         j2lYM3mpmK7oz0lSMUEcbcub3fOruFOQR12MAwDjMxvasU8sjE5t4+YrqaTk6CTfPUdg
         SavuW3+jbWiDV/cno0DthFlhTsgdkNsnw8gu9mxHh2dBvPIAyL7ef2KaCFZMZAFclzVl
         InDbXWZy8+4Hj8JthIwFykHHVa0UJnyPoqkM8v16ltOzNaZVp0r96rv9mXXVaAkyAPfF
         uqdA==
X-Gm-Message-State: APjAAAULBKmn+wvbwDrNnmcrzS9TiPKlwjRwD7CJbJ1tn63UFpqwAJod
        KJbEHtoXDjyt53nTce+3HUGFdy/m
X-Google-Smtp-Source: APXvYqwA1XqzWH1YmnEAViVqxILvw5lZQclfDlFMlnogdUQZTCGHls8LAaxb8UIhTis2AQ3F6ZIrsA==
X-Received: by 2002:a7b:ce1a:: with SMTP id m26mr13615467wmc.60.1567103287497;
        Thu, 29 Aug 2019 11:28:07 -0700 (PDT)
Received: from localhost ([2.31.128.175])
        by smtp.gmail.com with ESMTPSA id c132sm5289996wme.27.2019.08.29.11.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Aug 2019 11:28:06 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 1/3] factor out refresh_and_write_cache function
Date:   Thu, 29 Aug 2019 19:27:46 +0100
Message-Id: <20190829182748.43802-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.194.ge5444969c9
In-Reply-To: <20190829182748.43802-1-t.gummerer@gmail.com>
References: <20190827101408.76757-1-t.gummerer@gmail.com>
 <20190829182748.43802-1-t.gummerer@gmail.com>
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
 cache.h      | 13 +++++++++++++
 read-cache.c | 17 +++++++++++++++++
 3 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 1aea657a7f..ddedd2b9d4 100644
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
+	if (refresh_and_write_cache(REFRESH_QUIET, 0) < 0)
+		die(_("unable to write index file"));
 
 	if (repo_index_has_changes(the_repository, NULL, &sb)) {
 		write_state_bool(state, "dirtyindex", 1);
diff --git a/cache.h b/cache.h
index b1da1ab08f..987d289e8f 100644
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
@@ -812,6 +813,18 @@ void fill_stat_cache_info(struct index_state *istate, struct cache_entry *ce, st
 #define REFRESH_IN_PORCELAIN	0x0020	/* user friendly output, not "needs update" */
 #define REFRESH_PROGRESS	0x0040  /* show progress bar if stderr is tty */
 int refresh_index(struct index_state *, unsigned int flags, const struct pathspec *pathspec, char *seen, const char *header_msg);
+/*
+ * Refresh the index and write it to disk.
+ *
+ * 'refresh_flags' is passed directly to 'refresh_index()', while
+ * 'COMMIT_LOCK | write_flags' is passed to 'write_locked_index()', so
+ * the lockfile is always either committed or rolled back.
+ *
+ * Return 1 if refreshing the cache failed, -1 if writing the cache to
+ * disk failed, 0 on success.
+ */
+int repo_refresh_and_write_index(struct repository*, unsigned int refresh_flags, unsigned int write_flags, const struct pathspec *, char *seen, const char *header_msg);
+
 struct cache_entry *refresh_cache_entry(struct index_state *, struct cache_entry *, unsigned int);
 
 void set_alternate_index_output(const char *);
diff --git a/read-cache.c b/read-cache.c
index 52ffa8a313..72662df077 100644
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
+	if (write_locked_index(repo->index, &lock_file, COMMIT_LOCK | write_flags))
+		return -1;
+	return 0;
+}
+
+
 int refresh_index(struct index_state *istate, unsigned int flags,
 		  const struct pathspec *pathspec,
 		  char *seen, const char *header_msg)
-- 
2.23.0.rc2.194.ge5444969c9

