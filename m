Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C26012027C
	for <e@80x24.org>; Tue, 30 May 2017 17:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751193AbdE3Rbg (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:31:36 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34425 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdE3Rbd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:31:33 -0400
Received: by mail-pf0-f181.google.com with SMTP id 9so78319166pfj.1
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tUu6TJFyhWTKm6j9jR5SLjGkvt3UV/+aIQDMGke9Z5c=;
        b=WW7+nQMJHaW384Rc0O33kCzRIwICZ/IcrH49aigVi+Nb+BvN/DgHhojN8AUq0qjIW0
         gjy8Hfmp1C9D/k78PO0cd8WfA/OiFSjtreRqQXgUgRwdHqiqE3KU2ZPue2rOSQvFbpAS
         Z1Y6440dzir5MPO2km98W8oLt3SR6RUbJAuZ5dzSVyJOFRokft9MgPF/LnyDMmI4WOrf
         et2K01uG2rCMXIPe0NO8EVBlz4klj2TxHH4hgbjQCA7ks66IV98yUiglJZuH/g1ame+k
         D0EeyahDuk/5CVEp4dEEWeeZlFJ6iVAPuvsuU6oqSEN4Y28DLFl6h/982fICYtEHqVM2
         TEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tUu6TJFyhWTKm6j9jR5SLjGkvt3UV/+aIQDMGke9Z5c=;
        b=j+afa3wBAt2n3XJbaFD4zdRCte/MSVwImx/rji/rSI68Z1oaZgNYcro7xQCeyTYRQ8
         xQ1RaS2sI+ANHsx9q+/mGIljwzm/oVR/nz5Q+d6SKrexU8B3/LMpgAZfI+jIXTv5L5pT
         OxFpgZwd0myPT5/F36Z+2L0Oy86WYbiwGfNOSvMVlRJwb0vTrnM6Lh6O9xvKLGKnihj9
         hjydZTySTIBn4eQHlMoc05UWjCHX23+64tTELwO0qjFfBlCl+LViU6p19tTMcDFoSSAj
         x9C9ZQYABFRVSd0RBfRqB10ZXMMNIcnVMJXqe2TLMF4598RNB2kvv2GN8xMBq2yE18kl
         o0Kw==
X-Gm-Message-State: AODbwcDKNIaeKcf5fC4k1jc/DkUR3RtMBBZ9OYcRFSnOw12jISBMX6Zt
        JIL2hhvE/OLXoqiB
X-Received: by 10.84.228.201 with SMTP id y9mr85437062pli.13.1496165487235;
        Tue, 30 May 2017 10:31:27 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.31.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:31:26 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 08/33] grep: convert to struct object_id
