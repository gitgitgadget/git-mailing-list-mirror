Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548E9C07E95
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 01:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3106A6117A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 01:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbhGNBb3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 21:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhGNBb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 21:31:28 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B59C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 18:28:36 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m2so1063415wrq.2
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 18:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a9jWueqvZkJx7xrDtU3GvBIrvXgFlczM5Bvgj0EBoVg=;
        b=NVF7QnZmLt11EvAconb9zVT++Z9sCycSR/vh2pK468MuNVOOUiFFSJxrd7Pz0RLgMI
         pkTmGV1foYsslYKdbKekfrGanDTCFjUcY8bsDU0IesWdretGd+gqsNuocPx54k7tYReI
         yvaB0zLS8sbYrSQTom0B7bCi9x1P1sejDjXzjlnsNPEku9B1yoctXMWViIxSlvxWYTaK
         HvJ4Sh7431TGTsWrOrEks9TzCkpfzEIhqn2d5tFrgRabEwv1G2xoWhOLPTMne0oQ/bN3
         1ELBkqChi9D2ieSHWJUDqNdbSHFUrZGK1UDUkFCm3E71HTk5kqxYj7dBmlZXOTA5RGvf
         uoug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=a9jWueqvZkJx7xrDtU3GvBIrvXgFlczM5Bvgj0EBoVg=;
        b=VvBckbS7vR6uGlOx35Vr+PXv3ohTKlzomoJQ0RewKmgREg0Pjjx9UVtzK9JIUakQAz
         DbVLY+Q1aeozViPKB3j05ogiLT8hiXKKhOWtBvUOO0AyNg7lPcxn2MMr+idY1zbbROCL
         rJicG51/AUUAbt6xUo6VKVA66LKb1r9gdQvxKiGw7rRHSpu6Z4EVzGzyEHy0est8sduO
         9YabzxfF8N6kASagN6BJAdkqnbluR9uWEMdxEZPIRenvfLfKkalvjKbJzWgXrGkeaDG6
         cA6Ce9uuMlDRPp2mu+LOv53SXBcy94ucxp1uLKsxF37GNYo0qQ6e7nY7Y1+r0Lvb4R7H
         52dA==
X-Gm-Message-State: AOAM531154eI15BQXlPw0Fu7FRujyIKP7yyFONCjoT0ngcv/Z/Ahlngn
        B6arfccv7Cm+do7f+xQ49LFCN3AnQLY=
X-Google-Smtp-Source: ABdhPJwT7KJxXePk1VHSlEhn9Y6XmGHAoSA8Bvzarx9bnJL3V1KcsNOk33paTtV3TqktzOtl8s52uQ==
X-Received: by 2002:adf:f6ca:: with SMTP id y10mr9311979wrp.211.1626226115447;
        Tue, 13 Jul 2021 18:28:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u12sm557593wrt.50.2021.07.13.18.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 18:28:35 -0700 (PDT)
Message-Id: <pull.1043.v2.git.git.1626226114067.gitgitgadget@gmail.com>
In-Reply-To: <pull.1043.git.git.1625943685565.gitgitgadget@gmail.com>
References: <pull.1043.git.git.1625943685565.gitgitgadget@gmail.com>
From:   "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 01:28:33 +0000
Subject: [PATCH v2] packfile: freshen the mtime of packfile by configuration
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
notice the '.pack' file's mtime changed, and '.idx' file not.

If we freshen the mtime of packfile by updating another
file instead of '.pack' file e.g. a empty '.bump' file,
when we need to check the mtime of packfile, get it from
another file instead. Large git repository may contains
large '.pack' files, and we can use smaller files even empty
file to do the mtime get/set operation, this can avoid
file system cache re-sync large '.pack' files again and
then speed up most git commands.

