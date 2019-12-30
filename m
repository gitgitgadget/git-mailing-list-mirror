Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB17C2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 14:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF8B20722
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 14:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9Wi6yRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfL3Ohb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 09:37:31 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33805 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfL3Ohb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 09:37:31 -0500
Received: by mail-qk1-f194.google.com with SMTP id j9so26756975qkk.1
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 06:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ev8OwRwsT1PPAfhkdwVkXGSdXVHVu+aOJPkWLHfN7SA=;
        b=K9Wi6yRygYI4z5iGX2x7PHrBq7FptFlsCnJgFfps8PcEdJr1j6+42VuGmLuI0Fw+he
         PPIuyQPL/f5Pl2uai4eSvoGkLg86TalhkvWZM348SYhYdkSiIq4Sy1HIgBYE94S8mwdG
         rDbPa6pGdPiziIk8tj/uFveiMEHT03gOPeSkyUbplV3SG2foNSa5VzJ2OJExEPbz2Cc7
         zg0aORFcdldhTkTaa9NGXJjvmK4nT/lIdRYL7h5IhOg/40CqAU8N1CUh/UwFlJw3QBb6
         RNsgeX26jtfgVqNMqUjg6olIOxvI/GdJbBpByOglAqwMnOoMbnz5fVOhbT/ZoM/ynxF7
         x+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ev8OwRwsT1PPAfhkdwVkXGSdXVHVu+aOJPkWLHfN7SA=;
        b=uccEszaEg0Cee7CtT/mDJa1qaLTYl1cMDJzOu4gMiYtdNC8YFQRWwFCW6E/6HKCWNK
         oJrgpbw7g2/UgdbWBoKAO9Csb6fpebdO8J9tKz/USTWInXQ+EUwJuiUE/dsHZ2MJzPjo
         apstweBl7p+BrLSAFS0AEOrGVuA8yTN2WsVtndoXJdNiSLq+kUZBg+B7v8HKy0ws6YiV
         B7yd652Q/zHBOb+01eHf7KxirN39zgdShFbWLlq6YVyfe4NVIaig+JnHc/qsqTB9ZoXr
         Ll5NYtfDnqhdW6MAKDSA04Lumd1FkParZKYFGFdgAXVnGsArxxZganKAUYwehZ24pHWh
         kcaA==
X-Gm-Message-State: APjAAAVZ+KZ9qfUkPBBYNwhJtng02yZD29d03PbX97VbrBsS0/v/CpK4
        zaAQFxdWMiNopXgyJwekAKg=
X-Google-Smtp-Source: APXvYqzNtjg/XueSJ8GsZPZSqnvBysk1uVg1j+JLdE31NwRgiG85GlnEl42j1LZU+Vkf23wcAjwiOQ==
X-Received: by 2002:a37:9dcd:: with SMTP id g196mr55854925qke.168.1577716649587;
        Mon, 30 Dec 2019 06:37:29 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:58a9:3b9:96c0:ccb8? ([2001:4898:a800:1010:9df:3b9:96c0:ccb8])
        by smtp.gmail.com with ESMTPSA id a24sm12468458qkl.82.2019.12.30.06.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2019 06:37:29 -0800 (PST)
Subject: Re: [PATCH 1/3] commit-graph: examine changed-path objects in pack
 order
To:     Jeff King <peff@peff.net>
Cc:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        Junio C Hamano <gitster@pobox.com>
References: <20191222093036.GA3449072@coredump.intra.peff.net>
 <20191222093206.GA3460818@coredump.intra.peff.net>
 <8b331ef6-f431-56ef-37a9-1d6e263ea0fe@gmail.com>
 <20191229061246.GB220034@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b9bd0c2e-63fc-5658-7a24-b8ab078acd44@gmail.com>
Date:   Mon, 30 Dec 2019 09:37:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20191229061246.GB220034@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/29/2019 1:12 AM, Jeff King wrote:
> On Fri, Dec 27, 2019 at 09:51:02AM -0500, Derrick Stolee wrote:
> 
>> On 12/22/2019 4:32 AM, Jeff King wrote:
>>> Looking at the diff of commit objects in pack order is much faster than
>>> in sha1 order, as it gives locality to the access of tree deltas
>>> (whereas sha1 order is effectively random). Unfortunately the
>>> commit-graph code sorts the commits (several times, sometimes as an oid
>>> and sometimes a pointer-to-commit), and we ultimately traverse in sha1
>>> order.
>>>
>>> Instead, let's remember the position at which we see each commit, and
>>> traverse in that order when looking at bloom filters. This drops my time
>>> for "git commit-graph write --changed-paths" in linux.git from ~4
>>> minutes to ~1.5 minutes.
>>
>> I'm doing my own perf tests on these patches, and my copy of linux.git
>> has four packs of varying sizes (corresponding with my rare fetches and
>> lack of repacks). My time goes from 3m50s to 3m00s. I was confused at
>> first, but then realized that I used the "--reachable" flag. In that
>> case, we never run set_commit_pos(), so all positions are equal and the
>> sort is not helpful.
>>
>> I thought that inserting some set_commit_pos() calls into close_reachable()
>> and add_missing_parents() would give some amount of time-order to the
>> commits as we compute the filters. However, the time did not change at
>> all.
>>
>> I've included the patch below for reference, anyway.
> 
> Yeah, I expected that would cover it, too. But instrumenting it to dump
> the position of each commit (see patch below), and then decorating "git
> log" output with the positions (see script below) shows that we're all
> over the map:
> 
>   *   3
>   |\  
>   | * 2791
>   | * 5476
>   | * 8520
>   | * 12040
>   | * 16036
>   * |   2790
>   |\ \  
>   | * | 5475
>   | * | 8519
>   | * | 12039
>   | * | 16035
>   | * | 20517
>   | * | 25527
>   | |/  
>   * |   5474
>   |\ \  
>   | * | 8518
>   | * | 12038
>   * | |   8517
>   [...]

