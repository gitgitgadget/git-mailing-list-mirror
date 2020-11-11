Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4ACAC5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 16:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C9152074B
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 16:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4jQix3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgKKQrd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 11:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbgKKQrc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 11:47:32 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830B8C0613D4
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 08:47:32 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id m13so2853291oih.8
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 08:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2fXjZtpKAT2PhULNZWTjsSEw2VWOlLfj+UB3FPMkZCc=;
        b=J4jQix3SQJ5jpnhoULhSsPTPfFRGnnAMtezysx6YBLmnvmpwjzGaEtWfJWL/rxY1oD
         nrcNwg6lmEbfDhvYjYf6ojCsDHYqxTRd5RViV/5cANbHmy2e4RHe4Bs81f/YJw/VAc/5
         KenO6eqFAGz9C9UH200UtXn3Xp+gfTNHJOea6qKHk2HI+GpG6foD9BjReSW446XqT9Ig
         JRGUnH/uDeXa0jsqtQEvrznoya7BsjUGDG84bTXnLrkgYEhM5j0Mr7ipzq/lnpD1HdSu
         2ynprKY9K0crYTD/uHM54brzxBdTa5RO8wftuQ5VJRDZ7HjNwte/A6icM/4Sg08solr5
         wB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2fXjZtpKAT2PhULNZWTjsSEw2VWOlLfj+UB3FPMkZCc=;
        b=j4n8At+0F50aIHCzokCuV6G2AIIDLVFEBxaCI2UoedhaCYNHtdhwhs4knojpOU46HK
         nkx2X7DPdCf4QIbG28n7tcsRTTAD8I1DjPKUy5o9/t6SnIyTZ+GeFWP4UC9ovlHOBP38
         W4Z7n89LH3ogyYlcg03kpY/Wfli/xU20whDei6cqGnlcd7z8Erk0FZEN85J4A73EMUbe
         YM0Vl5l4Z3wvjNLfZb408NOx7lUUxlKorXLowVpfmxR7Drb3Q/ayTPJOIZwijvpozAas
         Sdc3ZtPEGCpY8Fvil44kRN86JyrEY7xnyY8Nk7Cezth/kUglhiWpRYps+Rty7kdTRqTd
         81YQ==
X-Gm-Message-State: AOAM533yWfZgbjb7o+Odq4LL/F6vXLqrXbwdpBR1QWbscvrNohJ4W+UU
        dt9VWDzDRjyC0Fu3ma2bAi5xhxbHo1T/s4xSjik=
X-Google-Smtp-Source: ABdhPJz/f79YwZGJBo7m3YWc3xY40nfvJQRlBC2H5UKjF1c8LPTIjDdWZ2Akv9ajo3eqEsa1S3QKHwGKOT6KZkNK6KY=
X-Received: by 2002:aca:3756:: with SMTP id e83mr2705184oia.31.1605113251772;
 Wed, 11 Nov 2020 08:47:31 -0800 (PST)
MIME-Version: 1.0
References: <20201102204344.342633-1-newren@gmail.com> <20201102204344.342633-5-newren@gmail.com>
 <cd05d258-a526-9843-f646-d2d42f1b8cbc@gmail.com>
In-Reply-To: <cd05d258-a526-9843-f646-d2d42f1b8cbc@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 11 Nov 2020 08:47:20 -0800
Message-ID: <CABPp-BFd2Wg-9h9+Gx20szX=YfKLqvBMWGg-eZU0yL8_DPh6kw@mail.gmail.com>
Subject: Re: [PATCH v2 04/20] merge-ort: use histogram diff
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 11, 2020 at 5:54 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 11/2/2020 3:43 PM, Elijah Newren wrote:
> > I have some ideas for using a histogram diff to improve content merges,
> > which fundamentally relies on the idea of a histogram.  Since the diffs
> > are never displayed to the user but just used internally for merging,
> > the typical user preference shouldn't matter anyway, and I want to make
> > sure that all my testing works with this algorithm.
> >
> > Granted, I don't yet know if those ideas will pan out and I haven't even
> > tried any of them out yet, but it's easy to change the diff algorithm in
> > the future if needed or wanted.  For now, just set it to histogram.
>
> If you are not making use of the histogram yet, then could you set this
> patch aside until you _do_ use it? Or are there performance implications
> that are also a side benefit?

Long story...

git folks tend to value performance pretty strongly -- including
sometimes valuing it OVER correctness.  For example, if fast-export
completely munges some merge commits and you send your first ever
patch in to the list to fix it (by turning on topo_order), you might
run into folks asking if it should be made an option so that we don't
slow down exports except for people who happen to know they need it
(and thus risk breaking exports for people who happen to be unaware
that they need it...).  Luckily, Peff bailed me out in that situation
by doing some timings and finding that topo_order actually made
fast-export _faster_, to everyone's surprise at the time.  Or, to take
another example, perhaps someone will introduce some commit-date
cutoff on the revision walking machinery that sometimes breaks the
answer but makes things faster...and then causes a bunch of headaches
years down the road when someone tries to introduce commit-graphs to
get us always correct _and_ fast answers.

In this case, histogram diffs in my cursory investigation are about 2%
slower than Myers diffs.  I think others may have done even more
detailed benchmarks.  They've been around for years, but haven't been
made the default, despite giving obviously better looking diffs to
users in a number of cases where Myers diffs are unintelligible.  But,
far more importantly, there are real merge bugs we know about that are
even affecting git.git and linux.git that I don't have a clue how to
address without the additional information that I believe is provided
by histogram diffs.  See the following:

https://lore.kernel.org/git/20190816184051.GB13894@sigill.intra.peff.net/
https://lore.kernel.org/git/CABPp-BHvJHpSJT7sdFwfNcPn_sOXwJi3=o14qjZS3M8Rzcxe2A@mail.gmail.com/
https://lore.kernel.org/git/CABPp-BGtez4qjbtFT1hQoREfcJPmk9MzjhY5eEq1QhXT23tFOw@mail.gmail.com/

I don't like mismerges.  I really don't like silent mismerges.  While
I am sometimes willing to make performance and correctness tradeoff,
I'm much more interested in correctness in general.  I want to fix the
above bugs.  I have not yet started doing so, but I believe histogram
diff at least gives me an angle.  But I can't rely on using the
information from histogram diff unless it's in use.  And it hasn't
been used because of a few percentage performance hit.

But, since I happen to be speeding up typical non-trivial
merges/rebases/cherry-picks by factors of 10 or more (at least,
anywhere that read-and-update-the-index is a trivial percentage of
overall time instead of 99.9% of overall time like it is for you), now
is golden opportunity to switch out the underlying diff algorithm so
that I can get the data I need to fix the bugs I know are there.
Whether I can actually fix them is yet to be seen; I won't even start
until merge-ort is complete and merged.

Does that help?
