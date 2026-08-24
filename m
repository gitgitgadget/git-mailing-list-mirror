Received: from mta0.migadu.com (out-107.mta0.migadu.com [91.218.175.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9F64052AF
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 12:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787573964; cv=none; b=DyKoMJvGYxWFJTMnLBKDXotd3GFEJ48mOIPA2TFYdPrLFAPAqcZg0qbl00DSF2iBus8ZjbKXbVyL+WbZUrL1ZJtJ9exBk9+fmKlZE6+iUZzsNkQ3izQU3l+/bfY7KdRZuUJHU3bc9hN7rU0+Y+JGiUcbX2S1ThuiF2aIqBVqqRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787573964; c=relaxed/simple;
	bh=vcf27pTdWLew8v9+Rx0bjqG70CtOvBXNxcVelWbQ7SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXCNNz/o8+ZK7DrsMRx+bBLZaGewp2nvsZeFZGumVZHafA7/Go80hYeOk398bYJ5pLiMb+V8NDSxVSSJrVXFGzHN7FyCPyP2ofVqsCVe/xilzhDU1xQP8rXUb/liWhRUWsrd7OB1odpFYzSuzMoVHAM5ilHmx24qlcTZzvyUzMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=E4wINA8a; arc=none smtp.client-ip=91.218.175.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="E4wINA8a"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vcf27pTdWLew8v9+Rx0bjqG70CtOvBXNxcVelWbQ7SU=;
 c=simple/simple; d=wyuan.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787573960; v=1; x=1788178760;
 b=E4wINA8a8jxMKJmIheRREN5kuCMiQy/hSVSP4/B4f/5rkOdA0fL/4zkgn4/YzP/pY8aPif43
 nKbodRj8r05sVceKYyp1Sa3CIV28TNDlCMI7hPZoNZfggTXz/Nwe0C1vzFNYk5a9X+kLFDmM/xX
 sRweB1/n9eZRH19TpgoOclPgA5kjvTuYm/kD/fwJvXQqinYqQkCsPbJgeEn3TL25BVQS+D7rAXc
 7PqyWHpQdOMsI1b9HmlHEY0g87CSyOMUXd1q7klsnJ/lRvn8cfTntOdZTLvH6JXg8XR9ZOdRaKI
 9MLp/HIEnsySbdb3BRsd+ZAuNudclaMszccBza/Vu35KQ==
X-Envelope-To: git@vger.kernel.org
Received: from localhost (117.176.242.187)
	by smtp.migadu.com with ESMTPS id 8bb68e1e72c29b73;
	Mon, 24 Aug 2026 12:19:09 +0000
X-Mizu-Trace-ID: 8bb68e1e72c29b73
X-Migadu-Flow: FLOW_OUT
Date: Mon, 24 Aug 2026 20:19:04 +0800
From: Weijie Yuan <wy@wyuan.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Alexey Samsonov via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Alexey Samsonov <vonosmas@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/3] treewide: migrate from legacy utime.h to utimensat
Message-ID: <aow2uARRxSQZR4wB@wyuan.org>
References: <pull.2209.git.1787322203.gitgitgadget@gmail.com>
 <aonIVn-ZQoMKWCAd@fruit.crustytoothpaste.net>
 <xmqqzeyeujde.fsf@gitster.g>
 <aor07LvsXOy1p7vh@wyuan.org>
 <xmqq5x10vowf.fsf@gitster.g>
 <aosVkqwcsmAWrDr6@wyuan.org>
 <xmqqfr04thhe.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfr04thhe.fsf@gitster.g>

On Sun, Aug 23, 2026 at 06:49:49PM -0700, Junio C Hamano wrote:
> Weijie Yuan <wy@wyuan.org> writes:
> 
> >> We know Johannes well enough to trust that his patches were sent
> >> with sufficient due diligence.  So...?
> >
> > <xmqqzeyeujde.fsf@gitster.g>:
> >> If work submitted under a DCO later turns out to be based on
> >> something we cannot legally use, the submitter may of course be in
> >> trouble, but we would also need to bear the cost of ripping it out;
> >> the later we discover the problem, the more substantial the effort
> >> necessary to deal with the fallout will be.
> >
> > What I meant is that you said we should be wary of content that might
> > carry legal risks,...
> 
> I am not sure what your point is.  Is there any part in "we trust
> Dscho well enough to trust that he sent them with sufficient due
> diligence" that was hard for you to understand?

Apologies, and please forget it. I must be feeling dizzy.

Thanks.
