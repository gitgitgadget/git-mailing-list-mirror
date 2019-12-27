Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2948C2D0C6
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 16:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C7520740
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 16:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUtDr4i1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfL0QLj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 11:11:39 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37211 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfL0QLj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 11:11:39 -0500
Received: by mail-qt1-f195.google.com with SMTP id w47so24878728qtk.4
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 08:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zvCjb5nsJtr8SfP3t8udVBR3wVd8zmbR05Gf9VTNRfM=;
        b=IUtDr4i1sOm500XGlv79QnmaREvhZbQSYJ76JsC3NFt25US6+EefFR85hj9OYFI8hN
         K2rSF1cUbKiQ/yhrvyaGgva+CTHRtdVENdKjW+A1buikAEBEW8EYs/bqTXpwaKj+Dj5J
         40OLjWcAlKr5gQddW8M1moeDtdlUjuiZA7OrxhEz2puglBtZcc4NWEssPzFKPogZlY7l
         sPTSMAjRqInd7vTZ4y0wegfhgSAZNOWbXhzjPsDDobC3QNFYBM0FAKVoJ871rHq0w/1U
         ha5brSIxwogIBWg86phroCMCp2klDOWuuXeM4qE94RhuSnA0wnlXqQA7QJJomwtk+zpu
         eEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zvCjb5nsJtr8SfP3t8udVBR3wVd8zmbR05Gf9VTNRfM=;
        b=Rq/X1JfefmPqyNBkW7jSnH+r4OXbsbuo57YIRC8Jv5febKCyVj49fBxlAhbGEWabLJ
         5Q8mo1BoFPYiV3KyT4bYH/7lKJshjD53+umU9k8e6vWMxD2b5EKLNOwyQ+KKG9WSaFrY
         U9OpJ30NfsizDw3Mi2JujCCetJkKDoiu+jqzRT0B4+6Svz1NLmCEfcIXoG0lXK6jmIu0
         iDdo8bj49ZJUcNiEK8verFSnSiC2JHmiqufRn4YL55swObdVDr4AOEYJEhrToywefHun
         VmyNMmdIAVUIXEvjDs/j9zWEJanW57/q8+FyD8WsCgLG628Sm4G20BIr1g/AHTwDbkic
         bnnw==
X-Gm-Message-State: APjAAAV7zqyudEJuRSRpCru9fBrM3mDti4UuJHP/WKxW5Rmj65Id2Rwr
        ICnEzy0dl9sIOsRXNjc7nuI=
X-Google-Smtp-Source: APXvYqw5hHLya0q/yTwzDW/S0FIoftlHwncjRyPc5lIHkdxODz615Q+KToZJ53e3Cf5Sh+EGxgnzJQ==
X-Received: by 2002:ac8:7b9a:: with SMTP id p26mr39100664qtu.281.1577463098391;
        Fri, 27 Dec 2019 08:11:38 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:9d29:38a1:5885:e8b3? ([2001:4898:a800:1010:4e5f:38a1:5885:e8b3])
        by smtp.gmail.com with ESMTPSA id d8sm10548668qtr.53.2019.12.27.08.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2019 08:11:37 -0800 (PST)
Subject: Re: [PATCH 0/9] [RFC] Changed Paths Bloom Filters
To:     Jeff King <peff@peff.net>,
        Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        Junio C Hamano <gitster@pobox.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
 <20191222093036.GA3449072@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e9a4e4ff-5466-dc39-c3f5-c9a8b8f2f11d@gmail.com>
Date:   Fri, 27 Dec 2019 11:11:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20191222093036.GA3449072@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/22/2019 4:30 AM, Jeff King wrote:
> On Fri, Dec 20, 2019 at 10:05:11PM +0000, Garima Singh via GitGitGadget wrote:
> 
>> Adopting changed path bloom filters has been discussed on the list before,
>> and a prototype version was worked on by SZEDER Gábor, Jonathan Tan and Dr.
>> Derrick Stolee [1]. This series is based on Dr. Stolee's approach [2] and
>> presents an updated and more polished RFC version of the feature.
> 
> Great to see progress here. I probably won't have time to review this
> carefully before the new year, but I did notice some low-hanging fruit
> on the generation side.
> 
> So here are a few patches to reduce the CPU and memory usage. They could
> be squashed in at the appropriate spots, or perhaps taken as inspiration
> if there are better solutions (especially for the first one).

I tested these patches with the Linux kernel repo and reported my results
on each patch. However, I wanted to also test on a larger internal repo
(the AzureDevOps repo), which has ~500 commits with more than 512 changes,
and generally has larger diffs than the Linux kernel repo.

