Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF34C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 19:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239282AbiLNTyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 14:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239073AbiLNTxc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 14:53:32 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE412B273
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 11:51:35 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id y3so5518575ilq.0
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 11:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u6XZACKuHYO6I+tOuUQWe89odRD0gSU5+zX036gDerg=;
        b=kKYCpHUuiqLv+MwS5dZhhXsiFGhfCc8aGjXCOJEcxOKMn3qz5KsiOyaHPoNXaVyhG0
         wGCCyZQw20NX+F/3Fe4ysLUaDoXBRgpudNuxPxdnHGtI4PjZNWL1FxMGIa1FJ/hscIMZ
         PZpS0klFeFmCjeuYsRQ/dAXgSF7P1UUTCePQ0/tpEXEQPGwEYCLUDnGcQSJojABBaYmC
         md9kys7SPTmnzIGG3V0Y8K1gEk73w5gtYo1K9ThRpfv43T6mwXbAgNxN3mSUxTu9L2R/
         bjXRVKy3b91ha8WHjKKgkg1scWmK6eAsElgN7mivb2cDNrZUgNNz32VMRWwmecNwA1wn
         l1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6XZACKuHYO6I+tOuUQWe89odRD0gSU5+zX036gDerg=;
        b=Mb0qHWzqSIjPXuE46KGRns4WkhJzJsuh6lxyLCvzu8rrRLdp7DNck67jrPrHqDgpZ5
         qrs87cGPmRBzUkakxZ9h2VNy4UnV4sTA7g1Uy0Pu8AIc8M28rNYpnscosI1T4kqLMhZs
         GO/ly6cKQatp3mTcxJbTMGh0oBZ83UufOQmlowZQjd+yBUbHvaGVT0sdk6VGHL0zc7DM
         7xavKObVNN0vV7el2kgzj5W8Ejceqple8C1u0oL5iTnwZzqKlG3AQHnpHjULZ2Fws3nO
         kicxAwKasM1zxVrx4J3aYb+mA9yYLMUtAqFzLhZJ0dTlihKWfpJuaa0kn6wrZWYKF/qb
         JEBA==
X-Gm-Message-State: ANoB5pkilNZLaRQLlpuDPzhJL89crV9exnnwu5v3KKevHA0U95s3Z5ks
        nlOiYparS1WzuCLUgYWFL7r6rjTHgxDs3Mou
X-Google-Smtp-Source: AA0mqf5rKn8jdMHgzZIPaDYoRpT3Mqhl6Nz4W8fTXYqoebgI1AvAw2tyQu5B2tzLMuWbWSCOMOuAug==
X-Received: by 2002:a05:6e02:486:b0:303:8ffb:9345 with SMTP id b6-20020a056e02048600b003038ffb9345mr13098929ils.17.1671047494624;
        Wed, 14 Dec 2022 11:51:34 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x4-20020a056e020f0400b0030341bffab8sm4792552ilj.31.2022.12.14.11.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 11:51:34 -0800 (PST)
Date:   Wed, 14 Dec 2022 14:51:33 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/5] ref-filter: factor out "%(foo) does not take
 arguments" errors
Message-ID: <Y5opRTGtrpoLsSF6@nand.local>
References: <Y5n3S7cnD7s/AIRL@coredump.intra.peff.net>
 <Y5n3n7Gp2gKNMln3@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5n3n7Gp2gKNMln3@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2022 at 11:19:43AM -0500, Jeff King wrote:
> Many atom parsers give the same error message, differing only in the
> name of the atom. If we use "%s does not take arguments", that should
> make life easier for translators, as they only need to translate one
> string. And in doing so, we can easily pull it into a helper function to
> make sure they are all using the exact same string.
>
> I've added a basic test here for %(HEAD), just to make sure this code is
> exercised at all in the test suite. We could cover each such atom, but
> the effort-to-reward ratio of trying to maintain an exhaustive list
> doesn't seem worth it.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  ref-filter.c            | 16 +++++++++++-----
>  t/t6300-for-each-ref.sh |  6 ++++++
>  2 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 08ac5f886e..639b18ab36 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -228,6 +228,12 @@ static int strbuf_addf_ret(struct strbuf *sb, int ret, const char *fmt, ...)
>  	return ret;
>  }
>
> +static int err_no_arg(struct strbuf *sb, const char *name)
> +{
> +	strbuf_addf(sb, _("%%(%s) does not take arguments"), name);
> +	return -1;
> +}
> +

Why introduce such a function? strbuf_addf_ret() already takes a format
string with additional vargs, so it should suffice to replace existing
calls with:

  return strbuf_addf_ret(err, -1, _("%%(%s) does not take arguments"), "objecttype");

Playing devil's advocate for a moment, I suppose arguments in favor of
err_no_arg() might be:

  - It does not require callers to repeat the translation key each time.
  - It requires fewer characters to call.

So I think either is fine, though it might be cleaner to implement
err_no_arg() in terms of strbuf_addf_ret() like:

  static int err_no_arg(struct strbuf *sb, const char *name)
  {
    return strbuf_addf_ret(sb, -1, _("%%(%s) does not take arguments"), name);
  }

Thanks,
Taylor
