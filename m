Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B29C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 15:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjDRPDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 11:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjDRPDF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 11:03:05 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F81FB45A
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 08:03:04 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-54fe82d8bf5so147610177b3.3
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 08:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681830183; x=1684422183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VEuSX6X0c3k+jOWe76ASVFCYsYUU7g1/1+WyLhjLdLA=;
        b=cbGaM7SmYY1syZTRrebHrlEFlIjzlOq9zH8P6rG0PLEaitMOGC1V6ebXdt1YUYe5Kb
         Cdhb/mXHD8kXpliVplAj+Owc6NShlGREEvDpkyPLi5L+BsoOzgI+4T9jqad8+785/YBH
         K+fAsKH7QhWzBCCDYsQMKpzrSFXHplhZPc/euVtkEcJ5k24D88G4POjDWs6+ndKbuZVC
         iz6AJepFS5Va3MlPjoBD0SLoPqeJnSWBjJMxwcys3+CPBXP4ooTvMaEQbPr06Wr45uUZ
         eEha8a1mlCvC0EDSqvMooGPN9+AwzqjvYa7+Gctu4c6D9oBsnE+v56vzFHIpbEpxjYoA
         5Row==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681830183; x=1684422183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEuSX6X0c3k+jOWe76ASVFCYsYUU7g1/1+WyLhjLdLA=;
        b=R1wOX4Ill2kS/k33GSfcp5yPtK7n9LW8mezUrk8iveS3Km5GlmrBQOVsQG0j9jV7jc
         LitMdZPxwETRMBri2Mlsr5bxtK3rad+UcMP03D/Ddd77NJzRWa8qV+RP5fq8/Z4pxncX
         tFn66Z9lZZZA1s/twVdDaJSjTUWSL70682YGOdCAVE5XeWMWQFtebJuqIzykPJPvu4xt
         rTZ1EzczY2usHBrLRPiXYS8lb9d61ZM7igBklju1xASI6MTwWq/6ry3EFdg1sdTr7p6D
         QjleGAZkrcAvmmf5aBuHDx8zrZXY2lQ2LggqjpeAGS9kFtmZB73+AO/35yTk5Zmu4ViM
         /mTA==
X-Gm-Message-State: AAQBX9dohUmb6c8Eq9IseU3CxDvTGveulNzFLhYMa2K/DKkR81kfxHNu
        n53tMU702g+nsJZOWl5Ka/Q75Q==
X-Google-Smtp-Source: AKy350aFSXgrnNR8w0xcHlJDvgLmPJlnEiVrNLwYFKpBnxkAriYoo8/gZZZqvrQEkWz4U/2VYoTp0g==
X-Received: by 2002:a81:4f13:0:b0:54f:9b17:c7db with SMTP id d19-20020a814f13000000b0054f9b17c7dbmr207055ywb.10.1681830183162;
        Tue, 18 Apr 2023 08:03:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 141-20020a810393000000b0054fba955474sm3854525ywd.17.2023.04.18.08.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 08:03:02 -0700 (PDT)
Date:   Tue, 18 Apr 2023 11:03:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 2/4] fsck: check rev-index checksums
Message-ID: <ZD6xJR7vrCzvW+Xw@nand.local>
References: <pull.1512.git.1681748502.gitgitgadget@gmail.com>
 <7db4ec3e327ed3695f4f5409cb2dc80c72688758.1681748502.git.gitgitgadget@gmail.com>
 <ZD3HI/LIXVv6Pacn@nand.local>
 <2628249e-fe9a-d15c-5414-33d815b35cd1@github.com>
 <ZD6ua4dSynRWmW2a@nand.local>
 <fe72e184-a252-dab4-e9aa-cf53e1499976@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fe72e184-a252-dab4-e9aa-cf53e1499976@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2023 at 10:57:15AM -0400, Derrick Stolee wrote:
> On 4/18/2023 10:51 AM, Taylor Blau wrote:
> > On Tue, Apr 18, 2023 at 10:27:57AM -0400, Derrick Stolee wrote:
> >>>> +test_expect_success 'fsck catches invalid checksum' '
> >>>> +	revfile=$(ls corrupt/.git/objects/pack/pack-*.rev) &&
> >>>
> >>> Would this test be tighter if we introduced a sub-shell and cd'd into
> >>> "corrupt" here?
> >>
> >> corrupt_rev_and_verify does the subshell thing. Why should we do that
> >> here in the test?
> >
> > I was thinking that it might be more concise if you moved the subshell
> > to the test and out of corrupt_rev_and_verify. In addition to making
> > corrupt_rev_and_verify work in other instances where the repository
> > isn't required to be in a directory named "corrupt", I think it
> > simplifies the result.
>
> I don't think there is a good reason to allow using a different repo
> name. This is the only test that requires doing anything but calling
> corrupt_rev_and_verify with different parameters, so I think this
> makes the test script at the end of the series noisier.

No worries. I was thinking that it might be convenient in the future if
we wanted to corrupt a .rev file in a different repository, but that's
absolutely a bridge we can cross if/when we get to it.

Thanks,
Taylor