Signed-off-by: Sun Chao <16657101987@163.com>
---
    packfile: freshen the mtime of packfile by configuration
    
    Commit 33d4221 (write_sha1_file: freshen existing objects, 2014-10-15)
    avoid writing existing objects by freshen their mtime (especially the
    packfiles contains them) in order to aid the correct caching, and some
    process like find_lru_pack can make good decision. However, this is
    unfriendly to incremental backup jobs or services rely on file system
    cache when there are large '.pack' files exists.
    
    For example, after packed all objects, use 'write-tree' to create same
    commit with the same tree and same environments such like
    GIT_COMMITTER_DATE and GIT_AUTHOR_DATE, we can notice the '.pack' file's
    mtime changed, and '.idx' file not.
    
    If we freshen the mtime of packfile by updating another file instead of
    '.pack' file e.g. a empty '.bump' file, when we need to check the mtime
    of packfile, get it from another file instead. Large git repository may
    contains large '.pack' files, and we can use smaller files even empty
    file to do the mtime get/set operation, this can avoid file system cache
    re-sync large '.pack' files again and then speed up most git commands.
    
    Signed-off-by: Sun Chao 16657101987@163.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1043%2Fsunchao9%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1043/sunchao9/master-v2
Pull-Request: https://github.com/git/git/pull/1043

