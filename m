Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CAEC2D0F3
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 21:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA632054F
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 21:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5SvxQJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732710AbgDAVAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 17:00:49 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:42982 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732441AbgDAVAt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 17:00:49 -0400
Received: by mail-wr1-f46.google.com with SMTP id h15so1721081wrx.9
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 14:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=f5oFKRuILi5JiMVi7hna5xOXWMO/U/E0cJqJP7Y1DdA=;
        b=f5SvxQJhCdrvFjxhaRFNkJJYaPNFihhFtXOv0Ju8V7e3ZtUVa7fS0Wn9q1xE+AlJX5
         jFZqIo0SxWdogRoWy4bonp12ovoF73mdcmXsodz7LAZJzwKjkqU1tqiwANh06xuYB+6W
         BRL+QLqkCBvFUWd7N3WzXpZ36vBargEHCzwYHEq4mGYAFCdR+QiPZryJHzJTlp+kTGv3
         gshQPWHUUOtMnqbW8tsA3GwJdGShC7kXZl5KUSGu5Ty00Dl1S94Dy38kfTv5tPZPC2TY
         7PZu5b0QW0KckaDMqrxhd5RSyCTxYVd3Jx53KfI1hrN6pi6plz98zkx90x4UHtVjIcYw
         XGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=f5oFKRuILi5JiMVi7hna5xOXWMO/U/E0cJqJP7Y1DdA=;
        b=BzN0G3efBuNVlgOCW6bmypnLTg8N31x4wO3T/y82KFc/9d1ZP2UwmC3pUYTxOFKhnm
         NVHq5HjDigmnAl1AmjFxOys+cmekb0CMFxaLIDHQ3SRUMHU3hxBVsP1n8YCaQB3syUtV
         eQaPjxLenBJN9+oGF5wY/zHtPCHo09e1PVBska5+5LinWK5oAXo2VCJfmvnn8bXVmAAm
         0KUwAqtHUm1/twsr8rNOgmOUsI2KIz1jSYQVQJ1vtzwABJJzNZahv3ge5RSvrLHSq6w4
         veTDx6qowEm0NJ2LQb30lQV7Ssw6fSL6CzBlC7/dbGM8C9BMDrEPy+wt8k5qvN/U8JOG
         Hsjw==
X-Gm-Message-State: ANhLgQ0u07kBxG0rxKhsBvOFw03nsube4dxM9zh4NB79kJaSC6KS7z2p
        xp7KSX9hKK1NRMZQvm1GjJbJIogF
X-Google-Smtp-Source: ADFU+vvfCM++LF5zjJ/aYOL03pJgf/8avxv/ptBvShmw6nrElsDIw/GpOxOjNFH4zrfyky7hiV6vQQ==
X-Received: by 2002:a05:6000:11c6:: with SMTP id i6mr29073191wrx.115.1585774847265;
        Wed, 01 Apr 2020 14:00:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l4sm4530427wru.1.2020.04.01.14.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 14:00:46 -0700 (PDT)
Message-Id: <56a312695fe1efc3393f67894c95b5bd643c66d1.1585774844.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.596.v2.git.1585774844.gitgitgadget@gmail.com>
References: <pull.596.git.1585764695643.gitgitgadget@gmail.com>
        <pull.596.v2.git.1585774844.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Apr 2020 21:00:44 +0000
Subject: [PATCH v2 2/2] commit-graph: fix buggy --expire-time option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The commit-graph builtin has an --expire-time option that takes a
datetime using OPT_EXPIRY_DATE(). However, the implementation inside
expire_commit_graphs() was treating a non-zero value as a number of
seconds to subtract from "now".

Update t5323-split-commit-graph.sh to demonstrate the correct value
of the --expire-time option by actually creating a crud .graph file
with mtime earlier than the expire time. Instead of using a super-
early time (1980) we use an explicit, and recent, time. Using
test-tool chmtime to create two files on either end of an exact
second, we create a test that catches this failure no matter the
current time. Using a fixed date is more portable than trying to
format a relative date string into the --expiry-date input.

I noticed this when inspecting some Scalar repos that had an excess
number of commit-graph files. In Scalar, we were using this second
interpretation by using "--expire-time=3600" to mean "delete graphs
older than one hour ago" to avoid deleting a commit-graph that a
foreground process may be trying to load.

Also I noticed that the help text was copied from the --max-commits
option. Fix that help text.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit-graph.c        | 2 +-
 commit-graph.c                | 2 +-
 t/t5324-split-commit-graph.sh | 8 +++++++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 4a70b33fb5f..5bfba972498 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -140,7 +140,7 @@ static int graph_write(int argc, const char **argv)
 		OPT_INTEGER(0, "size-multiple", &split_opts.size_multiple,
 			N_("maximum ratio between two levels of a split commit-graph")),
 		OPT_EXPIRY_DATE(0, "expire-time", &split_opts.expire_time,
-			N_("maximum number of commits in a non-base split commit-graph")),
+			N_("only expire files older than a given date-time")),
 		OPT_END(),
 	};
 
diff --git a/commit-graph.c b/commit-graph.c
index f013a84e294..0d0d37787a0 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1707,7 +1707,7 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 	timestamp_t expire_time = time(NULL);
 
 	if (ctx->split_opts && ctx->split_opts->expire_time)
-		expire_time -= ctx->split_opts->expire_time;
+		expire_time = ctx->split_opts->expire_time;
 	if (!ctx->split) {
 		char *chain_file_name = get_chain_filename(ctx->odb);
 		unlink(chain_file_name);
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 53b2e6b4555..b8b208fc3da 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -210,8 +210,14 @@ test_expect_success 'test merge stragety constants' '
 		git config core.commitGraph true &&
 		test_line_count = 2 $graphdir/commit-graph-chain &&
 		test_commit 15 &&
-		git commit-graph write --reachable --split --size-multiple=10 --expire-time=1980-01-01 &&
+		touch $graphdir/to-delete.graph $graphdir/to-keep.graph &&
+		test-tool chmtime =1546362000 $graphdir/to-delete.graph &&
+		test-tool chmtime =1546362001 $graphdir/to-keep.graph &&
+		git commit-graph write --reachable --split --size-multiple=10 \
+			--expire-time="2019-01-01 12:00 -05:00" &&
 		test_line_count = 1 $graphdir/commit-graph-chain &&
+		test_path_is_missing $graphdir/to-delete.graph &&
+		test_path_is_file $graphdir/to-keep.graph &&
 		ls $graphdir/graph-*.graph >graph-files &&
 		test_line_count = 3 graph-files
 	) &&
-- 
gitgitgadget
