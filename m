Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B25C7618E
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 02:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjDUCOT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 22:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbjDUCOR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 22:14:17 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A155D5581
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 19:14:12 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-b8bf343833dso330054276.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 19:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682043251; x=1684635251;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3R7/3oilbF9BjYO0GIY+C32p3UdvkhrZtCKQaTQvjO0=;
        b=WLNzGmB4QJ9j7scZqDY5wSIoWWFP/yoqlUYvs24gtLmLOfvfZQWGdojAVWkNaTX73v
         +UWWBjkDfH93dlfhgPZRSDj0WJdStMk2lHLKUB00rxvsv+tRyyVotZoCsDaZykS6HFZE
         jpyAXMCpy6ASXJkcyuArsmVXjnQEdm6cibY+l/Cok5XmEm1hqS2GGYL4YYCLspieMV8Z
         +NRxmzpVE6BAX2GkRSfYIUDFIPpsgg6mul9UrOWTdmU1vMxxvqNEKJ2Pip1bHgd3Yddn
         0y+Lhvh/Yvsk+PBOeorLPIhD/hoxnVud/eNfcCziYpX0YXQdB1+LovztqgmitSg5cyDt
         0ETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682043251; x=1684635251;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3R7/3oilbF9BjYO0GIY+C32p3UdvkhrZtCKQaTQvjO0=;
        b=hWw7EnPGQ1whWwyeN/35qTHdt1XtUSrbe/7O8b5r4FnrNScFsqQaUnhPV0yTHs9U1Y
         C0rFF20bkynX04KQZa84CEwQnT5YC/zmNzWnwit9NO0pHPimNGMFj4pRxQC4AisidK4U
         iq9p/Lnlcf495XIYecvI0ovfCY7YhASAKesLZ1TKPZNlMYKKWTvnvbanVXou/ssoIkhU
         it2orJKpdVxGqg+eURzVw3qnDEKLA/vgQJ7qXiEWUsJtnDGE8HvRs/4lu3vlxram6lRa
         aNbeLPXCnb1jgopcclt92PRtpC7qQcqxZSM1anCbOhQPs4/qrevVhcrx5wCHaI9svf6I
         Q9pw==
X-Gm-Message-State: AAQBX9fZgPoqe7TKURawc+CaE9SJ3buCFCjyUXkJyOZ4fvT6I1bzfuL5
        1l7ty5MkoSjG0IcHr7+6R8OgtA==
X-Google-Smtp-Source: AKy350YCmbli1QABkG8zfV/5iywADaR4yYZAEAj+wGxy76oqYNciMTV71UX65w0c2S0lvVw6uZ9zeQ==
X-Received: by 2002:a25:c5c9:0:b0:b23:dfd7:ec0a with SMTP id v192-20020a25c5c9000000b00b23dfd7ec0amr909387ybe.27.1682043251649;
        Thu, 20 Apr 2023 19:14:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o68-20020a254147000000b00b8f5b078eacsm668015yba.39.2023.04.20.19.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 19:14:11 -0700 (PDT)
Date:   Thu, 20 Apr 2023 22:14:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/pack-objects.c: introduce `pack.extraCruftTips`
Message-ID: <ZEHxctCveqt06g4a@nand.local>
References: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
 <CAPx1GvdmzDVbiZGeguVVjWe+eAhj6=yG18Rd6wLhZVrnd4jiBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPx1GvdmzDVbiZGeguVVjWe+eAhj6=yG18Rd6wLhZVrnd4jiBg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2023 at 05:10:31PM -0700, Chris Torek wrote:
> On Thu, Apr 20, 2023 at 10:35 AM Taylor Blau <me@ttaylorr.com> wrote:
> > +Output must contain exactly one hex object ID per line, and nothing
> > +else. Objects which cannot be found in the repository are ignored.
>
> The first part sounds good, as a rigid output format can always be
> relaxed later if necessary. The second I'm less sure about: should
> there perhaps be a --{no-,}missing-objects option to control it?

Maybe, although specifying it might be a little tricky.

I think you'd have to tie that setting into the configuration instead of
passing it through as a command-line argument. So things get interesting
when you have multiple `pack.extraCruftTips` commands: which of them are
allowed (or not allowed) to specify missing objects?

I think you could do something like:

    [packExtraCruft "foo"]
        exec = /path/to/script
        allowMissing = true

and specify multiple pack.extraCruftTips-esque programs, that each allow
(or not) passing missing objects.

I dunno. It might be overkill, but I could also see a compelling
argument towards doing something like that. It may equally be OK to set
`pack.allowMissingExtraCruftTips` once and have it apply to all values
of `pack.extraCruftTips`.

That might be a reasonable compromise, and it doesn't feel like overkill
to me. I can't easily imagine a circumstance where you'd want to allow
some programs to specify missing objects and not others.

Thanks,
Taylor
