Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6EEC47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 17:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C98A1613E9
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 17:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhFJR0H (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 13:26:07 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:35553 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhFJR0G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 13:26:06 -0400
Received: by mail-qt1-f171.google.com with SMTP id g12so436757qtb.2
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 10:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Hu5iNqxx+2EeK7N9j4rSpJUB2AS04mmgWZZluwUvaPM=;
        b=lMiu8Rx9B7mgZ+hkxZCOBZaI2gkK7gdW7auFicdKocL8Tyc6Gb8EN0S6weXJSCH6P7
         XjXFZ4FtP0s1hV11hvgrObBfu4rK+i1fBtTNKlvMkpyIsXLH7PmE35hcmfHLcls00kp9
         KlgGL4EpHvHvnDWdaUn1N2Csic/LYJ5xWlvO9pahZrUg54xtE9S+3doQl6+/klaP09eX
         PRmFZeapfUTXpOVUHerr8gdlEKVms4yQ9JiNSZ46B7RACQkgflhD1eSnQkfODVdbrk19
         S94ogXdvk4psesBIvVmoh31PF96jjQsS7sx819x3tvQGyobSPU9CoNGJPv1oAqNcMSDn
         0jEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Hu5iNqxx+2EeK7N9j4rSpJUB2AS04mmgWZZluwUvaPM=;
        b=eHAaUNynss3ZqxYFNzui45j9HIZFxXp/61h8AMw3gzaxwoQ6r6VqiA6IlZ3YYxEQhr
         wbQxG5xmhUxPF5cRACoIUUBxf3RuNHUQZaNdJ+CrdiwzBsphySO5W/X8OOnWEKN4wtLP
         R+JOLKkyPZ577yITtMaRXyGh7+ZYYk5MEG4cCVV6uiyiuO85Ae5Sq7y0V+Rmj0UX1d0a
         AxTs0B4s5NHf5aBxsWoNYGJjQPwOFVwUabimMYbA8caCBg5sLdb11MgsTyzG4SYoxVhN
         NvnH5tzq+pqeUEukUWCPZsFz/8HYup049Bj6yylP+EmN9zkOs9Lsq2JwIQNECpdf1Ags
         A4OA==
X-Gm-Message-State: AOAM532S7d4JalPQgKoRhJmeVuMFrcZhi+S3DMWUWN94c8fkwEasRXqp
        VktUjQ4g7CC9Xje5dGjUCeoQaw==
X-Google-Smtp-Source: ABdhPJzlE32wxUKjpSdJPWyY6IgDyYOGAIDnBqaQZN00qVqy+H+9Uqefg0l4RokoUT3ZH5awsp/9sg==
X-Received: by 2002:ac8:4b4c:: with SMTP id e12mr720607qts.78.1623345779851;
        Thu, 10 Jun 2021 10:22:59 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:b6b5:2c95:5f61:efec])
        by smtp.gmail.com with ESMTPSA id h68sm2636681qkf.126.2021.06.10.10.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 10:22:59 -0700 (PDT)
Date:   Thu, 10 Jun 2021 13:22:56 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: Re: Making split commit graphs pick up new options (namely
 --changed-paths)
Message-ID: <YMJKcHpN/gL5U6KK@nand.local>
References: <871r9a2dol.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871r9a2dol.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 10, 2021 at 12:40:33PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Is there any way with an existing --split setup that introduces a
> --changed-paths to make the "add bloom filters to the graph" eventually
> consistent, or is some one-off --split=replace the only way to
> grandfather in such a feature?

I'm assuming what you mean is "can I introduce changed-path Bloom
filters into an existing split commit-graph with many layers without
having to recompute the whole thing at once?" If so, then the answer is
yes.

Passing --changed-paths causes the commit-graph machinery to compute
missing Bloom filters for every commit in the graph layer it is writing.
So, if you do something like:

  git commit-graph write --split --reachable --size-multiple=2 \
    --changed-paths

(--size-multiple=2 is the default, but I'm including it for clarity),
then you'll get changed-path Bloom filters for all commits in the new
layer, including any layers which may have been merged to create that
layer.

That all still respects `--max-new-filters`, with preference going to
commits with lower generation numbers before higher ones (unless
including commits from packs explicitly with --stdin-packs, in which
case preference is given in pack order; see
commit-graph.c:commit_pos_cmp() for details).

t4216 shows this for --split=replace, but you could just as easily
imagine a test like this:

    #!/bin/sh

    rm -fr repo
    git init repo
    cd repo

    commit () {
      >$1
      git add $1
      git commit -m "$1"
    }

    # no changed-path Bloom filter
    commit missing
    git commit-graph write --split --reachable --no-changed-paths

    missing="$(git rev-parse HEAD)"
    ~/src/git/t/helper/test-tool bloom get_filter_for_commit "$missing"

    # >= 2x the size of the previous layer, so they will be merged
    commit bloom1
    commit bloom2
    git commit-graph write --split --reachable --changed-paths

    # and the $missing commit has a Bloom filter
    ~/src/git/t/helper/test-tool bloom get_filter_for_commit "$missing"

(One caveat is that if you run that script unmodified, you'll get a
filter on both invcations of the test-tool: that's because it computes
filters on the fly if they are missing. You can change that by s/1/0 in
the call to get_or_compute_bloom_filter()).

> Reading the code there seems to be no way to do that, and we have the
> "chunk_bloom_data" in the graph, as well as "bloom_filter_settings".
>
> I'd expect some way to combine the "max_new_filters" and --split with
> some eventual-consistency logic so that graphs not matching our current
> settings are replaced, or replaced some <limit> at a time.

This is asking about something slightly different, Bloom filter
settings rather than the existence of chagned-path Bloom filters
themselves. The Bloom settings aren't written to the commit-graph
although there has been some discussion about doing this in the past.

If we ever did encode the Bloom settings, I imagine that accomplishing a
sort of "eventually replace all changed-path Bloom filters with these
new settings" would be as simple as considering all filters computed
under different settings to be "uncomputed".

> Also, am I reading the expire_commit_graphs() logic correctly that we
> first write the split graph, and then unlink() things that are too old?
> I.e. if you rely on the commit-graph to optimize things this will make
> things slower until the next run of writing the graph?

Before expire_commit_graphs() is called, we call mark_commit_graphs()
which freshens the mtimes of all surviving commit-graph layers, and then
expire_commit_graphs() removes the stale layers. I'm not sure what
things getting slower is referring to since the resulting commit-graph
has at least as many commits as the commit-graph that existed prior to
the write.

> I expected to find something more gentle there [...]

FWIW, I also find this "expire based on mtimes" thing a little odd for
writing split commit-graphs because we know exactly which layers we want
to get rid of. I suspect that the reuse comes from wanting to unify the
logic for handling '--expire-time' with the expiration that happens
after writing a split commit-graph that merged two or more previous
layers.

I would probably change mark_commit_graphs() to remove those merged
layers explicitly (but still run expire_commit_graphs() to handle
--expire-time). But, come to think of it... if merging >2 layers already
causes the merged layers to be removed, then why would you ever set an
--expire-time yourself?

Thanks,
Taylor
