Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D45C47254
	for <git@archiver.kernel.org>; Wed,  6 May 2020 00:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08442206A5
	for <git@archiver.kernel.org>; Wed,  6 May 2020 00:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="SWmHSjEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgEFAHm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 20:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbgEFAHj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 20:07:39 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DC8C061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 17:07:38 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mq3so63474pjb.1
        for <git@vger.kernel.org>; Tue, 05 May 2020 17:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iu3L/AEcjj8ZCUAc3p5nfa00WagHa7V7ljbKMe2JdAM=;
        b=SWmHSjEAak/eN2aH4hE54+PIMvJofmPzs7NiCjLuO+Oii3O0j2JxHcvEcBOmHLmlQz
         5k3DniyrzJ6pR0F+K6n1xoSa4k8k8Ld1jLRDfBY4N3fHdStsuw3BC8EJ2fB6LkGwQKwd
         3s+0FmR252hdr5qv884r6lQjMhZ7IS6Zwn8DqTfsklL9LOABEAYxWYqPGCH0p1K4rMQk
         WH7VZwptAu8XWYF+/tQhkl4TbHTC0ugS5i1GlplmEE78250iGnf9fCYgaHZII313eYSG
         l3C5NvHN5pxhIuo9W7gzfp7Ems+/1IH3nIDcaHW1CvV4AplEqCjP3+mnlF9P+BG1RHIl
         6Hdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iu3L/AEcjj8ZCUAc3p5nfa00WagHa7V7ljbKMe2JdAM=;
        b=ClM4uLXrV7QyJge78CuyP+MS7wTwuZI+2cQN5vBhLzY5sAM4ZekW7J1nUg1nBunzM3
         Jn6K5musBeuRHI0hZFBnweq7B50eI4fTKgXuFc2HjYijTPwjY86e30kdaiJhEoQpDjAU
         jKCm9dW1trER3jq9vM5qsLbvfpDGLkW8JD/TD7EX1ij4d8JKia9r19Q/GLld9I/RY/bh
         xh5u6l62vzTrLVVe3hVkrBHUTicWXHJ2IbQ9TmoG5qPFlkxe7RjvbnS/bsSnh32ZOvZ+
         QlkldIpv0wCb335LKb1WzsJbGubuuq/xsHvZmhulAv8cdaoz2290k023u9uHOirVE3Y7
         7Gkg==
X-Gm-Message-State: AGi0PubsjSaoXS8FTEA0JkZ2IQuk5ouhbtBA8ngQ0h46WflSuCavm412
        Zed5l4kbnBY3P9k/+iiX3pi0rqL8s7c=
X-Google-Smtp-Source: APiQypJnNe0fGFgkzsndTRj/cwLxWkTXthBcoijxJe6PhMWieHGWk9VJ0/yPUhOCR3/yAjYZxTkuiQ==
X-Received: by 2002:a17:90a:368d:: with SMTP id t13mr5728608pjb.175.1588723657065;
        Tue, 05 May 2020 17:07:37 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id g184sm124376pfb.80.2020.05.05.17.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 17:07:36 -0700 (PDT)
Date:   Tue, 5 May 2020 18:07:35 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v2 2/8] commit-graph.c: show progress of finding reachable
 commits
Message-ID: <cb56a9a73b961c7d61b4c7dc6f49bd07f05d66e4.1588723544.git.me@ttaylorr.com>
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
index 00da281f39..d0397f2a23 100644
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

