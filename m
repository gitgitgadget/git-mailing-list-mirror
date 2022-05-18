Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D336C433F5
	for <git@archiver.kernel.org>; Wed, 18 May 2022 23:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiERXL2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 19:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiERXLR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 19:11:17 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2682CC83
        for <git@vger.kernel.org>; Wed, 18 May 2022 16:11:16 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id p74so395175iod.8
        for <git@vger.kernel.org>; Wed, 18 May 2022 16:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3fsAElo0mYlsn8kCYYH/LUSHofJ6gGHgRFVcPt3jq6I=;
        b=lKPdSUescPJD+N2JpkVwDpzvstJaSYLeewkXOh3SO1EMtjEuE5Xy6FhrBn41gcvkpJ
         tYUJb90XDV9Trk5RrYLB9J4VPQ390y2W2UcweXi/plAyLP12mTPGXTgm74rgf+ct5mD+
         M9gIWGjWwwwMJU/MDhTL0ekyV3HPKnrkZn3JzIWlDz25ByGCjr2kpR7jdtKsNUGDvsmf
         ykfifbzyeb7ikvrHZsnIqfBlcx3/l/HRpAd3uDddmu8Itmm2UtTgfjGlIhk/ylJ77iPI
         3+GvOoGhsN2CWazglqCBTx1aFiSJzWKwqqw5eigTr3OSwJ5woBctFlBlglyXYLIlU3aN
         Zrxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3fsAElo0mYlsn8kCYYH/LUSHofJ6gGHgRFVcPt3jq6I=;
        b=vTwjDq81qQs/3uOEvt7AjO8GMJc/W92EbcWw5LntoO3ggEROslFUsGrbmVtT+tI+yv
         NR8yNBS0OyvMoqOheYI2/8GHZNwUJRtFmYL90xvVqrXXbLQgNaz6vSL2FuUYw6aQbegS
         0k+MXxodBfEnJoq+z2m7uZjfVxipHb3QYlbwuN3FBqX2MqEK73Uj27SwqeJypB9IWpDX
         AAh9jpfn+QewUKO5+33xxA1XK5Kd2wxH69zJzxae3za0jHXTrevWEot6E7BSC+oC0n8S
         cFpEbQ7BnmJHvpKvnQ97iaIzInvnfegA6qLsE4DzkaJCs68YBThC+7Ui5bouqYOFYGd4
         i5XA==
X-Gm-Message-State: AOAM533VXf1GYND4FBvVEojIIWsh3TIOOi7rz5g4bamHTnaOe3zMKcbe
        VS5tEhXJ/tN8ORVdOUhAxuOdYmr0G2fiTFZx
X-Google-Smtp-Source: ABdhPJwJaEa+xmY1WjTxQOCLECDdJyoSzvg5Ki0ZjkWDsU/mpFCOzIl2NuV01yFu0SDUMVy66fzZzg==
X-Received: by 2002:a05:6638:2182:b0:32b:8ed4:4e26 with SMTP id s2-20020a056638218200b0032b8ed44e26mr1072969jaj.225.1652915475505;
        Wed, 18 May 2022 16:11:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j198-20020a0263cf000000b0032e307deea8sm240994jac.13.2022.05.18.16.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 16:11:15 -0700 (PDT)
Date:   Wed, 18 May 2022 19:11:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: [PATCH v4 09/17] reachable: add options to
 add_unseen_recent_objects_to_traversal
Message-ID: <da7273f41f61e7b87cecf5a9eb0ab6a4eef4353b.1652915424.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1652915424.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1652915424.git.me@ttaylorr.com>
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