This makes a lot of sense why the previous approach did not work. Thanks!

> I think the root issue is that we never do any date-sorting on the
> commits. So:
> 
>   - we hit each ref tip in lexical order; with tags, this is quite often
>     the opposite of reverse-chronological
> 
>   - we traverse breadth-first, but we don't order queue at all. So if we
>     see a merge X, then we'll next process X^1 and X^2, and then X^1^,
>     and then X^2^, and so forth. So we keep digging equally down
>     simultaneous branches, even if one branch is way shorter than the
>     other. Whereas a regular Git traversal will order the queue by
>     commit timestamp, so it tends to be roughly chronological (of course
>     a topo-sort would work too, but that's probably overkill).
> 
> I wonder if this would be simpler if "commit-graph --reachable" just
> used the regular revision machinery instead of doing its own custom
> traversal.

Instead, why not use our already-computed generation numbers? That seems
to improve the time a bit. (6m30s to 4m50s)

-->8--

From: Derrick Stolee <dstolee@microsoft.com>
Date: Fri, 27 Dec 2019 09:47:49 -0500
Subject: [PATCH] commit-graph: examine commits by generation number

When running 'git commit-graph write --changed-paths', we sort the
commits by pack-order to save time when computing the changed-paths
bloom filters. This does not help when finding the commits via the
--reachable flag.

If not using pack-order, then sort by generation number before
examining the diff. Commits with similar generation are more likely
to have many trees in common, making the diff faster.

On the Linux kernel repository, this change reduced the computation
time for 'git commit-graph write --reachable --changed-paths' from
6m30s to 4m50s.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index bf6c663772..fe4ab545f2 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -72,6 +72,25 @@ static int commit_pos_cmp(const void *va, const void *vb)
 	       commit_pos_at(&commit_pos, b);
 }
 
+static int commit_gen_cmp(const void *va, const void *vb)
+{
+	const struct commit *a = *(const struct commit **)va;
+	const struct commit *b = *(const struct commit **)vb;
+
+	/* lower generation commits first */
+	if (a->generation < b->generation)
+		return -1;
+	else if (a->generation > b->generation)
+		return 1;
+
+	/* use date as a heuristic when generations are equal */
+	if (a->date < b->date)
+		return -1;
+	else if (a->date > b->date)
+		return 1;
+	return 0;
+}
+
 char *get_commit_graph_filename(const char *obj_dir)
 {
 	char *filename = xstrfmt("%s/info/commit-graph", obj_dir);
@@ -849,7 +868,8 @@ struct write_commit_graph_context {
 		 report_progress:1,
 		 split:1,
 		 check_oids:1,
-		 bloom:1;
+		 bloom:1,
+		 order_by_pack:1;
 
 	const struct split_commit_graph_opts *split_opts;
 	uint32_t total_bloom_filter_size;
@@ -1245,7 +1265,11 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 
 	ALLOC_ARRAY(sorted_by_pos, ctx->commits.nr);
 	COPY_ARRAY(sorted_by_pos, ctx->commits.list, ctx->commits.nr);
-	QSORT(sorted_by_pos, ctx->commits.nr, commit_pos_cmp);
+
+	if (ctx->order_by_pack)
+		QSORT(sorted_by_pos, ctx->commits.nr, commit_pos_cmp);
+	else
+		QSORT(sorted_by_pos, ctx->commits.nr, commit_gen_cmp);
 
 	for (i = 0; i < ctx->commits.nr; i++) {
 		struct commit *c = sorted_by_pos[i];
@@ -1979,6 +2003,7 @@ int write_commit_graph(const char *obj_dir,
 	}
 
 	if (pack_indexes) {
+		ctx->order_by_pack = 1;
 		if ((res = fill_oids_from_packs(ctx, pack_indexes)))
 			goto cleanup;
 	}
@@ -1988,8 +2013,10 @@ int write_commit_graph(const char *obj_dir,
 			goto cleanup;
 	}
 
-	if (!pack_indexes && !commit_hex)
+	if (!pack_indexes && !commit_hex) {
+		ctx->order_by_pack = 1;
 		fill_oids_from_all_packs(ctx);
+	}
 
 	close_reachable(ctx);
 
-- 
2.25.0.rc0



