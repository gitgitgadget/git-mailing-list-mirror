Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BD7C07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 19:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFA7E61355
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 19:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhGJTEO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 15:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhGJTEO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 15:04:14 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD99C0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 12:01:28 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i94so17451052wri.4
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 12:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=jeezaSl7uZGVhkmBRsj4CxnttQKGgH5BvMS2CMtzrXk=;
        b=V+KFfB57luHuYZeiL6zEIh51yBk8wlsGyMPH/+gHyST1+4XYk4v+sCEg7G+G2jhe/m
         DdrT04Zby2BJaqEBxg7tuyB+vyNWP/Et+9ZB0RKHF/QqWIJcPY7B1xxrnXArGGugWdfN
         IJBtx4ZmLBA4eQoHziNcB8TEjtwHBclfO153n2cD2r5A7F3vq3MJsXJqMBmY5jRBouPn
         VXOgvM9PBKTRD36C8DzRMZe4/xUwN8HKOMpEuyW4QFD6NL+rxhSnbvPQ+LPJjKWhBQPF
         p5dzB4KE1apHxH6ngYezqJq4RzzSmYZfVKGxIxlSGRDbMSh/SfoBL5iLfB8HK6fR4DzP
         rwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jeezaSl7uZGVhkmBRsj4CxnttQKGgH5BvMS2CMtzrXk=;
        b=PYMsYl7x86S2W9otQXrwoWrTeb7DbhLg3rGJfz4B5YUCpHW4rBEMmP5ok8n9Di6XAE
         iw/vlGRqdDCCqEZOWVlulvK5mLMHBsL0ZGnr3icejZMzepiB+ql0gqTvej0swZPY48Z4
         hRV16bV4IdmPWICtdFx2++axyYYNLqx/yfExhV9fPiZLMIvrKTIzoSnFIQaK4SjqSiBU
         3hxaG9QTOFTBtOLqe/+YDH57GKEE7GhACvkuZz21E+J1O9hsMF5sq3GU//AxxYUki/sv
         w3JdE1KHZbLmmsKeBds5Jl+DwJlftg6YnjczLZPtBCLkJA9heaJ2PTjIpp0Wd3xE5sc2
         APgw==
X-Gm-Message-State: AOAM532Q1/VnwjoQ/0am742DPM+PXa7FRDLn5X4ieNMPPYNjcLvtWPH8
        ZWRbmOSzmmLNtAPq0AHNW8iYXarGdmU=
X-Google-Smtp-Source: ABdhPJziz/f2dupzIYiRuqdi0I+xfTRQ3TU85FLAELuqR0+GRQzyR97dLaKTLbyHEM2/6vSBZI8hkg==
X-Received: by 2002:adf:ec86:: with SMTP id z6mr23003187wrn.320.1625943687062;
        Sat, 10 Jul 2021 12:01:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l17sm14843469wmq.3.2021.07.10.12.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 12:01:26 -0700 (PDT)
Message-Id: <pull.1043.git.git.1625943685565.gitgitgadget@gmail.com>
From:   "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Jul 2021 19:01:25 +0000
Subject: [PATCH] packfile: enhance the mtime of packfile by idx file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sun Chao <16657101987@163.com>, Sun Chao <16657101987@163.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sun Chao <16657101987@163.com>

Commit 33d4221c79 (write_sha1_file: freshen existing objects,
2014-10-15) avoid writing existing objects by freshen their
mtime (especially the packfiles contains them) in order to
aid the correct caching, and some process like find_lru_pack
can make good decision. However, this is unfriendly to
incremental backup jobs or services rely on file system
cache when there are large '.pack' files exists.

For example, after packed all objects, use 'write-tree' to
create same commit with the same tree and same environments
such like GIT_COMMITTER_DATE and GIT_AUTHOR_DATE, we can
notice the '.pack' file's mtime changed, but '.idx' file not.

