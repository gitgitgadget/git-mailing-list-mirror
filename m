Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898B4C47254
	for <git@archiver.kernel.org>; Wed,  6 May 2020 00:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6779B20752
	for <git@archiver.kernel.org>; Wed,  6 May 2020 00:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="MDfg/nzF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbgEFAHy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 20:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbgEFAHy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 20:07:54 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F5CC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 17:07:54 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x10so247059plr.4
        for <git@vger.kernel.org>; Tue, 05 May 2020 17:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZLtBzuI9rDePR+08aciWXpR6Rg+IfC1H1o29cmmEwO8=;
        b=MDfg/nzFLJ15TuFiOpAuxYlYzN3S4eN2pUMcRBjWSC4RCMx15F8vxJAcfiYgBHfo7Z
         44XJLnD4Sj+dHsTzQEA+P64MD4++9SZ5GxzQPuBLsqNt9A6egWMqUXxNQaGpdIlConfj
         voJqdguEB+9F3FkgxlfpbTZhLHZLrwJ7LDRuJhTW4XrC9bH1KZVbsKc8uf/c+XKkUYmz
         mLa8flopGyizYykcgYCT/W3N8mL9NHSrOyOkdg1Rf9vQl4Qu/C1jL/ZQ9/bMaXpIIo62
         T4HH/oAKqmXCaSMk8NUTHg+wdQFMtjySS+fUekcejEZ7p5CFzQmsXsqbviL3W2zvDjns
         iIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZLtBzuI9rDePR+08aciWXpR6Rg+IfC1H1o29cmmEwO8=;
        b=QFW5o04tlTy84tsUhAGhp9pmglcs/kLTrBArsvCeJaNoM1g/0aglNXlxJMlNghbkiP
         gVhIUrx4pVpKd2tx7zN3SaotQoW9XLY1sFREktdsCPJlyncTJ4xve6D+1NmuhFtzLb2G
         bhrIwU3wKM8UjzAYBkMSZcl09F13D5QujX9lwhQIrmsxO1FiovMu0uK+BDWr5zGk8s45
         gt9wD6LKGTh0yItUuOYUEm/PRjD8qtpd9Q944VBDItx5PmvOz20Pzxsby5T1QOyvnaqy
         LD9icF9H0p5Qg+7BnMz/FaXiEaYpKlR3cX0yRv7XzQLbhzY9m6hRnfFU+0DuNnKaBUl3
         Adbg==
X-Gm-Message-State: AGi0PuZzKJ87acruTBk6yBeaOTXKoHb80rL148krXt7sqyRESYCi/V6Z
        hp0dND6yuKbKWKiH520thoEUKDrcHbo=
X-Google-Smtp-Source: APiQypLsEzgo4cvCp1eo4PWE3GKeLvsy2Mdb182nwXtfxWPzzXnSVsxUZfUIsbMXaCSrDWSsKfPlDQ==
X-Received: by 2002:a17:90a:5584:: with SMTP id c4mr6102428pji.51.1588723673161;
        Tue, 05 May 2020 17:07:53 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id 28sm3064188pjh.43.2020.05.05.17.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 17:07:52 -0700 (PDT)
Date:   Tue, 5 May 2020 18:07:51 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v2 6/8] commit-graph.c: simplify 'fill_oids_from_commits'
Message-ID: <61887870c722d0934b02d7e2a94972a147dc4d3b.1588723544.git.me@ttaylorr.com>
References: <cover.1588641176.git.me@ttaylorr.com>
 <cover.1588723543.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588723543.git.me@ttaylorr.com>
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
index 2c3b5fd09d..56a4a43b30 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1411,46 +1411,19 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
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

