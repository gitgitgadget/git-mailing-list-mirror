Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EBDC77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 21:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbjELV2J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 17:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239832AbjELV2F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 17:28:05 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E2BD041
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:27:59 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-55a10577911so151503507b3.0
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683926878; x=1686518878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dPzaKWxwYYksafO/SIHynHv0Kq9GzxFRWOnPKqxV17U=;
        b=DT3FeNXwW1/TQno0JxIKtslfSCyNEbZaVT2mDsqB7j6cRU2FVgBnAyYs9SmMJBqkYg
         V2nH/y5DIcTEg2dCfn6i/iVt6N23Vn0zw5/QS9BwEkQLjt9mK+QoNeKSXbMTkw8/Qu6Z
         bKX/YdsXl7msQyEOFIvbBQF3i55alPIQ+o6OB4niIb3Vs+46Ptd+2IeFrEfM+ZMzLdi/
         zvTKh1sNhA1LyrItqG8q1Ea8Vjnar11woAjGPJAwkfgAMR5yKEWhWwPgaZRUzDKlroVz
         Hdjitz8Zkl8iblURNuUmrzHvj9UaNc4SYVXKJvcZuzeAlPuewn/ZbU9tUTI61kZFLimI
         gGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683926878; x=1686518878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPzaKWxwYYksafO/SIHynHv0Kq9GzxFRWOnPKqxV17U=;
        b=TGBxMuDYFqEytOQerpnaa0urIXSCxptF0QKoYLueoBfsYciYv55TQ3rszsilPxanml
         zfhAjLYToRX4WcBwHVwGeAq7tmtKmzXQoTWI0f28JTdtEs6rIzdZR+yfYpmP+KcT/9HI
         ZaEgaYcJc+7hpeky9wzWVLBAo5S6OT1KRq/gsrym6uSB6IbjXL/B/57StJ1PZna4roUQ
         +SivdTi+/4hsLXbpcQk6gdq/XbFiYdIiqQm/bquAJnvzN2NwpTqAWo8RKWNZ+F/tY0Mu
         ZSke/aaXR5Qt48d90VKqaHWmn6Qae8ogrb6DWxqIV9VEKy90raYeA0fUmsxFTQQNjz40
         eXyQ==
X-Gm-Message-State: AC+VfDys79lz92XiPWQYUF9v9BE7Q4+BxYhg4/cBd/tDLEeOHRUXyqXy
        6snZairOBjTbW+Prkr3xmLiLHw==
X-Google-Smtp-Source: ACHHUZ6fCBulVnH4sRQ/Yiwqh5d6fLCiBNCz1Hk1vBq3GUHsElhQ4BdU4sLdgO+Uko8MQHVgWmU6GA==
X-Received: by 2002:a0d:f281:0:b0:560:beeb:6fc1 with SMTP id b123-20020a0df281000000b00560beeb6fc1mr12136984ywf.16.1683926877733;
        Fri, 12 May 2023 14:27:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p185-20020a0dffc2000000b0055ddea0db57sm4637388ywf.146.2023.05.12.14.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 14:27:57 -0700 (PDT)
Date:   Fri, 12 May 2023 17:27:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        derrickstolee@github.com
Subject: Re: Changed path filter hash differs from murmur3 if char is signed
Message-ID: <ZF6vW7/BhKqUyP7R@nand.local>
References: <xmqqbkippca5.fsf@gitster.g>
 <20230512205427.1090937-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230512205427.1090937-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2023 at 01:54:27PM -0700, Jonathan Tan wrote:
> > > I don't have statistics on this, but if the majority of repos have
> > > only <=0x7f filenames (which seems reasonable to me), this might save
> > > sufficient work that we can proceed with bumping the version number and
> > > ignoring old data.
> > >
> > >> Better yet, we should be able to reuse existing Bloom filter data for
> > >> paths that have all characters <=0xff, and only recompute them where
> >
> > "ff" -> "7f" I presume?
>
> That was my assumption too, but Taylor can clarify.

Sorry, yes, I meant "0x7f" here not "0xff". Thanks for catching, both.

Thanks,
Taylor
