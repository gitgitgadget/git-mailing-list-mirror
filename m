Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E117FC54EEB
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 11:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E382120774
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 11:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtdBERB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgCVL1U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 07:27:20 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:46038 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgCVL1U (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 07:27:20 -0400
Received: by mail-ed1-f43.google.com with SMTP id u59so12891179edc.12
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 04:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IohmThxyKt7BE5knODDnXnLAL3TnNqF3NVU6wrT2KRA=;
        b=WtdBERB3gqnB+emEemzLGsRdBdMdYGZH6ie/wfHa4XIoQSwWkGhfEG+US6nhqwddHM
         E7hAhG+IW9esTfM10jeTHz11SozU/r8sqZax91UtXIggdZxWeZIYcdwlvtuCZ/Lmdg/Z
         3y0ULccQc963A3Qu7pr7rd7MGdKPAdHk3IeL6tRh00rEhKdupyAg2/tjyUKggCZd7JI4
         CKp87lqBzdtN4vbpetaUvhQSnL14IWTrm+6S0D9wGCC8a9hXUcRNRzlfDLl/ecNOmnoJ
         AU+cazmIT4Zs9M2CrJSHnM5cefxdShbr0wC60dHOTnsfCZ5AOap/gYtgZlFV90c0hyXz
         JYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IohmThxyKt7BE5knODDnXnLAL3TnNqF3NVU6wrT2KRA=;
        b=M9OpOiipuFvtfx9QgCdHeURb94YeMF2H63Z/TeS1APJFWugYn7qNXoWYfIg4y5/yL2
         t4jwUauaoNFnyMG11e7jSLJKpu5fxVYRbcVkpwdR4uYMNINtLpVJ9CHG3RkThQaOKBif
         zw6ewWrqG7EhqFdDy3+8vnI5DlOAJkrt3RZgtnxu/Sg0+OMN/ueS/ZZdK0CCfaxWGs5e
         iM+H/ycmPGnSjez1/QiXKZDVv3L88BDsuMJTOrK1xL7/Z52tSqNlG2LV15NQnNcKEfnt
         pv5PFZGm/Vhyvh7mL7lVTg1Fy+Tt9zEH2R9xgnyPOzZZkZflFmBKXh/ayhfh6DHrts7s
         mqAQ==
X-Gm-Message-State: ANhLgQ2ZJc2alnde6ybOeLSkv19J1W4C7OYdp+cIJ+d5eyby3SClPcYc
        wDGS78Gwf5a0wpJgdbLsEW3w1POMzM9mHM8x5R4=
X-Google-Smtp-Source: ADFU+vuDt0sedRyipNSSlR7QYvEdlbzQrjdxQw0PdZp2FbxS7vGrNNiu+ESmHD20M+fPu5BJ+mg4CauVSl1HamZghGQ=
X-Received: by 2002:a17:906:3502:: with SMTP id r2mr15383171eja.67.1584876437889;
 Sun, 22 Mar 2020 04:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk66fu7dZ4H8tvnbxfdBRcRdx-3f_cJSdVAoKrE3UbR3nehfA@mail.gmail.com>
In-Reply-To: <CAHk66fu7dZ4H8tvnbxfdBRcRdx-3f_cJSdVAoKrE3UbR3nehfA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 22 Mar 2020 12:27:06 +0100
Message-ID: <CAP8UFD0T4OXaTyVYhkG56Gko=qtUAA1bVfyKNbX05Xprwe__Bg@mail.gmail.com>
Subject: Re: [GSoC][RFC] Convert mergetool to builtin
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhishek,

On Wed, Mar 18, 2020 at 5:31 PM Abhishek Kumar
<abhishekkumar8222@gmail.com> wrote:
>
> Hello Christian
>
> Sorry for the late reply - the work on the interval based graph labels has
> been pretty chaotic. I am going to roll out the second version of this
> proposal soon.

Great!

> In the meantime,
>
> > [...]
> >> ### Conversion of mergetool--lib
> >>
> >> As mentioned earlier, conversion of the mergetool-related scripts has to be
> >> spread over 2-3 SoC or similar projects due to the size of scripts involved.
> >> Conversion of mergetool would set up most of the plumbing required for
> >> mergetool--lib and makes the subsequent conversion possible.
> >
> > I wonder if it would be better to convert git-mergetool--lib.sh first
> > and then git-difftool--helper.sh and git-mergetool.sh that are using
> > it.
>
> I had been agonizing over this decision while I was initially writing
> the proposal.
>
> My justifications for mergetool.sh over mergetool--lib.sh at the time were:

[...]

> As it stands now, I am open to converting either scripts.

It's ok to give all the above arguments in your proposal, and then to
say that you studied how to convert one of the possible scripts more
and that's the reason you choose to convert it in your proposal.

> >> ## Plan
> >>
> >> Similar to the conversion of difftool, I plan to create a builtin that shells
> >> out to a helper script. Once mergetool--lib is converted, we can retire the
> >> helper script and conversion would be complete.
> >
> > So you plan to create a builtin that would shell out to git-mergetool--lib.sh?
> >
> > Could you be clearer about what the conversion of difftool did and how
> > you plan to imitate that?
>
> Conversion of difftool had three patches:
>
> 1. difftool: add a skeleton for the upcoming builtin
> - Rename git-difftool.perl to git-legacy-difftool.perl
> - Create builtin/difftool.c which executes git-legacy-difftool.perl
> - Add difftool to builtin.h
> - Add "difftool.usebuiltin" configuration option
> - Modify build process
>
> 2. difftool: implement the functionality in the builtin
>
> 3. difftool: retire the legacy script
> - Remove git-legacy-difftool.perl from the build process
> - Remove outdated "NEEDWORK" comments
> - Remove perl dependency from test file
>
> Since most of the conversion was done in a single commit, it is hard to talk
> about the exact order of changes.

It's ok to just say all the above in your proposal.

> Similar to this, my changes can be grouped as:
>
> 1. Create a skeleton builtin.
> 2. Implement scaffolding, implement shared functions, teach builtin to resolve
> symlink, submodule and deleted file conflicts, and others. They form the core
> functionality of mergetool.
> 3. Teach builtin to shell out for file conflict (at which we retire
> mergetool.sh)

Ok, to group however you want. What I am just saying it's that's it's
valuable if your proposal shows more clearly how your steps or
the way you group the changes corresponds to what was done for difftool.

> >> 8. Teach builtin to assign merge tool (July 10 - July 15)
> >> - Convert `get_configured_merge_tool` from mergetool--lib
> >> - Around 50 lines
> >
> > Ok, so at this point you start to convert git-mergetool--lib.sh. Where
> > is the converted code going to be? Does git-difftool--helper.sh needs
> > what you will convert?
>
> Yes. Some functions like get_configured_merge_tool, guess_merge_tool are only
> used by mergetool and can be moved to builtin/mergetool.c.

Ok.

> >> 9. Teach builtin to shell out for file conflict (July 15 - July 31)
> >>  - Write a minimal mergetool--helper.sh (similar to difftool--helper.sh)
> >> - Call the helper script from the builtin
> >> - Retire the legacy script.
> >
> > Which legacy script?
>
> git-mergetool.sh was renamed to git-legacy-mergetool.sh back in first step.

Ok.

I hope to see the above answers in the next version of your proposal.

Best,
Christian.
