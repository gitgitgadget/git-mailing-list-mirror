Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CEF5208D0
	for <e@80x24.org>; Sun, 20 Aug 2017 20:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753303AbdHTUJ4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 16:09:56 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35078 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753226AbdHTUJl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 16:09:41 -0400
Received: by mail-lf0-f67.google.com with SMTP id h89so2450484lfi.2
        for <git@vger.kernel.org>; Sun, 20 Aug 2017 13:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Bc5loRXQLGLLvWX0AFk81YWAodPECpM/RyTku5kYhWs=;
        b=twFLvunR76qc+g0fF+EuIkxlYjasyKEXif/oPwgaTLQdMGOCwUeerruDm5CszhISwj
         f1J/DC0MebMj31Ly1hR4nLeJ5UvyGMuAF2iPFIQuBY0UDXEvHv5TYp7IQ+4COqyR9T12
         2awUQldqLtClfz6+Z6V933d0JZCvvqwpmYYkz16fDt4VZHJmUcnOHm5MdQUtMZ7hJVv4
         yooBnydB+xahvQ02Eiuvs0FXU1pfq1Hu3Aqmb+PaYFzJtnkFxOMX6geF2Eb2X+qY/4EX
         8s2JSxTC3SnwbiBF8fW6PYexKNcOGoWWRTd740SuXgsNUkqYlv9wlo9ofwmWFOj2+9Cx
         qfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=Bc5loRXQLGLLvWX0AFk81YWAodPECpM/RyTku5kYhWs=;
        b=K8X/TAK3blx9j4HP+z1nlNA30sHLhDyJsANXsnBmSwjO5cEM9KeyorqFz6cqGc7+E7
         FK6TwpchRW0yo8Vn2EgyPK4DGVuNjcvZjnOClVFO3rSPDSOGEysb3NwwK6HxRibDV4KZ
         50OlvgpYVFCetw5LMOmFQCxyMjNgZ7hMrrnNkMTPfoYrvDtVnljKKQgO27cgZv4P1g1p
         h7E1WF4mwxGuTuDoTGYUnQrqKqvct6BzFecb2+xHMSKOObINkiimOu3TzAufH+usAHCy
         eBI9XSlXjlocI481/kH8DUCo9A3keJoFZ6AAfLDilN97YW8EK39wPBF/XZLC5eE2oPc/
         AFdQ==
X-Gm-Message-State: AHYfb5hzSmOSP8dxavnt5JwF25/w6GnE354lr5JOB4KDZiGE9fWsC3RG
        vTYS16/dBbvfpFS8L0M=
X-Received: by 10.46.92.137 with SMTP id q131mr5417405ljb.102.1503259780178;
        Sun, 20 Aug 2017 13:09:40 -0700 (PDT)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id a64sm928869lfl.36.2017.08.20.13.09.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Aug 2017 13:09:39 -0700 (PDT)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 4/6] sha1_file: convert index_fd to struct object_id
