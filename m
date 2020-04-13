Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B36AC2BA2B
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 14:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 762D420767
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 14:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qkbai/gu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgDMOpf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729137AbgDMOpb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 10:45:31 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA67C008748
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 07:45:30 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id z65so12316064ede.0
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 07:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fxI4kN9j15YUGF9BkcGNTLKPd6kti9IzYEg0lAbFWEA=;
        b=qkbai/guJV5D4HQZhEnHBd8BuHKjLk3cl/nkysfcG0D1ywggLBIkEpDYNk3zVwIrTH
         9+iAlaW1iMgh00KDlYILABn3RhwJQAjttvX/gEdC7vS3uTM2qa+LsFJoiTR+nHmd2iJH
         xMfZAwbnSfnc5QqymwL1hdT7AyU1Tb4K2tzEDIjkikpFsMd1tv3X5fjX/lEBuia8Pil2
         Vx2MvIeeNipJOoJgXqygdgEa/15RKATuoE1n7PoP4yHDMPnnZib5lBQEx6VSXQUwqpHV
         scPNfbeMb4RW/dAMGt9jMB7rYM2qgiD4aiBh2nxYxh5CDKkP1tAYZVI5grtQLQrFJOQp
         +KfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fxI4kN9j15YUGF9BkcGNTLKPd6kti9IzYEg0lAbFWEA=;
        b=TO/CQzex5DufLUGJPWYxJCU4DufksHIUv6UuOdj+kSZ/HeQbmmIVg8r/IhnoDfCG0g
         Y/+pX51kuZxQkiASOOfFTVoPl4++bn8gfpSTC4+AI1qTyhip90dxPJn00edOT+gzpCNb
         EQuaAS7NM1X1fC6AjkRQmsy4iIf04sl86iZHL5eoW0ohxdUAbPsLDh4ucwioU/5EiX+o
         G0lYBVVoB2sSslwEmCp3Vksp+CEXqVfkipJXwMsi/aUdfIEKb6cLfdO4IIKm+QTMWqsq
         YEH3D4PvdzC6WxhAjpiLhqsURVRJvgnV6eGww3vZN/OWus2XAJR+ioE8h+w9To5ewdHR
         C9FA==
X-Gm-Message-State: AGi0PuadwW2/HJ3Gss9hvWa+ECurXvz1s88/0UFC8kerXLHf2KbS8aB4
        UPfKxP2L71LyGrFnVYaMRsyq5fNr
X-Google-Smtp-Source: APiQypKqmwojgqKxQ/Zmx6OEnE/RVbdHuiW7noCCUoAyEQEEMRv75zbp69yFc5w7SULzgPMkQeO1RA==
X-Received: by 2002:a17:906:f90e:: with SMTP id lc14mr1995312ejb.156.1586789129395;
        Mon, 13 Apr 2020 07:45:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r19sm83399edo.12.2020.04.13.07.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 07:45:28 -0700 (PDT)
Message-Id: <7e8f1aed1138ab2a52a8957ac95895ac9effd933.1586789126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.609.v2.git.1586789126.gitgitgadget@gmail.com>
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
        <pull.609.v2.git.1586789126.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Apr 2020 14:45:24 +0000
Subject: [PATCH v2 2/4] commit: write commit-graph with Bloom filters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, jnareb@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The GIT_TEST_COMMIT_GRAPH environment variable updates the commit-
graph file whenever "git commit" is run, ensuring that we always
have an updated commit-graph throughout the test suite. The
GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS environment variable was
introduced to write the changed-path Bloom filters whenever "git
commit-graph write" is run. However, the GIT_TEST_COMMIT_GRAPH
trick doesn't launch a separate process and instead writes it
directly.

Update the "git commit" builtin to write changed-path Bloom filters
when both GIT_TEST_COMMIT_GRAPH and GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS
are enabled.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 77668629e27..3e8f36ce5c8 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1968,6 +1968,8 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->check_oids = flags & COMMIT_GRAPH_WRITE_CHECK_OIDS ? 1 : 0;
 	ctx->split_opts = split_opts;
 	ctx->changed_paths = flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS ? 1 : 0;
+	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
+		ctx->changed_paths = 1;
 	ctx->total_bloom_filter_data_size = 0;
 
 	if (ctx->split) {
-- 
gitgitgadget

