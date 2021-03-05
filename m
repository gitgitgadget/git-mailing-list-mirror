Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4DEC433E6
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 15:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C673A6508D
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 15:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhCEPWM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 10:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbhCEPVy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 10:21:54 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34BFC061574
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 07:21:53 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id 18so1973506qty.3
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 07:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/U3pYSgUtgqQM+PBSge337RhCEGhTiHYrdje1g3WRM0=;
        b=BnZLdYN7TDPt2UWrvwUphpSC44OeJNxFi7lZJ/zfuK+grHr6qMWLfVZURP7yNLRx4Y
         OKebTKbT8OHFk5erhcz1CFCDtsCrSxnEk6pW9XpYI8i/9mob5aD/3e5a5Bq4iGBczdpo
         nKn2su5sRacao4TvHaSs80cAoXM4rgcU1Zbx+FYwSVb7Asv9Xa/88b4naWBWcBwDNl1Z
         pBkjlWyKlEZkgUdkbt97VWt42Jx2gISgUeOpnAf+Giy28QQiOUDtImKk+KkPcAlUKRie
         DxA15Vtufmw8Knf54GpAMMXix7hWuX1OCQrp7CMYmplOz9GQHHH6+6Yrdj6aqngDpD5B
         qeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/U3pYSgUtgqQM+PBSge337RhCEGhTiHYrdje1g3WRM0=;
        b=WOeAVv1GRRTn/3rKPXUjygiW5KX3+tIgE4jRZazxS6UuKNL4bZb7RB6GAtVtiqt8N5
         48zJkVrGcpO+YXdi6Se4TJHfpzl0iQOL0WCkB8w7iZZTdNvZCjDq3fQB1opkqSVFzjm2
         ICQOVE90bkx4fXsAZOBUYxx0nmI59E05oT0lwsy3em8sm5QCXtNWynbDJcLw5Y7VkNFz
         OhyjSv5scHqEkfO2hdQPiy+BZ17rFqEsCezkBOM8L6Pf8iHSawu8xVigzUUhRD6jCZU5
         A9KM576a6MMvE7X9fsj7tE0sCSemhbJVdBTtSGLFoD/oOt/FQHR0fXaBuJinU3K5w6GR
         leGA==
X-Gm-Message-State: AOAM532znQI1RNAtQPh6i6i0eqwgVAShn87MGEH3Lq8rKw6LYTP7dVUQ
        8goeyvWpq2isQcZ7V9vnQ+qJ3QqoVL4EOIDq
X-Google-Smtp-Source: ABdhPJwTe7gp+zhLaGkXDsss8+yAJK1zOD6JSxqhKJksp9XsuQ+KtqpM/U2lSIkjQrfMJ+8pb3Owsw==
X-Received: by 2002:a05:622a:506:: with SMTP id l6mr9234188qtx.134.1614957712790;
        Fri, 05 Mar 2021 07:21:52 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:4ce8:219:f731:dbf5])
        by smtp.gmail.com with ESMTPSA id g11sm1992651qkk.5.2021.03.05.07.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 07:21:52 -0800 (PST)
Date:   Fri, 5 Mar 2021 10:21:50 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
Subject: [PATCH 3/5] builtin/repack.c: assign pack split later
Message-ID: <60f13524bd602517c41554898b213161e9d603ce.1614957681.git.me@ttaylorr.com>
References: <cover.1614957681.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1614957681.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To determine the where to place the split when repacking with the
'--geometric' option, split_pack_geometry() assigns the "split" variable
and then decrements it in a loop.

It would be equivalent (and more readable) to assign the split to the
loop position after exiting the loop, so do that instead.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 4ca2f647b4..21a5778e73 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -356,8 +356,6 @@ static void split_pack_geometry(struct pack_geometry *geometry, int factor)
 		return;
 	}
 
-	split = geometry->pack_nr - 1;
-
 	/*
 	 * First, count the number of packs (in descending order of size) which
 	 * already form a geometric progression.
@@ -365,12 +363,12 @@ static void split_pack_geometry(struct pack_geometry *geometry, int factor)
 	for (i = geometry->pack_nr - 1; i > 0; i--) {
 		struct packed_git *ours = geometry->pack[i];
 		struct packed_git *prev = geometry->pack[i - 1];
-		if (geometry_pack_weight(ours) >= factor * geometry_pack_weight(prev))
-			split--;
-		else
+		if (geometry_pack_weight(ours) < factor * geometry_pack_weight(prev))
 			break;
 	}
 
+	split = i;
+
 	if (split) {
 		/*
 		 * Move the split one to the right, since the top element in the
-- 
2.30.0.667.g81c0cbc6fd

