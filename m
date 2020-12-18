Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D14C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 16:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8417E23B28
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 16:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgLRQnE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 11:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgLRQnD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 11:43:03 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F42EC0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 08:42:23 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id q25so2432163otn.10
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 08:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u72jS/VRA4QhxRJnaJGXYD8BQvNuEtoklXfHKlVwL/g=;
        b=CHZYg+414iBg6M9JT5qwQ71lUh8AF+fQgdcpxe2OMDi2oWMREgSrUyTiLmQFOcRpgp
         ttEB8L67ur21lCoxSNBeVYI7pnJDwT0dtUPtsHg0sNqBVfo3jYanQ5F2SBXWGuMBgqsr
         R20KUabyDPLX3I7xXSoUy7tuargU8P4iMuxKj5k2i38sDBaT1QFDbLBZp06ZT/c/tFyu
         MtOhvcE3BGoqlrqoXXrx5I1qaw0eetpapdQZPAaSk7as/vzgHp01vsdLpkQUXYoYEZ1D
         SQdJVxrjKABV+zwy9zFaGbZTInyyc3ZmGbmLJf3gNgTOV3VCspurD+43diuYRetVvDOH
         qe4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u72jS/VRA4QhxRJnaJGXYD8BQvNuEtoklXfHKlVwL/g=;
        b=ubuB0EJtQjlh97GBWprPQfOVNdHOm0JZW9B7PVfvea0MjSnniUrxXYxR0J/V/EeWb7
         Chjw3mOPcNj+DYBf7AkeXpzEtd/dzg1J5BJ0BY/DDw8AqzZfD5zHdKn5s95k503vP0D7
         Uo7YI3DZQfE9JzlUNxkztdEWtKF49Ybc6Yj3U8OoRyePyqmwAHWZz1ZKkGZhzznnpGZK
         GghekumFuOwqyM9HOfcReuG9JTAstA0ZvsghEe4C3fheyScAD2ABlkln1XvFs8YxcYEO
         kGDJm5wvSDW6x6lwY96Js7JR5beyADVIrw+ep+EjuYrspEMgZhE1fbgGgUjtUU7pNWvv
         3YCA==
X-Gm-Message-State: AOAM53002I/BLIRhBMytbtG6Qt2cZziGShcyj/qS6OSIlRUnK5pHdiz/
        mZmzFiOuQlTS5LIGIZG3emd2rrjfO0BnskiRCBs=
X-Google-Smtp-Source: ABdhPJwhct9IVjN64mMZAtjsE8DVi3NDKt/POL7DrY9/d5Q5RK3pdIxHZLLqKohg4YGW3mQxQC8/lkvkXhVlKiOfgrY=
X-Received: by 2002:a9d:b8e:: with SMTP id 14mr3423197oth.316.1608309742618;
 Fri, 18 Dec 2020 08:42:22 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <20201216184929.3924-1-sorganov@gmail.com>
 <20201216184929.3924-23-sorganov@gmail.com> <CABPp-BG1S83EUbqtqqjeLT4=Je44BpRMrf0MB+DNQK2wjRDbqQ@mail.gmail.com>
 <871rfncie5.fsf@osv.gnss.ru>
In-Reply-To: <871rfncie5.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 18 Dec 2020 08:42:11 -0800
Message-ID: <CABPp-BFtJ_LE2RhKoOQQ7h_Nspa=12Chwtp8kBq0PCKA6j2BPA@mail.gmail.com>
Subject: Re: [PATCH v2 22/33] diff-merges: implement new values for --diff-merges
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 18, 2020 at 6:12 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Wed, Dec 16, 2020 at 10:50 AM Sergey Organov <sorganov@gmail.com> wrote:
> >>
> >> We first implement new options as exact synonyms for their original
> >> counterparts, to get all the infrastructure right, and keep functional
> >> improvements for later commits.
> >>
> >> The following values are implemented:
> >>
> >> --diff-merges=          old equivalent
> >> first|first-parent    = --first-parent (only format implications)
> >> sep|separate          = -m
> >> comb|combined         = -c
> >> dense| dense-combined = --cc
> >>
> >> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> >> ---
> >>  diff-merges.c | 19 ++++++++++++++++---
> >>  1 file changed, 16 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/diff-merges.c b/diff-merges.c
> >> index 6446e2093661..cba391604ac7 100644
> >> --- a/diff-merges.c
> >> +++ b/diff-merges.c
> >> @@ -15,6 +15,11 @@ static void set_separate(struct rev_info *revs) {
> >>         revs->separate_merges = 1;
> >>  }
> >>
> >> +static void set_first_parent(struct rev_info *revs) {
> >> +       set_separate(revs);
> >> +       revs->first_parent_merges = 1;
> >> +}
> >> +
> >>  static void set_m(struct rev_info *revs) {
> >>         /*
> >>          * To "diff-index", "-m" means "match missing", and to the "log"
> >> @@ -38,11 +43,19 @@ static void set_dense_combined(struct rev_info *revs) {
> >>  }
> >>
> >>  static void set_diff_merges(struct rev_info *revs, const char *optarg) {
> >> -       if (!strcmp(optarg, "off")) {
> >> +       if (0) ;
> >
> > Leftover cruft from some intermediate changes or something?
>
> No. It's just an idiom for if-switch, making all the actual cases look
> the same. Without this the first one looks special when in fact it
> isn't. I won't die for it though.
>
> >
> >> +       else if (!strcmp(optarg, "off")   || !strcmp(optarg, "none"))
> >>                 suppress(revs);
> >> -       } else {
> >> +       else if (!strcmp(optarg, "first") || !strcmp(optarg, "first-parent"))
> >> +               set_first_parent(revs);
> >> +       else if (!strcmp(optarg, "sep")   || !strcmp(optarg, "separate"))
> >> +               set_separate(revs);
> >> +       else if (!strcmp(optarg, "comb")  || !strcmp(optarg, "combined"))
> >> +               set_combined(revs);
> >> + else if (!strcmp(optarg, "dense") || !strcmp(optarg,
> >> "dense-combined"))
> >> +               set_dense_combined(revs);
> >> +       else
> >
> > Not sure I like the special-casing for "sep" and "comb".  "dense"
> > seems okay since it's a real word.
>
> That was a poor-man attempt at unique shortcuts made by hand, as well as
> a reminder to consider to re-write this using generic options framework
> that will do it automagically. They are just a few first letters,
> nothing more. That's why I didn't even document them.

Seems like a
   /* TODO: use generic options framework to allow abbreviations */
would make that intent much more clear.

> > Since you're adding short versions of m, c, and cc later in the
> > series, do we need these other special-case forms?
>
> No, I don't think we do necessarily need them, but then they do no harm
> either, so I didn't remove them when I added m, c, and cc. Neither was I
> sure we do need these m, c, and cc in the first place.

Well, I'd say it certainly adds clutter for reviewers, so there is at
least a little harm.  ;-)  It was on the patch that added m, c, and cc
that it particularly stood out to me, so I looked up the relevant
commit so that I could add the comment at the right place to make it
easier for you to rip out.
