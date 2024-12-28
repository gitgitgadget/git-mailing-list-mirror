Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1959B2744D
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 19:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735412911; cv=none; b=ErBGjFIhtu7rxsqUUJ/Vhu6gHDHoplrVFNRDnLmF2Oc5q6nXT+R7xZ4RGReRCqMgqO7uT/6eJhGN86wt5ovEghYnWZvbj01eQ6mMMhHspIk1Z1DvvEQzGGEmvXElRR58O0x1Bww8kCYYKlXZAQZKFJuoPI8qZ7IBLADF4HH7q8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735412911; c=relaxed/simple;
	bh=vds+psJ2hCf3BCJh7LreCIVjI/tVGJp5XSrr3I5ZBSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PapwNqbfFPe4s4YrL5zrc3IoNL/9OO/kwbBLvqz94vGG/FE4w/XTTQzwJGwGZsdMMMK8jYgid23226rsOcHM1Y/jVRmkV+Lr35zeBcJNBPc2jFQAjyrR56Uae5iIApMxHLMKiMGw6E+JfvNjbsPYjiETDHL3vnDLiSFCghswGzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ej34NgU0; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ej34NgU0"
Received: (qmail 24577 invoked by uid 109); 28 Dec 2024 19:08:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=vds+psJ2hCf3BCJh7LreCIVjI/tVGJp5XSrr3I5ZBSo=; b=Ej34NgU0uB/euESS+GSwvliIjlq5spJYcYK+AmDHfUjwrNqHSrV3x9oqKnQTjAums+g7vd3ly5611XN70AfaIvwPffgjOUrkf2TZT6df19RGQJrDDFrUIjoIDcNFpUpfcZiTortSHnk9Shen1JX71Uj7049aVw9BLBwMDg+an81AUjpZYQRC9kT8z25i/80NpBhmZmXxxtV1YMReZEfPpV2P+r8hymHc5w56Px4G702ZstmtBqhnjhdJGEv5xE4ZJ+qvfTIpBiiGRY8YZwBt3wLJpj30Qj7kBSV97tpIWL45k4cgsUUE+Ql/dEFYUl1iINFNLuQuE5YJ2n406ft80w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 28 Dec 2024 19:08:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29978 invoked by uid 111); 28 Dec 2024 19:08:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 28 Dec 2024 14:08:27 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 28 Dec 2024 14:08:27 -0500
From: Jeff King <peff@peff.net>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: crstml@libero.it, git@vger.kernel.org
Subject: Re: connecting the local main branch to the remote origin/main
 without pushing
Message-ID: <20241228190827.GB815586@coredump.intra.peff.net>
References: <a69c4e2e-cbb0-c242-a34a-8997a84fefb7@libero.it>
 <87h66nk9uy.fsf@igel.home>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h66nk9uy.fsf@igel.home>

On Sat, Dec 28, 2024 at 06:15:01PM +0100, Andreas Schwab wrote:

> On Dez 28 2024, crstml@libero.it wrote:
> 
> > My question is:
> >      Is it possible when applying the method 2 to have (without pushing)
> >      the local main branch connected to the remote origin/main branch as
> >      in the case of method 1 which by cloning connects these branches.
> 
> You can establish the effect by setting two config entries:
> 
> $ git config branch.main.remote origin
> $ git config branch.main.merge refs/heads/main

Also:

  git branch --set-upstream-to=origin/main main

(sets the same config variables, but maybe a little more ergonomic).

-Peff
