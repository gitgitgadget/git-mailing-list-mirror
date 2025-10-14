Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDC6307AC4
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 03:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411360; cv=none; b=jl0FaIKxVf9sKMI9jPsxTeQg4xyubV01ij3FRB+c66PeLKytBVJpXCjIGdC5SlJ/JlhQ3Bhm1DzSz2yHFuJPwfK+jwsSqoiL4aoiyuR/5NgjhGld8YRn6tEjs++HDFkK9luhtm1Ak6sPLern5t0WODI7tcuOTJ8eKTVNOaSzWTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411360; c=relaxed/simple;
	bh=LBl8vRnUStOlhf0NryLkEpnO2p46hlNJZMey9ryzN5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGPVXVnfBGqFDmgWfM9t8HeGeANk+u6QioluWd533x9+fkMeDoLHd/ydPvuZ+Cnm4e8zwfR1DBuf9p14HnTtk3qOqfrrLmuxK6yhwM2XaiXWkpZIafBKFtVcEalbzPf7m3Um0xF2yDI995XOelVU06j08idOtifHqWaBrSo39PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ULzyjDRc; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ULzyjDRc"
Received: (qmail 213203 invoked by uid 109); 14 Oct 2025 03:09:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=LBl8vRnUStOlhf0NryLkEpnO2p46hlNJZMey9ryzN5w=; b=ULzyjDRcHwQ0JuFW5P99YvSpbslAIuSt203k8Z1gQ3lz55jNNDxfCOd69zhTzc9atl3jB1sdua0/qiNsggQoj80t56n+Aiz47QZ4jvELGlncUzwzDTslBiyWnjLtjIJe6DeLIcP30UiamDFY18THyuGm+FbdMn+uqnMevkVC+cuo4tbVEumypbUrXRLD4lDVC80usXqKNnzcNv3jefWVGROZM0F+QJVM+18AbcvmT03icoMI+b6HgAa0S6YFI3uQeO8IRF79reNXTBZpU1FOddp+sorsKSvGlK09SatvalVfSm8WbqJcYolDaq6YpjWaoFXaC36XqrinErxAP2TjDQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Oct 2025 03:09:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 343597 invoked by uid 111); 14 Oct 2025 03:09:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Oct 2025 23:09:15 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 13 Oct 2025 23:09:15 -0400
From: Jeff King <peff@peff.net>
To: Sruteesh Kumar <sruteesh.oss@protonmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] match_pathname(): give fnmatch one char of prefix context
Message-ID: <20251014030915.GA1652717@coredump.intra.peff.net>
References: <n_EjA_jj-d398XOogazunHfOBdh-yoa5P-Prb3b7gjkBODqWMtvKNdhnCLuikthwVcbEy4-ryWTRgyuiShJ3tam93j8S7lmGSlyFjNoxzSo=@protonmail.com>
 <20251014003404.GC1507@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251014003404.GC1507@coredump.intra.peff.net>

On Mon, Oct 13, 2025 at 08:34:04PM -0400, Jeff King wrote:

> On Fri, Oct 10, 2025 at 02:57:07PM +0000, Sruteesh Kumar wrote:
> 
> > Look at the first scenario in the above link. Git is matching the path
> > foobar with the pattern foo**/bar which is against the git's official
> > documentation (Look at the last point in the double asterisk section
> > at the URL https://git-scm.com/docs/gitignore#_pattern_format). 
> > 
> > Is this an issue with the code or the documentation?
> 
> I think the code is buggy. Here's a patch which would fix it, but I've
> marked it as RFC because:

Er, sorry, I forgot to actually mark it as "RFC" in the subject. But
pretend that I did. ;)

-Peff
