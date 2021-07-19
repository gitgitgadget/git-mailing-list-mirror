Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176ABC07E95
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 22:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E856C6100C
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 22:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbhGSWQw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385847AbhGSTNI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 15:13:08 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ADEC061574
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 12:46:45 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k4so23427651wrc.8
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 12:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oxHTksaZHM9BWD/AIaGOCJO0aRiyUfJnWTLm7KlZIJk=;
        b=UrhmTMp4oYUdA/IoBGSMdDjnAzZaEffhmxMnixyxTmWFcEHsplxzqVwertufX05rHz
         DoiEgc9i4Pk0fxJPBVmcj/jMRDBmHeQkY5Mn8UpNNGR7Ul1JYCN6K88wF/OLj7+92yBh
         ga3dJ7u1hpHEZoZiMs6NRSq08mF/TSeFWlyxSKQj1RNeH/L8dR+4j2hU1xjx6bmQ9TMX
         grMsyElt2XCVMNFw4+5c269Mynxffas/UODW8D/7S+D5o1g3rgcOWrm6k3+FNAF5tDcO
         zzXXJWBulg/K3UK98NRWab7I58v5DGwR9PVu7qPYTZme0mDnpGlg8XAAK6prr4ur2Bb9
         ZfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oxHTksaZHM9BWD/AIaGOCJO0aRiyUfJnWTLm7KlZIJk=;
        b=UHRWV3uNF3amrtYKMrJPcwAD6gJmV0W0zHSOTpZwRT4u57MTOnsdnszx32pnR73fSo
         HH+a5Q9shFsmpvsi+6d/XBt4ronu4cIP5VE1iTm+xQMSwlr9TyeCT9U2pPx0a7AZmhl8
         cH1G2lgbgDdaxNAPt9ooB+y02GRSS85coSdLZgBRty9EBkFoqdfORjvzc6lqVDgbAfrc
         oXKGEk7vcSf1jEp95VZDLsdVn1cUMNuVVqHnC1BYSK208+tE9qtaUk0LHbBugnNq3BfJ
         Y1I9jmY2oGAZtX/0QVryqrKM0/tswn+7dpdJjsOCOK7aHEldRUBXiRbClVdCRbkjyU2g
         Jqrg==
X-Gm-Message-State: AOAM532adPMl0cSddd55XPLqpUXFUqtC/vXDJjq6VPlj8WMc+XY6cxxh
        a6+IFB5LQgyb2BrL8ECP7tdu+c0wgEY=
X-Google-Smtp-Source: ABdhPJxcuCNiZWQz6XoXt9KnJ4BxXvb5etkHiVmLFBkYfjUawaMBTQD0f5q8+y6BSleDLvIwhLViOg==
X-Received: by 2002:a5d:62c2:: with SMTP id o2mr31980056wrv.234.1626724401033;
        Mon, 19 Jul 2021 12:53:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c12sm24127383wrr.90.2021.07.19.12.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 12:53:20 -0700 (PDT)
Message-Id: <pull.1043.v3.git.git.1626724399377.gitgitgadget@gmail.com>
In-Reply-To: <pull.1043.v2.git.git.1626226114067.gitgitgadget@gmail.com>
References: <pull.1043.v2.git.git.1626226114067.gitgitgadget@gmail.com>
From:   "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Jul 2021 19:53:19 +0000
Subject: [PATCH v3] packfile: freshen the mtime of packfile by configuration
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Taylor Blau <ttaylorr@github.com>,
        Martin Fick <mfick@codeaurora.org>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Sun Chao <16657101987@163.com>, Sun Chao <16657101987@163.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sun Chao <16657101987@163.com>

Commit 33d4221c79 (write_sha1_file: freshen existing objects,
2014-10-15) avoid writing existing objects by freshen their
mtime (especially the packfiles contains them) in order to
aid the correct caching, and some process like find_lru_pack
can make good decision. However, this is unfriendly to
incremental backup jobs or services rely on cached file system
when there are large '.pack' files exists.

