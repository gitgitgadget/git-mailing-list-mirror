Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AE317C3
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 00:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705539390; cv=none; b=ZRua7ER+12wKIc+MkFnAvQD/GEuQ9llJ7NVtmyJsiKEVgvTouDOJ4vAC8UFE0RcJS6qjvTHVF/G5PzxvIAfq8u5bUhJ+oUOtO6J7J2BQKYLxf+WFIPvv8CONjtiNZ0Kg61SVfWUIm5JZvsHT/q2/yNs2vgAoWaJ6mXLJoQw5GE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705539390; c=relaxed/simple;
	bh=yxvGt/H9fLB+h6Jv67R/RM2074BmilIn4zEygZ9ZtYA=;
	h=Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:X-Pobox-Relay-ID; b=fOqfUb3UhhPOVZmcA1tyrTsVmuX/t7lwOJEO7+7WNoGghPYZ3tQH0caGbQUYXXARP6jdb4bQKJAHZXlfVI0xA1AvAqI0CDZ/RLLz4+mrzDyHrtcHx8GKx5mzPIbkiWt1n78DLfmQV2yuS/9vfCyeGdXNU90UAdlO2L5wgmW5tBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UcV19W0m; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UcV19W0m"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 079011C3A00;
	Wed, 17 Jan 2024 19:56:27 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=yxvGt/H9fLB+h6Jv67R/RM2074BmilIn4zEygZ
	9ZtYA=; b=UcV19W0m6+aeZAJUBajkdG7gM8WoZ/QCt/JdPwreGz8aa1/dQYtB9A
	rwN8THYw+JEe6St1DavC+VSLwbx8Phj+kk/l+jm/1RZI3ixYcknvAsRoFa4a5D0t
	zjq2YXnE9RLHkfHADPFlw5gkBIbmT6zt82VxX5/ZIS1TP9D281fcw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F27CF1C39FE;
	Wed, 17 Jan 2024 19:56:26 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5A7DB1C39FC;
	Wed, 17 Jan 2024 19:56:26 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 03/12] t1414: convert test to use Git commands instead
 of writing refs manually
In-Reply-To: <19233aa0d4496b66d67fbee82fb8d9b6b35a03cb.1705521155.git.gitgitgadget@gmail.com>
	(John Cai via GitGitGadget's message of "Wed, 17 Jan 2024 19:52:26
	+0000")
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
	<19233aa0d4496b66d67fbee82fb8d9b6b35a03cb.1705521155.git.gitgitgadget@gmail.com>
Date: Wed, 17 Jan 2024 16:56:25 -0800
Message-ID: <xmqq7ck7tq6e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6843A6C0-B59C-11EE-AD86-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  # Create a situation where the reflog and ref database disagree about the latest
>  # state of HEAD.
> -test_expect_success REFFILES 'walk prefers reflog to ref tip' '
> +test_expect_success 'walk prefers reflog to ref tip' '
> +	test_commit A &&
> +	test_commit B &&
> +	git reflog delete HEAD@{0} &&
>  	head=$(git rev-parse HEAD) &&
> +	A=$(git rev-parse A) &&
>  
> +	echo $A >expect &&

You do not need an intermediate variable A, i.e.

	git rev-parse A >expect &&

would suffice.  Also it seems that $head is no longer used
because you do not manufacture a reflog entry yourself, so the two
assignments to $A and $head can be removed.

>  	git log -g --format=%H -1 >actual &&
>  	test_cmp expect actual
>  '

The resulting code makes the intent of the test much clearer.
Nicely done.
