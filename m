Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3431C48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 00:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCE25613C3
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 00:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhFKAWo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 20:22:44 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:38447 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhFKAWn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 20:22:43 -0400
Received: by mail-ej1-f42.google.com with SMTP id og14so1806998ejc.5
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 17:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=3ii25W4EzBU1E9dJ/bcbqmtURmdlCgMEZ6pEUGlC4W8=;
        b=lm27YnS38CC6Y7mpIV5/nkeBR5DLMf9qgXSYk+Fodg/a7INQOuByaAj2g5b/1kk0eJ
         kx/5MVpPxZkpWtYReGEc+Vu9yvO3MitIeamDEHzV/qJab26EQv6dlwDb9k+brbjKs2yh
         lsyW0tYSB6LEwYuDXA1LZ3leeYaeihc8bxeRiA2345f82UY5rjuB9kMwoSBF79az/wEm
         qGjF63vtmGgJzol9eoadZ/yI3dTYgTv5PgDO5ndUypQYR9NGcgYA8d/9Lh8DD4tlBJff
         BKoLKtVhzfL2m7uwA1IluYKGQVl8lCwSrNHjVPvh6DW1ZkomfBUHMlUkhZpYPKJR1VxV
         +TMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=3ii25W4EzBU1E9dJ/bcbqmtURmdlCgMEZ6pEUGlC4W8=;
        b=fuKCAgTmR7PEKyK4zcn3fPGSfL1l/+dlYXW0VTavc5s+iBwl23+Z6b5N4ezlgpp5t8
         mX/+BD9OJXMpo28yPHQ+kgrh+8aDbVX6zlMOzG5OEuMjIema4F9VqAS7DTCb53ssiTLC
         TxxLsiHqIS0h9apV/sHUo1A6E0ASBrbFU8NYyxsWT7tv6tqCX7dTX9DBfW4UbkKuVItH
         slbtyimEZjnaVwy/33uCck7g3n9SsHYDMLWZvjeykXI2JRDY092nzdEGptkdEriHUN4k
         cFsUt7FU+sCg6k7LObEZswNP0g9SjfvjCEhYqLzi+LpYdpa6e7oa/5GYth60EA++g1DM
         YfUw==
X-Gm-Message-State: AOAM530wt5awm8E8LQQFHl/J9SD0U8WTqxwwg7gvzmVf3QCmP7M6dfQg
        mArBu/rUxbq2RHIJt2V9N/c=
X-Google-Smtp-Source: ABdhPJyPI7UJZhpEVg/mHp/+PYU6vf3WVSM1GDcdaG2+Pk8DcPSWXaGh9EMNbQZgwhnwW2aK2cPlDg==
X-Received: by 2002:a17:906:757:: with SMTP id z23mr877846ejb.537.1623370774514;
        Thu, 10 Jun 2021 17:19:34 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id u12sm2013462edv.43.2021.06.10.17.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 17:19:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net, szeder.dev@gmail.com
Subject: Re: Making split commit graphs pick up new options (namely
 --changed-paths)
Date:   Fri, 11 Jun 2021 01:56:31 +0200
References: <871r9a2dol.fsf@evledraar.gmail.com> <YMJKcHpN/gL5U6KK@nand.local>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YMJKcHpN/gL5U6KK@nand.local>
Message-ID: <87mtrx1cdr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 10 2021, Taylor Blau wrote:

