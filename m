Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0860C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 01:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF669206C0
	for <git@archiver.kernel.org>; Tue,  5 May 2020 01:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Vh8f6X2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgEEBNi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 21:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727820AbgEEBNi (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 21:13:38 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385A1C061A0F
        for <git@vger.kernel.org>; Mon,  4 May 2020 18:13:38 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a31so277275pje.1
        for <git@vger.kernel.org>; Mon, 04 May 2020 18:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yn/llej/jTolC/XlId/Yu+ZvA9EsPYY1FRqM7XVwbno=;
        b=Vh8f6X2MYJxyrY7y3AC6eU3iIHEBfPnkSI+arqU+pU3uitz6coEUwkycrMgm/80sf5
         o7nhr5gbs+dAajqAW/9FxN8NgGvc1xmynHAKUWjaxwcDtmpmgTMNrlWB2MnlBYNRDmmK
         7H++EqereZaOR7a1fkwmN9x2zVApYbS/xEE5WhC9efpVX5nmbHyqHYZXQMoXiFDQWJm/
         6G2Qh1OSRujZq9CnUHHTrE9ndouz5HVjj7YoFCUiq3a3XJl6hxX/ApqgQQlkiLOPL9wh
         bvGhiYIGX1KYUmWHG+SFasic0NVHY7A+xC/6AljkJyw51RXER3qsWS7lkteO8CYbX0bg
         Jezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yn/llej/jTolC/XlId/Yu+ZvA9EsPYY1FRqM7XVwbno=;
        b=FkXJdhRlV3BpgdKkF+8E+QLAN5XiyKZFpIe1vc1iwzRRAZ4odSV5ajzMfdfOAtgHRY
         AQhBJ+7r3wzwDNLo2A47wj7sMNSOZ2eHiNJruaQj6uMarvcMgycxmPa8jE3gzaDE7Ekv
         Z4b8kBVWMyDulpjqs855ph/RTm7Xz+Qyh2IoBBkYZ20WWyJoWAcDDcsxKzw81omIdw9a
         ulgd2TylBfYyiRP3rnRRuquMGFtgkMvjvm4qRfoAzgDOr5ybMm3dyNoBfy43uqqpsgiG
         1WtLe8nX5NbERfESBpVUQOOI2Rs4n4Na1cGOPyfMAuslAWmYSNrgxUUfvOAyMMN44rF2
         DpOg==
X-Gm-Message-State: AGi0PuY2MEHP0YzaXwUwmdcTzOmbh9o9390cKh4m/A09zBVEu3NmrcIf
        AEi0TtJZObZAonvzvbPRkzV6ai+NqafqEA==
X-Google-Smtp-Source: APiQypJ8tJgSlUHn558+s7c0C0m+6F01it30fQtDCUAgUa1/HhGc8KAmyTQSANDLZ2rl4yHbnbjOcQ==
X-Received: by 2002:a17:90a:7e4:: with SMTP id m91mr101771pjm.155.1588641217375;
        Mon, 04 May 2020 18:13:37 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id y16sm318989pfp.45.2020.05.04.18.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 18:13:36 -0700 (PDT)
Date:   Mon, 4 May 2020 19:13:35 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH 1/8] commit-graph.c: extract 'refs_cb_data'
Message-ID: <43286c3c45b2dcef8d9d39b4998c17f364eb1060.1588641176.git.me@ttaylorr.com>
References: <cover.1588641176.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588641176.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In subsequent patches, we are going to update a progress meter when
'add_ref_to_set()' is called, and need a convenient way to pass a
'struct progress *' in from the caller.

Introduce 'refs_cb_data' as a catch-all for parameters that
'add_ref_to_set' may need, and wrap the existing single parameter in
that struct.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 6dc777e2f3..00da281f39 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1318,13 +1318,17 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 	stop_progress(&progress);
 }
 
+struct refs_cb_data {
+	struct oidset *commits;
+};
+
 static int add_ref_to_set(const char *refname,
 			  const struct object_id *oid,
 			  int flags, void *cb_data)
 {
-	struct oidset *commits = (struct oidset *)cb_data;
+	struct refs_cb_data *data = (struct refs_cb_data *)cb_data;
 
-	oidset_insert(commits, oid);
+	oidset_insert(data->commits, oid);
 	return 0;
 }
 
@@ -1333,9 +1337,13 @@ int write_commit_graph_reachable(struct object_directory *odb,
 				 const struct split_commit_graph_opts *split_opts)
 {
 	struct oidset commits = OIDSET_INIT;
+	struct refs_cb_data data;
 	int result;
 
-	for_each_ref(add_ref_to_set, &commits);
+	memset(&data, 0, sizeof(data));
+	data.commits = &commits;
+
+	for_each_ref(add_ref_to_set, &data);
 	result = write_commit_graph(odb, NULL, &commits,
 				    flags, split_opts);
 
-- 
2.26.0.113.ge9739cdccc

