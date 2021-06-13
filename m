Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08291C48BE8
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 14:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D83BF61285
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 14:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhFMOgI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 10:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbhFMOgI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 10:36:08 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C233C061766
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 07:34:07 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id v17-20020a4aa5110000b0290249d63900faso2040043ook.0
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 07:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=3CBqCzZX7WZhn7Q2xCyW6evMJYEu9OWMmfKvDQvhI8Q=;
        b=OU2e8QxWq56jssxGKbrlfPzpahUK2E7phHN8FG1UGPwECdyqMIhXPYbOA2eKy81YvZ
         fGdI4wyTyIBnm6AzUpq5H37t7xxhgz6NJWcgsyH4MefotpB7vQaD0fDZHiqnCmqbnAYu
         05C8eRZNtJ6GFxydabPWNvmWqWqCYDpgKUVFfD29fbA4+vU++GG7/3Pj8g+0pFWbbmyD
         1AtXGiHXPkKNS34PKycG9jVarsi4x6fCCd8HoF0Xp+SOlSdFzKEFKBmH26p0gmZs1MCR
         m361+MzlrgmCFTfAvr6hUCkLHdsMLzfthq2Kbzdu7Hqv2q9ckSosbW9DiIVILe7GFL9f
         u0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=3CBqCzZX7WZhn7Q2xCyW6evMJYEu9OWMmfKvDQvhI8Q=;
        b=YwfeCQN6IChs98Ga1u8QzucLSLnBj0Guh40jGRBmnDmWgN8UfeRYvroEVBOv0TBszp
         RbuVOvc+eSvNT/k7ReQvztV4JLCwlOlRjyDA4L2WSu25vWZrZoabq5Gsnp8M9sGhrL9M
         mlRYzojk6H3TQyxZLrKf4Gmu2j2MuzwaC064C+z3z+rZ2MNxdjt7LfqSfXB7OzQTJU1o
         bPXNUtJvrLhwNQaE2jFWcCLGhBNyElET/2QtPVm9GXJk4ov6YmjM29sWosdVHyU1Gg1f
         M5/aBRdBwFUJUWLwCg9rVpWcAX1K4ROwunPPmSRXcncqD0BX6ccN14v6HOggIhu0da92
         +FUw==
X-Gm-Message-State: AOAM5329e/n2LMCvttxe6NQk5A1uNDf4j9v6PwN4lCcNgtJ+n0B+Fa4j
        7E34o3HSTJ4Nv0N4Bgn16e8=
X-Google-Smtp-Source: ABdhPJyEHCfecH9MrqFSddL4AGscJRNjbWjT5n7ra6nXjY5I3ra2GWOHxnvhZnS5sRNDPJvYDFvd9A==
X-Received: by 2002:a4a:d052:: with SMTP id x18mr10147870oor.21.1623594846393;
        Sun, 13 Jun 2021 07:34:06 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id f19sm2735515ots.41.2021.06.13.07.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 07:34:05 -0700 (PDT)
Date:   Sun, 13 Jun 2021 09:34:04 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        David Aguilar <davvid@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <60c6175ca6840_41f2b208fc@natae.notmuch>
In-Reply-To: <CABPp-BGhaSJmqXFKpCVcUKexNXaa8sLEms-6q-qno7uETzGQ=A@mail.gmail.com>
References: <60c3a41bd25e3_8d0f2089e@natae.notmuch>
 <20210611190235.1970106-1-newren@gmail.com>
 <60c3d0296f869_8d0f208ec@natae.notmuch>
 <CABPp-BGhaSJmqXFKpCVcUKexNXaa8sLEms-6q-qno7uETzGQ=A@mail.gmail.com>
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Fri, Jun 11, 2021 at 2:05 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > Elijah Newren wrote:
> > > On Fri, Jun 11, 2021 at 10:57 AM Felipe Contreras <felipe.contreras@gmail.com> wrote:
> >
> > > > Or just use the base of the virtual merge:
> > > >
> > > >   <<<<<<< HEAD
> > > >   D
> > > >   ||||||| merged common ancestors
> > > >   1
> > > >   =======
> > > >   C
> > > >   >>>>>>> C
> > >
> > > I think that implementing this choice would look like this (again, not
> > > compiled or tested and I'm not familiar with xdiff so take it with a
> > > big grain of salt):
> > >
> > >
> > > diff --git a/ll-merge.c b/ll-merge.c
> > > index 095a4d820e..dbc7f76951 100644
> > > --- a/ll-merge.c
> > > +++ b/ll-merge.c
> > > @@ -130,6 +130,8 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
> > >       memset(&xmp, 0, sizeof(xmp));
> > >       xmp.level = XDL_MERGE_ZEALOUS;
> > >       xmp.favor = opts->variant;
> > > +     if (git_xmerge_style >= 0 && opts->virtual_ancestor)
> > > +             xmp.favor = XDL_MERGE_FAVOR_BASE;
> >
> > The only time git_xmerge_style isn't >= 0 is when no merge style has
> > been configured by the user.
> 
> Yep, probably should have just been
> 
> +     if (opts->virtual_ancestor)
> +             xmp.favor = XDL_MERGE_FAVOR_BASE;
> 
> Though the difference doesn't matter a lot.  Since
> merge.conflictStyle=merge (which is the current default) doesn't
> display the contents from the merge base in a three-way content merge,
> setting xmp.favor to XDL_MERGE_FAVOR_BASE vs. leaving it as 0 for the
> recursive/intermediate merges won't generally end up affecting the end
> result.  It'd only matter for diff3 and zdiff3 users.

OK, so:

  if (git_xmerge_style > 0 && opts->virtual_ancestor)

> Going on a slight tangent, I think there's actually a related bug
> here.  We probably should not honor XDL_MERGE_FAVOR_{OURS,THEIRS} when
> opts->virtual_ancestor is true; that's just asking for trouble.  I
> think it'd paradoxically result in reversing the desired behavior
> (e.g. users would see what they'd consider XDL_MERGE_FAVOR_THEIRS
> behavior when they asked for XDL_MERGE_FAVOR_OURS) in some cases as a
> result.

Maybe write a test-case and find out?

> > In fact, I don't see why any style should change that desired behavior.
> > If you said there's issues with the "merge" style too, perhaps the above
> > will help for those cases too.
> >
> > > > We don't have to use diff3 all the way.
> > >
> > > Right, thus my mention in the other email to consider adding a
> > > XDL_MERGE_FAVOR_BASE -- which you then also mention here in your third
> > > option, and which I've now given at least a partial patch for.  Not
> > > sure if it's a crazy idea or a great idea, since I don't do very many
> > > criss-cross merges myself.
> >
> > I thought you meant as a separate configurable flag, not something done
> > by default.
> >
> > Now that I understand what you meant I think it could be a great idea.
> 
> If someone that does lots of criss-cross merges can comment on the
> idea, and agree that it's worth a shot, I can try to turn it into real
> patches.

I would flip the conditional: if nobody that does lots of criss-crosses
objects...

If we waited for a tiny minority of users to speak up before doing
something we migth wait forever.

> (I might even try to investigate the zdiff3 stuff too, which sounds
> like something I've wanted many times...but I'd really rather
> concentrate on merge-ort until its upstreaming is finished.)

Well, I just re-sent the patch:

https://lore.kernel.org/git/20210613143155.836591-1-felipe.contreras@gmail.com/

Cheers.

-- 
Felipe Contreras