| Version  | Time   | Memory |
|----------|--------|--------|
| Garima   | 16m36s | 27.0gb |
| Peff 1   | 6m32s  | 28.0gb |
| Peff 2   | 6m48s  |  5.6gb |
| Peff 3   | 6m14s  |  4.5gb |
| Shortcut | 3m47s  |  4.5gb |

For reference, I found the time and memory information using
"/usr/bin/time --verbose" in a bash script.
 
> I think we could go further still, by actually doing a non-recursive
> diff_tree_oid(), and then recursing into sub-trees ourselves. That would
> save us having to split apart each path to add the leading paths to the
> hashmap (most of which will be duplicates if the commit touched "a/b/c"
> and "a/b/d", etc). I doubt it would be that huge a speedup though. We
> have to keep a list of the touched paths anyway (since the bloom key
> parameters depend on the number of entries), and most of the time is
> almost certainly spent inflating the trees in the first place. However
> it might be easier to follow the code, and it would make it simpler to
> stop traversing at the 512-entry limit, rather than generating a huge
> diff only to throw it away.

By "Shortcut" in the table above, I mean the following patch on top of
Garima's and Peff's changes. It inserts a max_changes option into struct
diff_options to halt the diff early. This seemed like an easier change
than creating a new tree diff algorithm wholesale.

Thanks,
-Stolee

-->8--

From: Derrick Stolee <dstolee@microsoft.com>
Date: Fri, 27 Dec 2019 10:13:48 -0500
Subject: [PATCH] diff: halt tree-diff early after max_changes

When computing the changed-paths bloom filters for the commit-graph,
we limit the size of the filter by restricting the number of paths
in the diff. Instead of computing a large diff and then ignoring the
result, it is better to halt the diff computation early.

Create a new "max_changes" option in struct diff_options. If non-zero,
then halt the diff computation after discovering strictly more changed
paths. This includes paths corresponding to trees that change.

Use this max_changes option in the bloom filter calculations. This
reduces the time taken to compute the filters for the Linux kernel
repo from 2m50s to 2m35s. For a larger repo with more commits changing
many paths, the time reduces from 6 minutes to under 4 minutes.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 bloom.c     | 4 +++-
 diff.h      | 5 +++++
 tree-diff.c | 5 +++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/bloom.c b/bloom.c
index ea77631cc2..83dde2378b 100644
--- a/bloom.c
+++ b/bloom.c
@@ -155,6 +155,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 	struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 	int i;
 	struct diff_options diffopt;
+	int max_changes = 512;
 
 	filter = bloom_filter_slab_at(&bloom_filters, c);
 
@@ -171,6 +172,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 
 	repo_diff_setup(r, &diffopt);
 	diffopt.flags.recursive = 1;
+	diffopt.max_changes = max_changes;
 	diff_setup_done(&diffopt);
 
 	if (c->parents)
@@ -179,7 +181,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 		diff_tree_oid(NULL, &c->object.oid, "", &diffopt);
 	diffcore_std(&diffopt);
 
-	if (diff_queued_diff.nr <= 512) {
+	if (diff_queued_diff.nr <= max_changes) {
 		struct hashmap pathmap;
 		struct pathmap_hash_entry* e;
 		struct hashmap_iter iter;
diff --git a/diff.h b/diff.h
index 6febe7e365..9443dc1b00 100644
--- a/diff.h
+++ b/diff.h
@@ -285,6 +285,11 @@ struct diff_options {
 	/* Number of hexdigits to abbreviate raw format output to. */
 	int abbrev;
 
+	/* If non-zero, then stop computing after this many changes. */
+	int max_changes;
+	/* For internal use only. */
+	int num_changes;
+
 	int ita_invisible_in_index;
 /* white-space error highlighting */
 #define WSEH_NEW (1<<12)
diff --git a/tree-diff.c b/tree-diff.c
index 33ded7f8b3..16a21d9f34 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -434,6 +434,9 @@ static struct combine_diff_path *ll_diff_tree_paths(
 		if (diff_can_quit_early(opt))
 			break;
 
+		if (opt->max_changes && opt->num_changes > opt->max_changes)
+			break;
+
 		if (opt->pathspec.nr) {
 			skip_uninteresting(&t, base, opt);
 			for (i = 0; i < nparent; i++)
@@ -518,6 +521,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
 
 			/* t↓ */
 			update_tree_entry(&t);
+			opt->num_changes++;
 		}
 
 		/* t > p[imin] */
@@ -535,6 +539,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
 		skip_emit_tp:
 			/* ∀ pi=p[imin]  pi↓ */
 			update_tp_entries(tp, nparent);
+			opt->num_changes++;
 		}
 	}
 
-- 
2.25.0.rc0

