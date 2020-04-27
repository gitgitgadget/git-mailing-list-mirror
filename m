Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152C0C54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 16:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB112206B9
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 16:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="CJqfwpFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgD0Q2B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727104AbgD0Q2B (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 12:28:01 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C3EC0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 09:28:01 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f7so9230183pfa.9
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 09:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m8WPRTZAA4ifjAR9b5/RmtGZJzGpRFy5RWTfVKbAGNM=;
        b=CJqfwpFq3lRBuolgeA0oDAilQpD4Zoe9CXZUEF5FDCysReBjF/DZaSVVLx9bD6yZ4A
         KszWu74mjP4ldsZmmt02Kge5Zwj9FWvvrMbky90j7LiYhh0GUrqSx4kEFk8wFw416LUl
         GqbHpT8O6OS6y/3mnPpD/WwdEgICv9PYvOZ6LOXvlDkqjNLqmIxtGRjwveG3YIGSoC+2
         7GC0fwycavB2wWAvIteqFzKuFp1/uL2e6oJINfDeZYz+O+Dy44wsZ02eUGF/eJzlgj8J
         v/EDuTR0XayTzCRisOB/2AL2mhdQFimhVkq0dv1+CdsnvezskM5BPJmZsEiy5m148ylT
         0eTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m8WPRTZAA4ifjAR9b5/RmtGZJzGpRFy5RWTfVKbAGNM=;
        b=diPgbNAGMgHLQfLfTkQDFngZWbfBl1d8YqLmLCbb+H0bH2f7AkxTtlk3BElInKSG+w
         8KVwp5PJvtfZW7ZVYoMdiaDilw1xDAi77M+2TbgUyLCH2nHZ48ohHrH6Be0Lc1R83eMt
         tczIEf4JBC8/o73kzm/w5sfuZjryhLXunL+4l42iYuGcM920rir+psqjH1AvY3OEnHT+
         qNMOJvTJAEwcQYcHdXYJzURYTBprYTL9/rxJ4Wx0tw0bG2AgnFmu0nDNjxQFtsy8EsAl
         IhtxGECo0gl//011vOIMytYeBHT4oB3SqH4S4dPQf0k+iF6AkR/4R0VsMct8bOnL4y+f
         evSQ==
X-Gm-Message-State: AGi0Puas1kXiVdZdnVb7lkr74EDt3LdYbYuuohCsgSxy/+qR9JQDMKcI
        9eJKrn5A82OG7iMa3PwXQ1ErGMOZnCFN6A==
X-Google-Smtp-Source: APiQypI9VD7YxWoL1BoErssfImBDbB8Tq4mpej9cEpi++A5aGBTZOa5EYTn6jMe4lIgjGYRfQL+uXQ==
X-Received: by 2002:a63:8ac4:: with SMTP id y187mr23593296pgd.294.1588004880298;
        Mon, 27 Apr 2020 09:28:00 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id n19sm3097903pgd.19.2020.04.27.09.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 09:27:59 -0700 (PDT)
Date:   Mon, 27 Apr 2020 10:27:58 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        mhagger@alum.mit.edu
Subject: [PATCH v2 2/4] lockfile.c: introduce 'hold_lock_file_for_update_mode'
Message-ID: <c1c84552bc69218299ce182388b6a888b3c71056.1588004647.git.me@ttaylorr.com>
References: <cover.1587422630.git.me@ttaylorr.com>
 <cover.1588004647.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588004647.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We use 'hold_lock_file_for_update' (and the '_timeout') variant to
acquire a lock when updating references, the commit-graph file, and so
on.

In particular, the commit-graph machinery uses this to acquire a
temporary file that is used to write a non-split commit-graph. In a
subsequent commit, an issue in the commit-graph machinery produces
graph files that have a different permission based on whether or not
they are part of a multi-layer graph will be addressed.

To do so, the commit-graph machinery will need a version of
'hold_lock_file_for_update' that takes the permission bits from the
caller.

Introduce such a function in this patch for both the
'hold_lock_file_for_update' and 'hold_lock_file_for_update_timeout'
functions, and leave the existing functions alone by inlining their
definitions in terms of the new mode variants.

Note that, like in the previous commit, 'hold_lock_file_for_update_mode'
is not guarenteed to set the given mode, since it may be modified by
both the umask and 'core.sharedRepository'.

Note also that even though the commit-graph machinery only calls
'hold_lock_file_for_update', that this is defined in terms of
'hold_lock_file_for_update_timeout', and so both need an additional mode
parameter here.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 lockfile.c | 18 ++++++++++--------
 lockfile.h | 32 ++++++++++++++++++++++++++++----
 2 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 8e8ab4f29f..cc9a4b8428 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -70,7 +70,8 @@ static void resolve_symlink(struct strbuf *path)
 }
 
 /* Make sure errno contains a meaningful value on error */