So if we update the mtime of packfile by updating the '.idx'
file instead of '.pack' file, when we check the mtime
of packfile, get it from '.idx' file instead. Large git
repository may contains large '.pack' files, but '.idx'
files are smaller enough, this can avoid file system cache
reload the large files again and speed up git commands.

Signed-off-by: Sun Chao <16657101987@163.com>
---
    packfile: enhance the mtime of packfile by idx file
    
    Commit 33d4221c79 (write_sha1_file: freshen existing objects,
    2014-10-15) avoid writing existing objects by freshen their mtime
    (especially the packfiles contains them) in order to aid the correct
    caching, and some process like find_lru_pack can make good decision.
    However, this is unfriendly to incremental backup jobs or services rely
    on file system cache when there are large '.pack' files exists.
    
    For example, after packed all objects, use 'write-tree' to create same
    commit with the same tree and same environments such like
    GIT_COMMITTER_DATE and GIT_AUTHOR_DATE, we can notice the '.pack' file's
    mtime changed, but '.idx' file not.
    
    So if we update the mtime of packfile by updating the '.idx' file
    instead of '.pack' file, when we check the mtime of packfile, get it
    from '.idx' file instead. Large git repository may contains large
    '.pack' files, but '.idx' files are smaller enough, this can avoid file
    system cache reload the large files again and speed up git commands.
    
    Signed-off-by: Sun Chao 16657101987@163.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1043%2Fsunchao9%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1043/sunchao9/master-v1
Pull-Request: https://github.com/git/git/pull/1043

 builtin/index-pack.c                 | 19 +++----------------
 object-file.c                        |  7 ++++++-
 packfile.c                           | 19 ++++++++++++++++++-
 packfile.h                           |  7 +++++++
 t/t7701-repack-unpack-unreachable.sh |  2 +-
 5 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3fbc5d70777..60bacc8ee7f 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1437,19 +1437,6 @@ static void fix_unresolved_deltas(struct hashfile *f)
 	free(sorted_by_pos);
 }
 
-static const char *derive_filename(const char *pack_name, const char *strip,
-				   const char *suffix, struct strbuf *buf)
-{
-	size_t len;
-	if (!strip_suffix(pack_name, strip, &len) || !len ||
-	    pack_name[len - 1] != '.')
-		die(_("packfile name '%s' does not end with '.%s'"),
-		    pack_name, strip);
-	strbuf_add(buf, pack_name, len);
-	strbuf_addstr(buf, suffix);
-	return buf->buf;
-}
-
 static void write_special_file(const char *suffix, const char *msg,
 			       const char *pack_name, const unsigned char *hash,
 			       const char **report)
