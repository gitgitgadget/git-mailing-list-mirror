Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7F226F2B8
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 10:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766054111; cv=none; b=VNIUW+N8XHTi7JgYtpyzT3SlIyGTt3J0vZPRIWjTkycw354GHxR012oINDoiWUXd3lX0lcTh/+HMxmtpoPlpTUDj7+Y07/0UIFl34chxO/UqA/2aRUynzX/c1/XcN1DFgJJqHTivTi5UQt/OExLtyngwYdcfD3cCs1RGuqAERcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766054111; c=relaxed/simple;
	bh=VG+MyI0E3ijTRFOst5fgraBTfjX6RtbJX1Xrc3/o4dM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkM4+p/hyfUgbjJyBcXj6SninnUYIJzJgpGmAUmUh17G1biz8V0bJBW54Sc/7Q0XUITEYKDLgiDG6MqG3o4DkjgNdabPnnpFxXdnFuTLhxxch3Lr88rwotjLBAejaUkR2CzqszD4GiB7N0sSAfNcGMIsSEBZI+dp8NUSKLDUkDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4dX6Vp2bxNzRpKW;
	Thu, 18 Dec 2025 11:34:58 +0100 (CET)
Message-ID: <44db571b-4fb1-43da-a7c2-eb7cc15048ab@kdbg.org>
Date: Thu, 18 Dec 2025 11:34:57 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] mingw: don't call `GetFileAttributes()` twice in
 `mingw_lstat()`
Content-Language: en-US
To: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: Karsten Blees <blees@dcon.de>, git@vger.kernel.org,
 Karsten Blees via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
 <dae450dd0e995b26d0140cf3753d103f5470f44d.1765980535.git.gitgitgadget@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <dae450dd0e995b26d0140cf3753d103f5470f44d.1765980535.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 17.12.25 um 15:08 schrieb Karsten Blees via GitGitGadget:
> From: Karsten Blees <blees@dcon.de>
> 
> The Win32 API function `GetFileAttributes()` cannot handle paths with
> trailing dir separators. The current `mingw_stat()`/`mingw_lstat()`
> implementation calls `GetFileAttributes()` twice if the path has
> trailing slashes (first with the original path that was passed as
> function parameter, and and a second time with a path copy with trailing
> '/' removed).
A comment above do_lstat() mentions this procedure. This patch doesn't
change the comment, but it should.

-- Hannes

