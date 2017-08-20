Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 028F420899
	for <e@80x24.org>; Sun, 20 Aug 2017 20:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753274AbdHTUJm (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 16:09:42 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34810 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753243AbdHTUJl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 16:09:41 -0400
Received: by mail-lf0-f65.google.com with SMTP id t20so731318lfe.1
        for <git@vger.kernel.org>; Sun, 20 Aug 2017 13:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=yS7tJi7UvVb5CUs7p3S3Eqe9E4bkifZ2V0HqmIlZxb0=;
        b=SsGcVDgpTcBmO2ownPYYy+NynHG3orEDuz28+WpdT4r+SxoHYZXFd2Ge2Sm3OL3Sdo
         5H4J4BfkA8Aaxnz5yplSvCmiY6dEkjKHjwh2zCLbO+iNVRvoCXvW25evvCL7kHccymr8
         cz6kcjIdH0baCWtFciV9WgKymVktNZBncNgvwg7zocwl6/sbfb4RCmzrnTcu8PJop5CF
         9LlQfIkIOuHsLPAKy46fFzIlQr/mTIrJzjdSRmzaQ60zI2gwnH584/5msvbPrOIs7uPA
         GKePQH8vPeZWiUcGVJHO/GptS7BMKUTJ3SkpBqvZ9gCpRFtE7XmK3yM4Is4M0L+D86zQ
         Rs9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=yS7tJi7UvVb5CUs7p3S3Eqe9E4bkifZ2V0HqmIlZxb0=;
        b=begwwryk72fGej5/zYIn+XSiGt86CqPhyoh+A80sP8hST/kGNtttKyaF1LsZhpAkfO
         l6fVuaEJnL1+0O76y88Fnu0eP1ymV42K3sNbP8vkYXtnD7f5khSiKs1IMd5WrpIm9GyP
         yLa3U7jLE/0t69yIWb4c5huA+dqyaJctSK8SfSpo6fJTYyyQkbjR0KVeljXYh9hFlrJu
         UUjhzlikhfPTF/Hyxw0yWpUxKzHImhQ1bmerd/SEr3joL5AvK1ubk/6baSbBintx8b6P
         cVlVp0lZPqHG77M3bgOrsNeq0d1xnvrK2q8bTPlgj0iHfv19xK3RY400rmA5OOCKR0oc
         CBBQ==
X-Gm-Message-State: AHYfb5iTe+52OftPJkCA8oM6eqXK06nhSwybmFj9pOA/oih3QyjL8s3n
        TXaT1DUmhF3DZLpy8HA=
X-Received: by 10.46.20.14 with SMTP id u14mr5001130ljd.105.1503259779205;
        Sun, 20 Aug 2017 13:09:39 -0700 (PDT)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id a64sm928869lfl.36.2017.08.20.13.09.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Aug 2017 13:09:38 -0700 (PDT)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 3/6] sha1_file: convert index_path to struct object_id
Date:   Sun, 20 Aug 2017 22:09:28 +0200
Message-Id: <e54161375fa3ff3e292b2bd7bacc6c99a71c88b1.1503258223.git.patryk.obara@gmail.com>
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
 builtin/update-index.c |  2 +-
 cache.h                |  2 +-
 diff.c                 |  2 +-
 notes-merge.c          |  2 +-
 read-cache.c           |  2 +-
 sha1_file.c            | 10 +++++-----
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 56721cf..d562f2e 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -280,7 +280,7 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
 	fill_stat_cache_info(ce, st);
 	ce->ce_mode = ce_mode_from_stat(old, st->st_mode);
 
