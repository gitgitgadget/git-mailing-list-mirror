Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3D429C325
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 23:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759359646; cv=none; b=hBJGJPeHTxVvhBGgLT3PxUd1XJhr+38d5AXP2btX+KFlukx/DajKtVCWHd4l2jH+hyjsyBD9AgS8giv58RPLfS8jMPGv7AjU/tKb2frhzSZp0ewkaKItFX96Wv9O+3tubRLUaua8sVtlI6geD1VppwU9tJVcnD9mGS5i0L2Gdhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759359646; c=relaxed/simple;
	bh=3u96eCtB4h7V90NnxBPzf9OYZasCDbbns8nTdr+bUn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6VxKuU6O5njbBCuXorjJ0YXneA8ZEd8WOHhJpvecfwRC+FgUVPib74bd1XNnrH+ooN8gQyQrA1so/JUeNB91xkiiygvQudXP3Pi4qxOTvgOoJq3akrW6ciBFS2cF4efOOPr2Y6k8N37Ax/hAKnQJGImQKy/uqkxOc94YGdKNL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Pl0fQ75B; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Pl0fQ75B"
Received: (qmail 99078 invoked by uid 109); 1 Oct 2025 23:00:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3u96eCtB4h7V90NnxBPzf9OYZasCDbbns8nTdr+bUn8=; b=Pl0fQ75Bl24UNAe4XT8e3beEhbQOzoBjDar3Yf/SeGEkLGDA0TbtcjxjYZX7fFDzpWfrrAyM2G2V1bjVu3VcUKPKSXVjoY02YntyJ673ZREZteqvnrcdFcTCTON1dM61udbHKWlwoZSqQ2Hsp/lUIQLEQkmQSDgL4aNLTyAa4VfhUhyza02ZKxDwBTFEBS4R5akNgv6GnkXgWihe0AmDjgS4T8bVC3vTX7fSpeIu+XsV6t6K+HczRV38DdgK9+U/UppcqlH3p7iMRBnUO9hwbMcWXcF7wzV9bxsvHisxE9t5AEZR/6Cp93X50I3xtNhWHqA27PIqFypSq3VIXIsWtg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Oct 2025 23:00:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 142136 invoked by uid 1000); 1 Oct 2025 23:00:43 -0000
Date: Wed, 1 Oct 2025 19:00:43 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] Define an extended tree format
Message-ID: <20251001230043.GB142037@peff.net>
References: <20251001005814.846992-1-sandals@crustytoothpaste.net>
 <20251001005814.846992-2-sandals@crustytoothpaste.net>
 <20251001174110.GA137600@peff.net>
 <20251001211140.GA140550@peff.net>
 <aN2g-RCLVuUYD7h2@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aN2g-RCLVuUYD7h2@fruit.crustytoothpaste.net>

On Wed, Oct 01, 2025 at 09:45:29PM +0000, brian m. carlson wrote:

> > Of course that is strictly worse for somebody who is relying on the
> > current accidental behavior. ;) And in the long run, I think this is the
> > spot we'd want to hook to do whatever massaging we need (whether
> > converting to the equivalent in-repo algorithm, or hacking up the name
> > to store the foreign hash).
> 
> I think sending in this patch is a good first step right now.  The
> intention of the transition document is that the code is in one and only
> one hash algorithm at a time and it would be better to reject this case
> until we're ready to wire it up correctly than end up with data that's
> corrupt down the line.

OK. I'll try to clean it up and add some tests, but it may not be until
next week.

-Peff
