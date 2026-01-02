Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E043415746E
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 07:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767339241; cv=none; b=XeoroSJm8FB3sSdXjLpq4mX5A9zn1r4xDRzpJWOluaH7JCydKqRoNUy5hKYHF+J6CmiEeyNNFuszm0ZGYqHLvRWMdfSK0MiwszowyeM3iOYI2PNq7BYESuO5zy1AO61UBgp1IBjAjkdXLGPddQ5/ctzDrja43+MuwF8wu7SE5Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767339241; c=relaxed/simple;
	bh=+qgzVuS0FH+EecDl8AxAt2UP5/wusAuUTHAzmufsxUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7I4Xpn3vPKJq7VvofoeKemrPxRZqIfGwe5pK7ytIdYYIUBeOTekdUDcBy6kL6RhIAWnQEc9aIv1XbeqMU8nFivg7gdykvE7/Maaa1KUfqabTggXOvDFAbgXNs3LpGQ5XfBkWlvYoZfWuSWPJdcnfrZcK+MXtvHMeZWDklv/nQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XEsNyWv5; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XEsNyWv5"
Received: (qmail 553123 invoked by uid 109); 2 Jan 2026 07:33:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+qgzVuS0FH+EecDl8AxAt2UP5/wusAuUTHAzmufsxUk=; b=XEsNyWv5dBWFMGuh/5bnEQO7cnIU4+G2N982+uXWXs7fx2r+jFNk9VseVL3cMioshjMRsHxT7Zv9RCCUELCSejke4/2xr2P3unZLs+oDFVNJQI/6sWGPAP3J8qxiD11rVfvGMpKOEPDZfL7XqnoHu/WqTWyokLALAf7rMhXrJ66J/F8RCW7/8jwO6OfYROYVL0vML/qRCu1sx16VbndxKM6JE+E3vhLGddH0axYRhFmon881trVoo0DpHBegZ0gUEdp9BMyRABwUrznB4F851Q/zC5J5rM5jZ7Byk2v4r8G+n4RKqov07NAcR2CjAppqnpk3vvt/dIO9fbgB1ZTyBw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 02 Jan 2026 07:33:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 719658 invoked by uid 111); 2 Jan 2026 07:34:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Jan 2026 02:34:02 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 2 Jan 2026 02:33:58 -0500
From: Jeff King <peff@peff.net>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Julien Moutinho <julm@sourcephile.fr>
Subject: Re: [RFC PATCH] builtin/format-patch: print a warning for skipped
 merge commits?
Message-ID: <20260102073358.GC2581074@coredump.intra.peff.net>
References: <20251231034217.2498648-1-asmadeus@codewreck.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251231034217.2498648-1-asmadeus@codewreck.org>

On Wed, Dec 31, 2025 at 12:42:17PM +0900, Dominique Martinet wrote:

> @@ -2274,6 +2273,11 @@ int cmd_format_patch(int argc,
>  		die(_("revision walk setup failed"));
>  	rev.boundary = 1;
>  	while ((commit = get_revision(&rev)) != NULL) {
> +		if (commit->parents->next) {
> +			warning(_("skipped merge commit %s"),
> +				oid_to_hex(&commit->object.oid));
> +			continue;
> +		}

I don't have any thoughts on whether the patch is overall a good
direction or not, but I suspect this line will segfault if we ever see a
root commit. You probably want:

  if (commit->parents && commit->parents->next)

here.

-Peff