-	if (index_path(ce->oid.hash, path, st,
+	if (index_path(&ce->oid, path, st,
 		       info_only ? 0 : HASH_WRITE_OBJECT)) {
 		free(ce);
 		return -1;
diff --git a/cache.h b/cache.h
index 1c69d2a..380868d 100644
--- a/cache.h
+++ b/cache.h
@@ -685,7 +685,7 @@ extern int ie_modified(const struct index_state *, const struct cache_entry *, s
 #define HASH_WRITE_OBJECT 1
 #define HASH_FORMAT_CHECK 2
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
-extern int index_path(unsigned char *sha1, const char *path, struct stat *st, unsigned flags);
+extern int index_path(struct object_id *oid, const char *path, struct stat *st, unsigned flags);
 
 /*
  * Record to sd the data from st that we use to check whether a file
diff --git a/diff.c b/diff.c
index 9c38258..65f8d13 100644
--- a/diff.c
+++ b/diff.c
@@ -3246,7 +3246,7 @@ static void diff_fill_oid_info(struct diff_filespec *one)
 			}
 			if (lstat(one->path, &st) < 0)
 				die_errno("stat '%s'", one->path);
-			if (index_path(one->oid.hash, one->path, &st, 0))
+			if (index_path(&one->oid, one->path, &st, 0))
 				die("cannot hash %s", one->path);
 		}
 	}
diff --git a/notes-merge.c b/notes-merge.c
index c12b354..744c685 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -709,7 +709,7 @@ int notes_merge_commit(struct notes_merge_options *o,
 		/* write file as blob, and add to partial_tree */
 		if (stat(path.buf, &st))
 			die_errno("Failed to stat '%s'", path.buf);
-		if (index_path(blob_oid.hash, path.buf, &st, HASH_WRITE_OBJECT))
+		if (index_path(&blob_oid, path.buf, &st, HASH_WRITE_OBJECT))
 			die("Failed to write blob object from '%s'", path.buf);
 		if (add_note(partial_tree, &obj_oid, &blob_oid, NULL))
 			die("Failed to add resolved note '%s' to notes tree",
diff --git a/read-cache.c b/read-cache.c
index 7285608..17f19a1 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -689,7 +689,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 		return 0;
 	}
 	if (!intent_only) {
-		if (index_path(ce->oid.hash, path, st, HASH_WRITE_OBJECT)) {
+		if (index_path(&ce->oid, path, st, HASH_WRITE_OBJECT)) {
 			free(ce);
 			return error("unable to index file %s", path);
 		}
diff --git a/sha1_file.c b/sha1_file.c
index b60ae15..6a2a48b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3686,7 +3686,7 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st,
 	return ret;
 }
 
-int index_path(unsigned char *sha1, const char *path, struct stat *st, unsigned flags)
+int index_path(struct object_id *oid, const char *path, struct stat *st, unsigned flags)
 {
 	int fd;
 	struct strbuf sb = STRBUF_INIT;
@@ -3696,7 +3696,7 @@ int index_path(unsigned char *sha1, const char *path, struct stat *st, unsigned
 		fd = open(path, O_RDONLY);
 		if (fd < 0)
 			return error_errno("open(\"%s\")", path);
-		if (index_fd(sha1, fd, st, OBJ_BLOB, path, flags) < 0)
+		if (index_fd(oid->hash, fd, st, OBJ_BLOB, path, flags) < 0)
 			return error("%s: failed to insert into database",
 				     path);
 		break;
@@ -3704,14 +3704,14 @@ int index_path(unsigned char *sha1, const char *path, struct stat *st, unsigned
 		if (strbuf_readlink(&sb, path, st->st_size))
 			return error_errno("readlink(\"%s\")", path);
 		if (!(flags & HASH_WRITE_OBJECT))
-			hash_sha1_file(sb.buf, sb.len, blob_type, sha1);
-		else if (write_sha1_file(sb.buf, sb.len, blob_type, sha1))
+			hash_sha1_file(sb.buf, sb.len, blob_type, oid->hash);
+		else if (write_sha1_file(sb.buf, sb.len, blob_type, oid->hash))
 			return error("%s: failed to insert into database",
 				     path);
 		strbuf_release(&sb);
 		break;
 	case S_IFDIR:
-		return resolve_gitlink_ref(path, "HEAD", sha1);
+		return resolve_gitlink_ref(path, "HEAD", oid->hash);
 	default:
 		return error("%s: unsupported file type", path);
 	}
-- 
2.9.5

