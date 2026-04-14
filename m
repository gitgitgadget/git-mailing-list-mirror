Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52D833ADAF
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 06:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776147829; cv=none; b=s9WuoNMIeNqeJT5uhgp73Q2PGwdWRusOkPDosg8HQ6I8AR2T4vUFqtg7f2awpvC4Peckk/m3Jg5EwXLX80NnmBC6mIQBBtEIl9+XkbDOPRhzxc/TNEmGWeJ1kqvulauAAuizxxEj2TZT/l5w/qWYIISOt1aEGvCr2wIrFhPnLkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776147829; c=relaxed/simple;
	bh=tkOy+cfAkmJr9JA5ztndCPd6mqSlJtL8MIywIF95Vds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVCzdIh9cjXTDAPUcsZhn/5ondFRcSr0HI/EM0rH4OoKTJOnsBVb5HdkK7q1VSrPkz2qaEoYYrBavo4JAiWsJX/VGeCjZab3yrDpnXa83kY+V+5e4OAB9jLl7tn7zLnEl0qPZdoeoznEdRxHjl0LCSxmcTB2rJcwK5QmRQefJSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RXhAE2ut; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RXhAE2ut"
Received: (qmail 342925 invoked by uid 106); 14 Apr 2026 06:23:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=tkOy+cfAkmJr9JA5ztndCPd6mqSlJtL8MIywIF95Vds=; b=RXhAE2utKFbkGIpF0T23WwCqbrujo6eJmFf17CaW/9cDA/lcPY5THFsIQxMTicZhnnsVeGo8rRr7/4CcberVexq4gv0ZNPhXTbRjhr4HL5kCqoOxrpzZkCnFUSogFj0/qOoaTSHGznfQiV1xhCbAE43bmZwkgZXq1/pCu4SkDTxE5Sk5xxx6NbweAqBk1/1tCv+dhfT+u4/k23SL/W6ZZagEVzyFILvXKQXKGsmAN6dfIhOwlRjq+IQQWJAgmbiKUT47f/IDxnuyIUpGse0CCK8Dvx8wMTOKSARQn+Bt3eednBpX9hAhDBeMI8en+mjkou4ahBE/y7hjlEpcNN7OOA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Apr 2026 06:23:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 573369 invoked by uid 111); 14 Apr 2026 06:23:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Apr 2026 02:23:46 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Apr 2026 02:23:45 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/12] t: prepare `test_must_fail ()` for `set -e`
Message-ID: <20260414062345.GA2902286@coredump.intra.peff.net>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
 <20260413-b4-pks-tests-with-set-e-v1-2-5b83763a0e84@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260413-b4-pks-tests-with-set-e-v1-2-5b83763a0e84@pks.im>

On Mon, Apr 13, 2026 at 11:49:23AM +0200, Patrick Steinhardt wrote:

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index f3af10fb7e..f8bc77619b 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1195,8 +1195,12 @@ test_must_fail () {
>  		echo >&7 "test_must_fail: only 'git' is allowed: $*"
>  		return 1
>  	fi
> -	"$@" 2>&7
> -	exit_code=$?
> +	if "$@" 2>&7
> +	then
> +		exit_code=0
> +	else
> +		exit_code=$?
> +	fi

One subtle interaction here is that the command in "$@" will be run with
"set -e" suppressed if it's a shell function (even if the body
explicitly says "set -e").

I think it's mostly academic since we don't tend to use "set -e" in the
tests at all, but it may be an eventual gotcha.

-Peff
