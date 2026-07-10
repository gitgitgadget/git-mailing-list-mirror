Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525163793CC
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 18:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783707299; cv=none; b=u5V0paJak2xw2NMnJ6nnCGFezYzjA1q7X7dcuLBh6W4Darw90c3WQpy8qVF5HhdIQD8JhKwBxVgMCBtKG/delizXtk1V9kTl9RnXJ+t4Xuvm/M0XZhxb0ZkGHksuonAGu4PhSxGKhNdwIYjU6wnV5Bic3xkPoJmoyHl00Znwqao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783707299; c=relaxed/simple;
	bh=+NDUl/11y15VSlt08/9TGFVR/zyQ+y/tjGqpWkWjU9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvwkKe1ganmQH0MR39kQzLrwHILkJvvjTkdjac0c78Ug7pmgtQj0bVJstHa6Ieji06ZXImQBVu/6/NZXfz4faUSqdxa6Jv6NjTWJgjCFZmwh1tF84u09sIDOo0kdeLRwKIyKRb+1SgyPJCS1vtR5zFPLe5HOJtPzu1TySPQyuHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=VFSiOj3r; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="VFSiOj3r"
Date: Fri, 10 Jul 2026 20:07:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1783706830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bo5bStXI5DgHxr+nPvorEhVPZ8DFVf38XfR0NjW8aW0=;
	b=VFSiOj3rhjuJ+HkTxSW9HtMn7GZ6z4Fasi4yyfohHSxRQ/ccnKOiaxjulawN7HjvrBXbfs
	xBPJ43t5cw90F8NA+Rheu7Z4MXFQr4d+coyJUCy9Kerba05iAxjgo9gqqlbamqXnV1jI1V
	+aRtklbWhvYQ78LN0+RcLkwFHXrAI4KjYNYQ8DY5mG4IJp7LGxa4NrxhTZYEyYmxqLIDl2
	tIddSgfVdthyKNEuGvUyApXFqRgIt4SUKZwbFW74nQd6cAs9FfCqrlB6wcjWDMJDmt3p8K
	5ebyqOnTYg/c29vWNceJGDu8P5xNIUWhOQqVij3OuxcVwDSrPOuEQ9Flr2lrzA==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, ayu.chandekar@gmail.com, 
	chandrapratap3519@gmail.com, christian.couder@gmail.com, gitster@pobox.com, 
	jltobler@gmail.com, karthik.188@gmail.com, krka@spotify.com, peff@peff.net, 
	phillip.wood@dunelm.org.uk, siddharthasthana31@gmail.com
Subject: Re: [PATCH v8 4/4] graph: indent visual root in graph
Message-ID: <alEroo_DhFaWm3DH@exploit>
References: <20260704-ps-pre-commit-indent-v7-0-a94706cc8376@gmail.com>
 <20260710-ps-pre-commit-indent-v8-0-d3b636463bf4@gmail.com>
 <20260710-ps-pre-commit-indent-v8-4-d3b636463bf4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-ps-pre-commit-indent-v8-4-d3b636463bf4@gmail.com>
X-Spamd-Bar: -

On Fri, Jul 10, 2026 at 12:37:07PM +0200, Pablo Sabater wrote:
> When rendering a graph, if the history contains multiple "visual roots",
> actual roots or commits that look like roots (i.e. have their parents
> filtered out) can end up being vertically adjacent to unrelated commits,
> falsely appearing to be related.
> 
> A fix for this issue was already attempted [1] a while ago.
> 
> This happens because the commits fill the space from left to right and
> when a visual root ends, its column becomes free for the following
> commit even if they are not related. Once this happens the unrelated
> commit is rendered below the visual root. Because there is no special
> character or way to identify when a visual root is rendered making the
> graph confusing.
> 
> By indenting the visual roots when there are still commits to show the
> vertical adjacency can be avoided.
> 
> Add is_visual_root flag to git_graph making it visible in all graph states,
> give graph_update() a new function, graph_is_visual_root() to know if the
> current commit is a visual root and set is_visual_root.
> The different handled cases are:
> 
> - If a visual root has children: similar to GRAPH_PRE_COMMIT state when
>   octopus merges need space, an edge row needs to be printed to connect
>   the child with the indented visual root. A new state GRAPH_PRE_ROOT is
>   needed to connect the child with the visual root:
> 
>     * child of the visual root
>      \ GRAPH_PRE_ROOT
>       * visual root indented
> 
> - If a visual root is child-less we can skip GRAPH_PRE_ROOT state and
>   render the indented commit directly.
> 
>       * visual root indented
>     * unrelated commit
> 
> - If two or more visual roots are adjacent: by having a lookahead to the
>   next commit that will be rendered, if the next commit is also a visual
>   root and we are on a visual root, meaning two visual root adjacent in
>   the history, the top one can omit the indent, making the one below to
>   indent only once, if there are more adjacent visual commits, the
>   indentation will increase for each adjacent one, cascading.
> 
>     * visual root
>       * visual root
>         * visual root
>     * last commit
> 
>   Even if the last commit is a root, because there is nothing that will be
>   rendered below we can omit the indentation on purpose.
> 
> [1]: https://lore.kernel.org/git/xmqqwnwajbuj.fsf@gitster.c.googlers.com/
> 
> Helped-by: Kristofer Karlsson <krka@spotify.com>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  graph.c                          | 235 +++++++++++++++++++
>  t/meson.build                    |   1 +
>  t/t4218-log-graph-indentation.sh | 473 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 709 insertions(+)

This doesn't seem to work for every visual root e.g.

    git log --graph --oneline --author="Mirko Faina"

The visual roots are not indented.

> +/*
> + * A commit can be a visual root when:
> + *
> + * - It has no parents.
> + *
> + * - It has parents but they are all filtered out and
> + *   commit->parents arrives NULL.
> + *
> + * - It is not a boundary commit. Boundary commits also have no visible
> + *   parents, but they are not selected as visual roots because they cannot
> + *   cause the ambiguity of being vertically adjacent because:
> + *
> + *   1. A boundary only appears because an included commit is its child.
> + *      Children are always above, and the renderer draws an edge down to
> + *      the boundary from that child. Rather than starting a column like a
> + *      visual root would do, it inherits its child column.
> + *
> + *   2. Included commits cannot appear below a boundary. Boundaries are
> + *      ancestors of the exclusion point; if an included commit were an
> + *      ancestor of the boundary it would be excluded and not rendered.
> + *      Boundaries therefore always sink to the bottom.
> + */
> +static int graph_is_visual_root_candidate(struct commit *c)
> +{
> +	return c->parents == NULL && !(c->object.flags & BOUNDARY);
> +}

I suspect this behaviour is due to these assumptions being too strict.

When we use the --author option the parents are not filtered out, so it
doesn't return NULL desipte being a visual root. We realize it is a
visual root only on the next commit, but once we are on the next commit
we can't indent as we have already printed this commit.

We realize only on the next commit after hitting simplify_commit(), it
calls get_commit_action() and checks if should keep the commit based on
the regex we provided. If the regex is not matched the commit is just
ignored (we do not filter parents based on regex when we expand a topo
walk).

At least that's what I gather, if anyone can confirm this...
