Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7685720281
	for <e@80x24.org>; Fri, 29 Sep 2017 20:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbdI2UM6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 16:12:58 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:46472 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752574AbdI2UMW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 16:12:22 -0400
Received: by mail-pf0-f175.google.com with SMTP id r68so340443pfj.3
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 13:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=vlxo9olA+M1PS3wWPmHTTedOqmvQNxWu69iSVuoPpEI=;
        b=h9NBCROpzKKZRbwLIe4bI9dZBaY+X36yb9IHIjrrWyekop70SesaILmqOCjJ6o53u4
         YrhTARBfgfhxUg47J7aOxxqaC+aazH4P1vvp80+yeFzwUp9/5mBjXmpOpCcSppBpzlOx
         wECCp5nWmPTbbyQnmKeAWDQgt3nwa3zmbqJiJy1TeLkQrphxgodZwGUIQ76mZ9LhKgjt
         pfsdvsjdzIZhqbbIJuUwpApdKqJ+3b78Y1hoVnv/SgeMl3nfHWZm4VFu81KiH4cYqvDx
         fAW9ApIv4aVwYfNFQK3ytB7VY4qDheDGcBNx6e1noaFRBzwg6duSfIlYeEBoP7g/gfbW
         /2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=vlxo9olA+M1PS3wWPmHTTedOqmvQNxWu69iSVuoPpEI=;
        b=HoBOSEgt/KR3BwTry1K8QSw8Lq60SAOvcyCsenYb9BW8bUVhHiSdYpe61yNBkmT2nA
         ACdpHB2/lWjlinsGMtL6I6z96bfYDezJcfgiGjjFCAs8sv2u+nAbztTdgJTLOeiHOV6O
         2QE6kzhLCPML5A1lpvvZVSJDReA1ZVPfp3561DtSeAyjlwUOD5m6/WziEVneKg1Q9jVQ
         SPI+Y2CCIbwoN+bA45FMLKaF9YxraF6dvnZfn9fcoJc4jT6vCrkBQ9eo16LeM6HcenDi
         U15L8C22fdFDCjK9djRHDUB0lvXqtXvspA8NO6KGFVvty8teDDIVpaXPU4ITF3JQCqSz
         WHwQ==
X-Gm-Message-State: AHPjjUghyHfczUL+1j8UneitZoognjRfODUot7ULqtT4PxlLASIFDLrg
        YO62+P8LLXOm46O4QkM0613em9zODXQ=
X-Google-Smtp-Source: AOwi7QDuQ9G3Yl7Mhp8Uki+VpvFXzAeym0hExnDSMF/ZDyd6ao5aXZyPGd5V7dKrQWpw2D2UdRdomw==
X-Received: by 10.98.71.153 with SMTP id p25mr8765154pfi.84.1506715941758;
        Fri, 29 Sep 2017 13:12:21 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id g5sm9280561pgo.66.2017.09.29.13.12.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Sep 2017 13:12:20 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        git@jeffhostetler.com, peartben@gmail.com,
        christian.couder@gmail.com
Subject: [PATCH 11/18] pack-objects: support --blob-max-bytes
Date:   Fri, 29 Sep 2017 13:11:47 -0700
Message-Id: <b9ea93edabc42754dc3643d6307c22a947eabaf3.1506714999.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.748.g20475d2c7
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of an effort to improve Git support for very large repositories
in which clients typically have only a subset of all version-controlled
blobs, teach pack-objects to support --blob-max-bytes, packing only
blobs not exceeding that size unless the blob corresponds to a file
whose name starts with ".git". upload-pack will eventually be taught to
use this new parameter if needed to exclude certain blobs during a fetch
or clone, potentially drastically reducing network consumption when
serving these very large repositories.

