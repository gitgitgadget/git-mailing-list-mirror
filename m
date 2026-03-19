Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7A5318EC4
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 04:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773895348; cv=none; b=HIJAQBootewLiP2iSZe/HDLrXV3VFy+oZyCgorL3RtGJ4u1BOvSLFlPVHbxGVRMVMJJaM7D3krN4aJBXZkOo1h07e0P75qrLErvFOVTDHAw4yRBrMLMeFEDzuD4tut8eAZKBvc+t7U6BC9abnkv3Mi3xTB6+TZnqJ3ah0+0TgK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773895348; c=relaxed/simple;
	bh=gAGhoteYdIWhWMEjj0pcNMcsM0uv1uJDagAcqX22X5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDRKsYAPGHA15Oth+f3DEu1YcWcUDotxH8MvJ5fileLCDj06WPQEsxr55UFIqIRMRLhiDNen2ErATeq9zgT2iPqV8fIP3xbBjLi/J1UEL5Se+y7yicjbs0+6/gtKx5RamJEO5bNc+8yTu1h62yfo1Af8q22OVMwr0DsPTmt9zC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q77VnzTo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q77VnzTo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ns8SlUkRJQfDUHm4KNQZUm2Q7WWUizAusx5ZNqBCkaE=; b=Q77VnzTo7ztY6vNCA5L0UUVG75
	VedQ0oEIwtdLfWqvhll+vIcsdC4Lrk3FazifprJE4la3sTJ48tTUASFaiXmIsWom9b1IJUbzLrGbR
	grWP/RAoIsSlIqfrPcOOd8nAB8E2mZyHD1JdEOeZMCteE7+CiWxGvkh4LYYl3MwWI5g+vYTg3svcu
	PDbCrEMRfgelE4SEx2MZgXlX93MCabPnCQkFuCY8j4vATTUhydYI+XpDPPI5Je6u1x/3kQ6LYMbay
	fzk4qj01MPApmPZK1tUwmu+G6jW+hlyfNVAmsDaF60dpf62iNd0p9V1brJZMtgzY9ZgrqsJQYGswa
	AHFlgKYA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w35DD-00000009uSd-3Cjd;
	Thu, 19 Mar 2026 04:42:23 +0000
Message-ID: <2c943182-d5d7-4f72-ab97-8d07bf4ed216@infradead.org>
Date: Wed, 18 Mar 2026 21:42:23 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git grep failure?
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
References: <7bbcda60-dad4-41d4-b994-c19f83f37e2f@infradead.org>
 <20260319003829.GA3530301@coredump.intra.peff.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260319003829.GA3530301@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/18/26 5:38 PM, Jeff King wrote:
> On Wed, Mar 18, 2026 at 04:28:17PM -0700, Randy Dunlap wrote:
> 
>> If I apply the patch at
>> https://lore.kernel.org/linux-doc/c5bb61cf789df1ecb32facc29df9749987c7ddfc.1773346620.git.ljs@kernel.org/
>>
>> Subject: [PATCH 02/15] mm: add documentation for the mmap_prepare file operation callback
>>
>> to the Linux kernel tree (e.g., linux-next-20260316), it applies cleanly.
>>
>> I noticed a typo in the patch ("struct vma_area_desc" should be
>> "struct vm_area_desc"). When I run
>> $ git grep vma_area_desc
>> the output is empty.
>>
>> Is this expected? (but not by me :)
> 
> I applied the patch and git-grep does produce one line of output (the
> instance added by the patch).
> 
> Two possible differences:
> 
>   - are you sure the patch application succeeded?

'git apply filename.patch' succeeded AFAICT. git status shows one
untracked file (the one that is added by the patch).
Do I need to do 'git commit' also?

>   - are you in a different subdirectory? By default git-grep narrows its
>     search to your current working directory and its subdirectories. So
>     if you are in arch/ or something, it would not find the result in
>     Documentation/. You can do:
> 
>       git grep vma_area_desc :/
> 
>     to search from the root of the project.

I'm running 'git grep' from the top-level directory of the
kernel source tree.

thanks.
-- 
~Randy

