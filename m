Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7939C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 23:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354051AbiETXSP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 19:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354036AbiETXR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 19:17:58 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F581A0AFE
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:17:57 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id v11so8942342qkf.1
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3fsAElo0mYlsn8kCYYH/LUSHofJ6gGHgRFVcPt3jq6I=;
        b=BuauLgC5PldcONLEQRi44sIxvHPF9PVXf649bIoGboAtpcb7KFY1Av+dOZMhV3QMdf
         LGeSzuEA/qQBH1RKUeNHJQrtW+e8wuTd7JyoxsEPaddIWCSY9mR12r28E9JQpm1KAaRw
         06iny719w7x9nIaJNjwtbnpKQE1DavGxdbbFeAtCNPyp4anstzgR2BbuH0u8y6QT9Z0W
         gpTJB1he63myRCMfNonqPZlSyEVtrsUVdkc1u4hjcbiqe22weEIHyw5IGlWGFDIOhSR9
         5zUhEqyAYLU5WJgMB10140Z55Vt3HmcUI3fIuhCZ3Jh00aQnZqzLWQq5uT1SJj7d7P0F
         ex0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3fsAElo0mYlsn8kCYYH/LUSHofJ6gGHgRFVcPt3jq6I=;
        b=VdvfiDXzMZmBQYxno8HiqLVTuNJ1VNugFLSvWmwITpl/zNf1dEF1sFnIcztVVHDItW
         36R7C8sIz3UBcSGIjNthujWQByP89a3FTkiMOekooE3gFfbEvsCMlFcLrVVv7aF39Xy8
         iEuK4xQO18oRFPr4YyQNe6cO1f/zKiEmLDjO21T8qLLVigCqVaAxQpAO8o0kUTuh1laq
         s32dHWLxeRfiZUjKJ6/tkAxTvOw7UXidwWMxJbZBCgOtlNV4ADuoEkBybjwiN2V8zgNG
         98MbWafeQJERylnhooEK1N2S4zoDTGN0sGMrPqVMQJmdX9zywIhGVReLS6TGWISvJHpm
         VS5g==
X-Gm-Message-State: AOAM531iD5E1Iq7MbcxPtIR6nACXW9fugig65EWg4iYXgv5lTOz6TZrM
        v9T+ufnKqRlx2oYD9NGuTbd0UqizSfakQOMf
X-Google-Smtp-Source: ABdhPJwV9m3TffycJxFU1W6hA5mLiy3gaIRGSh1nn8ilMrk/+KXL4VqfG+cUC1M1odf5uzznukqAqA==
X-Received: by 2002:a05:620a:28d4:b0:6a0:9a5f:3d8b with SMTP id l20-20020a05620a28d400b006a09a5f3d8bmr7940489qkp.622.1653088676039;
        Fri, 20 May 2022 16:17:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w16-20020a05620a129000b0069fc13ce1e1sm471761qki.18.2022.05.20.16.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 16:17:55 -0700 (PDT)
Date:   Fri, 20 May 2022 19:17:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: [PATCH v5 09/17] reachable: add options to
 add_unseen_recent_objects_to_traversal
Message-ID: <1cf00d462cc94775825a758558a5428e30919fee.1653088640.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1653088640.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function behaves very similarly to what we will need in
pack-objects in order to implement cruft packs with expiration. But it
is lacking a couple of things. Namely, it needs:

  - a mechanism to communicate the timestamps of individual recent
    objects to some external caller

  - and, in the case of packed objects, our future caller will also want
    to know the originating pack, as well as the offset within that pack
    at which the object can be found

  - finally, it needs a way to skip over packs which are marked as kept
    in-core.

To address the first two, add a callback interface in this patch which
reports the time of each recent object, as well as a (packed_git,
off_t) pair for packed objects.

Likewise, add a new option to the packed object iterators to skip over
packs which are marked as kept in core. This option will become
implicitly tested in a future patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c |  2 +-
 reachable.c            | 51 +++++++++++++++++++++++++++++++++++-------
 reachable.h            |  9 +++++++-
 3 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 9cf89be673..3b8bf6a3dd 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3957,7 +3957,7 @@ static void get_object_list(struct rev_info *revs, int ac, const char **av)
 	if (unpack_unreachable_expiration) {
 		revs->ignore_missing_links = 1;
 		if (add_unseen_recent_objects_to_traversal(revs,
-				unpack_unreachable_expiration))
+				unpack_unreachable_expiration, NULL, 0))
 			die(_("unable to add recent objects"));
 		if (prepare_revision_walk(revs))
 			die(_("revision walk setup failed"));
