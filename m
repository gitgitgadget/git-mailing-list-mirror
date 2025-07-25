Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F01F184E
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 04:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753417855; cv=none; b=E/zs1PlRHOo1UTcDGVO38OSx9luq55sDHAGetwFBcBESdUjq0rC/SRka8EkdtT/Df3pKIZXr/asb5OsrE/WhZQSn2GlaSA5SohpWanZgULHo8q0mycWtwfTv3tWFB4satJWgZQwECBCfaO21fxbPvw7M5btDrZyaADdokr/YSzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753417855; c=relaxed/simple;
	bh=WWOWfHXDv/pk7yZQB/guOwemamfYY1NQm+gHmBF0gnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1RoPAykWMVpn6ef7CyP0YGRCmFR1zogshQN6kFCVi1YFP9vamtrTc+pUEneL7hvtiuon6WxsPTU2YX2ZsoHk0h4B+fSAtVefDKr6AmErJnlOhMI54xSiefX2QCtoLln26TGZO1tmqvgh3Jti9AVW1sratSrqksTOfhf38KM8eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fviKfPCy; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fviKfPCy"
Received: (qmail 23636 invoked by uid 109); 25 Jul 2025 04:30:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=WWOWfHXDv/pk7yZQB/guOwemamfYY1NQm+gHmBF0gnA=; b=fviKfPCym+3z4lVXXSMhD6tJMT3adDlKCkNYWKZ0XWj+lrssJVJ2+2lfS0cvuOZxFIxy4Kxg2PKiA4xRlotb76Neh4VXGWX67axkKLVtQqQrf4ktzgJnnRTOEGMGXRRPeyTMRQpJ08EzFSvFlyn2rsMkGVfEiJNR3ax1EyzQQcvgsJUh28+0Fxrns8qUB87UaJ8VwgYJsUzt68lsmLbhjeUWIxDoJQfZ6N/YdDQieyNlGxlShVFkWyav1U4QQhP1AFvowEP0hwqbCDNrYhWpr2JVB9jSEWASwgzLQeXlIkLpORtCMKjxrqOiSnkKQckAivZQfq4a+VSwZcK20Yq33A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Jul 2025 04:30:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15466 invoked by uid 111); 25 Jul 2025 04:30:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Jul 2025 00:30:47 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 25 Jul 2025 00:30:43 -0400
From: Jeff King <peff@peff.net>
To: Jonas =?utf-8?Q?Brandst=C3=B6tter?= <jonas.brandstoetter@gmx.at>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] t7510: add test cases for non-absolute gpg program
Message-ID: <20250725043043.GA3002998@coredump.intra.peff.net>
References: <20250711232348.460804-1-jonas.brandstoetter@gmx.at>
 <20250722190922.51183-3-jonas.brandstoetter@gmx.at>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250722190922.51183-3-jonas.brandstoetter@gmx.at>

On Tue, Jul 22, 2025 at 09:09:22PM +0200, Jonas Brandstötter wrote:

>  	test_must_fail env LET_GPG_PROGRAM_FAIL=1 \
>  	git commit -S --allow-empty -m must-fail 2>err &&
> -	grep zOMG err
> +	grep zOMG err &&
> +
> +	# `gpg.program` starts with `~`, the path should be interpreted to be relative to `$HOME`
> +	test_config gpg.program "~/fake-gpg" &&
> +	env HOME="$(pwd)" \
> +	git commit -S --allow-empty -m signed-commit &&
> +
> +	# `gpg.program` does not specify an absolute path, it should find a program in `$PATH`
> +	test_config gpg.program "fake-gpg" &&
> +	env PATH="$(pwd):$PATH" \
> +	git commit -S --allow-empty -m signed-commit

This second test seems to fail on Windows. E.g., in this CI job:

  https://github.com/git/git/actions/runs/16509422831/job/46688307091

Right before the failure, the trace shows that we are setting PATH like
this:

  ++env 'PATH=D:/a/git/git/t/trash directory.t7510-signed-commit:/d/a/git/git:/d/a/git/git/t/helper:/c/Users/runneradmin/path:/mingw64/bin:/usr/bin/:/usr/bin/core_perl:/c/WINDOWS/system32:/c/WINDOWS:/c/WINDOWS/System32/Wbem'

Should it be "/d/a/git/git/..." instead of "D:/a/git/git/..."? Which we
could get by using $PWD, I think.

The earlier one using $HOME uses D:/, but this one is different because
colons are meaningful separators in $PATH.

-Peff
