Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B99C43214
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 17:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E94E60F36
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 17:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhHPRGj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 13:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbhHPRGh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 13:06:37 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971A0C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 10:06:05 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id f10so8876522wml.2
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 10:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QYEJ3dTlznPdrkAqSG6e9p48cILV0vEK2HUJMwZsqjA=;
        b=sPECO+MF3P7wXXB8giqJb4SjC3KUmHfvysTKc7X/XzuuZ/523RO8smR3cHrLlYatl4
         QGislTq4omtOLRfy99MOsMZ/kjydS+AhMHr+ZCD2o2R56/j3DxJjARjSWC8iI1/HiQw7
         BQCiu7iNo65u2hJCsGOZuo2BtFWFJf8fvezXRoJKXCp59SG13n+LHoyS0QvPTIK7Cdyl
         SDnwnqZPhJWc0M4xGf92au0wFIiGGbEui4QLmWqbPczPfiPdiDQ15a9Be+EqsPKBRtIo
         iQsBbpAmudje+1ciNTtJnQBGz+p02PI5vCjv/L9Yhy3ONxR4Tih+gHE3/qzeqvNrCPdm
         nc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QYEJ3dTlznPdrkAqSG6e9p48cILV0vEK2HUJMwZsqjA=;
        b=aOvjBS1IG0SVmMNNOxdtr5gopn7xVOBuF/EhJo4NLnnHen0wAYbdCexG9xxWl3E5IA
         3jgbbMZ0tIU+QYIYoUJNbyUHkfr+L9BLFsDcJVVp0hKwefgxm3jBwLJFbdlp6sGB6cb/
         MHx1pElUCF23u6I3g+rsgLNbCgb2Go8pSFv9GS1ZxqwN1PqLa/uvX2NH/xDmN+m8IReg
         BVnEy8UMLZH7PDzUJFuYbHcT9K/GvejjJDGkJEgls0G1rAXwkHNZjhU+i5RADo33bNc+
         Ll/6ybGK8tWE0O7g5jANn9YEbQr0lrSzFLtxIKVW2xAZ1h/WEW/ayqMWpVh8afiJxhUB
         XI1w==
X-Gm-Message-State: AOAM5314bB4OjuKHLnI01i3JKUuAGG0hBy6Y8+2v5fu9dlLj5KQELJ1V
        r2WZSAwSwKNIGOzkBaJns77lppPe4MY=
X-Google-Smtp-Source: ABdhPJz48ssT/iQaOIyOW6jYL1x3GwynSkXALWgFXxvvNVsSXFaxFzD07UUoYLbRrGe44aFWr3WVlA==
X-Received: by 2002:a1c:2904:: with SMTP id p4mr106164wmp.178.1629133564124;
        Mon, 16 Aug 2021 10:06:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z137sm103917wmc.14.2021.08.16.10.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 10:06:03 -0700 (PDT)
Message-Id: <7166f77615442e511159be2d7ad2b3b46f40cbd7.1629133561.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1066.git.git.1629133561.gitgitgadget@gmail.com>
References: <pull.1066.git.git.1629133561.gitgitgadget@gmail.com>
From:   "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Aug 2021 17:06:01 +0000
Subject: [PATCH 2/2] packfile: freshen the mtime of packfile by bump file
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
incremental backup jobs or services rely on cached file system
when there are large '.pack' files exists.

For example, after packed all objects, use 'write-tree' to
create same commit with the same tree and same environments
such like GIT_COMMITTER_DATE and GIT_AUTHOR_DATE, we can
notice the '.pack' file's mtime changed. Git servers
that use filesystems like NFS will reload the '.pack' files
to file system page cache, which will slow the git commands.

So if we freshen the mtime of packfile by updating a '.bump'
file instead, when we check the mtime of packfile, get it from
'.bump' file also. Large git repository may contains large
'.pack' files, but '.bump' files can be empty. This will avoid
file system page caches reload large files from NFS and then
make git commands faster.

