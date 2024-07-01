Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D9014388B
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 18:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858922; cv=none; b=rRX6s8T21NaUk01DzWRl8tRf+wnhjiSvhwayf52840BSYDpEbBHbOnS0iNzTzqhJs8ffuc2grxX4+dzNZqeNl8iOfW6e93xe0QH8d6HFVKSYRxudDkUb/Zcs+iEJp85CftuewLXT6D8Kh8jjzu3QXGnxI4pfso8mxFDlRFXlSvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858922; c=relaxed/simple;
	bh=6JnDyVaEUjIRaalzIU/xuD2RI+Za5mWIg2/EGwptYsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Afx1H+ChxNrCmZyDNABaZV1c+LG1BMyc3iem4AK7QJAfyGvPT3BZ9fIFa5h8f0CqWZauGPk4sWmFiweNe4wtdPLnMxnKpU/NSpDr1MiJqNouz8cwwhh37eBPnyzIHY6vqxq5VznpQtbPEOry0hoAJKOcxTsv9pvlE7dQHtr81JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 25538 invoked by uid 109); 1 Jul 2024 18:35:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Jul 2024 18:35:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15008 invoked by uid 111); 1 Jul 2024 18:35:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Jul 2024 14:35:15 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 1 Jul 2024 14:35:15 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Jonathan Nieder <jrnieder@gmail.com>, limin <1159309551xcz@gmail.com>,
	git@vger.kernel.org
Subject: Re: Git remote origin leaks user access token
Message-ID: <20240701183515.GF3199@coredump.intra.peff.net>
References: <CALFtjBBvk+JPmU_GzrnM=ANwaQDdiLtzh4YkZFbcVENyCu9fxA@mail.gmail.com>
 <ZoKW-yDJMsz9JPSI@google.com>
 <ZoLY_yxpQBjmp8O3@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZoLY_yxpQBjmp8O3@tapette.crustytoothpaste.net>

On Mon, Jul 01, 2024 at 04:27:43PM +0000, brian m. carlson wrote:

> I do want to point out that several people, not just me, have worked
> together to make using a credential helper as easy and robust as
> possible.  I mention this not to contradict Jonathan, who I think is
> also trying to help in this regard, but mostly to mention that as a
> project we've been trying to gently nudge people into doing the more
> secure thing.  If people have further suggestions on how to make this
> easier for users in the future, I'm very eager to hear them.

One thing we could do is refuse to store credentials in plaintext
config. That helps people who aren't aware of the recommendations you
mentioned end up more secure (though at the expense of convenience, as
subsequent fetches won't work if you don't have a credential helper set
up).

Some old discussion and possible patches here if anybody wants to pick
up the topic:

  https://lore.kernel.org/git/nycvar.QRO.7.76.6.1905172121130.46@tvgsbejvaqbjf.bet/

-Peff
