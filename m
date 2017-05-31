Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFE4A1FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751252AbdEaVpV (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:45:21 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36003 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751240AbdEaVpM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:45:12 -0400
Received: by mail-pf0-f177.google.com with SMTP id m17so18552320pfg.3
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UWKsxm9NH58+kjHiak9z0/HP6RIpvgt6GMsG+FjnVCE=;
        b=Fei5MORife2ZeuWjvk/IsUYlKxehfAQZJOrINvAuxHowFIaBXcO69iQu8Cr/oMmJmA
         qMKqTxTdUhAU5pVGi7I442dI22ZjAYqsb6O+XnykLvjabxBgnU/VI0hq8MC2A6TnjsFk
         zP8BmZvOEPfSzMwujt5A42L3SzcrIBgDhpJJl+G4w7/Qhp4hHftiuAyM6iYhPyfHM7bZ
         ABi2vxtlvjeUN0zF6xb7yOxucflw16MGI50C3ygoOzHzHUfp9eS8gML9YvzXZ8S4xT9L
         CvkKJjzCfWVVEASZMv+1uYQ2lQrtLgyqbiXzuyFLCg/eLrT964S8KDlHwH2noxG+t7oI
         gj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UWKsxm9NH58+kjHiak9z0/HP6RIpvgt6GMsG+FjnVCE=;
        b=Y6TVsZFn4kevhSi+v1D6Ecce2Yl9+/TXtN+FsE9pKw84zchptaU+XbY+qBA1oF4nKI
         IJJMnQ8GY+emrTg8PY2RAQwa/kDOEA+W8SJd/qQGzFH4l28k4AJfIDNyZZ9Mk1Jsq4yq
         59l52889pdPYjXP/6wog/CxNsIK8k/HfmtKn4N2Lzy2zRO4K1SQmmlSJqCIvl8T0oL5P
         bWEDcPsnYKO+9AMvYM6H7UAAWGf8VkcxbE5+bVRpCk/Hyugv4F/CGF598oCxeIiXnSo9
         5LR0AG9ibuHTNBZM2nwaxxtRcItm4WZ+AIhqkR8f+cU4rY5iS/Uy7akHkzaC3vIpynTN
         SdJA==
X-Gm-Message-State: AODbwcA3adGQ/MUcrSivOinj4r0/DAzyTacwF7mFCnCdcZ401Py1bSjP
        iXNw3DvsknzlXqn5ECpCPA==
X-Received: by 10.99.147.68 with SMTP id w4mr35611902pgm.189.1496267100899;
        Wed, 31 May 2017 14:45:00 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 187sm26952745pgj.66.2017.05.31.14.44.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:44:59 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 18/31] convert: convert convert_to_git to take an index
Date:   Wed, 31 May 2017 14:44:04 -0700
Message-Id: <20170531214417.38857-19-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 apply.c         | 2 +-
 builtin/blame.c | 2 +-
 combine-diff.c  | 2 +-
 convert.c       | 7 ++++---
 convert.h       | 8 +++++---
 diff.c          | 6 +++---
 dir.c           | 2 +-
 sha1_file.c     | 4 ++--
 8 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/apply.c b/apply.c
index 87db9618d..8eca54325 100644
--- a/apply.c
+++ b/apply.c
@@ -2268,7 +2268,7 @@ static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
 	case S_IFREG:
 		if (strbuf_read_file(buf, path, st->st_size) != st->st_size)
 			return error(_("unable to open or read %s"), path);
-		convert_to_git(path, buf->buf, buf->len, buf, 0);
+		convert_to_git(&the_index, path, buf->buf, buf->len, buf, 0);
 		return 0;
 	default:
 		return -1;
diff --git a/builtin/blame.c b/builtin/blame.c
index c0ae49298..317d2ec37 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2384,7 +2384,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 		if (strbuf_read(&buf, 0, 0) < 0)
 			die_errno("failed to read from stdin");
 	}
-	convert_to_git(path, buf.buf, buf.len, &buf, 0);
+	convert_to_git(&the_index, path, buf.buf, buf.len, &buf, 0);
 	origin->file.ptr = buf.buf;
 	origin->file.size = buf.len;
 	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_oid.hash);
