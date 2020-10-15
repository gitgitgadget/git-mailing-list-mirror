Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023F8C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 13:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 858B322267
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 13:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAPKE9L9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgJONVw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 09:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgJONVw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 09:21:52 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7268C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 06:21:51 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id t25so3540994ejd.13
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 06:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iHigZuyg12ZB0YKn3pVpXLICncMzfshOOCqCyZiiCuM=;
        b=BAPKE9L9uQ0LXTpvzE6EXIJYJ7fUsOpZzj7zKcWvSZm3nua0sUWBxcqYF2RQfZwmXu
         LYssdVgG42IZzgqeHIIsNqDQUqLVd34Mla90kdjVrHgDbDv4TlGJ9eXKEW/C1Oml9IRC
         x6xhZYYO67q4/LR5FtlwdZ8JtT7La2NggabcTrcSMYRtBT1fwFcLbvx4ammrB4MWYRRm
         HZKIFQiNLfLwv8kUEcZ8jds2V4JghQC9MgzJtwlCfVN4OquylMItrjqHJfogR069tM8R
         7m1WWYl8Hule1tokHNXo9dfMCjad//77qJx9TXSsqv6dS1eSsDlwM7G7Z+8s0lKyeWV3
         O2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iHigZuyg12ZB0YKn3pVpXLICncMzfshOOCqCyZiiCuM=;
        b=e5+AdgOC+RdGmSzmmy8ysSuBd6DJno+X0cLOofLLarGSmAkzrcqG+IFhR8mpW2vVje
         H3JNH8L8XdepUmIS8RuVBqs6tdfiUDobMd1n1Cd9SfGx0svVHnb1AkUlf3GbfHykNwU0
         fqmuFj0Hp7xMXSfRrn/pfWIgalxTD/+GQFZ4q4YfABUTNIBzbwzKSzh92qYCNroXa6jw
         ugyoAlv6MSLyvz5XUeoZAwsa8fZzJfMuGX1aD8pU/gS9xZ6amSj/NpIM9DDHOMQ2bQRp
         nfnGFJYBldgK4IIHcFa1WzIEA1EG0BFotw+2catJYhf50t5KeH7Mttlj3KnNFbc0F41s
         cG6w==
X-Gm-Message-State: AOAM533GbUrWkWn0q9JW5bym6B2Yj4x/ZYaPGWxqPNEsBJ3eFEvzLeY8
        GjiUdxdWlaUVsZjXSt5yb2k=
X-Google-Smtp-Source: ABdhPJxB90XnkUFCooB/tDrNe8FsrmFFN/Vg0Y1OUHK+mvlnZXIOE/55jGmfwet1YcmcVxZwTbxK6Q==
X-Received: by 2002:a17:906:6bce:: with SMTP id t14mr4584731ejs.118.1602768110175;
        Thu, 15 Oct 2020 06:21:50 -0700 (PDT)
Received: from szeder.dev (94-21-23-128.pool.digikabel.hu. [94.21.23.128])
        by smtp.gmail.com with ESMTPSA id me12sm1588412ejb.108.2020.10.15.06.21.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2020 06:21:49 -0700 (PDT)
Date:   Thu, 15 Oct 2020 15:21:47 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, l.s.r@web.de,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 04/10] commit-graph: persist existence of changed-paths
Message-ID: <20201015132147.GB24954@szeder.dev>
References: <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
 <pull.659.v4.git.1593610050.gitgitgadget@gmail.com>
 <f1e3a8516ebd58b283166a5374843f5cb3332d08.1593610050.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f1e3a8516ebd58b283166a5374843f5cb3332d08.1593610050.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 01, 2020 at 01:27:24PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The changed-path Bloom filters were released in v2.27.0, but have a
> significant drawback. A user can opt-in to writing the changed-path
> filters using the "--changed-paths" option to "git commit-graph write"
> but the next write will drop the filters unless that option is
> specified.
> 
> This becomes even more important when considering the interaction with
> gc.writeCommitGraph (on by default) or fetch.writeCommitGraph (part of
> features.experimental). These config options trigger commit-graph writes
> that the user did not signal, and hence there is no --changed-paths
> option available.
> 
> Allow a user that opts-in to the changed-path filters to persist the
> property of "my commit-graph has changed-path filters" automatically. A
> user can drop filters using the --no-changed-paths option.

