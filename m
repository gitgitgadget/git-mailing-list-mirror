Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E317C77B75
	for <git@archiver.kernel.org>; Mon,  8 May 2023 17:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbjEHRi0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 13:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbjEHRiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 13:38:16 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9244F5FF7
        for <git@vger.kernel.org>; Mon,  8 May 2023 10:38:11 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-559e53d1195so69305267b3.2
        for <git@vger.kernel.org>; Mon, 08 May 2023 10:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683567490; x=1686159490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R9FZiwSdorLoMYpq4R8bXR+hymQnnjYbO1isQqpVQtk=;
        b=w2Rdg5qoYZoKtVgfQ+th5PewHbYEcChMbRlRIgKX4cvWr/N5bg3ZCSs8Kjd3TLRvp5
         qXQQ/a1Fc24bfigGi72nKAAwbEeYEi30FHR76sLbU3q0NwUviU3qH3L/GHqH/SyF2GZW
         32Tfzn+GP7SjQqwjH/Z+x9O+hLAX3L19am0Fjda4l1G3xIc7f1SbE/X4EZSfLoHzzGga
         9TaDm+mWpXpXHoJM2bZ20LWhrOP61KZY27MYTSSd4Eo7OKTOQZPgDjgFqYdIcZjHTkFc
         dFJaTP1WT1bVjJmCWwN0TlNQKgCXudtXSHfQi+uyCSrH0Qau1L5d17xv/fV6wQ1viOoP
         +6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683567490; x=1686159490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9FZiwSdorLoMYpq4R8bXR+hymQnnjYbO1isQqpVQtk=;
        b=EgJt0AzCTfIvfV7F/80p2E2Kbz4fOqRqzPXaRqZGGuxnEUzu/9rqGbu6LMj6g7rvHt
         N+BcfQB7tBjUup1ggPQmFL4Bd6vlPyHgeIHISAhHiAXLllJ3uiLoS0W9MXbVh4tq9/CZ
         KYLb8cpR++TKaww0wfN6XKmST+59UZHcTPbNGOY++ANDm7MStAcgloRnzIr9VBNyRqhX
         J9HDO4SYB6P8nzKkaGddjQtfnC3O/nfFoDzKFcPkYuyM6nOYu5D7BKn2Wb0n66T6hX7U
         xhjYJGut7A1gRg0HzWrisCAP8Vg6UEUl6i93cL1SW138TZlo57/w7U4RnVpEYaS9hDph
         XYlA==
X-Gm-Message-State: AC+VfDyCX0w07eQ3JvW1FgfCY8eLxH4pi+K6oTwjcPv3d76hMbfRKBML
        7v4qADCNFEQtbe0rS7f1AsK+laZX/VwqIKWM3Qt5qg==
X-Google-Smtp-Source: ACHHUZ6bNY6Qt4iRKuf1t6FZI8MKZ96ctadFgWBFxIi+npDdzkGDAzqdBZlhrwYXrSBYjZcXm3+phw==
X-Received: by 2002:a0d:d8d4:0:b0:54f:adeb:9898 with SMTP id a203-20020a0dd8d4000000b0054fadeb9898mr13294276ywe.10.1683567490618;
        Mon, 08 May 2023 10:38:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y1-20020a81a101000000b0055a07585a91sm2669195ywg.11.2023.05.08.10.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 10:38:10 -0700 (PDT)
Date:   Mon, 8 May 2023 13:38:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/3] pack-bitmap.c: extract `fill_in_bitmap()`
Message-ID: <e7b30490dae51b1375545ba19561900ed0f340b7.1683567065.git.me@ttaylorr.com>
References: <cover.1682380788.git.me@ttaylorr.com>
 <cover.1683567065.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1683567065.git.me@ttaylorr.com>
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
2.40.1.479.g8f2b93ade7

