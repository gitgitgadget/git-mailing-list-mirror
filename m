Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B18C76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 13:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjDKNpa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 09:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjDKNpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 09:45:25 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD7D2D48
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 06:45:24 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54ee17a659bso159969817b3.4
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 06:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681220723; x=1683812723;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2vIOVWl9/+gnjDuqN43n4z1IqpJRKIIzI0Au6ERZ1Qc=;
        b=UmL+rkzOJgPbZQvRE9MsMJ3rUV0fgZFPWTN/g7WJllB4RvIVnOxVbX+PqNxqKbPs9a
         96BTvjBpcYFTGn2E8qB91VvNT80jwLiOq8quHyZQzzGb5YFkg+4ql9mKSOAMiK2f/QK4
         itdr4wINHvkIocPHUZd5Ki0B9k1oDLL97CbH72Ko2TX4cGAfJnoO4XnGDpMQRvRKxwbJ
         FSfwzmvsb5Tac+yJShAlmzdTyy95Na+MYTe1xV/7jHhNArRo4DYLIyElwchdA3wZLbug
         9Ec/rlB0gMKAtFbRLIX+PbXo2gcgWHg2EU4XLvVi6HDY5IffjIYBkfEw45BFNokGempJ
         0+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681220723; x=1683812723;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2vIOVWl9/+gnjDuqN43n4z1IqpJRKIIzI0Au6ERZ1Qc=;
        b=tk9TMLTjfAfN/Khzdh4T2/k8tjtDHMPi+xadWiTT6TIjfeFtYBXYJd90JxN1fNEwdw
         29Yup/wem2siy9PfvMLW9jFZqAuD6NNP3oajE/1NVJwcWYctoQNuW3oauzgiFQ9R6i42
         N3c3y+Srv1gxyZRGFxP1YILnBRx4f9GgeOYHhFJ4pZfmwW55sNaBo17KGLmrY4kQUIsR
         GmLhJh8yS4GueyRBeGVf9deUZhOFN0rVs/hivFK5TkiOlvmCNYndAYA8R8wFjG5u15yk
         wk3+MUP8HVA3q922XGeINqp/spDNerBhHzdk7HohTYg/cDvyb+SIL+UsdAeGfIUV6ODj
         r3Jg==
X-Gm-Message-State: AAQBX9dhj9xSPAAtoQ/oLwGruk3lp9HNscuACCz2PRC+CGsHsttBehin
        hKHDqp+OKuFxR+QRZb+VJap08fMUSHSg6rGVdw==
X-Google-Smtp-Source: AKy350bcuGGXmMJpLhkzsQ/e/t27JdxrSiVsmaUuMAdbzHtWXMdNz3tcfCE0ZBW2+buJBqj2BGRpXA==
X-Received: by 2002:a0d:f943:0:b0:544:4d3d:4231 with SMTP id j64-20020a0df943000000b005444d3d4231mr6991493ywf.47.1681220723337;
        Tue, 11 Apr 2023 06:45:23 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id d82-20020a814f55000000b0054ef368af47sm2019572ywb.116.2023.04.11.06.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 06:45:22 -0700 (PDT)
Message-ID: <d81c0fe8-580f-dbab-9904-e0ea8459576c@github.com>
Date:   Tue, 11 Apr 2023 09:45:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/7] pack-revindex: make `load_pack_revindex` take a
 repository
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <cover.1681166596.git.me@ttaylorr.com>
 <be4faf11011efcfab479e5785e6c2bbac95309bd.1681166596.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <be4faf11011efcfab479e5785e6c2bbac95309bd.1681166596.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/10/2023 6:53 PM, Taylor Blau wrote:
> In a future commit, we will introduce a `pack.readReverseIndex`
> configuration, which forces Git to generate the reverse index from
> scratch instead of loading it from disk.
> 
> In order to avoid reading this configuration value more than once, we'll
> use the `repo_settings` struct to lazily load this value.
> 
> In order to access the `struct repo_settings`, add a repository argument
> to `load_pack_revindex`, and update all callers to pass the correct
> instance (in all cases, `the_repository`).

If all callers use the_repository, then we could presumably use
the_repository within the method directly. However, there are some
cases where the call chain is less obvious that we have already
entered something that is "repository scoped".

The patch below applies on top of this one and is the result of
exploring the two callers within pack-bitmap.c. Since they are
static, I was able to only modify things within that file, but
found two callers to _those_ methods that were repository scoped,
so without making this connection we are losing that scope.

There are other non-static methods in pack-bitmap.c that might
benefit from wiring a repository pointer through (or adding a
repository pointer to struct bitmap_index to get it for free),
but I used the trick of defining a local repository pointer at
the top of the method to make it easier to change in the future.

Thanks,
-Stolee


--- >8 ---

From 9816f7026199981b86d9f3e2188036e1b20bc2f9 Mon Sep 17 00:00:00 2001
From: Derrick Stolee <derrickstolee@github.com>
Date: Tue, 11 Apr 2023 09:34:42 -0400
Subject: [PATCH] pack-bitmap: use struct repository more often

