Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF92C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 19:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352829AbiCXTIU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 15:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345232AbiCXTIU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 15:08:20 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EAEB82CD
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 12:06:47 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id e22so6491139ioe.11
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 12:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/truon9Y0DKOhJnAiEk0GhwGGedFCE4FHQ5K3Ik4zd4=;
        b=XN3I15GCFKrOWb32dBlqDmA0K/8iMP2ludXlFbfMM5h+MvWEWjQcN3gWO1pIcyzVOe
         bxvRD6+DDUTffZVGcsEJgj3iTVFGtoly3Ki2ecIsi0HYP45odhNQrRrsVZOZkpN34OFI
         2MJk70XER7HB9RWtWoZxjDfZud3y9TK5gLZQZZ+zlqbp4QEXcWsWPe5cgwSvULnDWSNf
         bcoI4L9+NmJPEr/wg90UblxgvDjBmPX7c6gfZni9IFtVXYUG2C0syWMfxQVGYqfW6IQ5
         r1zRT+DJWiZe9IPA/UyQUJ4aUDfU7FEghe9aDhmTtEzlyvpmDHSnA/tY7dBEFYAqOmwv
         I9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/truon9Y0DKOhJnAiEk0GhwGGedFCE4FHQ5K3Ik4zd4=;
        b=bGkKiFobeX1+jpIryhCVZn3Qo5V3Mjt8xqW7FhPvJ0hHqXoq7SOVvMSmZtG+u9gjL2
         Py5Q3brM/KjtCQsX8ysR471eLmG8TngJ9rpPhCCcQhydVfGjzuzv3PaDLc/6oKk27qPH
         bSZnQ+5/5Q3KRImJgF+RDEsWdrBU/gTDqXaOxVvYgbdSkCf4UyHDTEC6CHErrHLLAavq
         Kb41XzeLtpmpmSBKla1K/X94l2XaISlGXaShic93HGxrHH2wcYhIPfbrOW1TnCwgE9OJ
         EXFmxDCL3f6wlFecW73exJABKPMiWa0YujXw2VLcMo3tgeTOtZiA7jhpFxJNx2T0KXgK
         wCtg==
X-Gm-Message-State: AOAM533dYU4N4N4ZSC3A5QBneLXU2tiHhJCrVVYCXUvZiZwua/q2ExUO
        ZC1ROrsO4IGASGScUjlBPd7o0w==
X-Google-Smtp-Source: ABdhPJxtU/3+yA0AoMQkeI1TOP+NjfdLNX4MaamQZwHBEK0OcALHvDAzS/MqDhmYhv/ifF5YDXgZuQ==
X-Received: by 2002:a05:6638:210b:b0:319:b277:7c21 with SMTP id n11-20020a056638210b00b00319b2777c21mr3893095jaj.240.1648148807040;
        Thu, 24 Mar 2022 12:06:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q197-20020a6b8ece000000b00648d615e80csm1824612iod.41.2022.03.24.12.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 12:06:46 -0700 (PDT)
Date:   Thu, 24 Mar 2022 15:06:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com, derrickstolee@github.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v1 2/3] pack-bitmap.c: add "break" statement in
 "open_pack_bitmap()"
Message-ID: <YjzBRjrYQWIpdsk3@nand.local>
References: <cover.1648119652.git.dyroneteng@gmail.com>
 <70500b63434f6e454631b3a8fde07c62b5adfef0.1648119652.git.dyroneteng@gmail.com>
 <xmqq7d8ji48t.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7d8ji48t.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 24, 2022 at 11:40:02AM -0700, Junio C Hamano wrote:
> Teng Long <dyroneteng@gmail.com> writes:
>
> > There will be only one operant ".bitmap" file in repo, so let's
> > add "break" statement in "open_pack_bitmap()" when looping all
> > the packs in repo.
>
> Googling "operant" only gives a psychology term X-<.
>
>     : behavior (such as bar pressing by a rat to obtain food) that
>     operates on the environment to produce rewarding and reinforcing
>     effects.

I suspect that the author meant "operating", which I would probably have
written as "Git will only use information from a single .bitmap file in
the repository" or similar.

But...

> I do not quite get this.  We expect that there may be more than one
> .pack in the object store, and that is why we iterate over the packs
> get_all_packs() gives us.  Then for each of these packs, we try to
> open pack bitmap.
>
> Ah, are you referring to the current limitation that we can have
> only one .bitmap file, even when there are many packs in the object
> store?
>
> I wonder if that limitation is something we need to hardcode here.

...you're exactly right: if we see more than one pack bitmap in the
repository, we can and should warn there, since we'll only ever *use*
information from a single bitmap at a time.

That's the behavior before this patch which is guaranteed by t5310.74.
This patch causes that test to break, and I would suggest that is
telling us to drop this part of the series.

Thanks,
Taylor
