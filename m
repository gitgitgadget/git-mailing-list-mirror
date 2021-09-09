Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31BAC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 21:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8646161132
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 21:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbhIIVha (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 17:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbhIIVh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 17:37:28 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4E7C061574
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 14:36:18 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id z2so3516132iln.0
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 14:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dS/aKPPdneW/nX43PmXlKUWtToPBczPMA88qPM8jRjg=;
        b=Aswjky2hUBIJAqL641L2TuLJSoWjK4d0vo5nWyo0jGH3/cGyzf6Dh2g9WlHSoCDSoE
         rinW+WUn9dAA70oLHLyrR2U+g6YGDJOdF9F+ww2KXc3lKEBkJcp5uzG5YkOfNlLsGl1t
         xLl1RO/EmlMaCPrp95OgM7P+XQBdAothv5vzSZmL0NP1DY1ajqLYIK2UHp72cSvNeXdD
         dw85aPQS81dGFQBFwUps+3WAKLGL/Dcm4Ag5YrCLdMk0/JLC9jAHnoAvYBheS8Ujd5XP
         Tkb3vMblIrdvCnnRPH4ypwPy8kqmZlOPIPlUhI6n7CR0/FwE8SHODouCib2ZTBT21h1s
         x5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dS/aKPPdneW/nX43PmXlKUWtToPBczPMA88qPM8jRjg=;
        b=L2Vz2OFSyp8T+uexArxs3pmuc13aVhpA8Az20yKbYOE8ZPtcYulFNm0/YRgNqEb1ae
         yODI9weXoamxdzdMgyPeHmUovOo1cHBMTv/3c2yfLGdWTwzIZ2QdQTPMC7+RWao5Njgo
         kbrXsK44VvLZdVBD4dVv8K82Osh40K8FV97hmKpDerPGRpY5h3EiDLGSC3apPtxuAjjX
         2gHFctvIkJYcUjhVgLcP/ht1lhmXJAEk9vfJANfJ0mwgFGetn+EWqEKzCkoThEsbB2JD
         apWG3eFu8nVHdMMgfncIp3fiXDUmwGRtFmvhDP3eyiinOfl542Nqvcbc8xF9bBlvYvQT
         oVLQ==
X-Gm-Message-State: AOAM530uAhxUxuMPaPSOltQma0raRVubgYcCJ6ax0C5Fwm6UoHZ9XvNj
        PeW5K08uVQHF5BiRmXDn28GLaAumfMOeDSBBbTFrS31ixlc=
X-Google-Smtp-Source: ABdhPJwG11/07JVXYG1f293hN4MyO/QFBT+WPC13WEBTA4KEe2225N0bWRor59FaTLsaktT32NsRi0P7MYYJaRyTvoA=
X-Received: by 2002:a05:6e02:d43:: with SMTP id h3mr3856589ilj.112.1631223377471;
 Thu, 09 Sep 2021 14:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAF8BazDKG03bpBEQyC9EsM8WxV_7WnQ386T=VT49EHNzsZ3PPw@mail.gmail.com>
 <YTktpQ9uZkbwtuLO@coredump.intra.peff.net> <CAF8BazB+RLrzD7eO_fmsUbLY0DbqFeum+eMeY1hdZSAnWTxn4A@mail.gmail.com>
In-Reply-To: <CAF8BazB+RLrzD7eO_fmsUbLY0DbqFeum+eMeY1hdZSAnWTxn4A@mail.gmail.com>
From:   Aleksey Midenkov <midenok@gmail.com>
Date:   Fri, 10 Sep 2021 00:31:00 +0300
Message-ID: <CAF8BazDyALuPtazZ-H5HnsR2HweVsc6yZPbObSDG+y-m+cUF3Q@mail.gmail.com>
Subject: Re: git diff: print hunk numbers?
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 9, 2021 at 6:45 PM Aleksey Midenkov <midenok@gmail.com> wrote:
>
> On Thu, Sep 9, 2021 at 12:39 AM Jeff King <peff@peff.net> wrote:
> >
> > On Wed, Sep 08, 2021 at 11:40:20PM +0300, Aleksey Midenkov wrote:
> >
> > > Is that possible/how to print hunk numbers with git diff?
> > >
> > > F.ex. instead of:
> > >
> > > @@ -106,7 +110,6 @@ while ($r < $statement_count)
> > > ...
> > >
> > > To print something like:
> > >
> > > @@ -106,7 +110,6 @@ 4 @@ while ($r < $statement_count)
> > > ...
> > >
> > > filterdiff uses hunk numbers intensively. Work with line-number ranges
> > > is not so effective.
> >
> > No, Git doesn't know how to do any annotations on hunk lines (aside from
> > finding and reporting the funcname lines from the source). So you'd have
> > to post-process it, like:
> >
> >   git diff ... |
> >   perl -pe 's/^@@.*?@@/join(" ", $&, ++$i, "@@")/e'
> >
> > but I'm not sure if that's quite what you're after. If you're using
> > filterdiff to pick out hunks, then piping through "filterdiff
> > --annotate" does something similar.
> >
> > If you want to post-process your diffs all the time, you can do
> > something like:
> >
> >   git config pager.color false
> >   git config pager.diff 'filterdiff --annotate | less'
> >
>
> Thanks!
>
>  git config pager.color false
>  git config pager.diff 'filterdiff --annotate | colordiff | less -FRX'
>  git config pager.show 'filterdiff --annotate | colordiff | less -FRX'
>
> did the job for me.
>
> > to show the annotations anytime the output is going to a terminal.
> > Though sadly filterdiff does not handle the colors; other
> > post-processors like diff-highlight parse around them.

What's more sadly filterdiff --annotate does not handle non-diff
output, so --stat option does not work! I should now detect whether it
is diff by reading the first line then return it to the pipe and run
filterdiff conditionally. That is all mess and the testing construct
just doesn't work (not sure if the command is bash-friendly at all):

git config pager.show 'IFS= read -r l; echo $l $l $l; cat'

So I can only overcome this by introducing different command through
alias `s` and assign custom pager to `s`:

git config pager.color true
git config --unset pager.show
git config pager.s "sed 's/\x1b\[[0-9;]*m//g'|filterdiff
--annotate|colordiff|less -FRX"

sed will bite out ANSI escape sequences.

> >
> > And finally, if your ultimate goal is to use filterdiff to pick out
> > hunks, you might find using Git's picking tools like "checkout -p"
> > easier. Even if you are starting with an actual patch, you can apply it
> > and then pick out bits, like:
> >
> >   git checkout --detach ;# temporary head for applying patch
> >   git apply </path/to/patch
> >   git commit -m "temporary commit for patch"
> >   git checkout - ;# back to the original branch
> >   git checkout -p HEAD@{1} ;# now selectively grab parts
> >
> > Of course that only helps if the patch actually applies. If your goal is
> > to filter out hunks that don't apply, it won't help. :)
> >
> > -Peff
>
> --
> @midenok



-- 
@midenok
