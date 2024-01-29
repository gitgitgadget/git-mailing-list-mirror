Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D02E48790
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 18:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554741; cv=none; b=p7dvWxkoTREKhSCqyhRe3GsPSlVD4UEuyFPfu43ky6N/UU9H2fZXW8FBlcA6xR265fQBvjLo/cNMGZ848enwBBr6bIrNdt+bK5M5bWAI11eMbVBj2mYzAmeJ2viRkYeIYnbCEO/qXJm0RoxJrEZYf0Up5p+ch3195dF34wuE8tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554741; c=relaxed/simple;
	bh=o7Rz2B1tRcX7iLbRGRNZNFRMsbZiz096u/jDCI5l2Lo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c+qD+THWzCks3/udzA1L4w28h/qbu3oY5sPFqI+flxoPvwqPHJGBTEVba+8IZMA35yzlXY9PyiBCaqUT8M6MmEl6rssyF074XEft8KTngu7pdxAp0BqekxwW/ls2vUApGt21r1lO0xo1mhw6/25wVIZVR8X6bGrZFVXgoPkyyMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pY4x7/G2; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pY4x7/G2"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 880C3209C3;
	Mon, 29 Jan 2024 13:58:59 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=o7Rz2B1tRcX7iLbRGRNZNFRMsbZiz096u/jDCI
	5l2Lo=; b=pY4x7/G2vuyarqlZfy/OPlkf2iKAKI8Z4uvwqggpvY+BzQESyCRGjZ
	bJ3o+KDuG+w8UkeVqCZADP1BkiOJlJVp56eR22TYY1EXU8ZojOKwCVJ4ammGEMDB
	Lneyvprkw8olRGGmmDtDdEYJF3EAZ0hq4C8Ciww6BvaGhKew4Uaks=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8140C209C2;
	Mon, 29 Jan 2024 13:58:59 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 18FA6209C1;
	Mon, 29 Jan 2024 13:58:56 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] add-patch: compare object id instead of literal
 string
In-Reply-To: <xmqqmssohu69.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	29 Jan 2024 10:27:10 -0800")
References: <20240128181202.986753-2-shyamthakkar001@gmail.com>
	<20240128181202.986753-3-shyamthakkar001@gmail.com>
	<xmqqmssohu69.fsf@gitster.g>
Date: Mon, 29 Jan 2024 10:58:54 -0800
Message-ID: <xmqq8r48hspd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 73DD80C4-BED8-11EE-B429-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> So, after thinking about it a bit more, I do not think I agree with
> the NEEDSWORK comment.  I can buy "@", but not an arbitrary revision
> name that happens to point at the same commit as HEAD.  

One more thing is it might make sense, if we were to allow more than
the literal string "HEAD", is to include the name of the current
branch (e.g., if "git symbolic-ref HEAD" says "refs/heads/main",
then "main") to the set of tokens that the user may use when they
mean to refer to "HEAD".  Unlike "newbranch" they are not currently
on, if they know what branch they are on and they know that is what
HEAD refers to, so the likelihood of them wanting to see the command
behave (i.e. the direction of the patch to be selected and the
messages) the same way may be much higher, I would suspect.

But still, the sudden reversal of the direction of the patches may
bring unexpected confusions to uses.  I dunno.

> In other
> words, I may be persuaded to thinking into it is a good idea to add:
>
>     static inline int user_means_HEAD(const char *a)
>     {
> 	return !strcmp(a, "HEAD") || !strcmp(a, "@");
>     }
>
> and replace "!strcmp(rev, "HEAD")" with "user_means_HEAD(rev)", but
> I would not go any further than that.
>
> Thanks.
