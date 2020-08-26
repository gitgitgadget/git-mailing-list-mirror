Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A44C433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 07:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96FF52071E
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 07:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eU0Y1N9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgHZHRi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 03:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgHZHRi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 03:17:38 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E151C061574
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 00:17:37 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k15so491524pfc.12
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 00:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XcIqpO753uB3cjuGYBl4Hf6eKTGqxLl+XUFmqE3GBPY=;
        b=eU0Y1N9LvrqmM36oLQ2Wlb8vi9NIqZ40fpEcxdIwrlaDMoJpuR9DhxhL7ni+2VN97/
         tlJoTTtYaK3ls1cCblNkde7bOl2ExbJCB0ZHg/4CxI894WdrIn8Fqtv9LW6VQREgWXqm
         4qc2k3KpfXhXWueOvMBlKIV8Y/nFeuSar9RsC2QJxA7HCu5qwMG4cJfTNzca2T3Tk/ZU
         WzE0cgtz8gXhUpAScLgIENNNSoVTDDFMRtmdRalpaeuGzBoNAIFO5LWlaf+LP+VV4r7T
         afVTeXtcu0r594CKAB6eMUAK6ZMrIuKwFM2ZhvoPXmpp6Q26tracaNAwlPcg0Ek0Y+hk
         5xXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=XcIqpO753uB3cjuGYBl4Hf6eKTGqxLl+XUFmqE3GBPY=;
        b=o5W7zkFd1e22LgT18CPpWEIXtxxnl0LewgrSHH22KkIHf1UG8+4pPcjrKrfeZaJjDj
         WW36xID2kNM/C1yZbdH/bVz1ETppxbPpu1eZqMRJdyVQ0qtMmk4zi/6c9HeTyeBsOB+c
         96jIuyrAEolz5EGcg/GVcvWpaC5c0nIJIPR3e3e8V++oPNyM8y3hVkgJxWQxehqJopop
         Kdgvc5E2WQ3m7XKuczF3PqX7P/uBN2IfaeMI39WzU+/Rx3JZhXTykloWUU7AK8OxqPE2
         N8YNY8Yf3k6N9PeoToxvnVlsOl3Laj55ClU+R9PA8F1UBpls4eiJORhEy+G/3hFMzvUO
         kF3Q==
X-Gm-Message-State: AOAM531TSrI6W9JF2ejFJVk1KqRpM59QZC2dMw6ntKf0K8YaYjXiHjq8
        t+a5w1m2UQ92slBYGdcapEI=
X-Google-Smtp-Source: ABdhPJzF4z/YrWiph9WNnT+Wpf+F3vsG/+aQWhdtRt17I8xPEny/MUejqYj0yBuSMla576J9m2cczA==
X-Received: by 2002:a62:7a42:: with SMTP id v63mr7937765pfc.217.1598426257265;
        Wed, 26 Aug 2020 00:17:37 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:e90:1a28:66a3:8a14:5b8a:edc3])
        by smtp.gmail.com with ESMTPSA id e23sm1156696pgb.79.2020.08.26.00.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 00:17:36 -0700 (PDT)
Date:   Wed, 26 Aug 2020 12:45:19 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, me@ttaylorr.com, stolee@gmail.com
Subject: Re: [PATCH v3 09/11] commit-graph: use generation v2 only if entire
 chain does
Message-ID: <20200826071519.GA6805@Abhishek-Arch>
Reply-To: 85pn7ihabl.fsf@gmail.com
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
 <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <5a147a9704f0f8d8644c92ea38583e966378b931.1597509583.git.gitgitgadget@gmail.com>
 <85pn7ihabl.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85pn7ihabl.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 22, 2020 at 07:14:38PM +0200, Jakub Narębski wrote:
> Hi Abhishek,
> 
> ... 
> 
> However the commit message do not say anything about the *writing* side.
> 

Revised the commit message to include the following at the end:

When writing the new layer in split commit-graph, we write a GDAT chunk
only if the topmost layer has a GDAT chunk. This guarantees that if a
layer has GDAT chunk, all lower layers must have a GDAT chunk as well.

Rewriting layers follows similar approach: if the topmost layer below
set of layers being rewritten (in the split commit-graph chain) exists,
and it does not contain GDAT chunk, then the result of rewrite does not
have GDAT chunks either.

> 
> ...
> 
> To be more detailed, without '--split=replace' we would want the following
> layer merging behavior:
> 
>    [layer with GDAT][with GDAT][without GDAT][without GDAT][without GDAT]
>            1              2           3             4            5
> 
> In the split commit-graph chain above, merging two topmost layers
> (layers 4 and 5) should create a layer without GDAT; merging three
> topmost layers (and any other layers, e.g. two middle ones, i.e. 3 and
> 4) should create a new layer with GDAT.
> 
>    [layer with GDAT][with GDAT][without GDAT][-------without GDAT-------]
>            1              2           3               merged
> 
>    [layer with GDAT][with GDAT][-------------with GDAT------------------]
>            1              2                    merged
> 
> I hope those ASCII-art pictures help understanding it
> 

