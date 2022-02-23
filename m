Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA52C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 07:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbiBWH62 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 02:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiBWH61 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 02:58:27 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A33C77AB8
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 23:58:00 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id p15so50473954ejc.7
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 23:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S/1fO6MoCRsWqQGsZqKUrlM0wxp9sDdBrME2p1A8jlk=;
        b=HkFJDxIrVB9zdTsRgPK9r4Es12KrsHGjQInDgfrzJgaQT23wUXEtzKwlcYgHlXBKqe
         2oL/rDhLeqYFTjBjY5NA2NRdcTmKpiREclJsU6zbD0xzB9dsgaoz+3BxfKgYK0slbsk4
         gkmIkI0eJ+DkvX+L04EbAqyYwWAVGjxaDmX7PwtOCYuGnOiw0IhtUu5hi0tRHFlkt0vZ
         5vc0NXotJde3iym76nx6nQdTmCCNpox2qU2gE5+1Z8NAcLHWj9QV5RyVjpg3QPaZBNZy
         s+H2Q2Xg+ed+cp87YhCSFCZ7HVtjTinO+WNS9UBBkcUmI6PYe5spIT4Apics/ABOqN/j
         j8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S/1fO6MoCRsWqQGsZqKUrlM0wxp9sDdBrME2p1A8jlk=;
        b=2BFRazNqUTvsr4jb/28m5YX6KB/m0H8OUqbgy1nic95vhkCFiP7NTIrAgdcX/Upy8v
         ZjOGPCTTGZ99M7iiX63FkITd383Re9J6eM+iGjRxsRxulH7RxlB2b6yzFc2JlD/Fv6Mz
         Sgu4GsaMWfT2mbDrr5OQKDbD9pQ2NOYQ6Z7p6vBctgh6htLAQtBe7oZuCwlNT+nToROn
         UEQipAa++aZ/Eu1ub9K5bPv49NJ1Co8cluCvfQE3sOXXIrGaQIGcWI3YF+AFxF3TRH/9
         juRFM3hgoSuSz17FZRzTerZFH6zmkMO67W7BaH/2UqiquyU5ikcHWkmQuujEILFT1iJ2
         5Pww==
X-Gm-Message-State: AOAM531YipZqW9OQtRb0J9cLqKV4vPEzLe3gE8+RZvaJxVF2SzURYr/b
        vvARRzQNiyHcLLf4Bobje1AWTQ6Pb5/rkkgM9ACgnSXo/L0=
X-Google-Smtp-Source: ABdhPJw19ek/7tG7mSpkqqRgOILMQVCgjmt+BzGfIcZmVC69ZFyh0VKeEBlSGGFHbuFUanEPGHnEBYe01iVujzQKesw=
X-Received: by 2002:a17:906:64e:b0:6ce:36ae:7ab5 with SMTP id
 t14-20020a170906064e00b006ce36ae7ab5mr22146697ejb.192.1645603078611; Tue, 22
 Feb 2022 23:57:58 -0800 (PST)
MIME-Version: 1.0
References: <pull.1152.git.1645290601.gitgitgadget@gmail.com>
 <pull.1152.v2.git.1645320591.gitgitgadget@gmail.com> <f1f7fc97fe2fe5079365bb91c71fb7033378995d.1645320592.git.gitgitgadget@gmail.com>
 <YhL6i3x1l4qwQJg+@nand.local>
In-Reply-To: <YhL6i3x1l4qwQJg+@nand.local>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 22 Feb 2022 23:57:47 -0800
Message-ID: <CABPp-BFO0dz6t2ouC0+40Z6oDnGc32GKDHUpeFfh7C_Vpccerg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] merge-ort: fix small memory leak in detect_and_process_renames()
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 20, 2022 at 6:35 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Sun, Feb 20, 2022 at 01:29:50AM +0000, Elijah Newren via GitGitGadget wrote:
> >  merge-ort.c | 15 +++++----------
> >  1 file changed, 5 insertions(+), 10 deletions(-)
>
> Both versions of this patch look good to me (in fact, I appreciated
> seeing both v1 and v2, since v1 makes it more obvious what is changing,
> but v2 does the whole thing in a little bit of a cleaner way).

Thanks for taking a look!

> > diff --git a/merge-ort.c b/merge-ort.c
> > index d85b1cd99e9..3d7f9feb6f7 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -3086,12 +3086,11 @@ static int detect_and_process_renames(struct merge_options *opt,
> >                                     struct tree *side1,
> >                                     struct tree *side2)
> >  {
> > -     struct diff_queue_struct combined;
> > +     struct diff_queue_struct combined = { 0 };
> >       struct rename_info *renames = &opt->priv->renames;
> > -     int need_dir_renames, s, clean = 1;
> > +     int need_dir_renames, s, i, clean = 1;
>
> And this entire patch looks good to me, but I did wonder about why "i"
> is an int here. Shouldn't it be a size_t instead? Looking at
> diff_queue_struct's definition, both "alloc" and "nr" are signed ints,
> when they should almost certainly be unsigned to avoid overflow.

You may be right, but I'm not sure we're too worried right now about
folks having billions of paths involved in renames; such a repo would
make even the Microsoft monorepos look miniscule.  ;-)
