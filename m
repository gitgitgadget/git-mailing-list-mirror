Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7686C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiBWSCC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243748AbiBWSBz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:01:55 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20204427E8
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:01:12 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id w7so25464563ioj.5
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=55eVss2FjjbR/BptcFBTfJ9F/BEx55IGL6Be5+kQlNQ=;
        b=EAufCO22Sw5RBAdsDlEnKbiMZaPOrroMRcIUYIYs1/ozijQVNF7kEhnypB31qL70yA
         5k9juTbPZtSRo/6VV6YNi2uHeA+5d88tAXpwReNe4VEVz9fLgkIsN37Jo74IUxLcvUPw
         Z9Yr/jJY+hH8j40zcOBC/W/nerivz9smOO87VfwL3XYymahH0ElbYBb1U0fIUJrsQX1N
         uOF/gyxo+kIxJrWaz/WIQ/Q5wAM6a0jTxRZXdXZeiQtNaQ7YkvFctrw91H0ue/HY1ee1
         FwrcSRrzixekzuBRi048zsUGONp1e8mvSgG0VBOQlH756qBhzS6/Q90J285HWJKnlQ5S
         ACjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=55eVss2FjjbR/BptcFBTfJ9F/BEx55IGL6Be5+kQlNQ=;
        b=5T8cbf9uO2+QYbP61a2nUXab3YWQwMSUevJxl9c2TsntCbw0BIcEqpwB5Nvrd4E8Ki
         ev0up31M7QvF0xxq7A754W8EaQH6mshdYVIT14GGsWwDnaiCesZLiZ4G08fiI0Ky5JbZ
         pAP/kW2lTNol1Ftw5iVlF8qPlAad3Rjpot7Mr1s8U9G/a3w5fdqqi3ZHu6DxgRJe00Ru
         FwROjKCAe/EAZRcIVHlUYt/7CrmWnEPMx+faAUAqKwhBSE8fgCltxqYh+N+91IU/ctMG
         A7py6aHKTfYhJLChYxYdWFKCObUDEyRkM2OMzwxIDzBEsruGE5sGXNNEcS6eZHYFpA1L
         4DlQ==
X-Gm-Message-State: AOAM532nz863YeYg70fZvixtoGmotrVWd5yS7Y9S6+6CvcarqNDTv/QL
        ShjW59WH2iSkkY0dA3y9Fhlkf/eQaEQuzz2x
X-Google-Smtp-Source: ABdhPJxgqbL2AYkAOwbFrBHU2Ub/vzi417wqlJYZGIF/WFwXiaGXahtvu1burXlaBAYFmHPdRicGCw==
X-Received: by 2002:a02:ce36:0:b0:313:efab:aef3 with SMTP id v22-20020a02ce36000000b00313efabaef3mr701329jar.240.1645639271444;
        Wed, 23 Feb 2022 10:01:11 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a6sm201861ilj.1.2022.02.23.10.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:01:10 -0800 (PST)
Date:   Wed, 23 Feb 2022 13:01:10 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     Shubham Mishra <shivam828787@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] avoid pipes with Git on LHS
Message-ID: <YhZ2Zpl3XGkTKxuI@nand.local>
References: <20220222114313.14921-1-shivam828787@gmail.com>
 <20220223115347.3083-1-shivam828787@gmail.com>
 <CAC316V57tHux-+MWMJuP5wNtwYrc2AinZj+ffnoyy-aWQWDukg@mail.gmail.com>
 <CAJyCBOTiWxAgkZPB6M5jPw=t=32zrnNH5tfnOc9Kdj9mKayrSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJyCBOTiWxAgkZPB6M5jPw=t=32zrnNH5tfnOc9Kdj9mKayrSA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 23, 2022 at 09:19:23PM +0800, Shaoxuan Yuan wrote:
> On Wed, Feb 23, 2022 at 8:42 PM Shubham Mishra <shivam828787@gmail.com> wrote:
> >
> > Hi,
>
> Hi,
>
> > I am using mails for code review for the first time, I have some
> > doubts, Can someone please clarify them? -
> > 1. It looks like the cover letter (Including "Range-diff" section) is
> > only for context sharing with reviewers, nothing from it gets merged
> > to the "seek" or any other branch.
>
> The cover letter stands for an introduction/summary to your patches.
> You can also put helpful context in it for better understanding. According
> to my knowledge, it will not be in the commit messages.

Right; the cover letter (along with any notes below the '---' in your
patches do not make it into the commit history).

The range-diff you posted is empty and doesn't look quite right to me...
when I applied both versions of your patches locally and generated a
range-diff myself, I got the expected (non-empty) results.

I'm not sure exactly how you're generating the range-diff locally, but
you may want to make sure that you're picking the previous version
correctly (and not doing something like `git range-diff master HEAD
HEAD`, which is what I suspect may have happened).

> > 2. I wanted to know how the merging process takes place. Once the
> > patch is accepted, do we merge all previous versions of it one after
> > another or every patch is independent so we have to just merge the
> > last accepted patch?
>
> Not so sure about this question. My two cents: generally the most agreed-upon
> patch will be merged, but the exact merging process could vary based
> on the circumstances. Probably Junio can have a better answer to this.

Emily Shaffer did some great work a couple of years ago on a "My First
Contribution" tutorial, which you can find in
Documentation/MyFirstContribution.txt.

The section "My Patch Got Emailed - Now What?" provides a good overview
of the review and queuing process.

Thanks,
Taylor
