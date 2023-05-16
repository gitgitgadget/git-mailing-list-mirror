Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84087C77B75
	for <git@archiver.kernel.org>; Tue, 16 May 2023 18:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjEPSBc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 14:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjEPSBb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 14:01:31 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5269B
        for <git@vger.kernel.org>; Tue, 16 May 2023 11:01:28 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so5342497276.0
        for <git@vger.kernel.org>; Tue, 16 May 2023 11:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684260088; x=1686852088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lHJ4CRDLxc0IPzGzgSxU2ukcI/2oVtAIhi0P0A6ZGDc=;
        b=FczpIrULwoj6s1f3CIM+0Al2rGXRddedVjsvKwNveqxVEDvk8W3p1tcco+A1tjffHj
         3AGDw1MLTV3MfWTkYwCNO6Romg/v2LuyIeh1frWfk5leq3w9BUv7LRdPhcLLSUpn4A6T
         AHotlnnl2QtuA5qR7+y0NcYFNWk+i8irURNdAwC9TkMW2FmlNJx/F2CmuiGe3pPS+8pz
         gsU0OONMIeI1E3mk1U58LGx/GunYiHNNa76ft2jSQyJg3SrJW/U0J+IwQJ0++sM4Bo99
         dhWamrnd/vZkdHIQ9hOissxrduUuFTvx6pqz1Rjy1uBZzPclfmsGUqfhZtIxetejXVLb
         1xSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684260088; x=1686852088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHJ4CRDLxc0IPzGzgSxU2ukcI/2oVtAIhi0P0A6ZGDc=;
        b=B31LtzkntwXkF/5T45KNy4dCwT5BFXrNUOTl/oPD6WHDKQV/0hHz2RjIU0pLxxO3E2
         DINccC6+4GjRxVorRnH2jDfRFqMx74utbG+ALHJAeGLqbG3bBwgEVdNb2vLjwSL4TPrj
         fiXlHTSG007dlmrJm9EJ84Zh1h5dvWXHxzgfVqcyFJSaRaV/ZysgL2eqWfzdw/WPitmS
         rgFcxWimqK1gzwByGOVTp5v+4zayZxTxomUYIKaJGQJ76UTfv5Z5dxBHm3B+vAecG+Bb
         BKT7zkTjVOObS++wn182+mB3LonvsNp1yPXg5irOq6qbE2d5BPlEzPc/p50gNewhXxhC
         mXgA==
X-Gm-Message-State: AC+VfDyQmUBDaZIWgtvXBju1nShfHwNha09VSyH8JACSoJnsw/ru0pHR
        E8t4p4/+5ggJRW/enjIQHIIdNg==
X-Google-Smtp-Source: ACHHUZ4w5A6ohqeoNGUW+MGED2SuCsCfD9PFkQnV/8giw7pAwfdjayx3XLSFCn0WeGl4NCrte5oBZg==
X-Received: by 2002:a81:ac8:0:b0:561:b4dd:8aff with SMTP id 191-20020a810ac8000000b00561b4dd8affmr890441ywk.6.1684260087917;
        Tue, 16 May 2023 11:01:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n190-20020a0dfdc7000000b0055a21492192sm25305ywf.115.2023.05.16.11.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 11:01:27 -0700 (PDT)
Date:   Tue, 16 May 2023 14:01:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     rsbecker@nexbridge.com, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] run-command.c: need alloc.h for our own at-exit handler
 emulation
Message-ID: <ZGPE9ozRChUJ3NGV@nand.local>
References: <009501d98817$9eb44560$dc1cd020$@nexbridge.com>
 <ZGO4LesPe4A2ftdm@nand.local>
 <xmqqlehourbf.fsf@gitster.g>
 <xmqqh6scur3r.fsf_-_@gitster.g>
 <ZGPEHu2pCYfdNI0h@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZGPEHu2pCYfdNI0h@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2023 at 01:57:50PM -0400, Taylor Blau wrote:
> On Tue, May 16, 2023 at 10:24:24AM -0700, Junio C Hamano wrote:
> > Recent header file shuffling missed this old user of ALLOC_GROW()
> > that was inside "#ifdef NO_PTHREADS' section and forgot to include
> > the new file, alloc.h, that defines the macro.
>
> Heh. I wrote an identical patch before lunch (which I just came back
> from). Feel free to queue either, I honestly do not care which as long
> as the bug is fixed :-).
>
>   https://lore.kernel.org/git/db403de74da839084165f11dab05d71484457c6f.1684259780.git.me@ttaylorr.com/

OK, having now read both completely, I would say I have a vague
preference for my version since it keeps the include at the top and
unconditional, and has slightly more information in the patch message.

But I do not prefer it so much over yours that I would be sad if you had
already queued yours and didn't want to bother shuffling it around.

Thanks,
Taylor
