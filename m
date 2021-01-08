Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBCEC433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9273D23A7B
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbhAHSUw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbhAHSUv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:20:51 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7461C0612FF
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:20:10 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id u26so10670722iof.3
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FopYTCAPpSmkVT6qgVdcS3FCh1/P8uB4hGHQFy2K3PU=;
        b=AZ7pe0WHiCwvoOMzxkMVGwbBJ9bN7ENtu8j9+D2PXFZ0p+GN3tMPJ8KVMjKiPkz0Pc
         K4/DWSZ8RnO252H/g68hfZniBsw+bHcmR8oWQV2MR+I47tpz5zizbyOiq5F23FJ5txDw
         P6yt/PnTjzSmX/Ybs8GR5O9l1fem4FmzDDZqV8zMd1id4F8GYyFppne5xd9SlYUtC5KP
         BHqgMxV+mcm4xUKRI5NKAVenscQj5e/dSNvJMBYECExO5T/kHR9TltPn/81wSiYN1IWU
         dhFudcBu/Z+cWhHs+a9EB74TdXYUAClkOmvlTgg2S3BZOixUO1kGP+ZFUTDHO3+YE5/I
         5RGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FopYTCAPpSmkVT6qgVdcS3FCh1/P8uB4hGHQFy2K3PU=;
        b=jcOQsVuSIRloZpWTOfBeYWLL7P5sMUBZUSUgvWqN73DhKe+VUBNNxZNRyAzsjePIyB
         KM4Xz0/hBNO3jmn2StUsl3AMFNk0mc2iJDFE9memDZbpSF0BDT7irgD2XPLlmWMiETOO
         xsr7OrSWAQ5+TpgjVXOEiTJg2uKlndftzDZ1btm+g2rLqIxs9yTItfLa7En0KtHxC1jn
         yYVGpqpBTzx4iPGpEygKko9zHI8gKC+h4Sh98MW3F46t0dejL3DI1d/HhUvOuXngXmKM
         6MufE3etehMvUayhRobNQAhCHh7X43khSd7WZCM1W08QuyOnrFQJxSr/b4/60X0V4lzk
         B7yA==
X-Gm-Message-State: AOAM532kDqiMGku3kU10UVxb+USHLxgA0OWnP9bz8svIcnbWmr04+ohR
        PWomxlTuZ+pl+aWPl/EquQyJB5+LJjh4iw==
X-Google-Smtp-Source: ABdhPJxWaSphpFlVR4QngZnxhvEdA3KxYxNXoc7U4jQ21sz3LQ1gjR7cNXlvORIg+1mi6K0ZqbToXQ==
X-Received: by 2002:a02:9691:: with SMTP id w17mr4509546jai.9.1610130009837;
        Fri, 08 Jan 2021 10:20:09 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id j15sm7790496ile.1.2021.01.08.10.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:20:09 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:20:07 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Subject: [PATCH 3/8] builtin/index-pack.c: write reverse indexes
Message-ID: <b0a7329824f4ad674d41a017f694893b510aa43c.1610129989.git.me@ttaylorr.com>
References: <cover.1610129989.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129989.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach 'git index-pack' to optionally write and verify reverse index with
'--[no-]rev-index', as well as respecting the 'pack.writeReverseIndex'
configuration option.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-index-pack.txt | 20 ++++++---
 builtin/index-pack.c             | 64 ++++++++++++++++++++++++-----
 t/t5325-reverse-index.sh         | 69 ++++++++++++++++++++++++++++++++
 3 files changed, 137 insertions(+), 16 deletions(-)
 create mode 100755 t/t5325-reverse-index.sh

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index af0c26232c..b65f380269 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -9,17 +9,18 @@ git-index-pack - Build pack index file for an existing packed archive
 SYNOPSIS
 --------
 [verse]
-'git index-pack' [-v] [-o <index-file>] <pack-file>
+'git index-pack' [-v] [-o <index-file>] [--[no-]rev-index] <pack-file>
 'git index-pack' --stdin [--fix-thin] [--keep] [-v] [-o <index-file>]
-                 [<pack-file>]
+		  [--[no-]rev-index] [<pack-file>]
 
 
 DESCRIPTION
 -----------
 Reads a packed archive (.pack) from the specified file, and
-builds a pack index file (.idx) for it.  The packed archive
-together with the pack index can then be placed in the
-objects/pack/ directory of a Git repository.
+builds a pack index file (.idx) for it. Optionally writes a
+reverse-index (.rev) for the specified pack. The packed
+archive together with the pack index can then be placed in
+the objects/pack/ directory of a Git repository.
 
 
 OPTIONS
