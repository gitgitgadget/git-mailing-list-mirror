Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA2BC19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 20:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346171AbiHIUIE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 16:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346067AbiHIUHw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 16:07:52 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7509A27163
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 13:07:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id dc19so24051141ejb.12
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 13:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=RJaDywBsm2yJPvi8sci8g0mt6p7Se2/yAPLbt+FRSjU=;
        b=oY0KI98n9EpI8kFdzfThp/yJpdlcgXcGYHiXHDSDCYyCZTJAlTJB2me7goTwJJqsgb
         I3jO7ki+eVrm7sutM9Elew64t44xwQ7wsF1R0P55K4rCTo//FvOvzX0eDkZj7fA7a18U
         K9htWn7Rbyb+w1KZtu2yMO3PWIJ1zoqh/VhHttoEYeC2xsIh1yg3j5YxAcOR4fohB5zB
         2bSbbKJQHuPzxS+O6Fiepo4Vk8z8V+/C4SFVVD3IDTCX0TrtvE5zpeDlYlfPAb2PNuAn
         lhzlCOyUOmjHVi+aVQd2YIqU6GSCIa5TnQlBF/LYb27XAyBDFUiHhhIMw5c+7ioiMtG+
         +geg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=RJaDywBsm2yJPvi8sci8g0mt6p7Se2/yAPLbt+FRSjU=;
        b=vsRwkvyd00pbfgV2fmPfMuO1xy3z9QKNNr/6tnL0ueUjg2/WBrZsLvfSWxbrmg4mt4
         gNEy6aDtDyz5HezGALY88QmZnhI7rzalzHsv+gzz9NBfjlLXFcaSFIz+lCNLoSmCpXjH
         6FyYDPm40DUO/EiD3YvxIlO/u0bqUr2HnjDEcpAh6J5bzm4bg+e9/knGOrxclftk4KfT
         HHEjqLLCOAQCidk5ehqJD/YEHE8uwR6CzcpUCh0G5Ko6t6/TYrR8uDXag5dJyO4z1OMF
         K33sPNzkICWGsuQ52263HEKEEEsKzg/Zcnva8L9XIgHFJT1OFP8H6aC0+rDmlVqRlT7T
         pf2w==
X-Gm-Message-State: ACgBeo39F4WIW6z5hGs/o5acVpVqOuD8KYRjmuqNHIgcFHJqQjo1GSnH
        zix1BOM3v2pE8zFYR9zNYdFq0+YIVlGko2l9ErCDZhny
X-Google-Smtp-Source: AA6agR64GIVbBFwFswKLt68nztmzoJ+ogR1oXa3+XpcZPEPff/UDGaeyql/LnB8+jLucWHWgCMIE7seU41b9Ol7EC1M=
X-Received: by 2002:a17:907:28c8:b0:730:9ccc:331f with SMTP id
 en8-20020a17090728c800b007309ccc331fmr17614593ejc.608.1660075669977; Tue, 09
 Aug 2022 13:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220809004549.123020-1-felipe.contreras@gmail.com>
 <20220809004549.123020-8-felipe.contreras@gmail.com> <CAMP44s2RsvXnt8LtDcv+Ai_kCxmtURGWXmwfchO08dhjMxkGhA@mail.gmail.com>
 <YvHv+EcNyHXCNZhK@zacax395.localdomain>
In-Reply-To: <YvHv+EcNyHXCNZhK@zacax395.localdomain>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 9 Aug 2022 15:07:39 -0500
Message-ID: <CAMP44s2ucc_i0mxOKAdPkKRV0zp7qQOCrSE_vJJHWcXqwGzGgA@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] mergetools: vimdiff: restore selective diff mode
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 9, 2022 at 12:26 AM Fernando Ramos <greenfoo@u92.eu> wrote:
>
> On 22/08/08 08:08PM, Felipe Contreras wrote:
> >
> > Notice that after reorganizing the tab handling my layout becomes really simple:
> >
> >   set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | 4b
>
> Thanks! I really like this new approach.
>
> I also manually tested your new series (with and without .vimrc) and it works as
> expected in all listed test cases.
>
> This last series gets the best of both worlds:
>
>   - Highglihting works in single window tabs even when there is just one tab
>
>   - Single tab layouts are not treated differently
>
>   - Generates shorter (easier to understand!) vim command strings (nice!)
>
>   - Opens the gate for a future configuration option that lets you enable "all
>     buffers diff mode" even if they are not visible in a given tab (maybe this
>     could be a new syntax token, *, that "marks" a tab to work in this mode?)
>
> So, definitely a great work. Thanks for the deeper look at the problem and this
> brilliant solution :)

It probably can be cleaned up a bit more, but the important thing is
the idea: parse tabs especially (which they are anyway).

Now if only the maintainer cared about fixing the regression that
would be great.

-- 
Felipe Contreras
