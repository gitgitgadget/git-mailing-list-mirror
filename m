Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D577722F1C
	for <git@vger.kernel.org>; Thu, 27 Jun 2024 21:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719524803; cv=none; b=u5Sars1RBC+n8G1T3+74ji+ZZxYgPEBIUSIDDlJXLM5lYSOWKOfqN2I6orSToNnq5rJE1RZ/gQfNs14e0U5aVfg3FSlcC4gExTnjRT/YuV6GNIYAjHBSjtkINrrLq4wLOCnLfdPlXZ1vPEJeOlJMOjzPvpidaV4wYWQTLuiPv3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719524803; c=relaxed/simple;
	bh=xqgYR53CzoUjv3tXcfJhRCqVr0JJTuZPQhVCpKPOa84=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k1wCI5+r1KDPsudBR2aFNVnwCkFWvMigpXYswHlSIM5rgWypN/yoRWXpafvsvHVcEHaajIXU0cHlHIPA0XJkQ20v/yt2b+qbRUH5luBCDN2o9GB9IJ7sgavQQcyJOyh+ZhHBSJyLK10WUN0Oaolq4GDwDUl2lQD/kdkurb2exWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uJZVTZFr; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uJZVTZFr"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B1E9F2D52C;
	Thu, 27 Jun 2024 17:46:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xqgYR53CzoUjv3tXcfJhRCqVr0JJTuZPQhVCpK
	POa84=; b=uJZVTZFrwvcJ/OnI9d2fn2rYUz0EIxRtKgsBiQ0OUTL/8YrGsXDst1
	q6QHlO8wlveyVUnPjfNPpHeo8lGEHv9F5sWC05LULzFIoAlFmWeFhnzj8TMDFG1B
	OZFG844EEygIx3D2J3NgElppyjdSe35Ee41P1xr71TP1XxL+Wcf30=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A8D692D52B;
	Thu, 27 Jun 2024 17:46:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 15DD32D52A;
	Thu, 27 Jun 2024 17:46:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  newren@gmail.com,  anh@canva.com,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH v2 0/5] sparse-index: improve
 clear_skip_worktree_from_present_files()
In-Reply-To: <pull.1754.v2.git.1719412192.gitgitgadget@gmail.com> (Derrick
	Stolee via GitGitGadget's message of "Wed, 26 Jun 2024 14:29:46
	+0000")
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
	<pull.1754.v2.git.1719412192.gitgitgadget@gmail.com>
Date: Thu, 27 Jun 2024 14:46:37 -0700
Message-ID: <xmqqv81uqcsi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BC6EFF72-34CE-11EF-BB3A-965B910A682E-77302942!pb-smtp2.pobox.com

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Updates in v2
> =============
>
> Thanks to Elijah for a thorough review, leading to valuable improvements.
>
>  * I was mistaken that the sparse index was required for this logic to
>    happen. This has changed several descriptions across the commit messages.
>  * The final lstat() in path_found() was not needed, so is removed in v2.
>    This saves even more time and lstat() calls, updating the stats.
>  * Elijah created a particularly nasty example for testing, which I include
>    in my final patch. He gets a "Helped-by" credit for this.
>  * Several comments, variables, and other improvements based on Elijah's
>    recommendations.
>
> Thanks, Stolee

Thanks, both.  This round was a pleasant read.

Let's mark it for 'next' soonish.


        
