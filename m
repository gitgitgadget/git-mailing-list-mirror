Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74765C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 14:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF812073B
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 14:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgC3ODs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:03:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:55620 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727191AbgC3ODs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 10:03:48 -0400
Received: (qmail 15164 invoked by uid 109); 30 Mar 2020 14:03:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 30 Mar 2020 14:03:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18730 invoked by uid 111); 30 Mar 2020 14:13:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Mar 2020 10:13:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 30 Mar 2020 10:03:46 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/7] oid_array: rename source file from sha1-array
Message-ID: <20200330140346.GC2456038@coredump.intra.peff.net>
References: <20200330140247.GA476088@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200330140247.GA476088@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We renamed the actual data structure in 910650d2f8 (Rename sha1_array to
oid_array, 2017-03-31), but the file is still called sha1-array. Besides
being slightly confusing, it makes it more annoying to grep for leftover
occurrences of "sha1" in various files, because the header is included
in so many places.

Let's complete the transition by renaming the source and header files
(and fixing up a few comment references).

I kept the "-" in the name, as that seems to be our style; cf.
fc1395f4a4 (sha1_file.c: rename to use dash in file name, 2018-04-10).
We also have oidmap.h and oidset.h without any punctuation, but those
are "struct oidmap" and "struct oidset" in the code. We _could_ make
this "oidarray" to match, but somehow it looks uglier to me because of
the length of "array" (plus it would be a very invasive patch for little
gain).

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile                    | 2 +-
 bisect.c                    | 2 +-
 builtin/cat-file.c          | 2 +-
 builtin/diff.c              | 2 +-
 builtin/fetch-pack.c        | 2 +-
 builtin/pack-objects.c      | 2 +-
 builtin/pull.c              | 2 +-
 builtin/receive-pack.c      | 2 +-
 builtin/send-pack.c         | 2 +-
 builtin/tag.c               | 2 +-
 cache.h                     | 2 +-
 combine-diff.c              | 2 +-
 connect.c                   | 2 +-
 delta-islands.c             | 2 +-
 fetch-pack.c                | 2 +-
 object-store.h              | 2 +-
 sha1-array.c => oid-array.c | 4 ++--
 sha1-array.h => oid-array.h | 2 +-
 parse-options-cb.c          | 2 +-
 ref-filter.h                | 2 +-
 remote-curl.c               | 2 +-
 send-pack.c                 | 2 +-
 sha1-name.c                 | 2 +-
 shallow.c                   | 2 +-
 submodule.c                 | 2 +-
 t/helper/test-sha1-array.c  | 2 +-
 transport.c                 | 2 +-
 27 files changed, 28 insertions(+), 28 deletions(-)
 rename sha1-array.c => oid-array.c (96%)
 rename sha1-array.h => oid-array.h (98%)

diff --git a/Makefile b/Makefile
index ef1ff2228f..abfe5cc29b 100644
--- a/Makefile
+++ b/Makefile
@@ -929,6 +929,7 @@ LIB_OBJS += notes-utils.o
 LIB_OBJS += object.o
 LIB_OBJS += oidmap.o
 LIB_OBJS += oidset.o
+LIB_OBJS += oid-array.o
 LIB_OBJS += packfile.o
 LIB_OBJS += pack-bitmap.o
 LIB_OBJS += pack-bitmap-write.o
@@ -978,7 +979,6 @@ LIB_OBJS += sequencer.o
 LIB_OBJS += serve.o
 LIB_OBJS += server-info.o
 LIB_OBJS += setup.o
-LIB_OBJS += sha1-array.o
 LIB_OBJS += sha1-lookup.o
 LIB_OBJS += sha1-file.o
 LIB_OBJS += sha1-name.o
diff --git a/bisect.c b/bisect.c
index 9154f810f7..64b579b6ea 100644
--- a/bisect.c
+++ b/bisect.c
@@ -10,7 +10,7 @@
 #include "run-command.h"
 #include "log-tree.h"
 #include "bisect.h"
-#include "sha1-array.h"
+#include "oid-array.h"
 #include "argv-array.h"
 #include "commit-slab.h"
 #include "commit-reach.h"
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 6ecc8ee6dc..0d03fdac6e 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -12,7 +12,7 @@
 #include "userdiff.h"
 #include "streaming.h"
 #include "tree-walk.h"
-#include "sha1-array.h"
+#include "oid-array.h"
 #include "packfile.h"
 #include "object-store.h"
 #include "promisor-remote.h"
diff --git a/builtin/diff.c b/builtin/diff.c
index 42ac803091..8537b17bd5 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -17,7 +17,7 @@
 #include "log-tree.h"
 #include "builtin.h"
 #include "submodule.h"
