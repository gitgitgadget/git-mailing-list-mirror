Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFDE620370
	for <e@80x24.org>; Thu,  5 Oct 2017 20:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbdJEUc7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 16:32:59 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51109 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbdJEUc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 16:32:57 -0400
Received: by mail-wm0-f65.google.com with SMTP id u138so4144495wmu.5
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 13:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0dgMFsdguv2GYWvd8O8bFMeR7kCx+OpihpB+SCO4UfQ=;
        b=ayapwGBQu3iyIoOXcJ+vV51CPPfZrpjaNXw7P3e8EKzr17HNp4b/CdPKuV5GA69LdT
         8/MpLWjzzig8QaSkDP2deEjpaU2U+pETqOYKHGLh0tkfwofJ+Ba+sCCzN4UBsFm45mjc
         d83rnx6EC3ujVH3e64/oZELM7qeXZ8pEmQF08eKmZGk0kf1JdqgwmdRAWS8UE0AqquTT
         Q1LRweVlG7L9SIDLaJiI0+PQkIka+H2YItQM2B9lUK/1CXgQWhR8awKSeS/oMbHeIlNZ
         VRCvw9MCdc9PADaXsXeFIopAn15S98upZs2G2FMCGl7Y1QQ1A82xBszf2Zpv9KQqrqEj
         z8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0dgMFsdguv2GYWvd8O8bFMeR7kCx+OpihpB+SCO4UfQ=;
        b=l8lGCIbRhc/kgyO8V4N8uNd+1gtAuNnREgpiTLYoGUef03Uj4UW9FGEqW0RWM8Db52
         VoEU1AL5f1hcJbGJ9gQzDOYTJeXBSyu7p+mfsp5SfLKKrNiIxb8B+s+5AyVOBmIRXisK
         +Fl/a6X8ttAmrZN9Otb9iZSQP+8NmTSq1wYDZpZFpiKbOx0q3rrKeF3XtMgAlVr1S4Sz
         4TgZ2tl2bQGzUMXn0Xfv78i/7mxswaSPKVqzxtu4UgQXxSODT9W+kqBne6csZMjaDlcZ
         BfColsTQlDL0aP8Di35n45vGTCFPVZ8bjB8cTEXr2jqXFb3NV8CmgXY0VOOVoqlCwsd4
         yEaA==
X-Gm-Message-State: AMCzsaV++pSEgVXC6Gvp+0adyvBezzghqXDZgEH1TWRJY07c3c4HE3wB
        zOJpe5LI+/ZCRS5X8aGluZfXoN4q
X-Google-Smtp-Source: AOwi7QDoKTGj1fy2LvVUMDjdzWkVzRWYGmEJtSkd8mTCJTy+7Z7MEkN6BfTZDtzG+sZafCI5kMRpEg==
X-Received: by 10.28.47.69 with SMTP id v66mr272712wmv.98.1507235575869;
        Thu, 05 Oct 2017 13:32:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id i76sm698424wmd.2.2017.10.05.13.32.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Oct 2017 13:32:55 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 10/12] read-cache: drop explicit `CLOSE_LOCK`-flag
Date:   Thu,  5 Oct 2017 22:32:12 +0200
Message-Id: <db82bb7dc0828a415e48e654031b3b0d0ed763a5.1507228170.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.2.666.gea220ee40
In-Reply-To: <cover.1507228170.git.martin.agren@gmail.com>
References: <xmqqy3osiwe6.fsf@gitster.mtv.corp.google.com> <cover.1507228170.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`write_locked_index()` takes two flags: `COMMIT_LOCK` and `CLOSE_LOCK`.
At most one is allowed. But it is also possible to use no flag, i.e.,
`0`. But when `write_locked_index()` calls `do_write_index()`, the
temporary file, a.k.a. the lockfile, will be closed. So passing `0` is
effectively the same as `CLOSE_LOCK`, which seems like a bug.

We might feel tempted to restructure the code in order to close the file
later, or conditionally. It also feels a bit unfortunate that we simply
"happen" to close the lock by way of an implementation detail of
lockfiles. But note that we need to close the temporary file before
`stat`-ing it, at least on Windows. See 9f41c7a6b (read-cache: close
index.lock in do_write_index, 2017-04-26).