Signed-off-by: Sun Chao <16657101987@163.com>
---
 Documentation/config/core.txt   |  11 +++
 cache.h                         |   1 +
 config.c                        |   5 ++
 environment.c                   |   1 +
 object-file.c                   |  30 +++++++-
 packfile.c                      |  12 +++-
 t/t5326-pack-mtime-bumpfiles.sh | 118 ++++++++++++++++++++++++++++++++
 7 files changed, 175 insertions(+), 3 deletions(-)
 create mode 100755 t/t5326-pack-mtime-bumpfiles.sh

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index c04f62a54a1..963d1b54e7e 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -398,6 +398,17 @@ the largest projects.  You probably do not need to adjust this value.
 +
 Common unit suffixes of 'k', 'm', or 'g' are supported.
 
+core.packMtimeToBumpFiles::
+	Normally we avoid writing existing object by freshening the mtime
+	of the *.pack file which contains it in order to aid some processes
+	such like prune. Use a *.bump file instead of *.pack file will
+	avoid file system cache re-sync the large packfiles on filesystems
+	like NFS, and consequently make git commands faster.
++
+The default is 'false' which means the *.pack file will be freshened by
+default. If set to 'true', the file with the '.bump' suffix will be
+created automatically, and it's mtime will be freshened instead.
+
 core.deltaBaseCacheLimit::
 	Maximum number of bytes per thread to reserve for caching base objects
 	that may be referenced by multiple deltified objects.  By storing the
diff --git a/cache.h b/cache.h
index bd4869beee4..a563cbacfa2 100644
--- a/cache.h
+++ b/cache.h
@@ -960,6 +960,7 @@ extern const char *git_hooks_path;
 extern int zlib_compression_level;
 extern int core_compression_level;
 extern int pack_compression_level;
+extern int pack_mtime_to_bumpfiles;
 extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
