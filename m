Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345BEECB
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 00:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705711900; cv=none; b=Z9qGczpgU09/bKKJKB3tY63oAUTGuKscgPwwj+UwnfTXF7unDdH22/6iM/DEgRhgvemgHs/r7VHYdQULForqs+QncOiLQuzvd54lE79G4gBU+EuSOLWJnkGBL1xKWqjMpTW4hWCn3vGYNxSijDGID0NUrsUyVU3qKqmsztpenkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705711900; c=relaxed/simple;
	bh=nDby4LwHwy6MChbDts3uBLFJjwnxhxe4uC8HGmpJMxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LG6RKvIO0AsVQktFISWZhHW6X4LV1GYjGvNdERuCttY6cVRlsZ8opaCEIxVKzKoMHp/TBEXu4KBc6W+RSnqCsSmj6yPDCMSd3HlbaHKGIAbQAdIOd9VZ5GXEfWAGEvODRod9oJL94f7kuNDHGwoaT4jZQGIV+gOrAWs3Wapl+iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 425 invoked by uid 109); 20 Jan 2024 00:51:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 20 Jan 2024 00:51:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6536 invoked by uid 111); 20 Jan 2024 00:51:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Jan 2024 19:51:38 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 19 Jan 2024 19:51:36 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 0/4] Strengthen fsck checks for submodule URLs
Message-ID: <20240120005136.GB117170@coredump.intra.peff.net>
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
 <pull.1635.v2.git.1705542918.gitgitgadget@gmail.com>
 <xmqqmst2sdn0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmst2sdn0.fsf@gitster.g>

On Thu, Jan 18, 2024 at 10:24:51AM -0800, Junio C Hamano wrote:

> >  * Patch 1 moves 'check_submodule_url()' to a public location so that it can
> >    be used outside of 'fsck.c'.
> >  * Patch 2 removes the obsolete/never-used code in 'test-tool submodule
> >    check-name' handling names provided on the command line.
> >  * Patch 3 adds a 'check-url' mode to 'test-tool submodule', calling the
> >    now-public 'check_submodule_url()' method on a given URL, and adds new
> >    tests checking valid and invalid submodule URLs.
> >  * Patch 4 replaces the 'credential_from_url_gently()' check with
> >    'url_normalize()' followed by 'url_decode()' and an explicit check for
> >    newlines (to preserve the newline handling added in 07259e74ec1 (fsck:
> >    detect gitmodules URLs with embedded newlines, 2020-03-11)).
> 
> Nicely done.  I'll wait for a few days to see if anybody else has
> reaction but after reading the patches myself, my inclination is to
> suggest merging it to 'next'.

It all looks good to me to go to 'next'.

After simplifying the input handling in patch 2, I probably would not
have bothered with the abstracted interface in patch 3 (and instead just
repeated the few lines of boilerplate, since there's so much already).
Mostly just because function pointers in C often make reading and
debugging more annoying. But I don't think it's a very big deal either
way in this instance.

-Peff
