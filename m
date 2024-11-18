Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001B32907
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731920807; cv=none; b=nSR0aH7ECrpxarEhPLutuqKyTWBoLnxfcpMr90Fn3DrO2OmP8e1XXZyo8jgwBbfZYwMlUGJjULhVRA9NnKCjgR9SENxvF7ki20jTNUe6jkvm+dAA1jYQjBtJq310rmVEZcyxvzmGBkcqBhpN+Ww1pLuOoi4I/JwPjrfiqNQ18q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731920807; c=relaxed/simple;
	bh=UhKSV6l9smi5+Nh/33ILlnmieGfZ1oRMnZ8q0Gm3W0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwdWpINlAHENiKzvSxSZ++06chyxOWH7r4gKC76XpEVX/o1etudJgELowtrQi+73RgToH+IGOfap7l3WHgpwtSir3u9KFvm4HTC3tS8PK5u8b7ZSZDE6+uLsuMKon+2QSAUi2ZC/k7T+HwLg6vW45/PvovqUA63T0hvQdvVpk7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=epEcEPYb; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="epEcEPYb"
Received: (qmail 22069 invoked by uid 109); 18 Nov 2024 09:06:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=UhKSV6l9smi5+Nh/33ILlnmieGfZ1oRMnZ8q0Gm3W0I=; b=epEcEPYbww9bwoeGR5kByvQGB1p23tETzmLkwbPx3PeW5wezNnA6+6gxBESY5xLiEEZzKEzhHT248y4O+rv8If7KOMJTwGUodS983LaWFlOLKSJLmVoYh3+ln6yGGJ+j/gn71YzK2d8+7vPoZqBuXDQdf7uTM21RJtYyBGU2cGids2NUWLvMDd1AXiC5CTvwsIYt1wdXnMMnlOmJNjV7AgQYMKnZitRL9kqTxLUir0dKBzS7sQbch2ojX81oBGJvfgKjfEb3BK0LYQcNR0iU5nMQFLp1SFEhWBqsEezJwCgklBDZ/qetcAkJAXGdyPCIrqWf7z9czRbx/wp8TrxybA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Nov 2024 09:06:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17848 invoked by uid 111); 18 Nov 2024 09:06:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Nov 2024 04:06:38 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 18 Nov 2024 04:06:33 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Sam James <sam@gentoo.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
Subject: Re: [PATCH 1/5] object-file: prefer array-of-bytes initializer for
 hash literals
Message-ID: <20241118090633.GA3984843@coredump.intra.peff.net>
References: <20241117090329.GA2341486@coredump.intra.peff.net>
 <20241117090814.GA3409496@coredump.intra.peff.net>
 <85d78ade-dbf4-4116-836e-a49c33324947@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85d78ade-dbf4-4116-836e-a49c33324947@web.de>

On Sun, Nov 17, 2024 at 10:52:40AM +0100, René Scharfe wrote:

> > -#define EMPTY_BLOB_SHA256_BIN_LITERAL \
> > -	"\x47\x3a\x0f\x4c\x3b\xe8\xa9\x36\x81\xa2" \
> > -	"\x67\xe3\xb1\xe9\xa7\xdc\xda\x11\x85\x43" \
> > -	"\x6f\xe1\x41\xf7\x74\x91\x20\xa3\x03\x72" \
> > -	"\x18\x13"
> > +#define EMPTY_TREE_SHA1_BIN_LITERAL { \
> > +	 0x4b, 0x82, 0x5d, 0xc6, 0x42, 0xcb, 0x6e, 0xb9, 0xa0, 0x60,  \
> > +	 0xe5, 0x4b, 0xf8, 0xd6, 0x92, 0x88, 0xfb, 0xee, 0x49, 0x04  \
> 
> The added space at the beginning looks seems unintended.

That was from the original, which had a tab followed by a space (maybe
to line up with the "E" in "EMPTY"?). I did s/"// and s/\\x\(..\)/0x\1, /
which left it.

> The two spaces before the backslash look odd.  One space, one tab or
> lining up the backslashes with spaces would look better.

This one is my fault, though. My regex left an extra comma at the end,
which I somehow managed to bungle removing. ;)

> Patch 5 does away with those spaces, thankfully. :)

Yep. Looks like there might be some whitespace oddities left over,
though, so I'll fix this on re-roll.

Thanks.

-Peff
