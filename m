Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577388F7D
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754123223; cv=none; b=Q858nw/sab5mXF4Ppv4z0JL3wrXDPITHSZuiFw2ogzvpTx2u/HnestuF791y80DfQfmbBClGsE6RkwZVYmZJCDKZUi6aJJM/pTYNcoFqT6K+B4BFq+FyEkNrfsS/hZFuo32CpPsK6+3E8qzPzaLfODfNlj8BGogDOAJ2ursaEyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754123223; c=relaxed/simple;
	bh=wPuVFYElUBi+RJmoE8+PsQXZxGW26UK3TZ28aCKWUws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bofFDdH1VKGPkYdT35U9JsgMjrW43BIy5pYKRBg5u88/MwDeKc4FUpyejUj6GyjkxY68WrgRy/BmcekX1fLMLW57stuKwYhmirdAPyK4yJBhYg2nyvoiZjVKW6lW3ayEe9K2T1FN4BOCaS8v19DnveCjou6SAO0NV8AADvNGNck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VjVMJclD; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VjVMJclD"
Received: (qmail 8602 invoked by uid 109); 2 Aug 2025 08:27:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=wPuVFYElUBi+RJmoE8+PsQXZxGW26UK3TZ28aCKWUws=; b=VjVMJclDYii4dO1gGoquCgGhfTKXWvdFadhCNx1brzMRalbKPPg00+0tYijQ3bZvMHHo9xSzbr87lORDzB/XEMGWhq3D0pjNqC7zsZwAwHULop+GPQi/Swvc5QW4mqqPwQQR/4siTaZfjz+HDhmobQyF+CJ1HOuuo/guZsWyZU0+0D/JllBfdqtXYQef6Va3RQhiikD+fAvb70gRGxGvm0FyOSVYQTXkbXKslNR7o7Ylf1rmjw9RtEi2ZyIAgRXrOwH6Y77ORgSqbbrdUt0TjIdWzPB6ykkvNegKq0FW79ISpfB53TCntwrvnFDCyWY1MuXluQ4fmvnDlTnUlYxcDA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 02 Aug 2025 08:27:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10594 invoked by uid 111); 2 Aug 2025 08:27:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 02 Aug 2025 04:27:04 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 2 Aug 2025 04:26:59 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 4/7] string-list: optionally trim string pieces split
 by string_list_split*()
Message-ID: <20250802082659.GB3711639@coredump.intra.peff.net>
References: <20250731224607.3942417-1-gitster@pobox.com>
 <20250801220423.1230969-1-gitster@pobox.com>
 <20250801220423.1230969-5-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250801220423.1230969-5-gitster@pobox.com>

On Fri, Aug 01, 2025 at 03:04:20PM -0700, Junio C Hamano wrote:

> +/* flag bits for split_f and split_in_place_f functions */
> +enum {
> +	/* trim() resulting string piece before adding it to the list */
> +	STRING_LIST_SPLIT_TRIM = (1 << 0),
> +};

It might be worth defining here what "trim" means. I can think of two
obvious definitions:

  1. trim whitespace from each split piece

  2. trim excess delimiters from each split piece (which in turn depends
     on how we handle multiple delimiters; do we make empty pieces, or
     do we collapse them? I think the former, which would make this type
     of trimming impossible?).

It looks like the patch does (1).

-Peff
