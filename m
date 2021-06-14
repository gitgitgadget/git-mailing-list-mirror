Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61B3C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 15:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95DFC61185
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 15:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbhFNPhx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 11:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbhFNPhX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 11:37:23 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F900C061574
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 08:35:04 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id q20-20020a4a6c140000b029024915d1bd7cso2740663ooc.12
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 08:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KVjDGqKmIWSbqhcaYL8TJlkumaT7AWGZtWCAneBCNak=;
        b=aEhANkz93FBP6DLABXT8QgcwaQFsH+mMCm3YHuI7ZSP6nUdWKosRpTWJsWcOKl21+L
         atWZM5oYK/a/BS6yj/E0IM86nolKovgKYajArLnFftVNPKF2Z3Qgk8h81+M3kGkJ3RJR
         t5q8AQxRPTPCMSnsUfLyuYaVvnHb6n6ZEPShHp6k8H+/4muoq1FOZn5MpvMS2cXyOXvx
         oFo3+6Ir/lbetvLbBmSEtqw08mymcr73p4JNTcSa9hn2yhwWMU8HT3tI1YooQmv6wc6Z
         +ICnanTD9dRI6nc6ZbjghWKevBGQLJ5WCMnn5CyIIsjGIHBsii950Q7HTh2N9CVPIY3S
         k93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KVjDGqKmIWSbqhcaYL8TJlkumaT7AWGZtWCAneBCNak=;
        b=cv/aEBH7/f8JST9zvAAIqCvY8ts/zITt+e7u+8kf7qmeHOZpuKAvGHN+hEB1VzrVGp
         dZkSIOwqih/vRXro2GLVVXGSLj7EkEqurD3KipBDi7DqM3eGwNqp63FuJ/ZM9uS7fqkR
         KrYM0WFq8KRBZBeGHZD91QOm+hHEPxNOBMkkmIrgnF++oAuOBwWO0+JIo8/K5y28Lazs
         hyoppgQC7vIsEre5/L6S2V9+0x15cS4uoCovc+VMdPBxFbcRvoEOxA3fpcVHlNkmTvF1
         RIdJxsaElS/591O7oaF8pDT6iVukd6YfuOEJ/hArvEqpXSt6mM1fD7RsPGDCaouiuPfU
         PkXg==
X-Gm-Message-State: AOAM532qMRrN6jzeTLnYNN06eWJ0SMEyBfs2WdwE5F/WRe/QiyBwetFW
        O/iUO1AlcwzjAPvNo3OxHz4nvdyAUVKzlaFloKg=
X-Google-Smtp-Source: ABdhPJyhkmiRhupTbOJ16yERF6UanzCI2WBH9npDK+k5/Bt6jeGNDLcrbQ12rBuGS4bRfMzu3KqtFGo7q7Nmlg3R1Cc=
X-Received: by 2002:a4a:b301:: with SMTP id m1mr13396539ooo.7.1623684903499;
 Mon, 14 Jun 2021 08:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210613225836.1009569-1-felipe.contreras@gmail.com> <20210613225836.1009569-5-felipe.contreras@gmail.com>
In-Reply-To: <20210613225836.1009569-5-felipe.contreras@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 14 Jun 2021 08:34:52 -0700
Message-ID: <CABPp-BGZ2H1MVgw9RvSdogLMdqsX3n89NkkDYDa2VM3TRHn7tg@mail.gmail.com>
Subject: Re: [PATCH 4/4] xdiff/xmerge: fix chg0 initialization
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 13, 2021 at 4:04 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> chg0 is needed when style is XDL_MERGE_DIFF3, xdl_refine_conflicts()
> currently is only called when level >= XDL_MERGE_ZEALOUS, which cannot
> happen since the level is capped to XDL_MERGE_EAGER.
>
> However, if at some point in the future we decide to not cap diff3, or
> introduce a similar uncapped mode, an uninitialized chg0 would cause a
> crash.

If this cannot happen now, and is needed by your other posted patch,
why aren't these two patches either combined or posted as part of the
same series?  (I think a separate submission _only_ makes sense if you
explicitly withdraw the other patch from consideration, otherwise it
feels dangerous to submit patches this way).

