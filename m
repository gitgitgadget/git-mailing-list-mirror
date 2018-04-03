Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 412A91F404
	for <e@80x24.org>; Tue,  3 Apr 2018 18:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751588AbeDCSAZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 14:00:25 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:39090 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751461AbeDCSAY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 14:00:24 -0400
Received: by mail-yb0-f196.google.com with SMTP id g197-v6so2369208ybf.6
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 11:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rzdaqL0BqTCx+cbDxv/o28dKShL2Ec23qPIa28+bUuY=;
        b=tCYISRiPLN1cQstmoctwgVLp34fWm/1nLcpvvZcPEY8v2+cT/lP2PwSyP0EZLViOOz
         C+7Uvnq/ESwqaUdllkpCGbf6Db8/w+6npIhehVXNvntHN7QoMnVh5oSC3vOF+bTyXLGn
         v6tsAM5+91n6+Rj/HBy2b9xTxPV05BBvNPAatvv+FWQAcrzT31b9BailGf/PeVAXL+i/
         3vS0BRNFl8oDnJR09yr+z0It4kgGfpCA2yS9w//hlryMful2ToYGxSf+8cILkuXEDdBY
         xuKeuLARNQJZeJjt5HEGNsfCi7ac5onrcZP8955OJaNR7sfVNPsNYVI+eQX9wjXTzrx5
         lv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rzdaqL0BqTCx+cbDxv/o28dKShL2Ec23qPIa28+bUuY=;
        b=EhVq0DrDEfJW+Yd388cw3mJbGEYsMG+dZp8UUFXcF1bY94BgM8i5p0mqood3cmWAVz
         3ao1nJXAVxjWC68MjQdLY5v1XXHbn1OzW97tMgocyI4b3tKl8nr+HFWpqWB1xzkDU+ED
         NiiapkWhHKIEvutlolGu72mxp0f6ZUkvvgeTenbur3aMlKJknCxKjRV5MyE++EmStQXJ
         IeL+/eWPSovGnltHLzbpRrMqvkSaTZnkmo/6XPX6vuszQpQuLvNNr/sYXRgip+9Mfwbo
         Lozg2Pgg17XMfETHowcc2rXkNIWni5/OUz8IsboV7pj4Aw/4U01m84UaLzU5LR3ayY5Z
         EpSw==
X-Gm-Message-State: ALQs6tA93brTCMu7ke2milzVwaoR+hhnyj6tnNls8IrX5Ctr5c0yKFBc
        o3HJVu5GKo/1HnF0775S4BQMzTe99A4yJjCKcHgq8g==
X-Google-Smtp-Source: AIpwx4+2lJ44swc1l8v2GzzFv5GJKIVLDwTQtyO0bHBM4CAABBy5SFewCMOuUm4oGMyH4mcug4vzb25CeubQ6cy2Ntc=
X-Received: by 2002:a25:ba51:: with SMTP id z17-v6mr6074077ybj.334.1522778422252;
 Tue, 03 Apr 2018 11:00:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Tue, 3 Apr 2018 11:00:21 -0700 (PDT)
In-Reply-To: <20180403120057.173849-4-dstolee@microsoft.com>
References: <20180403120057.173849-1-dstolee@microsoft.com> <20180403120057.173849-4-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 3 Apr 2018 11:00:21 -0700
Message-ID: <CAGZ79kZ0XZRiKcJG-5Ckd=XjE-3GfGHkNuyu4590OyfGPve4Rg@mail.gmail.com>
Subject: Re: [PATCH 3/3] commit-graph: lazy-load trees
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 3, 2018 at 5:00 AM, Derrick Stolee <dstolee@microsoft.com> wrote:
> The commit-graph file provides quick access to commit data, including
> the OID of the root tree for each commit in the graph. When performing
> a deep commit-graph walk, we may not need to load most of the trees
> for these commits.
>
> Delay loading the tree object for a commit loaded from the graph
> until requested via get_commit_tree(). Do not lazy-load trees for
> commits not in the graph, since that requires duplicate parsing
> and the relative peformance improvement when trees are not needed
> is small.
>
> On the Linux repository, performance tests were run for the following
> command:
>
>         git log --graph --oneline -1000
>
> Before: 0.83s
> After:  0.65s
> Rel %: -21.6%

This is an awesome speedup.

>
> Adding '-- kernel/' to the command requires loading the root tree
> for every commit that is walked.

and as the walk prunes those commits that do not touch kernel/
which from my quick glance is the real core thing. Linus' announcements
claim that > 50% is drivers, networking and documentation[1].
So the "-- kernel/" walk needs to walk twice as many commits to find
a thousand commits that actually touch kernel/ ?

[1] http://lkml.iu.edu/hypermail/linux/kernel/1801.3/02794.html
http://lkml.iu.edu/hypermail/linux/kernel/1803.3/00580.html

> There was no measureable performance
> change as a result of this patch.

... which means that the walking itself is really fast now and the
dominating effects are setup and checking the tree?

Is git smart enough to not load the root tree for "log -- ./" or
would we get the desired performance numbers from that?

> @@ -317,6 +315,27 @@ int parse_commit_in_graph(struct commit *item)
>         return 0;
>  }
>
> +static struct tree *load_tree_for_commit(struct commit_graph *g, struct commit *c)
> +{
> +       struct object_id oid;
> +       const unsigned char *commit_data = g->chunk_commit_data + (g->hash_len + 16) * (c->graph_pos);

What is 16? (I imagine it is the "length of the row" - g->hash_len ?)
Would it make sense to have a constant/define for an entire row instead?
(By any chance what is the meaning of GRAPH_DATA_WIDTH, which is 36?
That is defined but never used.)

> +struct tree *get_commit_tree_in_graph(const struct commit *c)
> +{
> +       if (c->tree)
> +               return c->tree;

This double checking is defensive programming, in case someone
doesn't check themselves (as get_commit_tree does below).

ok.

> @@ -17,6 +17,13 @@ char *get_commit_graph_filename(const char *obj_dir);
>   */
>  int parse_commit_in_graph(struct commit *item);
>
> +/*
> + * For performance reasons, a commit loaded from the graph does not
> + * have a tree loaded until trying to consume it for the first time.

That is the theme of this series/patch, but do we need to write it down
into the codebase? I'd be inclined to omit this part and only go with:

  Load the root tree of a commit and return the tree.

>  struct tree *get_commit_tree(const struct commit *commit)
>  {
> -       return commit->tree;
> +       if (commit->tree || !commit->object.parsed)

I understand to return the tree from the commit
when we have the tree in the commit object (the first
part).

But 'when we have not (yet) parsed the commit object',
we also just return its tree? Could you explain the
second part of the condition?
Is that for commits that are not part of the commit graph?
(But then why does it need to be negated?)

Thanks,
Stefan