Drop `CLOSE_LOCK` and make it explicit that `write_locked_index()`
always closes the lock. Whether it is also committed is governed by the
remaining flag, `COMMIT_LOCK`.

This means we neither have nor suggest that we have a mode to write the
index and leave the file open. Whatever extra contents we might
eventually want to write, we should probably write it from within
`write_locked_index()` itself anyway.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
v2: Drop `CLOSE_LOCK` altogether instead of requiring precisely one of
the flags to be set.

 builtin/commit.c | 10 +++++-----
 cache.h          |  5 ++---
 read-cache.c     | 11 +++++------
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 0f8ddb686..32dc2101f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -355,7 +355,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 
 		refresh_cache_or_die(refresh_flags);
 
-		if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
+		if (write_locked_index(&the_index, &index_lock, 0))
 			die(_("unable to create temporary index"));
 
 		old_index_env = getenv(INDEX_ENVIRONMENT);
@@ -374,7 +374,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		if (update_main_cache_tree(WRITE_TREE_SILENT) == 0) {
 			if (reopen_lock_file(&index_lock) < 0)
 				die(_("unable to write index file"));
-			if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
+			if (write_locked_index(&the_index, &index_lock, 0))
 				die(_("unable to update temporary index"));
 		} else
 			warning(_("Failed to update main cache tree"));
@@ -401,7 +401,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		add_files_to_cache(also ? prefix : NULL, &pathspec, 0);
 		refresh_cache_or_die(refresh_flags);
 		update_main_cache_tree(WRITE_TREE_SILENT);
-		if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
+		if (write_locked_index(&the_index, &index_lock, 0))
 			die(_("unable to write new_index file"));
 		commit_style = COMMIT_NORMAL;
 		ret = get_lock_file_path(&index_lock);
@@ -474,7 +474,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	add_remove_files(&partial);
 	refresh_cache(REFRESH_QUIET);
 	update_main_cache_tree(WRITE_TREE_SILENT);
-	if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
+	if (write_locked_index(&the_index, &index_lock, 0))
 		die(_("unable to write new_index file"));
 
 	hold_lock_file_for_update(&false_lock,
@@ -486,7 +486,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	add_remove_files(&partial);
 	refresh_cache(REFRESH_QUIET);
 
-	if (write_locked_index(&the_index, &false_lock, CLOSE_LOCK))
+	if (write_locked_index(&the_index, &false_lock, 0))
 		die(_("unable to write temporary index file"));
 
 	discard_cache();
diff --git a/cache.h b/cache.h
index e9d9556e3..21a6856c5 100644
--- a/cache.h
+++ b/cache.h
@@ -604,11 +604,10 @@ extern int read_index_unmerged(struct index_state *);
 
 /* For use with `write_locked_index()`. */
 #define COMMIT_LOCK		(1 << 0)
-#define CLOSE_LOCK		(1 << 1)
 
 /*
- * Write the index while holding an already-taken lock. The flags may
- * contain at most one of `COMMIT_LOCK` and `CLOSE_LOCK`.
+ * Write the index while holding an already-taken lock. Close the lock,
+ * and if `COMMIT_LOCK` is given, commit it.
  *
  * Unless a split index is in use, write the index into the lockfile.
  *
diff --git a/read-cache.c b/read-cache.c
index 65f4fe837..1c917eba9 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2343,14 +2343,13 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 	int ret = do_write_index(istate, lock->tempfile, 0);
 	if (ret)
 		return ret;
-	assert((flags & (COMMIT_LOCK | CLOSE_LOCK)) !=
-	       (COMMIT_LOCK | CLOSE_LOCK));
 	if (flags & COMMIT_LOCK)
 		return commit_locked_index(lock);
-	else if (flags & CLOSE_LOCK)
-		return close_lock_file_gently(lock);
-	else
-		return ret;
+	/*
+	 * The lockfile already happens to have
+	 * been closed, but let's be specific.
+	 */
+	return close_lock_file_gently(lock);
 }
 
 static int write_split_index(struct index_state *istate,
-- 
2.14.2.666.gea220ee40

