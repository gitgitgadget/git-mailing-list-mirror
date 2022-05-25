Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730A2C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 23:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242382AbiEYXCJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 19:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238277AbiEYXCI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 19:02:08 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C485B55367
        for <git@vger.kernel.org>; Wed, 25 May 2022 16:02:05 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id em1so509421qvb.7
        for <git@vger.kernel.org>; Wed, 25 May 2022 16:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B0+eCmltMMRwyrAbkXieHS61vMbtlHFXefFffX6D8yI=;
        b=KqRu3i+0qSPeGsP1oiP/RX4TOQYyX1nIIXrE0BdlBtrywDl8HbVU1NQTu9ySYkhQEZ
         c6ldThUMSzVAGubztA1WhOoGFZy1tEYvIqEQkNZclNZgwkD920VBzwlj2cDTjcOtHPDC
         jBGBw9O2A8lihGmDtVaE5RiLIfWcmXvSrcS4rTRRIDC7Bjz8AMY97lN6ZvYhi5luYq3T
         ZM09WwlE7eeRDEPrEotnVNj/uK9C7CwkMIrNxVg2bUgu9A01CwQURLJUiQjBn+QdaEv8
         wAquWznkzY8ppklOS7htZLV5t+DZQuF9ItOdKFlCiXkkCtc+HHpYoPYf4w+Jo9/07Wt+
         hNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B0+eCmltMMRwyrAbkXieHS61vMbtlHFXefFffX6D8yI=;
        b=UWx0607LoMuZS/6CfnT7h3PC8wPXjEEjKqHNrCjaK3sb057KS0OTpx9gOHp0vSNiMj
         HoQuGCXdRB02DvwLduikAdDgLi9nbl5wiYzbwBfs9yuCwdyTwnrtkVitdCTq2EIkU1Tc
         +fy48P35V/bsR/buQ+jwZCQ6SWNGxQf1vYCOJWvgGcL0zhsLMNZ9UQB6SS/DXaY8rTG3
         7MHiesDUqhVVdBAJ/Cux4JpMB36AqfLnpQYiv29+6mIQ42PNsocwh+7oaiBH+RlEMhzc
         5xGqhvSutyqCfHEJoFOCvs6+LeN+N1mpvBs2Db4JMfdXVWWV7oPp/xZUigNglgj7rwRc
         uksg==
X-Gm-Message-State: AOAM530vD6yydl/fvtEebXnJYJHWG2qZQdXKcMtK2ZBDaH7rI9p/Q9RQ
        s0xoOgbBHVJiFp1sC3TuInoMkA==
X-Google-Smtp-Source: ABdhPJz/aeLcoojDPiWND17g5765WpamPvfhPofUMTsxU8EY0cU0TwmO/RoNRpLYAT/bxVCglpuXWg==
X-Received: by 2002:ad4:5aed:0:b0:461:caa6:81f8 with SMTP id c13-20020ad45aed000000b00461caa681f8mr27636835qvh.49.1653519724877;
        Wed, 25 May 2022 16:02:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l21-20020a37a215000000b006a377a015d4sm167563qke.39.2022.05.25.16.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 16:02:04 -0700 (PDT)
Date:   Wed, 25 May 2022 19:02:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, derrickstolee@github.com,
        gitster@pobox.com, jrnieder@gmail.com, larsxschneider@gmail.com,
        tytso@mit.edu
Subject: Re: [PATCH v5 02/17] pack-mtimes: support reading .mtimes files
Message-ID: <Yo61aqaQ/tXh+moi@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
 <91a9d21b0b7d99023083c0bbb6f91ccdc1782736.1653088640.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <91a9d21b0b7d99023083c0bbb6f91ccdc1782736.1653088640.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,

On Fri, May 20, 2022 at 07:17:35PM -0400, Taylor Blau wrote:
> To store the individual mtimes of objects in a cruft pack, introduce a
> new `.mtimes` format that can optionally accompany a single pack in the
> repository.

Like I mentioned in this sub-thread, here is a small fixup! to apply on
top of this patch when queueing. I'm hoping this will be easier than
reapplying the dozen+ or so patches in this series (the rest of which
are unchanged). But if it isn't, please let me know and I can send you a
reroll of the whole thing.

In the meantime, here's the fixup...

--- 8< ---
Subject: [PATCH] fixup! pack-mtimes: support reading .mtimes files

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 object-store.h |  5 +++++
 pack-mtimes.c  | 35 +++++++++++++++++++----------------
 pack-mtimes.h  | 11 +++++++++++
 3 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/object-store.h b/object-store.h
