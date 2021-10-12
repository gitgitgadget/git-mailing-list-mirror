Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212BBC433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 14:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09D4A6101D
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 14:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237304AbhJLOdA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 10:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237285AbhJLOc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 10:32:57 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5ED8C06161C
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 07:30:55 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e12so67587659wra.4
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 07:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tIvcClGtL+BLliCpVP559eoCgxMjlmsE5VFLX95xufU=;
        b=CyDS2seH5zwvqN5G6d1xfac+J078MlgZ1bg28Wg/7aVbjKzLPqPPVxwle+1BS6ca5O
         QuDvIkkRtQFR3u3YsJsXe39rHo6MSrqVf9GOW5QcvAMny4xWYrStv3YQd71TqFYkw04b
         K4OlzHuE1axC439Me0Ag1bujogFilcDzsgzpeSFAm/ch0eNAvEVd1/pn4uNVCIDtRzPJ
         MhdFnJZNnqpt7GQlLpG0uy5pe4+8VOtdc1/cMKCVMSZHk2gQi6s9ZniEIl0fuQ09UvPH
         5nfYyRTPqzClS8lL4XqB5EJEniIvVHi3XbcmP9iZEvx2MGRVqs/T71uinB+AzCD9daOh
         OcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tIvcClGtL+BLliCpVP559eoCgxMjlmsE5VFLX95xufU=;
        b=KBjioDERp/a5exzU5b+kmH2YdD0tGF+oE1DI51IQG1MvXBli1A2fV4TtsT/GRIYBOE
         uHsCdQ14qsH2J0xUski74p50ijmYXuTf1v3EYRAfLew0etZ93Rf9FJnk2d7IDaYkU+k8
         1MO8iiK43pIqf+ejE2lTgCz8ePIuEY3jm7MFjahVTtiAuTJYumC+Y7MQufH5UBNgAZmT
         2iHU66QZEM5N6VWMHgrNkS1o3gStuhpwM5ckBWO+IjiznKMImRgE9JSSrUWUWIAWyq2j
         MEKXMPHZMseaHG8ImVEXSZtdbgYOoBixFMxVcGUYfyQ0kMtOQ00OOgRVX2HjnXoeXZSA
         IRkw==
X-Gm-Message-State: AOAM53094CSbSR9ABks7nrFBaLS4W60NS8aRqZI+xx6lfNeiLrSUQ5Fq
        Cc+Lv4zxJHeCyRnSo751heG4jm4Y8WqybA==
X-Google-Smtp-Source: ABdhPJzpp9Og41G8VVqLaeRvABnfhD5Cs9N8nNc6dF4fFnvrxFofoMqd8V6x9biB4o0pV6au87gprg==
X-Received: by 2002:a5d:630b:: with SMTP id i11mr15121875wru.65.1634049054067;
        Tue, 12 Oct 2021 07:30:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l2sm3149791wmi.1.2021.10.12.07.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 07:30:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Turner <novalis@novalis.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] commit: fix duplication regression in permission error output
Date:   Tue, 12 Oct 2021 16:30:49 +0200
Message-Id: <patch-v2-2.2-e6cd47355d5-20211012T142950Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1567.g7b23ce7ed9e
In-Reply-To: <cover-v2-0.2-00000000000-20211012T142950Z-avarab@gmail.com>
References: <patch-2.2-56b20f6024b-20211009T133354Z-avarab@gmail.com> <cover-v2-0.2-00000000000-20211012T142950Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression in the error output emitted when .git/objects can't
be written to. Before 9c4d6c0297b (cache-tree: Write updated
cache-tree after commit, 2014-07-13) we'd emit only one "insufficient
permission" error, now we'll do so again.

The cause is rather straightforward, we've got WRITE_TREE_SILENT for
the use-case of wanting to prepare an index silently, quieting any
permission etc. error output. Then when we attempt to update to
that (possibly broken) index we'll run into the same errors again.

But with 9c4d6c0297b the gap between the cache-tree API and the object
store wasn't closed in terms of asking write_object_file() to be
silent. I.e. post-9c4d6c0297b the first call is to prepare_index(),
and after that we'll call prepare_to_commit(). We only want verbose
error output from the latter.

So let's add and use that facility with a corresponding HASH_SILENT
flag, its only user is cache-tree.c's update_one(), which will set it
if its "WRITE_TREE_SILENT" flag is set.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache-tree.c          |  5 +++--
 cache.h               |  1 +
 object-file.c         | 20 ++++++++++++--------
 object-store.h        | 10 ++++++++--
 t/t0004-unwritable.sh |  2 +-
 5 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 90919f9e345..f21bfc631c6 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -440,8 +440,9 @@ static int update_one(struct cache_tree *it,
 	} else if (dryrun) {
 		hash_object_file(the_hash_algo, buffer.buf, buffer.len,
 				 tree_type, &it->oid);
-	} else if (write_object_file(buffer.buf, buffer.len, tree_type,
-				     &it->oid)) {
+	} else if (write_object_file_flags(buffer.buf, buffer.len, tree_type,
+					   &it->oid, flags & WRITE_TREE_SILENT
+					   ? HASH_SILENT : 0)) {
 		strbuf_release(&buffer);
 		return -1;
 	}
