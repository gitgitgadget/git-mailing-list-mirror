Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8361922CF
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 20:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495189; cv=none; b=kOo8ZImdBosEq4QRoKRW65DbFdBu2bDrFt/EYXFxJK60WT8pFN+dQofR14TONPLsamq9V2rgdf9EBk4RxHmeJ/pSIwxVZdk5K6T9yHKXREJjvndlgR/2eHcUPE467t/1W2je/JWwlDUguJh6271nCrYhnHloX6L1U6AI1kW12FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495189; c=relaxed/simple;
	bh=nmY6YneMN7L/0lGJdMPWNBJmer0N8vlBRssZsxp1Rog=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lfApzkJ6HZeT4Vnj51GRqL5Xirsavl6KOovhB39/NQYkJT4G1Eqbt3jveqpZ9K7NcBR0V/c/U0S23JLRdwNRfbTHKFr9/71wCY+o9mf0fmNw9NdaUJwF57oTbwBFOifpM9aILhhnI3L5zH0nP08O5zr8JtY53gcP9ubbTbCoa6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mbDMd+m/; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mbDMd+m/"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 878FF3E86B;
	Mon, 12 Aug 2024 16:39:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nmY6YneMN7L/0lGJdMPWNBJmer0N8vlBRssZsx
	p1Rog=; b=mbDMd+m/IDzUi1ey1XbYK1SBy3jtreNH9f5ZsKBmBvt+w9WJFj5GZx
	5uXrn5giwqRonbX2XHSDyUGzFFVofeBWG5yOv2nC/y4xh0eOWFRSYE77giToB+Tg
	afanZLH10Ut3ZE6ILFrJ28o7SsY6TLjIkfzyk8V5n2Lt5Je7H6gDk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 818833E86A;
	Mon, 12 Aug 2024 16:39:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 510E43E869;
	Mon, 12 Aug 2024 16:39:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Alex Galvin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Alex Galvin <agalvin@comqi.com>
Subject: Re: [PATCH v3 0/3] git-svn: use svn:global-ignores when creating
 .gitignores
In-Reply-To: <pull.1747.v3.git.git.1723481908.gitgitgadget@gmail.com> (Alex
	Galvin via GitGitGadget's message of "Mon, 12 Aug 2024 16:58:25
	+0000")
References: <pull.1747.v2.git.git.1721335657.gitgitgadget@gmail.com>
	<pull.1747.v3.git.git.1723481908.gitgitgadget@gmail.com>
Date: Mon, 12 Aug 2024 13:39:40 -0700
Message-ID: <xmqq7ccl1nn7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 00A9EA90-58EB-11EF-B3CD-E92ED1CD468F-77302942!pb-smtp21.pobox.com

"Alex Galvin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Git-SVN does not currently use the svn:global-ignores property added in
> Subversion 1.8 when showing or creating .gitignore files. This causes
> Git-SVN to track files that are ignored by this directive in Subversion.

THe v2 iteration of the topic has already been merged to 'next' last
week, and I was hoping we were done.  Can you make it an incremental 
update on top of d7969a5127, which was the previous round?

Thanks.
