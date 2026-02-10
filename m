Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D585830BF69
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 22:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770764044; cv=none; b=L8SZKTEyoGsobr2biGw4XuXIuc8kcueIuBcIRbwZoK/fudi/N2V+zXcb65NcySHENHau26ewJCz91S9YqwIESWQrFD68TzRlIrvOXHGbpUxcTnCS/jYXLXEJ1wPVZSl0sJyN47ZVXcsAta6aXzbMrZOU+bR/E+j4B4OYmV0zhho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770764044; c=relaxed/simple;
	bh=RHsv6uN1UfGM7R3Y87+C4Rldd12r4lu19dR4iV+fqnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6iOd8vRGfM5SbqhNS2Ufy/1nOMH8YHGCvoD7QVpxCgDy9fEdm+DArsVKsuJM4ICi2FzR61CTeTGhGPZ98cw78L0kNKhkJjThJwmzRG6u/L18wM6j5Xow/Dhz3bBxZ8Fp0Cmifkw9kMbBwFhyTW/C7wfcZVG0DJZAlEmuZ25xVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Zh5Be2rO; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Zh5Be2rO"
Received: (qmail 6899 invoked by uid 109); 10 Feb 2026 22:54:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=RHsv6uN1UfGM7R3Y87+C4Rldd12r4lu19dR4iV+fqnM=; b=Zh5Be2rOagkOz8jdmERyu2qzHPNdwKACfWSm7PgbvhTr7TBxcZX0srZLehmNbKvB/TLoJGptASONdRu4oAZf4cAt/8r5LPVyHSUZFlPzmVzXS9agNA1hWRo1/z0MMg+Gh+OvuezeyT7/ckc8xl6Jx929wRHQReSnqixgRuzW2/XCEsI4D0qzTkjaXufGJMEjghINzHQSDSwvhKK7meSHlNN5hGbergxzcVFML8yhh2i6q+/GACUNFGlBUKmK+kGEGLGyCGO5wWv4ty7mJ+z8w15TqX2YVW94KK+0wR3V24GHA2wswCvJpACFSTRnNP69BDPxUIKwFolMr4rbm9SgPA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Feb 2026 22:54:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13452 invoked by uid 111); 10 Feb 2026 22:54:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Feb 2026 17:54:04 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 10 Feb 2026 17:54:01 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 3/5] ci: make test slicing consistent across Meson/Make
Message-ID: <20260210225401.GA1837188@coredump.intra.peff.net>
References: <20260209-b4-pks-ci-meson-improvements-v1-0-38444dec4874@pks.im>
 <20260209-b4-pks-ci-meson-improvements-v1-3-38444dec4874@pks.im>
 <xmqqa4xgxn2m.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqa4xgxn2m.fsf@gitster.g>

On Tue, Feb 10, 2026 at 02:15:13PM -0800, Junio C Hamano wrote:

> > diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> > index 2b175dc5c6..1b7a16e1f1 100644
> > --- a/.github/workflows/main.yml
> > +++ b/.github/workflows/main.yml
> > @@ -298,7 +298,7 @@ jobs:
> >          path: build
> >      - name: Test
> >        shell: pwsh
> > -      run: ci/run-test-slice-meson.sh build ${{matrix.nr}} 10
> > +      run: ci/run-test-slice-meson.sh build ${{matrix.nr + 1}} 10
> >      - name: print test failures
> >        if: failure() && env.FAILED_TEST_ARTIFACTS != ''
> >        shell: bash
> 
> Have we successfully run this one?
> 
> I am getting
> 
> Invalid workflow file: .github/workflows/main.yml#L1
> (Line: 153, Col: 12): Unexpected symbol: '+'. Located at position 11
> within expression: matrix.nr + 1, (Line: 301, Col: 12): Unexpected
> symbol: '+'. Located at position 11 within expression: matrix.nr + 1
> 
> https://github.com/orgs/community/discussions/25386 is a 6-year old
> discussion so things may have changed quite a lot, but at least back
> then the claim was
> 
>     Github actions doesn’t support math operations in expressions
>     inside ${{ }}. You could add up these two numbers in bash script and
>     then use set-env command to give its value to an environment
>     variable ...
> 
> though.

Right, that's why we used pwsh syntax to do it before, in d3d6493dcf
(ci: use Meson's new `--slice` option, 2025-07-09).

That went away in 17bd1108ea (ci(windows-meson-test): handle options and
output like other test jobs, 2025-11-18), because the "+1" was added
into the script itself there. It looks like the patch under discussion
removes the +1 from the script, so we'd need to go back to the pwsh
syntax.

-Peff