The above parts of the commit message and the corresponding changes
are OK, but ...

> In the process, we need to be extremely careful to match the Bloom
> filter settings as specified by the commit-graph. This will allow future
> versions of Git to customize these settings, and the version with this
> change will persist those settings as commit-graphs are rewritten on
> top.

As pointed out in my original bug report [1], modified path Bloom
filters are computed with hardcoded settings in
bloom.c:get_bloom_filter().  Since this patch does not touch bloom.c
at all, it still computes Bloom filters with those hardcoded settings,
and, consequently, despite the commit message's claims, it does not
persist the settings in the existing commit-graph.

[1] https://public-inbox.org/git/20200619140230.GB22200@szeder.dev/

> Use the trace2 API to signal the settings used during the write, and
> check that output in a test after manually adjusting the correct bytes
> in the commit-graph file.

This test is insufficient, as it only checks what settings trace2
believes the Bloom filters are computed with, not what settings they
are actually computed with; that's why it succeeded while the bug
whose absence it was supposed to ensure was still there.

More robust tests should instead look at what actually gets written to
the commit-graph, and how that is interpreted during pathspec-limited
revision walks.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

A "Reported-by: me" trailer would have been appropriate here.

> ---
>  Documentation/git-commit-graph.txt |  5 +++-
>  builtin/commit-graph.c             |  5 +++-
>  commit-graph.c                     | 45 ++++++++++++++++++++++++++++--
>  commit-graph.h                     |  1 +
>  t/t4216-log-bloom.sh               | 17 ++++++++++-
>  5 files changed, 67 insertions(+), 6 deletions(-)

Anyway, this is now partially fixed in 9a7a9ed10d (bloom: use provided
'struct bloom_filter_settings', 2020-09-16), though, unfortunately,
its commit message is not quite clear on this.  Alas, that's only a
partial fix, because we still only look at the top level commit-graph
file for existing Bloom filter settings.  However, deeper commit-graph
layers can contain Bloom filters with non-default settings even when
the top level doesn't, and these failing tests below demonstrate:

  ---  >8  ---

#!/bin/sh

test_description='test'

. ./test-lib.sh

test_expect_success 'setup' '
	git commit --allow-empty -m "Bloom filters are written but ignored for root commits :(" &&
	for i in 1 2 3
	do
		echo $i >file &&
		git add file &&
		git commit -m "$i" || return 1
	done &&
	git log --oneline --no-decorate -- file >expect
'

test_expect_success 'split' '
	# Compute Bloom filters with "unusual" settings.
	git rev-parse HEAD^^ | GIT_TEST_BLOOM_SETTINGS_NUM_HASHES=3 git commit-graph write --stdin-commits --changed-paths --split &&
	# A commit-graph layer without Bloom filters "hides" the layers
	# below ...
	git rev-parse HEAD^ | git commit-graph write --stdin-commits --no-changed-paths --split=no-merge &&
	# ... so this does not look at existing Bloom filters and their
	# settings in the bottom commit-graph layer and computes new
	# Bloom filters using the default 7 hashes.
	git rev-parse HEAD | git commit-graph write --stdin-commits --changed-paths --split=no-merge &&

	# Just to make sure that there are as many graph layers as I
	# think there should be.
	test_line_count = 3 .git/objects/info/commit-graphs/commit-graph-chain &&

	# This checks Bloom filters using settings in the top layer,
	# thus misses commits modifying file in the bottom commit-graph
	# layer.
	git log --oneline --no-decorate -- file >actual &&
	test_cmp expect actual
'

test_expect_success 'merged' '
	# This merges all existing layers, and computes missing Bloom
	# filters with the settings in the top layer, without noticing
	# that filters in the bottom layer were computed with different
	# settings.
	git commit-graph write --reachable --changed-paths &&

	# Just to make sure...
	test_path_is_file .git/objects/info/commit-graph &&

	# This misses commits modifying file that were merged from the
	# bottom commit-graph layer.
	git log --oneline --no-decorate -- file >actual &&
	test_cmp expect actual
'

test_done

