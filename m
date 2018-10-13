Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 054441F97E
	for <e@80x24.org>; Sat, 13 Oct 2018 00:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbeJMIdu (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 04:33:50 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:55408 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbeJMIdu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 04:33:50 -0400
Received: by mail-pf1-f201.google.com with SMTP id 14-v6so13471109pfk.22
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 17:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mmwZjDMPDOyOr06mrGOlugZsWKMVJwTQQ1Sted8pKE0=;
        b=TF9XlxOGijIlavAc2/chiY8emppPD+sJdquIeF0jBUvGtjR1XuoGt7rkHUqKJHwq0I
         Em3+Z56JvQjIjqMx8+P93iYAm2isbq3IgcFZ3jf4OTF8MPxEt5D4UiTQQJj/dz7XEdk9
         dSbxcNWUwnlwZoIJ3yVFYO7vlNxZ94fQWoITnjSwVS2dnYgTtLqX8d/K+IeV1rTbAJ1p
         a7VQaqVI2gZgf5/ZeKVg7AgF/JLr/quXWNdMEkLdyEKuUpacWKy//0Zw4FwdFPUT8Vdm
         3PIRxf9YaF91bK2SDDmxmOFCRm4qf7dROL6FHqjLDAzpy/cY7l2PNjRVAIYVgCOu4mpI
         IgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mmwZjDMPDOyOr06mrGOlugZsWKMVJwTQQ1Sted8pKE0=;
        b=Wu9sB16m3PGHk3+/7SU2Qt8UvCVGvgXJNRzs41r1bVj69cjKHMf9uAj+n5CC6kaYly
         G0jsy8WQrQZh+4I+E8UHT36/e056ATAcWXden2LrYiF1hkAM1iG/ePE3p9sx02hw/b/T
         cnUSoNqoF3wyp3kJ7FWCiyt+HSdwmbrcLe8q+gFX5+SfJkrBITKlNP4XUcHVjLRAU1qF
         IkKsya3Bof46KGdfCjXNtvr3MY98+06r9JAWxSaC8AtRfI55JRgigZxq5vh6buZHdeMc
         X6anpYj+hq7Of/jwFAbFG1Kabzbd1X1OQs+m8KIdFaSDqDhcKN2i83zfEHcuUKLHOBZu
         j9ig==
X-Gm-Message-State: ABuFfoibpujPpmwgPmvbE/QzFfvWlqO0ahkrZqs5mMyTHCQUBlvHgfFe
        j4DU8PzcByysuJvL8E8qHmWIyRHyvfPoqhrtRusPMHY6BJeLddhdtx3iFdPtKsaFRxdbLyliigx
        xXDupcoKF18GyBufSeZB5eNqaisSQF0uGYeo3anuTzshB49NtMfG00aswpmpUVns=
X-Google-Smtp-Source: ACcGV63hbgmRQZOqsAMy8yPas29pyuS03uwBckjus57WikFNUXeCF177tcnGKkqPGwt2mAtJHHSnRguqx3qWIw==
X-Received: by 2002:a62:4b18:: with SMTP id y24-v6mr4352348pfa.64.1539392327436;
 Fri, 12 Oct 2018 17:58:47 -0700 (PDT)
Date:   Fri, 12 Oct 2018 17:58:41 -0700
In-Reply-To: <cover.1539391439.git.steadmon@google.com>
Message-Id: <c7b5a03d810bee0289cccedd5f433fca2867904c.1539391439.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1538693039.git.steadmon@google.com> <cover.1539391439.git.steadmon@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v2 2/2] fuzz: Add fuzz testing for packfile indices.
From:   steadmon@google.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Josh Steadmon <steadmon@google.com>

Breaks the majority of check_packed_git_idx() into a separate function,
load_idx(). The latter function operates on arbitrary buffers, which
makes it suitable as a fuzzing test target.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 .gitignore      |  1 +
 Makefile        |  1 +
 fuzz-pack-idx.c | 13 +++++++++++++
 packfile.c      | 44 +++++++++++++++++++++++++-------------------
 packfile.h      | 13 +++++++++++++
 5 files changed, 53 insertions(+), 19 deletions(-)
 create mode 100644 fuzz-pack-idx.c

diff --git a/.gitignore b/.gitignore
index 87a28b3115..64b3377d40 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,5 +1,6 @@
 /fuzz_corpora
 /fuzz-pack-headers
+/fuzz-pack-idx
 /GIT-BUILD-OPTIONS
 /GIT-CFLAGS
 /GIT-LDFLAGS
diff --git a/Makefile b/Makefile
index 7f5a19b8ab..1b3d893090 100644
--- a/Makefile
+++ b/Makefile
@@ -685,6 +685,7 @@ SCRIPTS = $(SCRIPT_SH_INS) \
 ETAGS_TARGET = TAGS
 
 FUZZ_OBJS += fuzz-pack-headers.o
+FUZZ_OBJS += fuzz-pack-idx.o
 
 # Always build fuzz objects even if not testing, to prevent bit-rot.
 all:: $(FUZZ_OBJS)