diff --git a/cache.h b/cache.h
index d092820c943..dc58bfa48a0 100644
--- a/cache.h
+++ b/cache.h
@@ -887,6 +887,7 @@ int ie_modified(struct index_state *, const struct cache_entry *, struct stat *,
 #define HASH_WRITE_OBJECT 1
 #define HASH_FORMAT_CHECK 2
 #define HASH_RENORMALIZE  4
+#define HASH_SILENT 8
 int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
 int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
 
diff --git a/object-file.c b/object-file.c
index 112d9b4badc..8fd67b07e45 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1873,7 +1873,7 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename)
 
 static int write_loose_object(const struct object_id *oid, char *hdr,
 			      int hdrlen, const void *buf, unsigned long len,
-			      time_t mtime)
+			      time_t mtime, unsigned flags)
 {
 	int fd, ret;
 	unsigned char compressed[4096];
@@ -1887,7 +1887,9 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 
 	fd = create_tmpfile(&tmp_file, filename.buf);
 	if (fd < 0) {
-		if (errno == EACCES)
+		if (flags & HASH_SILENT)
+			return -1;
+		else if (errno == EACCES)
 			return error(_("insufficient permission for adding an object to repository database %s"), get_object_directory());
 		else
 			return error_errno(_("unable to create temporary file"));
@@ -1937,7 +1939,8 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 		struct utimbuf utb;
 		utb.actime = mtime;
 		utb.modtime = mtime;
-		if (utime(tmp_file.buf, &utb) < 0)
+		if (utime(tmp_file.buf, &utb) < 0 &&
+		    !(flags & HASH_SILENT))
 			warning_errno(_("failed utime() on %s"), tmp_file.buf);
 	}
 
@@ -1962,8 +1965,9 @@ static int freshen_packed_object(const struct object_id *oid)
 	return 1;
 }
 
-int write_object_file(const void *buf, unsigned long len, const char *type,
-		      struct object_id *oid)
+int write_object_file_flags(const void *buf, unsigned long len,
+			    const char *type, struct object_id *oid,
+			    unsigned flags)
 {
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen = sizeof(hdr);
@@ -1975,7 +1979,7 @@ int write_object_file(const void *buf, unsigned long len, const char *type,
 				  &hdrlen);
 	if (freshen_packed_object(oid) || freshen_loose_object(oid))
 		return 0;
-	return write_loose_object(oid, hdr, hdrlen, buf, len, 0);
+	return write_loose_object(oid, hdr, hdrlen, buf, len, 0, flags);
 }
 
 int hash_object_file_literally(const void *buf, unsigned long len,
@@ -1995,7 +1999,7 @@ int hash_object_file_literally(const void *buf, unsigned long len,
 		goto cleanup;
 	if (freshen_packed_object(oid) || freshen_loose_object(oid))
 		goto cleanup;
-	status = write_loose_object(oid, header, hdrlen, buf, len, 0);
+	status = write_loose_object(oid, header, hdrlen, buf, len, 0, 0);
 
 cleanup:
 	free(header);
@@ -2017,7 +2021,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 	if (!buf)
 		return error(_("cannot read object for %s"), oid_to_hex(oid));
 	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(type), (uintmax_t)len) + 1;
-	ret = write_loose_object(oid, hdr, hdrlen, buf, len, mtime);
+	ret = write_loose_object(oid, hdr, hdrlen, buf, len, mtime, 0);
 	free(buf);
 
 	return ret;
diff --git a/object-store.h b/object-store.h
index 1e647a5be30..cea8d38bbd0 100644
--- a/object-store.h
+++ b/object-store.h
@@ -223,8 +223,14 @@ int hash_object_file(const struct git_hash_algo *algo, const void *buf,
 		     unsigned long len, const char *type,
 		     struct object_id *oid);
 
-int write_object_file(const void *buf, unsigned long len,
-		      const char *type, struct object_id *oid);
+int write_object_file_flags(const void *buf, unsigned long len,
+			    const char *type, struct object_id *oid,
+			    unsigned flags);
+static inline int write_object_file(const void *buf, unsigned long len,
+				    const char *type, struct object_id *oid)
+{
+	return write_object_file_flags(buf, len, type, oid, 0);
+}
 
 int hash_object_file_literally(const void *buf, unsigned long len,
 			       const char *type, struct object_id *oid,
diff --git a/t/t0004-unwritable.sh b/t/t0004-unwritable.sh
index 3627ce367c0..2e9d652d826 100755
--- a/t/t0004-unwritable.sh
+++ b/t/t0004-unwritable.sh
@@ -38,7 +38,7 @@ test_expect_success POSIXPERM,SANITY,!SANITIZE_LEAK 'commit should notice unwrit
 '
 
 test_lazy_prereq COMMIT_OUT 'test -e "$TRASH_DIRECTORY"/out.commit'
-test_expect_failure COMMIT_OUT 'commit output on unwritable repository' '
+test_expect_success COMMIT_OUT 'commit output on unwritable repository' '
 	cat >expect <<-\EOF &&
 	error: insufficient permission for adding an object to repository database .git/objects
 	error: Error building trees
-- 
2.33.0.1567.g7b23ce7ed9e

