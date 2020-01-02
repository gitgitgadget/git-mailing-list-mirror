Return-Path: <SRS0=b7P8=2X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE064C3276D
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 16:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47EC21D7D
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 16:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWuCNX4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgABQOT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jan 2020 11:14:19 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33250 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbgABQOS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jan 2020 11:14:18 -0500
Received: by mail-ed1-f65.google.com with SMTP id r21so39484743edq.0
        for <git@vger.kernel.org>; Thu, 02 Jan 2020 08:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8S1lIQ5KbUHPJiVBTvmk8vWMxDWVDQCu/K6M01jw5Tw=;
        b=jWuCNX4lMUV/JZw308IVHTdOcwOUsdY10N44shWYlYB63GfjtHu3USwgdrzDMtVtbO
         IZvOnm0mdxfxFDquHo8dJ2Gy1VkAbEPrgNOOEhFnpFFYl7cIzUzgr4hEKAnyuK9Ux1VO
         pS2LOs/oQs3Rk2WSYYUGCw7G0o8JztbrtF26gHRk2Cb9D/BPdV+lcJ19Mh6/J9eFqPr8
         253LVlZuMIb9eb7F56ll5Tbt0Tdh+pCcurMRQPfcEk8MPIrDWruE0njH0Wl/ylpUf0ih
         PG7yPiWU3Xg6arucBv9bcsuxO0s0XvS39vb4Q8d4UGELYKMf7ArV1yUIJuIO6bZ/ddM7
         Qzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8S1lIQ5KbUHPJiVBTvmk8vWMxDWVDQCu/K6M01jw5Tw=;
        b=oKpNa3qmxAry5FA3UR61S37E26q8mPHUTOkw1hXgMIIlcnUEzbeBF1ncWfEVrqazG5
         CqExAMPiMvsm+VnWL7qEMyj7ODkItUyGEbcyS1ClJjLipsvtMM0i6EmJa9BXnoRtpCjs
         yqq2ABkQvwlajukvqSEZoS5GmJvjFYdTY8VhLDh4G+j1vtGSA4y3aCDQU1mpKk3HpIPQ
         PBRrSo9Yc2H3EIfOkowlCpjjJ3+VUKH3lDuK77++u6VDYNwLjw5deHllNNr/Knf7h305
         ShQFenyUU7OswYwXMz7ulQ98O8m+28kqWpv7KGWS0HqsySGlC664d9fE1IjYmyfDI9sX
         tUUw==
X-Gm-Message-State: APjAAAVAQ2kK4DjqP5GOy/PBf7AJ/ZYuVRQQcYyY8C3pgXhJ+EYKprKy
        8U2zCYGeCMGDR72yd7A5OKmvTki7
X-Google-Smtp-Source: APXvYqyLsQZE6+ximN7bJUL70mt5jZIirrVH0g0GvemcLo2dQcyWmBCBZcp7rmqJze1vGr4yjYi0rg==
X-Received: by 2002:a17:906:5e4d:: with SMTP id b13mr90170659eju.266.1577981656753;
        Thu, 02 Jan 2020 08:14:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y4sm7429407ejr.41.2020.01.02.08.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 08:14:16 -0800 (PST)
Message-Id: <91d89356a20625d04af74d458c28b32445e760c1.1577981654.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.509.git.1577981654.gitgitgadget@gmail.com>
References: <pull.509.git.1577981654.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Jan 2020 16:14:14 +0000
Subject: [PATCH 1/1] fetch: set size_multiple in split_commit_graph_opts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, me@ttaylorr.com, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In 50f26bd ("fetch: add fetch.writeCommitGraph config setting",
2019-09-02), the fetch builtin added the capability to write a
commit-graph using the "--split" feature. This feature creates
multiple commit-graph files, and those can merge based on a set
of "split options" including a size multiple. The default size
multiple is 2, which intends to provide a log_2 N depth of the
commit-graph chain where N is the number of commits.

However, I noticed during dogfooding that my commit-graph chains
were becoming quite large when left only to builds by 'git fetch'.
It turns out that in split_graph_merge_strategy(), we default the
size_mult variable to 2 except we override it with the context's
split_opts if they exist. In builtin/fetch.c, we create such a
split_opts, but do not populate it with values.

This problem is due to two failures:

 1. It is unclear that we can add the flag COMMIT_GRAPH_WRITE_SPLIT
    with a NULL split_opts.
 2. If we have a non-NULL split_opts, then we override the default
    values even if a zero value is given.

Correct both of these issues. First, do not override size_mult when
the options provide a zero value. Second, stop creating a split_opts
in the fetch builtin.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/fetch.c | 4 +---
 commit-graph.c  | 4 +++-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f8765b385b..b4c6d921d0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1866,15 +1866,13 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	    (fetch_write_commit_graph < 0 &&
 	     the_repository->settings.fetch_write_commit_graph)) {
 		int commit_graph_flags = COMMIT_GRAPH_WRITE_SPLIT;
-		struct split_commit_graph_opts split_opts;
-		memset(&split_opts, 0, sizeof(struct split_commit_graph_opts));
 
 		if (progress)
 			commit_graph_flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 
 		write_commit_graph_reachable(get_object_directory(),
 					     commit_graph_flags,
-					     &split_opts);
+					     NULL);
 	}
 
 	close_object_store(the_repository->objects);
diff --git a/commit-graph.c b/commit-graph.c
index e771394aff..b205e65ed1 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1542,7 +1542,9 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 
 	if (ctx->split_opts) {
 		max_commits = ctx->split_opts->max_commits;
-		size_mult = ctx->split_opts->size_multiple;
+
+		if (ctx->split_opts->size_multiple)
+			size_mult = ctx->split_opts->size_multiple;
 	}
 
 	g = ctx->r->objects->commit_graph;
-- 
gitgitgadget
