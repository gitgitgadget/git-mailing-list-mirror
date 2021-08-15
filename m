Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF56FC4338F
	for <git@archiver.kernel.org>; Sun, 15 Aug 2021 17:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9A1361241
	for <git@archiver.kernel.org>; Sun, 15 Aug 2021 17:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhHORJU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Aug 2021 13:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhHORJU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Aug 2021 13:09:20 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11FCC061764
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 10:08:49 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q10so20412310wro.2
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 10:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nQbVlVG65Cm7gWsN0CYou+peJKXftZe8i69e863P+mU=;
        b=MkLjm6u2UF0KcV3lvGmL5k5GiZ+yyRnt1IfR4IHKf/8LYkvFuwKq3QkglwKvw+TvgK
         ZyK23ApIwErtg68HweAFuU78UVPccuFFxf6UEX1YGxBZE/bFGUSYsVBiq++SRv0ZDYNS
         EuiVw0w/0IKX2WX9S0EAUHWxNCLvFhgoNivFP8hHNy6xRI1scDjcCvEgn12m5nz4IPiV
         xvSqqFbnPuS0xdAT0uhX2JYBajOuWDhMrsyfs21S5mfAC9vozhSy1DJwJBOsJLPo7aPD
         CtoIETbucKh2m9OzeY6J299KLdi006rRg9URFUPgTz6lZKJfenbit1uYfPNI0xOWqnxR
         BLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nQbVlVG65Cm7gWsN0CYou+peJKXftZe8i69e863P+mU=;
        b=ttzRjTF1jDJlq5D66I6S3zO3jGLc5Nrt+30+ZeAUwxJwVBpXM6IPFEz6bYLktWlpkd
         A9+KLgfeoda2L1wqbhZ+pChqPfhJT1si/Sv9wDebuD68ERuwZOCLi818Ghor260PIGbB
         W/A+Q7NfF2zByqvoCCUG8WAMONH43/DS5y9JbRkF5LNH14KkODwwmxSy2Wu/QsZZAB6/
         obJc1GnKEadNBQ+MHhrsb/lhWau09nToZjQ/BPoLL1IlEhAaMFU94pHk5UJ2H9b0h1Od
         AiETA6v0walvbdZzaUK7K9LA8qUUT/WSZEZmajSNzTtoEmybKCT5rjC6PAiZ/ZGIk1X5
         c0hg==
X-Gm-Message-State: AOAM530xdknj6FWWAiUFaITcNUgJEDOccEu4CUpBgToQh+VsltUaQ0kz
        q9bOpE3hX8XhZYcmvCL6rNSLpUjnkAU=
X-Google-Smtp-Source: ABdhPJyrnj5KFCk3qGH5CB88FpHJUnFYHxFHkzIAsjvb3EPh9D2pWU8Bc4yO4C7CsDdFSRPSRIb7OA==
X-Received: by 2002:a5d:456a:: with SMTP id a10mr13977366wrc.339.1629047328136;
        Sun, 15 Aug 2021 10:08:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e10sm8660409wrt.82.2021.08.15.10.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 10:08:47 -0700 (PDT)
Message-Id: <pull.1043.v4.git.git.1629047327.gitgitgadget@gmail.com>
In-Reply-To: <pull.1043.v3.git.git.1626724399377.gitgitgadget@gmail.com>
References: <pull.1043.v3.git.git.1626724399377.gitgitgadget@gmail.com>
From:   "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 15 Aug 2021 17:08:45 +0000
Subject: [PATCH v4 0/2] packfile: freshen the mtime of packfile by configuration
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sun Chao <16657101987@163.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

packfile: freshen the mtime of packfile by bump file

We've talked about the cache reload through earlier patches, and we stopped
because no further evidence can tell NFS client will reload the page caches
if the file mtime changed. So our team have done these experiments:

Step1: prepare git servers which mount the NFS disk and a big repo

