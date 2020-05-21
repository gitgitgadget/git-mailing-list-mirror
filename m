Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DA6C433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 03:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACD4720738
	for <git@archiver.kernel.org>; Thu, 21 May 2020 03:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJwyrSVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgEUD0x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 23:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgEUD0w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 23:26:52 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A17C061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 20:26:52 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r22so2435374pga.12
        for <git@vger.kernel.org>; Wed, 20 May 2020 20:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hG+f81DzhcjghLs6r3T+/X8TPR8rsWsaw1QCQWTk9O8=;
        b=XJwyrSVmxYt7MtIfHFGV0ffbJkLVrs+wVN4ezXBfVCegjYPqn8xvmnHYahEME7m3Vb
         zbGWIimyiPP84w642DANbbAh7UxijqwE2VVztCWeG4+tBzmfLkjQW/ZM1Kwpqxv+rBMc
         z9FSCz/+bajUbUtD56XGg6mYfqaQm2CHeIAppaXrpvGWnFoUe6KKZXpFeROwXkjZTx6z
         1m+Bp4v0yK/OuhgCjeE0940jFc1grKNzky5Ddk/mS4YHujQLqpMSm5lePNHRMi+aHaro
         2daiM6H97Zvfro7hMlhVaN7zJ08qmhRtStQYhEPKIDIa1cf6zJHw1WrLG8azONLhxU2e
         pvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hG+f81DzhcjghLs6r3T+/X8TPR8rsWsaw1QCQWTk9O8=;
        b=qZOg7tvLe/A731B+wt32L+VqX3lIIS3bB4E3G+cwe8QSJXWRz5dm59XF8e2shrAP8u
         z84Wp9Ox86NaXICmPzFol+vRY8RDQUXOqhixC3B7fLHZmdVeEbTXJqqFhoHhN508UrwX
         MiYPMw3GE4xifB1kkEY6da1WqrPHW7z6yLdtGiANA0dFtjdR4pypP1cr/xeXUhMgbJwx
         Uha/ALi8drszvcg5PUeLgDeF0GQqB0mriivTZJq4pO9aCdulungCUfp3o33Gfx3C9EWL
         PsGFWwMgWJDupBlIfGhv8oxfmIFv9GUB39Ey8G8NM3A6VaQKjJgDpGIZ9WmIpRNHhVE4
         3ZDw==
X-Gm-Message-State: AOAM533H9oLbR3PrOLlZ9eQMXsnzytO4EwqW6Jx8WHBcMFmg6EljTg12
        5PIimYH8djTmbQ3isfciufU=
X-Google-Smtp-Source: ABdhPJxHPm5HFf5PuCg4MrehL/g9Fbq8bdAPzyGO3M9DwGYC84ifIFpKan20/nuvSn3wlvoRtvXvQw==
X-Received: by 2002:a62:834b:: with SMTP id h72mr7304799pfe.237.1590031612220;
        Wed, 20 May 2020 20:26:52 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id c22sm3279620pfc.127.2020.05.20.20.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 20:26:51 -0700 (PDT)
Date:   Wed, 20 May 2020 20:26:48 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        bwilliams.eng@gmail.com
Subject: Re: connect: don't request v2 when pushing (Re: Protocol v2 in v2.27)
Message-ID: <20200521032648.GF20332@Carlos-MBP>
References: <xmqqsgfuv2ko.fsf@gitster.c.googlers.com>
 <20200520193156.GA4700@coredump.intra.peff.net>
 <xmqq5zcquz4t.fsf_-_@gitster.c.googlers.com>
 <20200520220023.GB3648@google.com>
 <xmqqlflmtaxq.fsf@gitster.c.googlers.com>
 <20200521021533.GC3648@google.com>
 <20200521023554.GE20332@Carlos-MBP>
 <20200521024558.GA102425@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521024558.GA102425@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 20, 2020 at 07:45:58PM -0700, Jonathan Nieder wrote:
> 
> Protocol v2 for push still does not exist, but we
> have plans to introduce it soon (reusing more code from v0 push, so
> this would hopefully have fewer teething pains than v2 for fetch).

Thanks for the explanation; I wasn't aware push was indeed still not
implemented and was indeed puzzled by that code, which I found while
looking at some unrelated issue.

Carlo
