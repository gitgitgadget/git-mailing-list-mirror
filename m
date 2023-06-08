Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DD7C7EE29
	for <git@archiver.kernel.org>; Thu,  8 Jun 2023 16:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjFHQZg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jun 2023 12:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjFHQZd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2023 12:25:33 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420A32D4A
        for <git@vger.kernel.org>; Thu,  8 Jun 2023 09:25:30 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-565de553de1so12046397b3.0
        for <git@vger.kernel.org>; Thu, 08 Jun 2023 09:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1686241529; x=1688833529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zwgnw6KsifAzOY5ff53X96Sx4hqydsRhJvR2wrmYki8=;
        b=A/gh3LaRrRl71Sjn3hbP9cKxC/1pkwRJQObfOnXdeSJlXQ9NmZW22pQkzDqRtNUUmY
         9juQW/qy0zpEaT6pPpS72zaxidu8Yey1XO1cM8fUJSRTERnFdXML0WQopuTgNkQXDjvf
         4Z0cObqUwr2+1ppOGye6I6VRMpzJHV1QKzhSTvohYXNtdMAAu+nlN7sbSwN8NA+046vS
         i/1fHQYYqxNxUpKpUClEL/c83VEJPN+TZLeSlOtU8peEoDnv89wvmC6sphAnY2p/6Kpn
         MmIjrSHgpQLNc3rL+/jO8x+iXgzCjVvXdtcQHpTtzQy4t8i+1C8LY2O1Z3RIlmVDofoR
         478A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686241529; x=1688833529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zwgnw6KsifAzOY5ff53X96Sx4hqydsRhJvR2wrmYki8=;
        b=XglPTcWGUTJpJ1Zq8gW+SPgQzZokLV+wKd9VmSgtVhwDMPL1KRQnkDD8kxAJQFuEIg
         1/7aU8FlSfrstwfR/hyYj58f9wrBI6N7lkwfE75WtBVk8yalxULi3BruoFGV8ytR0h/D
         xMXI9MEf+pNiDSVa4TDhEGX6ju6H9UYN7XbKvquNDtiu8B0ZpqdOrA+t/jGWRkKKHYdC
         isjDRHQcQJd4k6iwzEWYS+gl5GAWAfqIAs55YN52Swab5NBE82GJQn1P9oKZeBZVJJC2
         MiBAzhQpKquVDTLJVTYxVIYh8RBJnGFGJAhrwwGI6bBPA2gKIyX6twpX/X53cpg2s8Dl
         fDPg==
X-Gm-Message-State: AC+VfDzc7a6vxPT0bNMKgJ0Jt48DCHk4g14MY7k1naYE+ep1UCv5oKhj
        dvc/c/tsyL5eO7vFGcjELhRMIkNTEE1fnrCo6Nfd74ET
X-Google-Smtp-Source: ACHHUZ6b+pSv4SHqioE94dj5WhNQndnYcEm5/nCqLC2KQI0PwmljmkhqrBY0fWIKg7lzBFrFwIxbPA==
X-Received: by 2002:a0d:ebc7:0:b0:569:f244:35a1 with SMTP id u190-20020a0debc7000000b00569f24435a1mr331256ywe.1.1686241529292;
        Thu, 08 Jun 2023 09:25:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z63-20020a0dd742000000b0054c0f3fd3ddsm22041ywd.30.2023.06.08.09.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:25:28 -0700 (PDT)
Date:   Thu, 8 Jun 2023 12:25:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 2/3] pack-bitmap.c: extract `fill_in_bitmap()`
Message-ID: <fa67382e21598e920737e2dd0e6ca929be025939.1686231639.git.me@ttaylorr.com>
References: <cover.1682380788.git.me@ttaylorr.com>
 <cover.1686231639.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1686231639.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To prepare for the boundary-based bitmap walk to perform a fill-in
traversal using the boundary of either side as the tips, extract routine
used to perform fill-in traversal by `find_objects()` so that it can be
used in both places.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 65 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 29 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 999f962602..c1a9c70061 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1043,6 +1043,40 @@ static int add_commit_to_bitmap(struct bitmap_index *bitmap_git,
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
+	if (!base)
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
+		die(_("revision walk setup failed"));
+
+	show_data.bitmap_git = bitmap_git;
+	show_data.base = base;
+
+	traverse_commit_list(revs, show_commit, show_object, &show_data);
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
@@ -1108,35 +1142,8 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
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
2.41.0.3.gb80d17c938

