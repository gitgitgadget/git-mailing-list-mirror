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
	by dcvr.yhbt.net (Postfix) with ESMTP id 84F101F463
	for <e@80x24.org>; Thu, 12 Sep 2019 12:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbfILMXw (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 08:23:52 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46152 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731436AbfILMXw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 08:23:52 -0400
Received: by mail-yb1-f194.google.com with SMTP id y194so8558449ybe.13
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 05:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P8Gj7c7X5weG0Q1j9ZwUbCR68E2+XooJFFpkfy46VK0=;
        b=ughjpKP5olV3QKpJ7clPSdFbWlX4c9LcSuaClzdgXbCuvzQ0ogsVCb49rEvaDzj2E1
         F3fyWFsVFpp/tkjLxEsnieDCqznoO0l4KvPuuJzTKF/8t1qmrimUver8L6ZNTrSVul9h
         GXMEycgWkpuTvtBdzChl/LOfdSZhnpxk/tpgEIXKhPOXVWMFiTKB2vTZEGNtqq6sylFB
         QvtVSn3PtG+SfLpSppDcMdDJ/qSIF5ht2YZz4Fr2xb8O8fE+UAETWTmUxWPfdA67Om0z
         zCcvaCJvBf7R6jloUg4drnqc6glayE4GT/4ogiJ26tNlb/bi7O6bauW7dLxQDDPoRVmS
         PCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P8Gj7c7X5weG0Q1j9ZwUbCR68E2+XooJFFpkfy46VK0=;
        b=aXEE6a/3nIMVcuxPral2N3P1SHa+tAiwLq7XgUeevSW+8Gi7SEdwDn+885Hl3xCfws
         oSq4vBFG7Pac6vu94p3aYgIhRxZcrerceNCyIG17c3bu1lQzUPlJynySooF2idtgBWV2
         FRMPO7+7twSxExf3kvrezVoPMzoiLHbyZz3ErfPtkgtyWsVwDzNCeK1Qzgk6dcIWfbvS
         g7zNBYkNXCicOCZg21GX6jKWb9Gu9iui7qizr5+Sw6R369EBXRSx5As+oiQNIdMjY9cd
         0ys2W2Yk1RYdbx/7/yD/x3h5Zk3/GfyFiUvV1RZ+i1Q8Nrw05mQ832q70MhdOvNICoGH
         LOgQ==
X-Gm-Message-State: APjAAAXsGltnVNsUtK+3iQzw94cKGzzMXtQC6YlK35m0LpiMiqLOx+Ax
        hJt/0OMi0rotxlhwfFn18UY=
X-Google-Smtp-Source: APXvYqxvUuSX81b9/3uaLXCQ8ZO6u+oHx8UtTy8wn/wqcEmtH5d7WsiMTPiH4pr0bRS7mDxCwBNH/w==
X-Received: by 2002:a25:414:: with SMTP id 20mr1620399ybe.212.1568291031243;
        Thu, 12 Sep 2019 05:23:51 -0700 (PDT)
Received: from [192.168.1.9] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id l11sm4893002ywh.34.2019.09.12.05.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2019 05:23:50 -0700 (PDT)
Subject: Re: [PATCH] upload-pack: disable commit graph more gently for shallow
 traversal
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20190912000414.GA31334@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fdb81ce0-20ee-5880-2a6c-0c8b3f1739b9@gmail.com>
Date:   Thu, 12 Sep 2019 08:23:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190912000414.GA31334@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/11/2019 8:04 PM, Jeff King wrote:
> When the client has asked for certain shallow options like
> "deepen-since", we do a custom rev-list walk that pretends to be
> shallow. Before doing so, we have to disable the commit-graph, since it
> is not compatible with the shallow view of the repository. That's
> handled by 829a321569 (commit-graph: close_commit_graph before shallow
> walk, 2018-08-20). That commit literally closes and frees our
> repo->objects->commit_graph struct.
> 
> That creates an interesting problem for commits that have _already_ been
> parsed using the commit graph. Their commit->object.parsed flag is set,
> their commit->graph_pos is set, but their commit->maybe_tree may still
> be NULL. When somebody later calls repo_get_commit_tree(), we see that
> we haven't loaded the tree oid yet and try to get it from the commit
> graph. But since it has been freed, we segfault!

OOPS! That is certainly a bad thing. I'm glad you found it, but I
am sorry for how you (probably) found it.

> So the root of the issue is a data dependency between the commit's
> lazy-load of the tree oid and the fact that the commit graph can go
> away mid-process. How can we resolve it?
> 
> There are a couple of general approaches:
> 
>   1. The obvious answer is to avoid loading the tree from the graph when
>      we see that it's NULL. But then what do we return for the tree oid?
>      If we return NULL, our caller in do_traverse() will rightly
>      complain that we have no tree. We'd have to fallback to loading the
>      actual commit object and re-parsing it. That requires teaching
>      parse_commit_buffer() to understand re-parsing (i.e., not starting
>      from a clean slate and not leaking any allocated bits like parent
>      list pointers).
> 
>   2. When we close the commit graph, walk through the set of in-memory
>      objects and clear any graph_pos pointers. But this means we also
>      have to "unparse" any such commits so that we know they still need
>      to open the commit object to fill in their trees. So it's no less
>      complicated than (1), and is more expensive (since we clear objects
>      we might not later need).
> 
>   3. Stop freeing the commit-graph struct. Continue to let it be used
>      for lazy-loads of tree oids, but let upload-pack specify that it
>      shouldn't be used for further commit parsing.
> 
>   4. Push the whole shallow rev-list out to its own sub-process, with
>      the commit-graph disabled from the start, giving it a clean memory
>      space to work from.
> 
> I've chosen (3) here. Options (1) and (2) would work, but are
> non-trivial to implement. Option (4) is more expensive, and I'm not sure
> how complicated it is (shelling out for the actual rev-list part is
> easy, but we do then parse the resulting commits internally, and I'm not
> clear which parts need to be handling shallow-ness).

I agree that (3) is the best option. The commit-graph is just a database
of commit data, and we are choosing to interpret the parent data differently.
The tree data is perfectly good.

> The new test in t5500 triggers this segfault, but see the comments there
> for how horribly intimate it has to be with how both upload-pack and
> commit graphs work.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  commit-graph.c        | 10 ++++++++++
>  commit-graph.h        |  6 ++++++
>  t/t5500-fetch-pack.sh | 38 ++++++++++++++++++++++++++++++++++++++
>  upload-pack.c         |  2 +-
>  4 files changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/commit-graph.c b/commit-graph.c
> index 9b02d2c426..bc5dd5913f 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -41,6 +41,8 @@
>  #define GRAPH_MIN_SIZE (GRAPH_HEADER_SIZE + 4 * GRAPH_CHUNKLOOKUP_WIDTH \
>  			+ GRAPH_FANOUT_SIZE + the_hash_algo->rawsz)
>  
> +static int commit_graph_disabled;

