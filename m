Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99156C433E2
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9413B20659
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="W6JqYVxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbgEMV7i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 17:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730414AbgEMV7g (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 17:59:36 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54B1C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 14:59:36 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n18so349977pfa.2
        for <git@vger.kernel.org>; Wed, 13 May 2020 14:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ti7MUW6Tecqs14xEsP+pxdyg5BIAUmOCplteYQw06kI=;
        b=W6JqYVxQHCIHKaDnhi7K3hBs6PvmQzsc9HxLNzM0kx9Ip3EQS547q8mlLqmS3+pVZf
         03jJ+Ni0wzHRvsuDqWCwfGjAApP6STcUrdA3F+jM9VwgLz45laG4wUucJBEMQMcJPEkK
         13wmLszLJqGxTtV2N560WADFLPAqgn1cN9/yPI3cfQGThnvrEH70XmeP1jEMj6GY3jjj
         t8DGE6qQpKuhPqeV90cxmVCV6YPV6w2x6uuFRhjfpTOmueFN/WVpkO5+nWm93UThQsoF
         iFvi75cxsXhIrWwjgqxLD/Gn5SvX+DfSXy8/p4wOzuZ5N5on256QLDwCaTHp7ZrMsmqM
         ivFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ti7MUW6Tecqs14xEsP+pxdyg5BIAUmOCplteYQw06kI=;
        b=pvbGARY5PfeUv05+dNgFisiRFHJg8vj6QfiDyr0TWZoJLghWQphmUXM19/gjdDUuYu
         d6dvcGgDUUB2V8QCd/di9uDMd3iEorGZqzer/aG8aa8+dxVCjoOoE9P/a2PyvDYtlKkp
         afgOmulM5ji4NQNFSpmk+VU9XwPDtADcSV8BTPFJjV0nY19sqgSrAe3rGPDriKa0azkT
         7iV39d0H5x/f7wSnd14OZmNhAXiyXoPzs2BnuuC3ftMbcZNjmfcVCFpQDrLI52VCpmG3
         tOfgquZSznVHat0jcLrCnC8CwV03Ipldy+RDQdNEDCtQ58DNS7LtgQ0rbsXZqWby4s4w
         kQYg==
X-Gm-Message-State: AOAM533nGL7qHnFZDFtV9Hs6Z+q2HvCWIohrjgvzNZVoXqLuFb3ADPtw
        vKgo2MD5GGEP2LZVaI1fJ7yM7Pti8rk=
X-Google-Smtp-Source: ABdhPJwMqvxUeezycGqikzl6DXrsU0NrtXOXG0d5Pg1VlaZdQ3euRGAG4wtLYcPJrFNDtHqflLBhgQ==
X-Received: by 2002:a62:3303:: with SMTP id z3mr1211992pfz.88.1589407175837;
        Wed, 13 May 2020 14:59:35 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id b74sm560651pga.31.2020.05.13.14.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:59:35 -0700 (PDT)
Date:   Wed, 13 May 2020 15:59:33 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v3 2/8] commit-graph.c: show progress of finding reachable
 commits
Message-ID: <773522c745c23a4c09f5c198bcb8f33c143c095e.1589407014.git.me@ttaylorr.com>
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

When 'git commit-graph write --reachable' is invoked, the commit-graph
machinery calls 'for_each_ref()' to discover the set of reachable
commits.

Right now the 'add_ref_to_set' callback is not doing anything other than
adding an OID to the set of known-reachable OIDs. In a subsequent
commit, 'add_ref_to_set' will presumptively peel references. This
operation should be fast for repositories with an up-to-date
'$GIT_DIR/packed-refs', but may be slow in the general case.

So that it doesn't appear that 'git commit-graph write' is idling with
'--reachable' in the slow case, add a progress meter to provide some
output in the meantime.

In general, we don't expect a progress meter to appear at all, since
peeling references with a 'packed-refs' file is quick. If it's slow and
we do show a progress meter, the subsequent 'fill_oids_from_commits()'
will be fast, since all of the calls to
'lookup_commit_reference_gently()' will be no-ops.

Both progress meters are delayed, so it is unlikely that more than one
will appear. In either case, this intermediate state will go away in a
handful of patches, at which point there will be at most one progress
meter.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 9693112063..f855911320 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1321,6 +1321,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 
 struct refs_cb_data {
 	struct oidset *commits;
+	struct progress *progress;
 };
 
 static int add_ref_to_set(const char *refname,
@@ -1330,6 +1331,9 @@ static int add_ref_to_set(const char *refname,
 	struct refs_cb_data *data = (struct refs_cb_data *)cb_data;
 
 	oidset_insert(data->commits, oid);
+
+	display_progress(data->progress, oidset_size(data->commits));
+
 	return 0;
 }
 
@@ -1343,12 +1347,17 @@ int write_commit_graph_reachable(struct object_directory *odb,
 
 	memset(&data, 0, sizeof(data));
 	data.commits = &commits;
+	if (flags & COMMIT_GRAPH_WRITE_PROGRESS)
+		data.progress = start_delayed_progress(
+			_("Collecting referenced commits"), 0);
 
 	for_each_ref(add_ref_to_set, &data);
 	result = write_commit_graph(odb, NULL, &commits,
 				    flags, split_opts);
 
 	oidset_clear(&commits);
+	if (data.progress)
+		stop_progress(&data.progress);
 	return result;
 }
 
-- 
2.26.0.113.ge9739cdccc

