Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE70E285041
	for <git@vger.kernel.org>; Sat, 11 Apr 2026 19:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775934465; cv=none; b=fMFQczAH0eZ2ysm266vOaHYUuhNcEMGsphkWfn3Q2ObIPmppXJF/im5K8zj1jWgwTrALLExd1guvxVxxct0y7WLwBFnJdQ4/KHnDHF+QpgyRiAAF9cDgOPaNeiqnrRLYYyowZmNIsxkB0rfHAkcRh4zmGb+fRc4x5yrZaYszTL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775934465; c=relaxed/simple;
	bh=xdqw3tJBxVVXRdN69Di/t6PF1z6g2BjP2WizEwgBzxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeQZ9pv4MpLeD6rmY62NQJ3X62C2nJlJx6x42WSPS2vJaYLclQqFoxQS3juwn6D/s1fEUC3uSoyryNGSKQGBoo+bHtFzjkQV/L3YoYtDeOLnAZmirDDQo4FBQPV9Jk4K22mdo1WrtqO77UEwGW0aHfdHggpSqj0Ttd4Triz1gkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ahRSWDlG; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ahRSWDlG"
Received: (qmail 317885 invoked by uid 106); 11 Apr 2026 19:07:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=xdqw3tJBxVVXRdN69Di/t6PF1z6g2BjP2WizEwgBzxM=; b=ahRSWDlG4TNZYouO7JMgHI0iTk3YbY87a3kH4x2LHF9AciLJldCd1irfqHu47yo8i51Dy67PRhjkA1ylAaGjhg3FeIkGxVmnVGFCwxWLmgySpq4/zvUq9ZESavxshC0LJyp5+yVss2JKUNyMVmOS+FHZK+bJp4JbcysVw0z3H6TTJgZ/8tqLLWm1aG8EUXr4iW6DK4rvwg72FW5fDgQ7QT1tIRN1uebJfSVIu2GW0i0FctkDUyGEAsgAZntU4RU0oeDuU3Ue17ua1o9Hx+dkoUyIB5H4lIcZdRsJNMv8rVDwUYYwpVqo5PYGAsjXSfE/9ltecVf0i5KNMd+kfmPENQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Apr 2026 19:07:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 525166 invoked by uid 111); 11 Apr 2026 19:07:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 11 Apr 2026 15:07:42 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 11 Apr 2026 15:07:41 -0400
From: Jeff King <peff@peff.net>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Chris Torek <chris.torek@gmail.com>,
	Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v9 4/4] checkout: -m (--merge) uses autostash when
 switching branches
Message-ID: <20260411190741.GA754996@coredump.intra.peff.net>
References: <pull.2234.v8.git.git.1775762235.gitgitgadget@gmail.com>
 <pull.2234.v9.git.git.1775854874.gitgitgadget@gmail.com>
 <00e0b3196cd158244cb15bfd7edb7d9d3f0954a2.1775854874.git.gitgitgadget@gmail.com>
 <20260411183823.GA672575@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260411183823.GA672575@coredump.intra.peff.net>

On Sat, Apr 11, 2026 at 02:38:23PM -0400, Jeff King wrote:

> Our enforcement of these rules has some holes, but I have a local series
> to fix that (which is how I noticed the problem). The entry continues to
> list some exceptions:
> 
>   There are some irregular refs in the root of the hierarchy that do not
>   match these rules. The following list is exhaustive and shall not be
>   extended in the future:
> 
>     •   AUTO_MERGE
> 
>     •   BISECT_EXPECTED_REV
> 
>     •   NOTES_MERGE_PARTIAL
> 
>     •   NOTES_MERGE_REF
> 
>     •   MERGE_AUTOSTASH
> 
> We can add CHECKOUT_AUTOSTASH to the list of exceptions, but I wonder if
> there is another name we could use that would conform to the usual
> rules.

Actually, I misread the documentation I quoted as "list is not
exhaustive". ;) So we would be violating its promise to add
CHECKOUT_AUTOSTASH to the list.

-Peff