index 2c4671ed7a..05cc9a33ed 100644
--- a/object-store.h
+++ b/object-store.h
@@ -122,6 +122,11 @@ struct packed_git {
 	const uint32_t *revindex_data;
 	const uint32_t *revindex_map;
 	size_t revindex_size;
+	/*
+	 * mtimes_map points at the beginning of the memory mapped region of
+	 * this pack's corresponding .mtimes file, and mtimes_size is the size
+	 * of that .mtimes file
+	 */
 	const uint32_t *mtimes_map;
 	size_t mtimes_size;
 	/* something like ".git/objects/pack/xxxxx.pack" */
diff --git a/pack-mtimes.c b/pack-mtimes.c
index 46ad584af1..0e0aafdcb0 100644
--- a/pack-mtimes.c
+++ b/pack-mtimes.c
@@ -1,3 +1,4 @@
+#include "git-compat-util.h"
 #include "pack-mtimes.h"
 #include "object-store.h"
 #include "packfile.h"
@@ -7,12 +8,10 @@ static char *pack_mtimes_filename(struct packed_git *p)
 	size_t len;
 	if (!strip_suffix(p->pack_name, ".pack", &len))
 		BUG("pack_name does not end in .pack");
-	/* NEEDSWORK: this could reuse code from pack-revindex.c. */
 	return xstrfmt("%.*s.mtimes", (int)len, p->pack_name);
 }

 #define MTIMES_HEADER_SIZE (12)
-#define MTIMES_MIN_SIZE (MTIMES_HEADER_SIZE + (2 * the_hash_algo->rawsz))

 struct mtimes_header {
 	uint32_t signature;
@@ -26,10 +25,9 @@ static int load_pack_mtimes_file(char *mtimes_file,
 {
 	int fd, ret = 0;
 	struct stat st;
-	void *data = NULL;
-	size_t mtimes_size;
+	uint32_t *data = NULL;
+	size_t mtimes_size, expected_size;
 	struct mtimes_header header;
-	uint32_t *hdr;

 	fd = git_open(mtimes_file);

@@ -44,21 +42,16 @@ static int load_pack_mtimes_file(char *mtimes_file,

 	mtimes_size = xsize_t(st.st_size);

-	if (mtimes_size < MTIMES_MIN_SIZE) {
+	if (mtimes_size < MTIMES_HEADER_SIZE) {
 		ret = error(_("mtimes file %s is too small"), mtimes_file);
 		goto cleanup;
 	}

-	if (mtimes_size - MTIMES_MIN_SIZE != st_mult(sizeof(uint32_t), num_objects)) {
-		ret = error(_("mtimes file %s is corrupt"), mtimes_file);
-		goto cleanup;
-	}
+	data = xmmap(NULL, mtimes_size, PROT_READ, MAP_PRIVATE, fd, 0);

-	data = hdr = xmmap(NULL, mtimes_size, PROT_READ, MAP_PRIVATE, fd, 0);
-
-	header.signature = ntohl(hdr[0]);
-	header.version = ntohl(hdr[1]);
-	header.hash_id = ntohl(hdr[2]);
+	header.signature = ntohl(data[0]);
+	header.version = ntohl(data[1]);
+	header.hash_id = ntohl(data[2]);

 	if (header.signature != MTIMES_SIGNATURE) {
 		ret = error(_("mtimes file %s has unknown signature"), mtimes_file);
@@ -77,13 +70,23 @@ static int load_pack_mtimes_file(char *mtimes_file,
 		goto cleanup;
 	}

+
+	expected_size = MTIMES_HEADER_SIZE;
+	expected_size = st_add(expected_size, st_mult(sizeof(uint32_t), num_objects));
+	expected_size = st_add(expected_size, 2 * (header.hash_id == 1 ? GIT_SHA1_RAWSZ : GIT_SHA256_RAWSZ));
+
+	if (mtimes_size != expected_size) {
+		ret = error(_("mtimes file %s is corrupt"), mtimes_file);
+		goto cleanup;
+	}
+
 cleanup:
 	if (ret) {
 		if (data)
 			munmap(data, mtimes_size);
 	} else {
 		*len_p = mtimes_size;
-		*data_p = (const uint32_t *)data;
+		*data_p = data;
 	}

 	close(fd);
diff --git a/pack-mtimes.h b/pack-mtimes.h
index 38ddb9f893..cc957b3e85 100644
--- a/pack-mtimes.h
+++ b/pack-mtimes.h
@@ -8,8 +8,19 @@

 struct packed_git;

+/*
+ * Loads the .mtimes file corresponding to "p", if any, returning zero
+ * on success.
+ */
 int load_pack_mtimes(struct packed_git *p);

+/* Returns the mtime associated with the object at position "pos" (in
+ * lexicographic/index order) in pack "p".
+ *
+ * Note that it is a BUG() to call this function if either (a) "p" does
+ * not have a corresponding .mtimes file, or (b) it does, but it hasn't
+ * been loaded
+ */
 uint32_t nth_packed_mtime(struct packed_git *p, uint32_t pos);

 #endif
--
2.36.1.94.gb0d54bedca

--- >8 ---
