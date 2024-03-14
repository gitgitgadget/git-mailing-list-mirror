Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F1374297
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710437568; cv=none; b=HJITbIEfnqFVLXnfpUF8yBjOSJELEXjaTrr+Ok4tymRRGooPnWXfZvfFoojC/tRDGq9uJ1wuhGeRjM2xDJAecKiV/k/8GPnyEXXOCIBZGZzhs+gpb+yu8Ve/K0W65z2K0hGMymLXUy6AAet7qlJ8/U4q+cE1v76en85SWb30jAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710437568; c=relaxed/simple;
	bh=B40JUCkU5RgK9kKwqu5ufpMQvJx9AtVY+uYeYLh7g7M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kylsW6q6aAJ6D1AmyoVxIyGD4+Yt6O5lRF3NhYu3Ra34Tx4Jm61EIZhR/xpUcrmIb3xqXIRIKyPUsUw+IIZfZvzoeFkxVNiAK5z39l9br4fmPW7OXlT5K3SHmsmhWXFI7iWIbcK1O7dZwH8NWh9VKIQHb1NoNjhS5k0Lp0Hgfzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Nq7oC9VP; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Nq7oC9VP"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C2DF523454;
	Thu, 14 Mar 2024 13:32:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=B40JUCkU5RgK9kKwqu5ufpMQvJx9AtVY+uYeYL
	h7g7M=; b=Nq7oC9VPzQCr+QeMlj4EiXNLt1gYVlf6Is3PnO2OyT5WSG6R1kGORW
	pj2OW0qFH+rzyfJuagWI7aegSAgyTwJjTQPQufXeUfZb7j/ZU0UHcQjqJCGezCPH
	bcx2i3RuoIRmkDl7tNKL2zcjKG8o63LImbPsfVJNmlkw0BC+va/FY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BBDC823453;
	Thu, 14 Mar 2024 13:32:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 63F8423452;
	Thu, 14 Mar 2024 13:32:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 5/5] checkout: fix interaction between --conflict and
 --merge
In-Reply-To: <b771b29e45abd1992e46c174dcaebe20ca8a41f9.1710435907.git.gitgitgadget@gmail.com>
	(Phillip Wood via GitGitGadget's message of "Thu, 14 Mar 2024 17:05:07
	+0000")
References: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
	<pull.1684.v2.git.1710435907.gitgitgadget@gmail.com>
	<b771b29e45abd1992e46c174dcaebe20ca8a41f9.1710435907.git.gitgitgadget@gmail.com>
Date: Thu, 14 Mar 2024 10:32:40 -0700
Message-ID: <xmqqcyrwvhvr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DCB117A0-E228-11EE-810D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When using "git checkout" to recreate merge conflicts or merge
> uncommitted changes when switching branch "--conflict" sensibly implies
> "--merge". Unfortunately the way this is implemented means that "git
> checkout --conflict=diff3 --no-merge" implies "--merge" violating the
> usual last-one-wins rule. Fix this by only overriding the value of
> opts->merge if "--conflicts" comes after "--no-merge" or "-[-no]-merge"
> is not given on the command line.

That smells like a convoluted logic but I think I can buy the
argument. If "--conflict=diff3" implies "--conflict=diff3 --merge",
then "--conflict=diff3 --no-merge" should imply "--conflict=diff3
--merge --no-merge" and the latter two cancels out with the
last-one-wins rule, leaving only "--conflict=diff3" that does not
imply anything about "--merge".  The conflict style specification
does not have any effect when we are not recreating any merge, so
all of them are ignored in the end.  So, it probably makes sense,
even though I find it highly confusing.

Is it likely that "--conflict=diff3 --no-merge" signals that the
user is confused and it is safer to abort the operation before doing
further harm, though, I wonder?

Thanks.
