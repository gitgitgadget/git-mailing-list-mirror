Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829E7C433FE
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 22:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237736AbiKNWnq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 17:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237788AbiKNWn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 17:43:27 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002C4C53
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 14:43:26 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id d123so9377942iof.7
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 14:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sl8ICY6y7bwm7M/90NxrJzcmlFWMCTUe5R0/xtGDNKY=;
        b=NWPKTwt+2jmSKnPXQ+3apY25JYERvHjuYs551jONYcyncdSWuP2sw71b5me1PW0663
         qZo941lkT8NuJE9fNEwrRhs+JF6xxWDw5f1nbriSd1qQGjHcEDeJOGis80n5a7mp2JRS
         /TTVW4HKYZe8ocPgGVkReyjMUTqUrkbnzttmCCKE+xCr4TcOMhAdcFnqH61defg92p7/
         4FNYyiSmimD4teC/FZ4LCmlXRO8dgzm2qTphLrjHaNknFyGX/eirSKImVTxOrUcnvxc4
         f5uDoF0fc7dGfBQ+rRtmZr7yA5blOBHbw2+aKlqIVMr6PJTfAoA9i+RjmA+08clECRcJ
         QLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sl8ICY6y7bwm7M/90NxrJzcmlFWMCTUe5R0/xtGDNKY=;
        b=mYuFvb1qWUxOTyVGClmqUr5+xSyoICqjkpQNdAQfeKvmk4gOTH2sunz1DYi4D02/gj
         McNDWrl9Lfyb4KBYro/Y1J8K8SKcRp2WA+36OXqr594tWu+zUTLiwVxRXKsHyMPeQFYq
         K+0IW0qh7V1yuYhvmJi1d9LTY2epxKTQdqgAuwPGSkqm47uH9KD9SOaVe5FeMXAt+5zK
         Z+2MQyj4HcG96UvgRSYTy0ExIuRuNBfHUxZ2zJloczdECXNowkSHarC1wf0kB7dj4Ddm
         Sv4KPV+2bny/aJHgB6RQrzGeXfRhBhWv/2TVZJyslBYBcV6kkaCCprk7f99H8hR8doJ7
         gdzg==
X-Gm-Message-State: ANoB5pmj7lsNu9Mp20qiqvP+g//zw9MsrEEFx2ZZ1aAopqBiIH/oyqRh
        23RjxlqRz7+I5pxh7/1Cm+jt2g==
X-Google-Smtp-Source: AA0mqf7bgpbTmr08ESBGi3TvNiwXW0iSmoMid9ec6liTivSi2Kk1MyWgqBKJ4iEYATr66C0nE3lv+w==
X-Received: by 2002:a05:6638:3d87:b0:363:db63:a796 with SMTP id ci7-20020a0566383d8700b00363db63a796mr6795936jab.250.1668465806330;
        Mon, 14 Nov 2022 14:43:26 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j28-20020a02cb1c000000b00363dee286edsm4097677jap.60.2022.11.14.14.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 14:43:24 -0800 (PST)
Date:   Mon, 14 Nov 2022 17:43:23 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <nasamuffin@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v3 0/2] http: redact curl h2h3 headers in info
Message-ID: <Y3LEi0maFyh3Qwwy@nand.local>
References: <pull.1377.v2.git.git.1668121055059.gitgitgadget@gmail.com>
 <pull.1377.v3.git.git.1668206106.gitgitgadget@gmail.com>
 <Y3LCNmsqfHDtG33u@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3LCNmsqfHDtG33u@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 14, 2022 at 05:33:26PM -0500, Jeff King wrote:
> On Fri, Nov 11, 2022 at 10:35:04PM +0000, Glen Choo via GitGitGadget wrote:
>
> > Big thanks to Peff for the feedback last round. I've incorporated all of the
> > suggestions. I'm so glad that we finally have tests here :)
> >
> > Changes in v3:
> >
> >  * Add the HTTP2 test from [1] to the start of the series
> >  * Drop struct strbuf inner in favor of doing work on the original strbuf
>
> Thanks, both look good to me (unsurprisingly ;) ).

Thanks, both. Will start merging this down in this evening's push-out.

Thanks,
Taylor
