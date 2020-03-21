Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A096C43333
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 03:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7486B20753
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 03:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="JzfQ0l7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgCUDo2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 23:44:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38372 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgCUDo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 23:44:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id z5so4339256pfn.5
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 20:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NkdbLpXft4kPNzHMNq9CDlvOq2sn0FNnQAcuWqU63q0=;
        b=JzfQ0l7L5YExBECusP2ev67wBHccREr32rMWP6lufoRpYv03AFhJR8uwsNpmI6wGQn
         3JE8XGrKC0rkNXUIg1zDAT6KXvyzUQmYslscgaMXSj/NO0uC84D9GiGh6b9Q3K4k8JCQ
         xfeeqkf+plWkXCarR7sET9FcMLR1ESaZy4ncLC85PVAi/+oiXwGdK2jEKr/Um8lQSnvK
         Lw0IMnx4H0d+IPWlJu8D0aMzNnfEYl3RWMcY7pP+kciU2T/zwySQFrDU6i/xXFv9U+gT
         9oY/TkQSgkyMjBUae/ybrxWfXxUS75pQti+VN2z+99ApuCu4vbD4jJlaVDE9gJTUQrxY
         Br9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NkdbLpXft4kPNzHMNq9CDlvOq2sn0FNnQAcuWqU63q0=;
        b=M118exnBjBvRYJnb0wwF6P8Y32ygL6/jWPO2M8aSImHbVF8D29s1fxewQHl73dnepp
         q8MNnkS/h74TjctYQ+Pu5oMn9nXMz4qGFVoUutdpD60PBfJ8vsagp1IO8nBvYwTv9/Jn
         266vN4RElFEEfNEFojFTPr9sovXnd6laTuevAMes2KBeBgideHEBbIpzbBUL3VYBmNfF
         06T42456amd1QoOP/B+uLvjJS1E5vajRgS1yb2Xeb2Jsy3IbyVw1dUHZQ6/Q2eaPj02T
         wjnWVpbU2mvX16s38yT16cuSAMgw067aoB4pKNjL/6YW5sjZm4Vdj75bnWuYfgM2rb6v
         48iw==
X-Gm-Message-State: ANhLgQ0t88zokV7+ws342HFHPF/J3wDB/eJOODA2yVfoqvmkZmQGUOqP
        RPIb/DZ8mclYXCPHYKEBYZ5FLhcGeVQ=
X-Google-Smtp-Source: ADFU+vs4OIeUOWDKOLdT7gDs4adZEYg0kr9SRj3B6tszSMl0gTx+XqS5ZQfsN+5evj+YEyXiryMwvg==
X-Received: by 2002:a63:7148:: with SMTP id b8mr11578836pgn.143.1584762265301;
        Fri, 20 Mar 2020 20:44:25 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id t60sm6059189pjb.9.2020.03.20.20.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 20:44:24 -0700 (PDT)
Date:   Fri, 20 Mar 2020 21:44:23 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
Subject: [PATCH 1/1] commit-graph.c: avoid unnecessary tag dereference when
 merging
Message-ID: <4c79a9ea909ebff8c0987bcf95692da92e79bda4.1584762087.git.me@ttaylorr.com>
References: <cover.1584762087.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1584762087.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When performing a 'git commit-graph write' with '--split', the
commit-graph machinery calls 'merge_commit_graph()' after deciding on a
split strategy to optionally clean up any existing commit-graph
layers that were made obsolete by the split strategy [1].

At this time, 'merge_commit_graph()' checks each commit that it writes
into the merged graph to make sure that it still exists in the object
store.

To do this, it uses 'lookup_commit_reference_gently()', which accepts
either a commit object, or a tag that refers to a commit. However, since
all 'oid' arguments passed to this function are from within the
commit-graphs being merged, we never pass a commit reference, and so any
time we spend in 'deref_tag()' is wasted.

Improve the situation by using 'repo_has_object_file' to check if the
object still exists, and '{lookup,repo_parse}_commit()' to turn it into
a bona-fide 'struct commit *'.

In my testing environment, this improves the time to "merge" a split
commit-graph containing all reachable commits in the kernel by
re-writing the same commit-graph (effectively measuring the time it
takes to check that all of those commits still exist) from:

  Attempt 1: 9.614
  Attempt 2: 10.984
  Attempt 3: 10.39
  Attempt 4: 9.14
  Attempt 5: 9.439

  real	0m9.140s
  user	0m8.207s
  sys	0m0.602s

to:

  Attempt 1: 9.12
  Attempt 2: 8.904
  Attempt 3: 9.361
  Attempt 4: 9.288
  Attempt 5: 9.677

  real	0m8.904s
  user	0m8.208s
  sys	0m0.596s

yielding a modest ~2.6% improvement in the best timings from each run,
and ~7.4% improvement on average.

[1]: This can happen if, for example, the new commit-graph exceeds the
     maximum allowed factor on the number of commits.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index f013a84e29..c7cfadc786 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1599,14 +1599,18 @@ static void merge_commit_graph(struct write_commit_graph_context *ctx,
 
 	for (i = 0; i < g->num_commits; i++) {
 		struct object_id oid;
-		struct commit *result;
+		struct commit *result = NULL;
 
 		display_progress(ctx->progress, i + 1);
 
 		load_oid_from_graph(g, i + offset, &oid);
 
 		/* only add commits if they still exist in the repo */
-		result = lookup_commit_reference_gently(ctx->r, &oid, 1);
+		if (repo_has_object_file(ctx->r, &oid)) {
+			result = lookup_commit(ctx->r, &oid);
+			if (repo_parse_commit(ctx->r, result))
+				result = NULL;
+		}
 
 		if (result) {
 			ctx->commits.list[ctx->commits.nr] = result;
-- 
2.26.0.rc2.311.g8e52d2684b
