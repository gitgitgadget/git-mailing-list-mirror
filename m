Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807681F5617
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 10:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760215; cv=none; b=cPL4lLWNhpfbCsEz7XqHHL1w2mVs9vqtBWU82t3VY6IdU3G4s3b/qaMp+gXRmgEaopEgHhYZMl+9lbMyeDancZEHQwyAT3afEqP8iZBXCM+xPU1pxH4jUWA7MYyqy20IcnLssERJZkbWC5Ttr1PHkjJfgBqLaJg98DFHByWdi/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760215; c=relaxed/simple;
	bh=lVgkEIcd3rA0k0GsmZvvhP+5EnYY5zgbmjMJ/AWKrkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1VJF/QQsKyaD9PPmtqAPcNZYzJTsdw5Lp111eYarBD9fKg5YKox/qmaZ1Vej89kbbprtTEOTXbVT4+f36eW/W0YH6yOBPz7xtGqwpjei2cLALXIM7UxqRfRMG0kVe0wnxbRLxj7M79dmuw+eKVAHlp4INJFzUVspQdJ1cyARJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WzUzmaBT; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WzUzmaBT"
Received: (qmail 17753 invoked by uid 109); 24 Jun 2025 10:16:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=lVgkEIcd3rA0k0GsmZvvhP+5EnYY5zgbmjMJ/AWKrkQ=; b=WzUzmaBTyLKE02QYmfX6/AnKxvUAz/k6n51eGDv06nwpsADMD0NV12OQAoyOy9k+z0RXZ1srKD6AYGbymHWC31NIocv1/ripQaDv5kLtXcfI4GH9eXuX+K/uVVo5ukns5n1H/dYloOm0oruml3ppnT4T/CFWvkFnJaIf9sRiCV7Y1pdjK9ZANMuYqzuRuZ1c58O5dTZUwWpvdioluewUPlVybdLdtoHfyLn7/+k5H2eOv0ohYY4qD8HryZazOp0ybMAz9mq3uk5odoSropYun7lCaDC1LMa+hZdnegrwkg3l1fSLIziqHyc5SsrkBr9v0y3ZGgloESEl2Ici6xwJpw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Jun 2025 10:16:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29322 invoked by uid 111); 24 Jun 2025 10:16:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Jun 2025 06:16:57 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Jun 2025 06:16:51 -0400
From: Jeff King <peff@peff.net>
To: Todd Zullinger <tmz@pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/2] test-lib: teach test_seq the -f option
Message-ID: <20250624101651.GC636332@coredump.intra.peff.net>
References: <20250623105516.GA654296@coredump.intra.peff.net>
 <20250623105625.GB654412@coredump.intra.peff.net>
 <aFmOazVXXGpt8bLB@teonanacatl.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aFmOazVXXGpt8bLB@teonanacatl.net>

On Mon, Jun 23, 2025 at 01:27:07PM -0400, Todd Zullinger wrote:

> Is it a sharp edge worth caring about that someone might
> write `test_seq -f 1 5` where we'd pass 1 as the format
> string?
> 
> If so, perhaps a check like this might be sufficient to
> catch it early?
> 
> 	diff --git i/t/test-lib-functions.sh w/t/test-lib-functions.sh
> 	index 8c176f4efc..87b59d5895 100644
> 	--- i/t/test-lib-functions.sh
> 	+++ w/t/test-lib-functions.sh
> 	@@ -1458,6 +1458,10 @@ test_seq () {
> 		case "$1" in
> 		-f)
> 			fmt="$2"
> 	+		case "$fmt" in
> 	+			*%*)	: ;;
> 	+			*)	BUG "no % in -f argument" ;;
> 	+		esac
> 			shift 2
> 			;;
> 		esac
> 
> I don't know whether it's worth the extra code or not.  I
> just wondered about how it would fail in the face of a minor
> typo.  It certainly should cause any test to fail if it were
> to output 1 instead of the intended format string, so it's
> arguably fine as-is.

Hmm, maybe. I notice that "seq" itself does this (though it did surprise
me). I think there it is actually doing the "%" interpolation itself (to
avoid memory errors by feeding arbitrary strings to printf functions),
so it's easy to do.

In our case, we can rely on the shell printf to do something sensible if
fed garbage. And because we're not parsing ourselves, a pattern like you
have above isn't totally accurate (e.g., consider what it would with
"%%d"). But it probably would be enough to catch typos.

It would also disallow:

  test_seq -f "same line" 50

to produce repeated lines, though I don't know how valuable that would
be. So I dunno.

> Adding -f to the usage note above, as Justin suggested might
> help folks avoid making the mistake of cuddling the format
> string against -f, e.g.: -f%d.  That is caught by the
> parameter count check (though perhaps not everyone would
> notice why, thinking they did pass an argument to -f).

If people are going to use "-f%d", I think we'd be better off making it
work than trying to complain about it. But I was hoping we could just
keep things simple and stupid, given the limited audience.

So my inclination is to leave the sharp edges and see if anybody gets
cut, but it's possible that I'm just being lazy.

-Peff
