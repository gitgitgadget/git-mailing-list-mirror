Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DB8C54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8AEB20724
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="WT2PJvrw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgDWVmB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgDWVlN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 17:41:13 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2CAC09B042
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 14:41:12 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w65so3630742pfc.12
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 14:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W8kNugks4MXsfPxeACWeyHb7wmQzLURnexIYN7sejkI=;
        b=WT2PJvrwXgTsUInge30oMAV9HutXHcDoLKf9of2doiCPDBnQ12jYVlt4KaGc3Wr3DO
         L/PbjgimRVTE3C6ddYU3fTt0gh4Ty6Lr1fNR8z1HrIpA9+P44an99g9MeO6RJDzQzsK3
         P4GtIN4HeK+1aVmC7iHJsWe9LrYhfAmRLjKlWdl/9q3ttwO8Ixq49jYMROocO+S/nPKW
         5sdS0HxNez//oBRru7yPlSl3ahbQNNnbl7ms1fOPzIeUlIROehcyH6kBrlElh83Gqi0j
         37+xmwvGzgF+Ll5sXplsCyc5Yg8NVq9esCrK7g1dyUoxvyaKiaH+0lUnfBtmGIpeCtn+
         +RNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W8kNugks4MXsfPxeACWeyHb7wmQzLURnexIYN7sejkI=;
        b=LlMazn6cHnxcIsP9f4C+IGYK88MznKu+rLrJvpXeWS5mSXIHsr+TjUhPL5asQTJ2MD
         WLOVZycq2o8QewN5sJtJTSBXVZMz1Vbc7c9M5J/oQUdmoW9U39QYiUlgKVCg7iRFyP6W
         u/LuDUHKaAvEvwWEPdikqHhWHYl91e0MZlq2lIAhMrqpj40KJ483nkN+/Jaer3/0tY7Z
         djK/M037JIzj7tb5NqqnksPbE8JTWpjLDKIFRuanXuaYfmPksBbSIC4RtPdlJiZWCYTT
         m4LkQwszw7yCc1cnsC8/UEYJ3C6ugVsa3Qfl2UxLJ9Gh8IuFo05/As/3tV68rvgiLreg
         2aAA==
X-Gm-Message-State: AGi0PuakJmCJctFe7qZyuoh+T8HCgHuySTn0YTcZxx1eZl8/fRD9ar3B
        a44EUaWe2s9TIBDwuGegdl3g11uPg73/Xw==
X-Google-Smtp-Source: APiQypKuyyrDWW9uORFXEiN7+7ms8XTOpx0d98L/+MjHUoKP5hUCRbJ5PWOW+Ax27KDXLr4EoBqrLQ==
X-Received: by 2002:aa7:920d:: with SMTP id 13mr6108576pfo.112.1587678071305;
        Thu, 23 Apr 2020 14:41:11 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id q200sm3004866pgq.68.2020.04.23.14.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 14:41:10 -0700 (PDT)
Date:   Thu, 23 Apr 2020 15:41:09 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, szeder.dev@gmail.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH 3/4] commit-graph.c: gracefully handle file descriptor
 exhaustion
Message-ID: <2b8ee726690861405f41adede5582b96749e98c5.1587677671.git.me@ttaylorr.com>
References: <cover.1587677671.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1587677671.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When writing a layered commit-graph, the commit-graph machinery uses
'commit_graph_filenames_after' and 'commit_graph_hash_after' to keep
track of the layers in the chain that we are in the process of writing.

When the number of commit-graph layers shrinks, we initialize all
entries in the aforementioned arrays, because we know the structure of
the new commit-graph chain immediately (since there are no new layers,
there are no unknown hash values).

But when the number of commit-graph layers grows (i.e., that
'num_commit_graphs_after > num_commit_graphs_before'), then we leave
some entries in the filenames and hashes arrays as uninitialized,
because we will fill them in later as those values become available.

For instance, we rely on 'write_commit_graph_file's to store the
filename and hash of the last layer in the new chain, which is the one
that it is responsible for writing. But, it's possible that
'write_commit_graph_file' may fail, e.g., from file descriptor
exhaustion. In this case it is possible that 'git_mkstemp_mode' will
fail, and that function will return early *before* setting the values
for the last commit-graph layer's filename and hash.

This causes a number of upleasant side-effects. For instance, trying to
'free()' each entry in 'ctx->commit_graph_filenames_after' (and
similarly for the hashes array) causes us to 'free()' uninitialized
memory, since the area is allocated with 'malloc()' and is therefore
subject to contain garbage (which is left alone when
'write_commit_graph_file' returns early).

This can manifest in other issues, like a general protection fault,
and/or leaving a stray 'commit-graph-chain.lock' around after the
process dies. (The reasoning for this is still a mystery to me, since
we'd otherwise usually expect the kernel to run tempfile.c's 'atexit()'
handlers in the case of a normal death...)

To resolve this, initialize the memory with 'CALLOC_ARRAY' so that
uninitialized entries are filled with zeros, and can thus be 'free()'d
as a noop instead of causing a fault.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c                |  4 ++--
 t/t5324-split-commit-graph.sh | 13 +++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index afde075962..b2d2fdfe3d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1602,8 +1602,8 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 		free(old_graph_name);
 	}
 
-	ALLOC_ARRAY(ctx->commit_graph_filenames_after, ctx->num_commit_graphs_after);
-	ALLOC_ARRAY(ctx->commit_graph_hash_after, ctx->num_commit_graphs_after);
+	CALLOC_ARRAY(ctx->commit_graph_filenames_after, ctx->num_commit_graphs_after);
+	CALLOC_ARRAY(ctx->commit_graph_hash_after, ctx->num_commit_graphs_after);
 
 	for (i = 0; i < ctx->num_commit_graphs_after &&
 		    i < ctx->num_commit_graphs_before; i++)
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index e5d8d64170..0d1db31b0a 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -381,4 +381,17 @@ test_expect_success '--split=replace replaces the chain' '
 	graph_read_expect 2
 '
 
+test_expect_success ULIMIT_FILE_DESCRIPTORS 'handles file descriptor exhaustion' '
+	git init ulimit &&
+	(
+		cd ulimit &&
+		for i in $(test_seq 64)
+		do
+			test_commit $i &&
+			test_might_fail run_with_limited_open_files git commit-graph write \
+				--split=no-merge --reachable || return 1
+		done
+	)
+'
+
 test_done
-- 
2.26.0.113.ge9739cdccc

