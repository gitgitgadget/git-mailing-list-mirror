Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F5A01F463
	for <e@80x24.org>; Thu, 12 Sep 2019 12:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbfILMbK (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 08:31:10 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36342 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731283AbfILMbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 08:31:09 -0400
Received: by mail-yb1-f196.google.com with SMTP id m9so8585572ybm.3
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 05:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3pt1tDhFyln2nHucumcY/pZDvad8QJv+0MThFMji2Pg=;
        b=UXbwsyldIsP4DsEPobpk21j4UWdi2FUePcmpoeUGSDGlF1A5ZNgavT9ELPYL4bHVzK
         Jm+dMe7+EJKB7y0tWL/LTIQaeZEmw9PYwb6/H0bHiygTfKcpnz7dOUuVPO8X0YUgaoiD
         K2aEmpzCuHx5Eq8jEpbLLJRhhti6DSWzHpVNjZvXt5jngPKdBGlapK1HiTkz9qKszRAg
         hIk2lF5ssTNkYbsU2yRTbojT1/rvPPNEp+vr5rZjGiOobEfk1co8MP6W6+zBXzQ0h31N
         mcbVs+KjUnigq/Jj2V/PsImenXy8sgPlTxsixdBXBULveRESjalvyv+r2L31MyCdblma
         KrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3pt1tDhFyln2nHucumcY/pZDvad8QJv+0MThFMji2Pg=;
        b=uL+K+GTjWqRwex4fq+0eklfycBvXfzrD3tIGpCqiemK5Uf9jOqmdndgBZAyJSW4KPs
         4Gd60EtHEGYZ3ZmUVPZmt2IEqgWVMhFHxabTpTE1DLZMUAgFJV5o6CiwSCzfBlXA/wNb
         7K40lEKHOP2FsQQKXnmzouFufkI2I9IPc0Kmq/EFO2rHtnodYb/T7ra7ekC5OKoTfqTq
         obIeIOvkZ76N4AAhZKWshUwwxK2YKf5RcMmeM44CqUDueeQvIklBAiNvcauFVRiPaU+D
         7MQ0VFS+FJEYr9GnaWe/HGD68/UXLQBXK6yr3vktyUqJZLZB5ynlQaARrhEYmt9YUkO8
         4Tsw==
X-Gm-Message-State: APjAAAXtppoeUSujKbYUKXrYiFV47etkGrqhcYKn46BHIZjSq5n3gPYL
        gOlmODUiUegHRiIzwo4kl5akF9Db
X-Google-Smtp-Source: APXvYqyeYWRTxP402BQi8Q7xZElUCJW4Bk5fOvIzwvSz+XNtOQdbRLwMYqI6pBzj6zKOnJlwK/Jt+w==
X-Received: by 2002:a25:e750:: with SMTP id e77mr1631869ybh.492.1568291468495;
        Thu, 12 Sep 2019 05:31:08 -0700 (PDT)
Received: from [192.168.1.9] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id v62sm5158964ywc.105.2019.09.12.05.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2019 05:31:07 -0700 (PDT)
Subject: Re: [PATCH] list-objects: don't queue root trees unless
 revs->tree_objects is set
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20190912000414.GA31334@sigill.intra.peff.net>
 <20190912001846.GA31370@sigill.intra.peff.net>
 <20190912011137.GA23412@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b2a4e32c-eb0b-d4b1-a44d-6587a6a77560@gmail.com>
Date:   Thu, 12 Sep 2019 08:31:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190912011137.GA23412@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/11/2019 9:11 PM, Jeff King wrote:
> On Wed, Sep 11, 2019 at 08:18:46PM -0400, Jeff King wrote:
> 
>>> That creates an interesting problem for commits that have _already_ been
>>> parsed using the commit graph. Their commit->object.parsed flag is set,
>>> their commit->graph_pos is set, but their commit->maybe_tree may still
>>> be NULL. When somebody later calls repo_get_commit_tree(), we see that
>>> we haven't loaded the tree oid yet and try to get it from the commit
>>> graph. But since it has been freed, we segfault!
>>
>> I was surprised we ever called repo_get_commit_tree() at all, since
>> we're literally just traversing commits here. It looks like
>> list-objects.c is very happy to queue pending trees for each commit,
>> even if we're just going to throw them away when we get to
>> process_tree()! I wonder if could be checking revs->tree_objects here
>> and saving ourselves some work.
> 
> Indeed, this seems to help quite a bit in the commit-graph case. I think
> it's worth doing (and is independent of the other patch).

Good find!

> -- >8 --
> Subject: list-objects: don't queue root trees unless revs->tree_objects is set
> 
> When traverse_commit_list() processes each commit, it queues the
> commit's root tree in the pending array. Then, after all commits are
> processed, it calls traverse_trees_and_blobs() to walk over the pending
> list, calling process_tree() on each. But if revs->tree_objects is not
> set, process_tree() just exists immediately!
> 
> We can save ourselves some work by not even bothering to queue these
> trees in the first place. There are a few subtle points to make:
> 
>   - we also detect commits with a NULL tree pointer here. But this isn't
>     an interesting check for broken commits, since the lookup_tree()
>     we'd have done during commit parsing doesn't actually check that we
>     have the tree on disk. So we're not losing any robustness.
> 
>   - besides queueing, we also set the NOT_USER_GIVEN flag on the tree
>     object. This is used by the traverse_commit_list_filtered() variant.
>     But if we're not exploring trees, then we won't actually care about
>     this flag, which is used only inside process_tree() code-paths.
> 
>   - queueing trees eventually leads to us queueing blobs, too. But we
>     don't need to check revs->blob_objects here. Even in the current
>     code, we still wouldn't find those blobs, because we'd never open up
>     the tree objects to list their contents.
> 
>   - the user-visible impact to the caller is minimal. The pending trees
>     are all cleared by the time the function returns anyway, by
>     traverse_trees_and_blobs(). We do call a show_commit() callback,
>     which technically could be looking at revs->pending during the
>     callback. But it seems like a rather unlikely thing to do (if you
>     want the tree of the current commit, then accessing the tree struct
>     member is a lot simpler).

These all look reasonable. We shouldn't need to do any of that any more.

> So this should be safe to do. Let's look at the benefits:
> 
>   [before]
>   Benchmark #1: git -C linux rev-list HEAD >/dev/null
>     Time (mean ± σ):      7.651 s ±  0.021 s    [User: 7.399 s, System: 0.252 s]
>     Range (min … max):    7.607 s …  7.683 s    10 runs
> 
>   [after]
>   Benchmark #1: git -C linux rev-list HEAD >/dev/null
>     Time (mean ± σ):      7.593 s ±  0.023 s    [User: 7.329 s, System: 0.264 s]
>     Range (min … max):    7.565 s …  7.634 s    10 runs
> 
> Not too impressive, but then we're really just avoiding sticking a
> pointer into a growable array. But still, I'll take a free 0.75%
> speedup.
> 
> Let's try it after running "git commit-graph write":
> 
>   [before]
>   Benchmark #1: git -C linux rev-list HEAD >/dev/null
>     Time (mean ± σ):      1.458 s ±  0.011 s    [User: 1.199 s, System: 0.259 s]
>     Range (min … max):    1.447 s …  1.481 s    10 runs
> 
>   [after]
>   Benchmark #1: git -C linux rev-list HEAD >/dev/null
>     Time (mean ± σ):      1.126 s ±  0.023 s    [User: 896.5 ms, System: 229.0 ms]
>     Range (min … max):    1.106 s …  1.181 s    10 runs
> 
> Now that's more like it. We saved over 22% of the total time. Part of
> that is because the runtime is shorter overall, but the absolute
> improvement is also much larger. What's going on?

Very cool.

> When we fill in a commit struct using the commit graph, we don't bother
> to set the tree pointer, and instead lazy-load it when somebody calls
> get_commit_tree(). So we're not only skipping the pointer write to the
> pending queue, but we're skipping the lazy-load of the tree entirely.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  list-objects.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/list-objects.c b/list-objects.c
> index b5651ddd5b..c837bcaca8 100644
> --- a/list-objects.c
> +++ b/list-objects.c
> @@ -370,7 +370,9 @@ static void do_traverse(struct traversal_context *ctx)
>  		 * an uninteresting boundary commit may not have its tree
>  		 * parsed yet, but we are not going to show them anyway
>  		 */
> -		if (get_commit_tree(commit)) {
> +		if (!ctx->revs->tree_objects)
> +			; /* do not bother loading tree */
> +		else if (get_commit_tree(commit)) {
>  			struct tree *tree = get_commit_tree(commit);
>  			tree->object.flags |= NOT_USER_GIVEN;
>  			add_pending_tree(ctx->revs, tree);

And a simple code fix. LGTM.

Thanks!
-Stolee
