Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 698E32070D
	for <e@80x24.org>; Mon, 12 Dec 2016 18:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932155AbcLLSRI (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 13:17:08 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35479 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753656AbcLLSRH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 13:17:07 -0500
Received: by mail-pg0-f52.google.com with SMTP id p66so37773066pga.2
        for <git@vger.kernel.org>; Mon, 12 Dec 2016 10:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vq+qdzWxzYu37YY+zITkSGoTUqkqYohY7DJUSi4GzPE=;
        b=jInqAQCTLHm7+y94/mN9NaW/U7RBC5m+jhcsHCM/UJdYKTHf6eyjwhB4ZH6dFtEGQ/
         UIF3QAuZKI2fqK1SpmRA1rBAv2zLFy/Sj59cWr1n+pRITJ+6lU9deyA1P9jkqmT9uT07
         e+WfjUF+FT/jK0pXQkNIA1Cr4D1Ic09fRIuFca4HPIhDb0MPRhYzGzkDN1ymzqLy61KX
         81t68cterrbmsSJ1CWt/nqI3SrLGEyUsuSyUjqpw4RNOFjj6f4fCoVtd5NYwjetZ6y3X
         RC+J0+cgtvcA8JH2poda+F8JqnbNk9jOx9PUfrn2bmanEIa3huYQTVbvFLzWD2k4RE/O
         PJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vq+qdzWxzYu37YY+zITkSGoTUqkqYohY7DJUSi4GzPE=;
        b=fA4IvKzvGivPsN5cJh9b6C4Q6d30wwuJWK1jDnYOxFEc5R+j2oQb3pyOx1OT4vMNpl
         opstaWVHgu2rem4yt8jUp5xO4O7g5J/YlbExvQqJt3ym4n78qV8xeFZ6LmD3DGCn8P9O
         NcBmCHFVFB6057HbLOoXdSAGCS9J7eTCgLq1zIPXhd42vx62CEPmYQ7AR+JLwnnpZzUY
         I+AskERYC18wdj8FcA71aTuIJd65t3I3wqVpIRXMz6YXV39AIKrkApBS8dmuq8O3MNS1
         934dNxIOvTkFRRX634dJMOTtIEvNZs/bu9MC/gT9ZdQZQ85J42b4S6fkqB+0JfFi4uGk
         SCOA==
X-Gm-Message-State: AKaTC01N+ZLkkuzjp32CcgzsEXKP8LU7vppoy9aMSh7D9mkgIOma+ILmIwLGO6k0Djm+nA5S
X-Received: by 10.99.37.195 with SMTP id l186mr167606768pgl.91.1481566626139;
        Mon, 12 Dec 2016 10:17:06 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id y66sm77644889pgb.21.2016.12.12.10.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Dec 2016 10:17:05 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        peff@peff.net, jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, tboegi@web.de, j6t@kdbg.org,
        pclouds@gmail.com
Subject: [PATCH v3 2/4] real_path: convert real_path_internal to strbuf_realpath
Date:   Mon, 12 Dec 2016 10:16:53 -0800
Message-Id: <1481566615-75299-3-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481566615-75299-1-git-send-email-bmwill@google.com>
References: <1481241494-6861-1-git-send-email-bmwill@google.com>
 <1481566615-75299-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the name of real_path_internal to strbuf_realpath.  In addition
push the static strbuf up to its callers and instead take as a
parameter a pointer to a strbuf to use for the final result.

This change makes strbuf_realpath reentrant.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 abspath.c | 53 +++++++++++++++++++++++++----------------------------
 cache.h   |  2 ++
 2 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/abspath.c b/abspath.c
index cafcae0..8c6c76b 100644
--- a/abspath.c
+++ b/abspath.c
@@ -55,21 +55,17 @@ static void get_next_component(struct strbuf *next, struct strbuf *remaining)
  * Return the real path (i.e., absolute path, with symlinks resolved
  * and extra slashes removed) equivalent to the specified path.  (If
  * you want an absolute path but don't mind links, use
- * absolute_path().)  The return value is a pointer to a static
- * buffer.
+ * absolute_path().)  Places the resolved realpath in the provided strbuf.
  *
  * The directory part of path (i.e., everything up to the last
  * dir_sep) must denote a valid, existing directory, but the last
  * component need not exist.  If die_on_error is set, then die with an
  * informative error message if there is a problem.  Otherwise, return
  * NULL on errors (without generating any output).
- *
- * If path is our buffer, then return path, as it's already what the
- * user wants.
  */