Date:   Tue, 30 May 2017 10:30:44 -0700
Message-Id: <20170530173109.54904-9-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the remaining parts of grep to use struct object_id.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/grep.c | 22 +++++++++++-----------
 cache.h        |  7 +++++++
 grep.c         | 17 ++++++++---------
 grep.h         |  2 +-
 4 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index c6c26e9b9..623c13a93 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -327,7 +327,7 @@ static int grep_oid(struct grep_opt *opt, const struct object_id *oid,
 
 #ifndef NO_PTHREADS
 	if (num_threads) {
-		add_work(opt, GREP_SOURCE_SHA1, pathbuf.buf, path, oid);
+		add_work(opt, GREP_SOURCE_OID, pathbuf.buf, path, oid);
 		strbuf_release(&pathbuf);
 		return 0;
 	} else
@@ -336,7 +336,7 @@ static int grep_oid(struct grep_opt *opt, const struct object_id *oid,
 		struct grep_source gs;
 		int hit;
 
-		grep_source_init(&gs, GREP_SOURCE_SHA1, pathbuf.buf, path, oid);
+		grep_source_init(&gs, GREP_SOURCE_OID, pathbuf.buf, path, oid);
 		strbuf_release(&pathbuf);
 		hit = grep_source(opt, &gs);
 
@@ -570,7 +570,7 @@ static int grep_submodule_launch(struct grep_opt *opt,
 	 * with the object's name: 'tree-name:filename'.  In order to
 	 * provide uniformity of output we want to pass the name of the
 	 * parent project's object name to the submodule so the submodule can
-	 * prefix its output with the parent's name and not its own SHA1.
+	 * prefix its output with the parent's name and not its own OID.
 	 */
 	if (gs->identifier && end_of_base)
 		argv_array_pushf(&cp.args, "--parent-basename=%.*s",
@@ -583,12 +583,12 @@ static int grep_submodule_launch(struct grep_opt *opt,
 		 * If there is a tree identifier for the submodule, add the
 		 * rev after adding the submodule options but before the
 		 * pathspecs.  To do this we listen for the '--' and insert the
-		 * sha1 before pushing the '--' onto the child process argv
+		 * oid before pushing the '--' onto the child process argv
 		 * array.
 		 */
 		if (gs->identifier &&
 		    !strcmp("--", submodule_options.argv[i])) {
-			argv_array_push(&cp.args, sha1_to_hex(gs->identifier));
+			argv_array_push(&cp.args, oid_to_hex(gs->identifier));
 		}
 
 		argv_array_push(&cp.args, submodule_options.argv[i]);
@@ -618,11 +618,11 @@ static int grep_submodule_launch(struct grep_opt *opt,
 
 /*
  * Prep grep structures for a submodule grep
- * sha1: the sha1 of the submodule or NULL if using the working tree
+ * oid: the oid of the submodule or NULL if using the working tree
  * filename: name of the submodule including tree name of parent
  * path: location of the submodule
  */
-static int grep_submodule(struct grep_opt *opt, const unsigned char *sha1,
+static int grep_submodule(struct grep_opt *opt, const struct object_id *oid,
 			  const char *filename, const char *path)
 {
 	if (!is_submodule_initialized(path))
@@ -632,7 +632,7 @@ static int grep_submodule(struct grep_opt *opt, const unsigned char *sha1,
 		 * If searching history, check for the presense of the
 		 * submodule's gitdir before skipping the submodule.
 		 */
-		if (sha1) {
+		if (oid) {
 			const struct submodule *sub =
 					submodule_from_path(null_sha1, path);
 			if (sub)
@@ -647,7 +647,7 @@ static int grep_submodule(struct grep_opt *opt, const unsigned char *sha1,
 
 #ifndef NO_PTHREADS
 	if (num_threads) {
-		add_work(opt, GREP_SOURCE_SUBMODULE, filename, path, sha1);
+		add_work(opt, GREP_SOURCE_SUBMODULE, filename, path, oid);
 		return 0;
 	} else
 #endif
@@ -656,7 +656,7 @@ static int grep_submodule(struct grep_opt *opt, const unsigned char *sha1,
 		int hit;
 
 		grep_source_init(&gs, GREP_SOURCE_SUBMODULE,
-				 filename, path, sha1);
+				 filename, path, oid);
 		hit = grep_submodule_launch(opt, &gs);
 
 		grep_source_clear(&gs);
@@ -775,7 +775,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 					 check_attr);
 			free(data);
 		} else if (recurse_submodules && S_ISGITLINK(entry.mode)) {
-			hit |= grep_submodule(opt, entry.oid->hash, base->buf,
+			hit |= grep_submodule(opt, entry.oid, base->buf,
 					      base->buf + tn_len);
 		}
 
diff --git a/cache.h b/cache.h
index ae4c45d37..50fd2b3cc 100644
--- a/cache.h
+++ b/cache.h
@@ -1026,6 +1026,13 @@ static inline void oidcpy(struct object_id *dst, const struct object_id *src)
 	hashcpy(dst->hash, src->hash);
 }
 
+static inline struct object_id *oiddup(const struct object_id *src)
+{
+	struct object_id *dst = xmalloc(sizeof(struct object_id));
+	oidcpy(dst, src);
+	return dst;
+}
+
 static inline void hashclr(unsigned char *hash)
 {
 	memset(hash, 0, GIT_SHA1_RAWSZ);
diff --git a/grep.c b/grep.c
index 47cee4506..a240b4cdb 100644
--- a/grep.c
+++ b/grep.c
@@ -1403,7 +1403,7 @@ static int fill_textconv_grep(struct userdiff_driver *driver,
 	 */
 	df = alloc_filespec(gs->path);
 	switch (gs->type) {
-	case GREP_SOURCE_SHA1:
+	case GREP_SOURCE_OID:
 		fill_filespec(df, gs->identifier, 1, 0100644);
 		break;
 	case GREP_SOURCE_FILE:
@@ -1747,9 +1747,8 @@ void grep_source_init(struct grep_source *gs, enum grep_source_type type,
 		 * If the identifier is non-NULL (in the submodule case) it
 		 * will be a SHA1 that needs to be copied.
 		 */
-	case GREP_SOURCE_SHA1:
-		gs->identifier = xmalloc(20);
-		hashcpy(gs->identifier, identifier);
+	case GREP_SOURCE_OID:
+		gs->identifier = oiddup(identifier);
 		break;
 	case GREP_SOURCE_BUF:
 		gs->identifier = NULL;
@@ -1772,7 +1771,7 @@ void grep_source_clear_data(struct grep_source *gs)
 {
 	switch (gs->type) {
 	case GREP_SOURCE_FILE:
-	case GREP_SOURCE_SHA1:
+	case GREP_SOURCE_OID:
 	case GREP_SOURCE_SUBMODULE:
 		free(gs->buf);
 		gs->buf = NULL;
@@ -1784,7 +1783,7 @@ void grep_source_clear_data(struct grep_source *gs)
 	}
 }
 
-static int grep_source_load_sha1(struct grep_source *gs)
+static int grep_source_load_oid(struct grep_source *gs)
 {
 	enum object_type type;
 
@@ -1795,7 +1794,7 @@ static int grep_source_load_sha1(struct grep_source *gs)
 	if (!gs->buf)
 		return error(_("'%s': unable to read %s"),
 			     gs->name,
-			     sha1_to_hex(gs->identifier));
+			     oid_to_hex(gs->identifier));
 	return 0;
 }
 
@@ -1841,8 +1840,8 @@ static int grep_source_load(struct grep_source *gs)
 	switch (gs->type) {
 	case GREP_SOURCE_FILE:
 		return grep_source_load_file(gs);
-	case GREP_SOURCE_SHA1:
-		return grep_source_load_sha1(gs);
+	case GREP_SOURCE_OID:
+		return grep_source_load_oid(gs);
 	case GREP_SOURCE_BUF:
 		return gs->buf ? 0 : -1;
 	case GREP_SOURCE_SUBMODULE:
diff --git a/grep.h b/grep.h
index 267534ca2..c88b40bdc 100644
--- a/grep.h
+++ b/grep.h
@@ -158,7 +158,7 @@ struct grep_source {
 	char *name;
 
 	enum grep_source_type {
-		GREP_SOURCE_SHA1,
+		GREP_SOURCE_OID,
 		GREP_SOURCE_FILE,
 		GREP_SOURCE_BUF,
 		GREP_SOURCE_SUBMODULE,
-- 
2.13.0.219.gdb65acc882-goog