@@ -33,7 +34,14 @@ OPTIONS
 	file is constructed from the name of packed archive
 	file by replacing .pack with .idx (and the program
 	fails if the name of packed archive does not end
-	with .pack).
+	with .pack). Incompatible with `--rev-index`.
+
+--[no-]rev-index::
+	When this flag is provided, generate a reverse index
+	(a `.rev` file) corresponding to the given pack. If
+	`--verify` is given, ensure that the existing
+	reverse index is correct. Takes precedence over
+	`pack.writeReverseIndex`.
 
 --stdin::
 	When this flag is provided, the pack is read from stdin
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 4b8d86e0ad..03408250b1 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -17,7 +17,7 @@
 #include "promisor-remote.h"
 
 static const char index_pack_usage[] =
-"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--verify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
+"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
 
 struct object_entry {
 	struct pack_idx_entry idx;
@@ -1436,13 +1436,13 @@ static void fix_unresolved_deltas(struct hashfile *f)
 	free(sorted_by_pos);
 }
 
-static const char *derive_filename(const char *pack_name, const char *suffix,
-				   struct strbuf *buf)
+static const char *derive_filename(const char *pack_name, const char *strip,
+				   const char *suffix, struct strbuf *buf)
 {
 	size_t len;
-	if (!strip_suffix(pack_name, ".pack", &len))
-		die(_("packfile name '%s' does not end with '.pack'"),
-		    pack_name);
+	if (!strip_suffix(pack_name, strip, &len))
+		die(_("packfile name '%s' does not end with '%s'"),
+		    pack_name, strip);
 	strbuf_add(buf, pack_name, len);
 	strbuf_addch(buf, '.');
 	strbuf_addstr(buf, suffix);
@@ -1459,7 +1459,7 @@ static void write_special_file(const char *suffix, const char *msg,
 	int msg_len = strlen(msg);
 
 	if (pack_name)
-		filename = derive_filename(pack_name, suffix, &name_buf);
+		filename = derive_filename(pack_name, ".pack", suffix, &name_buf);
 	else
 		filename = odb_pack_name(&name_buf, hash, suffix);
 
@@ -1484,12 +1484,14 @@ static void write_special_file(const char *suffix, const char *msg,
 
 static void final(const char *final_pack_name, const char *curr_pack_name,
 		  const char *final_index_name, const char *curr_index_name,
+		  const char *final_rev_index_name, const char *curr_rev_index_name,
 		  const char *keep_msg, const char *promisor_msg,
 		  unsigned char *hash)
 {
 	const char *report = "pack";
 	struct strbuf pack_name = STRBUF_INIT;
 	struct strbuf index_name = STRBUF_INIT;
+	struct strbuf rev_index_name = STRBUF_INIT;
 	int err;
 
 	if (!from_stdin) {
@@ -1524,6 +1526,16 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 	} else
 		chmod(final_index_name, 0444);
 
+	if (curr_rev_index_name) {
+		if (final_rev_index_name != curr_rev_index_name) {
+			if (!final_rev_index_name)
+				final_rev_index_name = odb_pack_name(&rev_index_name, hash, "rev");
+			if (finalize_object_file(curr_rev_index_name, final_rev_index_name))
+				die(_("cannot store reverse index file"));
+		} else
+			chmod(final_rev_index_name, 0444);
+	}
+
 	if (do_fsck_object) {
 		struct packed_git *p;
 		p = add_packed_git(final_index_name, strlen(final_index_name), 0);
@@ -1553,6 +1565,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		}
 	}
 
+	strbuf_release(&rev_index_name);
 	strbuf_release(&index_name);
 	strbuf_release(&pack_name);
 }
@@ -1578,6 +1591,12 @@ static int git_index_pack_config(const char *k, const char *v, void *cb)
 		}
 		return 0;
 	}
+	if (!strcmp(k, "pack.writereverseindex")) {
+		if (git_config_bool(k, v))
+			opts->flags |= WRITE_REV;
+		else
+			opts->flags &= ~WRITE_REV;
+	}
 	return git_default_config(k, v, cb);
 }
 
@@ -1695,12 +1714,14 @@ static void show_pack_info(int stat_only)
 
 int cmd_index_pack(int argc, const char **argv, const char *prefix)
 {
-	int i, fix_thin_pack = 0, verify = 0, stat_only = 0;
+	int i, fix_thin_pack = 0, verify = 0, stat_only = 0, rev_index;
 	const char *curr_index;
-	const char *index_name = NULL, *pack_name = NULL;
+	const char *curr_rev_index = NULL;
+	const char *index_name = NULL, *pack_name = NULL, *rev_index_name = NULL;
 	const char *keep_msg = NULL;
 	const char *promisor_msg = NULL;
 	struct strbuf index_name_buf = STRBUF_INIT;
+	struct strbuf rev_index_name_buf = STRBUF_INIT;
 	struct pack_idx_entry **idx_objects;
 	struct pack_idx_option opts;
 	unsigned char pack_hash[GIT_MAX_RAWSZ];
@@ -1727,6 +1748,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (prefix && chdir(prefix))
 		die(_("Cannot come back to cwd"));
 
+	rev_index = !!(opts.flags & (WRITE_REV_VERIFY | WRITE_REV));
+
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
@@ -1805,6 +1828,10 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				if (hash_algo == GIT_HASH_UNKNOWN)
 					die(_("unknown hash algorithm '%s'"), arg);
 				repo_set_hash_algo(the_repository, hash_algo);
+			} else if (!strcmp(arg, "--rev-index")) {
+				rev_index = 1;
+			} else if (!strcmp(arg, "--no-rev-index")) {
+				rev_index = 0;
 			} else
 				usage(index_pack_usage);
 			continue;