> Let's initialize it to be safe.

Is it being safe, or is it hacking around a hypothetical future
segfault?  Are these values reasonable, or did you just initialize
them to known garbage rather than letting them be unknown garbage?
Are there other values that need to be changed for the xdiff data
structures to be consistent?  Will future code readers be helped by
this initialization, or will it introduce inconsistencies (albeit
initialized ones) in existing data structures that make it harder for
future readers to reason about?

I'm somewhat worried by the cavalier posting of the zdiff3 patch[1],
and am worried you're continuing more of the same here, especially
since in your previous post[2] you said that you didn't know whether
this particular change made sense and haven't posted anything yet to
state why it does.  Peff already pointed out that you reposted the
zdiff3 patch that had knonw segfaults without even stating as much[3].
That's one thing that needs to be corrected, but I think there are
more that should be pointed out.  Peff linked to the old thread which
is how you found out about the patches, but the old thread also
included things that Junio wanted to see if zdiff3 were to be added as
an option[4], and discussed some concerns about the implementation
that would need to be addressed[5].  Given the fact that Peff liked
the original zdiff3 patch and tried it for over a month and took time
to report on it and argue for such a feature, I would have expected
that when you reposted the zdiff3 patch that you would have provided
some more detailed explanation of how it works and why it's right (and
included some fixes with it rather than separate), and that you would
have included multiple new testcases to the testsuite both to make
sure we don't cause any obvious bugs and to provide some samples of
how the option functions, and also likely include in the cover letter
some kind of explanation of additional testing done to try to assure
us that the new mode is safe to use (e.g. "I ran this on hundreds of
linux kernel commits, with X% of them showing a difference.  They
typically looked like <Y>" or "I've run with this for a month without
issue, and occasionally have re-checked a merge afterwards and found
that the conflicts were much easier to view because of...").  Short of
all that, I would have at least expected the patches to be posted as
RFC and stating any known shortcomings and additional work you planned
on doing after gathering some feedback.

You didn't do any of that, making me wonder whether this patch is a
solid fix, or whether it represents just hacking around the first edge
case you ran into and posting a shot in the dark.  It could well be
either; how are we to know whether we should trust these patches?

(Having read the old zdiff3 thread after Peff pointed to it, I really
like the idea of such an option.  I'd like to see it exist and I would
use it.  But I think it needs to be introduced appropriately,
otherwise it makes it even less likely we'll end up with such a
thing.)

[1] https://lore.kernel.org/git/20210613143155.836591-1-felipe.contreras@gmail.com/
[2] https://lore.kernel.org/git/60c677a2c2d24_f5651208cf@natae.notmuch/
[3] https://lore.kernel.org/git/YMbexfeUG78yBix4@coredump.intra.peff.net/
[4] https://lore.kernel.org/git/7vip42gfjc.fsf@alter.siamese.dyndns.org/
[5] https://lore.kernel.org/git/20130307180157.GA6604@sigill.intra.peff.net/

> Cc: Jeff King <peff@peff.net>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  xdiff/xmerge.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
> index b5b3f56f92..d9b3a0dccd 100644
> --- a/xdiff/xmerge.c
> +++ b/xdiff/xmerge.c
> @@ -333,7 +333,7 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
>                 mmfile_t t1, t2;
>                 xdfenv_t xe;
>                 xdchange_t *xscr, *x;
> -               int i1 = m->i1, i2 = m->i2;
> +               int i0 = m->i0, i1 = m->i1, i2 = m->i2;
>
>                 /* let's handle just the conflicts */
>                 if (m->mode)
> @@ -384,6 +384,8 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
>                         m->next = m2;
>                         m = m2;
>                         m->mode = 0;
> +                       m->i0 = i0;
> +                       m->chg0 = 0;
>                         m->i1 = xscr->i1 + i1;
>                         m->chg1 = xscr->chg1;
>                         m->i2 = xscr->i2 + i2;
> --
> 2.32.0