Range-diff vs v1:

 1:  f6adbb4e90f ! 1:  943e31e8587 packfile: enhance the mtime of packfile by idx file
     @@ Metadata
      Author: Sun Chao <16657101987@163.com>
      
       ## Commit message ##
     -    packfile: enhance the mtime of packfile by idx file
     +    packfile: freshen the mtime of packfile by configuration
      
          Commit 33d4221c79 (write_sha1_file: freshen existing objects,
          2014-10-15) avoid writing existing objects by freshen their
     @@ Commit message
          For example, after packed all objects, use 'write-tree' to
          create same commit with the same tree and same environments
          such like GIT_COMMITTER_DATE and GIT_AUTHOR_DATE, we can
     -    notice the '.pack' file's mtime changed, but '.idx' file not.
     +    notice the '.pack' file's mtime changed, and '.idx' file not.
      
     -    So if we update the mtime of packfile by updating the '.idx'
     -    file instead of '.pack' file, when we check the mtime
     -    of packfile, get it from '.idx' file instead. Large git
     -    repository may contains large '.pack' files, but '.idx'
     -    files are smaller enough, this can avoid file system cache
     -    reload the large files again and speed up git commands.
     +    If we freshen the mtime of packfile by updating another
     +    file instead of '.pack' file e.g. a empty '.bump' file,
     +    when we need to check the mtime of packfile, get it from
     +    another file instead. Large git repository may contains
     +    large '.pack' files, and we can use smaller files even empty
     +    file to do the mtime get/set operation, this can avoid
     +    file system cache re-sync large '.pack' files again and
     +    then speed up most git commands.
      
          Signed-off-by: Sun Chao <16657101987@163.com>
      
     + ## Documentation/config/core.txt ##
     +@@ Documentation/config/core.txt: the largest projects.  You probably do not need to adjust this value.
     + +
     + Common unit suffixes of 'k', 'm', or 'g' are supported.
     + 
     ++core.packMtimeSuffix::
     ++	Normally we avoid writing existing object by freshening the mtime
     ++	of the *.pack file which contains it in order to aid some processes
     ++	such like prune. Use different file instead of *.pack file will
     ++	avoid file system cache re-sync the large packfiles, and consequently
     ++	make git commands faster.
     +++
     ++The default is 'pack' which means the *.pack file will be freshened by
     ++default. You can configure a different suffix to use, the file with the
     ++suffix will be created automatically, it's better not using any known
     ++suffix such like 'idx', 'keep', 'promisor'.
     ++
     + core.deltaBaseCacheLimit::
     + 	Maximum number of bytes per thread to reserve for caching base objects
     + 	that may be referenced by multiple deltified objects.  By storing the
     +
       ## builtin/index-pack.c ##
      @@ builtin/index-pack.c: static void fix_unresolved_deltas(struct hashfile *f)
       	free(sorted_by_pos);
     @@ builtin/index-pack.c: int cmd_index_pack(int argc, const char **argv, const char
       							 &rev_index_name_buf);
       	}
      
     + ## cache.h ##
     +@@ cache.h: extern size_t packed_git_limit;
     + extern size_t delta_base_cache_limit;
     + extern unsigned long big_file_threshold;
     + extern unsigned long pack_size_limit_cfg;
     ++extern const char *pack_mtime_suffix;
     + 
     + /*
     +  * Accessors for the core.sharedrepository config which lazy-load the value
     +
     + ## config.c ##
     +@@ config.c: static int git_default_core_config(const char *var, const char *value, void *cb)
     + 		return 0;
     + 	}
     + 
     ++	if (!strcmp(var, "core.packmtimesuffix")) {
     ++		return git_config_string(&pack_mtime_suffix, var, value);
     ++	}
     ++
     + 	if (!strcmp(var, "core.deltabasecachelimit")) {
     + 		delta_base_cache_limit = git_config_ulong(var, value);
     + 		return 0;
     +
     + ## environment.c ##
     +@@ environment.c: const char *git_hooks_path;
     + int zlib_compression_level = Z_BEST_SPEED;
     + int core_compression_level;
     + int pack_compression_level = Z_DEFAULT_COMPRESSION;
     ++const char *pack_mtime_suffix = "pack";
     + int fsync_object_files;
     + size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
     + size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
     +
       ## object-file.c ##
      @@ object-file.c: static int freshen_loose_object(const struct object_id *oid)
       static int freshen_packed_object(const struct object_id *oid)
       {
       	struct pack_entry e;
     ++	struct stat st;
      +	struct strbuf name_buf = STRBUF_INIT;
      +	const char *filename;
      +
     @@ object-file.c: static int freshen_loose_object(const struct object_id *oid)
       	if (e.p->freshened)
       		return 1;
      -	if (!freshen_file(e.p->pack_name))
     +-		return 0;
     ++
     ++	filename = e.p->pack_name;
     ++	if (!strcasecmp(pack_mtime_suffix, "pack")) {
     ++		if (!freshen_file(filename))
     ++			return 0;
     ++		e.p->freshened = 1;
     ++		return 1;
     ++	}
     ++
     ++	/* If we want to freshen different file instead of .pack file, we need
     ++	 * to make sure the file exists and create it if needed.
     ++	 */
     ++	filename = derive_pack_filename(filename, "pack", pack_mtime_suffix, &name_buf);
     ++	if (lstat(filename, &st) < 0) {
     ++		int fd = open(filename, O_CREAT|O_EXCL|O_WRONLY, 0664);
     ++		if (fd < 0) {
     ++			// here we need to check it again because other git process may created it
     ++			if (lstat(filename, &st) < 0)
     ++				die_errno("unable to create '%s'", filename);
     ++		} else {
     ++			close(fd);
     ++		}
     ++	} else {
     ++		if (!freshen_file(filename))
     ++			return 0;
     ++	}
      +
     -+	filename = derive_pack_filename(e.p->pack_name, "pack", "idx", &name_buf);
     -+	if (!freshen_file(filename))
     - 		return 0;
       	e.p->freshened = 1;
       	return 1;
     + }
      
       ## packfile.c ##
      @@ packfile.c: char *sha1_pack_index_name(const unsigned char *sha1)
     @@ packfile.c: char *sha1_pack_index_name(const unsigned char *sha1)
       static unsigned int pack_used_ctr;
       static unsigned int pack_mmap_calls;
       static unsigned int peak_pack_open_windows;
     -@@ packfile.c: struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
     - 	size_t alloc;
     - 	struct packed_git *p;
     - 
     -+	if (stat(path, &st) || !S_ISREG(st.st_mode)) {
     -+		return NULL;
     -+	}
     -+
     - 	/*
     - 	 * Make sure a corresponding .pack file exists and that
     - 	 * the index looks sane.
     -@@ packfile.c: struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
     - 	alloc = st_add3(path_len, strlen(".promisor"), 1);
     - 	p = alloc_packed_git(alloc);
     - 	memcpy(p->pack_name, path, path_len);
     -+	p->mtime = st.st_mtime;
     - 
     - 	xsnprintf(p->pack_name + path_len, alloc - path_len, ".keep");
     - 	if (!access(p->pack_name, F_OK))
      @@ packfile.c: struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
       	 */
       	p->pack_size = st.st_size;
       	p->pack_local = local;
     --	p->mtime = st.st_mtime;
     ++
     ++	/* If we have different file used to freshen the mtime, we should
     ++	 * use it at a higher priority.
     ++	 */
     ++	if (!!strcasecmp(pack_mtime_suffix, "pack")) {
     ++		struct strbuf name_buf = STRBUF_INIT;
     ++		const char *filename;
     ++
     ++		filename = derive_pack_filename(path, "idx", pack_mtime_suffix, &name_buf);
     ++		stat(filename, &st);
     ++	}
     + 	p->mtime = st.st_mtime;
       	if (path_len < the_hash_algo->hexsz ||
       	    get_sha1_hex(path + path_len - the_hash_algo->hexsz, p->hash))
     - 		hashclr(p->hash);
      
       ## packfile.h ##
      @@ packfile.h: char *sha1_pack_name(const unsigned char *sha1);
     @@ packfile.h: char *sha1_pack_name(const unsigned char *sha1);
      
       ## t/t7701-repack-unpack-unreachable.sh ##
      @@ t/t7701-repack-unpack-unreachable.sh: test_expect_success 'do not bother loosening old objects' '
     - 	git prune-packed &&
     - 	git cat-file -p $obj1 &&
     - 	git cat-file -p $obj2 &&
     --	test-tool chmtime =-86400 .git/objects/pack/pack-$pack2.pack &&
     -+	test-tool chmtime =-86400 .git/objects/pack/pack-$pack2.idx &&
     - 	git repack -A -d --unpack-unreachable=1.hour.ago &&
     - 	git cat-file -p $obj1 &&
       	test_must_fail git cat-file -p $obj2
     + '
     + 
     ++test_expect_success 'do not bother loosening old objects with core.packmtimesuffix config' '
     ++	obj1=$(echo three | git hash-object -w --stdin) &&
     ++	obj2=$(echo four | git hash-object -w --stdin) &&
     ++	pack1=$(echo $obj1 | git -c core.packmtimesuffix=bump pack-objects .git/objects/pack/pack) &&
     ++	pack2=$(echo $obj2 | git -c core.packmtimesuffix=bump pack-objects .git/objects/pack/pack) &&
     ++	git -c core.packmtimesuffix=bump prune-packed &&
     ++	git cat-file -p $obj1 &&
     ++	git cat-file -p $obj2 &&
     ++	touch .git/objects/pack/pack-$pack2.bump &&
     ++	test-tool chmtime =-86400 .git/objects/pack/pack-$pack2.bump &&
     ++	git -c core.packmtimesuffix=bump repack -A -d --unpack-unreachable=1.hour.ago &&
     ++	git cat-file -p $obj1 &&
     ++	test_must_fail git cat-file -p $obj2
     ++'
     ++
     + test_expect_success 'keep packed objects found only in index' '
     + 	echo my-unique-content >file &&
     + 	git add file &&


 Documentation/config/core.txt        | 12 ++++++++++
 builtin/index-pack.c                 | 19 +++-------------
 cache.h                              |  1 +
 config.c                             |  4 ++++
 environment.c                        |  1 +
 object-file.c                        | 33 ++++++++++++++++++++++++++--
 packfile.c                           | 24 ++++++++++++++++++++
 packfile.h                           |  7 ++++++
 t/t7701-repack-unpack-unreachable.sh | 15 +++++++++++++
 9 files changed, 98 insertions(+), 18 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index c04f62a54a1..9a256992d8c 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -398,6 +398,18 @@ the largest projects.  You probably do not need to adjust this value.
 +
 Common unit suffixes of 'k', 'm', or 'g' are supported.
 
