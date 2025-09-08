Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D3218872A
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346715; cv=none; b=hty/IFdKZj27QCJZSs2uqV7Nz/cBsFQDOG++1ZOCLcuoMV8esBfE37514RiSOxkJ4PyvS2/Qj7Fd/BXIAdY22P3Ib/0HFbpEKDDwMWJ8xQUuJgIpKY+Pd2P4SVrgjZTpJXgMoUSeZAleuPaFJwPWsChQLOlDG2Uqx06Ute0GmD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346715; c=relaxed/simple;
	bh=SOkGct4WfG4Vln9cbKrPBh6sBSy2hXd6XMnoe5ymZls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8G7/wD6hVsATNfg8K+HD5DEBybmzG1H2XLjn42TKtwyYopBb+YFDSMKYfsvXtZE81LfIQ1caXUgeSUNY+TmhkPWRSaZxB7MKCqrTG3fXrDkgM5Fv+WIGeJ41cHSJX7xKQskf9g3IOK0Gw1Ae/oDpSF+I/WIg8VCTpTRa1VGgx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BOv1STDj; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BOv1STDj"
Received: (qmail 21259 invoked by uid 109); 8 Sep 2025 15:51:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=SOkGct4WfG4Vln9cbKrPBh6sBSy2hXd6XMnoe5ymZls=; b=BOv1STDjmOpp/5wbgw15F574X3D+CcKUvtkIrvrY1nDUmJmj5tXilFSEbl91B2VbRP8yaSG63vUl6SiHracBc/eVadI73tLNV8ScSfEUcT7XEhMt4ZGAt7h5uN/ToRxOUjmPJvhaPuKbu0AyU1IbzLmaopcuhjvKWuITLTuMXLPfXpRKaFrzwNBBziX9HOeSwSegVR71aRWBYHDlp6rqz7lNz+P4oAnZMzU26BSjEn40VS6cK7UsY4cxBL4/6/yCTvjzj+E17DR780kOlyxkawvaED84DLjWQIgBKVASNPCyYTvO8IPCjo1UKs9qwUykWGfWl4DeS72BF5BZpseDQw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Sep 2025 15:51:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 34461 invoked by uid 111); 8 Sep 2025 15:51:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Sep 2025 11:51:47 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Sep 2025 11:51:46 -0400
From: Jeff King <peff@peff.net>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 07/10] submodule: error out if gitdir name is too long
Message-ID: <20250908155146.GA1308482@coredump.intra.peff.net>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-8-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250908140117.262205-8-adrian.ratiu@collabora.com>

On Mon, Sep 08, 2025 at 05:01:14PM +0300, Adrian Ratiu wrote:

> Encoding submodule names increases their name size, so there is an
> increased risk to hit the max filename length in the gitdir path.
> (the likelihood is still rather small, so it's an acceptable risk)
> 
> This gitdir file-name-too-long corner case can be be addressed in
> multiple ways, including sharding or trimming, however for now, just
> add the portable logic (suggested by Peff) to detect the corner case
> then error out to avoid comitting to a specific policy (or policies).

Thanks, the compat logic here looks reasonable to me.

As somebody who has not really been looking into or thought about the
topic at all, though, I wondered how necessary pathconf() is here. That
is, I can imagine two alternatives:

 - just try to use the path, and we either get an error from
   open()/mkdir() or we don't. This would end up with roughly the same
   outcome as the current code which calls die(), though it would not
   help with eventually fulfilling your TODO.

 - set some arbitrary but sane limit (say, 255?). That would make the
   behavior consistent across platforms, though it does mean you might
   be prevented from using very long submodule names on systems that
   could support it.

I dunno. Like I said, this is not a problem I thought a lot about, so
feel free to ignore. Mostly I just notice that we have lived for 20+
years without pathconf, I think mostly by following the philosophy of
the first bullet point above.

-Peff
