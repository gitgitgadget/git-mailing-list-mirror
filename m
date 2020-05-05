Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C90C47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 01:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC79D20658
	for <git@archiver.kernel.org>; Tue,  5 May 2020 01:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Hmjv8yKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgEEBNn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 21:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727899AbgEEBNn (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 21:13:43 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF574C061A0F
        for <git@vger.kernel.org>; Mon,  4 May 2020 18:13:41 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id y6so273082pjc.4
        for <git@vger.kernel.org>; Mon, 04 May 2020 18:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8nHD7/l+FWqHP8kpZBKCwMK0CWsUxzQbGEIs9CiQc7Q=;
        b=Hmjv8yKtkGWYT+rcHnmP89PBFAbBWq3xhythq0B4Ra5eGQhzC0Q6XaqDXaus9Fq53W
         FFOWFLM+4BM7Tuh1KHzsNJqdUenbNzL22lH7z1VQmzZ0qrC6FY3GFBBrD151PNYiHJE2
         6of7ajJnkDPoNkXI7f/NPUDAZfm3uoSSJ/Q+YZL45BGNJb6eW4DK/c4aFLd3tBqtaPhL
         yuCrYXGwiIXCQ7QzFK9cKunis28Eeeai9TnE5I6Cut64KvowrFDnPPZtCqQIxkCyhvIC
         TeeneeC/8NbSKUe6DvbEsjAvaQ8cuDr8axPUvfyBWLNNBLLCLh507/P/Vp+FKkG2FxtK
         oPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8nHD7/l+FWqHP8kpZBKCwMK0CWsUxzQbGEIs9CiQc7Q=;
        b=bkt6ZgWEoxq9VohhXFiyvbq/TZTwHNSKWH0ct1fuLxEMzCUZ4vvRo2T401Zqe8WtwJ
         bsEraTaIUXpZvgTFKQAV037y/drmRnn0qTYfW+njk3lzGl097i4IT22ojOg/kyylIRye
         v8BD7vSSMI0cw+ltOm5uV3D0Gfz7nz2OSFOdS6o5CLQKI12YN3ILN4LUmSH4WumRyCVA
         lZuuyxtmKnNQcoDb6/M/e/LuxALfIiU6dtyB0N+EhNviE+EOyGtB1SEKicUOxPEhN5jR
         AqSSx3T2ogA0yJG53IsqnT+WjumVWQ6JRQDRgBodiXz1mkd+j6XlA6Sp8IzeUIk3y3LT
         ymGw==
X-Gm-Message-State: AGi0PuYaoIvMb0hyqvrRcPs6GyyRe7+VB+Xfr2QZlkL2yF93yf5OqDaB
        o+VFOd7l1g/nvx9XAtGbTndcbBHmYJ5scA==
X-Google-Smtp-Source: APiQypL41YHCiC1SK0mbw6pX9Vp3Yaf+AowLqGlNXdGa/J2ErkUnbJ8EmEWO4gKXEwwr7gJEX796gw==
X-Received: by 2002:a17:90a:d504:: with SMTP id t4mr37215pju.123.1588641221074;
        Mon, 04 May 2020 18:13:41 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id ie17sm198478pjb.19.2020.05.04.18.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 18:13:40 -0700 (PDT)
Date:   Mon, 4 May 2020 19:13:39 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH 2/8] commit-graph.c: show progress of finding reachable
 commits
Message-ID: <5bdbeaf374b6050670f800fcdd3b54ddd0750754.1588641176.git.me@ttaylorr.com>
References: <cover.1588641176.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588641176.git.me@ttaylorr.com>
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
 commit-graph.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 00da281f39..8f61256b0a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1320,6 +1320,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 
 struct refs_cb_data {
 	struct oidset *commits;
+	struct progress *progress;
 };
 
 static int add_ref_to_set(const char *refname,
@@ -1328,6 +1329,8 @@ static int add_ref_to_set(const char *refname,
 {
 	struct refs_cb_data *data = (struct refs_cb_data *)cb_data;
 
+	display_progress(data->progress, oidset_size(data->commits) + 1);
+
 	oidset_insert(data->commits, oid);
 	return 0;
 }
@@ -1342,12 +1345,17 @@ int write_commit_graph_reachable(struct object_directory *odb,
 
 	memset(&data, 0, sizeof(data));
 	data.commits = &commits;
+	if (flags & COMMIT_GRAPH_WRITE_PROGRESS)
+		data.progress = start_delayed_progress(
+			_("Finding reachable commits"), 0);
 
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

