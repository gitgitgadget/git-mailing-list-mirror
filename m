Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BFF258CCB
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 08:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740557346; cv=none; b=CR6rXkWs9QrzMC6sTuQ80Z0hCoNthHWvj3IGugY9U8UUe/G2KHY2cxfjbOIwxZ+khsuubEdifi+sgJ+SWh45tr9PAYjL3vaTlSJ/YfKxdkHFcDiHbY8Ehps+4RWdU+KhxxFHUW99hXtzPw7VlKFZKSwpy/tOH8a+Kf7kYBNgXI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740557346; c=relaxed/simple;
	bh=wFrTaZHDSXUymTSchvhowP4RRtB5Pig7qEPr1U8ZN2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pO4LSOt+0yUkICPrZ9d2o8UjxV6JomwTKlQqZvSNAT2QN53++b9qqQs1cMNEVpNEWwoBNJgAZMY64dCJJbi7ro3HAvcv792za4aYL1Qo/0/xEK9AiQBTQsTE/83g5O5kb6yyn6+REMpdBf93zeUzkazZE/mHnq7jlCHPxWSdeNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Z2CaVXXp; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Z2CaVXXp"
Received: (qmail 6243 invoked by uid 109); 26 Feb 2025 08:09:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=wFrTaZHDSXUymTSchvhowP4RRtB5Pig7qEPr1U8ZN2U=; b=Z2CaVXXpeGWKve3gCK6SDVIGqHA4sYCOk9VZoY9mLTjVD7ll6o1peNX0A+8aUqxFRmB4hLhVuQhMW2KZF/7J18q1MbqCZk9pAJ6CwmvOmNXcMQVAlR8Pk5ZZxhY4BYWyhm8CPYE5JksuqIr3Z093mswh6OSZDvUh2EfYekGuS5kQZaNvw9bqqpmdgXUy+yLi4xGy7Jp9WPQB9nE4/66ejbg++lKKOwWSjUjhuaFZhuwk8FDY7cUKByemQ5iEsnPTB/N56PYPEp13x0Ertq+BrRvwpZc4IlR++AaTTYN2FNOg6E6zBfiYubW4Qc+II5doHJNwgx3mSd0Do3U2yu6//Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Feb 2025 08:09:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21422 invoked by uid 111); 26 Feb 2025 08:09:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Feb 2025 03:09:03 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 26 Feb 2025 03:09:02 -0500
From: Jeff King <peff@peff.net>
To: Yaakov Smith <Yaakov.Smith@wisetechglobal.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: \b character escapes in CLI usage
Message-ID: <20250226080902.GA29996@coredump.intra.peff.net>
References: <SYBPR01MB579278DD5EC6E13CA9A213FDE2C32@SYBPR01MB5792.ausprd01.prod.outlook.com>
 <20250226073822.GA21138@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226073822.GA21138@coredump.intra.peff.net>

On Wed, Feb 26, 2025 at 02:38:23AM -0500, Jeff King wrote:

> I wonder if we should consider adding "U" to the default $LESS variable
> we set.

Having tried this for 5 minutes, the answer is a resounding "no". It
also treats tabs as control characters, making source code diffs rather
ugly. ;)

In modern versions of less you can get around it with:

  LESS="-U --proc-tab"

or:

  LESS="--PROC-BACKSPACE"

but those are new in less 632, from the last year or two. So I don't
think we can rely on it in our default variable, but people with recent
versions of less should consider setting it.

Looks like it was added for exactly this case:

  https://github.com/gwsw/less/issues/335

-Peff
