Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD39C47082
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B4E46128B
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbhE0A77 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbhE0A77 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:59:59 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D4FC061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:58:26 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j14so2928809wrq.5
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ibtXHqpyQ7EgPX+bKl81bhsofy+ssrnG8ElTIMneN6A=;
        b=eXoZpXRfUHunvPmjxniUYHjqufAznICwxVh9iwYWDtqen/6OjoNYOzKIGM1DRoFOCU
         +ILaGAmZOrjDt7a9lAFPrIWLhEFDfz+FGb7sim+p7oAeOhSKtbJ3CxSWJvdaHC4Q4nwd
         HrWC6+gTmfJoMdp+3Qn5ege1+4DMgFtpLaAxewAG8Uu5H8YmyP+prFiqidKa2ju+6pTE
         aF9inRz14lpi3/aD/vfbYYwT3ETvtYQfMMiCBiP5Zpyc6Du5w4U+TH7Z8nkrRJbnPcEE
         p792NzI9+iZRH6InbqdNix6OVabzTqQ3H4rbSnZ9uhRkoVu5j3ludPWJ5ekyp0k5o/gv
         tQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ibtXHqpyQ7EgPX+bKl81bhsofy+ssrnG8ElTIMneN6A=;
        b=Oqan3dyPSarGCNpgrPZc18oxkRcp9/Yr5Ji1ZeC9l7590oS7lIUX2XP9mp7LegIYOJ
         TulWfRo7Hr5B/EmQ59JT/QKnhOf5N/Qtc5YOCqKk5QMoKrk7aUtLVnBZ1FyjyKFCIYDf
         yx/rpRj0P+1JPj3U35uVvRWyt8+VnrLTRTbnfsVGjiqPN4SIJ/K2avbI18vqgDFfhM48
         RWuqxJE3hb5FQguz6sr7JDPnQhiqcvDhXECHiW/9l5rCzbpcfwUsH6/VYAFhKFYQUtE+
         UF6+yKSC3IlvOpDXOoVF5Tj29X9vhxn3dQOZlAgWe8DQZuf/ia5YuFmaEyOTuUkTH5i3
         Ov5w==
X-Gm-Message-State: AOAM532clyBpFCI3ASacLJPTqieog16kJfr3++y4ryR9J25KzSVLqN23
        4yISfw0S833waBGJctzHVSmdqG0mqXDlOg==
X-Google-Smtp-Source: ABdhPJx/p9YwhKTNkcqstcvE5rYW41OkmyxxyR2DWjVBdl91me9q32qteliWs3QYdD1JP2DsnOZynw==
X-Received: by 2002:a5d:4b10:: with SMTP id v16mr555203wrq.259.1622077104665;
        Wed, 26 May 2021 17:58:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c12sm707731wrc.94.2021.05.26.17.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 17:58:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] pack-objects: move builtin-only code to its own header
Date:   Thu, 27 May 2021 02:52:51 +0200
Message-Id: <patch-1.1-d085d59a417-20210527T005213Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.413.g73297d74493
In-Reply-To: <878s41m5nc.fsf@evledraar.gmail.com>
References: <878s41m5nc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the code that's only used in builtin/pack-objects.c to a new
builtin/pack-objects.h header and out of pack-objects.h.

This fixes an issue where Solaris's SunCC hasn't been able to compile
git since 483fa7f42d9 (t/helper/test-bitmap.c: initial commit,
2021-03-31).

The real origin of that issue is that in 898eba5e630 (pack-objects:
refer to delta objects by index instead of pointer, 2018-04-14)
utility functions only needed by builtin/pack-objects.c were added to
pack-objects.h. Since then the header has been used in a few other
places, but 483fa7f42d9 was the first time it was used by test helper.

Since Solaris is stricter about linking and the oe_get_size_slow()
function lives in builtin/pack-objects.c the build started failing
with:

    Undefined                       first referenced
     symbol                             in file
    oe_get_size_slow                    t/helper/test-bitmap.o
    ld: fatal: symbol referencing errors. No output written to t/helper/test-tool

On other platforms this is presumably OK because the compiler and/or
linker detects that the "static inline" functions that reference
oe_get_size_slow() aren't used.

