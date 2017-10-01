Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E929F20A10
	for <e@80x24.org>; Sun,  1 Oct 2017 14:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751384AbdJAO5N (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 10:57:13 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33577 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdJAO5M (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 10:57:12 -0400
Received: by mail-wr0-f196.google.com with SMTP id z96so932968wrb.0
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 07:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JNESj41Yfave5K5Y1y5ILDtVSLYU7s+itRuK/9MSGFY=;
        b=IvmGkMG+KpCNiqnh/i6h/J2vWkDAn7KUM2Ki6JrbxzezQIB8Wmhs7Kj3a0PgQR4//A
         7fuOILiqh4TlkcHXKsDUIOqZtVURtSu1WrrqVyg33ifAghb/PGB5fQ+cempLrzWRqYRZ
         +tG3yKJVNVy2tApVzsjgIYotUpOIhQhTKusa8VSZyV2vul/67JlI0YW8pOzQL2//OLNG
         g+hAUg6/JkT9nCQW/pXKM0PESw1mpkbtiyGSaXavh+vg5UWPDnms+BMGdRZEs9Hum1gG
         fC/EWplTWvGaFX3Qyil8tVuq31vmFE8lYHSwYZbSY7NpTar8j4Oen4NI7s6T4BvNxSNB
         uaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JNESj41Yfave5K5Y1y5ILDtVSLYU7s+itRuK/9MSGFY=;
        b=uCuMZAQJLGSHfMXpwmTf8Z6IMX+HVxEfwCDSNty1Vz0W1jiIRxLwmsso6t6VNpWFTg
         Y4Gr4RZtpYhdj4uLHwpp6jryyFCpH5tJuY4wymODsELLAXcrhknp4wggP3JvwGBt+2JE
         Gh1WVGmaUnwqNbtcih1Xsx/1C3Sb5vynM5DRjtOuS2DoLzqysHm2k+leZczSUNrC5Mwl
         WLPjpTVGu8lJ1e0gq5x0J08+BP6Z6uLCLNdVUCGWgUEoHkEDeMyqn6ICmxEGSwVaUj0t
         JycbOfjb/v7JDSH0sinYaopndKNhAE3aiXQ8LvLVzannfgA0dFNuNaHkS2ahxJ6yeN62
         wyJA==
X-Gm-Message-State: AMCzsaUaOJvcYZDWZ4nGW68efs/rgCd3onXUmVpD5oK37FdWTzee50wU
        zGdFUUSnJ6xyeUSkw/TS8G/gGg==
X-Google-Smtp-Source: AOwi7QAQfiIg4nSd5tLODD4BdcVzK/5e9qe77DHyFObZKvHrtUgTBmMcGT78k4IKuzQyxhIZ7as09Q==
X-Received: by 10.223.161.201 with SMTP id v9mr5659290wrv.36.1506869830481;
        Sun, 01 Oct 2017 07:57:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id w82sm10473516wme.5.2017.10.01.07.57.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Oct 2017 07:57:09 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/11] read-cache: roll back lock on error with `COMMIT_LOCK`
Date:   Sun,  1 Oct 2017 16:56:12 +0200
Message-Id: <26a9c90a6478ec9ddb4ce34923e251ebe9323ab2.1506862824.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.727.g9ddaf86
In-Reply-To: <cover.1506862824.git.martin.agren@gmail.com>
References: <cover.1506862824.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `write_locked_index(..., lock, COMMIT_LOCK)` returns, the lockfile
might have been neither committed nor rolled back. This happens if the
call to `do_write_index()` early in `do_write_locked_index()` fails, or
if `write_shared_index()` fails.

Some callers obviously do not expect the lock to remain locked. They
simply kick an error up the call stack without rolling back the lock.
They typically have the lock on the stack, so there is now no way of
releasing it. (Some callers actually do roll back the lock, and many
others simply do not care because they are about to die anyway.) Maybe
we don't try to take the lock again within the same process, so this is
not a problem at the time, but if we ever learn to try, we could
deadlock.

We could teach existing callers to roll back where it matters. That
would introduce some boiler-plate code, and future users might
re-introduce the same mistake. After all, it does seem reasonable to
expect that `COMMIT_LOCK` does what `commit_lockfile()` does: commits or
rolls back.

Teach `write_locked_index(..., COMMIT_LOCK)` to roll back the lock
before returning. If we have already succeeded and committed, it will be
a noop. Simplify the existing callers where we now have a superfluous
call to `rollback_lockfile()`. This should keep future readers from
wondering why the callers are inconsistent.

For the users which `die()` if `write_locked_index()` fails, this change
does not bring any benefit. But it also doesn't hurt -- it simply means
we clean up the lockfile in `do_write_locked_index()` instead of in our
custom `atexit(3)` handler.

Out-of-tree callers will be affected by this change, but they will be
getting the locking-behavior that they almost certainly expect.

For the other flag, `CLOSE_LOCK`, leaving the lock as-is on error is
appropriate, since that is how `close_lockfile_gently()` behaves.
(There are not many in-tree users and they all `die()` on error.)

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 builtin/difftool.c |  1 -
 cache.h            |  1 +
 merge.c            |  4 +---
 read-cache.c       | 13 ++++++++-----
 sequencer.c        |  1 -
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index b2d3ba753..bcc79d188 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -616,7 +616,6 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 			if (hold_lock_file_for_update(&lock, buf.buf, 0) < 0 ||
 			    write_locked_index(&wtindex, &lock, COMMIT_LOCK)) {
 				ret = error("could not write %s", buf.buf);
-				rollback_lock_file(&lock);
 				goto finish;
 			}
 			changed_files(&wt_modified, buf.buf, workdir);
diff --git a/cache.h b/cache.h
index 4d09da792..0da90a545 100644
--- a/cache.h
+++ b/cache.h
@@ -618,6 +618,7 @@ extern int read_index_unmerged(struct index_state *);
  * split index to the lockfile. If the temporary file for the shared
  * index cannot be created, fall back to the normal case.
  *
+ * With `COMMIT_LOCK`, the lock is always committed or rolled back.
  * With `CLOSE_LOCK`, the lock will be neither committed nor rolled back.
  */
 extern int write_locked_index(struct index_state *, struct lock_file *lock, unsigned flags);
diff --git a/merge.c b/merge.c
index a18a452b5..e5d796c9f 100644
--- a/merge.c
+++ b/merge.c
@@ -91,9 +91,7 @@ int checkout_fast_forward(const struct object_id *head,
 	}
 	if (unpack_trees(nr_trees, t, &opts))
 		return -1;
-	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK)) {
-		rollback_lock_file(&lock_file);
+	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		return error(_("unable to write new index file"));
-	}
 	return 0;
 }