Thanks! There were helpful.

While we work as expected in the first scenario i.e merging 4 and 5, we
would *still* write a layer without GDAT in the second scenario.

I have tweaked split_graph_merge_strategy() to fix this:

----------------------------------------------

diff --git a/commit-graph.c b/commit-graph.c
index 6d54d9a286..246fad030d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1973,6 +1973,9 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 		}
 	}
 
+	if (!ctx->write_generation_data && g->chunk_generation_data)
+		ctx->write_generation_data = 1;
+
 	if (flags != COMMIT_GRAPH_SPLIT_REPLACE)
 		ctx->new_base_graph = g;
 	else if (ctx->num_commit_graphs_after != 1)

----------------------------------------------------

That is, if we were not writing generation data (because of mixed
generation concerns) but the new topmost layer has a generation data
chunk, we have merged all layers without GDAT chunk and can now write a
GDAT chunk safely.

> >
> > It is difficult to expose this issue in a test. Since we _start_ with
> > artificially low generation numbers, any commit walk that prioritizes
> > generation numbers will walk all of the commits with high generation
> > number before walking the commits with low generation number. In all the
> > cases I tried, the commit-graph layers themselves "protect" any
> > incorrect behavior since none of the commits in the lower layer can
> > reach the commits in the upper layer.
> >
> > This issue would manifest itself as a performance problem in this case,
> > especially with something like "git log --graph" since the low
> > generation numbers would cause the in-degree queue to walk all of the
> > commits in the lower layer before allowing the topo-order queue to write
> > anything to output (depending on the size of the upper layer).
> 
> Wouldn't breaking the reachability condition promise make some Git
> commands to return *incorrect* results if they short-circuit, stop
> walking if generation number shows that A cannot reach B?
> 
> I am talking here about commands that return boolean, or select subset
> from given set of revisions:
> - git merge-base --is-ancestor <B> <A>
> - git branch branch-A <A> && git branch --contains <B>
> - git branch branch-B <B> && git branch --merged <A>
> 
> Git assumes that generation numbers fulfill the following condition:
> 
>   if A can reach B, then gen(A) > gen(B)
> 
> Notably this includes commits not in commit-graph, and clamped values.
> 
> However, in the following case
> 
> * if commit A is from higher layer without GDAT
>   and uses topological levels for 'generation', e.g. 115 (in a small repo)
> * and commit B is from lower layer with GDAT
>   and uses corrected commit date as 'generation', for example 1598112896,
> 
> it may happen that A (later commit) can reach B (earlier commit), but
> gen(B) > gen(A).  The reachability condition promise for generation
> numbers is broken.
> 
> >
> > Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> > Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> > ---
> 
> I have reordered files in the patch itself to make it easier to review
> the proposed changes.
> 
> >  commit-graph.h                |  1 +
> >  commit-graph.c                | 32 +++++++++++++++-
> >  t/t5324-split-commit-graph.sh | 70 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 102 insertions(+), 1 deletion(-)
> >
> > diff --git a/commit-graph.h b/commit-graph.h
> > index f78c892fc0..3cf89d895d 100644
> > --- a/commit-graph.h
> > +++ b/commit-graph.h
> > @@ -63,6 +63,7 @@ struct commit_graph {
> >  	struct object_directory *odb;
> >
> >  	uint32_t num_commits_in_base;
> > +	uint32_t read_generation_data;
> >  	struct commit_graph *base_graph;
> >
> 
> First, why `read_generation_data` is of uint32_t type, when it stores
> (as far as I understand it), a "boolean" value of either 0 or 1?
> 

Yes, using unsigned int instead of uint32_t (although in most of cases
it would be same).  If commit_graph had other flags as well, we could
have used a bit field.

> Second, couldn't we simply set chunk_generation_data to NULL?  Or would
> that interfere with the case of rewriting, where we want to use existing
> GDAT data when writing new commit-graph with GDAT chunk?

It interferes with rewriting the split commit-graph, as you might have
guessed from the above code snippet.

> 
> ...
>
> > diff --git a/commit-graph.c b/commit-graph.c
> 
> >  		graph_data->generation = item->date +
> >  			(timestamp_t) get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
> >  	else
> > @@ -885,6 +908,7 @@ void load_commit_graph_info(struct repository *r, struct commit *item)
> >  	uint32_t pos;
> >  	if (!prepare_commit_graph(r))
> >  		return;
> > +
> >  	if (find_commit_in_graph(item, r->objects->commit_graph, &pos))
> >  		fill_commit_graph_info(item, r->objects->commit_graph, pos);
> >  }
> 
> This is unrelated whitespace fix, a "while at it" in neighbourhood of
> changes.  All right then.
> 

Reverted this change, as it's unimportant.

> > @@ -2192,6 +2216,9 @@ int write_commit_graph(struct object_directory *odb,
>
> ...
> 
> It would be nice to have an example with merging layers (whether we
> would handle it in strict or relaxed way).
> 

Sure, will add.

> > +
> >  test_done
> 
> Best,
> -- 
> Jakub Narębski

Thanks
- Abhishek
