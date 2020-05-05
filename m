Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9EAC3A5A9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 01:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 728E6206C0
	for <git@archiver.kernel.org>; Tue,  5 May 2020 01:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="TLdVOFKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgEEBN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 21:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728025AbgEEBN4 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 21:13:56 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAC0C061A0F
        for <git@vger.kernel.org>; Mon,  4 May 2020 18:13:56 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x15so81693pfa.1
        for <git@vger.kernel.org>; Mon, 04 May 2020 18:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hMHhlnIpEEVGwdI31E60N9MAO0ZW52wwNAwbjWLYaws=;
        b=TLdVOFKNmbbPjtGuvJu7WKcA4ebFdMjLIkZq9Qe1qud0nIezJLjCtP2KNx4Yj5BfQt
         pzQphNw1M634YQN16BT24A/6rXdSXfXbERaI4ZrY2r9dUvg9QmId9M1dVOW4GKn6MaRg
         QxBvWFWIlAClR9TW5Gn4Od/Q8g8g1F0/9z1cKnh3/WM7DCz/ladfBsNzKovsu28fYN3E
         AQmE1afQI/BCO/hVhJknrZLbYYHEqPwqy1toC0aDBB54zXkBpKn9MKQNYg2rtXVhFEHv
         7DVWwN2RWfnk6oyN+j7xWOx8oPGO+MHyQRcqFKvzR3IImvFM9V1nmB+W5R1Q9DlM9dvi
         uzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hMHhlnIpEEVGwdI31E60N9MAO0ZW52wwNAwbjWLYaws=;
        b=TxRSZ4HR5XxgT9y8uZn8gzSr+Ho9uFAD/6VXlVbD2kO8vrWqxnrW/r2kgWD5w60UPr
         naRyqSRIdoPig3UruPeSNSf/08Ax/2wQAcQTnysDnWf1SoqE6lOUgzsTwlQ106KOi1wN
         n8z8MZ0fkXtcRExTxjvOQM9Ab+s9z/pfg32HVLCvga1JAh7N1giqmYDwuVl5saB1wASe
         2/inpneS+ZM2bnl2roK7CfiPCGwlegcbGsbb/GIPN+bQiid4UAn8US3bPiVAyFgzN2mG
         VDd0yoUtoIkpcwNoxr56dTN//sh+7tV2TpWlGZ4BSxtT0dOSbhQNB+2+8wZH9trmeHrf
         pzcg==
X-Gm-Message-State: AGi0PuZs8tTs7xgsD0/2D56Y9n5KLjw9AF28i9v8l8rjI8VbBrfkqMyk
        rOpF9ICd16es1tY7o23rcXCJ+t+4JaCe2Q==
X-Google-Smtp-Source: APiQypJ0Z2yvp5HNzSi6IiQJlc7WSmwvzTa9T1iL5FnKcmsMHsWSiW6lew3lgAB7KSUCVuZFhOTk3g==
X-Received: by 2002:a62:3784:: with SMTP id e126mr713192pfa.303.1588641235964;
        Mon, 04 May 2020 18:13:55 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id y6sm223377pjw.15.2020.05.04.18.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 18:13:55 -0700 (PDT)
Date:   Mon, 4 May 2020 19:13:54 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH 6/8] commit-graph.c: simplify 'fill_oids_from_commits'
Message-ID: <7e9d8c1f1a124171ebb5b4d874718053d1c9064a.1588641176.git.me@ttaylorr.com>
References: <cover.1588641176.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588641176.git.me@ttaylorr.com>
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
index 5c3fad0dd7..24c2d80935 100644
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

