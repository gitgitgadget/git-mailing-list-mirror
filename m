Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF12C55181
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 22:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 862AF2145D
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 22:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Y2+yecA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgDTWvJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgDTWvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Apr 2020 18:51:09 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39705C061A0E
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 15:51:09 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g6so5810351pgs.9
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 15:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FdJ/GzC5Jea/0R271A3mvu0HuvaEirllFgWXt1QNESE=;
        b=Y2+yecA+PAmpwDExs9amDLuM5TMJGzao1OYYhCet9HLvKU+02BeFQ9jM/sD0B5u/8J
         6kXGMdX+BPE43PsaeDZCjFHWyy4WILthGOWiQjUQGphOSOo/OEReqOSJp0rnNRsyxoT/
         8E4Oy16KHLyLqtkmrDmPbCeDs7QHA+Jqed8ZC8c5SsAONXVkcClyB+lqj6LGn52mHroy
         rQGTHyl954RcC6V5r7FdLg74OdF0Nw8Ri4Jl3lpADeOrTxzVWYMnSZR+WXRswe1u+KUM
         BpZMGLdSGSSGRVocUkOKdT+JffNgYIxYGQUW28NgJY4oDbklgufLDZpGVe5kw90FePZK
         Zlnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FdJ/GzC5Jea/0R271A3mvu0HuvaEirllFgWXt1QNESE=;
        b=G5ufbd22p/SPwQDxI6ihEH6y+RjbZ/OiuvRgIiI++T51R57K9rX1va7/PmW+hT2glT
         oHBjm6/mAfsVBTB7uGUnnV5Q1WCHNmC8AmAsf5HhzzcwrXyg4omW0Uhcwn1RNmx6lGmx
         IP4FFgtkgTkquCTL0CjQjQn/EsCaKJTDjOT/WYrkVApPpaFkXEKjQFmI0SzBBOCf9lzf
         y8zEegJKdsvHOo7qSWZqPnf5exSTGUqwisp4hN6gClf9En1DvH7NcSOMDK8SP2aX2uZH
         h/s9F/cVAz88RkwxEANqu5lS+zLLlK2OIhboyfjAvdA7y+OnINi+fBhuIvs07BOLbGNa
         NDNg==
X-Gm-Message-State: AGi0PubY0/ruRJZoomnVt2iB9n1VohHDk4TpYZzMFplbq805hze42k3B
        0edidew+dlFcjVFFpp7pSnHHn6x9UQJ6iQ==
X-Google-Smtp-Source: APiQypJ/1+nAVc4qOq5TR3zurPg8tnkeGv48s0kkfl344qv/JV54tMHXMXfuK11C/N9D+8qjz/f9yg==
X-Received: by 2002:aa7:9dc7:: with SMTP id g7mr16858745pfq.291.1587423068268;
        Mon, 20 Apr 2020 15:51:08 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id 23sm418727pjb.11.2020.04.20.15.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:51:07 -0700 (PDT)
Date:   Mon, 20 Apr 2020 16:51:06 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, mhagger@alum.mit.edu, peff@peff.net
Subject: [PATCH 2/3] lockfile.c: introduce 'hold_lock_file_for_update_mode'
Message-ID: <dad37d42334954d40f308a4fc3189a925f90df66.1587422630.git.me@ttaylorr.com>
References: <cover.1587422630.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1587422630.git.me@ttaylorr.com>
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

Note that even though the commit-graph machinery only calls
'hold_lock_file_for_update', that this is defined in terms of
'hold_lock_file_for_update_timeout', and so both need an additional mode
parameter here.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 lockfile.c | 18 ++++++++++--------
 lockfile.h | 19 +++++++++++++++++--
 2 files changed, 27 insertions(+), 10 deletions(-)

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
index 9843053ce8..12f25279b5 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -159,9 +159,17 @@ struct lock_file {
  * timeout_ms is -1, retry indefinitely. The flags argument and error
  * handling are described above.
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
@@ -175,6 +183,13 @@ static inline int hold_lock_file_for_update(
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
2.26.1.108.gadb95c98e4

