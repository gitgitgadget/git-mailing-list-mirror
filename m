Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E537C54FCB
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 17:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9AE32084D
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 17:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="sogAhWwk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgD0RVP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgD0RVP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 13:21:15 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2688EC0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 10:21:14 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 18so9306004pfx.6
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 10:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x0g6AWnDQJCOXInurQ3xYF7ZswBLohJrNq5XO8KHceQ=;
        b=sogAhWwkSGNf0M359jSo7RUIBQzWvGZ7Vpxhff8hQXX4o7DZO1yMUQjqDAfMx93lks
         qgZGqygj4m1gvSWBA1YQLIGJBabO0GWmRihqSP+ZRKKSMbeYrWEh4GIv0Ssdbi4wOL3Q
         B2Ryq6aWa4zxL8P2t15+gRYN33YxOPL3jRvVSq+j2K9ycGstUiRT4ZuBTawPOZVGzBJn
         oEkaW4C3F/MwsQlSFUjosdNK4fdTZtbQA7w/oawj2rfYG8F7rVv876ra5RAkfE3EciJY
         MpkKMF0W8E0MaQusOx3zP+JSvYAyjVLCxf+6EWsRqAH7nok0IyTKh28cBh2YwTNS9jzV
         abdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x0g6AWnDQJCOXInurQ3xYF7ZswBLohJrNq5XO8KHceQ=;
        b=F+362K1JlDzah+kKxtmizMq/Pw4zpBFcL8pOQjRc9R5u6nVPBKxDTU6fNUGGU44eyu
         NgXxFL+JPMtkobzTj/levl0eHhwsqU+IuVdLbuH7eK6ASQaueuNkjBB0iev7gQXADYJh
         98tw3DIdAmxEpX5SCVBfRg5wyduYFmskXDYWagOArLzoiGD8D9YPQZ7WtWdZ4QX3Qjra
         UuMZiai1Nk1Tzhera5vQM5yTAE7maJa6v3JdIX1aYVsQaEsfeteneIoDWq92kJIBGuut
         c4Z/mMAKpKAchzqxG1cL90wdNAo0WKIVVajwweNyG+jKiGJKGPElobYZ6J+gtEytb0be
         4Otg==
X-Gm-Message-State: AGi0PuZYzJKYxI0vh3LekSZUFjuMUudPZ3Q9q0aZPp9aAWEqxxPDL2Q2
        c+FZGxFuSszV+lkfVgzapa/EjC4Jo30uvA==
X-Google-Smtp-Source: APiQypJqM+sIAwpVOKYIaEYeyg2pEV1Eby9SvFkS8S66yuv5GQuLvMDJ0tdENa3kcC3r9AVgG6wHeQ==
X-Received: by 2002:a62:32c1:: with SMTP id y184mr23971969pfy.306.1588008073036;
        Mon, 27 Apr 2020 10:21:13 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id n23sm11633108pjq.18.2020.04.27.10.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 10:21:12 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <me@ttaylorrr.com>
Date:   Mon, 27 Apr 2020 11:21:11 -0600
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        mhagger@alum.mit.edu
Subject: Re: [PATCH v2 4/4] commit-graph.c: ensure graph layers respect
 core.sharedRepository
Message-ID: <20200427172111.GA58509@syl.local>
References: <cover.1587422630.git.me@ttaylorr.com>
 <cover.1588004647.git.me@ttaylorr.com>
 <f83437f130812d172167d335ba2d13b1545a9f58.1588004647.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f83437f130812d172167d335ba2d13b1545a9f58.1588004647.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 10:28:05AM -0600, Taylor Blau wrote:
> Non-layered commit-graphs use 'adjust_shared_perm' to make the
> commit-graph file readable (or not) to a combination of the user, group,
> and others.
>
> Call 'adjust_shared_perm' for split-graph layers to make sure that these
> also respect 'core.sharedRepository'. The 'commit-graph-chain' file
> already respects this configuration since it uses
> 'hold_lock_file_for_update' (which calls 'adjust_shared_perm' eventually
> in 'create_tempfile_mode').

It occurs to me that we might want to apply the same treatment to
'commit-graph-chain's, too.

Junio: I'm not sure if you want to apply the below in this series on
top, or if you'd prefer me send it as a separate series. Either way,
here's a patch to do just that:

-- >8 --

Subject: [PATCH] commit-graph.c: make 'commit-graph-chain's read-only

In a previous commit, we made incremental graph layers read-only by
using 'git_mkstemp_mode' with permissions '0444'.

There is no reason that 'commit-graph-chain's should be modifiable by
the user, since they are generated at a temporary location and then
atomically renamed into place.

To ensure that these files are read-only, too, use
'hold_lock_file_for_update_mode' with the same read-only permission
bits, and let the umask and 'adjust_shared_perm' take care of the rest.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c                | 3 ++-
 t/t5324-split-commit-graph.sh | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index d05a55901d..b2dfd7701f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1378,7 +1378,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	if (ctx->split) {
 		char *lock_name = get_chain_filename(ctx->odb);

-		hold_lock_file_for_update(&lk, lock_name, LOCK_DIE_ON_ERROR);
+		hold_lock_file_for_update_mode(&lk, lock_name,
+					       LOCK_DIE_ON_ERROR, 0444);

 		fd = git_mkstemp_mode(ctx->graph_name, 0444);
 		if (fd < 0) {
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 61136c737f..a8b12c8110 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -362,6 +362,8 @@ do
 		test_line_count = 1 graph-files &&
 		echo "$modebits" >expect &&
 		test_modebits $graphdir/graph-*.graph >actual &&
+		test_cmp expect actual &&
+		test_modebits $graphdir/commit-graph-chain >actual &&
 		test_cmp expect actual
 	'
 done <<\EOF
--
2.26.0.113.ge9739cdccc

