Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674D6C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 20:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiLNUMm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 15:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiLNUL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 15:11:57 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386582E9C3
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 12:04:01 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id y4so4053675iof.0
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 12:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G+rnQFjXvOAb76VGx/ZuP2N47g26HhR7KDaNf0v+GB4=;
        b=WxXyNGvCJBBuAa/0F0aoz0x0LvYVUHR7tLX5dDaaw2956ZuJ0/LuDFKd3a0RY32yAz
         kF7PjQQULBlakGEVGVPyXTvaBnKqBTfNB/qrPPO+G2DQp4dkNLVZlPrwlFXgiz6NsbT1
         Rv0qmVS8OnX5M8aKlo1Oldt8gp9u4zqJXbVfoKfPLQrLCNq2ZEZ3vv663JFueVrUawPC
         yE5Bq7OK1GmtOP6b3AY+XkDwXNEeuujxHOApmAweDJI7yhhkDNSxlRPAHVrs5JfsO7ER
         fdwj9ES3F0Dif3aywzrJZse39PQTe++Mni2pCwGBn2Ff44x+znBOJN1SsJYEJaCuMb0+
         aTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+rnQFjXvOAb76VGx/ZuP2N47g26HhR7KDaNf0v+GB4=;
        b=BB3bWmcSMz2/nezCdNEmJISGQMB9EAJMDHLY/LXda+zV30PyX4wMKwn16Cc/QA9//k
         ZSOt1wENLrWxz2a62/NnEiCCuWZbhhVzDClGyeYTSUG+uRKOVp98+5eRW1g4KZjIKZfW
         t6ZKxgFShqoItaukp+gsCqKA+U2Iyrmj1f5dhXt0ssIyOMBgEsTRoRrPApVH+fNOKzEp
         90nqUd+iPpYXVL5QWPwj4RMmQh5RUqIXzsp/lnrXhPgp6uM7uhnGbnEFOIk9FxZab/z3
         TsDQdn9QyE+napdKiSDQ+CGilwS/maHvlC+Il8CWwGkz97+TowyTOO5yOCupVeelCSYc
         /COw==
X-Gm-Message-State: ANoB5pkU0ubHgj/0h68zwTeBjaUrpPi2OVxBl2AAZaBxTcAUXCEE02lL
        A+qHvOEYa6QWaUp54818A3ouZyk+S+WartZJ
X-Google-Smtp-Source: AA0mqf6tBuDjA9zRX/Gds5HS7Ca5E1IGVhweRnp4kIbz6MOZ/jr+ri3CYKAZbBJ5hROEf/8yHtnldQ==
X-Received: by 2002:a6b:7112:0:b0:6e2:bf38:165f with SMTP id q18-20020a6b7112000000b006e2bf38165fmr14987290iog.1.1671048240538;
        Wed, 14 Dec 2022 12:04:00 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q25-20020a05663810d900b0038437cba721sm2023940jad.7.2022.12.14.12.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 12:03:59 -0800 (PST)
Date:   Wed, 14 Dec 2022 15:03:58 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/5] ref-filter: factor out "%(foo) does not take
 arguments" errors
Message-ID: <Y5osLpxzGPc8cLjf@nand.local>
References: <Y5n3S7cnD7s/AIRL@coredump.intra.peff.net>
 <Y5n3n7Gp2gKNMln3@coredump.intra.peff.net>
 <Y5opRTGtrpoLsSF6@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5opRTGtrpoLsSF6@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2022 at 02:51:33PM -0500, Taylor Blau wrote:
> On Wed, Dec 14, 2022 at 11:19:43AM -0500, Jeff King wrote:
> > Many atom parsers give the same error message, differing only in the
> > name of the atom. If we use "%s does not take arguments", that should
> > make life easier for translators, as they only need to translate one
> > string. And in doing so, we can easily pull it into a helper function to
> > make sure they are all using the exact same string.
> >
> > I've added a basic test here for %(HEAD), just to make sure this code is
> > exercised at all in the test suite. We could cover each such atom, but
> > the effort-to-reward ratio of trying to maintain an exhaustive list
> > doesn't seem worth it.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> >  ref-filter.c            | 16 +++++++++++-----
> >  t/t6300-for-each-ref.sh |  6 ++++++
> >  2 files changed, 17 insertions(+), 5 deletions(-)
> >
> > diff --git a/ref-filter.c b/ref-filter.c
> > index 08ac5f886e..639b18ab36 100644
> > --- a/ref-filter.c
> > +++ b/ref-filter.c
> > @@ -228,6 +228,12 @@ static int strbuf_addf_ret(struct strbuf *sb, int ret, const char *fmt, ...)
> >  	return ret;
> >  }
> >
> > +static int err_no_arg(struct strbuf *sb, const char *name)
> > +{
> > +	strbuf_addf(sb, _("%%(%s) does not take arguments"), name);
> > +	return -1;
> > +}
> > +
>
> Why introduce such a function? strbuf_addf_ret() already takes a format
> string with additional vargs, so it should suffice to replace existing
> calls with:
>
>   return strbuf_addf_ret(err, -1, _("%%(%s) does not take arguments"), "objecttype");
>
> Playing devil's advocate for a moment, I suppose arguments in favor of
> err_no_arg() might be:
>
>   - It does not require callers to repeat the translation key each time.
>   - It requires fewer characters to call.
>
> So I think either is fine, though it might be cleaner to implement
> err_no_arg() in terms of strbuf_addf_ret() like:
>
>   static int err_no_arg(struct strbuf *sb, const char *name)
>   {
>     return strbuf_addf_ret(sb, -1, _("%%(%s) does not take arguments"), name);
>   }

Ah, the later patches make it clear why you pulled this into its own
function. Perhaps a blurb in the patch message along the lines of: "this
doesn't need to live in its own function, but doing so will make a
subsequent change much easier" would be helpful, but I don't think it's
a big deal.

Thanks,
Taylor
