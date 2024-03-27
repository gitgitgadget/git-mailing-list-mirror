Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E322C850
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 07:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525625; cv=none; b=CoSDNizjUAWdeQ9qOSOMAMZmLURUG8WWnqLcA7GpfpvJm4H9lx1Ea92chvkiXSwycpGi217p2fEJGgwtIy2uaPWZWc/NgpQ5NNOokBInHM664RZcvgjKiCp+hosyGEtihPcyrs0w51NXdzRqE1m5AHgNJ1FLNtkBzXib+7poGfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525625; c=relaxed/simple;
	bh=6DKfkwO0LofFTdcufzfZjSn+ecBtTDPpfCkLpT1LakY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K66P+HYRNWFlQKLD481yJWx/vfIr8CC+avzLQIDbZ033xRNAi5yH5FxK09k70nrDaJXAH5rntp4XCwOyH4l0GTYI+L3J7h3y235g4zlYn8WJD6oT2D9LMnRD+g7Q1YlLppwFBKCNz7DzJEg8EaXKjbpU9J/xDJ+kDicsK7hBP/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19842 invoked by uid 109); 27 Mar 2024 07:46:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Mar 2024 07:46:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24083 invoked by uid 111); 27 Mar 2024 07:47:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Mar 2024 03:47:00 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 27 Mar 2024 03:46:55 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Dragan Simic <dsimic@manjaro.org>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH v2 16/16] config: allow multi-byte core.commentChar
Message-ID: <20240327074655.GA831122@coredump.intra.peff.net>
References: <20240312091013.GA95442@coredump.intra.peff.net>
 <20240312091750.GP95609@coredump.intra.peff.net>
 <0426f7bf-6032-4fc7-886c-c4278c6e105b@app.fastmail.com>
 <20240315055944.GB1741107@coredump.intra.peff.net>
 <6be335ed-8598-406c-b535-2e58554b00e9@app.fastmail.com>
 <20240315081041.GA1753560@coredump.intra.peff.net>
 <xmqq8r247igg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8r247igg.fsf@gitster.g>

On Tue, Mar 26, 2024 at 03:10:23PM -0700, Junio C Hamano wrote:

> It has been 10 days since this discussion petered out.

I wrote the last message, so I was waiting for you to respond. ;)

  https://lore.kernel.org/git/20240316055013.GA32145@coredump.intra.peff.net/

> My preference is to introduce core.commentString to avoid confusion
> coming from an older Git using the first-byte of a multi-byte
> string, or dying upon reading a configuration file meant for a newer
> Git, and then let core.commentString override core.commentChar, but
> I would prefer to see the discussion participants to raise their
> opinions and reach a conclusion.

OK. I don't have a strong opinion. Are you OK with core.commentString as
a strict synonym (so last-one-wins and either name overwrites previous)?
Or do you want an override (i.e., commentString always overrides
commentChar, regardless of order). I think it's mostly academic, and the
strict synonym version is much easier to implement.

-Peff
