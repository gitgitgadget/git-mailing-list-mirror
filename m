Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AADC77B7E
	for <git@archiver.kernel.org>; Tue,  2 May 2023 16:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjEBQGE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 12:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBQGD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 12:06:03 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CBB26AC
        for <git@vger.kernel.org>; Tue,  2 May 2023 09:06:01 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-38e692c0930so2471959b6e.0
        for <git@vger.kernel.org>; Tue, 02 May 2023 09:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683043561; x=1685635561;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYp+25tIsUOIZSpBRpid4R2a9WY/uvRWafFeYlp+oTc=;
        b=ncqqS+Pj4J4cNGWmeDFuWrFldbgRryp1gEzy4gXsEEj+c2k8+8vtOj17b4OoeOATn8
         aTK7kA0X3Nm3UDeGMej2JMrEPRR0/39eFh5rq1DpuR4dYdC04aMHtqx7VWBy8+h6rgY2
         uEhbPTUGpM98D+fHHt8I+OYm2cObtO50XXqmRu7xkIPP/ZzSRwb751tlIXW5/AtwHi47
         1QTMfrlPmI3KuDoITLzPXiQ0eRW68LUFloDnSq5gRIA97rtxXnMN2CQj9dIXwJH60bDT
         BI+yZ0/mJaeMBtrM/S/UQ4g0XgY74rAzAsN9vO/93AULA6U2Gx/XdKi49pVpal+AuvRV
         EQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683043561; x=1685635561;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vYp+25tIsUOIZSpBRpid4R2a9WY/uvRWafFeYlp+oTc=;
        b=jBxS6C1gPltRHJ5I11rjeiv3oePakc4z0DJPvbff3JXwnzWNJYiTbQRqBO4Dg3TppH
         BsrSUL5n9xOqZ4i4NsIyZnM3or8V702LkFBdEqya7mDwSTtjaA59t8W1y+TEwn49yxA2
         MXS+F0k11riRPme/9t3lFMNQTLLNK41Su2HmXc4fsohpdRQEPmudOBQfILaZiPCQcIU6
         r6c2WC4ZGRXDVo3Gx0JQk16pcPAlA8YsFX5dHqFIdQ0VsL9N40xuu5ePwdbmUftWmpD2
         5xr5ZMUARtDO3HXuplwMWEHJZXmrhOld0oqShSqsTOSGHnYqETJiz3LLmmZhurK4Fq+Y
         PWgQ==
X-Gm-Message-State: AC+VfDwQoL/rQx/VkktMr3JRVsdqXhwcMa42hUkmc/hNtEv+OSlEXikL
        wauwLVs5OACk+z3yVqq3mtOR7ptshzI=
X-Google-Smtp-Source: ACHHUZ5rDv4UnJFn+ce2Fy6cz3dhYyCkW0qDC7/Xd9Pr5LveGoRhCfpNr01PsZhtODXbw7t0AeSxKg==
X-Received: by 2002:aca:1906:0:b0:38e:a824:27d3 with SMTP id l6-20020aca1906000000b0038ea82427d3mr8520921oii.27.1683043561256;
        Tue, 02 May 2023 09:06:01 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id a28-20020a056808099c00b0038ded2e4f05sm12421864oic.16.2023.05.02.09.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 09:06:00 -0700 (PDT)
Date:   Tue, 02 May 2023 10:05:59 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <645134e7619b0_1ba2d294a7@chronos.notmuch>
In-Reply-To: <20230502101854.GA1180695@coredump.intra.peff.net>
References: <20230418070048.2209469-1-felipe.contreras@gmail.com>
 <20230418070048.2209469-2-felipe.contreras@gmail.com>
 <xmqq8ren8xz1.fsf@gitster.g>
 <644684018a766_aba29424@chronos.notmuch>
 <xmqq8reg96cu.fsf@gitster.g>
 <20230425061029.GA4015844@coredump.intra.peff.net>
 <644af29c8526c_7f4f2945f@chronos.notmuch>
 <20230502101854.GA1180695@coredump.intra.peff.net>
Subject: Re: [PATCH 1/2] doc: git-checkout: trivial callout cleanup
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Thu, Apr 27, 2023 at 04:09:32PM -0600, Felipe Contreras wrote:
> 
> > > Using just a blank line between the code block and the call-out list
> > > (instead of the "+") works for asciidoc (it is happy to keep the two
> > > together) but not asciidoctor (it ends the outer ordered list before
> > > starting the callout list).
> > 
> > I don't know what you mean.
> 
> For reference, I meant this:
> 
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index 6bb32ab460..ed32497290 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -529,7 +529,7 @@ $ git checkout master~2 Makefile  <2>
>  $ rm -f hello.c
>  $ git checkout hello.c            <3>
>  ------------
> -+
> +
>  <1> switch branch
>  <2> take a file out of another commit
>  <3> restore `hello.c` from the index
> 
> which asciidoc renders the same, but asciidoctor is not.

I see. I would say the code is ambiguous, so it's not surprising that a parser
interprets it as an end of a list element.

-- 
Felipe Contreras
