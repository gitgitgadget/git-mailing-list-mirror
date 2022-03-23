Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DEAC433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 14:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244757AbiCWOUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 10:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244696AbiCWOUU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 10:20:20 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E5B7C79B
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 07:18:50 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id p12-20020a05600c430c00b0038cbdf52227so1014391wme.2
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 07:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aiCX82v4JkbKLcnp7TNkHQh6J48cLvQ+k4Zd2qEfSN8=;
        b=bwJC5IJ4DN/wEvzENoMXM5Pk9y7JMbCdr+zMGUmTyrqDIax8gPFqdub1+7nHtskK22
         oHMBIkiteDiQ5gD41Cu1s3/zL56eIc98szYYqVBK6GrtX98cCopH/HMkREX1eOz47ZoK
         SAO3dJck0Tl94vVmqY7znAoZYSFvEEzaN/sZjiW0v7sX3xmRWPbFARoC/MNLH1YQYcHt
         BiO8ETZVJ+d9mroRJYg87cYFc/f5m42ZgsJ4E/WZilju58Nbea0CqH0Mfxbp14vyddeX
         C1eIY+LHgABTIDOt/GWaPVglb7JLTxjb8ID2USEXWAeIggTe2J1LqKjWjfbiix2gcqtE
         X8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aiCX82v4JkbKLcnp7TNkHQh6J48cLvQ+k4Zd2qEfSN8=;
        b=2Fk6hV6YP9pED38vKFq6qqafpBZbba37tDLjcdSZ5JrjzJRDblB9XknS6NBDWInlfd
         gKOXhZ5uTNXrv0hYtWS2R/yB859kisrwysyQ9fbn/pNIKMHYW0o3SS7XvbctAJ4N0lFJ
         wFsj+u9+yAABlo+yzSL/FCPRN+vaG69FvKaCxxAL0UecA8EXvPXueq1ome1WStTcKpn2
         5O3A9QBT6k8soSeRpMxOW3j5G8N/FOTk91419z/Cpz8lAV1po4xNO37rAySK03QzoMHN
         OGIU7FsftGsFbSi5x8PO4kAThy5CZWq5NHKEmPG1dJEgA1DU2LccVeP23fQYChjLKpin
         clNQ==
X-Gm-Message-State: AOAM530C3n/r8CxQmrAviNwp4agUDxYhhTM4DcFAacvlOffW2d8T6HjI
        aoXeiV9bOYdGEuBLaTapOSP5u+bfsk06gA==
X-Google-Smtp-Source: ABdhPJw3fCEsDluLch1z72EN/SBdW/Ww18SqH5+vww/KbDcxWtjKcxX3aRGq9mXnsq1l2hTk4gcsXA==
X-Received: by 2002:a05:600c:2188:b0:38c:9a21:9c95 with SMTP id e8-20020a05600c218800b0038c9a219c95mr9040207wme.87.1648045128486;
        Wed, 23 Mar 2022 07:18:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q14-20020a1cf30e000000b0038986a18ec8sm30592wmq.46.2022.03.23.07.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 07:18:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 5/7] add: use WLI_NEED_LOOSE_FSYNC for new "only the index" bulk fsync()
Date:   Wed, 23 Mar 2022 15:18:29 +0100
Message-Id: <RFC-patch-v2-5.7-2bf14fd4946-20220323T140753Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1428.g1c1a0152d61
In-Reply-To: <RFC-cover-v2-0.7-00000000000-20220323T140753Z-avarab@gmail.com>
References: <RFC-cover-0.7-00000000000-20220323T033928Z-avarab@gmail.com> <RFC-cover-v2-0.7-00000000000-20220323T140753Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can now bring "bulk" syncing back to "git add" using a mechanism
discussed in the preceding commit where we fsync() on the index, not
the last object we write.

