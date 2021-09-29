Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AECC433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 20:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C046461504
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 20:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346703AbhI2Ucd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 16:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345611AbhI2Ucc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 16:32:32 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2613CC06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 13:30:51 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id i62so4759294ioa.6
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 13:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ta1llM3Adc1MASRJWjzdA0d7W9wf0ZubbfkQZ0A3jz4=;
        b=5uA/X0FD67CcJ0cJfFD/WUEqtpggYEEfkuSekhvVfk9Ua6ciKjrX3DUFFTWU6UL15E
         sNqA0UNjbnOnHAcM4U425ePzlBuUCl0GiQMKQFFPnATeZJFehw2R71LcebKepgpweTsy
         na4Sl2FSEYqhmuaBFe8IyoEzkdOgG+rJ0G5aLloSQSNF1hMAMt5nDjsGq8ENLAga7BO1
         /uZ8EP9kJ0QyqnEy5/0KeKzcpdvXwJuSwQRbtzBhv54YaB2lzhRR3KfdKQsS5DKGfhSA
         cYliTdElTg9i7jlWL8EADmLhMgYM/ajy3Bt34ZT01kXAurZl9WymuO94J5Xj4u1tnS1p
         eguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ta1llM3Adc1MASRJWjzdA0d7W9wf0ZubbfkQZ0A3jz4=;
        b=TmEhK1zFZNuLkY7obZztTjbu7gdQuZggZ/bdMic5CiSh6aSYQafzFKsoOJrLTApFzb
         X00gCMYh9aFiP7Umlvz4cPBz0u1CUCLkX3s+i955bzxVj4QklF3vCGoZfbJZnLfe9sDO
         hNk0Pv4MFhhd0M2HWx5hxLa7K09+0xM5YUA10PGsTmXwrwG9jKP1xmAmouMLnWAp2MKO
         V8kKW2ji6UU0boIRTUOtMsne5e9OVqdhd3faG3B9aABybrsJ4WYCWqzwnZX3D6T3Inh2
         B1oSIbwjySPRL6ggf4MbVf1ZzqON0prPb133VJ09HnBmORI3hYdd0mgYB5zRRHyxGaSV
         w73Q==
X-Gm-Message-State: AOAM532B2hNlJw5/YT9rwhZr77zXPVvHMkExMmBB6I2E2IMYsnKeCBdG
        q/pnKUueycW4vXd74K0dnxuqxA==
X-Google-Smtp-Source: ABdhPJxcROFVdmDWcyxPlC250kLEgeK9czFutUO3MTQGE/ugn0zezlszzoNGLLCYCnobdAadnuDRKw==
X-Received: by 2002:a6b:4f04:: with SMTP id d4mr1196928iob.95.1632947450438;
        Wed, 29 Sep 2021 13:30:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z187sm443015iof.49.2021.09.29.13.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 13:30:49 -0700 (PDT)
Date:   Wed, 29 Sep 2021 16:30:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Taylor Blau <ttaylorr@github.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: Git in Outreachy?
Message-ID: <YVTM+WQH/UyhVeTz@nand.local>
References: <YTGLLQCvlnT17jo8@nand.local>
 <YUYPgF6tRQ5ERYWL@nand.local>
 <YUpN4zrZmyxoTb4l@nand.local>
 <CAP8UFD0snuPE0L+L2LxEgCAQXaP_j9LwxwJP_ZounOtg4kRv_g@mail.gmail.com>
 <YVSjkMLdxtURP5iN@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YVSjkMLdxtURP5iN@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 29, 2021 at 01:34:08PM -0400, Taylor Blau wrote:
> > We still have only one project ("Unify ref-filter formats with other
> > pretty formats", that ZheNing and me are willing to co-mentor)
> > submitted though.
>
> I plan to submit and mentor a project myself. (I'm thinking that I'll do
> a grab-bag of bitmap-related items that I'd like to see implemented, but
> that may be too open-ended for a successful Outreachy project).

I think (open-ended as it may be) that I'll be able to provide the most
guidance for a bitmap-related project. I submitted that as a intern
project, which anybody logged in through the Outreachy site can view
here:

  https://www.outreachy.org/apply/project-selection/#git

Thanks,
Taylor
