Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A14528EF
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730919315; cv=none; b=qCkmE1tj5k8uUUKZfvthKi8J8nTH3gqq6UX0IeEByoMXFK4KRM5+lYKs82U5IzmKlqwHcInxaN4QIZlojAhw7iz6zokkWjFNp+HjRgOnd4ZeIg15IYU85tes43UhVfvPj0e9qxQk/QsQw9RYYX/jcnEA/Z+N00wzzqfK12WZy+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730919315; c=relaxed/simple;
	bh=EQkX0TAqdaVI4MKATIwtPl1s3a7GPlLBKK+qhdtgic4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmA5hadAllj0kvuoUbZAPsCB4uNpWT1+GunnGzzAbv7x5yTBsaxGW8yZNDxMjjxEN5cDbBbD4DOjMZZd7S1E7mrLD6Pm4oAqaBlKD5+rY10DDX4WCWgYUei26Mkb1Rk/pQg8jo9jFEuTgokF0HHaAOLtsH0n9DvmzjobCYtvyGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Wp2ZmwrN; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Wp2ZmwrN"
Received: (qmail 14184 invoked by uid 109); 6 Nov 2024 18:55:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=EQkX0TAqdaVI4MKATIwtPl1s3a7GPlLBKK+qhdtgic4=; b=Wp2ZmwrNHmh0aU6aKFciE2eVHId88/8dPa3jvf/QBfwOh00gH8HINkqQptKjNmk5L7kS+0mT/1OZED8VMn1arM3S40fXi1L10DLthUo+81cMpEpDg/bZsnHMf+nAXAp9NY/p1mpgdEoHJWTj8RJ5bPn8PRyARQUC3fywKTOyTeih2MKUCyzDtCEDYeb5qCUS/pOIjwdN5dqlX6bcNHrmDdlrz3+0nGa2HyikWpn+vjOv4OqpN9Jz1oKhlkFFHMgp0nyxtyztgfc/aj4sR9dx/81wPnPeNFNPtDSuxrRqBLLtp0xBqn4/Pt5P7DoeiNiAvLmg1AbCcjeKpsOS+zfQNg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Nov 2024 18:55:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7121 invoked by uid 111); 6 Nov 2024 18:55:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Nov 2024 13:55:11 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 6 Nov 2024 13:55:11 -0500
From: Jeff King <peff@peff.net>
To: Kousik Sanagavarapu <five231003@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] t6300: values containing ')' are broken in ref formats
Message-ID: <20241106185511.GB880133@coredump.intra.peff.net>
References: <20241105190235.13502-1-five231003@gmail.com>
 <xmqqikt1qhwt.fsf@gitster.g>
 <20241106022552.GA816908@coredump.intra.peff.net>
 <xmqq8qtxqcye.fsf@gitster.g>
 <ZyroYBwtQtgc6NoR@five231003>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZyroYBwtQtgc6NoR@five231003>

On Wed, Nov 06, 2024 at 09:24:08AM +0530, Kousik Sanagavarapu wrote:

> One way to fix this is refactoring the way in which we parse our format
> string.  Although this would mean we would have to do a huge refactoring
> as this step happens very high up in the call chain.
> 
> Therefore, support including parenthesis characters in "<string>" by
> instead giving their hexcode equivalents - as a for-now hack.

So if I understand this is just expanding %<hex> and nothing else? That
seems like the worst of both worlds. Now "%" is magic in these value
strings, breaking compatibility, but we didn't buy ourselves the
flexibility to do arbitrary comparisons like:

  %(if:equals=%(upstream:lstrip=3))%(refname:short)%(then)...

-Peff
