Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E94C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiCCAWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiCCAV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:21:57 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9189210C516
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:21:06 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id q8so3984932iod.2
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 16:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZL9Xn4vJ1YAE0z3FDDkhh5/7TEmraDYuidhU9WAofIM=;
        b=jfnyZsOV8vS7aK4CkqilfRSL3PNDPpX4Q3ogHzs6DUFB37la3MYxQBy348xDyDOCeN
         bCbp7mGdKYsfnjQgI4AXocB2HWQ6oQd7hhUpsKA1FDLeCrXxTqJbUlxK8ME4LKNWQlNK
         AL7XkqU2kJ3f4k7g3onuakua7M+iF9eikWH73YLnFLqkD4aq9jCc/KPvAAtuy4CycZ+W
         okS1zbl+sFvXHBTncvDlfunyCpLDc3l5GB4cFAOqI17Qbp/jErosFHDexsJ9uy6PVDbJ
         yrdJBBGI/O1uilEZTZtBS5dJlQRitFtH8Q8Gt7Md2lhN5cOLv2keuonYi8+pwYpJzjiH
         STGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZL9Xn4vJ1YAE0z3FDDkhh5/7TEmraDYuidhU9WAofIM=;
        b=fuxEGC+4MOPYejPpX4bAHjOzjwFLE0u/nsQNQZl+bayNaaOitZUBCBRbfhugzWPoC6
         uGnJDPiG0Vf4GZHJZHTlDJxR2631FPBu8v5tkVEjUGBjteKqVlhAXP/OMSO3SlOjoqLj
         Ph0qbvRyV+WUhKNYlzLrad4MtJBDXARhxdp8wVixfZO/ANkrlyqGTZ40OQXnwBi629Fo
         9sNJ7EhgljNUjbrVSMZLWlxpCgtU3s4MwZ3G2rlUfVYKo1EsDs4xTzMJbF5L2ofIzh8s
         7HwsfHxnHByC5Tu0XnqVOjNUSPWYozzzJCLdgFdUbDDrA685dSo2FCFEBUC6oDN1D2k2
         SW6w==
X-Gm-Message-State: AOAM5308fCRoW8wrIPgCagtgWd6MPFcKbNtPfLg5midR1aOIilXlX+1A
        j6ocYw5zQ79tZZqVxdx17vGh4TeWbUH9cLJL
X-Google-Smtp-Source: ABdhPJxkPtqm0Vf/zqq1pXj0t1gsoxq3YhP0Z4tnycUNZpQP+LDRabQ8ngZ4XNvPxyN26n3xouTpCQ==
X-Received: by 2002:a02:1183:0:b0:314:4120:1fbe with SMTP id 125-20020a021183000000b0031441201fbemr27775986jaf.129.1646266865840;
        Wed, 02 Mar 2022 16:21:05 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m1-20020a0566022ac100b00644bad95365sm355190iov.39.2022.03.02.16.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 16:21:05 -0800 (PST)
Date:   Wed, 2 Mar 2022 19:21:05 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     tytso@mit.edu, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: [PATCH v3 09/17] reachable: add options to
 add_unseen_recent_objects_to_traversal
Message-ID: <cebb30b6678497529f949d539e9d8a2910662067.1646266835.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646266835.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1646266835.git.me@ttaylorr.com>
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
index 5ba4fc9c2c..1ef333717d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3951,7 +3951,7 @@ static void get_object_list(int ac, const char **av)
 	if (unpack_unreachable_expiration) {
 		revs.ignore_missing_links = 1;
 		if (add_unseen_recent_objects_to_traversal(&revs,
-				unpack_unreachable_expiration))
+				unpack_unreachable_expiration, NULL, 0))
 			die(_("unable to add recent objects"));
 		if (prepare_revision_walk(&revs))
 			die(_("revision walk setup failed"));
diff --git a/reachable.c b/reachable.c
index 84e3d0d75e..0eb9909f47 100644
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
2.35.1.73.gccc5557600