diff --git a/read-cache.c b/read-cache.c
index 8e498e879..53f1941c9 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2182,9 +2182,8 @@ static int has_racy_timestamp(struct index_state *istate)
 void update_index_if_able(struct index_state *istate, struct lock_file *lockfile)
 {
 	if ((istate->cache_changed || has_racy_timestamp(istate)) &&
-	    verify_index(istate) &&
-	    write_locked_index(istate, lockfile, COMMIT_LOCK))
-		rollback_lock_file(lockfile);
+	    verify_index(istate))
+		write_locked_index(istate, lockfile, COMMIT_LOCK);
 }
 
 static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
@@ -2498,7 +2497,8 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 	    (istate->cache_changed & ~EXTMASK)) {
 		if (si)
 			hashclr(si->base_sha1);
-		return do_write_locked_index(istate, lock, flags);
+		ret = do_write_locked_index(istate, lock, flags);
+		goto out;
 	}
 
 	if (getenv("GIT_TEST_SPLIT_INDEX")) {
@@ -2514,7 +2514,7 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 	if (new_shared_index) {
 		ret = write_shared_index(istate, lock, flags);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	ret = write_split_index(istate, lock, flags);
@@ -2523,6 +2523,9 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 	if (!ret && !new_shared_index)
 		freshen_shared_index(sha1_to_hex(si->base_sha1), 1);
 
+out:
+	if (flags & COMMIT_LOCK)
+		rollback_lock_file(lock);
 	return ret;
 }
 
diff --git a/sequencer.c b/sequencer.c
index 60636ce54..d56c38081 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1183,7 +1183,6 @@ static int read_and_refresh_cache(struct replay_opts *opts)
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
 	if (the_index.cache_changed && index_fd >= 0) {
 		if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK)) {
-			rollback_lock_file(&index_lock);
 			return error(_("git %s: failed to refresh the index"),
 				_(action_name(opts)));
 		}
-- 
2.14.1.727.g9ddaf86

