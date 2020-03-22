Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A767C4332E
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A22C20767
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="WVlOqSlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgCVAUI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 20:20:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41847 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbgCVAUI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 20:20:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id z65so5472247pfz.8
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 17:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=itcxSi2DiCxTJKjPR3y6POBrHkIkeDECQ6X/eYRPfN8=;
        b=WVlOqSlKKdoctLpop3mfb0ul9adFlJzXg/noyCkusXnpm91ZFdhkzqO3JM3B5qnrlH
         PcWAWQM9GZW0Zq1qMx3x88U9qL/6QefUU9aYyeYpE4b8IswRjrrqrfiAMu9Aj77RC9pu
         KwJ+dNSTZwo/b3l/5glpa4YvMWdLZw9SfXvw4K1NFaYNAj3RkX++u8NyqkqO/3LCIDxB
         6qSsnGBdsW2qEPi43BffIrbrHVg+YeWbqAzIX9LBrRGR+PRPikhH5ZmyYVhpOGsPVQB9
         bJQZ0DxCFWW3KVUL8ef62B03+qV/Ue+vLeYbK39Tr28KOprUf1aM7a6vNX4SV9ghJOr2
         52yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=itcxSi2DiCxTJKjPR3y6POBrHkIkeDECQ6X/eYRPfN8=;
        b=H0CeNBW1/EkG/kqr+/I8+Ct7EeOq21/+PR+s1a2u30uDqPARtZwhlDJt7bN8smy/Dc
         If2k1ANlnpQQxG5CwiH6iWZAOb7Ul0n3nRsIM4bYDTq/mHx0b4v2pcAE0LXQTsWVzQ2t
         jxO6sCoQyvv4GZPeDRi2TDMCAR0lk3u2nQ6z9EhG3YnQVUxbx2dAJkYCZ/D9iTcRd7aN
         qOVHnibsEouCLw5R9qa35cYa5SPBAwxlAOd+gcgaWirYfVUW3k4SSVuyoPDdHE33BCpO
         Y5Uglo0R3wiDa5cehiv2EbDyLXXNtslBohrKDeT9I7114o3grL7cb5MOY+X6Gx49Qn9p
         CEsg==
X-Gm-Message-State: ANhLgQ0+LgSM8pcEeOsVkG2Bmh20FOWMeqa4oxtwXfIsTeiZ529dkVoI
        ThwZIXGNZY9c7qvuFc2rwY1FiQ==
X-Google-Smtp-Source: ADFU+vvs/Ab6d6ZCTV0ODnr0mb43cODIdyGtf/NYvHrnTvWHeOvA8GPf9K0m3H8dNswPTfNNUdv0AA==
X-Received: by 2002:a63:8342:: with SMTP id h63mr15771207pge.141.1584836406751;
        Sat, 21 Mar 2020 17:20:06 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id p70sm8170294pjp.47.2020.03.21.17.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 17:20:06 -0700 (PDT)
Date:   Sat, 21 Mar 2020 18:20:05 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 1/1] commit-graph.c: avoid unnecessary tag dereference
 when merging
Message-ID: <20200322002005.GA48038@syl.local>
References: <cover.1584762087.git.me@ttaylorr.com>
 <4c79a9ea909ebff8c0987bcf95692da92e79bda4.1584762087.git.me@ttaylorr.com>
 <20200321050025.GA1438317@coredump.intra.peff.net>
 <20200321061141.GA30636@syl.local>
 <20200321070333.GB1441446@coredump.intra.peff.net>
 <xmqqfte1a6ew.fsf@gitster.c.googlers.com>
 <a0de34e3-3f60-1838-dbaf-2ee3dddc7c89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a0de34e3-3f60-1838-dbaf-2ee3dddc7c89@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 21, 2020 at 08:03:01PM -0400, Derrick Stolee wrote:
> On 3/21/2020 2:50 PM, Junio C Hamano wrote:
> > Do we need to worry about INFO_QUICK and SKIP_FETCH_OBJECT in this
> > codepath, by the way?
>
> I was coming back to this thread to bring up these exact flags for
> consideration. The good news is that in a partial clone with any
> amount of filtering we will still have all reachable commits, which
> are necessary for the commit-graph to make sense. The only ones that
> would fail has_object_file() are ones removed by GC, but they may
> still exist on the remote. So without SKIP_FETCH_OBJECT, we would
> generate a network call even if the server has GC'd to remove the
> commits. This gets particularly bad when the server returns all
> reachable objects from that commit!

That makes sense. Do you think something like this should be applied?

diff --git a/commit-graph.c b/commit-graph.c
index c7cfadc786..0097318798 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1594,6 +1594,7 @@ static void merge_commit_graph(struct write_commit_graph_context *ctx,
 {
        uint32_t i;
        uint32_t offset = g->num_commits_in_base;
+       int flags = OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT;

        ALLOC_GROW(ctx->commits.list, ctx->commits.nr + g->num_commits, ctx->commits.alloc);

@@ -1606,7 +1607,7 @@ static void merge_commit_graph(struct write_commit_graph_context *ctx,
                load_oid_from_graph(g, i + offset, &oid);

                /* only add commits if they still exist in the repo */
-               if (repo_has_object_file(ctx->r, &oid)) {
+               if (repo_has_object_file_with_flags(ctx->r, &oid, flags)) {
                        result = lookup_commit(ctx->r, &oid);
                        if (repo_parse_commit(ctx->r, result))
                                result = NULL;

> Thanks,
> -Stolee

Thanks,
Taylor
