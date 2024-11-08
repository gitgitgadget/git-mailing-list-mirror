Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA1C1E260C
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731086607; cv=none; b=k129uZl2BlOjV1BC8590SCWKUr/yd6tbJwU1F8mWWfH9Bgs3RKkaZ4h6CIadvP+EEyabn7j/oNf4m7uJobF9L75kjPFxlSc1JE2wR/7wgHXqEQafPOjIrSAP1DVaxUW0FxL/mp69ynTmi/EXVixQDPJYQt52gPgXujeys3r6my0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731086607; c=relaxed/simple;
	bh=pdoUdqGFE8h520wSPnSbArtDyd1WpCO9Y7VVpkibw4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBUInyL3CFutoM87pHupcRWeGI28cKJK+cIldKcuDznoocGxXAcPijP5hjeBBNs868vvhCgDmOIWXpWjcaNa2rXQa949jgcXu0qZPE4VQcWxMIhyy0hatwxebTjLYfvI3kn9ulTJPkLw2m+E0o7NL4FotSYsYV4ZDI0gKPWZmHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MLFeoMR6; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MLFeoMR6"
Received: (qmail 13778 invoked by uid 109); 8 Nov 2024 17:23:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=pdoUdqGFE8h520wSPnSbArtDyd1WpCO9Y7VVpkibw4w=; b=MLFeoMR63n/ASoRQfmbdrSSDdcZr9QlpPSFPLEa3kJJEN/zxIxvT7b2PK3P3urtcN2girDe5u1ilIUHV8MjdAQUl/324KBTmZhvLhesW99lM7FQgBcJZikLSkGUpPIbrb0nRHHaDBbDd1qy4y5hJYslmXYnrnPQHI+MW/seDRT7hiLoEdSzJYOLX6v8ZKBtmtSLZEzjZAK6S6Q/j981KiETipxPi1yhI0sS4qmLq6vjE1Z75ouIUlIMzsn2Sc1YqXZGsL2aD1cT4HsOZdkl80GBGnVTH7D2mqfHux0bx90mbXhEtpbAUTmHuETaXxHDTSxVdvQFQ/w44DHjyAbFN+A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 08 Nov 2024 17:23:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29990 invoked by uid 111); 8 Nov 2024 17:23:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 Nov 2024 12:23:23 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 8 Nov 2024 12:23:23 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] t/helper/test-tool: implement 'sha1-unsafe' helper
Message-ID: <20241108172323.GC548990@coredump.intra.peff.net>
References: <cover.1730833506.git.me@ttaylorr.com>
 <20241107014737.GB961214@coredump.intra.peff.net>
 <ZywgZt419SfPUVkQ@tapette.crustytoothpaste.net>
 <Zy0yRLt5dM554yq1@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zy0yRLt5dM554yq1@nand.local>

On Thu, Nov 07, 2024 at 04:33:56PM -0500, Taylor Blau wrote:

> >   # Compute and append pack trailer to "$1"
> >   pack_trailer () {
> >   	test-tool $(test_oid algo) -b <"$1" >trailer.tmp &&
> >   	cat trailer.tmp >>"$1" &&
> >   	rm -f trailer.tmp
> >   }
> 
> Nice find. I think that it may be worth writing this as:
> 
>     case "$(test_oid algo)" in
>     sha1)
>         test-tool sha1 -b <"$1" >trailer.tmp
>         ;;
>     sha256)
>         test-tool sha256 -b <"$1" >trailer.tmp
>         ;;
>     *)
>         echo >&2 "unknown algorithm: $(test_oid algo)"
>         exit 1
>         ;;
>     esac

If it were "test-tool hash --algo=$(test_oid algo)", then presumably
test-tool would naturally do the same switch and error message
internally.

-Peff