-#include "sha1-array.h"
+#include "oid-array.h"
 
 #define DIFF_NO_INDEX_EXPLICIT 1
 #define DIFF_NO_INDEX_IMPLICIT 2
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index dc1485c8aa..4771100072 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -3,7 +3,7 @@
 #include "fetch-pack.h"
 #include "remote.h"
 #include "connect.h"
-#include "sha1-array.h"
+#include "oid-array.h"
 #include "protocol.h"
 
 static const char fetch_pack_usage[] =
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index dc7c58ce3f..fdd18c7ccb 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -26,7 +26,7 @@
 #include "pack-bitmap.h"
 #include "delta-islands.h"
 #include "reachable.h"
-#include "sha1-array.h"
+#include "oid-array.h"
 #include "argv-array.h"
 #include "list.h"
 #include "packfile.h"
diff --git a/builtin/pull.c b/builtin/pull.c
index e42665b681..9429786604 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -12,7 +12,7 @@
 #include "parse-options.h"
 #include "exec-cmd.h"
 #include "run-command.h"
-#include "sha1-array.h"
+#include "oid-array.h"
 #include "remote.h"
 #include "dir.h"
 #include "rebase.h"
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 2cc18bbffd..d46147f709 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -13,7 +13,7 @@
 #include "remote.h"
 #include "connect.h"
 #include "string-list.h"
-#include "sha1-array.h"
+#include "oid-array.h"
 #include "connected.h"
 #include "argv-array.h"
 #include "version.h"
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 098ebf22d0..f2c5a34402 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -11,7 +11,7 @@
 #include "quote.h"
 #include "transport.h"
 #include "version.h"
-#include "sha1-array.h"
+#include "oid-array.h"
 #include "gpg-interface.h"
 #include "gettext.h"
 #include "protocol.h"
diff --git a/builtin/tag.c b/builtin/tag.c
index cc30d346f5..dd160b49c7 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -17,7 +17,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "gpg-interface.h"
-#include "sha1-array.h"
+#include "oid-array.h"
 #include "column.h"
 #include "ref-filter.h"
 
diff --git a/cache.h b/cache.h
index c77b95870a..0f0485ecfe 100644
--- a/cache.h
+++ b/cache.h
@@ -14,7 +14,7 @@
 #include "pack-revindex.h"
 #include "hash.h"
 #include "path.h"
-#include "sha1-array.h"
+#include "oid-array.h"
 #include "repository.h"
 #include "mem-pool.h"
 
diff --git a/combine-diff.c b/combine-diff.c
index d5c4d839dc..002e0e5438 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -10,7 +10,7 @@
 #include "log-tree.h"
 #include "refs.h"
 #include "userdiff.h"
