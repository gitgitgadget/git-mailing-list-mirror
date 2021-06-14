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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD74CC2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 14:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB6F16124B
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 14:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbhFNPAX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 11:00:23 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:40834 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbhFNPAX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 11:00:23 -0400
Received: by mail-oi1-f182.google.com with SMTP id d19so10605934oic.7
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 07:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pprmJPlJkh3htdQ+diWDL7WZq578nsq85Hneu8Z9MFg=;
        b=G7o8GIBLwjuLp5liXZi70Z/WDahvTzES8oq7KwUvZL5s2bPs5vV7OrlvWJ5OVppU4W
         bReji/YDCdw9TSucIUk/gjqU7O9mHyIcVfHTFBM5KbKkBvtLD3FA0b6wCEw/wVsOouLc
         kJ1SOpdnxrrVEB4OLYpHyotm1r0cuxPknDPRSGNLP3Wfoy3/+rN3B8Ie3LxgnutbalTS
         4wXLDF64HyUxfOPl0jl7ZGUE9j18N6xMNOLWaERJRtmeQrUU6QJXyUzfX5YOL7O1NMPn
         aNHSHFvgfK4RWxc9f9nm3Aea66mfLOJp8/Fu/Qor9+r1FFMK2kA1kwHyFRaqHi60SL/X
         rByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pprmJPlJkh3htdQ+diWDL7WZq578nsq85Hneu8Z9MFg=;
        b=UPnMDgTharCxplBUUBmxmeJPUZfTFqxx1Kx5BvUd/EN/RPI0IRmLQZSsl8l2biGEn5
         ZYm5GlJwzZaUUWehQByd6rl3T5+YBDbCy4Ab91E8SDXIvlWwe4BYvE3ZPkj6ulBABO6G
         CdFl00o9z6FXYPZ1LpcM59vVJGF5CIDdpOrR+dYa3PYtBx8Q6uh4WIuRyxxwqkeYgsv/
         +uVvycGPYsEY79QcaXg7A+Ao9FOW4Bu5FtH2PxEtH5ScPRDmTrcuKvjHIyooshjT8gWX
         qnCj1dALya6XgeNyrddNAIoOD0KSKjLkUvpIbPzWJUlATPwu+7Gc9y3CIO8O7IcjKuIe
         WJfA==
X-Gm-Message-State: AOAM531euS7r62qBWJ2rbAmTJPuPQ1K8miczE7l+jFgswRpJb/+Wuf8Z
        05ROEOY3VRRdXQOaI+qXTpbDgM9Ow63bgDP5Jy8=
X-Google-Smtp-Source: ABdhPJy5HTEnpzkjKeDy1N4yavk5D7Iv3C+qF6pvU8OLCuscMxWj3nCVXrv4O58UZTTUG2UxUOow3d9ZPIwhudDw8Zw=
X-Received: by 2002:aca:f482:: with SMTP id s124mr21472340oih.167.1623682626047;
 Mon, 14 Jun 2021 07:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210613045949.255090-1-felipe.contreras@gmail.com> <20210613045949.255090-2-felipe.contreras@gmail.com>
In-Reply-To: <20210613045949.255090-2-felipe.contreras@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 14 Jun 2021 07:56:54 -0700
Message-ID: <CABPp-BGstXDbzxpySw7q_jn22HD05MsrZeHNv+kXFHOFS2_WCQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] pull: cleanup autostash check
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 12, 2021 at 9:59 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Currently "git pull --rebase" takes a shortcut in the case a
> fast-forward merge is possible; run_merge() is called with --ff-only.
>
> However, "git merge" didn't have an --autostash option, so, when "git
> pull --rebase --autostash" was called *and* the fast-forward merge
> shortcut was taken, then the pull failed.
>
> This was fixed in commit f15e7cf5cc (pull: ff --rebase --autostash
> works in dirty repo, 2017-06-01) by simply skipping the fast-forward
> merge shortcut.
>
> Later on "git merge" learned the --autostash option [a03b55530a
> (merge: teach --autostash option, 2020-04-07)], and so did "git pull"
> [d9f15d37f1 (pull: pass --autostash to merge, 2020-04-07)].
>
> Therefore it's not necessary to skip the fast-forward merge shortcut
> anymore when called with --rebase --autostash.
>
> Let's always take the fast-forward merge shortcut by essentially
> reverting f15e7cf5cc.
>
> Reviewed-by: Elijah Newren <newren@gmail.com>

I think you are basing the Reviewed-by on
https://lore.kernel.org/git/CABPp-BEsQWsHMAmwc3gmJnXcS+aR-FtoMJxBRQ=BpARP49-L-Q@mail.gmail.com/;
is that correct?  Messages from folks that they seem to like the patch
or believe it looks good should be translated into an Acked-by rather
than a Reviewed-by; from Documentation/SubmittingPatches:

* `Reviewed-by:`, unlike the other tags, can only be offered by the
  reviewer and means that she is completely satisfied that the patch
  is ready for application.  It is usually offered only after a
  detailed review.

Sorry for not catching this when you posted v3 & v4 of your earlier
series.  When your series exploded in size and seemed to just be
accumulating additional changes you wanted to make in the area that
weren't in response to reviewer feedback (I wasn't sure why the new
patches in subsequent rerolls weren't just separate series), I didn't
have the bandwidth to keep up and review them, so I just missed it.

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/pull.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index e8927fc2ff..a22293b7db 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -947,7 +947,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>         struct oid_array merge_heads = OID_ARRAY_INIT;
>         struct object_id orig_head, curr_head;
>         struct object_id rebase_fork_point;
> -       int autostash;
>         int rebase_unspecified = 0;
>         int can_ff;
>
> @@ -982,8 +981,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>         if (get_oid("HEAD", &orig_head))
>                 oidclr(&orig_head);
>
> -       autostash = config_autostash;
>         if (opt_rebase) {
> +               int autostash = config_autostash;
>                 if (opt_autostash != -1)
>                         autostash = opt_autostash;
>
> @@ -1065,13 +1064,12 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>                      recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) &&
>                     submodule_touches_in_range(the_repository, &upstream, &curr_head))
>                         die(_("cannot rebase with locally recorded submodule modifications"));
> -               if (!autostash) {
> -                       if (can_ff) {
> -                               /* we can fast-forward this without invoking rebase */
> -                               opt_ff = "--ff-only";
> -                               ran_ff = 1;
> -                               ret = run_merge();
> -                       }
> +
> +               if (can_ff) {
> +                       /* we can fast-forward this without invoking rebase */
> +                       opt_ff = "--ff-only";
> +                       ran_ff = 1;
> +                       ret = run_merge();
>                 }
>                 if (!ran_ff)
>                         ret = run_rebase(&newbase, &upstream);
> --
> 2.32.0
