Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C028C433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDFBC235E4
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbhAMW2t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 17:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729302AbhAMWYv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 17:24:51 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073ABC061794
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:23:35 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id g24so2285728qtq.12
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r2Ij7b3enD/CrytVWJjzjfBbDMQQjC8jGACJJMCAAQI=;
        b=NO7CihYa1+Hwl8KxBon6MXQTKMHsYqW1q/jwe+henaz4dA6DmgHJUiHOPojndZGyOZ
         hv+29bycngQCgmXwtntrCoYQAHhXhPT7VSoM2P6gD66ZHvmNKLU8yXSgQ7sms8+lVlIb
         Q+IOyfsPlw583ILOdHMefB7hCeSPoCEkye31oa0kEBDvrpn7AfG27Ymlp4nSHAyiU6DZ
         WmCxvIsBGoQZ+42u8YadghgyclXyO2KndGHHNgGHpjrbe8pfeuFuCuymEmbEJ+Mzq7Y2
         gcttsdVyCLWXpchDm56tl4lbnDgbpOm+IAV18/l0tWelNpeqMYuV7W6YaiC7kLQUUE/m
         cLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r2Ij7b3enD/CrytVWJjzjfBbDMQQjC8jGACJJMCAAQI=;
        b=WXAHB3RzQlTlN4hT2zKm4orCV1Fq70Dz/dG6LgzhGNY/+sYHXloJ2wLugu9jDZ38Tr
         vL01Ewm7ZhxxOuhpIROaLZ0Klp2iOIbJEW8xPs3ECdo/CDbHQVoSyQ1cpwQy6qhPFW6h
         0jIEoG/a9bsB7SNZpSFhqgg1e3KBy80L/WO1jtG4/k4YrgEi9Qjii72uR5gNPfEUjciM
         qovFV6OWwL+VV+z3RdWjHKaoh5YGydl5W/j2KP5R5PFAikTEoz2I3cVMQHAmwR3Q7mef
         axlK1lolPnezNgGqvdQveruCp/SXnXHys/hiuzS7799WVtQqkxfEi7UewwBJJCJREu7t
         Hqhg==
X-Gm-Message-State: AOAM533ps6bOID/FlicKrk1kSrhLA9VUkkDy+OlBOerRTEPiIgSZDcsT
        W4DQNPLtQBJiOs9CF0Z6wTYblXOp1Kld1A==
X-Google-Smtp-Source: ABdhPJxI1awlAZKxzivC6Rz0sQ6BaASAh+f41Q/g6fybVyt19W2htuO3PowoJHSmSur3++jlYDyVcw==
X-Received: by 2002:ac8:128c:: with SMTP id y12mr4503266qti.127.1610576613830;
        Wed, 13 Jan 2021 14:23:33 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id n4sm1860946qtl.22.2021.01.13.14.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:23:33 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:23:31 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v2 01/20] pack-revindex: introduce a new API
Message-ID: <e1aa89244ad3edb52aaeb28d6934cb2b0a0dc65a.1610576604.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610576604.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the next several patches, we will prepare for loading a reverse index
either in memory (mapping the inverse of the .idx's contents in-core),
or directly from a yet-to-be-introduced on-disk format. To prepare for
that, we'll introduce an API that avoids the caller explicitly indexing
the revindex pointer in the packed_git structure.

There are four ways to interact with the reverse index. Accordingly,
four functions will be exported from 'pack-revindex.h' by the time that
the existing API is removed. A caller may:

 1. Load the pack's reverse index. This involves opening up the index,
    generating an array, and then sorting it. Since opening the index
    can fail, this function ('load_pack_revindex()') returns an int.
    Accordingly, it takes only a single argument: the 'struct
    packed_git' the caller wants to build a reverse index for.

    This function is well-suited for both the current and new API.
    Callers will have to continue to open the reverse index explicitly,
    but this function will eventually learn how to detect and load a
    reverse index from the on-disk format, if one exists. Otherwise, it
    will fallback to generating one in memory from scratch.

 2. Convert a pack position into an offset. This operation is now
    called `pack_pos_to_offset()`. It takes a pack and a position, and
    returns the corresponding off_t.

    Any error simply calls BUG(), since the callers are not well-suited
    to handle a failure and keep going.

 3. Convert a pack position into an index position. Same as above; this
    takes a pack and a position, and returns a uint32_t. This operation
    is known as `pack_pos_to_index()`. The same thinking about error
    conditions applies here as well.

 4. Find the pack position for a given offset. This operation is now
    known as `offset_to_pack_pos()`. It takes a pack, an offset, and a
    pointer to a uint32_t where the position is written, if an object
    exists at that offset. Otherwise, -1 is returned to indicate
    failure.

    Unlike some of the callers that used to access '->offset' and '->nr'
    directly, the error checking around this call is somewhat more
    robust. This is important since callers should always pass an offset
    which points at the boundary of two objects. The API, unlike direct
    access, enforces that that is the case.

    This will become important in a subsequent patch where a caller
    which does not but could check the return value treats the signed
    `-1` from `find_revindex_position()` as an index into the 'revindex'
    array.

Two design warts are carried over into the new API:

  - Asking for the index position of an out-of-bounds object will result
    in a BUG() (since no such object exists), but asking for the offset
    of the non-existent object at the end of the pack returns the total
    size of the pack.

    This makes it convenient for callers who always want to take the
    difference of two adjacent object's offsets (to compute the on-disk
    size) but don't want to worry about boundaries at the end of the
    pack.

  - offset_to_pack_pos() lazily loads the reverse index, but
    pack_pos_to_index() doesn't (callers of the former are well-suited
    to handle errors, but callers of the latter are not).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-revindex.c | 32 +++++++++++++++++++++++++++++
 pack-revindex.h | 54 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/pack-revindex.c b/pack-revindex.c