We prepared 3 vms named c1, s1 and s2, we also have a NFS server named n1.
s1 and s2 mount the NFS disk from n1 by:

    mount -t nfs -o vers=3,timeo=600,nolock,noatime,lookupcache=postive,\
    actimeo=3 <n1 ip addr>:/repositories /mnt/repositories


We setup git server services on s1 and s2, so we can clone repos from s1 by
git commands. Then we created a repository under /mnt/repositories, and
pushed large files to the repository, so we can find a large .pack file in
the repository with about 1.2 GB size.

Step2: do first git clone from client after drop caches of s1

First we drop the caches from s1 by:

    sync; echo 3 > /proc/sys/vm/drop_caches


Then we run git command in c1 to clone the huge repository we created in
Step1, at the same time we run the two commands in s1:

    tcpdump -nn host <n1 ip addr> -w 1st_command.pcap
    nfsiostat 1 -p /mnt/repositories


try to get the result and check what happends.

Step3: do new git clones without drop caches of s1

After Step2, we called new git clone command in c1 to clone the huge
repository for serveral times, and also run the commands at the same time:

    tcpdump -nn host <n1 ip addr> -w lots_of_command.pcap
    nfsiostat 1 -p /mnt/repositories


Step4: do new git clones with packfile mtime changed

After Step2 and Step3, we try to touch all the ".pack" files from s2, and we
call a new git clone in c1 to download the huge repository again, and run
the two command in s1 at the same time:

    tcpdump -nn host <n1 ip addr> -w mtime_changed_command.pcap
    nfsiostat 1 -p /mnt/repositories


Result:

We got a about 1.4GB big pcap file during Step2 and Step4, we can find lots
of READ request and response after open it with wireshark. And by
'nfsiostat' command we can see the 'ops/s' and 'KB/s' of 'read' in the
output shows a relatively large value for a while.

But we got a 4MB pcap file in Step3, and open it with wireshark, we can only
find GETATTR and FSSTAT requests and response. And we the 'nfsiostat' always
show 0 in 'ops/s' and 'KB/s' of 'read' part in the output.

We have done Step1 to Step4 serveral times, each time the result are same.

So we can make sure the NFS client will reload the page cache if other NFS
client changes the mtime of the large .pack files. And for git servers which
use filesystem like NFS to manage large repositories, reload large files
that only have mtime changed result big NFS server IOPS pressure and that
also makes the git server slow because the IO is the bottleneck when there
are too many client requests for the same big repositries.

And I do think the team who manage the git servers need a configuration
choise which can enhance the mtime of packfile through another file which
should be small enough or even empty. It should be backward compatibility
when it is in default value, but just as metioned by Ævar before, maybe
somepeople what to use it in mixed-version environment, we should warn them
in documents, but such configuration do big help for some team who run some
servers mount the NFS disks.

Sun Chao (2):
  packfile: rename `derive_filename()` to `derive_pack_filename()`
  packfile: freshen the mtime of packfile by bump file

 Documentation/config/core.txt   |  11 +++
 builtin/index-pack.c            |  19 +----
 cache.h                         |   1 +
 config.c                        |   5 ++
 environment.c                   |   1 +
 object-file.c                   |  30 +++++++-
 packfile.c                      |  25 ++++++-
 packfile.h                      |   7 ++
 t/t5326-pack-mtime-bumpfiles.sh | 118 ++++++++++++++++++++++++++++++++
 9 files changed, 198 insertions(+), 19 deletions(-)
 create mode 100755 t/t5326-pack-mtime-bumpfiles.sh


base-commit: 5d213e46bb7b880238ff5ea3914e940a50ae9369
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1043%2Fsunchao9%2Fmaster-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1043/sunchao9/master-v4
Pull-Request: https://github.com/git/git/pull/1043

