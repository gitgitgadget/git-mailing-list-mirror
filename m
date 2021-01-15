Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2222C433DB
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 18:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6A47235F8
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 18:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbhAOSF6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 13:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbhAOSF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 13:05:57 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82867C0613C1
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 10:05:17 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id h18so5491827vsg.8
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 10:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RCQYD50vIpFiXzYdU7FNQrMpLS3WYiwlaUVy4bxuUK4=;
        b=kgIQGbkE7slm5jcKIyJr1BrM2adYbS6/WvKJiOrJ+i/XfN9Mo6HADh0Td64ybcAa0s
         e2xMX9X+lNFj1E/ChW9Y7UEndOXFcBdYAGiMm2CFVm/4assvm+RRweT4omx3xsBAyJdp
         V+7p763ju0yA0cQaUk8SWb0dmr3x+kkmUdCU5rR9iSOwWaefx9gWvhZ8jM2c9PCix86Y
         doJvKrR1uWed2gqp30z29slwHNKsYOixm2HW3GyrIGgHJwNSGBLqX+Bmuibk9nteYKCB
         e842RAOoaDXqz3cHbla1SdEdIk8bZ3P6hjvWCGoIQk2qIzXOBD8sX+/gIdJ9Y/fEILwJ
         9Jlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RCQYD50vIpFiXzYdU7FNQrMpLS3WYiwlaUVy4bxuUK4=;
        b=SaiKDvcxTVv8FGekYFuw18C1WTVN8V5iSukkOzPWrcxFmRyLYYAe3WR0vGVCe84LC2
         1fGf+qVUq8E1ZuvRwVkFVlcVDypbpM4HN18/oW67xmz+IjhTtOuu1a5QHgBxR7s+8lvx
         kR+kAWVedg6v2KycCJacmAX092Gw9Pmp4h2EwvxRP8q4d7m90G8bxZybNBp3wnTyRogx
         Dt0+JBMCRhKzGBdXzBKYxWGKvOZYUBe1m/KnicxQ67lWqpSFhSms4bXBZWS9ZNltORvj
         /sWTDs8TWXq8cOnP2Kb7bjc80khizqK4BYWQyZz4L8XAvZjQ9iDh4rSYk3Inu4RGswQZ
         DQ+A==
X-Gm-Message-State: AOAM5305HFGrL5OsWDqslD1ehLDGM/FzRtvs1NPomIuMZXVVmSC86SMj
        Y1FHIWJ6CAkfqWHPydU9xRauxeU2zMxRXh7NQB8=
X-Google-Smtp-Source: ABdhPJwCKNqEtRO6969z2mDmTeVRVQg+a51eNvOMJBKfi/tc6hfjX8qYf4QJgiQuuIiA4+d463ImogwOOvnEcr1ILpA=
X-Received: by 2002:a05:6102:242a:: with SMTP id l10mr676036vsi.58.1610733916815;
 Fri, 15 Jan 2021 10:05:16 -0800 (PST)
MIME-Version: 1.0
References: <CAPSFM5c2iqBn8_Dih2id7q6RRp0q=vfCSVUHDE5AOXZ8z3Ko9w@mail.gmail.com>
 <CAPSFM5f+cm87N5TO3V+rJvWyrcazybNb_Zu_bJZ+sBH4N4iyow@mail.gmail.com>
 <99b40665-45dd-6c4d-d46a-56c7dbf89568@gmail.com> <YACAHdDEMIgvQruK@nand.local>
 <0236bb58-61a7-6126-b50f-93e8b6bf3aef@gmail.com>
In-Reply-To: <0236bb58-61a7-6126-b50f-93e8b6bf3aef@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 15 Jan 2021 19:05:05 +0100
Message-ID: <CAN0heSqnaOi+2k_2mtKBW4wPoGSZ=nAkt1wQaeocgKy9s7b45g@mail.gmail.com>
Subject: Re: How to implement the "amend!" commit ?
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Charvi Mendiratta <charvi077@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 15 Jan 2021 at 12:08, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 14/01/2021 17:32, Taylor Blau wrote:
> > On Thu, Jan 14, 2021 at 10:39:50AM +0000, Phillip Wood wrote:
> >>> Secondly, As an alternative to above, we can use `--fixup=<commit>
> >>> --amend` and `--fixup=<commit> --reword`.
> >>
> >> This is not backwards compatible. At the moment If you create a fixup with
> >> `git commit --fixup=aaa` and then realize it should refer to commit bbb
> >> instead you can fix it with `git commit --amend --fixup=bbb`. That would no
> >> longer be possible.
> >
> > Too bad. I felt that this was the most ergonomic idea put forwards, but
> > I also thought that we died with '--amend --fixup=xxx'. Its current
> > behavior does make sense to me, but it's too bad that we can't use it
> > for this new purpose.
>
> I guess we could decide to change the behavior but I'm not sure there is
> a sufficiently compelling reason to do that. I agree the current
> behavior makes sense but (based on no data at all) I'm not sure that it
> is used very much. [...]

Data point: I've done this more than once to correct my choice of which
commit to fixup. I'd like to think I'm not very special, so I would
guess that I'm not the *only one* who has come up with that and found it
useful. As for being used "very much", no idea.

But regardless of that, it feels awkward to me to tie those two options
together. That feeling might well correlate with having found that
combo to be useful in the first place, though.



Martin