-static const char *real_path_internal(const char *path, int die_on_error)
+char *strbuf_realpath(struct strbuf *resolved, const char *path,
+		      int die_on_error)
 {
-	static struct strbuf resolved = STRBUF_INIT;
 	struct strbuf remaining = STRBUF_INIT;
 	struct strbuf next = STRBUF_INIT;
 	struct strbuf symlink = STRBUF_INIT;
@@ -77,10 +73,6 @@ static const char *real_path_internal(const char *path, int die_on_error)
 	int num_symlinks = 0;
 	struct stat st;
 
-	/* We've already done it */
-	if (path == resolved.buf)
-		return path;
-
 	if (!*path) {
 		if (die_on_error)
 			die("The empty string is not a valid path");
@@ -88,16 +80,16 @@ static const char *real_path_internal(const char *path, int die_on_error)
 			goto error_out;
 	}
 
-	strbuf_reset(&resolved);
+	strbuf_reset(resolved);
 
 	if (is_absolute_path(path)) {
 		/* absolute path; start with only root as being resolved */
 		int offset = offset_1st_component(path);
-		strbuf_add(&resolved, path, offset);
+		strbuf_add(resolved, path, offset);
 		strbuf_addstr(&remaining, path + offset);
 	} else {
 		/* relative path; can use CWD as the initial resolved path */
-		if (strbuf_getcwd(&resolved)) {
+		if (strbuf_getcwd(resolved)) {
 			if (die_on_error)
 				die_errno("unable to get current working directory");
 			else
@@ -116,21 +108,21 @@ static const char *real_path_internal(const char *path, int die_on_error)
 			continue; /* '.' component */
 		} else if (next.len == 2 && !strcmp(next.buf, "..")) {
 			/* '..' component; strip the last path component */
-			strip_last_component(&resolved);
+			strip_last_component(resolved);
 			continue;
 		}
 
 		/* append the next component and resolve resultant path */
-		if (!is_dir_sep(resolved.buf[resolved.len - 1]))
-			strbuf_addch(&resolved, '/');
-		strbuf_addbuf(&resolved, &next);
+		if (!is_dir_sep(resolved->buf[resolved->len - 1]))
+			strbuf_addch(resolved, '/');
+		strbuf_addbuf(resolved, &next);
 
-		if (lstat(resolved.buf, &st)) {
+		if (lstat(resolved->buf, &st)) {
 			/* error out unless this was the last component */
 			if (errno != ENOENT || remaining.len) {
 				if (die_on_error)
 					die_errno("Invalid path '%s'",
-						  resolved.buf);
+						  resolved->buf);
 				else
 					goto error_out;
 			}
@@ -146,12 +138,12 @@ static const char *real_path_internal(const char *path, int die_on_error)
 					goto error_out;
 			}
 
-			len = strbuf_readlink(&symlink, resolved.buf,
+			len = strbuf_readlink(&symlink, resolved->buf,
 					      st.st_size);
 			if (len < 0) {
 				if (die_on_error)
 					die_errno("Invalid symlink '%s'",
-						  resolved.buf);
+						  resolved->buf);
 				else
 					goto error_out;
 			}
@@ -159,8 +151,8 @@ static const char *real_path_internal(const char *path, int die_on_error)
 			if (is_absolute_path(symlink.buf)) {
 				/* absolute symlink; set resolved to root */
 				int offset = offset_1st_component(symlink.buf);
-				strbuf_reset(&resolved);
-				strbuf_add(&resolved, symlink.buf, offset);
+				strbuf_reset(resolved);
+				strbuf_add(resolved, symlink.buf, offset);
 				strbuf_remove(&symlink, 0, offset);
 			} else {
 				/*
@@ -168,7 +160,7 @@ static const char *real_path_internal(const char *path, int die_on_error)
 				 * strip off the last component since it will
 				 * be replaced with the contents of the symlink
 				 */
-				strip_last_component(&resolved);
+				strip_last_component(resolved);
 			}
 
 			/*
@@ -188,24 +180,29 @@ static const char *real_path_internal(const char *path, int die_on_error)
 		}
 	}
 
-	retval = resolved.buf;
+	retval = resolved->buf;
 
 error_out:
 	strbuf_release(&remaining);
 	strbuf_release(&next);
 	strbuf_release(&symlink);
 
+	if (!retval)
+		strbuf_reset(resolved);
+
 	return retval;
 }
 
 const char *real_path(const char *path)
 {
-	return real_path_internal(path, 1);
+	static struct strbuf realpath = STRBUF_INIT;
+	return strbuf_realpath(&realpath, path, 1);
 }
 
 const char *real_path_if_valid(const char *path)
 {
-	return real_path_internal(path, 0);
+	static struct strbuf realpath = STRBUF_INIT;
+	return strbuf_realpath(&realpath, path, 0);
 }
 
 /*
diff --git a/cache.h b/cache.h
index a50a61a..7a81294 100644
--- a/cache.h
+++ b/cache.h
@@ -1064,6 +1064,8 @@ static inline int is_absolute_path(const char *path)
 	return is_dir_sep(path[0]) || has_dos_drive_prefix(path);
 }
 int is_directory(const char *);
+char *strbuf_realpath(struct strbuf *resolved, const char *path,
+		      int die_on_error);
 const char *real_path(const char *path);
 const char *real_path_if_valid(const char *path);
 const char *absolute_path(const char *path);
-- 
2.8.0.rc3.226.g39d4020