-#include "sha1-array.h"
+#include "oid-array.h"
 #include "revision.h"
 
 static int compare_paths(const struct combine_diff_path *one,
diff --git a/connect.c b/connect.c
index b6451ab5e8..23013c6344 100644
--- a/connect.c
+++ b/connect.c
@@ -9,7 +9,7 @@
 #include "connect.h"
 #include "url.h"
 #include "string-list.h"
-#include "sha1-array.h"
+#include "oid-array.h"
 #include "transport.h"
 #include "strbuf.h"
 #include "version.h"
diff --git a/delta-islands.c b/delta-islands.c
index 09dbd3cf72..aa98b2e541 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -17,7 +17,7 @@
 #include "pack-bitmap.h"
 #include "pack-objects.h"
 #include "delta-islands.h"
-#include "sha1-array.h"
+#include "oid-array.h"
 #include "config.h"
 
 KHASH_INIT(str, const char *, void *, 1, kh_str_hash_func, kh_str_hash_equal)
diff --git a/fetch-pack.c b/fetch-pack.c
index 1734a573b0..0b07b3ee73 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -15,7 +15,7 @@
 #include "connect.h"
 #include "transport.h"
 #include "version.h"
-#include "sha1-array.h"
+#include "oid-array.h"
 #include "oidset.h"
 #include "packfile.h"
 #include "object-store.h"
diff --git a/object-store.h b/object-store.h
index be72fee7d5..d1e490f203 100644
--- a/object-store.h
+++ b/object-store.h
@@ -4,7 +4,7 @@
 #include "cache.h"
 #include "oidmap.h"
 #include "list.h"
-#include "sha1-array.h"
+#include "oid-array.h"
 #include "strbuf.h"
 #include "thread-utils.h"
 
diff --git a/sha1-array.c b/oid-array.c
similarity index 96%
rename from sha1-array.c
rename to oid-array.c
index bada0c4353..8657a5cedf 100644
--- a/sha1-array.c
+++ b/oid-array.c
@@ -1,5 +1,5 @@
 #include "cache.h"
-#include "sha1-array.h"
+#include "oid-array.h"
 #include "sha1-lookup.h"
 
 void oid_array_append(struct oid_array *array, const struct object_id *oid)
@@ -48,7 +48,7 @@ int oid_array_for_each(struct oid_array *array,
 {
 	size_t i;
 
-	/* No oid_array_sort() here! See sha1-array.h */
+	/* No oid_array_sort() here! See oid-array.h */
 
 	for (i = 0; i < array->nr; i++) {
 		int ret = fn(array->oid + i, data);
diff --git a/sha1-array.h b/oid-array.h
similarity index 98%
rename from sha1-array.h
rename to oid-array.h
index c5e4b9324f..f28d322c90 100644
--- a/sha1-array.h
+++ b/oid-array.h
@@ -19,7 +19,7 @@
  *
  * void some_func(void)
  * {
- *     struct sha1_array hashes = OID_ARRAY_INIT;
+ *     struct oid_array hashes = OID_ARRAY_INIT;
  *     struct object_id oid;
  *
  *     // Read objects into our set
diff --git a/parse-options-cb.c b/parse-options-cb.c
index a28b55be48..86cd393013 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -5,7 +5,7 @@
 #include "color.h"
 #include "string-list.h"
 #include "argv-array.h"
-#include "sha1-array.h"
+#include "oid-array.h"
 
 /*----- some often used options -----*/
 
diff --git a/ref-filter.h b/ref-filter.h
index f1dcff4c6e..64330e9601 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -1,7 +1,7 @@
 #ifndef REF_FILTER_H
 #define REF_FILTER_H
 
-#include "sha1-array.h"
+#include "oid-array.h"
 #include "refs.h"
 #include "commit.h"
 #include "parse-options.h"
diff --git a/remote-curl.c b/remote-curl.c
index e4cd321844..1c9aa3d0ab 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -12,7 +12,7 @@
 #include "sideband.h"
 #include "argv-array.h"
 #include "credential.h"
-#include "sha1-array.h"
+#include "oid-array.h"
 #include "send-pack.h"
 #include "protocol.h"
 #include "quote.h"
diff --git a/send-pack.c b/send-pack.c
index 0407841ae8..da4741ce4a 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -12,7 +12,7 @@
 #include "quote.h"
 #include "transport.h"
 #include "version.h"
-#include "sha1-array.h"
+#include "oid-array.h"
 #include "gpg-interface.h"
 #include "cache.h"
 
diff --git a/sha1-name.c b/sha1-name.c
index 5bb006e5a9..6561cd9097 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -8,7 +8,7 @@
 #include "refs.h"
 #include "remote.h"
 #include "dir.h"
-#include "sha1-array.h"
+#include "oid-array.h"
 #include "packfile.h"
 #include "object-store.h"
 #include "repository.h"
diff --git a/shallow.c b/shallow.c
index 7fd04afed1..14f7fa6e27 100644
--- a/shallow.c
+++ b/shallow.c
@@ -8,7 +8,7 @@
 #include "pkt-line.h"
 #include "remote.h"
 #include "refs.h"
-#include "sha1-array.h"
+#include "oid-array.h"
 #include "diff.h"
 #include "revision.h"
 #include "commit-slab.h"
diff --git a/submodule.c b/submodule.c
index c3aadf3fff..e2ef5698c8 100644
--- a/submodule.c
+++ b/submodule.c
@@ -12,7 +12,7 @@
 #include "diffcore.h"
 #include "refs.h"
 #include "string-list.h"
-#include "sha1-array.h"
+#include "oid-array.h"
 #include "argv-array.h"
 #include "blob.h"
 #include "thread-utils.h"
diff --git a/t/helper/test-sha1-array.c b/t/helper/test-sha1-array.c
index ad5e69f9d3..6f7d3b939e 100644
--- a/t/helper/test-sha1-array.c
+++ b/t/helper/test-sha1-array.c
@@ -1,6 +1,6 @@
 #include "test-tool.h"
 #include "cache.h"
-#include "sha1-array.h"
+#include "oid-array.h"
 
 static int print_oid(const struct object_id *oid, void *data)
 {
diff --git a/transport.c b/transport.c
index 1fdc7dac1a..471c5bd339 100644
--- a/transport.c
+++ b/transport.c
@@ -16,7 +16,7 @@
 #include "url.h"
 #include "submodule.h"
 #include "string-list.h"
-#include "sha1-array.h"
+#include "oid-array.h"
 #include "sigchain.h"
 #include "transport-internal.h"
 #include "protocol.h"
-- 
2.26.0.597.g7e08ed78ff