Let's solve this by moving the relevant code to
builtin/pack-objects.c. This is almost entirely a code-only move, but
because of the early macro definitions in that file referencing some
of these inline functions we need to move the definition of "static
struct packing_data to_pack" earlier, and declare these inline
functions above the macros.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/pack-objects.c | 174 +++++++++++++++++++++++++++++++++++++++--
 pack-objects.h         | 159 -------------------------------------
 2 files changed, 167 insertions(+), 166 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6ded130e45b..de00adbb9e0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -37,6 +37,134 @@
 #include "shallow.h"
 #include "promisor-remote.h"
 
+/*
+ * Objects we are going to pack are collected in the `to_pack` structure.
+ * It contains an array (dynamically expanded) of the object data, and a map
+ * that can resolve SHA1s to their position in the array.
+ */
+static struct packing_data to_pack;
+
+static inline struct object_entry *oe_delta(
+		const struct packing_data *pack,
+		const struct object_entry *e)
+{
+	if (!e->delta_idx)
+		return NULL;
+	if (e->ext_base)
+		return &pack->ext_bases[e->delta_idx - 1];
+	else
+		return &pack->objects[e->delta_idx - 1];
+}
+
+static inline unsigned long oe_delta_size(struct packing_data *pack,
+					  const struct object_entry *e)
+{
+	if (e->delta_size_valid)
+		return e->delta_size_;
+
+	/*
+	 * pack->delta_size[] can't be NULL because oe_set_delta_size()
+	 * must have been called when a new delta is saved with
+	 * oe_set_delta().
+	 * If oe_delta() returns NULL (i.e. default state, which means
+	 * delta_size_valid is also false), then the caller must never
+	 * call oe_delta_size().
+	 */
+	return pack->delta_size[e - pack->objects];
+}
+
+unsigned long oe_get_size_slow(struct packing_data *pack,
+			       const struct object_entry *e);
+
+static inline unsigned long oe_size(struct packing_data *pack,
+				    const struct object_entry *e)
+{
+	if (e->size_valid)
+		return e->size_;
+
+	return oe_get_size_slow(pack, e);
+}
+
+static inline void oe_set_delta(struct packing_data *pack,
+				struct object_entry *e,
+				struct object_entry *delta)
+{
+	if (delta)
+		e->delta_idx = (delta - pack->objects) + 1;
+	else
+		e->delta_idx = 0;
+}
+
+static inline struct object_entry *oe_delta_sibling(
+		const struct packing_data *pack,
+		const struct object_entry *e)
+{
+	if (e->delta_sibling_idx)
+		return &pack->objects[e->delta_sibling_idx - 1];
+	return NULL;
+}
+
+static inline struct object_entry *oe_delta_child(
+		const struct packing_data *pack,
+		const struct object_entry *e)
+{
+	if (e->delta_child_idx)
+		return &pack->objects[e->delta_child_idx - 1];
+	return NULL;
+}
+
+static inline void oe_set_delta_child(struct packing_data *pack,
+				      struct object_entry *e,
+				      struct object_entry *delta)
+{
+	if (delta)
+		e->delta_child_idx = (delta - pack->objects) + 1;
+	else
+		e->delta_child_idx = 0;
+}
+
+static inline void oe_set_delta_sibling(struct packing_data *pack,
+					struct object_entry *e,
+					struct object_entry *delta)
+{
+	if (delta)
+		e->delta_sibling_idx = (delta - pack->objects) + 1;
+	else
+		e->delta_sibling_idx = 0;
+}
+
+static inline void oe_set_size(struct packing_data *pack,
+			       struct object_entry *e,
+			       unsigned long size)
+{
+	if (size < pack->oe_size_limit) {
+		e->size_ = size;
+		e->size_valid = 1;
+	} else {
+		e->size_valid = 0;
+		if (oe_get_size_slow(pack, e) != size)
+			BUG("'size' is supposed to be the object size!");
+	}
+}
+
+static inline void oe_set_delta_size(struct packing_data *pack,
+				     struct object_entry *e,
+				     unsigned long size)
+{
+	if (size < pack->oe_delta_size_limit) {
+		e->delta_size_ = size;
+		e->delta_size_valid = 1;
+	} else {
+		packing_data_lock(pack);
+		if (!pack->delta_size)
+			ALLOC_ARRAY(pack->delta_size, pack->nr_alloc);
+		packing_data_unlock(pack);
+
+		pack->delta_size[e - pack->objects] = size;
+		e->delta_size_valid = 0;
+	}
+}
+
 #define IN_PACK(obj) oe_in_pack(&to_pack, obj)
 #define SIZE(obj) oe_size(&to_pack, obj)
 #define SET_SIZE(obj,size) oe_set_size(&to_pack, obj, size)
