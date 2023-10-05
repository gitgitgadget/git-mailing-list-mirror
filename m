Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B509E92FC1
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 21:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjJEVDP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 17:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjJEVDO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 17:03:14 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5A893
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 14:03:13 -0700 (PDT)
Received: (qmail 26836 invoked by uid 109); 5 Oct 2023 21:03:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Oct 2023 21:03:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29180 invoked by uid 111); 5 Oct 2023 21:03:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Oct 2023 17:03:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Oct 2023 17:03:12 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 08/10] commit-graph: free write-context entries before
 overwriting
Message-ID: <20231005210312.GB981206@coredump.intra.peff.net>
References: <20231003202504.GA7697@coredump.intra.peff.net>
 <20231003203055.GH7812@coredump.intra.peff.net>
 <ZR73rpsKiTBF/rYj@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZR73rpsKiTBF/rYj@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 05, 2023 at 01:51:42PM -0400, Taylor Blau wrote:

> @@ -1033,11 +1033,11 @@ struct write_commit_graph_context {
>  	uint64_t progress_cnt;
> 
>  	char *base_graph_name;
> -	int num_commit_graphs_before;
> -	int num_commit_graphs_after;
> -	char **commit_graph_filenames_before;
> -	char **commit_graph_filenames_after;
> -	char **commit_graph_hash_after;
> +	struct {
> +		size_t nr;
> +		char **fname;
> +		char **hash;
> +	} graphs_before, graphs_after;
>  	uint32_t new_num_commits_in_base;
>  	struct commit_graph *new_base_graph;
> --- >8 ---
> 
> ...making the corresponding changes throughout the rest of the file. But
> that is definitely out of scope here, and could easily be left for
> another day.

I agree that it would make things a bit more readable, but there
currently is no "hash_before". So they're not quite symmetric.

-Peff
