Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3752CC433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 01:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C75461B98
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 01:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242320AbhKRBnz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 20:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239516AbhKRBny (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 20:43:54 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D6EC061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 17:40:55 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id l19so4879082ilk.0
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 17:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iwvExEo3LgM9MWUyQ1fbgE8USC2jfeHxUih9LaWHsjg=;
        b=AnUm9P1Fq1h/PlmOyGZN9rba5FgKwydOhvUmlnev78zmhflsJluboH5hVu2l1zujf8
         IF8cpSgiZ2AdAgzrD0XxwTIPvCyPVoIM4P2RfCpQt/49umXAYzMVtduiGbuv/RXz1V+D
         H7Ux3g9Fr9vHwIhWx3HvLyyFrO5DoPz5a3DrbRX6EjIRTIym8reuCOjO0PYDU3U/3Zqw
         jeS5g2qU73VfiIXCkGy+FhyWKFvJeXiFFIejMuoRXrtPzlkZySB5QGyimx5RjwwRsdQ3
         A00oMqBPmkW7B7SAg3YbdQUkGj2ZxA/CxTsEEE2JQnpC+2FHg3WpYPDfJjW/JkZcQGjQ
         XTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iwvExEo3LgM9MWUyQ1fbgE8USC2jfeHxUih9LaWHsjg=;
        b=XNiKr2MACX16UaboMMR5qHtFq0VMl310RMmH+2DXABDOwcJgPHUiQ50DgKFAYyjPG8
         94TJY3hhf2Ux2FIeeG1G85fnElh9eXiqfjfbfWcipSp92MTd0MIfgS7w7jWr8cRFAzex
         ZPaPL9bp1FqdF0Rt/ftvhiwohzvlgWC6I9yTKr1qml8qjFauZBz2KydagAdu1o2VBUmC
         dP9Q2dzCog6x/CFP7b0UTmb6EFS+p0VcDeih7kvi7/tqYt/EILY0YI5agdM2b/YyrQy3
         8UzXSHmxibjz3eTmtZd3qfyFnVGy4b0QjFl13u3ia1VwLTtqdQdX8w+R1b03pPMKTrI4
         dTng==
X-Gm-Message-State: AOAM531tsK9LxpNj5X7mm04TMFdUC/bo4uVFFgZIAYH0a5uoPLEQfjnV
        qtiMA1t76cSlpStEg/uCzEPbYzhjdF47CIUH
X-Google-Smtp-Source: ABdhPJxRXP0yT8PJC2L98WDy4xbi/hE4mARU8GfCgDy2yiqQGxSwyHNvZKTmHxyfzeP34FCJfcONyg==
X-Received: by 2002:a92:b112:: with SMTP id t18mr1911716ilh.168.1637199654963;
        Wed, 17 Nov 2021 17:40:54 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c9sm885316iom.9.2021.11.17.17.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 17:40:54 -0800 (PST)
Date:   Wed, 17 Nov 2021 20:40:53 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Philip Oakley <philipoakley@iee.email>,
        Etienne Guillot <git@etguillot.fr>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Git List <git@vger.kernel.org>
Subject: Re: Need help in understanding how to submit a patch
Message-ID: <YZWvJdWcmhIl9DxR@nand.local>
References: <127c9dbd-4861-beea-a85b-af7412ce141f@etguillot.fr>
 <6fa0b1dd-ac20-ff55-95ea-1c22347f9199@iee.email>
 <20211117175149.7slohfqqwsmn3ua6@yadavpratyush.com>
 <YZVB5hy4Xuim5K9B@nand.local>
 <CANYiYbFq-SAq2VLcFFX8P=Y8-JzjqW63mJqTuOCgO+q+Zzf=DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANYiYbFq-SAq2VLcFFX8P=Y8-JzjqW63mJqTuOCgO+q+Zzf=DQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 18, 2021 at 09:37:57AM +0800, Jiang Xin wrote:
> On Thu, Nov 18, 2021 at 1:54 AM Taylor Blau <me@ttaylorr.com> wrote:
> >
> > Jiang,
> >
> > On Wed, Nov 17, 2021 at 11:21:49PM +0530, Pratyush Yadav wrote:
> > > Hi Etienne,
> > >
> > > On 17/11/21 03:47PM, Philip Oakley wrote:
> > > > On 16/11/2021 21:15, Etienne Guillot wrote:
> > > > > Hi,
> > > > >
> > > > > I found a typo mistake in the french translation of git-gui.
> > > > > I did read the instructions on this page
> > > > > https://git-scm.com/docs/SubmittingPatches
> > > > > but I still not sure where should I push the correction.
> > > > >
> > > > > Thanks for your help
> > > > >
> > > > > Etienne Guillot
> > > > Hi Etienne
> > > >
> > > > The Git Gui is managed by Pratyush Yadav (cc'd) and hosted at
> > > > https://github.com/prati0100/git-gui
> > > >
> > > > Not sure what the latest is on contributing translations (not covered in
> > > > the GitHub Readme..).
> > >
> > > I usually ask people to post patches on this mailing list and I review
> > > them here. But I make an exception for translation changes since they
> > > never get any reviews anyway.
> > >
> > > So I am fine with either a Pull Request on GitHub or a patch on the
> > > mailing list.
> >
> > Since Pratyush is the maintainer, does the po/TEAMS file in your tree
> > need updating?
>
> Git Gui is a standalone project with its own workflow. The file
> "po/TEAMS" is only used for Git project, so I am a little confused how
> to update this file?

I misread Etienne's original message, I thought they were asking about
the French translation for Git, not git-gui.

> > I'm not sure how up-to-date the file is in general, but the last commit
> > was made semi-recently back in August, so I assume that the entry for
> > the French translation is outdated.
>
> French l10n team is led by Jean-Noël Avila, and is very active.
>
>     git log --no-merges -- po/fr.po
>
> L10n for git-gui are maintained by different people though.  Because
> "git-gui" is merged into git using subtree merge strategy,  I cannot
> find commit logs of "git-gui/po/fr.po" using the same command, and
> have to find the original git-gui commit, and find commit logs from
> "po/fr.po" (which is quite different file from "po/fr.po" of Git).
>
>     git log 8a383db4b2 -- po/fr.po

Yes, clearly no update is necessary here. Sorry for the confusion.

Thanks,
Taylor