diff --git a/combine-diff.c b/combine-diff.c
index 2848034fe..74f723af3 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1053,7 +1053,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			if (is_file) {
 				struct strbuf buf = STRBUF_INIT;
 
-				if (convert_to_git(elem->path, result, len, &buf, safe_crlf)) {
+				if (convert_to_git(&the_index, elem->path, result, len, &buf, safe_crlf)) {
 					free(result);
 					result = strbuf_detach(&buf, &len);
 					result_size = len;
diff --git a/convert.c b/convert.c
index 824b606fa..5af6fdf3f 100644
--- a/convert.c
+++ b/convert.c
@@ -1085,7 +1085,8 @@ const char *get_convert_attr_ascii(const char *path)
 	return "";
 }
 
-int convert_to_git(const char *path, const char *src, size_t len,
+int convert_to_git(const struct index_state *istate,
+		   const char *path, const char *src, size_t len,
                    struct strbuf *dst, enum safe_crlf checksafe)
 {
 	int ret = 0;
@@ -1101,7 +1102,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
 		src = dst->buf;
 		len = dst->len;
 	}
-	ret |= crlf_to_git(&the_index, path, src, len, dst, ca.crlf_action, checksafe);
+	ret |= crlf_to_git(istate, path, src, len, dst, ca.crlf_action, checksafe);
 	if (ret && dst) {
 		src = dst->buf;
 		len = dst->len;
@@ -1172,7 +1173,7 @@ int renormalize_buffer(const char *path, const char *src, size_t len, struct str
 		src = dst->buf;
 		len = dst->len;
 	}
-	return ret | convert_to_git(path, src, len, dst, SAFE_CRLF_RENORMALIZE);
+	return ret | convert_to_git(&the_index, path, src, len, dst, SAFE_CRLF_RENORMALIZE);
 }
 
 /*****************************************************************
diff --git a/convert.h b/convert.h
index 3a813a797..60cb41d6a 100644
--- a/convert.h
+++ b/convert.h
@@ -41,15 +41,17 @@ extern const char *get_wt_convert_stats_ascii(const char *path);
 extern const char *get_convert_attr_ascii(const char *path);
 
 /* returns 1 if *dst was used */
-extern int convert_to_git(const char *path, const char *src, size_t len,
+extern int convert_to_git(const struct index_state *istate,
+			  const char *path, const char *src, size_t len,
 			  struct strbuf *dst, enum safe_crlf checksafe);
 extern int convert_to_working_tree(const char *path, const char *src,
 				   size_t len, struct strbuf *dst);
 extern int renormalize_buffer(const char *path, const char *src, size_t len,
 			      struct strbuf *dst);
-static inline int would_convert_to_git(const char *path)
+static inline int would_convert_to_git(const struct index_state *istate,
+				       const char *path)
 {
-	return convert_to_git(path, NULL, 0, NULL, 0);
+	return convert_to_git(istate, path, NULL, 0, NULL, 0);
 }
 /* Precondition: would_convert_to_git_filter_fd(path) == true */
 extern void convert_to_git_filter_fd(const struct index_state *istate,
diff --git a/diff.c b/diff.c
index 2f2467c6d..87ed6d6d3 100644
--- a/diff.c
+++ b/diff.c
@@ -2756,7 +2756,7 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
 	 * Similarly, if we'd have to convert the file contents anyway, that
 	 * makes the optimization not worthwhile.
 	 */
-	if (!want_file && would_convert_to_git(name))
+	if (!want_file && would_convert_to_git(&the_index, name))
 		return 0;
 
 	len = strlen(name);
@@ -2878,7 +2878,7 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 		 * point if the path requires us to run the content
 		 * conversion.
 		 */
-		if (size_only && !would_convert_to_git(s->path))
+		if (size_only && !would_convert_to_git(&the_index, s->path))
 			return 0;
 
 		/*
@@ -2905,7 +2905,7 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 		/*
 		 * Convert from working tree format to canonical git format
 		 */
-		if (convert_to_git(s->path, s->data, s->size, &buf, crlf_warn)) {
+		if (convert_to_git(&the_index, s->path, s->data, s->size, &buf, crlf_warn)) {
 			size_t size = 0;
 			munmap(s->data, s->size);
 			s->should_munmap = 0;
diff --git a/dir.c b/dir.c
index 0c26a53d2..8dc74c5d2 100644
--- a/dir.c
+++ b/dir.c
@@ -796,7 +796,7 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 				 (pos = index_name_pos(istate, fname, strlen(fname))) >= 0 &&
 				 !ce_stage(istate->cache[pos]) &&
 				 ce_uptodate(istate->cache[pos]) &&
-				 !would_convert_to_git(fname))
+				 !would_convert_to_git(istate, fname))
 				hashcpy(sha1_stat->sha1,
 					istate->cache[pos]->oid.hash);
 			else
diff --git a/sha1_file.c b/sha1_file.c
index 80e9ef3bb..a900b2804 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3547,7 +3547,7 @@ static int index_mem(unsigned char *sha1, void *buf, size_t size,
 	 */
 	if ((type == OBJ_BLOB) && path) {
 		struct strbuf nbuf = STRBUF_INIT;
-		if (convert_to_git(path, buf, size, &nbuf,
+		if (convert_to_git(&the_index, path, buf, size, &nbuf,
 				   write_object ? safe_crlf : SAFE_CRLF_FALSE)) {
 			buf = strbuf_detach(&nbuf, &size);
 			re_allocated = 1;
@@ -3669,7 +3669,7 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st,
 	else if (!S_ISREG(st->st_mode))
 		ret = index_pipe(sha1, fd, type, path, flags);
 	else if (st->st_size <= big_file_threshold || type != OBJ_BLOB ||
-		 (path && would_convert_to_git(path)))
+		 (path && would_convert_to_git(&the_index, path)))
 		ret = index_core(sha1, fd, xsize_t(st->st_size), type, path,
 				 flags);
 	else
-- 
2.13.0.506.g27d5fe0cd-goog