diff --git a/fuzz-pack-idx.c b/fuzz-pack-idx.c
new file mode 100644
index 0000000000..0c3d777aac
--- /dev/null
+++ b/fuzz-pack-idx.c
@@ -0,0 +1,13 @@
+#include "object-store.h"
+#include "packfile.h"
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
+{
+	struct packed_git p;
+
+	load_idx("fuzz-input", GIT_SHA1_RAWSZ, (void *)data, size, &p);
+
+	return 0;
+}
diff --git a/packfile.c b/packfile.c
index 841b36182f..86074a76e9 100644
--- a/packfile.c
+++ b/packfile.c
@@ -80,10 +80,8 @@ void pack_report(void)
 static int check_packed_git_idx(const char *path, struct packed_git *p)
 {
 	void *idx_map;
-	struct pack_idx_header *hdr;
 	size_t idx_size;
-	uint32_t version, nr, i, *index;
-	int fd = git_open(path);
+	int fd = git_open(path), ret;
 	struct stat st;
 	const unsigned int hashsz = the_hash_algo->rawsz;
 
@@ -101,16 +99,32 @@ static int check_packed_git_idx(const char *path, struct packed_git *p)
 	idx_map = xmmap(NULL, idx_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
 
-	hdr = idx_map;
+	ret = load_idx(path, hashsz, idx_map, idx_size, p);
+
+	if (ret)
+		munmap(idx_map, idx_size);
+
+	return ret;
+}
+
+int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
+	     size_t idx_size, struct packed_git *p)
+{
+	struct pack_idx_header *hdr = idx_map;
+	uint32_t version, nr, i, *index;
+
+	if (idx_size < 4 * 256 + hashsz + hashsz)
+		return error("index file %s is too small", path);
+	if (idx_map == NULL)
+		return error("empty data");
+
 	if (hdr->idx_signature == htonl(PACK_IDX_SIGNATURE)) {
 		version = ntohl(hdr->idx_version);
-		if (version < 2 || version > 2) {
-			munmap(idx_map, idx_size);
+		if (version < 2 || version > 2)
 			return error("index file %s is version %"PRIu32
 				     " and is not supported by this binary"
 				     " (try upgrading GIT to a newer version)",
 				     path, version);
-		}
 	} else
 		version = 1;
 
@@ -120,10 +134,8 @@ static int check_packed_git_idx(const char *path, struct packed_git *p)
 		index += 2;  /* skip index header */
 	for (i = 0; i < 256; i++) {
 		uint32_t n = ntohl(index[i]);
-		if (n < nr) {
-			munmap(idx_map, idx_size);
+		if (n < nr)
 			return error("non-monotonic index %s", path);
-		}
 		nr = n;
 	}
 
@@ -135,10 +147,8 @@ static int check_packed_git_idx(const char *path, struct packed_git *p)
 		 *  - hash of the packfile
 		 *  - file checksum
 		 */
-		if (idx_size != 4*256 + nr * (hashsz + 4) + hashsz + hashsz) {
-			munmap(idx_map, idx_size);
+		if (idx_size != 4 * 256 + nr * (hashsz + 4) + hashsz + hashsz)
 			return error("wrong index v1 file size in %s", path);
-		}
 	} else if (version == 2) {
 		/*
 		 * Minimum size:
@@ -157,20 +167,16 @@ static int check_packed_git_idx(const char *path, struct packed_git *p)
 		unsigned long max_size = min_size;
 		if (nr)
 			max_size += (nr - 1)*8;
-		if (idx_size < min_size || idx_size > max_size) {
-			munmap(idx_map, idx_size);
+		if (idx_size < min_size || idx_size > max_size)
 			return error("wrong index v2 file size in %s", path);
-		}
 		if (idx_size != min_size &&
 		    /*
 		     * make sure we can deal with large pack offsets.
 		     * 31-bit signed offset won't be enough, neither
 		     * 32-bit unsigned one will be.
 		     */
-		    (sizeof(off_t) <= 4)) {
-			munmap(idx_map, idx_size);
+		    (sizeof(off_t) <= 4))
 			return error("pack too large for current definition of off_t in %s", path);
-		}
 	}
 
 	p->index_version = version;
diff --git a/packfile.h b/packfile.h
index 442625723d..6c4037605d 100644
--- a/packfile.h
+++ b/packfile.h
@@ -164,4 +164,17 @@ extern int has_pack_index(const unsigned char *sha1);
  */
 extern int is_promisor_object(const struct object_id *oid);
 
+/*
+ * Expose a function for fuzz testing.
+ *
+ * load_idx() parses a block of memory as a packfile index and puts the results
+ * into a struct packed_git.
+ *
+ * This function should not be used directly. It is exposed here only so that we
+ * have a convenient entry-point for fuzz testing. For real uses, you should
+ * probably use open_pack_index() or parse_pack_index() instead.
+ */
+extern int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
+		    size_t idx_size, struct packed_git *p);
+
 #endif
-- 
2.19.0.605.g01d371f741-goog

