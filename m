Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96C561FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 23:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932212AbcLHX6g (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 18:58:36 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:32945 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753087AbcLHX6f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 18:58:35 -0500
Received: by mail-pf0-f180.google.com with SMTP id d2so366842pfd.0
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 15:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iMgH3TwhaFs72uv25ykE7osjayQBD+yqMDcJr4JPF4g=;
        b=Il3kbak3vKZCavE+fQWAagBRDjiPDIdf1CotIENr1SKuqspx7OLKU9OEy6duVlyRFn
         OrZChpY7WzSXhv8sPXxowaNz3FRnWQ0YMV7ideEethL3/zKrVoYlic23VApiwqno5W0y
         b3TCGIdGMcwFvDKS4I2hqxSrT0Q8VsjpvAzFewz560LIOILeP7Sk0uTPva6LuLDkpIif
         WFJeaIVDzRnA4gE9+nUzjD+iNyvoeQUj7C3fNVxhg2/MpUgLhQoeBmItJGp0hqNMjdGf
         5T7PBth0rVKukfh1wLl2POSnK6prqydHUg+/S5vk7+yB1aNNp/vi/Y4LMc1rqT+l4ugS
         fm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iMgH3TwhaFs72uv25ykE7osjayQBD+yqMDcJr4JPF4g=;
        b=BQf2Fh+CKwvQsB0F+Q6S9f5M8zrVSb/RP/6iRZOsTIXDAKD49gvfcPs14lSN0enVr5
         NCe0be0OCog4MIELxobBGtblDvdMlsJQ47OnuVq1yFFy3oNBjWjDdaeqgI03pxqRz1Z2
         Zj/XVGSmsXF6hfgkSQBF/az0pUonFch7V6xq8jFVCDiJy2iwG8yDrq9zm27I4f4Kjb+M
         CdEPrUTnlrTup8n3VeccLvPQb4oVP8dYZ7C4FGsI82ABVXvau0yd/6CYfnVB8mBqeLoO
         PbOA64mqYMdeQ1IvRh3fFyHZoQcorZPA+sn4V4T0a/vanvLr8FkzCpEBTClIztuCWWAZ
         l0dg==
X-Gm-Message-State: AKaTC01xwHPs6SGDq6DYtWBE+gMMe6yuGjn6AvwQ+RwH6/v8fiGkUJDb1Nu6eukC7ArnKrdd
X-Received: by 10.98.28.79 with SMTP id c76mr77254842pfc.8.1481241514103;
        Thu, 08 Dec 2016 15:58:34 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id a7sm52505499pfl.87.2016.12.08.15.58.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 15:58:32 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        peff@peff.net, jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, tboegi@web.de, j6t@kdbg.org,
        pclouds@gmail.com
Subject: [PATCH v2 2/4] real_path: convert real_path_internal to strbuf_realpath
Date:   Thu,  8 Dec 2016 15:58:12 -0800
Message-Id: <1481241494-6861-3-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481241494-6861-1-git-send-email-bmwill@google.com>
References: <1480964316-99305-1-git-send-email-bmwill@google.com>
 <1481241494-6861-1-git-send-email-bmwill@google.com>
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
index 92f2a29..b0d4c1b 100644
--- a/abspath.c
+++ b/abspath.c
@@ -48,21 +48,17 @@ static void get_next_component(struct strbuf *next, struct strbuf *remaining)
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
@@ -70,10 +66,6 @@ static const char *real_path_internal(const char *path, int die_on_error)
 	int num_symlinks = 0;
 	struct stat st;
 
-	/* We've already done it */
-	if (path == resolved.buf)
-		return path;
-
 	if (!*path) {
 		if (die_on_error)
 			die("The empty string is not a valid path");
@@ -81,16 +73,16 @@ static const char *real_path_internal(const char *path, int die_on_error)
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
@@ -109,21 +101,21 @@ static const char *real_path_internal(const char *path, int die_on_error)
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
 			if (!(errno == ENOENT && !remaining.len)) {
 				if (die_on_error)
 					die_errno("Invalid path '%s'",
-						  resolved.buf);
+						  resolved->buf);
 				else
 					goto error_out;
 			}
@@ -139,12 +131,12 @@ static const char *real_path_internal(const char *path, int die_on_error)
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
@@ -152,8 +144,8 @@ static const char *real_path_internal(const char *path, int die_on_error)
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
@@ -161,7 +153,7 @@ static const char *real_path_internal(const char *path, int die_on_error)
 				 * strip off the last component since it will
 				 * be replaced with the contents of the symlink
 				 */
-				strip_last_component(&resolved);
+				strip_last_component(resolved);
 			}
 
 			/*
@@ -181,24 +173,29 @@ static const char *real_path_internal(const char *path, int die_on_error)
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

