Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B595C4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 11:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBB402076D
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 11:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=powertools-tech.com header.i=@powertools-tech.com header.b="Oq4UMMCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgJ3Ljt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 07:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgJ3Ljs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 07:39:48 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFB4C0613D2
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 04:39:48 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id h22so2674956wmb.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 04:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=powertools-tech.com; s=gsuite;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uJNr2QNpyx0aFb42GaC8s3OAU9zjXXTEs9sKrpqwAjw=;
        b=Oq4UMMCiLQrKIbtiDF42FwO6H6zWHT51j1bjtByQd2zfqgAyXV50LKbUTmGANtbgDT
         mWimfwfSY7Igef0A/7mrrrvGMVYJEeQ5z0pezKozUzEXGva59vo55HvX9PShVCpHdBLg
         x48OVKj1gZTY2Ti6PHQNPxh4n1r6JgBWJXn2WlIcIZhN81goj4y1KMURT0Iiz6dgF8jD
         MCw+jl9g8FX4z0Og+xpSOy6KNPS8sHRsyk2YJOa3xo25F5nWNR6TGnVexlSz9wd/6kl4
         Xhq2kzNsLMTlJep9TDFB0mDvvIvW7TFaHKcS9/7LOcywK4RvukhAY2pW3JI1u7Njbtcr
         lX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uJNr2QNpyx0aFb42GaC8s3OAU9zjXXTEs9sKrpqwAjw=;
        b=kW/jjuZ5Nzsq5j+p5CTBswsiFX0zdQLXlz/To8SQcIPvwgHIUs99uqwm/CBLIouGGb
         Mp7GF9P30615/ePSfyW8BGLjVGsPGe2UAYojKJZDi1kBxGRWhVXr4uc6Obh/BkxaQrJR
         91VDFYTMwf5iPm/O6POowTD1WfloRqqTd4uk7xGJ7w/wzHHwqYumjfotbrPKN3PEcrSg
         eMa32n0+EH51PAJnYhTOokQbMqH9DOTHyUoSWjvnuv3FbipTs1pok/EwVgm5sZG2Q9MC
         n+aweC/aP+Gyp9AisQRwfaqrVYyl4InSITXzCmKq4C2F8IMI0XQa8FFbyz9cZWLCVClf
         thlw==
X-Gm-Message-State: AOAM5331QFue3O8DGu/sed56ThUa1zsWeJwX0DlwwqJt4Q6ELjzELz7l
        G1jxum43igcHhesbIg3PWh5f8Yoqf0iYNQ3A
X-Google-Smtp-Source: ABdhPJy6NBrpyHxRyC5VIY5Zcq1rMaUIHFm96XVS15+a1+A1DtzN8wfT2KFXDefxqSL31tslAHrBog==
X-Received: by 2002:a1c:dcd6:: with SMTP id t205mr2038887wmg.29.1604057987091;
        Fri, 30 Oct 2020 04:39:47 -0700 (PDT)
Received: from localhost ([2001:470:1f21:ea::ffff:dda4])
        by smtp.gmail.com with ESMTPSA id c18sm4290993wmk.36.2020.10.30.04.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 04:39:46 -0700 (PDT)
Date:   Fri, 30 Oct 2020 11:39:45 +0000
From:   =?utf-8?B?U2ltw6Nv?= Afonso <simao.afonso@powertools-tech.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Credential Store: Don't acquire lock when only reading the file
Message-ID: <20201030113945.3edylqczqav2xd2k@safonso-t430>
References: <20201029192020.mcri76ylbdure2o7@safonso-t430>
 <20201030055541.GA3264588@coredump.intra.peff.net>
 <20201030112229.3rcyylkuyrlrhn7g@safonso-t430>
 <20201030112524.GA3274373@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030112524.GA3274373@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-10-30 07:25:24, Jeff King wrote:
> I meant: would you like to try writing a patch. :)
> 
> The offer applies to anybody else, too, of course. I may work on it
> eventually, but I've successfully left that series at the bottom of my
> todo list for 8 years, so...

Ah, that's another kettle of fish. I can try to take a look at the
simpler fixes you mentioned.
