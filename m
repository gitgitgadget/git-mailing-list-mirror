Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B527C433E7
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 02:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B27D9222E9
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 02:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="z1Ya//HV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389470AbgJTCbn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 22:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389429AbgJTCbn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 22:31:43 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628A5C0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 19:31:42 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id p16so409970ilq.5
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 19:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GFdOk1fdHrnef4s7LuvxsaEyA8eyWsCyLkoupxwyOmo=;
        b=z1Ya//HVovIqIzTz8in3BHqsQQjFosSaQ0nRma4epejkwgT5ooDquGVDs0JJSP42Fz
         9dRbsGf7kC5Twnm6thAGrp/QtsL9gRjsetR4EKb61lggALWM8Zcio3riA5SBnMXavSbn
         sY6qKmVat674M7gh7yNkNzOK6hh1AuwrlmLz4uG/Xe4HOne3g/paKRXbu13ptS4K1JcY
         lWoIGc2q+Z3HmTwDy/slxPhrl1j1yB6hCF/dQESEbdECnJ9uLM/ctg3zDz8oyy7gsste
         EVstm2mbtM/tbha21fpIua6htZuwGWo6p733Wid44+jBCfxGDy1pK6Ggxg7l1/O2pOcr
         HyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GFdOk1fdHrnef4s7LuvxsaEyA8eyWsCyLkoupxwyOmo=;
        b=rZ8L+M89X/67LO/O/ZMwi+R3hTvPfxqeOSAmeIO8dh5QPjNooPFF9AGTWU7XKZEPFc
         A4/W5xcF0lMTrwQWtR195n/EjCz/KOukdD4wRSNVfyof4ELC5u+0n6927SUychvrY4y4
         y/qBjZi3uCHQSZCQHJ52SN4mBuSme/TzcWJCuuVbQwll83dqaB5KqGJXsN8P59f7XFuv
         h8vxtaM7YLTJaYMpcajAKfwMT32IaW+lIoqpT4+v5Zsc4oehHV4u8Duk6vICUe/+7GKk
         VSpwXz/Ok/P1L4mkh9/wntjrfOwQq97v+xs6LSinAQuAxXKdWK7+2RZHJYVS6bMFYaO7
         gLQg==
X-Gm-Message-State: AOAM533fHULwvL7aRGkH+n+GN/93L0cgaWxNqDGQcGTBOn8CTsJTljCo
        Qc/JkwqLOC56g67Ejl8ZqdDoPE4R4wXPrDHr
X-Google-Smtp-Source: ABdhPJzFDXL3FNo0tZGBM6qorM1JqXg3heRmjMZ7/uX8YZKax8ovgJDiJXQjB8OJEJflfjXF6/lnOw==
X-Received: by 2002:a92:dec2:: with SMTP id k2mr388978ilp.78.1603161101645;
        Mon, 19 Oct 2020 19:31:41 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:943f:d0f4:e8b9:b8f9])
        by smtp.gmail.com with ESMTPSA id f5sm360022ioq.5.2020.10.19.19.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 19:31:40 -0700 (PDT)
Date:   Mon, 19 Oct 2020 22:31:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] Documentation: stylistically normalize references
 to Signed-off-by:
Message-ID: <20201020023138.GA54484@nand.local>
References: <xmqqmu0it6ls.fsf@gitster.c.googlers.com>
 <cover.1603142543.git.bkuhn@sfconservancy.org>
 <37a4932d48c1d36c3c512e9f8c0bcac878de6b76.1603142543.git.bkuhn@sfconservancy.org>
 <20201019220214.GB49623@nand.local>
 <xmqqy2k1dfoh.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2k1dfoh.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 19, 2020 at 03:17:02PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > I think that the 3-patch series that Junio was talking about in [1] is
> > actually this one [2].
> > ...
> > [1]: https://lore.kernel.org/git/xmqqmu0it6ls.fsf@gitster.c.googlers.com/
> > [2]: https://lore.kernel.org/git/20201018194912.2716372-1-gitster@pobox.com/
>
> True.
>
> I actually think it is a bad idea to add ":" after every mention of
> "Signed-off-by"; it only looks clarifying because we use a boring
> and generic word "line" to refer to where that three-word token
> appears.
>
> We can say "a 'Signed-off-by' trailer" and it becomes plenty clear
> that we are not talking about any random line in the log message,
> and we do not need ":" everywhere, I suspect.

Mm. I may be in the minority that I think having ":" after
"Signed-off-by" is helpful, but I'm happy to go whichever way others
find most clear.

> Thanks.

Thanks,
Taylor