-static int lock_file(struct lock_file *lk, const char *path, int flags)
+static int lock_file(struct lock_file *lk, const char *path, int flags,
+		     int mode)
 {
 	struct strbuf filename = STRBUF_INIT;
 
@@ -79,7 +80,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 		resolve_symlink(&filename);
 
 	strbuf_addstr(&filename, LOCK_SUFFIX);
-	lk->tempfile = create_tempfile(filename.buf);
+	lk->tempfile = create_tempfile_mode(filename.buf, mode);
 	strbuf_release(&filename);
 	return lk->tempfile ? lk->tempfile->fd : -1;
 }
@@ -99,7 +100,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
  * exactly once. If timeout_ms is -1, try indefinitely.
  */
 static int lock_file_timeout(struct lock_file *lk, const char *path,
-			     int flags, long timeout_ms)
+			     int flags, long timeout_ms, int mode)
 {
 	int n = 1;
 	int multiplier = 1;
@@ -107,7 +108,7 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
 	static int random_initialized = 0;
 
 	if (timeout_ms == 0)
-		return lock_file(lk, path, flags);
+		return lock_file(lk, path, flags, mode);
 
 	if (!random_initialized) {
 		srand((unsigned int)getpid());
@@ -121,7 +122,7 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
 		long backoff_ms, wait_ms;
 		int fd;
 
-		fd = lock_file(lk, path, flags);
+		fd = lock_file(lk, path, flags, mode);
 
 		if (fd >= 0)
 			return fd; /* success */
@@ -169,10 +170,11 @@ NORETURN void unable_to_lock_die(const char *path, int err)
 }
 
 /* This should return a meaningful errno on failure */
-int hold_lock_file_for_update_timeout(struct lock_file *lk, const char *path,
-				      int flags, long timeout_ms)
+int hold_lock_file_for_update_timeout_mode(struct lock_file *lk,
+					   const char *path, int flags,
+					   long timeout_ms, int mode)
 {
-	int fd = lock_file_timeout(lk, path, flags, timeout_ms);
+	int fd = lock_file_timeout(lk, path, flags, timeout_ms, mode);
 	if (fd < 0) {
 		if (flags & LOCK_DIE_ON_ERROR)
 			unable_to_lock_die(path, errno);
diff --git a/lockfile.h b/lockfile.h
index 9843053ce8..db93e6ba73 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -90,6 +90,15 @@
  * functions. In particular, the state diagram and the cleanup
  * machinery are all implemented in the tempfile module.
  *
+ * Permission bits
+ * ---------------
+ *
+ * If you call either `hold_lock_file_for_update_mode` or
+ * `hold_lock_file_for_update_timeout_mode`, you can specify a suggested
+ * mode for the underlying temporary file. Note that the file isn't
+ * guaranteed to have this exact mode, since it may be limited by either
+ * the umask, 'core.sharedRepository', or both. See `adjust_shared_perm`
+ * for more.
  *
  * Error handling
  * --------------
@@ -156,12 +165,20 @@ struct lock_file {
  * file descriptor for writing to it, or -1 on error. If the file is
  * currently locked, retry with quadratic backoff for at least
  * timeout_ms milliseconds. If timeout_ms is 0, try exactly once; if
- * timeout_ms is -1, retry indefinitely. The flags argument and error
- * handling are described above.
+ * timeout_ms is -1, retry indefinitely. The flags argument, error
+ * handling, and mode are described above.
  */
-int hold_lock_file_for_update_timeout(
+int hold_lock_file_for_update_timeout_mode(
 		struct lock_file *lk, const char *path,
-		int flags, long timeout_ms);
+		int flags, long timeout_ms, int mode);
+
+static inline int hold_lock_file_for_update_timeout(
+		struct lock_file *lk, const char *path,
+		int flags, long timeout_ms)
+{
+	return hold_lock_file_for_update_timeout_mode(lk, path, flags,
+						      timeout_ms, 0666);
+}
 
 /*
  * Attempt to create a lockfile for the file at `path` and return a
@@ -175,6 +192,13 @@ static inline int hold_lock_file_for_update(
 	return hold_lock_file_for_update_timeout(lk, path, flags, 0);
 }
 
+static inline int hold_lock_file_for_update_mode(
+		struct lock_file *lk, const char *path,
+		int flags, int mode)
+{
+	return hold_lock_file_for_update_timeout_mode(lk, path, flags, 0, mode);
+}
+
 /*
  * Return a nonzero value iff `lk` is currently locked.
  */
-- 
2.26.0.113.ge9739cdccc

