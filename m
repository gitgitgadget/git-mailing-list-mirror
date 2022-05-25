Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBCBC433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 03:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243422AbiEYDrQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 23:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbiEYDrO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 23:47:14 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6938F579A1
        for <git@vger.kernel.org>; Tue, 24 May 2022 20:47:12 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id wh22so38982088ejb.7
        for <git@vger.kernel.org>; Tue, 24 May 2022 20:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+oUK/pY3zCElLLzDjcdDcsmMrap/xV56M76a6RYWeDk=;
        b=S6/UnQRW5x5UG58BtNmjQx2BmOV8YdRgcYA3buryJq4cV2/E17Ig70tLs2ypJ4wlJn
         N0DJzZhsvWBYUjFlaG/zwz0TyoOBqnJE/t840I6aotFyHneWOjXLCz72FZxXSN/wOLET
         YCkaGxG81E6wRTmq5bFlAaXQ+68EFg095IHmHZ4qII5vPtd3apGdLtlJ/3Y6XVBijkHo
         e0sy/VRnrvqiI82X4iy30r/cSNXkT8Q55PvgaBX6ZxZCM8ISa9Bsxkacng+OPEABJq4g
         VkaCB30ZWNhgA728OEVgWn0xF9xGgsejV52UhSrXzn2qqVb5nJo2VJ/pgPMMnY3ZPHkE
         h9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+oUK/pY3zCElLLzDjcdDcsmMrap/xV56M76a6RYWeDk=;
        b=i8URPdYiap4hSlgY/NeuXDnLgNF1NO/6TPwGF9YlNWFhyvNp+2y3qHCzYL3yd6OU3f
         DBq/2lskTftM1ce8vqXLl+YRB3AQZac0Zhs1ZjH7cJgnMkGYTufKDf0FHwM5d0kG15WS
         RLlM6qFBIgu9Q1zNrfwvQN2ZlqtiwZDwCejtJYsg8J/Z3PrvlLunvYZS23cewXWD3cs0
         wM8slEyZSLKNGekyJaHMkcfUMT6huC+bxWQvoIw7jSfU7uc30YyjJowguQebWVLZxzED
         deyQAnasT3n5SHjX0On7xQEszBMXu97hC/3AAv9rrI8isV3y5R6gevaXkJmRL3alUSpq
         QVhQ==
X-Gm-Message-State: AOAM530RFiz0Q/8E8otes6UP/+sPsgtWhkTTV9h/o5PpCUoAWUca/0bz
        qIGqrfmdB/PggJPYD9Z3V1YGIQ16X0aqRNkukQeYvOSm
X-Google-Smtp-Source: ABdhPJwYmPABk31nt1PodQT1D+em/4gY5QTMjOL0KP4s1Cp8RGKgfUMC5IoC0/FpRkH4nEexXyanre1AMv7mMpKhREA=
X-Received: by 2002:a17:907:7ea9:b0:6fe:d412:ec2c with SMTP id
 qb41-20020a1709077ea900b006fed412ec2cmr13417755ejc.613.1653450430915; Tue, 24
 May 2022 20:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220505203234.21586-1-ggossdev@gmail.com> <20220510171527.25778-1-ggossdev@gmail.com>
 <20220510171527.25778-2-ggossdev@gmail.com> <xmqq7d6sm3e0.fsf@gitster.g>
 <CABPp-BGXRzYCvyM38dEUvQ125+VtRu++7L9UiRz98u+1=Lov7A@mail.gmail.com> <xmqqilpuhfz2.fsf@gitster.g>
In-Reply-To: <xmqqilpuhfz2.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 24 May 2022 20:46:59 -0700
Message-ID: <CABPp-BHHyouFfJ4OC=xShxFASTdBL=7qxnvwS7pDQ+xO6iTW2w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dir: consider worktree config in path recursion
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Goss Geppert <gg.oss.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        christian w <usebees@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 24, 2022 at 12:45 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Wed, May 11, 2022 at 9:37 AM Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> Goss Geppert <gg.oss.dev@gmail.com> writes:
> >>
> >> > diff --git a/dir.c b/dir.c
> >> > index f2b0f24210..a1886e61a3 100644
> >> > --- a/dir.c
> >> > +++ b/dir.c
> >> > @@ -1893,9 +1893,31 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
> >>
> > [...]
> >>
> >> > +                     real_gitdir = real_pathdup(the_repository->gitdir, 0);
> >>
> >> This function is repeatedly called during the traversal.
> >>
> >> How expensive is it to keep calling real_pathdup() on the constant
> >> the_repository->gitdir just in case it might be the same as our true
> >> GIT_DIR?
> >
> > I agree that treat_directory is called many times, but this
> > real_pathdup() call is inside the "if (nested_repo)" block, so this
> > new real_pathdup() invocation should occur very seldom.  Or are you
> > worried about cases where users have *very* large numbers of bare
> > repositories nested under the working directory?
>
> No.  I wasn't worried about anything in particular.  I just wanted
> to get the feel of how deep a thought the patch was backed by by
> spot checking what was and what was not taken into account when
> designing the change.
>
> I do not care too much when there are very large numbers of things
> that cause this codepath to be exercised.  Strange situations can be
> left for later optimization only when they turn up in the real world
> and prove to be a problem.

Ah, gotcha.

> By the way, where is a bare repository involved?  did you mean
> non-bare aka worktree-full repository?

Yes, sorry, I meant non-bare repository.