Since any excluded blob should not act as a delta base, I did this by
avoiding such oversized blobs from ever going into the "to_pack" data
structure, which contains both preferred bases (which do not go into the
final packfile but can act as delta bases) and the objects to be packed
(which go into the final packfile and also can act as delta bases). To
that end, add_object_entry() has been modified to exclude the
appropriate non-preferred-base objects. (Preferred bases, regardless of
size, still enter "to_pack" - they are something that the client
indicates that it has, not something that the server needs to serve, so
no exclusion occurs.)

If bitmaps are to be used, we would not know if a blob corresponded to a
file whose name starts with ".git". For this reason, when invoked with
--blob-max-bytes, pack-objects will not use bitmaps.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/git-pack-objects.txt | 12 +++++++++-
 builtin/pack-objects.c             | 33 ++++++++++++++++++++++++++--
 t/t5300-pack-object.sh             | 45 ++++++++++++++++++++++++++++++++++++++
 t/test-lib-functions.sh            | 12 ++++++++++
 4 files changed, 99 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 473a16135..ddce2d4c1 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -12,7 +12,8 @@ SYNOPSIS
 'git pack-objects' [-q | --progress | --all-progress] [--all-progress-implied]
 	[--no-reuse-delta] [--delta-base-offset] [--non-empty]
 	[--local] [--incremental] [--window=<n>] [--depth=<n>]
-	[--revs [--unpacked | --all]] [--stdout | base-name]
+	[--revs [--unpacked | --all]]
+	[--stdout [--blob-max-bytes=<n>] | base-name]
 	[--shallow] [--keep-true-parents] < object-list
 
 
@@ -236,6 +237,15 @@ So does `git bundle` (see linkgit:git-bundle[1]) when it creates a bundle.
 	With this option, parents that are hidden by grafts are packed
 	nevertheless.
 
+--blob-max-bytes=<n>::
+	This option can only be used with --stdout. If specified, a blob
+	larger than this will not be packed unless a to-be-packed tree
+	has that blob with a filename beginning with ".git".  The size
+	can be suffixed with "k", "m", or "g", and may be "0".
++
+If specified, after printing the packfile, pack-objects will print, in packet
+format (pkt-line), the names of excluded blobs and their sizes.
+
 SEE ALSO
 --------
 linkgit:git-rev-list[1]
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ef0b61d5f..8686b4351 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -26,6 +26,8 @@
 #include "argv-array.h"
 #include "mru.h"
 #include "packfile.h"