diff --git a/reachable.c b/reachable.c
index b9f4ad886e..d4507c4270 100644
--- a/reachable.c
+++ b/reachable.c
@@ -60,9 +60,13 @@ static void mark_commit(struct commit *c, void *data)
 struct recent_data {
 	struct rev_info *revs;
 	timestamp_t timestamp;
+	report_recent_object_fn *cb;
+	int ignore_in_core_kept_packs;
 };
 
 static void add_recent_object(const struct object_id *oid,
+			      struct packed_git *pack,
+			      off_t offset,
 			      timestamp_t mtime,
 			      struct recent_data *data)
 {
@@ -103,13 +107,29 @@ static void add_recent_object(const struct object_id *oid,
 		die("unable to lookup %s", oid_to_hex(oid));
 
 	add_pending_object(data->revs, obj, "");
+	if (data->cb)
+		data->cb(obj, pack, offset, mtime);
+}
+
+static int want_recent_object(struct recent_data *data,
+			      const struct object_id *oid)
+{
+	if (data->ignore_in_core_kept_packs &&
+	    has_object_kept_pack(oid, IN_CORE_KEEP_PACKS))
+		return 0;
+	return 1;
 }
 
 static int add_recent_loose(const struct object_id *oid,
 			    const char *path, void *data)
 {
 	struct stat st;
-	struct object *obj = lookup_object(the_repository, oid);
+	struct object *obj;
+
+	if (!want_recent_object(data, oid))
+		return 0;
+
+	obj = lookup_object(the_repository, oid);
 
 	if (obj && obj->flags & SEEN)
 		return 0;
@@ -126,7 +146,7 @@ static int add_recent_loose(const struct object_id *oid,
 		return error_errno("unable to stat %s", oid_to_hex(oid));
 	}
 
-	add_recent_object(oid, st.st_mtime, data);
+	add_recent_object(oid, NULL, 0, st.st_mtime, data);
 	return 0;
 }
 
@@ -134,29 +154,43 @@ static int add_recent_packed(const struct object_id *oid,
 			     struct packed_git *p, uint32_t pos,
 			     void *data)
 {
-	struct object *obj = lookup_object(the_repository, oid);
+	struct object *obj;
+
+	if (!want_recent_object(data, oid))
+		return 0;
+
+	obj = lookup_object(the_repository, oid);
 
 	if (obj && obj->flags & SEEN)
 		return 0;
-	add_recent_object(oid, p->mtime, data);
+	add_recent_object(oid, p, nth_packed_object_offset(p, pos), p->mtime, data);
 	return 0;
 }
 
 int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
-					   timestamp_t timestamp)
+					   timestamp_t timestamp,
+					   report_recent_object_fn *cb,
+					   int ignore_in_core_kept_packs)
 {
 	struct recent_data data;
+	enum for_each_object_flags flags;
 	int r;
 
 	data.revs = revs;
 	data.timestamp = timestamp;
+	data.cb = cb;
+	data.ignore_in_core_kept_packs = ignore_in_core_kept_packs;
 
 	r = for_each_loose_object(add_recent_loose, &data,
 				  FOR_EACH_OBJECT_LOCAL_ONLY);
 	if (r)
 		return r;
-	return for_each_packed_object(add_recent_packed, &data,
-				      FOR_EACH_OBJECT_LOCAL_ONLY);
+
+	flags = FOR_EACH_OBJECT_LOCAL_ONLY | FOR_EACH_OBJECT_PACK_ORDER;
+	if (ignore_in_core_kept_packs)
+		flags |= FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS;
+
+	return for_each_packed_object(add_recent_packed, &data, flags);
 }
 
 static int mark_object_seen(const struct object_id *oid,
@@ -217,7 +251,8 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 
 	if (mark_recent) {
 		revs->ignore_missing_links = 1;
-		if (add_unseen_recent_objects_to_traversal(revs, mark_recent))
+		if (add_unseen_recent_objects_to_traversal(revs, mark_recent,
+							   NULL, 0))
 			die("unable to mark recent objects");
 		if (prepare_revision_walk(revs))
 			die("revision walk setup failed");
diff --git a/reachable.h b/reachable.h
index 5df932ad8f..b776761baa 100644
--- a/reachable.h
+++ b/reachable.h
@@ -1,11 +1,18 @@
 #ifndef REACHEABLE_H
 #define REACHEABLE_H
 
+#include "object.h"
+
 struct progress;
 struct rev_info;
 
+typedef void report_recent_object_fn(const struct object *, struct packed_git *,
+				     off_t, time_t);
+
 int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
-					   timestamp_t timestamp);
+					   timestamp_t timestamp,
+					   report_recent_object_fn cb,
+					   int ignore_in_core_kept_packs);
 void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 			    timestamp_t mark_recent, struct progress *);
 
-- 
2.36.1.94.gb0d54bedca

