Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28198C74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 21:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjCWVQk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 17:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjCWVQj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 17:16:39 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3370225B81
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 14:16:38 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-53d277c1834so417484827b3.10
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 14:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1679606197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YfGnvoxny/4BBNNn3QsAlV0Ns0ERpdJIYjxi0xjUWac=;
        b=NPh9Q53KHF1ueC1LVfwoPKmap+krR+DNshjYMqkWILZueS4e9UbjPUDRf5xrMNVYum
         0e8SN50LePCemoT1RtX2v3VQ6mhq3FZ5RSecgcEgREFhiRXiFrwObKTcNSuHsLgrwlST
         vNPJD8chnU3qftslj4jfxZLpzcNhYnmXw9QqMSdu4SNoIHHLWiAkSv2WVz4B47cwdi6J
         OowSwHA7x5pTGLRI1cAblb7k433XeEMOjfE4wEtV12Thfy5F1a5em0RLyRpu2bx4W22B
         djXFonGAksRUkaSVdWAN5cmm8/G1mC6N3AriIERClvabNeaT4lpfrb1iCcSwawfQK1k9
         uAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679606197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfGnvoxny/4BBNNn3QsAlV0Ns0ERpdJIYjxi0xjUWac=;
        b=fSd2BP1Chlt3mW72Vc2JMj2qyuVDJ0/0q7YWH3iLDYpnW5d5JwbYFxFrJdHnI+hn4W
         EaAgxtGBH/zVXo4+gKq+Xf0K7cfMZf52skmbQoo53ZYR5ne9Ocu+z65xmZdvwYrja0oo
         B3PeXla1et84qtHvkSnhDOw7WW/W4wPOkq8jZsy2ptR7pG+SyQvDgyhqDXjTp3GBj3cY
         TB0P+TPqGyppNFeyZL3Vi22elwpH+7JGElwidWii0Bo719sV+drkg1xRXYCcbryVu8YA
         N86QQvfAwgapT+wK5/AUwsZtwRvKRrh2ZE5PjT5jFBmqrksuoz1MWN6JrcbVaVyWmkgg
         VfCQ==
X-Gm-Message-State: AAQBX9fZZdk34SaWJUuF8a4C7efYP2936XFY2AlASY9eDV6JEX6DXi2u
        zHueDg9SvHXr4Ka7M/q3ZnwtTw==
X-Google-Smtp-Source: AKy350bq6QeU/MpKwAq+VCEAFRGMw4STA3kkAXUqiHjMlj5rSQYP0jFUwzhSTMzn9vdrJJ2tkMEuVg==
X-Received: by 2002:a0d:ca93:0:b0:541:876d:ae50 with SMTP id m141-20020a0dca93000000b00541876dae50mr5015236ywd.44.1679606197282;
        Thu, 23 Mar 2023 14:16:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x136-20020a81a08e000000b00545a08184e1sm48156ywg.113.2023.03.23.14.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 14:16:36 -0700 (PDT)
Date:   Thu, 23 Mar 2023 17:16:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [RFC/PATCH] pack-redundant: escalate deprecation warning to an
 error
Message-ID: <ZBzBr1EAXoqBwmVo@nand.local>
References: <20230323204047.GA9290@coredump.intra.peff.net>
 <xmqqlejn6vb9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlejn6vb9.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2023 at 01:56:26PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
> > I was looking in this file recently, and was reminded of the deprecation
> > plan. The two data points above do give me a little bit of pause, but it
> > seems like the current state is the worst of both worlds: we do not have
> > the benefit of dropping the code, and people who try to use the command
> > have a bad experience. So we should probably either proceed (as with
> > this patch), or decide we need to keep pack-redundant.
>
> Sounds like a good thing to do.  Will queue.  Thanks.

Yeah, I agree with and am persuaded by the "worst of both worlds"
argument. I think that changing this to a die() is sensible for now.

At what point would it be fair to drop this builtin entirely from the
tree?

Thanks,
Taylor
