Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3BEC433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 06:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiBDGIU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 01:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiBDGIU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 01:08:20 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB9FC061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 22:08:19 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id k25so15963450ejp.5
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 22:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=/3HPhhj09iZ2758Bq0XO+mj790fbP8mrX3nSiTVGLmg=;
        b=Md0/lJgtypwOroIXcwOpBerAdFzyeKYRT3iox47RhXmCNyzhHwSU2UiwBBTzDBanoP
         wI2J7xgGmMk4uNzkRFjTBsb5YcV+IZkTPh8FOKtoRJFi1d19viNGANY9ujzRi+vPkZ4Z
         DM5+7TMc7SrLS2cERr+bFtE+cuEupQRDmCtZ+DHeVnmO3m/GKYHLtpPAVba0iC0/QSwx
         bhyiM5zIg4pB9420cBBJrtsrw+rVlb3LeeXSIWyiWjjePEIWsGPqcPzCovCSgSquTGDe
         AZWX9tA+NhNYvN+vE8krxV+AhVcRBy3oBP0QjPqBwwoinXv2L+T0RJqwueREGNhWxH8H
         DWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=/3HPhhj09iZ2758Bq0XO+mj790fbP8mrX3nSiTVGLmg=;
        b=c/JOYFM/DuNRBBQIPO4lvkgAZD3Uji7l5lXuwHR0zwsVHkDW/ksPwJsAyrQRwmyTCm
         jL2rZRpDMRzh5I+qb2q8kac3Y1ygyNJUhQ3HHL1KfitMtv2Ex9D8Z23/aJUPZIsmhJem
         rHdbY2JrEioFaKQAMeIVlxSZefWQfzs5rRGTycS8yFQAwNkBhdLlug/5FNCDhj7buhEN
         oxdYegv2TIhbq4hzTbzg1b1a5biukAiDO0uyzXuALcoO69wYAYDqLRKACo/mFSOMmtZt
         r/6MdSwtgSXedKMzh+s66+PS8UOMEcIZR/dDcXd7kFAvJvOkEVoiVFmhf8C+q5Wlvrk3
         qoyg==
X-Gm-Message-State: AOAM532LpYLRg26RKIAAXDrbPKZZTuIynY4luuHSdIPcRrOqvPI4sWC0
        OEoa/pCWXLwnyNrAPmKVppQ+lA1atWv6QR0pjOA=
X-Google-Smtp-Source: ABdhPJyktdFWAGTbN3GhsnllkBwLNsUwIZx/7BiT/deG+/5lQbMjpZXI9wT/Cd6YMGRbGM8jPDl+qu/kYeDm2ApedNk=
X-Received: by 2002:a17:907:60d6:: with SMTP id hv22mr1193210ejc.476.1643954898366;
 Thu, 03 Feb 2022 22:08:18 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
 <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com> <02c29f920d0d5fde6d85f7b86a69be92e3f0f34d.1643787281.git.gitgitgadget@gmail.com>
 <YfywEBIIJWLPM2kr@google.com>
In-Reply-To: <YfywEBIIJWLPM2kr@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 3 Feb 2022 22:08:07 -0800
Message-ID: <CABPp-BEVXa9rP7J_hNrWxOziWGAZ6YpP302dLOvNbAVumth3JQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/15] merge-tree: implement real merges
To:     Josh Steadmon <steadmon@google.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 3, 2022 at 8:48 PM Josh Steadmon <steadmon@google.com> wrote:
>
> On 2022.02.02 07:34, Elijah Newren via GitGitGadget wrote:
[...]
> > +USAGE NOTES
> > +-----------
> > +
> > +git-merge-tree was written to be low-level plumbing, similar to
> > +hash-object, mktree, commit-tree, update-ref, and mktag.  Thus, it could
> > +be used as a part of a series of steps such as
> > +
> > +       NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
> > +       test $? -eq 0 || die "There were conflicts..."
> > +       NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
> > +       git update-ref $BRANCH1 $NEWCOMMIT
> > +
> > +However, it does not quite fit into the same category of low-level
> > +plumbing commands since the possibility of merge conflicts give it a
> > +much higher chance of the command not succeeding.
>
> I found this final paragraph confusing. It seems to be hinting at some
> conclusion it expects readers to make, but I haven't been able to figure
> out what. Could this be made more explicit, or perhaps dropped
> altogether?

Yep, I'll drop it.