For example, after packed all objects, use 'write-tree' to
create same commit with the same tree and same environments
such like GIT_COMMITTER_DATE and GIT_AUTHOR_DATE, we can
notice the '.pack' file's mtime changed. Git servers
that mount the same NFS disk will re-sync the '.pack' files
to cached file system which will slow the git commands.

So if add core.freshenPackfiles to indicate whether or not
packs can be freshened, turning off this option on some
servers can speed up the execution of some commands on servers
which use NFS disk instead of local disk.

Signed-off-by: Sun Chao <16657101987@163.com>
---
    packfile: freshen the mtime of packfile by configuration
    
    packfile: freshen the mtime of packfile by configuration
    
    Commit 33d4221c79 (write_sha1_file: freshen existing objects,
    2014-10-15) avoid writing existing objects by freshen their mtime
    (especially the packfiles contains them) in order to aid the correct
    caching, and some process like find_lru_pack can make good decision.
    However, this is unfriendly to incremental backup jobs or services rely
    on cached file system when there are large '.pack' files exists.
    
    For example, after packed all objects, use 'write-tree' to create same
    commit with the same tree and same environments such like
    GIT_COMMITTER_DATE and GIT_AUTHOR_DATE, we can notice the '.pack' file's
    mtime changed. Git servers that mount the same NFS disk will re-sync the
    '.pack' files to cached file system which will slow the git commands.
    
    Here we can find the description of the cached file system for NFS
    Client from
    https://www.ibm.com/docs/en/aix/7.2?topic=performance-cache-file-system:
    
    3. To ensure that the cached directories and files are kept up to date, 
    CacheFS periodically checks the consistency of files stored in the cache.
    It does this by comparing the current modification time to the previous
    modification time.
    
    4. If the modification times are different, all data and attributes
    for the directory or file are purged from the cache, and new data and
    attributes are retrieved from the back file system.
    
    
    So if add core.freshenPackfiles to indicate whether or not packs can be
    freshened, turning off this option on some servers can speed up the
    execution of some commands on servers which use NFS disk instead of
    local disk.
    
    Signed-off-by: Sun Chao 16657101987@163.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1043%2Fsunchao9%2Fmaster-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1043/sunchao9/master-v3
Pull-Request: https://github.com/git/git/pull/1043

