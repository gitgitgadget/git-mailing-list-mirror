Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA5DE784A7
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 03:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbjJBDGH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 23:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjJBDGF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 23:06:05 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C00C4
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 20:06:02 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso120352255ad.1
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 20:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696215962; x=1696820762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R5fCXBvCy+JgkMxfYp8KUk4djrEV+yEOTvzQgHIvY/A=;
        b=YDcoNNABohxtIHJp9fOKfrkMjmggFGDZozTBTTc6TrDbQBPy5Q54C7DOssndF/xI+E
         APUtnKL7Ph3xcdZeFwrfP/gQV55uNEAb32mYcITuog73SVoZNKEuH5TkbSgHTKs79ucL
         gA7EfKj1g97RWOtxM08+5Vt+EihAGmUAYTbh2mO2G8pVvscrEzex9LnLFS5FJS/IAnqP
         pVAGkAXqSekWHV4ukaPaRCVSxJQCQlj9q6Gm0zwPhM6M2x8ZSqopMDNNeO84jJvRbx0M
         LazWtu//KrP5wL5GiyROF/S5u8UIZWblncisV4f6uvOlh57jj0oSbkEcMIXa7q810V9b
         3Uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696215962; x=1696820762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5fCXBvCy+JgkMxfYp8KUk4djrEV+yEOTvzQgHIvY/A=;
        b=TVOT2wabHKIbOUoMZLv59ICMInfLuzlm+PXIIdIkwqiKFBaQlhSkVMj7Q08p0AMkWK
         R8sfc4pA1Io8D8xYrUR6WTz4vEcaaYJkSzg7Sy15q+8UrNCuaM0UVKpxnDjKVn72w+I6
         UUqTy6w71RgU8IveWiiQVe82Pe62fCzq0E3ANthHWaC5GpBre/ie3o+GsdMx/+933JKv
         EnJy88L3JGmVxnZCZLty49EyiouritDXeMpEM4DIKp6FM+T7J4hYaLHcClT3xJ/fO7jG
         DgEiKyMtinw2grTTtAtDtEuCwNGSol5bZd611iLg2xoWiCZ1laWws6B9Nah2qpSCATDa
         OPwg==
X-Gm-Message-State: AOJu0Yx3LEtEPfleikVMIOY7m+VGiSIHUSiymv4qtWhjMkq4t2LtVaXl
        Y/v/fKc5PGrXgfxB/Caq+zc1ScVOjYw=
X-Google-Smtp-Source: AGHT+IHCw8oWm+f2ddUjJ5wrLgP87dH1fUr4fVpCb+UFYLsWkF7TodG9s1OxgbgWZ6/OVt7VnvDkKw==
X-Received: by 2002:a17:902:d3c7:b0:1bb:f1d9:432e with SMTP id w7-20020a170902d3c700b001bbf1d9432emr7284708plb.37.1696215961603;
        Sun, 01 Oct 2023 20:06:01 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([135.180.175.200])
        by smtp.gmail.com with ESMTPSA id c24-20020a170902b69800b001bb1f0605b2sm20790631pls.214.2023.10.01.20.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 20:06:01 -0700 (PDT)
Date:   Sun, 1 Oct 2023 20:05:59 -0700
From:   Carlo Marcelo Arenas =?us-ascii?Q?Bel'on?= <carenas@gmail.com>
To:     Benjamin Hiller <benhiller@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git grep performance regression on macOS
Message-ID: <dw26ovefqhtvpdxdrj6rlzmosi5wg2avhsurh452jku3vf2ox3@fjkysuygd4ej>
References: <CAPWWTaDE5559vA1qa0zhBid_ep9ht+PxPSDS5YC7Dk0NN8sp9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPWWTaDE5559vA1qa0zhBid_ep9ht+PxPSDS5YC7Dk0NN8sp9A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 29, 2023 at 04:56:19PM -0700, Benjamin Hiller wrote:
> 
> git grep -E "(A3T[A-Z0-9]|AKIA|AGPA|AIDA|AROA|AIPA|ANPA|ANVA|ASIA)[A-Z0-9]{16}|(\"|')?(AWS|aws|Aws)?_?(SECRET|secret|Secret)?_?(ACCESS|access|Access)?_?(KEY|key|Key)(\"|')?\s*(:|=>|=)\s*(\"|')?[A-Za-z0-9/\+=]{40}(\"|')?|(\"|')?(AWS|aws|Aws)?_?(ACCOUNT|account|Account)_?(ID|id|Id)?(\"|')?\s*(:|=>|=)\s*(\"|')?[0-9]{4}\-?[0-9]{4}\-?[0-9]{4}(\"|')?"

changing this code to use `git grep -P` instead will make it at least 7x
faster even if you have a pcre2 library without JIT.

Carlo
