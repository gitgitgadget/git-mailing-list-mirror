Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54D029D260
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 22:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776204231; cv=none; b=KOyOfiJWSrOtq5FtYpwkx2s184IgbthunDehIGPblJoKsJ1qNSkfMUZKsWrwujqWr/iQwlltIyE+WywhdqMSKLyhspTVTiwfH/Bz52pA6Fn7qpYn2nx90V3NfntNfkOJ/8w0APmrKNEszujAwgjXNwKsPA+0dZhp/gcpNR6U7sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776204231; c=relaxed/simple;
	bh=4KKYmdKvrheJe2kAmdqniYowYNhqYr4IUfFzmcoPZwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1JW/u3hH00+EW4wU8EuTrAhd44FDu2X3IBXAFE2+KbxnKKh/09CaTKawYTR1nvOx/rYaF84MsKg88RVZIyFMWrmX1JDgjYi7KrVYb9ksK/z8WNXFHCvrZyHABI8xKKV3KBA7xgUgi6YxLl34GwR/1ih4mR1sh2SrTJB0IVkSX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VTK8Le2c; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VTK8Le2c"
Received: (qmail 350653 invoked by uid 106); 14 Apr 2026 22:03:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=4KKYmdKvrheJe2kAmdqniYowYNhqYr4IUfFzmcoPZwY=; b=VTK8Le2cDUlegEV56jS3xpsQTlg0EbPnPPAsDKxWh/BUsbxnYiOhW0NsP20Io3vuqPdvQJ5w3pDdp3vaf6NaVSCPWmxa/xbwdQuA7L85dGQojd0BTsiVxEAk6BuJSWsPpA3u53Oh6Y+PTPiJ9i75BLucUzs6f8R0dLVDwMZbAkpnte+7Fkrw+yaZAX985NzLtuFYCQZnRBKo7+GCIEhINsuiU49xqfcmRt84vrSMRU5Tj4hUuCpw/Td8m1/ve5TONVD0egbxrtmgr9s5nTpFyxX0nbsx6gmEBObUTe6YMbWmf4lMTezCXyW4hZXcuRcZ5nt8ov7nvZSQBSNBIK0VJA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Apr 2026 22:03:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 586807 invoked by uid 111); 14 Apr 2026 22:03:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Apr 2026 18:03:47 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Apr 2026 18:03:47 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 06/12] t: prepare execution of potentially failing
 commands for `set -e`
Message-ID: <20260414220347.GA3475127@coredump.intra.peff.net>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
 <20260413-b4-pks-tests-with-set-e-v1-6-5b83763a0e84@pks.im>
 <xmqqeckifq59.fsf@gitster.g>
 <xmqq340yfivf.fsf@gitster.g>
 <ad3rgbgadjIZRgaz@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad3rgbgadjIZRgaz@pks.im>

On Tue, Apr 14, 2026 at 09:23:45AM +0200, Patrick Steinhardt wrote:

> diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
> index 32814e75df..3acb58125b 100755
> --- a/t/t9501-gitweb-standalone-http-status.sh
> +++ b/t/t9501-gitweb-standalone-http-status.sh
> @@ -15,12 +15,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
>  . ./lib-gitweb.sh
>  
> -#
>  # Gitweb only provides the functionality tested by the 'modification times'
>  # tests if it can access a date parser from one of these modules:
> -#
> -perl -MHTTP::Date -e 0 >/dev/null 2>&1 && test_set_prereq DATE_PARSER
> -perl -MTime::ParseDate -e 0 >/dev/null 2>&1 && test_set_prereq DATE_PARSER
> +test_lazy_prereq DATE_PARSER '
> +	perl -MHTTP::Date -e 0 ||
> +	perl -MTime::ParseDate -e 0
> +'

Maybe I am being dense, but I don't see how the original would have
problems with "set -e". The perl command is on the left-hand side of an
&&, so "set -e" will be suppressed.

-Peff