Range-diff vs v3:

 -:  ----------- > 1:  81afc69d22c packfile: rename `derive_filename()` to `derive_pack_filename()`
 1:  16c68923bea ! 2:  7166f776154 packfile: freshen the mtime of packfile by configuration
     @@ Metadata
      Author: Sun Chao <16657101987@163.com>
      
       ## Commit message ##
     -    packfile: freshen the mtime of packfile by configuration
     +    packfile: freshen the mtime of packfile by bump file
      
          Commit 33d4221c79 (write_sha1_file: freshen existing objects,
          2014-10-15) avoid writing existing objects by freshen their
     @@ Commit message
          create same commit with the same tree and same environments
          such like GIT_COMMITTER_DATE and GIT_AUTHOR_DATE, we can
          notice the '.pack' file's mtime changed. Git servers
     -    that mount the same NFS disk will re-sync the '.pack' files
     -    to cached file system which will slow the git commands.
     +    that use filesystems like NFS will reload the '.pack' files
     +    to file system page cache, which will slow the git commands.
      
     -    So if add core.freshenPackfiles to indicate whether or not
     -    packs can be freshened, turning off this option on some
     -    servers can speed up the execution of some commands on servers
     -    which use NFS disk instead of local disk.
     +    So if we freshen the mtime of packfile by updating a '.bump'
     +    file instead, when we check the mtime of packfile, get it from
     +    '.bump' file also. Large git repository may contains large
     +    '.pack' files, but '.bump' files can be empty. This will avoid
     +    file system page caches reload large files from NFS and then
     +    make git commands faster.
      
          Signed-off-by: Sun Chao <16657101987@163.com>
      
     @@ Documentation/config/core.txt: the largest projects.  You probably do not need t
       +
       Common unit suffixes of 'k', 'm', or 'g' are supported.
       
     -+core.freshenPackFiles::
     ++core.packMtimeToBumpFiles::
      +	Normally we avoid writing existing object by freshening the mtime
      +	of the *.pack file which contains it in order to aid some processes
     -+	such like prune. Turning off this option on some servers can speed
     -+	up the execution of some commands like 'git-upload-pack'(e.g. some
     -+	servers that mount the same NFS disk will re-sync the *.pack files
     -+	to cached file system if the mtime cahnges).
     ++	such like prune. Use a *.bump file instead of *.pack file will
     ++	avoid file system cache re-sync the large packfiles on filesystems
     ++	like NFS, and consequently make git commands faster.
      ++
     -+The default is true which means the *.pack file will be freshened if we
     -+want to write a existing object whthin it.
     ++The default is 'false' which means the *.pack file will be freshened by
     ++default. If set to 'true', the file with the '.bump' suffix will be
     ++created automatically, and it's mtime will be freshened instead.
      +
       core.deltaBaseCacheLimit::
       	Maximum number of bytes per thread to reserve for caching base objects
       	that may be referenced by multiple deltified objects.  By storing the
      
       ## cache.h ##
     -@@ cache.h: extern size_t packed_git_limit;
     +@@ cache.h: extern const char *git_hooks_path;
     + extern int zlib_compression_level;
     + extern int core_compression_level;
     + extern int pack_compression_level;
     ++extern int pack_mtime_to_bumpfiles;
     + extern size_t packed_git_window_size;
     + extern size_t packed_git_limit;
       extern size_t delta_base_cache_limit;
     - extern unsigned long big_file_threshold;
     - extern unsigned long pack_size_limit_cfg;
     -+extern int core_freshen_packfiles;
     - 
     - /*
     -  * Accessors for the core.sharedrepository config which lazy-load the value
      
       ## config.c ##
      @@ config.c: static int git_default_core_config(const char *var, const char *value, void *cb)
       		return 0;
       	}
       
     -+	if (!strcmp(var, "core.freshenpackfiles")) {
     -+		core_freshen_packfiles = git_config_bool(var, value);
     ++	if (!strcmp(var, "core.packmtimetobumpfiles")) {
     ++		pack_mtime_to_bumpfiles = git_config_bool(var, value);
     ++		return 0;
      +	}
      +
       	if (!strcmp(var, "core.deltabasecachelimit")) {
     @@ config.c: static int git_default_core_config(const char *var, const char *value,
       		return 0;
      
       ## environment.c ##
     -@@ environment.c: int core_sparse_checkout_cone;
     - int merge_log_config = -1;
     - int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
     - unsigned long pack_size_limit_cfg;
     -+int core_freshen_packfiles = 1;
     - enum log_refs_config log_all_ref_updates = LOG_REFS_UNSET;
     - 
     - #ifndef PROTECT_HFS_DEFAULT
     +@@ environment.c: const char *git_hooks_path;
     + int zlib_compression_level = Z_BEST_SPEED;
     + int core_compression_level;
     + int pack_compression_level = Z_DEFAULT_COMPRESSION;
     ++int pack_mtime_to_bumpfiles;
     + int fsync_object_files;
     + size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
     + size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
      
       ## object-file.c ##
      @@ object-file.c: static int freshen_loose_object(const struct object_id *oid)
       static int freshen_packed_object(const struct object_id *oid)
       {
       	struct pack_entry e;
     -+
     -+	if (!core_freshen_packfiles)
     -+		return 1;
     ++	struct stat st;
     ++	struct strbuf name_buf = STRBUF_INIT;
     ++	const char *filename;
      +
       	if (!find_pack_entry(the_repository, oid, &e))
       		return 0;
       	if (e.p->freshened)
     + 		return 1;
     +-	if (!freshen_file(e.p->pack_name))
     +-		return 0;
     ++
     ++	filename = e.p->pack_name;
     ++	if (!pack_mtime_to_bumpfiles) {
     ++		if (!freshen_file(filename))
     ++			return 0;
     ++		e.p->freshened = 1;
     ++		return 1;
     ++	}
     ++
     ++	filename = derive_pack_filename(filename, "pack", "bump", &name_buf);
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
     ++
     + 	e.p->freshened = 1;
     + 	return 1;
     + }
      
     - ## t/t7701-repack-unpack-unreachable.sh ##
     -@@ t/t7701-repack-unpack-unreachable.sh: test_expect_success 'do not bother loosening old objects' '
     - 	test_must_fail git cat-file -p $obj2
     - '
     + ## packfile.c ##
     +@@ packfile.c: void close_object_store(struct raw_object_store *o)
       
     -+test_expect_success 'do not bother loosening old objects without freshen pack time' '
     -+	obj1=$(echo three | git hash-object -w --stdin) &&
     -+	obj2=$(echo four | git hash-object -w --stdin) &&
     -+	pack1=$(echo $obj1 | git -c core.freshenPackFiles=false pack-objects .git/objects/pack/pack) &&
     -+	pack2=$(echo $obj2 | git -c core.freshenPackFiles=false pack-objects .git/objects/pack/pack) &&
     -+	git -c core.freshenPackFiles=false prune-packed &&
     + void unlink_pack_path(const char *pack_name, int force_delete)
     + {
     +-	static const char *exts[] = {".pack", ".idx", ".rev", ".keep", ".bitmap", ".promisor"};
     ++	static const char *exts[] = {".pack", ".idx", ".rev", ".keep", ".bitmap", ".promisor", ".bump"};
     + 	int i;
     + 	struct strbuf buf = STRBUF_INIT;
     + 	size_t plen;
     +@@ packfile.c: struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
     + 	p->pack_size = st.st_size;
     + 	p->pack_local = local;
     + 	p->mtime = st.st_mtime;
     ++
     ++	if (pack_mtime_to_bumpfiles) {
     ++		struct strbuf name_buf = STRBUF_INIT;
     ++		const char *filename;
     ++
     ++		filename = derive_pack_filename(path, "idx", "bump", &name_buf);
     ++		if (!stat(filename, &st)) {
     ++			p->mtime = st.st_mtime;
     ++		}
     ++	}
     + 	if (path_len < the_hash_algo->hexsz ||
     + 	    get_sha1_hex(path + path_len - the_hash_algo->hexsz, p->hash))
     + 		hashclr(p->hash);
     +
     + ## t/t5326-pack-mtime-bumpfiles.sh (new) ##
     +@@
     ++#!/bin/sh
     ++
     ++test_description='packfile mtime use bump files'
     ++. ./test-lib.sh
     ++
     ++if stat -c %Y . >/dev/null 2>&1; then
     ++    get_modified_time() { stat -c %Y "$1" 2>/dev/null; }
     ++elif stat -f %m . >/dev/null 2>&1; then
     ++    get_modified_time() { stat -f %m "$1" 2>/dev/null; }
     ++elif date -r . +%s >/dev/null 2>&1; then
     ++    get_modified_time() { date -r "$1" +%s 2>/dev/null; }
     ++else
     ++    echo 'get_modified_time() is unsupported' >&2
     ++    get_modified_time() { printf '%s' 0; }
     ++fi
     ++
     ++test_expect_success 'freshen existing packfile without core.packMtimeToBumpFiles' '
     ++	obj1=$(echo one | git hash-object -w --stdin) &&
     ++	obj2=$(echo two | git hash-object -w --stdin) &&
     ++	pack1=$(echo $obj1 | git pack-objects .git/objects/pack/pack) &&
     ++	pack2=$(echo $obj2 | git pack-objects .git/objects/pack/pack) &&
     ++	test-tool chmtime =-60 .git/objects/pack/pack-$pack1.* &&
     ++	test-tool chmtime =-60 .git/objects/pack/pack-$pack2.* &&
     ++	pack1_mtime=$(get_modified_time .git/objects/pack/pack-$pack1.pack) &&
     ++	pack2_mtime=$(get_modified_time .git/objects/pack/pack-$pack2.pack) &&
     ++	(echo one | git hash-object -w --stdin) &&
     ++	! test_path_exists .git/objects/pack/pack-$pack1.bump &&
     ++	! test_path_exists .git/objects/pack/pack-$pack2.bump &&
     ++	pack1_mtime_new=$(get_modified_time .git/objects/pack/pack-$pack1.pack) &&
     ++	pack2_mtime_new=$(get_modified_time .git/objects/pack/pack-$pack2.pack) &&
     ++	echo "$pack1_mtime : $pack1_mtime_new" &&
     ++	test ! "$pack1_mtime" = "$pack1_mtime_new" &&
     ++	test "$pack2_mtime" = "$pack2_mtime_new"
     ++
     ++'
     ++
     ++test_expect_success 'freshen existing packfile with core.packMtimeToBumpFiles' '
     ++
     ++	rm -rf .git/objects && git init &&
     ++	obj1=$(echo one | git hash-object -w --stdin) &&
     ++	obj2=$(echo two | git hash-object -w --stdin) &&
     ++	pack1=$(echo $obj1 | git pack-objects .git/objects/pack/pack) &&
     ++	pack2=$(echo $obj2 | git pack-objects .git/objects/pack/pack) &&
     ++	test-tool chmtime =-60 .git/objects/pack/pack-$pack1.* &&
     ++	test-tool chmtime =-60 .git/objects/pack/pack-$pack2.* &&
     ++	pack1_mtime=$(get_modified_time .git/objects/pack/pack-$pack1.pack) &&
     ++	pack2_mtime=$(get_modified_time .git/objects/pack/pack-$pack2.pack) &&
     ++	(echo one | git -c core.packMtimeToBumpFiles=true hash-object -w --stdin) &&
     ++	test_path_exists .git/objects/pack/pack-$pack1.bump &&
     ++	! test_path_exists .git/objects/pack/pack-$pack2.bump &&
     ++	pack1_mtime_new=$(get_modified_time .git/objects/pack/pack-$pack1.pack) &&
     ++	pack2_mtime_new=$(get_modified_time .git/objects/pack/pack-$pack2.pack) &&
     ++	test "$pack1_mtime" = "$pack1_mtime_new" &&
     ++	test "$pack2_mtime" = "$pack2_mtime_new"
     ++
     ++'
     ++
     ++test_expect_success 'repack prune unreachable objects without core.packMtimeToBumpFiles' '
     ++
     ++	rm -rf .git/objects && git init &&
     ++	obj1=$(echo one | git hash-object -w --stdin) &&
     ++	obj2=$(echo two | git hash-object -w --stdin) &&
     ++	pack1=$(echo $obj1 | git pack-objects .git/objects/pack/pack) &&
     ++	pack2=$(echo $obj2 | git pack-objects .git/objects/pack/pack) &&
     ++	echo one | git hash-object -w --stdin &&
     ++	echo two | git hash-object -w --stdin &&
     ++	! test_path_exists .git/objects/pack/pack-$pack1.bump &&
     ++	! test_path_exists .git/objects/pack/pack-$pack2.bump &&
     ++	git prune-packed &&
      +	git cat-file -p $obj1 &&
      +	git cat-file -p $obj2 &&
      +	test-tool chmtime =-86400 .git/objects/pack/pack-$pack2.pack &&
     -+	git -c core.freshenPackFiles=false repack -A -d --unpack-unreachable=1.hour.ago &&
     ++	git repack -A -d --unpack-unreachable=1.hour.ago &&
     ++	git cat-file -p $obj1 &&
     ++	test_must_fail git cat-file -p $obj2
     ++
     ++'
     ++
     ++test_expect_success 'repack prune unreachable objects with core.packMtimeToBumpFiles and bump files' '
     ++
     ++	rm -rf .git/objects && git init &&
     ++	obj1=$(echo one | git hash-object -w --stdin) &&
     ++	obj2=$(echo two | git hash-object -w --stdin) &&
     ++	pack1=$(echo $obj1 | git pack-objects .git/objects/pack/pack) &&
     ++	pack2=$(echo $obj2 | git pack-objects .git/objects/pack/pack) &&
     ++	echo one | git -c core.packMtimeToBumpFiles=true hash-object -w --stdin &&
     ++	echo two | git -c core.packMtimeToBumpFiles=true hash-object -w --stdin &&
     ++	test_path_exists .git/objects/pack/pack-$pack1.bump &&
     ++	test_path_exists .git/objects/pack/pack-$pack2.bump &&
     ++	test-tool chmtime =-86400 .git/objects/pack/pack-$pack2.pack &&
     ++	git -c core.packMtimeToBumpFiles=true repack -A -d --unpack-unreachable=1.hour.ago &&
     ++	git cat-file -p $obj1 &&
     ++	git cat-file -p $obj2
     ++
     ++'
     ++
     ++test_expect_success 'repack prune unreachable objects with core.packMtimeToBumpFiles and old bump files' '
     ++
     ++	rm -rf .git/objects && git init &&
     ++	obj1=$(echo one | git hash-object -w --stdin) &&
     ++	obj2=$(echo two | git hash-object -w --stdin) &&
     ++	pack1=$(echo $obj1 | git pack-objects .git/objects/pack/pack) &&
     ++	pack2=$(echo $obj2 | git pack-objects .git/objects/pack/pack) &&
     ++	echo one | git -c core.packMtimeToBumpFiles=true hash-object -w --stdin &&
     ++	echo two | git -c core.packMtimeToBumpFiles=true hash-object -w --stdin &&
     ++	test_path_exists .git/objects/pack/pack-$pack1.bump &&
     ++	test_path_exists .git/objects/pack/pack-$pack2.bump &&
     ++	git prune-packed &&
     ++	git cat-file -p $obj1 &&
     ++	git cat-file -p $obj2 &&
     ++	test-tool chmtime =-86400 .git/objects/pack/pack-$pack2.bump &&
     ++	git -c core.packMtimeToBumpFiles=true repack -A -d --unpack-unreachable=1.hour.ago &&
      +	git cat-file -p $obj1 &&
      +	test_must_fail git cat-file -p $obj2
     ++
      +'
      +
     - test_expect_success 'keep packed objects found only in index' '
     - 	echo my-unique-content >file &&
     - 	git add file &&
     ++test_done

-- 
gitgitgadget