> On Thu, Jun 10, 2021 at 12:40:33PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Is there any way with an existing --split setup that introduces a
>> --changed-paths to make the "add bloom filters to the graph" eventually
>> consistent, or is some one-off --split=3Dreplace the only way to
>> grandfather in such a feature?
>
> I'm assuming what you mean is "can I introduce changed-path Bloom
> filters into an existing split commit-graph with many layers without
> having to recompute the whole thing at once?" If so, then the answer is
> yes.
>
> Passing --changed-paths causes the commit-graph machinery to compute
> missing Bloom filters for every commit in the graph layer it is writing.
> So, if you do something like:
>
>   git commit-graph write --split --reachable --size-multiple=3D2 \
>     --changed-paths
>
> (--size-multiple=3D2 is the default, but I'm including it for clarity),
> then you'll get changed-path Bloom filters for all commits in the new
> layer, including any layers which may have been merged to create that
> layer.
>
> That all still respects `--max-new-filters`, with preference going to
> commits with lower generation numbers before higher ones (unless
> including commits from packs explicitly with --stdin-packs, in which
> case preference is given in pack order; see
> commit-graph.c:commit_pos_cmp() for details).
>
> t4216 shows this for --split=3Dreplace, but you could just as easily
> imagine a test like this:
>
>     #!/bin/sh
>
>     rm -fr repo
>     git init repo
>     cd repo
>
>     commit () {
>       >$1
>       git add $1
>       git commit -m "$1"
>     }
>
>     # no changed-path Bloom filter
>     commit missing
>     git commit-graph write --split --reachable --no-changed-paths
>
>     missing=3D"$(git rev-parse HEAD)"
>     ~/src/git/t/helper/test-tool bloom get_filter_for_commit "$missing"
>
>     # >=3D 2x the size of the previous layer, so they will be merged
>     commit bloom1
>     commit bloom2
>     git commit-graph write --split --reachable --changed-paths
>
>     # and the $missing commit has a Bloom filter
>     ~/src/git/t/helper/test-tool bloom get_filter_for_commit "$missing"
>
> (One caveat is that if you run that script unmodified, you'll get a
> filter on both invcations of the test-tool: that's because it computes
> filters on the fly if they are missing. You can change that by s/1/0 in
> the call to get_or_compute_bloom_filter()).

I was assuming it would not be added, but it seems I was just wrong
about that.

What prompted this question from me was reviewing a MR dealing with the
format, where the code is parsing graph files checking if they have
bloom filters, and then using --split or --split=3Dreplace:
https://gitlab.com/gitlab-org/gitaly/-/merge_requests/3545#note_596862825

>> Reading the code there seems to be no way to do that, and we have the
>> "chunk_bloom_data" in the graph, as well as "bloom_filter_settings".
>>
>> I'd expect some way to combine the "max_new_filters" and --split with
>> some eventual-consistency logic so that graphs not matching our current
>> settings are replaced, or replaced some <limit> at a time.
>
> This is asking about something slightly different, Bloom filter
> settings rather than the existence of chagned-path Bloom filters
> themselves. The Bloom settings aren't written to the commit-graph
> although there has been some discussion about doing this in the past.
>
> If we ever did encode the Bloom settings, I imagine that accomplishing a
> sort of "eventually replace all changed-path Bloom filters with these
> new settings" would be as simple as considering all filters computed
> under different settings to be "uncomputed".

Yes, I don't have or know of a use-case for this now.

But perhaps as the commit-graph format gets used more as a generic
container for generated data about commits a thing like this would be
useful, i.e. regenerating that part of the graph if the settings are
different, particularly (as has been said) if it's not easy to discover
the input setting from the data itself.

>> Also, am I reading the expire_commit_graphs() logic correctly that we
>> first write the split graph, and then unlink() things that are too old?
>> I.e. if you rely on the commit-graph to optimize things this will make
>> things slower until the next run of writing the graph?
>
> Before expire_commit_graphs() is called, we call mark_commit_graphs()
> which freshens the mtimes of all surviving commit-graph layers, and then
> expire_commit_graphs() removes the stale layers. I'm not sure what
> things getting slower is referring to since the resulting commit-graph
> has at least as many commits as the commit-graph that existed prior to
> the write.

I was assuming we'd be left without a segment of the data, but now I
seem to recall that the commit-graph can't have missing parts of the
graph. So this was doubly a brainfart on my part.

>> I expected to find something more gentle there [...]
>
> FWIW, I also find this "expire based on mtimes" thing a little odd for
> writing split commit-graphs because we know exactly which layers we want
> to get rid of. I suspect that the reuse comes from wanting to unify the
> logic for handling '--expire-time' with the expiration that happens
> after writing a split commit-graph that merged two or more previous
> layers.
>
> I would probably change mark_commit_graphs() to remove those merged
> layers explicitly (but still run expire_commit_graphs() to handle
> --expire-time). But, come to think of it... if merging >2 layers already
> causes the merged layers to be removed, then why would you ever set an
> --expire-time yourself?

What Derrick said downthread, but you might also find this discussion
(and upthread of that) on the split graph format interesting:
https://lore.kernel.org/git/874l63xpwx.fsf@evledraar.gmail.com/

I.e. the initial idea was to have a numeric split
(commit-graph-{1,2,3,...}, and juggle those "chunks". It seems I managed
to convince Derrick to go with the current "chained hash" approach.

That's related to the way we want to do expiry. I.e. you might think
that layer isn't used, but a concurrent process working over NFS may
still want it, especially if that process itself is a long-running
command.

Reading the code now I think it can be much more aggressive than it
currently is, even say to the point of the "commit-graph write"
optionally forking to the background and doing the unlink() itself in
10-60 seconds or something.

I.e. in load_commit_graph_chain() we always load full chain once we
start doing so, we don't load one part of it, find the data we want, and
then go to a bunch of more other work outside of commit-graph.c, only to
return to loading the next segment in the chain much later. It happens
as fast as the loop around load_commit_graph_one will run.

That loop would be less racy if it pre-opened all the files it wants, so
the consuming process would hang onto them past an unlink() by a
concurrent process.

It's probably a non-issue in practice, but one can imagine e.g. a set of
10x 10MB commit-graph files being loaded over a 10KB/s NFS connection or
something. Opening and parsing all the files could take a while. By the
time we open() the last one an aggressive expiry policy might have
removed it from under us.

Anyway, even then the worst we'll do is warn about not finding the
segment in the chain and return the graph up until that point. I.e.:

    warning(_("unable to find all commit-graph files"));

So yeah, maybe we can just unlink() them right away, or another way to
handle the race is that load_commit_graph_chain() could just try again
from the beginning in such a case, and presumably picking up the fresh
just-rewritten chain.