@@ -1460,7 +1447,7 @@ static void write_special_file(const char *suffix, const char *msg,
 	int msg_len = strlen(msg);
 
 	if (pack_name)
-		filename = derive_filename(pack_name, "pack", suffix, &name_buf);
+		filename = derive_pack_filename(pack_name, "pack", suffix, &name_buf);
 	else
 		filename = odb_pack_name(&name_buf, hash, suffix);
 
@@ -1855,13 +1842,13 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (from_stdin && hash_algo)
 		die(_("--object-format cannot be used with --stdin"));
 	if (!index_name && pack_name)
-		index_name = derive_filename(pack_name, "pack", "idx", &index_name_buf);
+		index_name = derive_pack_filename(pack_name, "pack", "idx", &index_name_buf);
 
 	opts.flags &= ~(WRITE_REV | WRITE_REV_VERIFY);
 	if (rev_index) {
 		opts.flags |= verify ? WRITE_REV_VERIFY : WRITE_REV;
 		if (index_name)
-			rev_index_name = derive_filename(index_name,
+			rev_index_name = derive_pack_filename(index_name,
 							 "idx", "rev",
 							 &rev_index_name_buf);
 	}
diff --git a/object-file.c b/object-file.c
index f233b440b22..068ef99d461 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1974,11 +1974,16 @@ static int freshen_loose_object(const struct object_id *oid)
 static int freshen_packed_object(const struct object_id *oid)
 {
 	struct pack_entry e;
+	struct strbuf name_buf = STRBUF_INIT;
+	const char *filename;
+
 	if (!find_pack_entry(the_repository, oid, &e))
 		return 0;
 	if (e.p->freshened)
 		return 1;
-	if (!freshen_file(e.p->pack_name))
+
+	filename = derive_pack_filename(e.p->pack_name, "pack", "idx", &name_buf);
+	if (!freshen_file(filename))
 		return 0;
 	e.p->freshened = 1;
 	return 1;
diff --git a/packfile.c b/packfile.c
index 755aa7aec5e..46f8fb22462 100644
--- a/packfile.c
+++ b/packfile.c
@@ -40,6 +40,19 @@ char *sha1_pack_index_name(const unsigned char *sha1)
 	return odb_pack_name(&buf, sha1, "idx");
 }
 
+const char *derive_pack_filename(const char *pack_name, const char *strip,
+				const char *suffix, struct strbuf *buf)
+{
+	size_t len;
+	if (!strip_suffix(pack_name, strip, &len) || !len ||
+	    pack_name[len - 1] != '.')
+		die(_("packfile name '%s' does not end with '.%s'"),
+		    pack_name, strip);
+	strbuf_add(buf, pack_name, len);
+	strbuf_addstr(buf, suffix);
+	return buf->buf;
+}
+
 static unsigned int pack_used_ctr;
 static unsigned int pack_mmap_calls;
 static unsigned int peak_pack_open_windows;
@@ -693,6 +706,10 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 	size_t alloc;
 	struct packed_git *p;
 
+	if (stat(path, &st) || !S_ISREG(st.st_mode)) {
+		return NULL;
+	}
+
 	/*
 	 * Make sure a corresponding .pack file exists and that
 	 * the index looks sane.
@@ -707,6 +724,7 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 	alloc = st_add3(path_len, strlen(".promisor"), 1);
 	p = alloc_packed_git(alloc);
 	memcpy(p->pack_name, path, path_len);
+	p->mtime = st.st_mtime;
 
 	xsnprintf(p->pack_name + path_len, alloc - path_len, ".keep");
 	if (!access(p->pack_name, F_OK))
@@ -727,7 +745,6 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 	 */
 	p->pack_size = st.st_size;
 	p->pack_local = local;
-	p->mtime = st.st_mtime;
 	if (path_len < the_hash_algo->hexsz ||
 	    get_sha1_hex(path + path_len - the_hash_algo->hexsz, p->hash))
 		hashclr(p->hash);
diff --git a/packfile.h b/packfile.h
index 3ae117a8aef..ff702b22e6a 100644
--- a/packfile.h
+++ b/packfile.h
@@ -31,6 +31,13 @@ char *sha1_pack_name(const unsigned char *sha1);
  */
 char *sha1_pack_index_name(const unsigned char *sha1);
 
+/*
+ * Return the corresponding filename with given suffix from "file_name"
+ * which must has "strip" suffix.
+ */
+const char *derive_pack_filename(const char *file_name, const char *strip,
+		const char *suffix, struct strbuf *buf);
+
 /*
  * Return the basename of the packfile, omitting any containing directory
  * (e.g., "pack-1234abcd[...].pack").
diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index 937f89ee8c8..51c1afcbe2c 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -106,7 +106,7 @@ test_expect_success 'do not bother loosening old objects' '
 	git prune-packed &&
 	git cat-file -p $obj1 &&
 	git cat-file -p $obj2 &&
-	test-tool chmtime =-86400 .git/objects/pack/pack-$pack2.pack &&
+	test-tool chmtime =-86400 .git/objects/pack/pack-$pack2.idx &&
 	git repack -A -d --unpack-unreachable=1.hour.ago &&
 	git cat-file -p $obj1 &&
 	test_must_fail git cat-file -p $obj2

base-commit: d486ca60a51c9cb1fe068803c3f540724e95e83a
-- 
gitgitgadget