On a ramdisk:

	$ git hyperfine -L rev ns/batched-fsync,HEAD -s 'make CFLAGS=-O3 && rm -rf repo && git init repo && cp -R t repo/' -p 'rm -rf repo/.git/objects/* repo/.git/
	index' './git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo add .' --warmup 1
	Benchmark 1: ./git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo add .' in 'ns/batched-fsync
	  Time (mean ± σ):     299.5 ms ±   1.6 ms    [User: 193.4 ms, System: 103.7 ms]
	  Range (min … max):   296.6 ms … 301.6 ms    10 runs

	Benchmark 2: ./git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo add .' in 'HEAD
	  Time (mean ± σ):     282.8 ms ±   2.1 ms    [User: 193.8 ms, System: 86.6 ms]
	  Range (min … max):   279.1 ms … 285.6 ms    10 runs

	Summary
	  './git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo add .' in 'HEAD' ran
	    1.06 ± 0.01 times faster than './git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo add .' in 'ns/batched-fsync'

My times on my spinning disk are too fuzzy to quote with confidence,
but I have seen it go as well as 15-30% faster. FWIW doing "strace
--summary-only" on the ramdisk is ~20% faster:

	$ git hyperfine -L rev ns/batched-fsync,HEAD -s 'make CFLAGS=-O3 && rm -rf repo && git init repo && cp -R t repo/' -p 'rm -rf repo/.git/objects/* repo/.git/index' 'strace --summary-only ./git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo add .' --warmup 1
	Benchmark 1: strace --summary-only ./git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo add .' in 'ns/batched-fsync
	  Time (mean ± σ):     917.4 ms ±  18.8 ms    [User: 388.7 ms, System: 672.1 ms]
	  Range (min … max):   885.3 ms … 948.1 ms    10 runs

	Benchmark 2: strace --summary-only ./git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo add .' in 'HEAD
	  Time (mean ± σ):     769.0 ms ±   9.2 ms    [User: 358.2 ms, System: 521.2 ms]
	  Range (min … max):   760.7 ms … 792.6 ms    10 runs

	Summary
	  'strace --summary-only ./git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo add .' in 'HEAD' ran
	    1.19 ± 0.03 times faster than 'strace --summary-only ./git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo add .' in 'ns/batched-fsync'

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/add.c | 6 ++++--
 cache.h       | 1 +
 read-cache.c  | 8 ++++++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 3ffb86a4338..6ef18b6246c 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -580,7 +580,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		 (intent_to_add ? ADD_CACHE_INTENT : 0) |
 		 (ignore_add_errors ? ADD_CACHE_IGNORE_ERRORS : 0) |
 		 (!(addremove || take_worktree_changes)
-		  ? ADD_CACHE_IGNORE_REMOVAL : 0));
+		  ? ADD_CACHE_IGNORE_REMOVAL : 0)) |
+		ADD_CACHE_HASH_N_OBJECTS;
 
 	if (read_cache_preload(&pathspec) < 0)
 		die(_("index file corrupt"));
@@ -686,7 +687,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 finish:
 	if (write_locked_index(&the_index, &lock_file,
-			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
+			       COMMIT_LOCK | SKIP_IF_UNCHANGED |
+			       WLI_NEED_LOOSE_FSYNC))
 		die(_("Unable to write new index file"));
 
 	dir_clear(&dir);
diff --git a/cache.h b/cache.h
index 7542e009a34..d57af938cbc 100644
--- a/cache.h
+++ b/cache.h
@@ -857,6 +857,7 @@ int remove_file_from_index(struct index_state *, const char *path);
 #define ADD_CACHE_IGNORE_ERRORS	4
 #define ADD_CACHE_IGNORE_REMOVAL 8
 #define ADD_CACHE_INTENT 16
+#define ADD_CACHE_HASH_N_OBJECTS 32
 /*
  * These two are used to add the contents of the file at path
  * to the index, marking the working tree up-to-date by storing
diff --git a/read-cache.c b/read-cache.c
index 275f6308c32..788423b6dde 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -755,6 +755,14 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	unsigned hash_flags = pretend ? 0 : HASH_WRITE_OBJECT;
 	struct object_id oid;
 
+	/*
+	 * TODO: Can't we also set HASH_N_OBJECTS_FIRST as a function
+	 * of !(ce->ce_flags & CE_ADDED) or something? I'm not too
+	 * familiar with the cache API...
+	 */
+	if (flags & ADD_CACHE_HASH_N_OBJECTS)
+		hash_flags |= HASH_N_OBJECTS;
+
 	if (flags & ADD_CACHE_RENORMALIZE)
 		hash_flags |= HASH_RENORMALIZE;
 
-- 
2.35.1.1428.g1c1a0152d61