@@ -56,13 +184,6 @@ static const char *pack_usage[] = {
 	NULL
 };
 
-/*
- * Objects we are going to pack are collected in the `to_pack` structure.
- * It contains an array (dynamically expanded) of the object data, and a map
- * that can resolve SHA1s to their position in the array.
- */
-static struct packing_data to_pack;
-
 static struct pack_idx_entry **written_list;
 static uint32_t nr_result, nr_written, nr_seen;
 static struct bitmap_index *bitmap_git;
@@ -301,6 +422,17 @@ static void copy_pack_data(struct hashfile *f,
 	}
 }
 
+static inline int oe_size_greater_than(struct packing_data *pack,
+				       const struct object_entry *lhs,
+				       unsigned long rhs)
+{
+	if (lhs->size_valid)
+		return lhs->size_ > rhs;
+	if (rhs < pack->oe_size_limit) /* rhs < 2^x <= lhs ? */
+		return 1;
+	return oe_get_size_slow(pack, lhs) > rhs;
+}
+
 /* Return 0 if we will bust the pack-size limit */
 static unsigned long write_no_reuse_object(struct hashfile *f, struct object_entry *entry,
 					   unsigned long limit, int usable_delta)
@@ -642,6 +774,14 @@ static int mark_tagged(const char *path, const struct object_id *oid, int flag,
 	return 0;
 }
 
+static inline unsigned char oe_layer(struct packing_data *pack,
+				     struct object_entry *e)
+{
+	if (!pack->layer)
+		return 0;
+	return pack->layer[e - pack->objects];
+}
+
 static inline void add_to_write_order(struct object_entry **wo,
 			       unsigned int *endp,
 			       struct object_entry *e)
@@ -2231,6 +2371,26 @@ static pthread_mutex_t progress_mutex;
  * progress_mutex for protection.
  */
 
