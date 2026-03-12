Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC1B264A86
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 23:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773359912; cv=none; b=a9rGY2mHVbg9qwyeaAvKgOxnaJ5RLH3wkq9J2oHkcPCYpcneWSscCHGcob6BwZBeP1K227pyVeAGR+uTklZnuMFuut9xz6qPI3moR+QW/43Q0CbA4cAIidh05fwFXYzzxSJfzbPKtgcJ/2gUWfp4AIUq0siFiAJdrWOdybOc4I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773359912; c=relaxed/simple;
	bh=8dt17S0zT2FSsGhv+7+vymjFAr3gUy4nztLZeQ7Ppzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDPW6kziOlVtRqwKxqecLKjFavvq13wyUu72aB8na2bn+YH+qchwebe/P1ilH1jKcZHZQF+YCJxotNepCNGbp0GB2cumLN6lT4bjX6R0aVh7MlhZ+Abb99RnDxp4XSuvbTKuMnQ+znz4cE7kV+h9q9sLjmLImiVtELWCEq7zC98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=G/9kSt82; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="G/9kSt82"
Received: (qmail 94172 invoked by uid 106); 12 Mar 2026 23:58:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=8dt17S0zT2FSsGhv+7+vymjFAr3gUy4nztLZeQ7Ppzw=; b=G/9kSt826Y5UxZipQ4dZ/+DavX+wd+4EFT/9L0XXunyan3ZdGAVytsDyC2XVzSFBXtRC1hZeuLsOB5BWgItuolw1+dywbEyELmxDsiIQUmTZUMVw8FLpV/5fOM31f5lTFdU406n/JrnaIOz7FCzrrQahqCgvnWdkO5+9GLLwEgyZ+N9/dweXVF5UiudAFiWPeKgjE4Ou4LiL57KHI2rPFNuRDVm3SpraknyOMimmI6ehChLDLTNlYhpgfG8O8SRSOp/E8PECtO9qOg+1UvlAgENHyZvaUYcEIc4jWhLFXY1138sJhWBsTbRGmG57guc+HXe2Lb5ugsy2lqpmslJl/w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Mar 2026 23:58:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 517220 invoked by uid 111); 12 Mar 2026 23:58:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Mar 2026 19:58:31 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 12 Mar 2026 19:58:28 -0400
From: Jeff King <peff@peff.net>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net,
	christian.couder@gmail.com, ps@pks.im, gitster@pobox.com
Subject: Re: [PATCH v5 3/3] fast-import: add mode to sign commits with
 invalid signatures
Message-ID: <20260312235828.GA3193385@coredump.intra.peff.net>
References: <20260311173147.2336432-1-jltobler@gmail.com>
 <20260312192228.481134-1-jltobler@gmail.com>
 <20260312192228.481134-4-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260312192228.481134-4-jltobler@gmail.com>

On Thu, Mar 12, 2026 at 02:22:28PM -0500, Justin Tobler wrote:

> +test_expect_success GPGSSH "sign invalid commit with explicit keyid" '
>  	rm -rf new &&
>  	git init new &&

This test is failing on Windows in GitHub's CI.

You can't see it from the context, but the next line of this test is:

	git fast-export --signed-commits=verbatim openpgp-signing >output &&

But the openpgp-signing branch will only have been created if the GPG
prereq is set. Should this be referencing ssh-signing instead? Or should
it be using GPG,GPGSSH as prereqs?

-Peff
