Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479F5C433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 442C920675
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="uYd1qV0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbgEMV7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 17:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730305AbgEMV7u (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 17:59:50 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD34C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 14:59:50 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id n15so141999pjt.4
        for <git@vger.kernel.org>; Wed, 13 May 2020 14:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ond+lafSLBQ7TvXkAbi/1y2V6GAD8p5h9CJcjrERjFc=;
        b=uYd1qV0g8wwa4yuV3Dsmex4P2szPVnETpIsm0zLkHAzxoKiG0iMPkzML1OopK1yl0l
         /0QPALFKDMQwi+F4WKUHfoumRgIgDdXHwD4TnN9LLaZb7/JfAElaFKD7ZQfyzZWsa6hA
         WPM74WSbSh0U/synOt5W7QoxXHZCf1MYq3NIE9kGDRQfHSxihQiniiwgjBC6VfUk+v3S
         4uzLYfJncSQ/2uaKyxLUbFjOnuMxqVxvdVv23hXwOP0AciRYEEDbE0TNlqPNy4syrPhn
         /36FHdKvH1TghbE1QJSasWHYVXG+61GDmkAvL3/b/c3DxL16JNLUNxvZimktS2AEfKqV
         eZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ond+lafSLBQ7TvXkAbi/1y2V6GAD8p5h9CJcjrERjFc=;
        b=X9i44DPhP+sXAIW4t4cbZjoDJhYrjnH93AGpwUcSkL857jhADCSbNpxgoU0ekF/QD9
         Jr0SxM+1HdXCNzJH0ULk5Vq+JnbdgHX8/Msc2s3eRk8KlERjgaC//qZuPGAThgCCwhYE
         rZXqzrOF0KJifIZVFQ2DBYlE+3N+K/D4HKPvYajTUTLuJ/eRhkhE3SNW/hxgDB7jAk3B
         ONLDEVXVOln1j0ZzTksA0386/nTxqNCHRiqCHtWUP2WuvIgpNgSP5w5VvpFrpSGXMu9Z
         t66lbXslsiFLBua7NbzNJ4qRUn6tI2loTSSzf21uWK3rPcjLmn/OWI2CGf9+8jd2K128
         5DDw==
X-Gm-Message-State: AGi0PubYh7j8OgDi56bG8qfr15eOP8B6Im2jM/3/oMC46sb7ExDHQ26l
        4NU05aegeuCQnQLi9m1du5dVhr2zIjI=
X-Google-Smtp-Source: APiQypJi8Ik2fTNF2zYMhi0Rk5LcQcUf5ev63Y06t0OTSOxoiMb3sFlLckRfsNn7hqLlGOv8m2X2gQ==
X-Received: by 2002:a17:90a:2f64:: with SMTP id s91mr36601832pjd.30.1589407189708;
        Wed, 13 May 2020 14:59:49 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id a138sm460062pfd.32.2020.05.13.14.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:59:49 -0700 (PDT)
Date:   Wed, 13 May 2020 15:59:47 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v3 6/8] commit-graph.c: simplify 'fill_oids_from_commits'
Message-ID: <6afb08a927b89e8f9cc570126d50669436abcae9.1589407015.git.me@ttaylorr.com>
References: <cover.1588641176.git.me@ttaylorr.com>
 <cover.1589407014.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1589407014.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the previous handful of commits, both 'git commit-graph write
--reachable' and '--stdin-commits' learned to peel tags down to the
commits which they refer to before passing them into the commit-graph
internals.

This makes the call to 'lookup_commit_reference_gently()' inside of
'fill_oids_from_commits()' a noop, since all OIDs are commits by that
point.

As such, remove the call entirely, as well as the progress meter, which
has been split and moved out to the callers in the aforementioned
earlier commits.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 33 +++------------------------------
 1 file changed, 3 insertions(+), 30 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index e7de91f0f1..3ea70e6676 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1413,46 +1413,19 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 static int fill_oids_from_commits(struct write_commit_graph_context *ctx,
 				  struct oidset *commits)
 {
-	uint32_t i = 0;
-	struct strbuf progress_title = STRBUF_INIT;
 	struct oidset_iter iter;
 	struct object_id *oid;
 
 	if (!oidset_size(commits))
 		return 0;
 
-	if (ctx->report_progress) {
-		strbuf_addf(&progress_title,
-			    Q_("Finding commits for commit graph from %d ref",
-			       "Finding commits for commit graph from %d refs",
-			       oidset_size(commits)),
-			    oidset_size(commits));
-		ctx->progress = start_delayed_progress(
-					progress_title.buf,
-					oidset_size(commits));
-	}
-
 	oidset_iter_init(commits, &iter);
 	while ((oid = oidset_iter_next(&iter))) {
-		struct commit *result;
-
-		display_progress(ctx->progress, ++i);
-
-		result = lookup_commit_reference_gently(ctx->r, oid, 1);
-		if (result) {
-			ALLOC_GROW(ctx->oids.list, ctx->oids.nr + 1, ctx->oids.alloc);
-			oidcpy(&ctx->oids.list[ctx->oids.nr], &(result->object.oid));
-			ctx->oids.nr++;
-		} else if (ctx->check_oids) {
-			error(_("invalid commit object id: %s"),
-			      oid_to_hex(oid));
-			return -1;
-		}
+		ALLOC_GROW(ctx->oids.list, ctx->oids.nr + 1, ctx->oids.alloc);
+		oidcpy(&ctx->oids.list[ctx->oids.nr], oid);
+		ctx->oids.nr++;
 	}
 
-	stop_progress(&ctx->progress);
-	strbuf_release(&progress_title);
-
 	return 0;
 }
 
-- 
2.26.0.113.ge9739cdccc