The previous change introduced a 'struct repository *' parameter to
load_pack_revindex(). To satisfy the callers within pack-bitmap.c, these
parameters were filled with 'the_repository'.

However, these callers are sometimes included in methods that are
already scoped to a 'struct repository *' parameter. By dropping the
link from that repository and using the_repository, we are giving a
false impression that this portion of the rev-index API is properly
scoped to a single repository.

Expand the static methods in pack-bitmap.c that call
load_pack_revindex() to include a 'struct repository *' parameter.
Modify the callers of those methods to pass a repository as appropriate.
For the methods without an appropriate repository, create a local
variable equal to the_repository so it is easier to convert them to
using a parameter in the future.

In the case of prepare_bitmap_git(), we already have a repository
pointer parameter that can be used. In prepare_bitmap_walk(), the
rev_info struct contains a repository pointer.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 pack-bitmap.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 8e3bb00931..38b35c4823 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -463,7 +463,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 	return 0;
 }
 
-static int load_reverse_index(struct bitmap_index *bitmap_git)
+static int load_reverse_index(struct repository *r, struct bitmap_index *bitmap_git)
 {
 	if (bitmap_is_midx(bitmap_git)) {
 		uint32_t i;
@@ -477,24 +477,23 @@ static int load_reverse_index(struct bitmap_index *bitmap_git)
 		 * since we will need to make use of them in pack-objects.
 		 */
 		for (i = 0; i < bitmap_git->midx->num_packs; i++) {
-			ret = load_pack_revindex(the_repository,
-						 bitmap_git->midx->packs[i]);
+			ret = load_pack_revindex(r, bitmap_git->midx->packs[i]);
 			if (ret)
 				return ret;
 		}
 		return 0;
 	}
-	return load_pack_revindex(the_repository, bitmap_git->pack);
+	return load_pack_revindex(r, bitmap_git->pack);
 }
 
-static int load_bitmap(struct bitmap_index *bitmap_git)
+static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git)
 {
 	assert(bitmap_git->map);
 
 	bitmap_git->bitmaps = kh_init_oid_map();
 	bitmap_git->ext_index.positions = kh_init_oid_pos();
 
-	if (load_reverse_index(bitmap_git))
+	if (load_reverse_index(r, bitmap_git))
 		goto failed;
 
 	if (!(bitmap_git->commits = read_bitmap_1(bitmap_git)) ||
@@ -581,7 +580,7 @@ struct bitmap_index *prepare_bitmap_git(struct repository *r)
 {
 	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
 
-	if (!open_bitmap(r, bitmap_git) && !load_bitmap(bitmap_git))
+	if (!open_bitmap(r, bitmap_git) && !load_bitmap(r, bitmap_git))
 		return bitmap_git;
 
 	free_bitmap_index(bitmap_git);
@@ -590,9 +589,10 @@ struct bitmap_index *prepare_bitmap_git(struct repository *r)
 
 struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx)
 {
+	struct repository *r = the_repository;
 	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
 
-	if (!open_midx_bitmap_1(bitmap_git, midx) && !load_bitmap(bitmap_git))
+	if (!open_midx_bitmap_1(bitmap_git, midx) && !load_bitmap(r, bitmap_git))
 		return bitmap_git;
 
 	free_bitmap_index(bitmap_git);
@@ -1593,7 +1593,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 	 * from disk. this is the point of no return; after this the rev_list
 	 * becomes invalidated and we must perform the revwalk through bitmaps
 	 */
-	if (load_bitmap(bitmap_git) < 0)
+	if (load_bitmap(revs->repo, bitmap_git) < 0)
 		goto cleanup;
 
 	object_array_clear(&revs->pending);
@@ -1743,6 +1743,7 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 				       uint32_t *entries,
 				       struct bitmap **reuse_out)
 {
+	struct repository *r = the_repository;
 	struct packed_git *pack;
 	struct bitmap *result = bitmap_git->result;
 	struct bitmap *reuse;
@@ -1753,7 +1754,7 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 
 	assert(result);
 
-	load_reverse_index(bitmap_git);
+	load_reverse_index(r, bitmap_git);
 
 	if (bitmap_is_midx(bitmap_git))
 		pack = bitmap_git->midx->packs[midx_preferred_pack(bitmap_git)];
@@ -2133,11 +2134,12 @@ int rebuild_bitmap(const uint32_t *reposition,
 uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
 				struct packing_data *mapping)
 {
+	struct repository *r = the_repository;
 	uint32_t i, num_objects;
 	uint32_t *reposition;
 
 	if (!bitmap_is_midx(bitmap_git))
-		load_reverse_index(bitmap_git);
+		load_reverse_index(r, bitmap_git);
 	else if (load_midx_revindex(bitmap_git->midx) < 0)
 		BUG("rebuild_existing_bitmaps: missing required rev-cache "
 		    "extension");
-- 
2.40.0.vfs.0.0.3.g5872ac9aaa4