+core.packMtimeSuffix::
+	Normally we avoid writing existing object by freshening the mtime
+	of the *.pack file which contains it in order to aid some processes
+	such like prune. Use different file instead of *.pack file will
+	avoid file system cache re-sync the large packfiles, and consequently
+	make git commands faster.
++
+The default is 'pack' which means the *.pack file will be freshened by
+default. You can configure a different suffix to use, the file with the
+suffix will be created automatically, it's better not using any known
+suffix such like 'idx', 'keep', 'promisor'.
+
 core.deltaBaseCacheLimit::
 	Maximum number of bytes per thread to reserve for caching base objects
 	that may be referenced by multiple deltified objects.  By storing the
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
diff --git a/cache.h b/cache.h
index ba04ff8bd36..d95b3d127e0 100644
--- a/cache.h
+++ b/cache.h
@@ -956,6 +956,7 @@ extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
 extern unsigned long big_file_threshold;
 extern unsigned long pack_size_limit_cfg;
+extern const char *pack_mtime_suffix;
 
 /*
  * Accessors for the core.sharedrepository config which lazy-load the value
diff --git a/config.c b/config.c
index f9c400ad306..27a6b619ed8 100644
--- a/config.c
+++ b/config.c
@@ -1431,6 +1431,10 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.packmtimesuffix")) {
+		return git_config_string(&pack_mtime_suffix, var, value);
+	}
+
 	if (!strcmp(var, "core.deltabasecachelimit")) {
 		delta_base_cache_limit = git_config_ulong(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 2f27008424a..07c21e1a934 100644
--- a/environment.c
+++ b/environment.c
@@ -43,6 +43,7 @@ const char *git_hooks_path;
 int zlib_compression_level = Z_BEST_SPEED;
 int core_compression_level;
 int pack_compression_level = Z_DEFAULT_COMPRESSION;
+const char *pack_mtime_suffix = "pack";
 int fsync_object_files;
 size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
diff --git a/object-file.c b/object-file.c
index f233b440b22..b3e77213c42 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1974,12 +1974,41 @@ static int freshen_loose_object(const struct object_id *oid)
 static int freshen_packed_object(const struct object_id *oid)
 {
 	struct pack_entry e;
+	struct stat st;
+	struct strbuf name_buf = STRBUF_INIT;
+	const char *filename;
+
 	if (!find_pack_entry(the_repository, oid, &e))
 		return 0;
 	if (e.p->freshened)
 		return 1;
-	if (!freshen_file(e.p->pack_name))
-		return 0;
+
+	filename = e.p->pack_name;
+	if (!strcasecmp(pack_mtime_suffix, "pack")) {
+		if (!freshen_file(filename))
+			return 0;
+		e.p->freshened = 1;
+		return 1;
+	}
+
+	/* If we want to freshen different file instead of .pack file, we need
+	 * to make sure the file exists and create it if needed.
+	 */
+	filename = derive_pack_filename(filename, "pack", pack_mtime_suffix, &name_buf);
+	if (lstat(filename, &st) < 0) {
+		int fd = open(filename, O_CREAT|O_EXCL|O_WRONLY, 0664);
+		if (fd < 0) {
+			// here we need to check it again because other git process may created it
+			if (lstat(filename, &st) < 0)
+				die_errno("unable to create '%s'", filename);
+		} else {
+			close(fd);
+		}
+	} else {
+		if (!freshen_file(filename))
+			return 0;
+	}
+
 	e.p->freshened = 1;
 	return 1;
 }
