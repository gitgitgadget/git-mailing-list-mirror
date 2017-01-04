Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39C6D20798
	for <e@80x24.org>; Wed,  4 Jan 2017 22:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968490AbdADWBv (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 17:01:51 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33538 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968469AbdADWBl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 17:01:41 -0500
Received: by mail-pg0-f46.google.com with SMTP id g1so192583682pgn.0
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 14:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T60rgY1zatYKmwESV5GDugr3buBUOmVXSioa7e4BLHo=;
        b=PdcVt3vISOsORUZXkdl0ZLXo11QqKTpphxi6D5rKliSkAXNRNrDb7siLS93p5e1k1a
         v1Q3YTlbf7CCGg/FUM46CbE8FmLR4lr7nj2KCEXb7G738ImwFqU9CjV8eLXRlo9/q8rF
         zCLROHegTbVhcj9Yk+arJUMt//h1zb47KScvbkGPCVeznqEsDehz6xcUmVGmM2R1C4Yb
         2+0VSyebxeDOKyuorcz1yaoN1JcWcYplzubwGUdXHI/DNdhPOqr0GuHJZLDZ7+t13sld
         53VtCPZS10sr5keHfgCOrFq4PR4pRy88N55IyVs53cJWyvibMeBV6GkcJpAz1GqtvpFV
         7+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T60rgY1zatYKmwESV5GDugr3buBUOmVXSioa7e4BLHo=;
        b=QhqtQBIvWSdCU20T9JGj0Jmi2XSmR92u9jmBDVDYGDwPDVeTBmTbNzMOgN/WLoxGaM
         vzxnbN/Og8fDAqDTsjbSgiXVmPErzTQGEzjnTRkpkEm4HdzB4CUbN14ohjz98FT4n0Cb
         rnIdL0+QNFZvYHhEiIIS/GmYSDh9ipBXKYQ8X+5lM44AH0SlqZCqdAnJqquC+aQbtMcT
         d9wr034tIXm0/AAzt1MyYIJZmkdMnbBQ5DTDbu5EiJn2DXs0I3aRKvDdCfZoNXsulk9H
         dmhmu8YkDt1qO+sJnY/JJWSUNkdB3D2wy52bRrciD8qJe48h89RIjHDr6jNwVDUipkKE
         QcpQ==
X-Gm-Message-State: AIkVDXIbwDBNVXGOUmz21Eu2fBwnKzwXGLBBPRCG6h5wAeYh1ry2ZSFE5ryfMXo4IqcFjCTx
X-Received: by 10.84.191.131 with SMTP id a3mr147478972pld.62.1483567295284;
        Wed, 04 Jan 2017 14:01:35 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id n29sm550351pfg.80.2017.01.04.14.01.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jan 2017 14:01:34 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        peff@peff.net, jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, tboegi@web.de, j6t@kdbg.org,
        pclouds@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v5 2/5] real_path: convert real_path_internal to strbuf_realpath
Date:   Wed,  4 Jan 2017 14:01:21 -0800
Message-Id: <20170104220124.145808-3-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170104220124.145808-1-bmwill@google.com>
References: <20170103190923.11882-1-bmwill@google.com>
 <20170104220124.145808-1-bmwill@google.com>
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
index 629201e48..a200d4220 100644
--- a/abspath.c
+++ b/abspath.c
@@ -57,21 +57,17 @@ static void get_next_component(struct strbuf *next, struct strbuf *remaining)
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
@@ -79,10 +75,6 @@ static const char *real_path_internal(const char *path, int die_on_error)
 	int num_symlinks = 0;
 	struct stat st;
 
-	/* We've already done it */
-	if (path == resolved.buf)
-		return path;
-
 	if (!*path) {
 		if (die_on_error)
 			die("The empty string is not a valid path");
@@ -90,16 +82,16 @@ static const char *real_path_internal(const char *path, int die_on_error)
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
@@ -118,21 +110,21 @@ static const char *real_path_internal(const char *path, int die_on_error)
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
@@ -150,12 +142,12 @@ static const char *real_path_internal(const char *path, int die_on_error)
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
@@ -163,8 +155,8 @@ static const char *real_path_internal(const char *path, int die_on_error)
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
@@ -172,7 +164,7 @@ static const char *real_path_internal(const char *path, int die_on_error)
 				 * strip off the last component since it will
 				 * be replaced with the contents of the symlink
 				 */
-				strip_last_component(&resolved);
+				strip_last_component(resolved);
 			}
 
 			/*
@@ -192,24 +184,29 @@ static const char *real_path_internal(const char *path, int die_on_error)
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
index a50a61a19..7a8129403 100644
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
2.11.0.390.gc69c2f50cf-goog