+#include "pkt-line.h"
+#include "varint.h"
 
 static const char *pack_usage[] = {
 	N_("git pack-objects --stdout [<options>...] [< <ref-list> | < <object-list>]"),
@@ -81,6 +83,8 @@ static unsigned long cache_max_small_delta_size = 1000;
 
 static unsigned long window_memory_limit = 0;
 
+static long blob_max_bytes = -1;
+
 /*
  * stats
  */
@@ -1072,6 +1076,27 @@ static const char no_closure_warning[] = N_(
 "disabling bitmap writing, as some objects are not being packed"
 );
 
+/*
+ * Returns 1 if the given blob does not meet any defined blob size
+ * limits.  Blobs that appear as a tree entry whose basename begins with
+ * ".git" are never considered oversized.
+ */
+static int oversized(const unsigned char *sha1, const char *name) {
+	const char *last_slash, *basename;
+	unsigned long size;
+
+	if (blob_max_bytes < 0)
+		return 0;
+
+	last_slash = strrchr(name, '/');
+	basename = last_slash ? last_slash + 1 : name;
+	if (starts_with(basename, ".git"))
+		return 0;
+
+	sha1_object_info(sha1, &size);
+	return size > blob_max_bytes;
+}
+
 static int add_object_entry(const unsigned char *sha1, enum object_type type,
 			    const char *name, int preferred_base)
 {
@@ -1082,7 +1107,8 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 	if (have_duplicate_entry(sha1, preferred_base, &index_pos))
 		return 0;
 
-	if (ignore_object(sha1, preferred_base, &found_pack, &found_offset)) {
+	if (ignore_object(sha1, preferred_base, &found_pack, &found_offset) ||
+	    (!preferred_base && type == OBJ_BLOB && oversized(sha1, name))) {
 		/* The pack is missing an object, so it will not have closure */
 		if (write_bitmap_index) {
 			warning(_(no_closure_warning));
@@ -2956,6 +2982,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("write a bitmap index together with the pack index")),
 		OPT_BOOL(0, "exclude-promisor-objects", &exclude_promisor_objects,
 			 N_("do not pack objects in promisor packfiles")),
+		OPT_MAGNITUDE(0, "blob-max-bytes", &blob_max_bytes,
+			      N_("exclude blobs larger than this")),
 		OPT_END(),
 	};
 
@@ -3054,7 +3082,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		use_bitmap_index = use_bitmap_index_default;
 
 	/* "hard" reasons not to use bitmaps; these just won't work at all */
-	if (!use_internal_rev_list || (!pack_to_stdout && write_bitmap_index) || is_repository_shallow())
+	if (!use_internal_rev_list || (!pack_to_stdout && write_bitmap_index) ||
+	    is_repository_shallow() || (blob_max_bytes >= 0))
 		use_bitmap_index = 0;
 
 	if (pack_to_stdout || !rev_list_all)
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 9c68b9925..697cc20f2 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -457,6 +457,51 @@ test_expect_success !PTHREADS,C_LOCALE_OUTPUT 'pack-objects --threads=N or pack.
 	grep -F "no threads support, ignoring pack.threads" err
 '
 
+lcut () {
+	perl -e '$/ = undef; $_ = <>; s/^.{'$1'}//s; print $_'
+}
+
+test_expect_success '--blob-size-limit works with multiple excluded' '
+	rm -rf server &&
+	git init server &&
+	printf a > server/a &&
+	printf b > server/b &&
+	printf c-very-long-file > server/c &&
+	printf d-very-long-file > server/d &&
+	git -C server add a b c d &&
+	git -C server commit -m x &&
+
+	git -C server rev-parse HEAD >objects &&
+	git -C server pack-objects --revs --stdout --blob-max-bytes=10 <objects >my.pack &&
+
+	# Ensure that only the small blobs are in the packfile
+	git index-pack my.pack &&
+	git verify-pack -v my.idx >objectlist &&
+	grep $(git hash-object server/a) objectlist &&
+	grep $(git hash-object server/b) objectlist &&
+	! grep $(git hash-object server/c) objectlist &&
+	! grep $(git hash-object server/d) objectlist
+'
+
+test_expect_success '--blob-size-limit never excludes special files' '
+	rm -rf server &&
+	git init server &&
+	printf a-very-long-file > server/a &&
+	printf a-very-long-file > server/.git-a &&
+	printf b-very-long-file > server/b &&
+	git -C server add a .git-a b &&
+	git -C server commit -m x &&
+
+	git -C server rev-parse HEAD >objects &&
+	git -C server pack-objects --revs --stdout --blob-max-bytes=10 <objects >my.pack &&
+
+	# Ensure that the .git-a blob is in the packfile, despite also
+	# appearing as a non-.git file
+	git index-pack my.pack &&
+	git verify-pack -v my.idx >objectlist &&
+	grep $(git hash-object server/a) objectlist
+'
+
 #
 # WARNING!
 #
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 1701fe2a0..07b79c7ad 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1020,3 +1020,15 @@ nongit () {
 		"$@"
 	)
 }
+
+# Converts big-endian pairs of hexadecimal digits into bytes. For example,
+# "printf 61620d0a | hex_pack" results in "ab\r\n".
+hex_pack () {
+	perl -e '$/ = undef; $input = <>; print pack("H*", $input)'
+}
+
+# Converts bytes into big-endian pairs of hexadecimal digits. For example,
+# "printf 'ab\r\n' | hex_unpack" results in "61620d0a".
+hex_unpack () {
+	perl -e '$/ = undef; $input = <>; print unpack("H2" x length($input), $input)'
+}
-- 
2.14.2.822.g60be5d43e6-goog

