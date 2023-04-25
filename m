Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5D8C7618E
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 00:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjDYAAc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 20:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjDYAA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 20:00:29 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED44C49FD
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 17:00:25 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-54f8e81c3f3so73941977b3.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 17:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682380825; x=1684972825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ATj/R9dos6SKkllUvlDuBr/LmjTsQyls7PW6rf0ofwE=;
        b=BSSt75xo4I6S16E7AQTDOBXwjHwnjOmX7QPUgbF0lIbFqO3FA4l7bv8LVgcAO8tGTK
         PAM8rG/fpkCkQrAnLllQgWbU32fwshcoko85WjAsT8nELPjiB6hC6n2GHW1FZZU6zk1b
         //Jq9ZEk38Fz4Hnl6ZnRgtKxgB5I6uE5pFWdUdswokoKuAEral/CLKcZqD0IKiLQZS7P
         xselFLfyRuzvWE7i1f8opJ5iGsGaqKvovOvaTptcgVq5qP1uvXR+yrFKEhDmASarqvJu
         x3GHYxwWFdaoY6Kp950CV3IYvrBqmoxMLqhhve5DqOKmuIhkYnfiAXXrcwDjuTgzlfqg
         oCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682380825; x=1684972825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATj/R9dos6SKkllUvlDuBr/LmjTsQyls7PW6rf0ofwE=;
        b=lODrCYkGLNF/Il+kHtPye8mnylLfJ820ssVSqqZtulcDBbFEg9qF87eGmEY098TgKg
         fy5qNnKnr5YYB66fT25AsVI6PdtFQiLyLsuGKpF/ZGsxBB1qDODRh5CKgLLFx/fbiKMA
         KzMfBshrbjDE9V7kc60Uvp9j7RszxmDSjDARL5AbCTc1UzztW7bxR8d8bzDip3F5tuIy
         YCpn2brlolT03gD9ZGcJSE5wEB19J/q8btsYWo7cZeweG56T9hk5z2Ud862NVHWsefXa
         uJ565zFrEo/d/QO6FtyUf6sJPyLBw5T4d08VKlSj8bs+sNhIlJDz9820DQW0zy3BPDBl
         5Xng==
X-Gm-Message-State: AAQBX9cPbBsUp8rqyVU1ayWNeocz7GzhEA+UHpQIjWbVK8LDra1C1diN
        TQ6QfiPgj3zoH2K8X0zHkE0MdAtWMN5aPny+hYk/7w==
X-Google-Smtp-Source: AKy350Y8g+8esqiM3W5PZtreZmP6ch15S9UPcPUSgRB1dihWOHixf0o1MiEZ1pT8t4mWjzTQiQJrTw==
X-Received: by 2002:a0d:d307:0:b0:541:9f38:ff48 with SMTP id v7-20020a0dd307000000b005419f38ff48mr8816110ywd.47.1682380824981;
        Mon, 24 Apr 2023 17:00:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a11-20020a0dd80b000000b0054fb975df99sm3244487ywe.18.2023.04.24.17.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 17:00:24 -0700 (PDT)
Date:   Mon, 24 Apr 2023 20:00:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] pack-bitmap.c: extract `fill_in_bitmap()`
Message-ID: <7624d3b5ba0415588a924aad2b855088e3d2028b.1682380788.git.me@ttaylorr.com>
References: <cover.1682380788.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1682380788.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To prepare for the boundary-based bitmap walk to perform a fill-in
traversal using the boundary of either side as the tips, extract routine
used to perform fill-in traversal by `find_objects()` so that it can be
used in both places.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 66 +++++++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index b2e7d06d60..046240d072 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1040,6 +1040,41 @@ static int add_commit_to_bitmap(struct bitmap_index *bitmap_git,
 	return 1;
 }
 
+static struct bitmap *fill_in_bitmap(struct bitmap_index *bitmap_git,
+				     struct rev_info *revs,
+				     struct bitmap *base,
+				     struct bitmap *seen)
+{
+	struct include_data incdata;
+	struct bitmap_show_data show_data;
+
+	if (base == NULL)
+		base = bitmap_new();
+
+	incdata.bitmap_git = bitmap_git;
+	incdata.base = base;
+	incdata.seen = seen;
+
+	revs->include_check = should_include;
+	revs->include_check_obj = should_include_obj;
+	revs->include_check_data = &incdata;
+
+	if (prepare_revision_walk(revs))
+		die("revision walk setup failed");
+
+	show_data.bitmap_git = bitmap_git;
+	show_data.base = base;
+
+	traverse_commit_list_filtered(revs, show_commit, show_object,
+				      &show_data, NULL);
+
+	revs->include_check = NULL;
+	revs->include_check_obj = NULL;
+	revs->include_check_data = NULL;
+
+	return base;
+}
+
 static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 				   struct rev_info *revs,
 				   struct object_list *roots,
@@ -1105,35 +1140,8 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 		}
 	}
 
-	if (needs_walk) {
-		struct include_data incdata;
-		struct bitmap_show_data show_data;
-
-		if (!base)
-			base = bitmap_new();
-
-		incdata.bitmap_git = bitmap_git;
-		incdata.base = base;
-		incdata.seen = seen;
-
-		revs->include_check = should_include;
-		revs->include_check_obj = should_include_obj;
-		revs->include_check_data = &incdata;
-
-		if (prepare_revision_walk(revs))
-			die(_("revision walk setup failed"));
-
-		show_data.bitmap_git = bitmap_git;
-		show_data.base = base;
-
-		traverse_commit_list(revs,
-				     show_commit, show_object,
-				     &show_data);
-
-		revs->include_check = NULL;
-		revs->include_check_obj = NULL;
-		revs->include_check_data = NULL;
-	}
+	if (needs_walk)
+		base = fill_in_bitmap(bitmap_git, revs, base, seen);
 
 	return base;
 }
-- 
2.40.0.380.gda896aa358.dirty

