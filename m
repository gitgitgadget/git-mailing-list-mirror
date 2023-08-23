Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79449C3DA66
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 18:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238222AbjHWSkl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 14:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237972AbjHWSkl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 14:40:41 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E87E6F
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 11:40:37 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d77f614243aso66845276.0
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692816036; x=1693420836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r3wUM0jGjwtg6ExZldX99gQkGDShZ1t49Z0rdUTwltU=;
        b=fORFSL6fsLrEuLP42KKN3GllsP8DCoONkMFoy4NIwX4SEaGanolX9E8ObuHkNurOsm
         lqbyZ3T3hrfNTjZ9LPiLcBQBWDLftYOXT6KEZ03AwPSTpZ7bFmiyfBH2UjPztl/FFmtV
         PhLODSEmDilA1/8aHCCgEhOgz2mUpnNynh8xlMyPqUUAN86E8HB8X02/iobBsCipujfm
         RlRJPWJ/jN6Y1xxPqq7udz03kqNANXJE8Hso3yI3a5Tr95Rg6EjB4js76/AzqUBbqIcC
         fIrM6bf4SGAUY5x+utVxXezGlZrfVvd3pb23v3sLKtlBzwTv0M8h1kEkC2ucYfpEnapL
         zUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692816036; x=1693420836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3wUM0jGjwtg6ExZldX99gQkGDShZ1t49Z0rdUTwltU=;
        b=HkWHde4/IvKHKYmZFh/28hhABgBnmJPTpA7BSVJmiyT82Vw+JPgj6OVsgQe46Xj0hY
         IKbVIgYyuo0MYMBoTHUe1Y9ydC35wd4xSiDO3VWVjAIsfrGfGmkiYIDSt7HHO2toCE7Y
         dOxVA+GiNh3BwQLOaGD9FSWZISWDXhMCRw2pefVSDvopbVPloY49dhlPsFMasCKOtOXY
         FalczCHgOqridtbZWRnylYqAqMiwo4eYF6KeUpZq7ILNaCojNnLkzmxYLWjDS1fuV9HO
         sD4Axa2hwCxQjzmboiWDlmgG+CVQKxjs/5HOUxOjB/rIeQHbDbpJDgg7iUmJDbw9GY9N
         /wcA==
X-Gm-Message-State: AOJu0YxebUW7tFHEvxkLgrIiAJfLgHyXhGuhyjn3nUJdR8BGXHoDi+9y
        ktcOHl4ZNuZC7axgrkOWFcOibg==
X-Google-Smtp-Source: AGHT+IH4Qe33mWWfAF41HaVixS2YolNJHRz7aB2fgBQm2yoLYDgWJGgVj4nV1DvLOF0MfP0013Nbig==
X-Received: by 2002:a25:9f8e:0:b0:d64:6cd9:29a4 with SMTP id u14-20020a259f8e000000b00d646cd929a4mr10789078ybq.61.1692816036549;
        Wed, 23 Aug 2023 11:40:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f9-20020a056902038900b00d071631665fsm2839768ybs.59.2023.08.23.11.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 11:40:36 -0700 (PDT)
Date:   Wed, 23 Aug 2023 14:40:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Hariom verma <hariom18599@gmail.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: Git in Outreachy? (December, 2023)
Message-ID: <ZOZSo7vJztHcvb4W@nand.local>
References: <ZNwhVOggObU7aVTr@nand.local>
 <CAP8UFD2Yw1XazomxEj0QB20FoaxkO16t_xgRurtnqCCOuhX-eQ@mail.gmail.com>
 <2c31a3d4-59f7-d036-0c6b-5fd62cc7a2fa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2c31a3d4-59f7-d036-0c6b-5fd62cc7a2fa@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 22, 2023 at 11:44:41AM +0530, Kaartic Sivaraam wrote:
> > > If folks are interested, I'd be more than happy to answer any questions
> > > about participating, and overall logistics of the program.
>
> I'm guessing the mentor sign up deadline aligns with the project submission
> timeline. Could you kindly confirm the same, Taylor?

I couldn't find any specific mention of it on the schedule[1], but AFAIR
we can add mentors at any time after the Git project confirms its
participation.

Thanks,
Taylor

[1]: https://www.outreachy.org/apply/project-selection/