Should we be putting this inside the repository struct instead?

> +
>  char *get_commit_graph_filename(const char *obj_dir)
>  {
>  	char *filename = xstrfmt("%s/info/commit-graph", obj_dir);
> @@ -472,6 +474,9 @@ static int prepare_commit_graph(struct repository *r)
>  		die("dying as requested by the '%s' variable on commit-graph load!",
>  		    GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD);
>  
> +	if (commit_graph_disabled)
> +		return 0;
> +
>  	if (r->objects->commit_graph_attempted)
>  		return !!r->objects->commit_graph;
>  	r->objects->commit_graph_attempted = 1;
> @@ -2101,3 +2106,8 @@ void free_commit_graph(struct commit_graph *g)
>  	free(g->filename);
>  	free(g);
>  }
> +
> +void disable_commit_graph(void)
> +{
> +	commit_graph_disabled = 1;
> +}

Then this would take a struct repository *r.

> diff --git a/commit-graph.h b/commit-graph.h
> index 486e64e591..42d6e7c289 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -107,4 +107,10 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
>  void close_commit_graph(struct raw_object_store *);
>  void free_commit_graph(struct commit_graph *);
>  
> +/*
> + * Disable further use of the commit graph in this process when parsing a
> + * "struct commit".
> + */
> +void disable_commit_graph(void);
> +
>  #endif
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 8210f63d41..7601664b74 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -783,6 +783,44 @@ test_expect_success 'clone shallow since selects no commits' '
>  	)
>  '
>  
> +# A few subtle things about the request in this test:
> +#
> +#  - the server must have commit-graphs present and enabled
> +#
> +#  - the history is such that our want/have share a common ancestor ("base"
> +#    here)
> +#
> +#  - we send only a single have, which is fewer than a normal client would
> +#    send. This ensures that we don't parse "base" up front with
> +#    parse_object(), but rather traverse to it as a parent while deciding if we
> +#    can stop the "have" negotiation, and call parse_commit(). The former
> +#    sees the actual object data and so always loads the three oid, whereas the
> +#    latter will try to lod it lazily.
> +#
> +#  - we must use protocol v2, because it handles the "have" negotiation before
> +#    processing the shallow direectives
> +#
> +test_expect_success 'shallow since with commit graph and already-seen commit' '
> +	test_create_repo shallow-since-graph &&
> +	(
> +	cd shallow-since-graph &&
> +	test_commit base &&
> +	test_commit master &&
> +	git checkout -b other HEAD^ &&
> +	test_commit other &&
> +	git commit-graph write --reachable &&
> +	git config core.commitGraph true &&
> +
> +	GIT_PROTOCOL=version=2 git upload-pack . <<-EOF >/dev/null
> +	0012command=fetch
> +	00010013deepen-since 1
> +	0032want $(git rev-parse other)
> +	0032have $(git rev-parse master)
> +	0000
> +	EOF
> +	)
> +'
> +
>  test_expect_success 'shallow clone exclude tag two' '
>  	test_create_repo shallow-exclude &&
>  	(
> diff --git a/upload-pack.c b/upload-pack.c
> index 222cd3ad89..a260b6b50d 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -722,7 +722,7 @@ static void deepen_by_rev_list(struct packet_writer *writer, int ac,
>  {
>  	struct commit_list *result;
>  
> -	close_commit_graph(the_repository->objects);
> +	disable_commit_graph();
>  	result = get_shallow_commits_by_rev_list(ac, av, SHALLOW, NOT_SHALLOW);
>  	send_shallow(writer, result);
>  	free_commit_list(result);
> 

Your patch does not seem to actually cover the "I've already parsed some commits"
case, as you are only preventing the commit-graph from being prepared. Instead,
we need to have a short-circuit inside parse_commit() to avoid future parsing
from the commit-graph file.

(I'm going to the rest of the thread messages now to see if I just repeated
someone else's concerns.)

Thanks,
-Stolee
