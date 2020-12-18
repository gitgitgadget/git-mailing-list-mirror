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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A861C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40F5423A57
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgLRFkF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 00:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgLRFkE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 00:40:04 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD398C0617A7
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 21:39:24 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id j20so935497otq.5
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 21:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k3m1W2sb1U3hp0Lleq6rpt9rOROpivB3HT+ZLainA7w=;
        b=Haw8zZ3CkHmSwEpeNVD7GirKIUVHKk7OatcaajW4bvl/hO29EKYCbRECPKlc/aUgpD
         f2cXb1FEo62EOhMRK4lNzQZ4E8rLVfFFuKa0wdB9fF+Lp9HpXtrBzAom2YPu3GG/k3wf
         s+Ch/wconcolIHtVZqhr7IYEBF5qq3oezxAeVeJjH0d4/xUHFBgNOzTB90E/dgZdp0cP
         hmpOnJAt4oXNg/BM+36SxutEjQ5Zq57v4LFxQ0XvFA+aGG1+AOhbhvw3IEv3f7mjc5tU
         +omaIyLHdfVdnTsKswZ7AXqH40f6yBvhdsUKwVN4dK6wIMkG0i3P7L4FY3sUtOlYCODg
         TETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k3m1W2sb1U3hp0Lleq6rpt9rOROpivB3HT+ZLainA7w=;
        b=cZc+uW0aNq4tKdwIJfL0sLI0fPYKgp6vW/wGUtB19sCjKsC+QCE0uGR4Lz+fXpztlE
         SmSWgXLeDjFX4L12FM1ZEwrmH1EgXsT9B1N2ESmpM+sCfsilP2re6xkfP8EDmmf8rGH0
         QxpdGBJZBXLbeF1VKJ7aMYsh2H/JPVtQXpxZeV6zHmgHQYyd6G5DugDiOhkdy6kD24pP
         oOv0BPaYF0yT66tUduRq6ruNR+g1e41kKisnyRGWbm79rWv4nlGPx+TBAgojwb1XSVPV
         WLyZ0zlNJ54TlkwIJ4wAYoUxJOdUu6FHC2Z9kV8iVVaMSGbWtKPzrrebGEoqpbFAga4H
         DPxQ==
X-Gm-Message-State: AOAM532IQyjO1K3/J93/7HKmKGY/90SR1ablekbQbeeNYhDtUHQrTj3p
        +qUBR9jGAPc+Sy2P32cJY+Y1Bg905CG807G3XDA=
X-Google-Smtp-Source: ABdhPJwM+fj6Fd5hK+PC/vdVS0/NiNptxYuhFy0DNt0j1gP58SzFzMUTkdI91IPh0URqIXEWbvK7j4PEnZxwd6MHr/0=
X-Received: by 2002:a05:6830:1610:: with SMTP id g16mr1755570otr.345.1608269964063;
 Thu, 17 Dec 2020 21:39:24 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <20201216184929.3924-1-sorganov@gmail.com>
 <20201216184929.3924-23-sorganov@gmail.com>
In-Reply-To: <20201216184929.3924-23-sorganov@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 17 Dec 2020 21:39:13 -0800
Message-ID: <CABPp-BG1S83EUbqtqqjeLT4=Je44BpRMrf0MB+DNQK2wjRDbqQ@mail.gmail.com>
Subject: Re: [PATCH v2 22/33] diff-merges: implement new values for --diff-merges
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 16, 2020 at 10:50 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> We first implement new options as exact synonyms for their original
> counterparts, to get all the infrastructure right, and keep functional
> improvements for later commits.
>
> The following values are implemented:
>
> --diff-merges=          old equivalent
> first|first-parent    = --first-parent (only format implications)
> sep|separate          = -m
> comb|combined         = -c
> dense| dense-combined = --cc
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  diff-merges.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/diff-merges.c b/diff-merges.c
> index 6446e2093661..cba391604ac7 100644
> --- a/diff-merges.c
> +++ b/diff-merges.c
> @@ -15,6 +15,11 @@ static void set_separate(struct rev_info *revs) {
>         revs->separate_merges = 1;
>  }
>
> +static void set_first_parent(struct rev_info *revs) {
> +       set_separate(revs);
> +       revs->first_parent_merges = 1;
> +}
> +
>  static void set_m(struct rev_info *revs) {
>         /*
>          * To "diff-index", "-m" means "match missing", and to the "log"
> @@ -38,11 +43,19 @@ static void set_dense_combined(struct rev_info *revs) {
>  }
>
>  static void set_diff_merges(struct rev_info *revs, const char *optarg) {
> -       if (!strcmp(optarg, "off")) {
> +       if (0) ;

Leftover cruft from some intermediate changes or something?

> +       else if (!strcmp(optarg, "off")   || !strcmp(optarg, "none"))
>                 suppress(revs);
> -       } else {
> +       else if (!strcmp(optarg, "first") || !strcmp(optarg, "first-parent"))
> +               set_first_parent(revs);
> +       else if (!strcmp(optarg, "sep")   || !strcmp(optarg, "separate"))
> +               set_separate(revs);
> +       else if (!strcmp(optarg, "comb")  || !strcmp(optarg, "combined"))
> +               set_combined(revs);
> +       else if (!strcmp(optarg, "dense") || !strcmp(optarg, "dense-combined"))
> +               set_dense_combined(revs);
> +       else

Not sure I like the special-casing for "sep" and "comb".  "dense"
seems okay since it's a real word.  Since you're adding short versions
of m, c, and cc later in the series, do we need these other
special-case forms?

>                 die(_("unknown value for --diff-merges: %s"), optarg);
> -       }
>  }
>
>  /*
> --
> 2.25.1
>