Date:   Sun, 20 Aug 2017 22:09:29 +0200
Message-Id: <6e77d1e53ed00ce638944c4b87be9c533daa27c0.1503258223.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1503258223.git.patryk.obara@gmail.com>
References: <cover.1503258223.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1503258223.git.patryk.obara@gmail.com>
References: <cover.1503258223.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert all remaining callers as well.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 builtin/difftool.c    |  2 +-
 builtin/hash-object.c |  2 +-
 builtin/replace.c     |  2 +-
 cache.h               |  2 +-
 read-cache.c          |  2 +-
 sha1_file.c           | 14 +++++++-------
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 8864d84..b2d3ba7 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -111,7 +111,7 @@ static int use_wt_file(const char *workdir, const char *name,
 		int fd = open(buf.buf, O_RDONLY);
 
 		if (fd >= 0 &&
-		    !index_fd(wt_oid.hash, fd, &st, OBJ_BLOB, name, 0)) {
+		    !index_fd(&wt_oid, fd, &st, OBJ_BLOB, name, 0)) {
 			if (is_null_oid(oid)) {
 				oidcpy(oid, &wt_oid);
 				use = 1;
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 1c0f0f3..8a58ce0 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -38,7 +38,7 @@ static void hash_fd(int fd, const char *type, const char *path, unsigned flags,
 	if (fstat(fd, &st) < 0 ||
 	    (literally
 	     ? hash_literally(&oid, fd, type, flags)
-	     : index_fd(oid.hash, fd, &st, type_from_string(type), path, flags)))
+	     : index_fd(&oid, fd, &st, type_from_string(type), path, flags)))
 		die((flags & HASH_WRITE_OBJECT)
 		    ? "Unable to add %s to database"
 		    : "Unable to hash %s", path);
diff --git a/builtin/replace.c b/builtin/replace.c
index f4a85a1..3e71a77 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -269,7 +269,7 @@ static void import_object(struct object_id *oid, enum object_type type,
 
 		if (fstat(fd, &st) < 0)
 			die_errno("unable to fstat %s", filename);
-		if (index_fd(oid->hash, fd, &st, type, NULL, flags) < 0)
+		if (index_fd(oid, fd, &st, type, NULL, flags) < 0)
 			die("unable to write object to database");
 		/* index_fd close()s fd for us */
 	}
diff --git a/cache.h b/cache.h
index 380868d..eaf3603 100644
--- a/cache.h
+++ b/cache.h
@@ -684,7 +684,7 @@ extern int ie_modified(const struct index_state *, const struct cache_entry *, s
 
 #define HASH_WRITE_OBJECT 1
 #define HASH_FORMAT_CHECK 2
-extern int index_fd(unsigned char *sha1, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
+extern int index_fd(struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
 extern int index_path(struct object_id *oid, const char *path, struct stat *st, unsigned flags);
 
 /*
diff --git a/read-cache.c b/read-cache.c
index 17f19a1..9b41058 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -161,7 +161,7 @@ static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
 
 	if (fd >= 0) {
 		struct object_id oid;
-		if (!index_fd(oid.hash, fd, st, OBJ_BLOB, ce->name, 0))
+		if (!index_fd(&oid, fd, st, OBJ_BLOB, ce->name, 0))
 			match = oidcmp(&oid, &ce->oid);
 		/* index_fd() closed the file descriptor already */
 	}
diff --git a/sha1_file.c b/sha1_file.c
index 6a2a48b..11995e5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3662,8 +3662,8 @@ static int index_stream(unsigned char *sha1, int fd, size_t size,
 	return index_bulk_checkin(sha1, fd, size, type, path, flags);
 }
 
-int index_fd(unsigned char *sha1, int fd, struct stat *st,
-	     enum object_type type, const char *path, unsigned flags)
+int index_fd(struct object_id *oid, int fd, struct stat *st,
+             enum object_type type, const char *path, unsigned flags)
 {
 	int ret;
 
@@ -3672,15 +3672,15 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st,
 	 * die() for large files.
 	 */
 	if (type == OBJ_BLOB && path && would_convert_to_git_filter_fd(path))
-		ret = index_stream_convert_blob(sha1, fd, path, flags);
+		ret = index_stream_convert_blob(oid->hash, fd, path, flags);
 	else if (!S_ISREG(st->st_mode))
-		ret = index_pipe(sha1, fd, type, path, flags);
+		ret = index_pipe(oid->hash, fd, type, path, flags);
 	else if (st->st_size <= big_file_threshold || type != OBJ_BLOB ||
 		 (path && would_convert_to_git(&the_index, path)))
-		ret = index_core(sha1, fd, xsize_t(st->st_size), type, path,
+		ret = index_core(oid->hash, fd, xsize_t(st->st_size), type, path,
 				 flags);
 	else
-		ret = index_stream(sha1, fd, xsize_t(st->st_size), type, path,
+		ret = index_stream(oid->hash, fd, xsize_t(st->st_size), type, path,
 				   flags);
 	close(fd);
 	return ret;
@@ -3696,7 +3696,7 @@ int index_path(struct object_id *oid, const char *path, struct stat *st, unsigne
 		fd = open(path, O_RDONLY);
 		if (fd < 0)
 			return error_errno("open(\"%s\")", path);
-		if (index_fd(oid->hash, fd, st, OBJ_BLOB, path, flags) < 0)
+		if (index_fd(oid, fd, st, OBJ_BLOB, path, flags) < 0)
 			return error("%s: failed to insert into database",
 				     path);
 		break;
-- 
2.9.5

