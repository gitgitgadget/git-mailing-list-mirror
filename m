Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6376F1B29C8
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 19:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718910983; cv=none; b=CwDboTbpM4awjDvvGj/dOYo+7n9o4BDYS8LZoou9Cc0DPKIYInjrQ4WP+mYEzXLk3a+lEEd2/LIGYzBDiozCBS/afJU8Y0Ivye6wEp671zzukFW4Qw9v27RWMqwqv+1C5JPG3bIAEfJMbsMNfIvaR51Enmbg//+EQ5nvDCy/5wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718910983; c=relaxed/simple;
	bh=bRmrJsd9/EcsRP+d8X3rRLYj0suOGHU3oF0XAbczRZc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hOsTX+tOFWbXAfXnsGgUdTuYe9ZqM3UUnCMQQtUmaBYphLmhjz2WAFGLNfriUzqxcw03oV24HlhRqJDoOuOCDDcvhG2HaCs7zxnxY6DA+opEk8iREURENBKitLOag43RdsuJ3oq8IfXdZIQNJY4HhuTnEjE9ynspdfR/8dDyecI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=e4YmfqAc; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="e4YmfqAc"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B46C1DD89;
	Thu, 20 Jun 2024 15:16:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bRmrJsd9/Ecs
	RP+d8X3rRLYj0suOGHU3oF0XAbczRZc=; b=e4YmfqAcbCnJDWR+6d/jGQiM/8MF
	C66qeOtuz/2i+jnkxQ8YGuk6rufViEYxArEOA9fbcJuZzMjk1xvu6bveWMAMe12a
	tiQcHB7fW8tLKUuYFpG3nO1f/K/Mbzk+frGCUKXpcHsBS0HqBc6TMe6XwvflsOeZ
	VnJzbVh/PVCClbs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 23A651DD87;
	Thu, 20 Jun 2024 15:16:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 896321DD86;
	Thu, 20 Jun 2024 15:16:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  newren@gmail.com,  anh@canva.com,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH 0/5] sparse-index: improve
 clear_skip_worktree_from_present_files()
In-Reply-To: <pull.1754.git.1718899877.gitgitgadget@gmail.com> (Derrick Stolee
	via GitGitGadget's message of "Thu, 20 Jun 2024 16:11:12 +0000")
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
Date: Thu, 20 Jun 2024 12:16:19 -0700
Message-ID: <xmqqiky3tofw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 937C50E6-2F39-11EF-AE90-5B6DE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> While doing some investigation in a private monorepo with sparse-checko=
ut
> and a sparse index, I accidentally left a modified file outside of my
> sparse-checkout cone. This caused my Git commands to slow to a crawl, s=
o I
> reran with GIT_TRACE2_PERF=3D1.
>
> While I was able to identify clear_skip_worktree_from_present_files() a=
s the
> culprit, it took longer than desired to figure out what was going on. T=
his
> series intends to both fix the performance issue (as much as possible) =
and
> do some refactoring to make it easier to understand what is happening.
>
> In the end, I was able to reduce the number of lstat() calls in my case=
 from
> over 170,000 to about 6,500, improving the time from 2.5s to 71ms on a =
warm
> disk cache. =C2=A0 Thanks, Stolee

That's impressive but I cannot offhand tell how big 170k (or 6.5k
for that matter) is relative to the size of the tree.  How many
paths are there in the entire tree (i.e. "git ls-tree -r HEAD | wc
-l") vs the number of the in-cone paths in the working tree? =20

If 6.5k is in the same ballpark as the latter, it would be really
good.

Thanks.
