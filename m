Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D055C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 07:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2629860F02
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 07:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbhGWG6W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 02:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbhGWG6V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 02:58:21 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE92C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 00:38:54 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ga41so2208389ejc.10
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 00:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3/gGtuSnS6wbXYFrrsexTDg1lZzIC+gfq4wkzycE0P0=;
        b=ec05SvaQAijt4devrxe+HGCiP5Nsx9TrG1Nira8s2onwh+j045YI0eSEaK0aUaqeo/
         8BrRacrZ8qFKSLJMM69Vt/JYd9IJL2z5p6g+2cxSDwVDFiwxtHwS0uklyQ7/CR53Lbbt
         Y5TuvDFRyWij9hv+b6zq/IYrsLuKWHbe0O0OfoX8juZWc6OuC9hh3Oa+48I7i48+mwLV
         pBWyTsT7PB2MyJ/NK1cNyN092Fr5I9ktQobV3s6UT8lkBGpfQNs0gjfFEbeUD9Rn+qlR
         7RDBubbmAoJsW6uTB2cyxd5PtZ1IpxT+rlG9/5+qvmY32YG+zUDnP/PU+U5n/0VrRHkD
         URpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3/gGtuSnS6wbXYFrrsexTDg1lZzIC+gfq4wkzycE0P0=;
        b=HRMa9tBgSEMp7DJMlgE/isXVJf2qFdr7xRF3c0El6DWp2WZDZwsgZJ82hog32TjXTl
         4XUgn0rS9Phx751ibP24p3ZYfrQtGONr5GqVnqZRAr7shU5VK6D8l+OgjJda69fht7rg
         lXCEAlxmq5N/tR0W+csUIVCDrl1XyYpzEIe7V8UfOK8nIWpGKRowoA6SXl2gma5KqCak
         HNuFJQAL1xqb9GdH0tAoKtSiQ1YJ53Ir/BAFgp8GG3aiUs6lfqxdTI1dW/7+9paFalJy
         hNTX9V388zzAn1dkYGM2aAgWkbfvl9NHlXJOA8zEvzuFbYJ6mOfYku7ITWeN6z/4Btqx
         /Dtg==
X-Gm-Message-State: AOAM531wctqYPqZVqjLlzMYWATuur8nAeD+kmoidDDF+W9xBSTUEQYZ/
        r1+hNbBn4gaSkcKfccst5mzRgNW/2oumWnjxL6k=
X-Google-Smtp-Source: ABdhPJwz2Q63JPNM/6/WzOVeDAfDGHlOKOOmllYDvwB95JxF5EyzIpZ2g/MK6cGPRKnFbyzr3t2h18u0EgL8gwKEHmQ=
X-Received: by 2002:a17:907:2d8a:: with SMTP id gt10mr3589151ejc.10.1627025933317;
 Fri, 23 Jul 2021 00:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAB9Jk9AafnUQr6q8t=b4Dh0PZHUA=fKJmtXxxObuGpF_w-_2wQ@mail.gmail.com>
 <871r7qvhhr.fsf@evledraar.gmail.com> <CAB9Jk9DqCR8C9qx6-gZmpTQfBAKnEupQTb1WkJgN3YOqSO0=2A@mail.gmail.com>
 <YPppNYOO26xAq2fn@coredump.intra.peff.net>
In-Reply-To: <YPppNYOO26xAq2fn@coredump.intra.peff.net>
From:   Angelo Borsotti <angelo.borsotti@gmail.com>
Date:   Fri, 23 Jul 2021 09:38:41 +0200
Message-ID: <CAB9Jk9Af-GKFUQCiyN9fKmjA1hOLBw9mc_FPFBHX1m1NAnbfmQ@mail.gmail.com>
Subject: Re: Extracting a file
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

> You might also like "git checkout -p HASH -- A", which will let you pick
> individual hunks from HASH:A and apply them to your working tree.

This shows the differences between the committed and the current file,
in a patch
form, which is handy to apply to the current file to make it equal to
the old, but
not if I want to browse the old file and understand how it was before.
Moreover, the command ends by asking:

    Apply deletion to index and worktree [y,n,q,a,d,?]?

and when I must be very careful to provide the correct answer so as not to
damage my files.
So many alternatives to simply get a file from the repo, some of which
potentially
dangerous, show that there is a need for a simple, safe command to get it.

-Angelo

On Fri, 23 Jul 2021 at 09:01, Jeff King <peff@peff.net> wrote:
>
> On Thu, Jul 22, 2021 at 11:46:01AM +0200, Angelo Borsotti wrote:
>
> > Actually, I did not want to make git behave like a read-only filesystem,
> > but only to be able to get what is stored in it using some easy to remember
> > command.
> >
> > I guess that:
> >
> >     git mv A B &&
> >     git checkout HEAD -- A
> >
> > renames file A in the work, current, directory to B, and then recovers
> > A from the
> > repository. This changes the file on which I am working. After having
> > read the old
> > A, and understood what changes I make that are not correct, I should delete A,
> > and rename B back to A.
> > If something gets wrong with this, I risk to damage my original A.
> > This is why it is
> > better not to change it, and instead get a copy of the old one with
> > another name,
> > which is what
> >
> > git show HASH:file/path/name.ext > some_new_name.ext
>
> You might also like "git checkout -p HASH -- A", which will let you pick
> individual hunks from HASH:A and apply them to your working tree.
>
> -Peff
