Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F69C433E3
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 00:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02F5220702
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 00:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeMa0rYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgHUAAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 20:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgHUAAG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 20:00:06 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906B4C061385
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 17:00:06 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id e14so1310767vsa.9
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 17:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w/5Yw1cJ+dgB7OPdqKioas4ZdQIzoMPVpaVsPQf5Qp8=;
        b=FeMa0rYqpaOALRErClh4XwEwjuQ3djUiEMpK2E9Iqo0ie2er4Q4HyNoaZ0LY0UijJw
         yWdZReS7xgDGi92GjlBngolp3Y395MWQeB0CBKbP7hFTgoK0pKPdWV+pVWPgQ8OqNYvH
         Bhh0ohmRQc0p73HgC2LTMD94dBqc3lHqi+icWGGAfN3LMquB1qpDq476Z0lYbJ1SeBIx
         BvDr0zGJWNu4DX+sQkDfBWTNJxB3mS1cXPEtl+Iyy2FwcGFm8lNBDqpBa1tq68s4YscH
         DxF7omajLD98cMZmx+nbGJRj9X5/PZd+PXuUWY1YcV1FvBlZNbKtNkbM78l6YMLy16DE
         CHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w/5Yw1cJ+dgB7OPdqKioas4ZdQIzoMPVpaVsPQf5Qp8=;
        b=OhM2F5kInycZGdePjYytgunM1wIps3ud3h1+AyvAQk8c3S54Vcm/R0VtLW1mWkDR+T
         6eSm8fGbaH/t+2xOvlUgY2bn0poagK0QhkJasA4YxQrMP4zX0YrCSmonAgGIfChIRz7x
         S16vH+UW8czbW44eWch93HejQYbQ8jv5GMabSXPnXCq6RE1pagW7qXs0qVSfpkJ0oSia
         7bN46uBclgsxARRzAYlBYiUyHnRXPYVFWLj7sAT8P1+VT3hFUZ+2VFN7Sfll9kQnCo2C
         vc6O78QHlJERdfZdPKn5ArU1Q8pQNiHOMD8s9MxDLdKDNEQpgDtZqLeamrZjInm2gE98
         rtcA==
X-Gm-Message-State: AOAM533Qsn0jjKHkba9ex5cWyNkoQbufpflPd5RNeFMWd7VUDONPyHm0
        PtkOVfv6GNFrCu2SZQJVOpORexBTssnAad1AJC4=
X-Google-Smtp-Source: ABdhPJxmh293Dv2EL4tmCu2Qapul8fmJ6e1msYTBUqnq8BayTOhbrYM8egTdZTGy2h/4ZDacsIMfvgK4KbneSC9ApiM=
X-Received: by 2002:a67:8807:: with SMTP id k7mr334908vsd.153.1597968004954;
 Thu, 20 Aug 2020 17:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200815002509.2467645-1-jacob.e.keller@intel.com>
 <20200815002509.2467645-3-jacob.e.keller@intel.com> <xmqq5z9gzvmb.fsf@gitster.c.googlers.com>
 <CA+P7+xpcm51cLPDDW+F1J-XZ2VvwNDWjnZqm54f3DKXxDfBF5Q@mail.gmail.com> <20200818174116.GA2473110@coredump.intra.peff.net>
