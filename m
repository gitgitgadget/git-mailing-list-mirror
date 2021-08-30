Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67A3C4320E
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 02:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6BD3601FD
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 02:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbhH3Ct5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Aug 2021 22:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbhH3Ctv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Aug 2021 22:49:51 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95828C061575
        for <git@vger.kernel.org>; Sun, 29 Aug 2021 19:48:58 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id y3so14512365ilm.6
        for <git@vger.kernel.org>; Sun, 29 Aug 2021 19:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3x5oi3PJu/bG/PA3zBC4mOdQqOOWyQeUhcGSt/ozz5Y=;
        b=1yNh0Vk7DB4cCfzw+lAe6xgPZjP2cUow2LsNzWemqq7cAn4dD9SrFD4uSHHOhl2ZU1
         3reypRs5qvlKr7uVbAmYbCUEtuEwFJtpnhP5EeDDJb+y8uyh5/PZjMma6AltiYM7fhJI
         WEJoAUCJyAD8IOzAMoLN/g6BfGXRGIlmJRBI2XctYpwyyDShnzS7BCOaBjc3fkQ0CM5L
         vfNjUyIbY+/vrFut0kKrPr0+3g22Y9tm604zIc3XiMsPGASGqXv/riWYNjkOicXk43XJ
         RSTO+6gt6xMaXzGv6SARYjkfbgyF2Psm0+eupJzSPKgQp6J4sqhTaXxUaaGrAdyyuV6Y
         +EMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3x5oi3PJu/bG/PA3zBC4mOdQqOOWyQeUhcGSt/ozz5Y=;
        b=fxuMYDchR2aScJzUjzmEcZyI4kdqjxYExfcu+T7Fy1Y/jlIodVwG8oURZ+xapUwrbz
         y+NDJT4cPJDfh/tQmtxFzl31ir6xjeZOTAK7to0ZrAg29lb3fS2BzTpxYbsmwL+fpV3k
         a2DL4aDYTrLMbGzVNftisfnhH5j1d9Eg+cI6soKAdZxxyXpSSN+Ftez4dD8cCGuv7Ls7
         AyAfjpFR5iItPRSA6V+NOJcdMpwJo0JZmeViVpuOjFwZHd6zbEBPDoMFwV+XsgsUGbZW
         mjqZf3ROKr0zFO+9eBmkUyp+AZBp76wbkKZ6qpKNi0vWI++rd2aeH9OMUJCAr9UNlJ7t
         9pTg==
X-Gm-Message-State: AOAM533FyIARMUJaPxl0GbqByUEOLj9xPgfun7WEpCggWGXMktiIKOZB
        WwK5XW4AO06NtfvBpNLt5gv8SxTAZ09fEbBi
X-Google-Smtp-Source: ABdhPJwMpgUe3f/EvwL+2O+cl4a6tW/s+clbfJZadqfPFacHuNyfqM6e+ouYbn4FfjzytFii6LY0Tw==
X-Received: by 2002:a92:d5d1:: with SMTP id d17mr14421169ilq.106.1630291737923;
        Sun, 29 Aug 2021 19:48:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k21sm7434369ioh.38.2021.08.29.19.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 19:48:57 -0700 (PDT)
Date:   Sun, 29 Aug 2021 22:48:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH 3/3] builtin/pack-objects.c: remove duplicate hash lookup
Message-ID: <5f7f88ac1dc022de2ae5108828a1f61f7150686b.1630291682.git.me@ttaylorr.com>
References: <cover.1630291682.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1630291682.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the original code from 08cdfb1337 (pack-objects --keep-unreachable,
2007-09-16), we add each object to the packing list with type
`obj->type`, where `obj` comes from `lookup_unknown_object()`. Unless we
had already looked up and parsed the object, this will be `OBJ_NONE`.
That's fine, since oe_set_type() sets the type_valid bit to '0', and we
determine the real type later on.

So the only thing we need from the object lookup is access to the
`flags` field so that we can mark that we've added the object with
`OBJECT_ADDED` to avoid adding it again (we can just pass `OBJ_NONE`
directly instead of grabbing it from the object).

But add_object_entry() already rejects duplicates! This has been the
behavior since 7a979d99ba (Thin pack - create packfile with missing
delta base., 2006-02-19), but 08cdfb1337 didn't take advantage of it.
Moreover, to do the OBJECT_ADDED check, we have to do a hash lookup in
`obj_hash`.

So we can drop the lookup_unknown_object() call completely, *and* the
OBJECT_ADDED flag, too, since the spot we're touching here is the only
location that checks it.

In the end, we perform the same number of hash lookups, but with the
added bonus that we don't waste memory allocating an OBJ_NONE object (if
we were traversing, we'd need it eventually, but the whole point of this
code path is not to traverse).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 11 +----------
 object.h               |  1 -
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 87ddbd5553..ec8503563a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3405,13 +3405,9 @@ static void read_object_list_from_stdin(void)
 	}
 }
 
-/* Remember to update object flag allocation in object.h */
-#define OBJECT_ADDED (1u<<20)
-
 static void show_commit(struct commit *commit, void *data)
 {
 	add_object_entry(&commit->object.oid, OBJ_COMMIT, NULL, 0);
-	commit->object.flags |= OBJECT_ADDED;
 
 	if (write_bitmap_index)
 		index_commit_for_bitmap(commit);
@@ -3424,7 +3420,6 @@ static void show_object(struct object *obj, const char *name, void *data)
 {
 	add_preferred_base_object(name);
 	add_object_entry(&obj->oid, obj->type, name, 0);
-	obj->flags |= OBJECT_ADDED;
 
 	if (use_delta_islands) {
 		const char *p;
@@ -3510,11 +3505,7 @@ static int add_object_in_unpacked_pack(const struct object_id *oid,
 				       uint32_t pos,
 				       void *_data)
 {
-	struct object *obj = lookup_unknown_object(the_repository, oid);
-	if (obj->flags & OBJECT_ADDED)
-		return 0;
-	add_object_entry(oid, obj->type, "", 0);
-	obj->flags |= OBJECT_ADDED;
+	add_object_entry(oid, OBJ_NONE, "", 0);
 	return 0;
 }
 
diff --git a/object.h b/object.h
index 3b38c9cc98..549f2d256b 100644
--- a/object.h
+++ b/object.h
@@ -75,7 +75,6 @@ struct object_array {
  * builtin/fsck.c:           0--3
  * builtin/gc.c:             0
  * builtin/index-pack.c:                                     2021
- * builtin/pack-objects.c:                                   20
  * builtin/reflog.c:                   10--12
  * builtin/show-branch.c:    0-------------------------------------------26
  * builtin/unpack-objects.c:                                 2021
-- 
2.33.0.96.g73915697e6
