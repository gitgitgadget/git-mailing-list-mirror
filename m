Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4188B823DD
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 04:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773377908; cv=none; b=EaJgxHaOslFAdW7kDibgJaSzzVm0uv9nTkLbaKOmBYZnffx+cnkfDYfI0SW3uTKj0s1wco1IQ/4zchLdfpgAU6YuKynviBWvBluYfLNdK3feLVGtzbgZEbGP5ndUn2l46+RthSTYWa1XJHn7SlTnNcuJ+YqECqKXfsju2IcLVpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773377908; c=relaxed/simple;
	bh=qy/733bFhIdvRR8/JG2BsOeVu+qV13kbJKhkd8zbbao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZR8KHskbS8t1t0aDnxozRsSv6dcQHUcUpyhXJR97BefnPH0Jz4pbRajpH2ozm1enTOLeocC8Sv3HMX4Rjn1GF7d5LONdzBXzZCgSTwPHi2jG/FQJBGrLj2cM/96HhRLPVLxtSq0gC/k/8uXW45+vAiQo4b3eF3XcmpdgMs4nf8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CpST8VVt; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CpST8VVt"
Received: (qmail 97764 invoked by uid 106); 13 Mar 2026 04:58:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=qy/733bFhIdvRR8/JG2BsOeVu+qV13kbJKhkd8zbbao=; b=CpST8VVtkK5FeDIjF2T+0NOSu//49STx3HdFL1Ruh4sFl1anshK/Sh32r+jCF5GChw19YYfxkxOs5tie3bmmphHBuLcWjoHY3XdZ1c8ligGs102/Mf5AGD+MQWWFPtlaUVZeKS2563sb81Kkqvk9Wa6d0SB2bhvISKHDupudvjmFWl1I6NVEaOcXfPuThA6QVJfJKFIfr1MFWZ7hI/lJ1wCrtdJqKaMhmi7cPnKb9MsW33dHzvAa/yXXeh/n/BugmcmTiUvBlH+JGxBawM3dA/eHgLwmKwwC1kS9ROxnFpIiUc5jKleqaguN2b5rkdsB3H/Xx1xRrYSNr8XV5FAARQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 13 Mar 2026 04:58:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 520424 invoked by uid 111); 13 Mar 2026 04:58:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Mar 2026 00:58:29 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 13 Mar 2026 00:58:25 -0400
From: Jeff King <peff@peff.net>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
	pushkarkumarsingh1970@gmail.com, christian.couder@gmail.com,
	karthik.188@gmail.com
Subject: Re: [PATCH v2] t0410: modernize delete_object helper
Message-ID: <20260313045825.GC3753825@coredump.intra.peff.net>
References: <20260312125030.7799-1-r.siddharth.shrimali@gmail.com>
 <20260313025852.30010-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260313025852.30010-1-r.siddharth.shrimali@gmail.com>

On Fri, Mar 13, 2026 at 08:28:52AM +0530, Siddharth Shrimali wrote:

>  delete_object () {
> -	rm $1/.git/objects/$(echo $2 | sed -e 's|^..|&/|')
> +	local repo=$1
> +	local obj=$2
> +	local path="$repo/.git/objects/$(test_oid_to_path "$obj")" &&
> +	rm "$path"

You'll need to write these first two with extra quotes, like:

  local repo="$1"
  local obj="$2"

It is fine without the quotes on most shells, but there are some
historical versions that need it (broken dash, according to
CodingGuidelines?).

This will be caught by "make test", which runs our
check-non-portable-shell script. But that's not run if you're just doing
a one-shot ./0410 invocation.

-Peff