diff --git a/packfile.c b/packfile.c
index 755aa7aec5e..a607dda4e25 100644
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
@@ -727,6 +740,17 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 	 */
 	p->pack_size = st.st_size;
 	p->pack_local = local;
+
+	/* If we have different file used to freshen the mtime, we should
+	 * use it at a higher priority.
+	 */
+	if (!!strcasecmp(pack_mtime_suffix, "pack")) {
+		struct strbuf name_buf = STRBUF_INIT;
+		const char *filename;
+
+		filename = derive_pack_filename(path, "idx", pack_mtime_suffix, &name_buf);
+		stat(filename, &st);
+	}
 	p->mtime = st.st_mtime;
 	if (path_len < the_hash_algo->hexsz ||
 	    get_sha1_hex(path + path_len - the_hash_algo->hexsz, p->hash))
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
index 937f89ee8c8..15828a318c4 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -112,6 +112,21 @@ test_expect_success 'do not bother loosening old objects' '
 	test_must_fail git cat-file -p $obj2
 '
 
+test_expect_success 'do not bother loosening old objects with core.packmtimesuffix config' '
+	obj1=$(echo three | git hash-object -w --stdin) &&
+	obj2=$(echo four | git hash-object -w --stdin) &&
+	pack1=$(echo $obj1 | git -c core.packmtimesuffix=bump pack-objects .git/objects/pack/pack) &&
+	pack2=$(echo $obj2 | git -c core.packmtimesuffix=bump pack-objects .git/objects/pack/pack) &&
+	git -c core.packmtimesuffix=bump prune-packed &&
+	git cat-file -p $obj1 &&
+	git cat-file -p $obj2 &&
+	touch .git/objects/pack/pack-$pack2.bump &&
+	test-tool chmtime =-86400 .git/objects/pack/pack-$pack2.bump &&
+	git -c core.packmtimesuffix=bump repack -A -d --unpack-unreachable=1.hour.ago &&
+	git cat-file -p $obj1 &&
+	test_must_fail git cat-file -p $obj2
+'
+
 test_expect_success 'keep packed objects found only in index' '
 	echo my-unique-content >file &&
 	git add file &&

base-commit: d486ca60a51c9cb1fe068803c3f540724e95e83a
-- 
gitgitgadget
