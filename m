Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AACC3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 06:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F63A21775
	for <git@archiver.kernel.org>; Sat,  2 May 2020 06:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXZdMs6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgEBGOE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 02:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726058AbgEBGOD (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 2 May 2020 02:14:03 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B043AC061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 23:14:03 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x15so2665704pfa.1
        for <git@vger.kernel.org>; Fri, 01 May 2020 23:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pWbzqgUhAwXCqoZAM3vxha7AQCx2Svexv5wdaBJHBgo=;
        b=DXZdMs6fPM4H0zaY68d/x8IBbD/U5JVEGCDseL1+TKRdAmmxLln992U0DwQ2PVHFlq
         2xBgle+Ti/794B5LBz+9JbCgmxyoDeN6F7VpCVQd2uamhEaItGDWorbSADiFoHMugJPz
         vNcRLRqmk0gzXCIwZ5W+/KzMOoGIFoXwEPJLn7OwtLSnr1ImqnxM7kV5gMhrqiA2Hp/W
         ngzREgvpUCD+9WuBMtgTO7pWGvaEoiI1eZvMb8IA5bMRR64Bnt8srGtU0dS7XAR9SNWX
         TaNdV7sQ560dLB3hDCd3Mt3CTBS3j8xs0n03Wj0/+3agfM5+eZ+QgYOr+h2rs8ejVdYs
         pY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pWbzqgUhAwXCqoZAM3vxha7AQCx2Svexv5wdaBJHBgo=;
        b=a3ovvSOQs0EY/9zh1QNPH9b/mRIugGJxBRNpZ5mS07WG/2VKwH02SMTTut0AO28yVw
         zdheF767jSBSmHLoBGx2/wluBhhtq70IKfbpUnZcZdTGAPTcxw1PZPx3vjeQPlYqK8A6
         LGBiW4/dITFJc9e+QRQZ9OXcgcvp+dBWtAVtQdsulVTyYnCiwbQtW6VbYsZpBAnWOkzs
         X/ruzI2QVF/zRm2PDVkGsJkxUzxsv2sTxlSTrYRe4iXA92repHRNd2vPF09wM2DKVoFx
         Nf4BZ0Rau3nXlFOVP73vUie4HDrwtjdfdblopE1H7xY4vnmf86ZUV+m1sEiF8JbEraOF
         0oyA==
X-Gm-Message-State: AGi0PuZaE/w7h98ofGto0oZVOZV4+DforE4N+AGYBZNTPnAdeddNcmGV
        aT+Qm1Znpg66GW7XK3abEdU=
X-Google-Smtp-Source: APiQypI3FWQh/C+unbef0YSMFELTywVn5cPKpvBMP0QkA+psXdm0RuROI/VpDUfUklT0Y7nhVk9fGQ==
X-Received: by 2002:aa7:943c:: with SMTP id y28mr7531997pfo.171.1588400043020;
        Fri, 01 May 2020 23:14:03 -0700 (PDT)
Received: from konoha ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id j23sm1233421pjz.13.2020.05.01.23.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 23:14:02 -0700 (PDT)
Date:   Sat, 2 May 2020 11:43:55 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        sandals@crustytoothpaste.net, christian.couder@gmail.com,
        dstolee@microsoft.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 3/4] gitfaq: shallow cloning a repository
Message-ID: <20200502061355.GB5582@konoha>
References: <20200429093811.8475-1-shouryashukla.oo@gmail.com>
 <20200429093811.8475-3-shouryashukla.oo@gmail.com>
 <xmqq7dxyxlpj.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7dxyxlpj.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/04 10:09, Junio C Hamano wrote:
> > ---
> > I wanted to ask why is there no mention of partial cloning in
> > the 'git-clone' documentation? Is it because it is an experimental
> > feature?
> 
> If the folks that have been pushing the feature haven't bothered to
> document it fully, by definition, it must be a work in progress that
> is not ready for the prime time ;-)
> 
> Jokes aside, the --filter=<filter-spec> option is mentioned in the
> documentation and it says "...is used for the partial clone filter",
> without even defining what a "partial clone filter" really is.
> 
> The topic deserves its own subsection, between the "Git URLs" and
> the "Examples" sections, in git-clone(1).

May I try to add it? If yes then are there any points to be kept in mind
while writing this part (for eg., length of the subsection, writing
style, what all is to be written etc.)?
> 
> >  Documentation/gitfaq.txt | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> > index 7d294306f9..6f32846e3d 100644
> > --- a/Documentation/gitfaq.txt
> > +++ b/Documentation/gitfaq.txt
> > @@ -243,6 +243,16 @@ I want to change the remote of my repository. How do I do that?::
> >  One can list the remotes of a repository using `git remote -v` command.
> >  The default name of a remote is 'origin'.
> >  
> > +[[shallow-cloning]]
> > +The repository I am trying to clone is too big. Is there an alternative
> > +way of cloning it in lesser space?::
> > +	A good way to save up space when cloning a repository is
> > +	by using `partial clones`. A partial clone will clone the
> > +	full history of the repository but will skip out the entities
> > +	specified by the `--filter` option one uses in `git clone`.
> > +	Any entity which has not been cloned to save space can be cloned
> > +	on-demand. See linkgit:partial-clone[1].
> 
> Where does this link go?

Actually I intended to link to this page:
https://git-scm.com/docs/partial-clone

Do we link such pages in a manner different from linking command
documentations? Also, lets say I want to link this section using
gitlink:
https://git-scm.com/docs/git-clone#_git_urls

Do we change the number in 'linkgit:git-clone[n]'? If yes, then how do
we decide that number?
