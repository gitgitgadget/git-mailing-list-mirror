Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9C9C6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 19:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjCUTGr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 15:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjCUTGq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 15:06:46 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4100A1BD
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 12:06:43 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id d14so4531326ion.9
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 12:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1679425602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xyt5oISv72/5x2b5mSsYu23uBvClRepXUNVOCSfjueM=;
        b=LYK43KlpRRcBBkcHCjcDa/0pqzDhTTSADsBXVEeu92uVidmZ+YXS/nrbfDSjpJIZ5D
         cx86FgkannJelxjYoa0of7STLwaMM/UVR9BHQ47xZjqlgDTC/umMs5FG1d/blmz6uNHC
         LfugmbhvW2gSAJHM2pTPWP9+9+KX+14zZZSD/EsrYAMd39IyIOQ3O96CLeIBAHaPhxND
         2pjJKp+tZuq2G4DIvqJojPf8hFCzxgqPYLzllufL6ZzLlRpyQYb+NZIFJXwofFbsU6lb
         Dx2ARQTUe9mXd0x/eux4NHcvGVkE2yxwdqQJx7vs/tSgn5VWIXaakEYMx+lTtLUFWB3s
         9Q8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679425602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xyt5oISv72/5x2b5mSsYu23uBvClRepXUNVOCSfjueM=;
        b=uynTTERWc41/ys9HJkZZGt4t9i0hdIwna8A9f3IDDUNUd7Y2lyCALO/ubADM6IZOra
         3uDGXZmU6Uyx2kgG5J79NCEEj3coFj+7S75lBrkqWp+9f5nzMdnDa1hRCjla2sDDyw0y
         9V0ENGaB7gCyWItPsTQ2mTrHqn9xflgUEsKFaptSyD6RfxU/qaRgVsdp5lTYRkMlb14d
         t76TOW98HD5jW0h1qP9rZJbgtx8vzCVE1oOeFxe2klLZYmlNM9BOr1x1UVikJ89S3FaY
         5u53h1MNY+EtlY0qVkmQjnFw2d6FIjfJpP2Msv3Eq0M1lA9cDjB0FNeGp5sT1M8IFuaK
         SJAA==
X-Gm-Message-State: AO0yUKWSsU54ON+hBWRiJohAL9V0TGOat8cRS94cQIJe5LhsORZrKEMM
        tqQyIoMzAZO01IO6Gitw5ZO25Q==
X-Google-Smtp-Source: AK7set+uJDnSY/5xdRXU3fxExxU11CRyYosnhNyipA8872yLFZ7RCHASxBQzgFxh4I4mM60S7Li+Ww==
X-Received: by 2002:a5e:d914:0:b0:74c:8b1c:239c with SMTP id n20-20020a5ed914000000b0074c8b1c239cmr2349730iop.10.1679425602482;
        Tue, 21 Mar 2023 12:06:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v13-20020a02b08d000000b004063fa63e31sm4070895jah.118.2023.03.21.12.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 12:06:42 -0700 (PDT)
Date:   Tue, 21 Mar 2023 15:06:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Paul Eggert <eggert@cs.ucla.edu>, Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2] git-compat-util: use gettimeofday(2) for time(2)
Message-ID: <ZBoAQFCWGhwIO963@nand.local>
References: <20230319064353.686226-1-eggert@cs.ucla.edu>
 <20230320230507.3932018-1-gitster@pobox.com>
 <20230321182252.GJ3119834@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230321182252.GJ3119834@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2023 at 02:22:52PM -0400, Jeff King wrote:
> The disadvantage is that it's longer to type, and that you have to
> declare a timeval in the caller. So maybe it's a dumb idea.

I don't think it's a dumb idea per-se, but I think that being able to
pass `time(NULL)` around without having to create a timeval and pass a
pointer to *it* before then giving that timeval to some other function
is a nice advantage.

So, yeah, we probably should just avoid calling time() altogether, but
in practice I like the solution of redefining time() to do the right
thing and implement it by calling gettimeofday().

...Which is a long way of saying that I agree with you that this
approach looks good, and that I'd like to avoid putting time() in the
list of banned functions.

Thanks,
Taylor
