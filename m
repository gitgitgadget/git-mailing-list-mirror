Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ED9C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 20:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCE5E6113E
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 20:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345692AbhIIUro (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 16:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345658AbhIIUrn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 16:47:43 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF0FC061574
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 13:46:33 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id l10so3316883ilh.8
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 13:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x12vodlTjw6GcEUC7EJZb6ck8MA3k8WsaBK5pxok/7c=;
        b=tWcOr66ToYPMeMpxRz2L1jf++COcZjSkbJLHEju4uOOBHthICJx25E0eJWoDVdXXfH
         NV99aiatuyNhdeO1JOZRX/YpymAGtfgSUT1cqxS2MfWuqpVgRy2RoL4ru1sfh2ruBOr0
         /jr10MRu9XZ9R9QQiqk9G1a38kbRANYKgKfx6qieDirAnaS30p8OQ34OglmpuZ4YYyY0
         81RpxnDGHwsiF7zbW0UNJHXq8yOba7WXbh93rGRDLnYW2rk6Kl+NaDwxIMOEFjnWtl1e
         IrUMoX8anTWXUQlPM+DJWDJ7Jr9+LdOuDYm/krZFbZVL+RfSd7PxUFAY1B2TRSdR6oVm
         1keQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x12vodlTjw6GcEUC7EJZb6ck8MA3k8WsaBK5pxok/7c=;
        b=o1dgVODz5URsLsEcZZpvQR6DIVVifBp/EOGjJUqFTXishTINzqIrvh5kxRy6oDgOUv
         Cx3vZ5cX3H9zZEFWkaIJpJDQy4RgaGG6zDTQvEdqF5vxO08z6YzcBRAKELA87+M+N3xj
         q62f0rpGVh7IuiyHlPP3krowQ1RXzwJHkr5+X2X06mYxuByKBNuI4mlZvvwlauD3Nxez
         5pRf4GeWCE4wenvcwg3NwqwMzu2Ge5c2iBUGGUJXd5wclZ6O2Gq4+rOyi3HYXZPedvrC
         xJoZeOwuqBszqRELrhlVj0QBMjbATTxDn9iM5k161id75XYd5PTRUVP/H4JQCP6xst64
         J/EA==
X-Gm-Message-State: AOAM531YGZ44toHL95wsLG19ZWQjqvjiGp/pxvZA/ft9YK/27GUqdXeV
        pGrb3erggdyosIy8DPkWJUsESw==
X-Google-Smtp-Source: ABdhPJwwSZvOvsJYqLk5AiL6mnZO+19A7YOe8DYHRcMbEEMMQyiqzs0VaTozTq9l5vz5+DqUMV/Cgw==
X-Received: by 2002:a92:d5d1:: with SMTP id d17mr3824933ilq.106.1631220392984;
        Thu, 09 Sep 2021 13:46:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m5sm1472060ila.10.2021.09.09.13.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 13:46:32 -0700 (PDT)
Date:   Thu, 9 Sep 2021 16:46:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] -Wunused-parameter clenaups on tb/multi-pack-bitmaps
Message-ID: <YTpyp8ul6ipgDAhY@nand.local>
References: <YTpms9UnVsx+uu/2@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTpms9UnVsx+uu/2@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 09, 2021 at 03:55:31PM -0400, Jeff King wrote:
> Now that tb/multi-pack-bitmaps is in "next", my local -Wunused-parameter
> topic noticed a few possible cleanups. Neither is a big deal, and I can
> definitely hold them for a larger cleanup. But I thought it might be
> worth doing them while they're fresh in our minds.

Thanks, I'd be happy to see this picked up while the topic is still in
next. Both of the spots you touched looked good to me (and don't
suddenly become necessary in any of the later series that I'm sitting on).

    Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
