Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9902CC433E9
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 18:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C792083B
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 18:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="fTSz66ma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbgICSt0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgICStZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 14:49:25 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274A8C061244
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 11:49:25 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id u3so4045250qkd.9
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 11:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7jcrU8El3viVZPL+vtJiz8gWwy/OVW4Ke0Vjz+EZkjE=;
        b=fTSz66maqiCL+oQk2taQt38l4bphLW7taxoxYOUZFI3GHB0PfsNlGmAevqpHaEdQIF
         yLW+sJ0nXKr5pIh4DK1X8CaPX0S9MkV4X28KiZ9NxB8DjhyQ64V+Ow/XTzZ767AXD7w9
         Fs9j1H+BvDRfC24USQNIY5KjvuzLfXwN6COWEwsuyxW8J8u4wope09uSC7Gh0lLqeMcd
         ibZq92610//je/KG755+y5rJaw5SaVp1kigae4NwymmHH70NTGhHaw/uG9QgznbTqeR3
         hX/91yeMbi22cMtI+yfjCC+XyWT1Mrje38jakuRCcQpFlG0qyRtFYnPx0gyZed98SWmV
         brpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7jcrU8El3viVZPL+vtJiz8gWwy/OVW4Ke0Vjz+EZkjE=;
        b=mdGVrbnf3SCcBLcMnvY4hm6od+RcbbQpf76uPGLuGbBPDJxdoErEQWA9eG3eoPULRn
         R99P2r+sxiZs0A6CMs4GDjRrDJ4T8Oa+g/vq7ZQOWYCB3Bts827F8yDTXPD9lRYX3FWP
         297KpXVTwvV2Zh+zGgsCDBukte9Vd7ThO0v5+kkKpWs7bzDBNPgNwStc3cedv75UShBK
         cFMaySaN6GVC24dhAhTfXAqAZh4VrVKsWrck1OacDWs04y5nwFhfsPK9yfC41UnpYZQ5
         CyRNog1TCa803KMk5mX0i4rZRZNNoWg123At5pW8pAvb/wjgvzs90PQvReeJYqyo3h/i
         FzAg==
X-Gm-Message-State: AOAM531XPytDVDT2HN7Of2sHd2cQwDOcJbPmkNt3Mfyyi5QE9+A79LdQ
        rAcE2TBBjbccf9bz0ohvZZl9bw==
X-Google-Smtp-Source: ABdhPJyw/rN98TVQW/HZfwnQvwHtQuolCuif9f4iqedMs0hG7o4uTv72126oWtbqI+hO00Nl12lyBA==
X-Received: by 2002:ae9:dd01:: with SMTP id r1mr4263167qkf.467.1599158964112;
        Thu, 03 Sep 2020 11:49:24 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a97c:6dae:76a4:c715])
        by smtp.gmail.com with ESMTPSA id 16sm2843686qks.102.2020.09.03.11.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 11:49:23 -0700 (PDT)
Date:   Thu, 3 Sep 2020 14:49:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com
Subject: Re: [PATCH v3 14/14] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
Message-ID: <20200903184920.GA8946@nand.local>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
 <09f6871f66bff838c067a3e0d23cd4622171f3bd.1597178915.git.me@ttaylorr.com>
 <20200901143650.GA22631@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200901143650.GA22631@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 01, 2020 at 04:36:50PM +0200, SZEDER Gábor wrote:
> Something seems to be wrong in this patch, though I haven't looked
> closer.  Consider this test with a bit of makeshift tracing:
>
>   ---  >8  ---
>
> diff --git a/bloom.c b/bloom.c
> index 8d07209c6b..1a0dec35cd 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -222,6 +222,7 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
>  	if (!compute_if_not_present)
>  		return NULL;
>
> +	printf("get_or_compute_bloom_filter(): diff: %s\n", oid_to_hex(&c->object.oid));
>  	repo_diff_setup(r, &diffopt);
>  	diffopt.flags.recursive = 1;
>  	diffopt.detect_rename = 0;
> diff --git a/t/t9999-test.sh b/t/t9999-test.sh
> new file mode 100755
> index 0000000000..0833e6ff7e
> --- /dev/null
> +++ b/t/t9999-test.sh
> @@ -0,0 +1,25 @@
> +#!/bin/sh
> +
> +test_description='test'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'test' '
> +	for i in 1 2 3 4 5 6
> +	do
> +		git commit -q --allow-empty -m $i || return 1
> +	done &&
> +	git log --oneline &&
> +
> +	# We have 6 commits and compute 2 Bloom filters per execution,
> +	# so 3 executions should be enough...  but, alas, it isnt.
> +	for i in 1 2 3 4 5
> +	do
> +		# No --split=replace!
> +		git commit-graph write --reachable --changed-paths --max-new-filters=2 || return 1
> +	done &&
> +
> +	git commit-graph write --reachable --changed-paths --max-new-filters=4
> +'
> +
> +test_done
>
>   ---  >8  ---
>
> It's output looks like:
>
>   [...]
>   + git log --oneline
>   13fcefa (HEAD -> master) 6
>   0c71516 5
>   a82a61c 4
>   54c6b2c 3
>   fc99def 2
>   a3a8cd3 1
>   + git commit-graph write --reachable --changed-paths --max-new-filters=2
>   get_or_compute_bloom_filter(): diff: 0c71516945bf0a23813e80205961d29ebc1020e0
>   get_or_compute_bloom_filter(): diff: 13fcefa4bb859a15c4edc6bb01b8b6c91b4f32b6
>   + git commit-graph write --reachable --changed-paths --max-new-filters=2
>   get_or_compute_bloom_filter(): diff: 54c6b2cd4fb50066683a197cc6d677689618505a
>   get_or_compute_bloom_filter(): diff: a3a8cd3c82028671bf51502d77277baf14a2f528
>   + git commit-graph write --reachable --changed-paths --max-new-filters=2
>   get_or_compute_bloom_filter(): diff: 0c71516945bf0a23813e80205961d29ebc1020e0
>   get_or_compute_bloom_filter(): diff: 13fcefa4bb859a15c4edc6bb01b8b6c91b4f32b6
>   + git commit-graph write --reachable --changed-paths --max-new-filters=2
>   get_or_compute_bloom_filter(): diff: 54c6b2cd4fb50066683a197cc6d677689618505a
>   get_or_compute_bloom_filter(): diff: a3a8cd3c82028671bf51502d77277baf14a2f528
>   + git commit-graph write --reachable --changed-paths --max-new-filters=2
>   get_or_compute_bloom_filter(): diff: 0c71516945bf0a23813e80205961d29ebc1020e0
>   get_or_compute_bloom_filter(): diff: 13fcefa4bb859a15c4edc6bb01b8b6c91b4f32b6
>   + git commit-graph write --reachable --changed-paths
>   get_or_compute_bloom_filter(): diff: 54c6b2cd4fb50066683a197cc6d677689618505a
>   get_or_compute_bloom_filter(): diff: a3a8cd3c82028671bf51502d77277baf14a2f528
>   get_or_compute_bloom_filter(): diff: a82a61c79b2b07c4440e292613e11a69e33ef7a2
>   get_or_compute_bloom_filter(): diff: fc99def8b1df27bcab7d1f4b7ced73239f9bd7ec
>
> See how the third write with '--max-new-filters=2' computes the
> filters that have already been computed by the first write instead of
> those two that have never been computed?  And then how the fourth
> write computes filters that have already been computed by the second
> write?  And ultimately we'll need a write without '--max-new-filters' (or
> with '--max-new-filters=<large-enough>') to compute all remaining
> filters.

