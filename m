Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70750C43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 11:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiFBLbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 07:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiFBLbq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 07:31:46 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5243BD6D
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 04:31:45 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id h137so572354iof.8
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 04:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hBu3yZAkWdyxZLsbLNqA4zrMOTf8KdojudSxkiXrq4I=;
        b=m13SlWh6/7aqUDbWwWoSQmkBY1vrZuVucbS8wRXwhpdqhceoo39DKIJnbcZJv8jYEo
         SETtuccuEoatoHEsPhJcGoaEEuIftqhDS1xUbYywVJshKQGfjpb7UwbgRxdBqImNHPpt
         6Am9zbeJfFkTMewh9aFixO8dOwKPZmBa8O5/yztxRnEVvcjeUOtRacuFmTXbt0JxLMaL
         Z2JGroy2KWnYh2LR6lsrMmaDnK0MIvMG5lMOoU+J4v83RVSURwWUYdBwuhqMdrBcfMjs
         ffTrTXSFKK5He8pJn+miFiwyeyiKIYtHpnLYAt1yto82Sneq/sHxCfR2QshD8jebafvl
         WnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hBu3yZAkWdyxZLsbLNqA4zrMOTf8KdojudSxkiXrq4I=;
        b=k5vvIGx1KyRXfyPic4lDZrUfZlxJ7TAKLcp2DzPGD4Efp7HnDRep9iKBiW66O9+xdJ
         VM2CJqh22JqlomrD9Gg+7psJOsyZyWMy5U82QjlP/Xc9yMqDgEyu035TrdVLvemdn0U2
         YnN9Tl3HQfEuHbM/wzcXRkQIcVFuV0bfwwSPU989J/gDEn+J62+xck/lOfiA3/sxSCx5
         /Li/98kADsKx4alLV3QQmsyMNnVGjUmdqZAIXW3lkcPBbFU5rIvfl3yQNGhcgl03mgTB
         GiUqACed+gShE0k3e9+iJDOLGmt4yrsXXZ904lMvszvsDc/lrBsHj/QV/UTT74xXMfgG
         P/OQ==
X-Gm-Message-State: AOAM530JzeZYmJVtYS+ZMmOCsxuqbpK/VV/lRebmRauuU4tkGCY9qCs9
        Egbc1l6gdQj6PxkEaAu77RzdJG3gxuJ+gyavMvbEWjGrURo=
X-Google-Smtp-Source: ABdhPJxxnUC8Cks86sNTmAuZmjz4XeOi+FAHAl8zaK2yRpJFaP8O3B99APY26l19wMq/tcOEITSwS6qQ/126T27Tfic=
X-Received: by 2002:a05:6602:248f:b0:65a:fb17:7a6b with SMTP id
 g15-20020a056602248f00b0065afb177a6bmr2267220ioe.79.1654169504702; Thu, 02
 Jun 2022 04:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAHHcNoe12h5E9OmkZy03-i7miFg2hLiT04BF3_t9C2bcmduR5Q@mail.gmail.com>
 <CAPx1GvfQLP3q-SvW38=VOxoAmQpMMau_UfXXXQiZSV3NOJCs0w@mail.gmail.com>
In-Reply-To: <CAPx1GvfQLP3q-SvW38=VOxoAmQpMMau_UfXXXQiZSV3NOJCs0w@mail.gmail.com>
From:   Akos Vandra-Meyer <axos88@gmail.com>
Date:   Thu, 2 Jun 2022 13:31:33 +0200
Message-ID: <CAHHcNodnB8gnaLgxW-vr6PxHh_YjCOAf7CTuot-CJsonb1mdnA@mail.gmail.com>
Subject: Re: BUG? git stash and immediate git apply results in conflict
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris,

Thanks for getting back to me on this.
My use case is the following:

I made a bunch of (loosely related) changes to my code, but I have
been asked to submit them as separate commits, so I need to separate
the changes to dependent files relating to the first and second
feature.

So I need to separate the changes in my workdir into two commits
(let's call them two features). Turns out the first feature needs a
dependent file changed in one way, and the second feature improves on
it, so it needs it changed in another way - normally this would result
in a conflict if they would have been done separately in different
branches.

I start off by stashing everything except stuff directly relating to
the first feature and stashing everything else. Check for build
errors, unstage, and incrementally staging more stuff that need to be
added in order to make the first feature build correctly. At some
point I reach the file that has to be changed differently, so I will
have a set of changes staged for that file, while another set of
changes remain unstaged - the changes that will be required by the
second feature.

At this point you pointed out that apparantly I'm misusing git, but I
am confused on how to correctly stash the unstaged changes to check if
the code would build with the staged changes only, and unstage them
and add more stuff if not?

Thanks,
  Akos





On Thu, 2 Jun 2022 at 08:32, Chris Torek <chris.torek@gmail.com> wrote:
>
> On Wed, Jun 1, 2022 at 2:11 PM Akos Vandra-Meyer <axos88@gmail.com> wrote:
> >  git stash -ku
> >  git stash pop
>
> This is not a bug in `git stash` itself, but rather in the way you're using it.
>
> There are two mistakes on your part here:
>
> 1: You are using `-k`, aka `--keep-index`. This flag is intended for usages
> that are not yours here.
>
> 2. You are *not* using `--index` in your `git pop`.  The `--index` flag is
> intended for the kind of thing you are doing here.
>
> It's a bit unfortunate (and perhaps worth some work in the documentation)
> that the `--keep-index` and `--index` flags sound so similar, and yet are so
> different.  The documentation could use some examples here, I think.
>
> Note that if you *do* want to use `--keep-index` during the `git stash` step,
> you will need a `git reset --hard` before your `git stash apply --index &&
> git stash drop` step (aka `git stash pop --index`).
>
> Chris