index ecdde39cf4..0ca3b54b45 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -203,3 +203,35 @@ struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs)
 
 	return p->revindex + pos;
 }
+
+int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
+{
+	int ret;
+
+	if (load_pack_revindex(p) < 0)
+		return -1;
+
+	ret = find_revindex_position(p, ofs);
+	if (ret < 0)
+		return ret;
+	*pos = ret;
+	return 0;
+}
+
+uint32_t pack_pos_to_index(struct packed_git *p, uint32_t pos)
+{
+	if (!p->revindex)
+		BUG("pack_pos_to_index: reverse index not yet loaded");
+	if (p->num_objects <= pos)
+		BUG("pack_pos_to_index: out-of-bounds object at %"PRIu32, pos);
+	return p->revindex[pos].nr;
+}
+
+off_t pack_pos_to_offset(struct packed_git *p, uint32_t pos)
+{
+	if (!p->revindex)
+		BUG("pack_pos_to_index: reverse index not yet loaded");
+	if (p->num_objects < pos)
+		BUG("pack_pos_to_offset: out-of-bounds object at %"PRIu32, pos);
+	return p->revindex[pos].offset;
+}
diff --git a/pack-revindex.h b/pack-revindex.h
index 848331d5d6..5a218aaa66 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -1,6 +1,21 @@
 #ifndef PACK_REVINDEX_H
 #define PACK_REVINDEX_H
 
+/**
+ * A revindex allows converting efficiently between three properties
+ * of an object within a pack:
+ *
+ * - index position: the numeric position within the list of sorted object ids
+ *   found in the .idx file
+ *
+ * - pack position: the numeric position within the list of objects in their
+ *   order within the actual .pack file (i.e., 0 is the first object in the
+ *   .pack, 1 is the second, and so on)
+ *
+ * - offset: the byte offset within the .pack file at which the object contents
+ *   can be found
+ */
+
 struct packed_git;
 
 struct revindex_entry {
@@ -8,9 +23,48 @@ struct revindex_entry {
 	unsigned int nr;
 };
 
+/*
+ * load_pack_revindex populates the revindex's internal data-structures for the
+ * given pack, returning zero on success and a negative value otherwise.
+ */
 int load_pack_revindex(struct packed_git *p);
 int find_revindex_position(struct packed_git *p, off_t ofs);
 
 struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs);
 
+/*
+ * offset_to_pack_pos converts an object offset to a pack position. This
+ * function returns zero on success, and a negative number otherwise. The
+ * parameter 'pos' is usable only on success.
+ *
+ * If the reverse index has not yet been loaded, this function loads it lazily,
+ * and returns an negative number if an error was encountered.
+ *
+ * This function runs in time O(log N) with the number of objects in the pack.
+ */
+int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos);
+
+/*
+ * pack_pos_to_index converts the given pack-relative position 'pos' by
+ * returning an index-relative position.
+ *
+ * If the reverse index has not yet been loaded, or the position is out of
+ * bounds, this function aborts.
+ *
+ * This function runs in constant time.
+ */
+uint32_t pack_pos_to_index(struct packed_git *p, uint32_t pos);
+
+/*
+ * pack_pos_to_offset converts the given pack-relative position 'pos' into a
+ * pack offset. For a pack with 'N' objects, asking for position 'N' will return
+ * the total size (in bytes) of the pack.
+ *
+ * If the reverse index has not yet been loaded, or the position is out of
+ * bounds, this function aborts.
+ *
+ * This function runs in constant time.
+ */
+off_t pack_pos_to_offset(struct packed_git *p, uint32_t pos);
+
 #endif
-- 
2.30.0.138.g6d7191ea01

