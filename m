Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A56C433DF
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 20:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7025622261
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 20:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3KKtjBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390988AbgJIUx6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 16:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390960AbgJIUx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 16:53:57 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AC3C0613D5
        for <git@vger.kernel.org>; Fri,  9 Oct 2020 13:53:57 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a72so490329wme.5
        for <git@vger.kernel.org>; Fri, 09 Oct 2020 13:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BeZky0ifivjf2ThY4p57yacIS4TlpNjuiehrhMNG82Q=;
        b=N3KKtjBWF5nt5eFL78DvsD8kS30s3Y7gigIEatG3R4kPNOM3n09fOFQfJ1synY5gvH
         BYPam+vkTkS2taOZeyOjiIRK+82++FUg5c2wKxmgf79UqCqJkAEpUODn5HLNBMipCJvx
         M3od7QkfE9cSZA2EWa5/nq2P9L7UT8fdBuEQJThsK2RZMu2NbJp22gklRFTM3qBjoE6d
         cFCbcxLqEbwYxxCzEauk1kHWbAMrqI2F0lPr2RbpqCmTFXrG4dtsO9GGErXX/WogXwfX
         tHB1mj8vyWFb5arzTjWQcLEU65Q6rLOwWbLUgLRT0viCWL1xiLziEniL9LWaC7a5XFBI
         um/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BeZky0ifivjf2ThY4p57yacIS4TlpNjuiehrhMNG82Q=;
        b=KAArOc/zODo+uRbRmyigP+Aa8uTZeIksSzlN3E80j24M2Nwz9PHWZbXLhmLH0LUckD
         0xwmfP2vyGCRQns8v9RC61VqaPI51UZp4jOsYXzdduSamApB5NCWyOINXQIEQCH57NG+
         ddHPhcox8irQ7sSLehEQN2NwtJYr90W2J+Kt8TOp7n/Xi3C9V7UM/qWvajhk7Mi7UBHR
         yZmGkxlbUTP4Kmdfik6gKul1ZsiuWEJck3JcZTeyr2/m2+g3M1xJ8IL51xW+xTftuew8
         hHS7duw9MS7qfngKUPtsW2zenvRai307SUbkZvFcKz27Banmtf1aoaDkFCQHImrAPXF/
         /vug==
X-Gm-Message-State: AOAM531q0chQbUFdNUerlx7z5rLGpqM7/rEoL9S8QU20bWZ6l9+f00O0
        2kiwl2T8mddrMm4JUgplSdZ10s5FoYw=
X-Google-Smtp-Source: ABdhPJyvYsEiDobfjEDVdED5XHYWEwOWLxYUHowwdG1VDoiyvr9f45VC4rLxyACsvqdUo+MQ4TLpoA==
X-Received: by 2002:a1c:bd43:: with SMTP id n64mr15252044wmf.113.1602276835582;
        Fri, 09 Oct 2020 13:53:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 30sm3746327wrs.84.2020.10.09.13.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 13:53:55 -0700 (PDT)
Message-Id: <4439e8ae8fdc9abf28df29d3038a1483d9084cf2.1602276832.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.747.v4.git.1602276832.gitgitgadget@gmail.com>
References: <pull.747.v3.git.1602169479482.gitgitgadget@gmail.com>
        <pull.747.v4.git.1602276832.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Oct 2020 20:53:52 +0000
Subject: [PATCH v4 2/2] commit-graph: don't write commit-graph when disabled
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The core.commitGraph config setting can be set to 'false' to prevent
parsing commits from the commit-graph file(s). This causes an issue when
trying to write with "--split" which needs to distinguish between
commits that are in the existing commit-graph layers and commits that
are not. The existing mechanism uses parse_commit() and follows by
checking if there is a 'graph_pos' that shows the commit was parsed from
the commit-graph file.

When core.commitGraph=false, we do not parse the commits from the
commit-graph and 'graph_pos' indicates that no commits are in the
existing file. The --split logic moves forward creating a new layer on
top that holds all reachable commits, then possibly merges down into
those layers, resulting in duplicate commits. The previous change makes
that merging process more robust to such a situation in case it happens
in the written commit-graph data.

The easy answer here is to avoid writing a commit-graph if reading the
commit-graph is disabled. Since the resulting commit-graph will would not
be read by subsequent Git processes. This is more natural than forcing
core.commitGraph to be true for the 'write' process.

Reported-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Helped-by: Jeff King <peff@peff.net>
Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt | 4 +++-
 commit-graph.c                     | 5 +++++
 t/t5324-split-commit-graph.sh      | 3 ++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index de6b6de230..e1f48c95b3 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -39,7 +39,9 @@ COMMANDS
 --------
 'write'::
 
-Write a commit-graph file based on the commits found in packfiles.
+Write a commit-graph file based on the commits found in packfiles. If
+the config option `core.commitGraph` is disabled, then this command will
+output a warning, then return success without writing a commit-graph file.
 +
 With the `--stdin-packs` option, generate the new commit graph by
 walking objects only in the specified pack-indexes. (Cannot be combined
diff --git a/commit-graph.c b/commit-graph.c
index 0280dcb2ce..6f62a07313 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2160,6 +2160,11 @@ int write_commit_graph(struct object_directory *odb,
 	int replace = 0;
 	struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 
+	prepare_repo_settings(the_repository);
+	if (!the_repository->settings.core_commit_graph) {
+		warning(_("attempting to write a commit-graph, but 'core.commitGraph' is disabled"));
+		return 0;
+	}
 	if (!commit_graph_compatible(the_repository))
 		return 0;
 
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index a314ce0368..4d3842b83b 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -442,8 +442,9 @@ test_expect_success '--split=replace with partial Bloom data' '
 
 test_expect_success 'prevent regression for duplicate commits across layers' '
 	git init dup &&
-	git -C dup config core.commitGraph false &&
 	git -C dup commit --allow-empty -m one &&
+	git -C dup -c core.commitGraph=false commit-graph write --split=no-merge --reachable 2>err &&
+	test_i18ngrep "attempting to write a commit-graph" err &&
 	git -C dup commit-graph write --split=no-merge --reachable &&
 	git -C dup commit --allow-empty -m two &&
 	git -C dup commit-graph write --split=no-merge --reachable &&
-- 
gitgitgadget
