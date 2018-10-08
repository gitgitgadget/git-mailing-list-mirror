Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E13E1F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 21:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbeJIFLM (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 01:11:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49360 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725991AbeJIFLL (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Oct 2018 01:11:11 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e17d:6d35:bfb8:6a25])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 279B56079C;
        Mon,  8 Oct 2018 21:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539035840;
        bh=Mi/LPpAhVdZfMLtx1DCYc5Trh8mZP5nPrkqMHP5g8BI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=JuLD+56G0/LsxqEAYQOsodn54jeKK3a/4AWfWNEwVVAo2UvuRduzZDj45EBzaTMUS
         m+loLwpRTC6ySO18pPUTrHHX9CIp20zfGkQ3Qy28ja5OgoztdcEkN5/OQKneGGI4Ag
         YJiwrX3aqTgLbLW87wuyh+gRbMQ5suAb2TxuaG14G1tQh/Wvdi6dXK5CMQD2QolsBs
         uoIN7+JbVJtbEGabJQ2UXXrKWcRwIZw85VSe1647fBDIJYkuPEOzVrmGXmA/J1aAzx
         ONfhkHNzMDRbLZCGR+JpjYSxZkTmmZBW0I8DWZL/u7Xd+oVOFJEkAsPYIv3E5fryNJ
         yoFfK0EZZsVizdP5zQIpt8QQ8RwIlanL4lxtLJimmFFOhQnh0HHsAy3HICyedcNcf7
         79TRsqjqUPmTUwz5oGxgeEGGhG87qb1thR9r3bwzLxzgwml79mVg8BCOejMsJUBbfv
         QYuGymTEJWM7dElaekiB62bfyfpiZoM6qQbnw+uD6xVccjdpasu
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 12/14] apply: rename new_sha1_prefix and old_sha1_prefix
Date:   Mon,  8 Oct 2018 21:56:59 +0000
Message-Id: <20181008215701.779099-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c
In-Reply-To: <20181008215701.779099-1-sandals@crustytoothpaste.net>
References: <20181008215701.779099-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename these structure members to "new_oid_prefix" and "old_oid_prefix".

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 apply.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/apply.c b/apply.c
index 792ecea36a..b9eb02ec12 100644
--- a/apply.c
+++ b/apply.c
@@ -223,8 +223,8 @@ struct patch {
 	struct fragment *fragments;
 	char *result;
 	size_t resultsize;
-	char old_sha1_prefix[GIT_MAX_HEXSZ + 1];
-	char new_sha1_prefix[GIT_MAX_HEXSZ + 1];
+	char old_oid_prefix[GIT_MAX_HEXSZ + 1];
+	char new_oid_prefix[GIT_MAX_HEXSZ + 1];
 	struct patch *next;
 
 	/* three-way fallback result */
@@ -1099,8 +1099,8 @@ static int gitdiff_index(struct apply_state *state,
 	if (!ptr || ptr[1] != '.' || hexsz < ptr - line)
 		return 0;
 	len = ptr - line;
-	memcpy(patch->old_sha1_prefix, line, len);
-	patch->old_sha1_prefix[len] = 0;
+	memcpy(patch->old_oid_prefix, line, len);
+	patch->old_oid_prefix[len] = 0;
 
 	line = ptr + 2;
 	ptr = strchr(line, ' ');
@@ -1112,8 +1112,8 @@ static int gitdiff_index(struct apply_state *state,
 
 	if (hexsz < len)
 		return 0;
-	memcpy(patch->new_sha1_prefix, line, len);
-	patch->new_sha1_prefix[len] = 0;
+	memcpy(patch->new_oid_prefix, line, len);
+	patch->new_oid_prefix[len] = 0;
 	if (*ptr == ' ')
 		return gitdiff_oldmode(state, ptr + 1, patch);
 	return 0;
@@ -2205,7 +2205,7 @@ static void reverse_patches(struct patch *p)
 		SWAP(p->new_mode, p->old_mode);
 		SWAP(p->is_new, p->is_delete);
 		SWAP(p->lines_added, p->lines_deleted);
-		SWAP(p->old_sha1_prefix, p->new_sha1_prefix);
+		SWAP(p->old_oid_prefix, p->new_oid_prefix);
 
 		for (; frag; frag = frag->next) {
 			SWAP(frag->newpos, frag->oldpos);
@@ -3149,10 +3149,10 @@ static int apply_binary(struct apply_state *state,
 	 * For safety, we require patch index line to contain
 	 * full hex textual object ID for old and new, at least for now.
 	 */
-	if (strlen(patch->old_sha1_prefix) != hexsz ||
-	    strlen(patch->new_sha1_prefix) != hexsz ||
-	    get_oid_hex(patch->old_sha1_prefix, &oid) ||
-	    get_oid_hex(patch->new_sha1_prefix, &oid))
+	if (strlen(patch->old_oid_prefix) != hexsz ||
+	    strlen(patch->new_oid_prefix) != hexsz ||
+	    get_oid_hex(patch->old_oid_prefix, &oid) ||
+	    get_oid_hex(patch->new_oid_prefix, &oid))
 		return error(_("cannot apply binary patch to '%s' "
 			       "without full index line"), name);
 
@@ -3162,7 +3162,7 @@ static int apply_binary(struct apply_state *state,
 		 * applies to.
 		 */
 		hash_object_file(img->buf, img->len, blob_type, &oid);
-		if (strcmp(oid_to_hex(&oid), patch->old_sha1_prefix))
+		if (strcmp(oid_to_hex(&oid), patch->old_oid_prefix))
 			return error(_("the patch applies to '%s' (%s), "
 				       "which does not match the "
 				       "current contents."),
@@ -3175,7 +3175,7 @@ static int apply_binary(struct apply_state *state,
 				       "'%s' but it is not empty"), name);
 	}
 
-	get_oid_hex(patch->new_sha1_prefix, &oid);
+	get_oid_hex(patch->new_oid_prefix, &oid);
 	if (is_null_oid(&oid)) {
 		clear_image(img);
 		return 0; /* deletion patch */
@@ -3191,7 +3191,7 @@ static int apply_binary(struct apply_state *state,
 		if (!result)
 			return error(_("the necessary postimage %s for "
 				       "'%s' cannot be read"),
-				     patch->new_sha1_prefix, name);
+				     patch->new_oid_prefix, name);
 		clear_image(img);
 		img->buf = result;
 		img->len = size;
@@ -3207,9 +3207,9 @@ static int apply_binary(struct apply_state *state,
 
 		/* verify that the result matches */
 		hash_object_file(img->buf, img->len, blob_type, &oid);
-		if (strcmp(oid_to_hex(&oid), patch->new_sha1_prefix))
+		if (strcmp(oid_to_hex(&oid), patch->new_oid_prefix))
 			return error(_("binary patch to '%s' creates incorrect result (expecting %s, got %s)"),
-				name, patch->new_sha1_prefix, oid_to_hex(&oid));
+				name, patch->new_oid_prefix, oid_to_hex(&oid));
 	}
 
 	return 0;
@@ -3565,7 +3565,7 @@ static int try_threeway(struct apply_state *state,
 	/* Preimage the patch was prepared for */
 	if (patch->is_new)
 		write_object_file("", 0, blob_type, &pre_oid);
-	else if (get_oid(patch->old_sha1_prefix, &pre_oid) ||
+	else if (get_oid(patch->old_oid_prefix, &pre_oid) ||
 		 read_blob_object(&buf, &pre_oid, patch->old_mode))
 		return error(_("repository lacks the necessary blob to fall back on 3-way merge."));
 
@@ -4059,11 +4059,11 @@ static int preimage_oid_in_gitlink_patch(struct patch *p, struct object_id *oid)
 	    !get_oid_hex(preimage + sizeof(heading) - 1, oid) &&
 	    preimage[sizeof(heading) + the_hash_algo->hexsz - 1] == '\n' &&
 	    /* does the abbreviated name on the index line agree with it? */
-	    starts_with(preimage + sizeof(heading) - 1, p->old_sha1_prefix))
+	    starts_with(preimage + sizeof(heading) - 1, p->old_oid_prefix))
 		return 0; /* it all looks fine */
 
 	/* we may have full object name on the index line */
-	return get_oid_hex(p->old_sha1_prefix, oid);
+	return get_oid_hex(p->old_oid_prefix, oid);
 }
 
 /* Build an index that contains just the files needed for a 3way merge */
@@ -4092,7 +4092,7 @@ static int build_fake_ancestor(struct apply_state *state, struct patch *list)
 			else
 				return error(_("sha1 information is lacking or "
 					       "useless for submodule %s"), name);
-		} else if (!get_oid_blob(patch->old_sha1_prefix, &oid)) {
+		} else if (!get_oid_blob(patch->old_oid_prefix, &oid)) {
 			; /* ok */
 		} else if (!patch->lines_added && !patch->lines_deleted) {
 			/* mode-only change: update the current */
