Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DB8258CD5
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558006; cv=none; b=swWyvCTsduvaEfLlFciToE4YA8IGTnQSYDJZw2PPLPg94Y98ACRFt51FwEEvbacxFphtD+Ub62XKvRw3T+oBZ+Cy/KQ7dc+3tgASRoD0yXBnuXrv3ITKowOJNbQEH0o+R6vJUwjypHP1orR5Ok4LbvFHco7WJxsIELDOUGO8NoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558006; c=relaxed/simple;
	bh=cTvBQJS8Eb7Ad9ndCn1xakpN6DK+rskdsmEuIJJCbAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdWK4cJ9NHGOPOQqM/yBrobWaleUI3UiUzMSjmw0E0fdgDeVYNgPyUl9+pIdPewJThZFrggedOk2JBLiKyJmwKLBnZJsES36h2z2JCUL16jeiTh5LzrSLBszi1BtBIJOF8rRh2YpwtmvanavbrGc19DDcI8WHFQi4gH7a4VildA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZaOEUFk1; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZaOEUFk1"
Received: (qmail 6341 invoked by uid 109); 26 Feb 2025 08:20:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=cTvBQJS8Eb7Ad9ndCn1xakpN6DK+rskdsmEuIJJCbAE=; b=ZaOEUFk1Sr2bLureFZ+Kmu187y8yEP8s+TapulzMtFrP1wHwfhVwn7N9VAwoDYNuUU3QodepOBCZ4p+x5Z2Mz9UZfl1KFHfHRzU8ka/Bwe6rNYNZBJ3eB7ov76pzYOkkJsnnrKHfZ3nL5RuqLq3erqoY89+Kmmaqp9Xvu2HWHiLNvuqE9DENohlzxatHofFpxIN+0okRbggSoGKEkbH+xKHF2Isoq8dBWERKgwRc/fdDG+FNB0doNBSnxAlVwI0O63E/HQiEIvJugA8xZSp8SFdhZqffs1cM+ksEpO1p9Mi+8j1LQMQ9uYYxaCM4IuyjyKbX4BVlLNm4c0KGx5kmcA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Feb 2025 08:20:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21981 invoked by uid 111); 26 Feb 2025 08:20:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Feb 2025 03:20:03 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 26 Feb 2025 03:20:02 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: win+Meson test failures due to ps/build-meson-fixes-0130 topic?
Message-ID: <20250226082002.GA30633@coredump.intra.peff.net>
References: <xmqqo6ypiz9w.fsf@gitster.g>
 <Z76qYgV7B2eUJHiP@pks.im>
 <Z77EJRJwPDGUglLk@pks.im>
 <20250226074653.GA27455@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226074653.GA27455@coredump.intra.peff.net>

On Wed, Feb 26, 2025 at 02:46:53AM -0500, Jeff King wrote:

> I'd imagine that if I did a complete "rm -rf build && meson setup build"
> it would work. But it's pretty lousy to have to do that preemptively
> during a bisection.

Looks like this runs even deeper. On my Linux machine:

  $ git checkout origin/next
  $ meson setup build
  [...ok...]
  $ meson compile -C build
  [...ok...]

  $ git checkout origin/master
  $ meson compile -C build
  [...]
  ../meson.build:215:35: ERROR: The `!=` operator of array does not accept objects of type str ()
  FAILED: build.ninja
  /usr/bin/meson --internal regenerate /home/peff/compile/git .
  ninja: error: rebuilding 'build.ninja': subcommand failed

  $ rm -rf build
  $ meson setup build
  $ meson compile -C build
  [...ok again...]

I'm hoping you can tell me I'm holding it wrong, and there's some way to
do an incremental build when crossing these sorts of boundaries (without
blowing away all of the build products).

I do at least use ccache which makes the "rm -rf" case a little less
painful.

-Peff
