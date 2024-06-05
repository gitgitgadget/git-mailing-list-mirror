Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AE529401
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 08:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717577241; cv=none; b=uvowAEQUg6NqytAmVpcmIDJOPzMrxm7wQOuJmMC+yOY36/TnFTJ0ZeWX+26/BvV/boshLSv6e4STT7BAOuuBSPfkT2XqLKdl6sWdJ7/NJyslocKQb4LVS/5vSrGtPMruIXg4A1LA9ZXNbrOLZmgjWwwioS3ISB/5AMOmePRsATg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717577241; c=relaxed/simple;
	bh=U/LEONykXk50qVoeu4KHKbO4xjixaWLWak4bHYwEON4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BE6ftjo6DbWBCnoGwSlC1ljrTcYaOGobLYsBTjLFXyFjvvnXxc/VzgKdGGfbKVNJkj4ZZrn6DMyxF++EXuaRhSAGqHg7lejCm9U8W0VYBWQVXYD0besM/BWm0C9Y7JBYpnWzDq4vUnAMiDLQH5/Lj1Gka7MCAqZ0LJ5ZAJSR/ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24335 invoked by uid 109); 5 Jun 2024 08:47:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 Jun 2024 08:47:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27983 invoked by uid 111); 5 Jun 2024 08:47:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Jun 2024 04:47:16 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 5 Jun 2024 04:47:18 -0400
From: Jeff King <peff@peff.net>
To: Fred Long <fred_long@fastmail.fm>
Cc: Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com,
	git@vger.kernel.org
Subject: Re: git fetch --prune fails with "fatal: bad object"
Message-ID: <20240605084718.GD2345232@coredump.intra.peff.net>
References: <16919-1717194882-875013@sneakemail.com>
 <xmqqplt1d0k0.fsf@gitster.g>
 <000501dab3b3$51779400$f466bc00$@nexbridge.com>
 <xmqqo78kbqwo.fsf@gitster.g>
 <20240604104437.GD1781455@coredump.intra.peff.net>
 <876fbb07-210e-128e-5289-57ab01761750@fastmail.fm>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <876fbb07-210e-128e-5289-57ab01761750@fastmail.fm>

On Tue, Jun 04, 2024 at 01:09:10PM -0700, Fred Long wrote:

> On 6/4/2024 3:44 AM, Jeff King peff-at-peff.net |git bugs/Example Allow|
> wrote:
> > In the case of a refs/remotes entry where you happen to know that you
> > could re-clone from the other side, it is relatively low stakes. But I
> > think keeping a human brain in the loop between corruption and deletion
> > is a good thing. Corruption should not be happening so often that it's a
> > major pain point.
> In my case it's not corruption. It's people creating branches, deleting
> them, and then removing the commits. (Maybe our git server has an option to
> automatically prune commits that are not reachable from a branch or tag, I
> don't know.) But this happens very frequently at my work.

Your local refs should not point to missing objects, though. Each clone
should maintain its own consistency. Are you using "git clone --shared"
or another scheme involving alternates?

-Peff
