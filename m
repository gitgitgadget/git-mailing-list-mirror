Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07BDC77B73
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 17:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjDTRYS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 13:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjDTRYP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 13:24:15 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F9E4EC4
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 10:24:04 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id n203so2713255ybg.6
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 10:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682011443; x=1684603443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mX7is0BFuyHTYfsbztYbCO25cFilycGGlhGN6FiXU1w=;
        b=dPEHWvafQXgFvtN8lJcDxOt2dEvDpbzrXJJYFmH9uEupYTF+UdlzZiq9+iuHNcjoIm
         c2pp0+7dheuEavp0Ywmylmu/XQzyDKQtg8A6p+RZnl9Z2kBuWK5Sev2KyN4aOT3cAyoI
         ZlgXwh1+prS3FA31pHEae6mdRbfTyQ5Q7ZWIBBhDeF8Yz25oPbGqHcG0fwOuOSDKJ2qF
         IYRKOSM3bvGdc7rcxpRsmQUNi+FCfpWn/XkXSC5GSCDKjafK/RLH7+MlfUxHcgIByRPj
         3wJgog+NNFwT+df8zZ97gg+AaCXhHjxtQeRe+yPIenjukZGAkjpBLHNN0PmV0kRdtKD3
         lpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682011443; x=1684603443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mX7is0BFuyHTYfsbztYbCO25cFilycGGlhGN6FiXU1w=;
        b=N2iBKv9TEUYTvK6OQzUvoFJ/nt9fs104yQrVQ4lf+Ux+c7yuuMeoZ/2ScUTg31soYu
         2kSeQux6dqpbaOQAipjEuRVm5NLeMilIupfOG+zcm9d3BbFCiomQAWzFU3G14Ifd0UsG
         ihtVzqNJHyIb5Xsc7jEvh3cZ8aTwAie6LNFm2O2EtLXDVP+iVkEVuLWOyYDLWQ70S6hT
         bdz8v4UnC5bvC3kgPZGvyVhgCq60t9CoXLSSqyjMN0HX3cSPNwpLt3nzsEZMJuWS3atP
         05S7Ar/wWNuycaONRxr3x85k2DZ1saaU0kECYxrKBTzFOpHeobJd8Nzgok1c1uYTCIUW
         BfGA==
X-Gm-Message-State: AAQBX9eyn1siKJl5Ef4Dy8qaSLFZZt8tXy9tTkeE2M7A7vAt5x4JpHqt
        J2dLDdWK5RzaNpbHXejwZlBpLzEiLFEtPJyqDKwfgg==
X-Google-Smtp-Source: AKy350bIHr3tfzvpz+N2yy3J9mp4RjEa4/zDGHpLXofkn6cJocYub1V2SvXIkR2irPw7m8sWxg7WFg==
X-Received: by 2002:a25:3254:0:b0:b96:7d4b:7aeb with SMTP id y81-20020a253254000000b00b967d4b7aebmr1841103yby.34.1682011443147;
        Thu, 20 Apr 2023 10:24:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v187-20020a0dd3c4000000b00555c30ec361sm427406ywd.143.2023.04.20.10.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 10:24:02 -0700 (PDT)
Date:   Thu, 20 Apr 2023 13:24:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 09/10] builtin/gc.c: make `gc.cruftPacks` enabled by
 default
Message-ID: <ZEF1MSwtSl7KdjMi@nand.local>
References: <cover.1681764848.git.me@ttaylorr.com>
 <cover.1681850424.git.me@ttaylorr.com>
 <b6784ddfe2906f7c04b3050bd9ba63a884ddb047.1681850424.git.me@ttaylorr.com>
 <xmqqh6tb7bsa.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh6tb7bsa.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 19, 2023 at 03:22:13PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
> > index e52bc6b858..17b4d39f89 100644
> > --- a/Documentation/config/feature.txt
> > +++ b/Documentation/config/feature.txt
> > @@ -14,9 +14,6 @@ feature.experimental::
> >  +
> >  * `fetch.negotiationAlgorithm=skipping` may improve fetch negotiation times by
> >  skipping more commits at a time, reducing the number of round trips.
> > -+
> > -* `gc.cruftPacks=true` reduces disk space used by unreachable objects during
> > -garbage collection, preventing loose object explosions.
>
> Being listed here is a definite sign that a feature behind a
> configuration variable is considered experimental.  Do we have (and
> if not, do we want to establish) a procedure to mark and announce a
> feature that used to be experimental no longer is?  If it is enough
> to mention it in the release notes, then I can take care of it, of
> course.

I am not aware of such a procedure. But personally I think it would be
fine to mention it in the release notes for the next release.

Thanks,
Taylor