@@ -1824,7 +1851,16 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (from_stdin && hash_algo)
 		die(_("--object-format cannot be used with --stdin"));
 	if (!index_name && pack_name)
-		index_name = derive_filename(pack_name, "idx", &index_name_buf);
+		index_name = derive_filename(pack_name, ".pack", "idx", &index_name_buf);
+
+	opts.flags &= ~(WRITE_REV | WRITE_REV_VERIFY);
+	if (rev_index) {
+		opts.flags |= verify ? WRITE_REV_VERIFY : WRITE_REV;
+		if (index_name)
+			rev_index_name = derive_filename(index_name,
+							 ".idx", "rev",
+							 &rev_index_name_buf);
+	}
 
 	if (verify) {
 		if (!index_name)
@@ -1878,11 +1914,16 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	for (i = 0; i < nr_objects; i++)
 		idx_objects[i] = &objects[i].idx;
 	curr_index = write_idx_file(index_name, idx_objects, nr_objects, &opts, pack_hash);
+	if (rev_index)
+		curr_rev_index = write_rev_file(rev_index_name, idx_objects,
+						nr_objects, pack_hash,
+						opts.flags);
 	free(idx_objects);
 
 	if (!verify)
 		final(pack_name, curr_pack,
 		      index_name, curr_index,
+		      rev_index_name, curr_rev_index,
 		      keep_msg, promisor_msg,
 		      pack_hash);
 	else
@@ -1893,10 +1934,13 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 
 	free(objects);
 	strbuf_release(&index_name_buf);
+	strbuf_release(&rev_index_name_buf);
 	if (pack_name == NULL)
 		free((void *) curr_pack);
 	if (index_name == NULL)
 		free((void *) curr_index);
+	if (rev_index_name == NULL)
+		free((void *) curr_rev_index);
 
 	/*
 	 * Let the caller know this pack is not self contained
diff --git a/t/t5325-reverse-index.sh b/t/t5325-reverse-index.sh
new file mode 100755
index 0000000000..f9afa698dc
--- /dev/null
+++ b/t/t5325-reverse-index.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+
+test_description='on-disk reverse index'
+. ./test-lib.sh
+
+packdir=.git/objects/pack
+
+test_expect_success 'setup' '
+	test_commit base &&
+
+	pack=$(git pack-objects --all $packdir/pack) &&
+	rev=$packdir/pack-$pack.rev &&
+
+	test_path_is_missing $rev
+'
+
+test_index_pack () {
+	rm -f $rev &&
+	conf=$1 &&
+	shift &&
+	git -c pack.writeReverseIndex=$conf index-pack "$@" \
+		$packdir/pack-$pack.pack
+}
+
+test_expect_success 'index-pack with pack.writeReverseIndex' '
+	test_index_pack "" &&
+	test_path_is_missing $rev &&
+
+	test_index_pack false &&
+	test_path_is_missing $rev &&
+
+	test_index_pack true &&
+	test_path_is_file $rev
+'
+
+test_expect_success 'index-pack with --[no-]rev-index' '
+	for conf in "" true false
+	do
+		test_index_pack "$conf" --rev-index &&
+		test_path_exists $rev &&
+
+		test_index_pack "$conf" --no-rev-index &&
+		test_path_is_missing $rev
+	done
+'
+
+test_expect_success 'index-pack can verify reverse indexes' '
+	test_when_finished "rm -f $rev" &&
+	test_index_pack true &&
+
+	test_path_is_file $rev &&
+	git index-pack --rev-index --verify $packdir/pack-$pack.pack &&
+
+	# Intentionally corrupt the reverse index.
+	chmod u+w $rev &&
+	printf "xxxx" | dd of=$rev bs=1 count=4 conv=notrunc &&
+
+	test_must_fail git index-pack --rev-index --verify \
+		$packdir/pack-$pack.pack 2>err &&
+	grep "validation error" err
+'
+
+test_expect_success 'index-pack infers reverse index name with -o' '
+	git index-pack --rev-index -o other.idx $packdir/pack-$pack.pack &&
+	test_path_is_file other.idx &&
+	test_path_is_file other.rev
+'
+
+test_done
-- 
2.30.0.138.g6d7191ea01