Range-diff vs v2:

 1:  943e31e8587 ! 1:  16c68923bea packfile: freshen the mtime of packfile by configuration
     @@ Commit message
          mtime (especially the packfiles contains them) in order to
          aid the correct caching, and some process like find_lru_pack
          can make good decision. However, this is unfriendly to
     -    incremental backup jobs or services rely on file system
     -    cache when there are large '.pack' files exists.
     +    incremental backup jobs or services rely on cached file system
     +    when there are large '.pack' files exists.
      
          For example, after packed all objects, use 'write-tree' to
          create same commit with the same tree and same environments
          such like GIT_COMMITTER_DATE and GIT_AUTHOR_DATE, we can
     -    notice the '.pack' file's mtime changed, and '.idx' file not.
     +    notice the '.pack' file's mtime changed. Git servers
     +    that mount the same NFS disk will re-sync the '.pack' files
     +    to cached file system which will slow the git commands.
      
     -    If we freshen the mtime of packfile by updating another
     -    file instead of '.pack' file e.g. a empty '.bump' file,
     -    when we need to check the mtime of packfile, get it from
     -    another file instead. Large git repository may contains
     -    large '.pack' files, and we can use smaller files even empty
     -    file to do the mtime get/set operation, this can avoid
     -    file system cache re-sync large '.pack' files again and
     -    then speed up most git commands.
     +    So if add core.freshenPackfiles to indicate whether or not
     +    packs can be freshened, turning off this option on some
     +    servers can speed up the execution of some commands on servers
     +    which use NFS disk instead of local disk.
      
          Signed-off-by: Sun Chao <16657101987@163.com>
      
     @@ Documentation/config/core.txt: the largest projects.  You probably do not need t
       +
       Common unit suffixes of 'k', 'm', or 'g' are supported.
       
     -+core.packMtimeSuffix::
     ++core.freshenPackFiles::
      +	Normally we avoid writing existing object by freshening the mtime
      +	of the *.pack file which contains it in order to aid some processes
     -+	such like prune. Use different file instead of *.pack file will
     -+	avoid file system cache re-sync the large packfiles, and consequently
     -+	make git commands faster.
     ++	such like prune. Turning off this option on some servers can speed
     ++	up the execution of some commands like 'git-upload-pack'(e.g. some
     ++	servers that mount the same NFS disk will re-sync the *.pack files
     ++	to cached file system if the mtime cahnges).
      ++
     -+The default is 'pack' which means the *.pack file will be freshened by
     -+default. You can configure a different suffix to use, the file with the
     -+suffix will be created automatically, it's better not using any known
     -+suffix such like 'idx', 'keep', 'promisor'.
     ++The default is true which means the *.pack file will be freshened if we
     ++want to write a existing object whthin it.
      +
       core.deltaBaseCacheLimit::
       	Maximum number of bytes per thread to reserve for caching base objects
       	that may be referenced by multiple deltified objects.  By storing the
      
     - ## builtin/index-pack.c ##
     -@@ builtin/index-pack.c: static void fix_unresolved_deltas(struct hashfile *f)
     - 	free(sorted_by_pos);
     - }
     - 
     --static const char *derive_filename(const char *pack_name, const char *strip,
     --				   const char *suffix, struct strbuf *buf)
     --{
     --	size_t len;
     --	if (!strip_suffix(pack_name, strip, &len) || !len ||
     --	    pack_name[len - 1] != '.')
     --		die(_("packfile name '%s' does not end with '.%s'"),
     --		    pack_name, strip);
     --	strbuf_add(buf, pack_name, len);
     --	strbuf_addstr(buf, suffix);
     --	return buf->buf;
     --}
     --
     - static void write_special_file(const char *suffix, const char *msg,
     - 			       const char *pack_name, const unsigned char *hash,
     - 			       const char **report)
     -@@ builtin/index-pack.c: static void write_special_file(const char *suffix, const char *msg,
     - 	int msg_len = strlen(msg);
     - 
     - 	if (pack_name)
     --		filename = derive_filename(pack_name, "pack", suffix, &name_buf);
     -+		filename = derive_pack_filename(pack_name, "pack", suffix, &name_buf);
     - 	else
     - 		filename = odb_pack_name(&name_buf, hash, suffix);
     - 
     -@@ builtin/index-pack.c: int cmd_index_pack(int argc, const char **argv, const char *prefix)
     - 	if (from_stdin && hash_algo)
     - 		die(_("--object-format cannot be used with --stdin"));
     - 	if (!index_name && pack_name)
     --		index_name = derive_filename(pack_name, "pack", "idx", &index_name_buf);
     -+		index_name = derive_pack_filename(pack_name, "pack", "idx", &index_name_buf);
     - 
     - 	opts.flags &= ~(WRITE_REV | WRITE_REV_VERIFY);
     - 	if (rev_index) {
     - 		opts.flags |= verify ? WRITE_REV_VERIFY : WRITE_REV;
     - 		if (index_name)
     --			rev_index_name = derive_filename(index_name,
     -+			rev_index_name = derive_pack_filename(index_name,
     - 							 "idx", "rev",
     - 							 &rev_index_name_buf);
     - 	}
     -
       ## cache.h ##
      @@ cache.h: extern size_t packed_git_limit;
       extern size_t delta_base_cache_limit;
       extern unsigned long big_file_threshold;
       extern unsigned long pack_size_limit_cfg;
     -+extern const char *pack_mtime_suffix;
     ++extern int core_freshen_packfiles;
       
       /*
        * Accessors for the core.sharedrepository config which lazy-load the value
     @@ config.c: static int git_default_core_config(const char *var, const char *value,
       		return 0;
       	}
       
     -+	if (!strcmp(var, "core.packmtimesuffix")) {
     -+		return git_config_string(&pack_mtime_suffix, var, value);
     ++	if (!strcmp(var, "core.freshenpackfiles")) {
     ++		core_freshen_packfiles = git_config_bool(var, value);
      +	}
      +
       	if (!strcmp(var, "core.deltabasecachelimit")) {
     @@ config.c: static int git_default_core_config(const char *var, const char *value,
       		return 0;
      
       ## environment.c ##
     -@@ environment.c: const char *git_hooks_path;
     - int zlib_compression_level = Z_BEST_SPEED;
     - int core_compression_level;
     - int pack_compression_level = Z_DEFAULT_COMPRESSION;
     -+const char *pack_mtime_suffix = "pack";
     - int fsync_object_files;
     - size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
     - size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
     +@@ environment.c: int core_sparse_checkout_cone;
     + int merge_log_config = -1;
     + int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
     + unsigned long pack_size_limit_cfg;
     ++int core_freshen_packfiles = 1;
     + enum log_refs_config log_all_ref_updates = LOG_REFS_UNSET;
     + 
     + #ifndef PROTECT_HFS_DEFAULT
      
       ## object-file.c ##
      @@ object-file.c: static int freshen_loose_object(const struct object_id *oid)
       static int freshen_packed_object(const struct object_id *oid)
       {
       	struct pack_entry e;
     -+	struct stat st;
     -+	struct strbuf name_buf = STRBUF_INIT;
     -+	const char *filename;
     ++
     ++	if (!core_freshen_packfiles)
     ++		return 1;
      +
       	if (!find_pack_entry(the_repository, oid, &e))
       		return 0;
       	if (e.p->freshened)
     - 		return 1;
     --	if (!freshen_file(e.p->pack_name))
     --		return 0;
     -+
     -+	filename = e.p->pack_name;
     -+	if (!strcasecmp(pack_mtime_suffix, "pack")) {
     -+		if (!freshen_file(filename))
     -+			return 0;
     -+		e.p->freshened = 1;
     -+		return 1;
     -+	}
     -+
     -+	/* If we want to freshen different file instead of .pack file, we need
     -+	 * to make sure the file exists and create it if needed.
     -+	 */
     -+	filename = derive_pack_filename(filename, "pack", pack_mtime_suffix, &name_buf);
     -+	if (lstat(filename, &st) < 0) {
     -+		int fd = open(filename, O_CREAT|O_EXCL|O_WRONLY, 0664);
     -+		if (fd < 0) {
     -+			// here we need to check it again because other git process may created it
     -+			if (lstat(filename, &st) < 0)
     -+				die_errno("unable to create '%s'", filename);
     -+		} else {
     -+			close(fd);
     -+		}
     -+	} else {
     -+		if (!freshen_file(filename))
     -+			return 0;
     -+	}
     -+
     - 	e.p->freshened = 1;
     - 	return 1;
     - }
     -
     - ## packfile.c ##
     -@@ packfile.c: char *sha1_pack_index_name(const unsigned char *sha1)
     - 	return odb_pack_name(&buf, sha1, "idx");
     - }
     - 
     -+const char *derive_pack_filename(const char *pack_name, const char *strip,
     -+				const char *suffix, struct strbuf *buf)
     -+{
     -+	size_t len;
     -+	if (!strip_suffix(pack_name, strip, &len) || !len ||
     -+	    pack_name[len - 1] != '.')
     -+		die(_("packfile name '%s' does not end with '.%s'"),
     -+		    pack_name, strip);
     -+	strbuf_add(buf, pack_name, len);
     -+	strbuf_addstr(buf, suffix);
     -+	return buf->buf;
     -+}
     -+
     - static unsigned int pack_used_ctr;
     - static unsigned int pack_mmap_calls;
     - static unsigned int peak_pack_open_windows;
     -@@ packfile.c: struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
     - 	 */
     - 	p->pack_size = st.st_size;
     - 	p->pack_local = local;
     -+
     -+	/* If we have different file used to freshen the mtime, we should
     -+	 * use it at a higher priority.
     -+	 */
     -+	if (!!strcasecmp(pack_mtime_suffix, "pack")) {
     -+		struct strbuf name_buf = STRBUF_INIT;
     -+		const char *filename;
     -+
     -+		filename = derive_pack_filename(path, "idx", pack_mtime_suffix, &name_buf);
     -+		stat(filename, &st);
     -+	}
     - 	p->mtime = st.st_mtime;
     - 	if (path_len < the_hash_algo->hexsz ||
     - 	    get_sha1_hex(path + path_len - the_hash_algo->hexsz, p->hash))
     -
     - ## packfile.h ##
     -@@ packfile.h: char *sha1_pack_name(const unsigned char *sha1);
     -  */
     - char *sha1_pack_index_name(const unsigned char *sha1);
     - 
     -+/*
     -+ * Return the corresponding filename with given suffix from "file_name"
     -+ * which must has "strip" suffix.
     -+ */
     -+const char *derive_pack_filename(const char *file_name, const char *strip,
     -+		const char *suffix, struct strbuf *buf);
     -+
     - /*
     -  * Return the basename of the packfile, omitting any containing directory
     -  * (e.g., "pack-1234abcd[...].pack").
      
       ## t/t7701-repack-unpack-unreachable.sh ##
      @@ t/t7701-repack-unpack-unreachable.sh: test_expect_success 'do not bother loosening old objects' '
       	test_must_fail git cat-file -p $obj2
       '
       
     -+test_expect_success 'do not bother loosening old objects with core.packmtimesuffix config' '
     ++test_expect_success 'do not bother loosening old objects without freshen pack time' '
      +	obj1=$(echo three | git hash-object -w --stdin) &&
      +	obj2=$(echo four | git hash-object -w --stdin) &&
     -+	pack1=$(echo $obj1 | git -c core.packmtimesuffix=bump pack-objects .git/objects/pack/pack) &&
     -+	pack2=$(echo $obj2 | git -c core.packmtimesuffix=bump pack-objects .git/objects/pack/pack) &&
     -+	git -c core.packmtimesuffix=bump prune-packed &&
     ++	pack1=$(echo $obj1 | git -c core.freshenPackFiles=false pack-objects .git/objects/pack/pack) &&
     ++	pack2=$(echo $obj2 | git -c core.freshenPackFiles=false pack-objects .git/objects/pack/pack) &&
     ++	git -c core.freshenPackFiles=false prune-packed &&
      +	git cat-file -p $obj1 &&
      +	git cat-file -p $obj2 &&
     -+	touch .git/objects/pack/pack-$pack2.bump &&
     -+	test-tool chmtime =-86400 .git/objects/pack/pack-$pack2.bump &&
     -+	git -c core.packmtimesuffix=bump repack -A -d --unpack-unreachable=1.hour.ago &&
     ++	test-tool chmtime =-86400 .git/objects/pack/pack-$pack2.pack &&
     ++	git -c core.freshenPackFiles=false repack -A -d --unpack-unreachable=1.hour.ago &&
      +	git cat-file -p $obj1 &&
      +	test_must_fail git cat-file -p $obj2
      +'


 Documentation/config/core.txt        | 11 +++++++++++
 cache.h                              |  1 +
 config.c                             |  4 ++++
 environment.c                        |  1 +
 object-file.c                        |  4 ++++
 t/t7701-repack-unpack-unreachable.sh | 14 ++++++++++++++
 6 files changed, 35 insertions(+)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index c04f62a54a1..1e7cf366628 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -398,6 +398,17 @@ the largest projects.  You probably do not need to adjust this value.
 +
 Common unit suffixes of 'k', 'm', or 'g' are supported.
 
+core.freshenPackFiles::
+	Normally we avoid writing existing object by freshening the mtime
+	of the *.pack file which contains it in order to aid some processes
+	such like prune. Turning off this option on some servers can speed
+	up the execution of some commands like 'git-upload-pack'(e.g. some
+	servers that mount the same NFS disk will re-sync the *.pack files
+	to cached file system if the mtime cahnges).
++
+The default is true which means the *.pack file will be freshened if we
+want to write a existing object whthin it.
+
 core.deltaBaseCacheLimit::
 	Maximum number of bytes per thread to reserve for caching base objects
 	that may be referenced by multiple deltified objects.  By storing the
diff --git a/cache.h b/cache.h
index ba04ff8bd36..46126c6977c 100644
--- a/cache.h
+++ b/cache.h
@@ -956,6 +956,7 @@ extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
 extern unsigned long big_file_threshold;
 extern unsigned long pack_size_limit_cfg;
+extern int core_freshen_packfiles;
 
 /*
  * Accessors for the core.sharedrepository config which lazy-load the value
diff --git a/config.c b/config.c
index f9c400ad306..02dcc8a028e 100644
--- a/config.c
+++ b/config.c
@@ -1431,6 +1431,10 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.freshenpackfiles")) {
+		core_freshen_packfiles = git_config_bool(var, value);
+	}
+
 	if (!strcmp(var, "core.deltabasecachelimit")) {
 		delta_base_cache_limit = git_config_ulong(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 2f27008424a..397525609a8 100644
--- a/environment.c
+++ b/environment.c
@@ -73,6 +73,7 @@ int core_sparse_checkout_cone;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
+int core_freshen_packfiles = 1;
 enum log_refs_config log_all_ref_updates = LOG_REFS_UNSET;
 
 #ifndef PROTECT_HFS_DEFAULT
diff --git a/object-file.c b/object-file.c
index f233b440b22..884c3e92c38 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1974,6 +1974,10 @@ static int freshen_loose_object(const struct object_id *oid)
 static int freshen_packed_object(const struct object_id *oid)
 {
 	struct pack_entry e;
+
+	if (!core_freshen_packfiles)
+		return 1;
+
 	if (!find_pack_entry(the_repository, oid, &e))
 		return 0;
 	if (e.p->freshened)
diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index 937f89ee8c8..b6a0b6c9695 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -112,6 +112,20 @@ test_expect_success 'do not bother loosening old objects' '
 	test_must_fail git cat-file -p $obj2
 '
 
+test_expect_success 'do not bother loosening old objects without freshen pack time' '
+	obj1=$(echo three | git hash-object -w --stdin) &&
+	obj2=$(echo four | git hash-object -w --stdin) &&
+	pack1=$(echo $obj1 | git -c core.freshenPackFiles=false pack-objects .git/objects/pack/pack) &&
+	pack2=$(echo $obj2 | git -c core.freshenPackFiles=false pack-objects .git/objects/pack/pack) &&
+	git -c core.freshenPackFiles=false prune-packed &&
+	git cat-file -p $obj1 &&
+	git cat-file -p $obj2 &&
+	test-tool chmtime =-86400 .git/objects/pack/pack-$pack2.pack &&
+	git -c core.freshenPackFiles=false repack -A -d --unpack-unreachable=1.hour.ago &&
+	git cat-file -p $obj1 &&
+	test_must_fail git cat-file -p $obj2
+'
+
 test_expect_success 'keep packed objects found only in index' '
 	echo my-unique-content >file &&
 	git add file &&

base-commit: 75ae10bc75336db031ee58d13c5037b929235912
-- 
gitgitgadget
