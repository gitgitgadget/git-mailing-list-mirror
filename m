Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FBC379EDF
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 03:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783483173; cv=none; b=s8/luV5IGtrcyZnPc/PoYOGBuBag8mfpDwYRywYLBuIuiUEsjgT0c2HJIxgSp4rf7V2CtnDTmSEHIfWB/5v2yq+1r1ejljnkT39ufKKe1nolU47/ejnvvzrVlM8IKRDZG1UlKL3jk1S+GcEVZc0Kx5VCJM3seQc37k5jnPV0Xvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783483173; c=relaxed/simple;
	bh=k8w3z6cvVEQoDDhlNVNgaQJUGyDpMrFVCFQGflF2GhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aT/Ps5fn5TbhMtG7Wppqy0xCN9A43qO2bbiBSpvdDKKZWWID0sxOjS+GVamC3jpWrUoyZ08/JnBa8LL4gS7g6hSUeGFLv9miaZN3GxNuhU5X76pqWI0XkGi7cIunQqsY4lOZdDUw0NYa1ajPniuCFISKkq8NsaOEBmDL1vLIm+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bYjkDcOc; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bYjkDcOc"
Received: (qmail 25566 invoked by uid 106); 8 Jul 2026 03:59:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=k8w3z6cvVEQoDDhlNVNgaQJUGyDpMrFVCFQGflF2GhI=; b=bYjkDcOcpabWXj6DgVllV8uKhvGs1nbqNWIlZOe5sy6V9Xm7dNROlrrJj7L+ML7TYcJQz9yBeKRK3Vn/CwoykRYDmUolVqOcIMGfkqV2A4SUuTKWLBS581DtC/QVoyDMR+nBffrG+Mczpf9rb5zIiPkDoWp6Oso4AciYi6ufrwrUMaHQeOPXqOCOa88OIaMRlwhWt1flhtQyFucCGH/ImUgO1H3lEZ8/vuGe2Psv0EAzwG2tygUKjLjBluUcpTE7UWgFGhyeE3cP8qGOjYQpvdUjLfQRXzMpmZ06kMVPOYGGbWwXK7+p+xDovKjpNG9p2LY9VOuy7ECzeRqgyWYfvQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Jul 2026 03:59:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 41132 invoked by uid 111); 8 Jul 2026 03:59:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jul 2026 23:59:31 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Jul 2026 23:59:30 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/4] parseopt: exit 0 on help
Message-ID: <20260708035930.GB41684@coredump.intra.peff.net>
References: <20260701212442.1430084-1-sandals@crustytoothpaste.net>
 <20260708001557.3581080-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260708001557.3581080-1-sandals@crustytoothpaste.net>

On Wed, Jul 08, 2026 at 12:15:53AM +0000, brian m. carlson wrote:

> Changes since v2:
> 
> * Fix inverted condition in t1517.
> * Stop checking for old versions of SVN Perl libraries since they are
>   so old nobody is using them.
> * Adjust the various cases where we choose between the error and
>   non-error help output.

Thanks, I have no complaints on this version.

In the earlier thread I sketched out a hypothetical caller that might be
affected by the change, but beyond raw speculation, I don't think we
have any way of knowing how common such a thing is. So I'm inclined to
proceed and see if anybody screams during this development cycle.

-Peff