diff --git a/config.c b/config.c
index f33abeab851..10ccf7c5581 100644
--- a/config.c
+++ b/config.c
@@ -1431,6 +1431,11 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.packmtimetobumpfiles")) {
+		pack_mtime_to_bumpfiles = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.deltabasecachelimit")) {
 		delta_base_cache_limit = git_config_ulong(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index d6b22ede7ea..5fa26cb3758 100644
--- a/environment.c
+++ b/environment.c
@@ -43,6 +43,7 @@ const char *git_hooks_path;
 int zlib_compression_level = Z_BEST_SPEED;
 int core_compression_level;
 int pack_compression_level = Z_DEFAULT_COMPRESSION;
+int pack_mtime_to_bumpfiles;
 int fsync_object_files;
 size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
diff --git a/object-file.c b/object-file.c
index a8be8994814..434073c17f1 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1994,12 +1994,38 @@ static int freshen_loose_object(const struct object_id *oid)
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
+	if (!pack_mtime_to_bumpfiles) {
+		if (!freshen_file(filename))
+			return 0;
+		e.p->freshened = 1;
+		return 1;
+	}
+
+	filename = derive_pack_filename(filename, "pack", "bump", &name_buf);
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
index 315c3da259a..f5cee440601 100644
--- a/packfile.c
+++ b/packfile.c
@@ -374,7 +374,7 @@ void close_object_store(struct raw_object_store *o)
 
 void unlink_pack_path(const char *pack_name, int force_delete)
 {
-	static const char *exts[] = {".pack", ".idx", ".rev", ".keep", ".bitmap", ".promisor"};
+	static const char *exts[] = {".pack", ".idx", ".rev", ".keep", ".bitmap", ".promisor", ".bump"};
 	int i;
 	struct strbuf buf = STRBUF_INIT;
 	size_t plen;
@@ -741,6 +741,16 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 	p->pack_size = st.st_size;
 	p->pack_local = local;
 	p->mtime = st.st_mtime;
+
+	if (pack_mtime_to_bumpfiles) {
+		struct strbuf name_buf = STRBUF_INIT;
+		const char *filename;
+
+		filename = derive_pack_filename(path, "idx", "bump", &name_buf);
+		if (!stat(filename, &st)) {
+			p->mtime = st.st_mtime;
+		}
+	}
 	if (path_len < the_hash_algo->hexsz ||
 	    get_sha1_hex(path + path_len - the_hash_algo->hexsz, p->hash))
 		hashclr(p->hash);
diff --git a/t/t5326-pack-mtime-bumpfiles.sh b/t/t5326-pack-mtime-bumpfiles.sh
new file mode 100755
index 00000000000..d6d9e6dc446
--- /dev/null
+++ b/t/t5326-pack-mtime-bumpfiles.sh
@@ -0,0 +1,118 @@
+#!/bin/sh
+
+test_description='packfile mtime use bump files'
+. ./test-lib.sh
+
+if stat -c %Y . >/dev/null 2>&1; then
+    get_modified_time() { stat -c %Y "$1" 2>/dev/null; }
+elif stat -f %m . >/dev/null 2>&1; then
+    get_modified_time() { stat -f %m "$1" 2>/dev/null; }
+elif date -r . +%s >/dev/null 2>&1; then
+    get_modified_time() { date -r "$1" +%s 2>/dev/null; }
+else
+    echo 'get_modified_time() is unsupported' >&2
+    get_modified_time() { printf '%s' 0; }
+fi
+
+test_expect_success 'freshen existing packfile without core.packMtimeToBumpFiles' '
+	obj1=$(echo one | git hash-object -w --stdin) &&
+	obj2=$(echo two | git hash-object -w --stdin) &&
+	pack1=$(echo $obj1 | git pack-objects .git/objects/pack/pack) &&
+	pack2=$(echo $obj2 | git pack-objects .git/objects/pack/pack) &&
+	test-tool chmtime =-60 .git/objects/pack/pack-$pack1.* &&
+	test-tool chmtime =-60 .git/objects/pack/pack-$pack2.* &&
+	pack1_mtime=$(get_modified_time .git/objects/pack/pack-$pack1.pack) &&
+	pack2_mtime=$(get_modified_time .git/objects/pack/pack-$pack2.pack) &&
+	(echo one | git hash-object -w --stdin) &&
+	! test_path_exists .git/objects/pack/pack-$pack1.bump &&
+	! test_path_exists .git/objects/pack/pack-$pack2.bump &&
+	pack1_mtime_new=$(get_modified_time .git/objects/pack/pack-$pack1.pack) &&
+	pack2_mtime_new=$(get_modified_time .git/objects/pack/pack-$pack2.pack) &&
+	echo "$pack1_mtime : $pack1_mtime_new" &&
+	test ! "$pack1_mtime" = "$pack1_mtime_new" &&
+	test "$pack2_mtime" = "$pack2_mtime_new"
+
+'
+
+test_expect_success 'freshen existing packfile with core.packMtimeToBumpFiles' '
+
+	rm -rf .git/objects && git init &&
+	obj1=$(echo one | git hash-object -w --stdin) &&
+	obj2=$(echo two | git hash-object -w --stdin) &&
+	pack1=$(echo $obj1 | git pack-objects .git/objects/pack/pack) &&
+	pack2=$(echo $obj2 | git pack-objects .git/objects/pack/pack) &&
+	test-tool chmtime =-60 .git/objects/pack/pack-$pack1.* &&
+	test-tool chmtime =-60 .git/objects/pack/pack-$pack2.* &&
+	pack1_mtime=$(get_modified_time .git/objects/pack/pack-$pack1.pack) &&
+	pack2_mtime=$(get_modified_time .git/objects/pack/pack-$pack2.pack) &&
+	(echo one | git -c core.packMtimeToBumpFiles=true hash-object -w --stdin) &&
+	test_path_exists .git/objects/pack/pack-$pack1.bump &&
+	! test_path_exists .git/objects/pack/pack-$pack2.bump &&
+	pack1_mtime_new=$(get_modified_time .git/objects/pack/pack-$pack1.pack) &&
+	pack2_mtime_new=$(get_modified_time .git/objects/pack/pack-$pack2.pack) &&
+	test "$pack1_mtime" = "$pack1_mtime_new" &&
+	test "$pack2_mtime" = "$pack2_mtime_new"
+
+'
+
+test_expect_success 'repack prune unreachable objects without core.packMtimeToBumpFiles' '
+
+	rm -rf .git/objects && git init &&
+	obj1=$(echo one | git hash-object -w --stdin) &&
+	obj2=$(echo two | git hash-object -w --stdin) &&
+	pack1=$(echo $obj1 | git pack-objects .git/objects/pack/pack) &&
+	pack2=$(echo $obj2 | git pack-objects .git/objects/pack/pack) &&
+	echo one | git hash-object -w --stdin &&
+	echo two | git hash-object -w --stdin &&
+	! test_path_exists .git/objects/pack/pack-$pack1.bump &&
+	! test_path_exists .git/objects/pack/pack-$pack2.bump &&
+	git prune-packed &&
+	git cat-file -p $obj1 &&
+	git cat-file -p $obj2 &&
+	test-tool chmtime =-86400 .git/objects/pack/pack-$pack2.pack &&
+	git repack -A -d --unpack-unreachable=1.hour.ago &&
+	git cat-file -p $obj1 &&
+	test_must_fail git cat-file -p $obj2
+
+'
+
+test_expect_success 'repack prune unreachable objects with core.packMtimeToBumpFiles and bump files' '
+
+	rm -rf .git/objects && git init &&
+	obj1=$(echo one | git hash-object -w --stdin) &&
+	obj2=$(echo two | git hash-object -w --stdin) &&
+	pack1=$(echo $obj1 | git pack-objects .git/objects/pack/pack) &&
+	pack2=$(echo $obj2 | git pack-objects .git/objects/pack/pack) &&
+	echo one | git -c core.packMtimeToBumpFiles=true hash-object -w --stdin &&
+	echo two | git -c core.packMtimeToBumpFiles=true hash-object -w --stdin &&
+	test_path_exists .git/objects/pack/pack-$pack1.bump &&
+	test_path_exists .git/objects/pack/pack-$pack2.bump &&
+	test-tool chmtime =-86400 .git/objects/pack/pack-$pack2.pack &&
+	git -c core.packMtimeToBumpFiles=true repack -A -d --unpack-unreachable=1.hour.ago &&
+	git cat-file -p $obj1 &&
+	git cat-file -p $obj2
+
+'
+
+test_expect_success 'repack prune unreachable objects with core.packMtimeToBumpFiles and old bump files' '
+
+	rm -rf .git/objects && git init &&
+	obj1=$(echo one | git hash-object -w --stdin) &&
+	obj2=$(echo two | git hash-object -w --stdin) &&
+	pack1=$(echo $obj1 | git pack-objects .git/objects/pack/pack) &&
+	pack2=$(echo $obj2 | git pack-objects .git/objects/pack/pack) &&
+	echo one | git -c core.packMtimeToBumpFiles=true hash-object -w --stdin &&
+	echo two | git -c core.packMtimeToBumpFiles=true hash-object -w --stdin &&
+	test_path_exists .git/objects/pack/pack-$pack1.bump &&
+	test_path_exists .git/objects/pack/pack-$pack2.bump &&
+	git prune-packed &&
+	git cat-file -p $obj1 &&
+	git cat-file -p $obj2 &&
+	test-tool chmtime =-86400 .git/objects/pack/pack-$pack2.bump &&
+	git -c core.packMtimeToBumpFiles=true repack -A -d --unpack-unreachable=1.hour.ago &&
+	git cat-file -p $obj1 &&
+	test_must_fail git cat-file -p $obj2
+
+'
+
+test_done
-- 
gitgitgadget
