Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3998C433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 11:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B04B564E24
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 11:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhBQLPp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 06:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhBQLPX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 06:15:23 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B31C061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 03:14:43 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id t29so8184128pfg.11
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 03:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ej+kG/JZO1YgTWQ/j7oofkAspnng+sh2ALDZj6yDyKw=;
        b=sjwVm0znNZ+zJOoiE2R6qAXf9puqIlUWML8T+8iEt31lovh8lPEP36vUTcLg6VHdDs
         h1Czi2JfKq/ffrmUkYLfQg6ZOgvNDPCw9oTzU44Oz5wft3SmpzzsETbq8CHeCpsL6NrW
         DOF0JzBYMDxp9RXvm0jphCof3mOtDHD0Un+xYXsgl0z/PwdeIfkTW+hBnmFRstffYBJH
         zgp1zIs6Ms6KDZKeaLR2XCGwHxPT672nLTE/B9xWgaUJzSh/OfiHrYDETnwU//yEZVLc
         mIDiBNPSku9VxYvrYO+gKpl3vEIibkKt2cCLHe0b5ZKiiozqiXPUaGCwK3jdtIIRfGRL
         O/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ej+kG/JZO1YgTWQ/j7oofkAspnng+sh2ALDZj6yDyKw=;
        b=DxL8fNtcZ0Ke5TswFA05lUIEhQ+MVIH23rooEjWYIa4On9yHzl6ehViWu51a28xb3u
         hjvdqn1bKlJ74qcE8yq6sOwPjdg9iT+5p2jLarGmthMdbVgQP//mkamqws6S0cKSQZCc
         rwy+1nKzDQWb4wzinm5vGbAqKpHzChddJx/LqShVlYqIEiAUhZgLWZNzDsAMHz1JK8bs
         8IbSNxYzdqhYws4acTWhyzuKa7PhCkUCFcAZRPt3IxW9tPOB2FUspJF7cfl2TBCysFWZ
         chIBJdxUhZ1LhNShQMzaEgORTVJpNWRHT/idp7opuaJ913d9H+xE2oKGAp6LbKr0g7kq
         N7OA==
X-Gm-Message-State: AOAM532hRfuf4nsVv5y4y8f9fHp1EuBlS1AiAW7a6Wb7Yz8jDmzCctHp
        ph8BTUZGGZd+lspUqXh/fRU=
X-Google-Smtp-Source: ABdhPJwK1dymEKk+PS2xTDn/ftjdrEgCa+hvlKEz2TfRNV+PXkcXKFhh6f6hg+f/7zeIpPT59QeUGQ==
X-Received: by 2002:aa7:86d8:0:b029:1b5:1121:729a with SMTP id h24-20020aa786d80000b02901b51121729amr23957322pfo.57.1613560483389;
        Wed, 17 Feb 2021 03:14:43 -0800 (PST)
Received: from generichostname ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id lw17sm1720446pjb.11.2021.02.17.03.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 03:14:42 -0800 (PST)
Date:   Wed, 17 Feb 2021 03:14:40 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 0/2] difftool.c: learn a new way start at specified
 file
Message-ID: <YCz6oDZCAODPS8sY@generichostname>
References: <pull.870.v4.git.1613308167239.gitgitgadget@gmail.com>
 <pull.870.v5.git.1613480198.gitgitgadget@gmail.com>
 <xmqqblcjrgvc.fsf@gitster.c.googlers.com>
 <CAOLTT8T=R-M1eK9thSuzHNOJ8wkaTX3yYsLEgpqmHiEYWgM1XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOLTT8T=R-M1eK9thSuzHNOJ8wkaTX3yYsLEgpqmHiEYWgM1XA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi ZheNing,

On Wed, Feb 17, 2021 at 12:12:10PM +0800, ZheNing Hu wrote:
> Oh, I am sorry.
> Then I only need to squash the two commit, right?

I've never used GGG before but I suspect that in your GitHub PR, you
need to set the PR base to 'master' instead of 'jc/diffcore-rotate'.

CCing the creator of GGG, please correct me if I'm wrong.

-Denton

> Junio C Hamano <gitster@pobox.com> 于2021年2月17日周三 上午2:45写道：
> >
> > "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > Junio C Hamano (1):
> > >   diff: --{rotate,skip}-to=<path>
> >
> > That's not part of your series (didn't I ask you not to include it)?
> >
> > > ZheNing Hu (1):
> > >   difftool.c: learn a new way start at specified file
> >
> > Will see what I find, but I may not be able to get to it today.
> >
> > Thanks.
