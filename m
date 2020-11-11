Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB55C5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CBC92087D
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="cHiUD2m/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbgKKToS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 14:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgKKToQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 14:44:16 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27018C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:44:15 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id b16so1954419qtb.6
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TZHmQ+gEVWeVWitBWD1fHXPDTy8E5OTpxkmbjVhKUS8=;
        b=cHiUD2m/U0bv+WzsVUidNHGA9uAVWvwj8RshQeGLifHpKZiIxARuE1BZffL6cWTj4P
         kCumZptrDNFYKKOyQaLu5wO43O9EVtrL9cB9sVPVtmwMfdyFD9o+RRkSouIU6Dui7qMY
         EPj/SJET12MTAYfiK2bbj7zuFo6q2yPlTptlycMPZoAosQM08RBYiyRxG+XOgFe3cGd9
         lNTBonucKi/f6mNnZTKElk0uVgMWW6wHb8UcTIOOanWEK9Fd0sYMNJXQdIABfjaq+kDv
         TqRCp1E++3C6IFfPS6LFux2CTK8dpc0usy0GKbK4ZVlbsCrHkFOpUp1wGrTrGZnjhhLI
         EAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TZHmQ+gEVWeVWitBWD1fHXPDTy8E5OTpxkmbjVhKUS8=;
        b=f3/TmwUr7sU2whD58fMxqs5BCeKX89WxWOJMYh/io5aP1BO2q4NJiHL+qm2CVEIHL2
         vu4Z2AqmV1A9zNq4XUHbV9OTqZmD0P/TfzQxL+NBd1joqz5X+vIiTQE1pqftdGQCh1a3
         Dlu13cp3d96rThgzF1SgRmiXt3CA1g9GNLY0QPOtQmDlZPomQEo3ldXn7zynYjn+BM8d
         IIKSbuikuIzBc9NqZt9QLDyfvlK3CMZp71Mmf4tBKatxC7droClQZ96wVZKxbkcNsv8W
         qhdiw1bO2GwP9g9hW2hLq4kyq1daDFUGUD19APDrc0H/EURFGlJpUkCBlfLXP9Apy8el
         KpqQ==
X-Gm-Message-State: AOAM531J8qm82xpTgduUuaCJPgBgkXqDLEteXOd2boltrScv5M0hV0nw
        YZlN8aQtaTOosk+FHGdtCwDUn9v2gIeBzd2k
X-Google-Smtp-Source: ABdhPJyH17xRKQqmJCtuOyVOTS7qblfx8knR0tR6CEwOQKAP80q/iIZcE7+1+3w7OFTiVr9bsouMUQ==
X-Received: by 2002:aed:3ae5:: with SMTP id o92mr24535152qte.265.1605123854118;
        Wed, 11 Nov 2020 11:44:14 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7ccc:9a51:1ad:2057])
        by smtp.gmail.com with ESMTPSA id x3sm3034424qke.55.2020.11.11.11.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:44:13 -0800 (PST)
Date:   Wed, 11 Nov 2020 14:44:11 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH 20/23] pack-bitmap: factor out 'add_commit_to_bitmap()'
Message-ID: <2ee47f31ab7718e3b6b0d0079f70b0a9195677b3.1605123653.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605123652.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'find_objects()' currently needs to interact with the bitmaps khash
pretty closely. To make 'find_objects()' read a little more
straightforwardly, remove some of the khash-level details into a new
function that describes what it does: 'add_commit_to_bitmap()'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 99a0683f49..dc811ebae8 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -516,6 +516,23 @@ static int should_include(struct commit *commit, void *_data)
 	return 1;
 }
 
+static int add_commit_to_bitmap(struct bitmap_index *bitmap_git,
+				struct bitmap **base,
+				struct commit *commit)
+{
+	struct ewah_bitmap *or_with = bitmap_for_commit(bitmap_git, commit);
+
+	if (!or_with)
+		return 0;
+
+	if (*base == NULL)
+		*base = ewah_to_bitmap(or_with);
+	else
+		bitmap_or_ewah(*base, or_with);
+
+	return 1;
+}
+
 static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 				   struct rev_info *revs,
 				   struct object_list *roots,
@@ -539,21 +556,10 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 		struct object *object = roots->item;
 		roots = roots->next;
 
-		if (object->type == OBJ_COMMIT) {
-			khiter_t pos = kh_get_oid_map(bitmap_git->bitmaps, object->oid);
-
-			if (pos < kh_end(bitmap_git->bitmaps)) {
-				struct stored_bitmap *st = kh_value(bitmap_git->bitmaps, pos);
-				struct ewah_bitmap *or_with = lookup_stored_bitmap(st);
-
-				if (base == NULL)
-					base = ewah_to_bitmap(or_with);
-				else
-					bitmap_or_ewah(base, or_with);
-
-				object->flags |= SEEN;
-				continue;
-			}
+		if (object->type == OBJ_COMMIT &&
+		    add_commit_to_bitmap(bitmap_git, &base, (struct commit *)object)) {
+			object->flags |= SEEN;
+			continue;
 		}
 
 		object_list_insert(object, &not_mapped);
-- 
2.29.2.156.gc03786897f

