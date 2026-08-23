Received: from mta0.migadu.com (out-164.mta0.migadu.com [91.218.175.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADE82441B8
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787499932; cv=none; b=tujsQxfHShSc6UR5cBirD5u4MWDhApwa7eA5TmLevMW551Q+acwxGPmZ2sEyZv+2XFGnzNLy72IFhJvyLyPRBwuIgdNORLSASPtcjOMtk2uMV/B3YVH7XsE1Zi9lz48U1jFa9OBSVL5DQWpE2SWFyLoUN2KOuTjjCjom/ji4NdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787499932; c=relaxed/simple;
	bh=z7JmWk/ZKzY9EpiqmF4/7rbP6dEwbujsNvMzogFMiwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0MymcAbiXwk9I+2/efU7KWE2XqO9BXmMR3JSC1nwQLIyymoHM2aWK2spe7Ot/yCAdbEo1k1kMJhPGn44hz7qI2j3FZyr+GpH2Bd7OXCBd4qIjyPIglClsi28tUKDqgxy0DZXebudOS0nFGqLbf9P+Kb3W9+QVu0dgRoCji5dIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=gCnnVehl; arc=none smtp.client-ip=91.218.175.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="gCnnVehl"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=z7JmWk/ZKzY9EpiqmF4/7rbP6dEwbujsNvMzogFMiwI=;
 c=simple/simple; d=wyuan.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787499927; v=1; x=1788104727;
 b=gCnnVehlBLoZJFuspE2dxZX5E/LnHDRjIIz6jzhuDEamnKyzoVn8APCWGTBH8PFXJgfWj5tE
 o3MLqVYqV8VCZLXpuNXngPRmt4GAJohB6BFC3ozIN29LD6y5EHiVuk/UPRMgQvGV2cx8PjRgwly
 CVVP24qjCfn12CE56yj7sHf2IZhd/xa49DW6njjAGrdmsfu9vD5kYgDwyDPg0ExSSkO74fl2pYK
 Y5Iwq3oj8WywfzkkHxr/2VOU54pJzxmRJYAxlmb14oHZkir7y2f3AaeN3/OhbRRYB6Bf++KMT8K
 5Sk51t+E8pivaVWWERqdEzLAaqkWTreq+yCsnrWFM9roQ==
X-Envelope-To: git@vger.kernel.org
Received: from localhost (117.176.242.187)
	by smtp.migadu.com with ESMTPS id b8dd6d9fdb16fed1;
	Sun, 23 Aug 2026 15:45:26 +0000
X-Mizu-Trace-ID: b8dd6d9fdb16fed1
X-Migadu-Flow: FLOW_OUT
Date: Sun, 23 Aug 2026 23:45:22 +0800
From: Weijie Yuan <wy@wyuan.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Alexey Samsonov via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Alexey Samsonov <vonosmas@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/3] treewide: migrate from legacy utime.h to utimensat
Message-ID: <aosVkqwcsmAWrDr6@wyuan.org>
References: <pull.2209.git.1787322203.gitgitgadget@gmail.com>
 <aonIVn-ZQoMKWCAd@fruit.crustytoothpaste.net>
 <xmqqzeyeujde.fsf@gitster.g>
 <aor07LvsXOy1p7vh@wyuan.org>
 <xmqq5x10vowf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq5x10vowf.fsf@gitster.g>

On Sun, Aug 23, 2026 at 08:26:40AM -0700, Junio C Hamano wrote:
> Weijie Yuan <wy@wyuan.org> writes:
> 
> > Sorry to interject here, but I seem to remember that dscho already has a
> > few commits with an Assisted-by trailer that have made it into master.
> > I´m not entirely sure what kind of assistance he received either, but as
> > you suggest, it seems better to mention this here sooner rather than
> > later.
> 
> We know Johannes well enough to trust that his patches were sent
> with sufficient due diligence.  So...?

<xmqqzeyeujde.fsf@gitster.g>:
> If work submitted under a DCO later turns out to be based on
> something we cannot legally use, the submitter may of course be in
> trouble, but we would also need to bear the cost of ripping it out;
> the later we discover the problem, the more substantial the effort
> necessary to deal with the fallout will be.

What I meant is that you said we should be wary of content that might
carry legal risks, if I understand correctly. And as far as I remember,
Johannes is the only person recently who has proactively disclosed that
his patches were AI-assisted. I appreciate that disclosure, so I was
simply pointing it out. Of course, I have no doubt about the quality of
his patches.

So what I mean is that we have already had cases where people
voluntarily disclosed their use of AI, but there did not seem to be much
discussion about it at the time. This time, Brian brought the issue up
for discussion, and I really appreciate both of you doing so.

Thanks.
