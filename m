Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB43AC77B7F
	for <git@archiver.kernel.org>; Fri,  5 May 2023 17:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjEER1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 13:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjEER1h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 13:27:37 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F009317FDC
        for <git@vger.kernel.org>; Fri,  5 May 2023 10:27:35 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-55a5e0f5b1aso19590407b3.0
        for <git@vger.kernel.org>; Fri, 05 May 2023 10:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683307655; x=1685899655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9EVx9HnW7dXwyAtqqExh5H1XEFTOiYX7/br8bkQRUYE=;
        b=HKC+Q8uIyuUgwss0yi/E1Ww6L20c5PYzg9Lo2F9g+fIDHkxsEviRCtzMukJErpcOxW
         BOKnEOhIImhONtDKL4IdMF2aZUciw+LmWH+ae6UrGHxjcOSsppX5QCIeec44WVNuwwyo
         hTPKwFx7SmQU1Rts39tLq87XzWCLsyM/vjkaSCpVgZV5FZdDFmczwPsNUkRjVB1MQKxa
         r6PnX7YW/ObaC/eQD0xtMlHdRGnM4qt+4zW2J8mrFR6wa6aXqmPdV0rl+FOXhdS7hToa
         eXvJszu6H1i+8rb1Wcc0zMXJDDBRR/4ntwT6yL8FSXLkhwgjmvV/nfEivpX+SYYHSq8U
         WoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683307655; x=1685899655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EVx9HnW7dXwyAtqqExh5H1XEFTOiYX7/br8bkQRUYE=;
        b=i/MWyTo48lsOmiwNSKwaFglUtwG0stzTOhv8Y5IPAyxlKRoszewBgZ+2qCdxMwAGzL
         h6vU6pZOcogJ2HrxOoaS9ibXJ4njb4+gVAGWYAhORGaWoVBcPoOQoqaYXcMwZcF4j2xg
         0p0UosOF46+9Uu5Dtnnr53fEZyli5sVd7wNp+hjgC1L3f9yFKmgMFVf0g9cu8GDBrixq
         BlXpO8JfFoBzJztXMXwhi21rtafbJlIac1T63UMWYQ0ye4zOqW+0+Vk9c2c5y9u5ZjZs
         NwTPFOQHqjh58oBFQRmk6woWIMKXr1JtwwdEvQLkBZQwptungzRUIJ4hQ/QDzhmgQv8n
         5QPQ==
X-Gm-Message-State: AC+VfDxfwcundN2KBfdneSurczfxSz6ngdYYNdB8JKZGhRIPavqKvgqb
        ityRG5irilF6gYIehnYevE6d4Q0XhLxPwWrwUg/95g==
X-Google-Smtp-Source: ACHHUZ66MmyWBowFVYfyTWzyMOPKMjkLeM58ob9Pit6zKU30dEApTBlHmP10Aa6KaVMtnGt5js8XVQ==
X-Received: by 2002:a0d:f346:0:b0:55d:820f:11b7 with SMTP id c67-20020a0df346000000b0055d820f11b7mr2222784ywf.32.1683307654971;
        Fri, 05 May 2023 10:27:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n1-20020a0dcb01000000b0055a503ca1e8sm579655ywd.109.2023.05.05.10.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 10:27:34 -0700 (PDT)
Date:   Fri, 5 May 2023 13:27:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] pack-bitmap.c: extract `fill_in_bitmap()`
Message-ID: <a3a15224390e90655f8ec443158df447f9d37184.1683307620.git.me@ttaylorr.com>
References: <cover.1682380788.git.me@ttaylorr.com>
 <cover.1683307620.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1683307620.git.me@ttaylorr.com>
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
index e0fad723bf..5d2cc6ac96 100644
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
2.40.1.478.gcab26587e8

