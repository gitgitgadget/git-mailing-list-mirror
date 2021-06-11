Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E79AC48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 00:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 369836100A
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 00:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhFKAwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 20:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhFKAwL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 20:52:11 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB7CC061574
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 17:50:04 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id u20so1405212qtx.1
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 17:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JrOWG154t07P+lf5dbh0sCnuZV0FiCf2pwv2WRvpTI0=;
        b=dviw7Fp3vnw90gwDv3jLiclWwZNH9EgJpx8b6v6I6dwAwx2ea2FTS2B58FsPz0DF7S
         WliY4vH/R9QXwipQk6qPxheZkk3+on9KPfoQCwjUs34+d5mMNGWtMB4I5w73ymwF6BKc
         mlOGtb67pJKeKfRcMCOhbUFZ5CBObZSFybacRs1KbZ/210R1DUBtjsnP9yFuBfAfCAsz
         3F2NTrI2YZzJAjLuv9aZEpxNTK9lZDDKhf51WhQD11dZZdM2xryBlbYhPdWKWbe/eIpW
         cGm9i+Klr4zWUHXbAD5aZO+yWu7+hKybDSZkp9Jbld4eNo3sTSMe0Frg75KgtJB9eAAE
         4abQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JrOWG154t07P+lf5dbh0sCnuZV0FiCf2pwv2WRvpTI0=;
        b=Y4bmUuei1TimvIr/4khUXabVJthckaM3Iav49eQm8f+iOt0sMzO1VOdDEJJSSwGGyr
         OZb0qCgKtcX/rzw6e0QtLo7g91Fngtu3bTS4q4yi/zaqW8kWs2KKetYRGUyEMx5+MTgI
         SvFieP0tn3cUKYoUNO5JmKLQO4jZn4xwZb1FVH38/Du20MF8ahsjt/iwgPcZ5cgsmSch
         mefumjdsg/qt2I8s95rcphs2Gn6YvaJnlE85QhrhhsVbvfm7k1DArIXiCLi4ZWL6bwAC
         V13gLc7Bo8aGD1BuQ8JLsFqBXcvA8j4xC3dnIvFiza8K8uG0cRIrN0571fhV7QLcHoXO
         9iIg==
X-Gm-Message-State: AOAM532LDHcJqapdUVX55H6IlzA7c52iP3l19Y3oQvRga8ff2AepEt5S
        e8JE9VUDyiA/uAzrgs4iP0zFrQ==
X-Google-Smtp-Source: ABdhPJxDd5RXTZfz6w4MsWjs5s/WV+u6FkApxMD4VIdP+4icU4kPGxArhyGU+J78DKUxwug3kIVN6Q==
X-Received: by 2002:ac8:4e93:: with SMTP id 19mr1599887qtp.202.1623372603958;
        Thu, 10 Jun 2021 17:50:03 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:8142:65b0:5f04:da8d])
        by smtp.gmail.com with ESMTPSA id b123sm3621408qke.87.2021.06.10.17.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 17:50:03 -0700 (PDT)
Date:   Thu, 10 Jun 2021 20:50:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net, szeder.dev@gmail.com
Subject: Re: Making split commit graphs pick up new options (namely
 --changed-paths)
Message-ID: <YMKzOgOU9lj9Nt0z@nand.local>
References: <871r9a2dol.fsf@evledraar.gmail.com>
 <YMJKcHpN/gL5U6KK@nand.local>
 <87mtrx1cdr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mtrx1cdr.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 11, 2021 at 01:56:31AM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> Reading the code there seems to be no way to do that, and we have the
> >> "chunk_bloom_data" in the graph, as well as "bloom_filter_settings".
> >>
> >> I'd expect some way to combine the "max_new_filters" and --split with
> >> some eventual-consistency logic so that graphs not matching our current
> >> settings are replaced, or replaced some <limit> at a time.
> >
> > This is asking about something slightly different, Bloom filter
> > settings rather than the existence of chagned-path Bloom filters
> > themselves. The Bloom settings aren't written to the commit-graph
> > although there has been some discussion about doing this in the past.
> >
> > If we ever did encode the Bloom settings, I imagine that accomplishing a
> > sort of "eventually replace all changed-path Bloom filters with these
> > new settings" would be as simple as considering all filters computed
> > under different settings to be "uncomputed".
>
> Yes, I don't have or know of a use-case for this now.
>
> But perhaps as the commit-graph format gets used more as a generic
> container for generated data about commits a thing like this would be
> useful, i.e. regenerating that part of the graph if the settings are
> different, particularly (as has been said) if it's not easy to discover
> the input setting from the data itself.

I wasn't completely correct about this (as Stolee noted and you ACK
below): we do store *some* settings in the format, but we don't store
the maximum number of entries in each filter. So today we would indicate
"computed, too large" for a commit that touches, say, 513 paths (the
limit is 512). But if you later ran:

  GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS=514 \
    git commit-graph write --split=replace --changed-paths

we would propagate the "too large" status forward and not bother to
recompute the filter (even though we could represent it if we did bother
to recompute it).

In the future we should probably include this as part of the filter
settings and recompute all filters in the commit-graph we're writing if
the value differs from the previous commit-graph. We have to recompute
it even if the maximum decreases since we can't ask the filter directly
"how many entries do you have?".

...and we have to assume that the limit is 512 on all commit-graphs that
exist in the wild today which do not explicit include this default
value. (That's not totally correct, of course, because you can set the
GIT_TEST_ variable, but it's close enough that I'd feel comfortable with
that rule in practice).

> So yeah, maybe we can just unlink() them right away, or another way to
> handle the race is that load_commit_graph_chain() could just try again
> from the beginning in such a case, and presumably picking up the fresh
> just-rewritten chain.

I'd probably be in favor of the latter.

Thanks,
Taylor