In-Reply-To: <20200818174116.GA2473110@coredump.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 20 Aug 2020 16:59:53 -0700
Message-ID: <CA+P7+xqfAqnoKBeOiO6f7tdyi_7M=wKpmnFoWBt6UHbOqbYCzQ@mail.gmail.com>
Subject: Re: [RFC 3/3] refspec: add support for negative refspecs
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 18, 2020 at 10:41 AM Jeff King <peff@peff.net> wrote:
>
> On Mon, Aug 17, 2020 at 05:04:00PM -0700, Jacob Keller wrote:
>
> > > > +     /* apply any negative refspecs now to prune the list of refs */
> > > > +     ref_map = apply_negative_refspecs(ref_map, rs);
> > > > +
> > > >       ref_map = ref_remove_duplicates(ref_map);
> > >
> > > How was the ordering here decided?  Should it result the same set if
> > > negative ones are excluded after duplicates are removed?
> >
> > Good question. This was what was done in peff's original patch. I need
> > to understand a bit more about what ref_remove_duplicates does to
> > really figure this out.
>
> The relevant commit is 2467a4fa03 (Remove duplicate ref matches in
> fetch, 2007-10-08), I think. We may end up with multiple refspecs
> requesting a particular ref. E.g.:
>
>   git fetch origin refs/heads/master refs/heads/*
>
> I don't think the order should matter. If we apply negative refspecs
> first, then we'd either remove both copies or leave both untouched (and
> if the latter, then de-dup to a single). If we apply negative refspecs
> after de-duping, then we'd either remove the single or leave it in
> place. But the result is the same either way.

I'm not sure this is quite true in the case where destinations are
supplied. Suppose this case:

git fetch refs/heads/*:refs/remotes/origin/*
refs/other/mybranch:refs/remotes/origin/mybranch

This would ofcourse error out due to de-duping where we determine that
both would fetch to the same place.. however if you also added a
negative refspec:

git fetch refs/heads/*:refs/remotes/origin/*
refs/other/mybranch:refs/remotes/origin/mybranch ^refs/heads/mybranch

then shouldn't this work? meaning we should de-dupe only after we
apply negative refspecs in this case?

>
> > > > @@ -1441,6 +1445,8 @@ int match_push_refs(struct ref *src, struct ref **dst,
> > > >               string_list_clear(&src_ref_index, 0);
> > > >       }
> > > >
> > > > +     *dst = apply_negative_refspecs(*dst, rs);
> > > > +
> > >
> > > The block of code whose tail is shown in the pre-context has
> > > prepared "delete these refs because we no longer have them" to the
> > > other side under MATCH_REFS_PRUNE but that was done based on the
> > > *dst list before we applied the negative refspec.  Is the ordering
> > > of these two correct, or should we filter the dst list with negative
> > > ones and use the resulting one in pruning operation?
> >
> > I think we need to swap the order here. I'll take a closer look.
>


> Hmm. I think the behavior we'd want is something like:
>
>   # make sure the other side has three refs
>   git branch prune/one HEAD
>   git branch prune/two HEAD
>   git branch prune/three HEAD
>   git push dst.git refs/heads/prune/*
>
>   # now drop two of ours, which are eligible for pruning
>   git branch -d prune/one
>   git branch -d prune/two
>
>   # push with pruning, omitting "two"
>   git push --prune dst.git refs/heads/prune/* ^refs/heads/prune/two
>
>   # we should leave "two" but still deleted "one"
>   test_write_lines one three >expect
>   git -C dst.git for-each-ref --format='%(refname:lstrip=3)' refs/heads/prune/ >actual
>   test_cmp expect actual
>
> I.e., the negative refspec shrinks the space we're considering pruning.
> And we'd probably want a similar test for "fetch --prune".
>
> I just tried that, though, and got an interesting result. The push
> actually complains:
>
>   $ git push --prune dst.git refs/heads/prune/* ^refs/heads/prune/two
>   error: src refspec refs/heads/prune/two does not match any
>   error: failed to push some refs to 'dst.git'
>
> For negative refspecs, would we want to loosen the "must-exist" check?
> Or really, is this getting into the "are we negative on the src or dst"
> thing you brought up earlier? Especially with --prune, what I really
> want to say is "do not touch the remote refs/heads/two".
>

Hmmm..

For regular push the negative refspec applies to the source. For prune
though we only provide a destination..

> We can get work around it by using a wildcard:
>
>   $ git push --prune dst.git refs/heads/prune/* ^refs/heads/prune/two*
>   To dst.git
>    - [deleted]         prune/one
>
> So it works as I'd expect already with your patch. But I do wonder if
> there are corner cases around the src/dst thing that might not behave
> sensibly.
>

Right, there's some interesting questions here still.

> -Peff

I'll be adding this as a test!

Thanks,
Jake