Ouch. This definitely has to do with the empty commits, since swapping
out your 'git commit ... --allow-empty' for a 'test_commit' produces the
output that you'd expect.

> With '--split=replace' it appears to work as expected.

This is definitely the critical bit. The crux of the issue is that
'copy_oids_to_commits()' handles split and non-split graphs differently.
The critical bits here are:

  * 43d3561805 (commit-graph write: don't die if the existing graph is
    corrupt, 2019-03-25) which forces the relevant data to *not* be
    loaded from an existing commit-graph, and

  * 8a6ac287b2 (builtin/commit-graph.c: introduce split strategy
    'replace', 2020-04-13), which does load data from an existing
    commit-graph with '--split=replace'.

When writing a graph with '--split=replace', commits are loaded from the
graph, which includes setting their '->graph_pos' (or rather setting
this data in a commit slab, which is I guess how it's done these days).
Without '--split=replace', the graph position will never be set.

So, by the time we get to 'get_bloom_filter_large_in_graph', the graph
position is 'COMMIT_NOT_FROM_GRAPH', which in turn forces us to
recompute the filter from scratch, since we assume that being
'NOT_FROM_GRAPH' implies that we won't find it in any 'BFXL' chunk.

Regardless of whether or not we should be trusting the parentage
information on-disk, recomputing the Bloom filters from scratch is
simply too expensive (and the opposite of the point of this series). So,
doing the following to force 'get_bloom_filter_large_in_graph' to lookup
the Bloom and BFXL data in a commit graph by forcibly loading its graph
position is the right thing to do.

This is sufficient to get us unstuck:

diff --git a/commit-graph.c b/commit-graph.c
index bec4e5b725..243c7253ff 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -956,8 +956,8 @@ int get_bloom_filter_large_in_graph(struct commit_graph *g,
                                    const struct commit *c,
                                    uint32_t max_changed_paths)
 {
-       uint32_t graph_pos = commit_graph_position(c);
-       if (graph_pos == COMMIT_NOT_FROM_GRAPH)
+       uint32_t graph_pos;
+       if (!find_commit_in_graph(c, g, &graph_pos))
                return 0;

        while (g && graph_pos < g->num_commits_in_base)

...but adding something like:

diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index a7a3b41919..571676cef2 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -310,4 +310,29 @@ test_expect_success 'Bloom generation backfills previously-skipped filters' '
        )
 '

+test_expect_success 'Bloom generation backfills empty commits' '
+       git init empty &&
+       test_when_finished "rm -fr empty" &&
+       (
+               cd empty &&
+               for i in $(test_seq 1 6)
+               do
+                       git commit --allow-empty -m "$i"
+               done &&
+
+               # Generate Bloom filters for empty commits 1-6, two at a time.
+               test_bloom_filters_computed "--reachable --changed-paths --max-new-filters=2" \
+                       0 2 2 &&
+               test_bloom_filters_computed "--reachable --changed-paths --max-new-filters=2" \
+                       2 2 2 &&
+               test_bloom_filters_computed "--reachable --changed-paths --max-new-filters=2" \
+                       4 2 2 &&
+
+               # Finally, make sure that once all commits have filters, that
+               # none are subsequently recomputed.
+               test_bloom_filters_computed "--reachable --changed-paths --max-new-filters=2" \
+                       6 0 0
+       )
+'
+
 test_done

is a good idea to harden what you wrote in your t9999 into an actual
test to prevent against regression. I'll fold both of those into this
patch.

Thanks for the bug report. It led to an interesting investigation as a
result :).

Thanks,
Taylor
