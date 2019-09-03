Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 941351F461
	for <e@80x24.org>; Tue,  3 Sep 2019 19:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfICTKt (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 15:10:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32956 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfICTKt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 15:10:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id r17so735351wme.0
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 12:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L0C6Vpjk5Wc7FtGNy8tLIf6VdopGyVfcQ6MWbNIvARk=;
        b=XBytGYmAYrrdzNANAc0F0hqI88uZy/SP7u/qTznkDbJUSbIxUaPeVxU8egQ9RFfVhi
         Ryr50EgDQQOv2PzhnE/AL7/fFckAJe/d5yjWTfuirnysFHjfLAOXVq8f0asuIDGslFoU
         n3P57NAhKM8a1L+PPlkOT515d60D+/b86OU0OwWaMFMXFrxrQgHfpu2Nh1Gxpv9u1cOe
         FNJ9jof9tl79/3dRvWAopBqKixD4nA3kxXsVxLP88QIVLhJ8RUjYntxpQLVXSFONRnBt
         OrEKGiyIslFeibk6XL7xPaU8bUgQerGbc+oZAUq9DHWqAQVaKAfOD/WdFG5adJ/pJZcA
         +7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L0C6Vpjk5Wc7FtGNy8tLIf6VdopGyVfcQ6MWbNIvARk=;
        b=fN9mnyzppnU5CLVdO6v0iu3OQhKvjbSmLnOOu+MyoEL5194WLtuekW6WivfeWaIyBL
         B5BIxJKE5l+G9DDlFmAumQWLi4BzjV/t7KaI2rJLpy9dI/k7vDY+R3So1J8nvHjTEmwx
         t8h1cXA1rDzQGN3x++DRzuW11jIXGOAf7+W5CwAiMoDHrqpmU26Ib7rR4UDbnLT7A5Wn
         uor7JEHpwh3bi0MSwsl9BnFhxPq7EDg3GXlB2eUVddnv+2l9phDompvDEckFbobEQtq5
         NC9GMobRgNNqszINn5sR3OcJU2qTUIoWk6Snspg3IZvPVuV3qH99It68uAR9o3qbKGIo
         xSCA==
X-Gm-Message-State: APjAAAWEnbwcoYc2TaiqKS/u0iEvvL0GlJQaF7og2sBuhHGsxpWJIj2G
        G3Ke1mjFtBA8Ieg7ia/V1HPDYh/Q
X-Google-Smtp-Source: APXvYqx/Q7IinWExs8TATTB6Ywn8vCgbD7YX/0S+/57ucgkoJUAVhg7CqNQa7Pf0rVVVPV4iqOyPpA==
X-Received: by 2002:a1c:a54a:: with SMTP id o71mr1084992wme.51.1567537846489;
        Tue, 03 Sep 2019 12:10:46 -0700 (PDT)
Received: from localhost ([95.148.214.9])
        by smtp.gmail.com with ESMTPSA id q25sm775325wmq.27.2019.09.03.12.10.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Sep 2019 12:10:45 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 1/3] factor out refresh_and_write_cache function
Date:   Tue,  3 Sep 2019 20:10:39 +0100
Message-Id: <20190903191041.10470-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.194.ge5444969c9
In-Reply-To: <20190903191041.10470-1-t.gummerer@gmail.com>
References: <20190829182748.43802-1-t.gummerer@gmail.com>
 <20190903191041.10470-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Getting the lock for the index, refreshing it and then writing it is a
pattern that happens more than once throughout the codebase, and isn't
trivial to get right.  Factor out the refresh_and_write_cache function
from builtin/am.c to read-cache.c, so it can be re-used in other
places in a subsequent commit.

Note that we return different error codes for failing to refresh the
cache, and failing to write the index.  The current caller only cares
about failing to write the index.  However for other callers we're
going to convert in subsequent patches we will need this distinction.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/am.c | 16 ++--------------
 cache.h      | 16 ++++++++++++++++
 read-cache.c | 19 +++++++++++++++++++
 3 files changed, 37 insertions(+), 14 deletions(-)

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
index b1da1ab08f..2b14768bea 100644
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
@@ -812,6 +813,21 @@ void fill_stat_cache_info(struct index_state *istate, struct cache_entry *ce, st
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
+ * Return 1 if refreshing the index returns an error, -1 if writing
+ * the index to disk fails, 0 on success.
+ *
+ * Note that if refreshing the index returns an error, we don't write
+ * the result to disk.
+ */
+int repo_refresh_and_write_index(struct repository*, unsigned int refresh_flags, unsigned int write_flags, const struct pathspec *, char *seen, const char *header_msg);
+
 struct cache_entry *refresh_cache_entry(struct index_state *, struct cache_entry *, unsigned int);
 
 void set_alternate_index_output(const char *);
diff --git a/read-cache.c b/read-cache.c
index 52ffa8a313..2ad96677ae 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1472,6 +1472,25 @@ static void show_file(const char * fmt, const char * name, int in_porcelain,
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
+	if (refresh_index(repo->index, refresh_flags, pathspec, seen, header_msg)) {
+		rollback_lock_file(&lock_file);
+		return 1;
+	}
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

