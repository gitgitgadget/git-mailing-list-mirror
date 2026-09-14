Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFB848D879
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789405147; cv=none; b=fLpU0yxyL813DQSRwSNF8x+Zrm167q/ZughjbXBH5yBRkH2gTwg2CGgVqJBPrS9NZlI2xqQghxfA3Ubqs+ZKJv2Z0IjBDjYVwLh9HaNqq1A0RtdJy2Vpyl9uIkOVQPFoBc1Vi68OcFxWUTfPmvTzHI98ivy2icAvzF8xuJOtC20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789405147; c=relaxed/simple;
	bh=T7k4Jn18dvamYMdlxXAvyzEzZSPUN0zhtOZagtPfOF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8qaCYLbK5Ay9Y/sUVE/k96IAthIG4Rgd6RhaCqzSKI4nLMwOrMbiPsxeJLElOwgYu7UTUDLRSMnKWFCyCE/cFWeF/LWEkiEEVSv4Ej/aB1hyR92T/wrrmLr52OSZXQDHDxQDfQZxPMydDQ1E3GiuZEvg3ne/wvyiVmRyOLd4kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XyaIHHWm; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XyaIHHWm"
Received: (qmail 5757 invoked by uid 106); 14 Sep 2026 16:59:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=T7k4Jn18dvamYMdlxXAvyzEzZSPUN0zhtOZagtPfOF8=; b=XyaIHHWmIZ3FecMy9NfEGHTQFpqlVYJeXNni/HH8Fv0h5GPFIC7PRTedJBSyBNvLH2dhCyLPufiP7yGWsj7JNM6qcAj/job+YwnryvOndHCvShl3hGE6PyuAJiHr31O6AE5r35g9Yxaf+5/VTzcD48Y7TIGPO8yMUTNG6VaCKUhnahHa0MKs60oFqcRXkPDvjHv5x2tLtBgnGyJTEwAoNqYgxKOKiS0LLyh1q3P88py7p9wS8D1ONALLddktr38rCVMmujPQ7Xjdvzz26gs8F7joVg1ByRgmWb5aQUaYIWfDx+JV09IYdeMejyAoLQB6UO1wkOUADUzZ53Hx6pX6Cw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 14 Sep 2026 16:59:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32454 invoked by uid 1000); 14 Sep 2026 16:59:03 -0000
Date: Mon, 14 Sep 2026 12:59:03 -0400
From: Jeff King <peff@peff.net>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: git@vger.kernel.org, Jean Delvare <jdelvare@suse.de>,
  Elijah Newren <newren@gmail.com>,
  Usman Akinyemi <usmanakinyemi202@gmail.com>, Taylor Blau <me@ttaylorr.com>,
  Junio C Hamano <gitster@pobox.com>,
  =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 0/3] merge-ll: Cleanup merge driver temporaries after
Message-ID: <20260914165903.GD32247@peff.net>
References: <20260910150608.1867930-1-mkoutny@suse.com>
 <20260910162242.GC251185@coredump.intra.peff.net>
 <aqQN_Q6ZAeyTy7WA@localhost.localdomain>
 <20260911171044.GA1609692@coredump.intra.peff.net>
 <aqf0fw2igdjsXe-V@localhost.localdomain>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqf0fw2igdjsXe-V@localhost.localdomain>

On Mon, Sep 14, 2026 at 03:23:28PM +0200, Michal Koutný wrote:

> > Hmm. I wonder if leaving the files could actually be a _feature_. If you
> > completed the merge with the external tool but we barfed reading it back
> > in, would it be useful to leave the file in place? It's possible, I
> > suppose, but I think it is more likely to be a nuisance (and we already
> > delete it for things like read() errors, just not anything that would
> > cause us to die()).
> 
> From the user perspective, this is unnecessary. (Potentially useful for
> debugging the merge tool.)
> For the former, the whole merge can retried (after restoring state), the
> latter is quite rare and can be worked around easily when the merge tool is
> under development.

I was more wondering if a user would be frustrated that they spent 30
minutes doing a really complicated merge in the tool, and then that
output was lost. I'd guess it's pretty rare, though.

-Peff
