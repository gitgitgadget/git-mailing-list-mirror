Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81B6EED626
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 18:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbjIOSiU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 14:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbjIOSiN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 14:38:13 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D651BD3
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 11:38:08 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-59b4ec8d9c1so26300197b3.0
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 11:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1694803088; x=1695407888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LjqZZOeFwnpagnQzpjhoeSOTQfNKzYOB0P6er6EClCM=;
        b=xpt7t5BC0S27PGnayRzLOR7l5L2BMrJVDM1Vhc7PAvYHsFJUdfypbrnPnkK5bN/QAi
         i3oDZ4LvjRQhPYgYgpp5WbiAlSUT3bYps/hbgSo3G3jPvuIhwk4Tx3ZN40s+uXr70tRg
         mjwTfPLQTG6EXNHZvMPtvE7U4vkTmhGwpZIhWPI8e8i1jDYiJFVJlk65AqSu4Co1aHzr
         LrDkv97LIDeIVxtKE7vaWQqFojhnJ4rB+t0MzM4sDqt9V6CQI534nY+m8KrXpDLdIExl
         CMy/e4ABHaFOkNfJsCB4dj3gO4qRPYpiZOzShv76pKBPTiNquMAUFqezNK3XXZEhilgb
         ZMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694803088; x=1695407888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjqZZOeFwnpagnQzpjhoeSOTQfNKzYOB0P6er6EClCM=;
        b=AnXsfUnLgDGlhZav/PmetTZC8eRnTk6ys7qoMTPRWkG5vQK3K4K+iMifasFbMBxgZR
         UFWwGEsAsa8XVLOtGR34sCphSmCeTLttsWm3jRQg+0m0zQMSNuiwfOmqVQKmCkmuLWIs
         NRygBt0YNvIjInKqkx/EekApbRB2rMkoLQmsWvJpBbUob6k7QuI2/ObA0fvCai0CSgvM
         /zJvNacBio5lh6tpTV/Vdxp69DE4wO/vNSr0e9+F3pAhSlbXl/k0DS845uAf79rjKKKE
         P1DT8GRXffkx4g1cqNO+AHdkdxET/kcM1mV1BGcLoSFWsbl8pQDgTCRhVECyopqX32HS
         tL6g==
X-Gm-Message-State: AOJu0YweLCNDGJHgRjnR8Gt74QqON3cSExil5jYYia0gSIf32PrrogkN
        VSAk25KerXuIcCMPYH5bCLtzHx6cMdLfrHO8g0e/AA==
X-Google-Smtp-Source: AGHT+IELiceccVT2wDWR7M6jL2jGqnC9hXqB2Tf+Tt/fPMtIsuKQ3I9wvM6UuMKzc1F/IjEO/Hv7vg==
X-Received: by 2002:a81:4951:0:b0:57a:8ecb:11ad with SMTP id w78-20020a814951000000b0057a8ecb11admr2572924ywa.43.1694803087802;
        Fri, 15 Sep 2023 11:38:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t125-20020a0dd183000000b00597e912e67esm991607ywd.131.2023.09.15.11.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 11:38:07 -0700 (PDT)
Date:   Fri, 15 Sep 2023 14:38:06 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] http: update curl http/2 info matching for curl 8.3.0
Message-ID: <ZQSkjiyrOac4DK8q@nand.local>
References: <20230915113237.GA3531328@coredump.intra.peff.net>
 <20230915113443.GB3531587@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230915113443.GB3531587@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 15, 2023 at 07:34:43AM -0400, Jeff King wrote:
> @@ -751,6 +753,18 @@ static int match_curl_h2_trace(const char *line, const char **out)
>  	    skip_iprefix(line, "h2 [", out))
>  		return 1;
>
> +	/*
> +	 * curl 8.3.0 uses:
> +	 *   [HTTP/2] [<stream-id>] [<header-name>: <header-val>]
> +	 * where <stream-id> is numeric.
> +	 */
> +	if (skip_iprefix(line, "[HTTP/2] [", &p)) {
> +		while (isdigit(*p))
> +			p++;
> +		if (skip_prefix(p, "] [", out))
> +			return 1;
> +	}
> +

This looks good, too, though I do have one question. The HTTP/2
specification in 5.1 says (among other things):

    Streams are identified with an unsigned 31-bit integer. Streams
    initiated by a client MUST use odd-numbered stream identifiers; those
    initiated by the server MUST use even-numbered stream identifiers. A
    stream identifier of zero (0x0) is used for connection control messages;
    the stream identifier of zero cannot be used to establish a new stream.

So the parsing you wrote here makes sense in that we consume digits
between the pair of square brackets enclosing the stream identifier.

But I think we would happily eat a line like:

    [HTTP/2] [] [Secret: xyz]

even lacking a stream identifier. I think that's reasonably OK in
practice, because we're being over-eager in redacting instead of the
other way around. And we're unlikely to see such a line from curl
anyway, so I don't think that it matters.

If you feel otherwise, though, I think something as simple as:

    if (skip_iprefix(line, "[HTTP/2] [", &p)) {
      if (!*p)
        return 0;
      while (isdigit(*p))
        p++;
      if (skip_prefix(p, "] [", out))
        return 1;
    }

would do the trick. I *think* that this would also work:

    if (skip_iprefix(line, "[HTTP/2] [", &p)) {
      do {
        p++;
      } while (isdigit(*p))
      if (skip_prefix(p, "] [", out))
        return 1;
    }

since we know that p is non-NULL, and if it's the end of the line, *p
will be NUL and isdigit(*p) will return 0. But it's arguably less
direct, and requires some extra reasoning, so I have a vague preference
for the former.

But this may all be moot anyway, I don't feel strongly one way or the
other.

Thanks,
Taylor