+static inline int oe_size_less_than(struct packing_data *pack,
+				    const struct object_entry *lhs,
+				    unsigned long rhs)
+{
+	if (lhs->size_valid)
+		return lhs->size_ < rhs;
+	if (rhs < pack->oe_size_limit) /* rhs < 2^x <= lhs ? */
+		return 0;
+	return oe_get_size_slow(pack, lhs) < rhs;
+}
+
+static inline void oe_set_tree_depth(struct packing_data *pack,
+				     struct object_entry *e,
+				     unsigned int tree_depth)
+{
+	if (!pack->tree_depth)
+		CALLOC_ARRAY(pack->tree_depth, pack->nr_alloc);
+	pack->tree_depth[e - pack->objects] = tree_depth;
+}
+
 /*
  * Return the size of the object without doing any delta
  * reconstruction (so non-deltas are true object sizes, but deltas
diff --git a/pack-objects.h b/pack-objects.h
index 9d88e3e518f..dca2351ef94 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -268,152 +268,10 @@ static inline void oe_set_in_pack(struct packing_data *pack,
 	pack->in_pack[e - pack->objects] = p;
 }
 
-static inline struct object_entry *oe_delta(
-		const struct packing_data *pack,
-		const struct object_entry *e)
-{
-	if (!e->delta_idx)
-		return NULL;
-	if (e->ext_base)
-		return &pack->ext_bases[e->delta_idx - 1];
-	else
-		return &pack->objects[e->delta_idx - 1];
-}
-
-static inline void oe_set_delta(struct packing_data *pack,
-				struct object_entry *e,
-				struct object_entry *delta)
-{
-	if (delta)
-		e->delta_idx = (delta - pack->objects) + 1;
-	else
-		e->delta_idx = 0;
-}
-
 void oe_set_delta_ext(struct packing_data *pack,
 		      struct object_entry *e,
 		      const struct object_id *oid);
 
-static inline struct object_entry *oe_delta_child(
-		const struct packing_data *pack,
-		const struct object_entry *e)
-{
-	if (e->delta_child_idx)
-		return &pack->objects[e->delta_child_idx - 1];
-	return NULL;
-}
-
-static inline void oe_set_delta_child(struct packing_data *pack,
-				      struct object_entry *e,
-				      struct object_entry *delta)
-{
-	if (delta)
-		e->delta_child_idx = (delta - pack->objects) + 1;
-	else
-		e->delta_child_idx = 0;
-}
-
-static inline struct object_entry *oe_delta_sibling(
-		const struct packing_data *pack,
-		const struct object_entry *e)
-{
-	if (e->delta_sibling_idx)
-		return &pack->objects[e->delta_sibling_idx - 1];
-	return NULL;
-}
-
-static inline void oe_set_delta_sibling(struct packing_data *pack,
-					struct object_entry *e,
-					struct object_entry *delta)
-{
-	if (delta)
-		e->delta_sibling_idx = (delta - pack->objects) + 1;
-	else
-		e->delta_sibling_idx = 0;
-}
-
-unsigned long oe_get_size_slow(struct packing_data *pack,
-			       const struct object_entry *e);
-static inline unsigned long oe_size(struct packing_data *pack,
-				    const struct object_entry *e)
-{
-	if (e->size_valid)
-		return e->size_;
-
-	return oe_get_size_slow(pack, e);
-}
-
-static inline int oe_size_less_than(struct packing_data *pack,
-				    const struct object_entry *lhs,
-				    unsigned long rhs)
-{
-	if (lhs->size_valid)
-		return lhs->size_ < rhs;
-	if (rhs < pack->oe_size_limit) /* rhs < 2^x <= lhs ? */
-		return 0;
-	return oe_get_size_slow(pack, lhs) < rhs;
-}
-
-static inline int oe_size_greater_than(struct packing_data *pack,
-				       const struct object_entry *lhs,
-				       unsigned long rhs)
-{
-	if (lhs->size_valid)
-		return lhs->size_ > rhs;
-	if (rhs < pack->oe_size_limit) /* rhs < 2^x <= lhs ? */
-		return 1;
-	return oe_get_size_slow(pack, lhs) > rhs;
-}
-
-static inline void oe_set_size(struct packing_data *pack,
-			       struct object_entry *e,
-			       unsigned long size)
-{
-	if (size < pack->oe_size_limit) {
-		e->size_ = size;
-		e->size_valid = 1;
-	} else {
-		e->size_valid = 0;
-		if (oe_get_size_slow(pack, e) != size)
-			BUG("'size' is supposed to be the object size!");
-	}
-}
-
-static inline unsigned long oe_delta_size(struct packing_data *pack,
-					  const struct object_entry *e)
-{
-	if (e->delta_size_valid)
-		return e->delta_size_;
-
-	/*
-	 * pack->delta_size[] can't be NULL because oe_set_delta_size()
-	 * must have been called when a new delta is saved with
-	 * oe_set_delta().
-	 * If oe_delta() returns NULL (i.e. default state, which means
-	 * delta_size_valid is also false), then the caller must never
-	 * call oe_delta_size().
-	 */
-	return pack->delta_size[e - pack->objects];
-}
-
-static inline void oe_set_delta_size(struct packing_data *pack,
-				     struct object_entry *e,
-				     unsigned long size)
-{
-	if (size < pack->oe_delta_size_limit) {
-		e->delta_size_ = size;
-		e->delta_size_valid = 1;
-	} else {
-		packing_data_lock(pack);
-		if (!pack->delta_size)
-			ALLOC_ARRAY(pack->delta_size, pack->nr_alloc);
-		packing_data_unlock(pack);
-
-		pack->delta_size[e - pack->objects] = size;
-		e->delta_size_valid = 0;
-	}
-}
-
 static inline unsigned int oe_tree_depth(struct packing_data *pack,
 					 struct object_entry *e)
 {
@@ -422,23 +280,6 @@ static inline unsigned int oe_tree_depth(struct packing_data *pack,
 	return pack->tree_depth[e - pack->objects];
 }
 
-static inline void oe_set_tree_depth(struct packing_data *pack,
-				     struct object_entry *e,
-				     unsigned int tree_depth)
-{
-	if (!pack->tree_depth)
-		CALLOC_ARRAY(pack->tree_depth, pack->nr_alloc);
-	pack->tree_depth[e - pack->objects] = tree_depth;
-}
-
-static inline unsigned char oe_layer(struct packing_data *pack,
-				     struct object_entry *e)
-{
-	if (!pack->layer)
-		return 0;
-	return pack->layer[e - pack->objects];
-}
-
 static inline void oe_set_layer(struct packing_data *pack,
 				struct object_entry *e,
 				unsigned char layer)
-- 
2.32.0.rc1.413.g73297d74493

