Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A593EA66
	for <git@vger.kernel.org>; Tue, 14 May 2024 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715698135; cv=none; b=FolybPPkz2bQZhy9mUxwaH3NQVelCGXerLmGbN6BolcbmvhWsxMCLHFLZGiHdmKyaokbHy8sLQofF2F1KsUjVZzyRdjKmP3AgRWuzTV9V5JfmGbKhx9nb95GTYoLRAgUq6jEFJCNld9AsiF9iW0l0JJDS1Q2LqiSq0JYibAJ1kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715698135; c=relaxed/simple;
	bh=24kjWptKM5G39NBAZhX5C4lrziMSPjKFJXuR/R+diC8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fYkogwMyV6+SYaDF8A+/GQx9ek1ICFkWf+fEWLCKLDqm368BVQIe9Xc5kZAfeAwmchCtq4ADgGZpPjWGyAvtLHQBaU1pF+nICKE4WPEhfxvqz7u/FAbdHz4e7Svk3dL/c0GlGQT0paaRUuym89wY7KYGPANuxLnAVPr0NqCMnT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MLcU8Tk/; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MLcU8Tk/"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1DF3F3D111;
	Tue, 14 May 2024 10:48:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=24kjWptKM5G39NBAZhX5C4lrziMSPjKFJXuR/R
	+diC8=; b=MLcU8Tk/bKDGFjS6fpkm+pB6NtnBSeTuHHkQMbXx8kzzfolFn//Xzs
	4EhWHb3xAZ4zkqNVmPCZI6iyk31CIBJ4dQEu+BHnLrIC+1fIMjhiqbbJSNS2lh8P
	gz1Y2h4xx/cC1cQtFGEfHkN2ZFJHAbkyqtC181f9PE2mlK1UEuxJ8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1749A3D10F;
	Tue, 14 May 2024 10:48:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BF5FC3D0CC;
	Tue, 14 May 2024 10:48:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Kyle Lippincott <spectral@google.com>,  Eric
 Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 00/21] builtin/config: remove global state
In-Reply-To: <cover.1715595550.git.ps@pks.im> (Patrick Steinhardt's message of
	"Mon, 13 May 2024 12:21:58 +0200")
References: <cover.1715339393.git.ps@pks.im> <cover.1715595550.git.ps@pks.im>
Date: Tue, 14 May 2024 07:48:47 -0700
Message-ID: <xmqqzfss78kw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1297CE24-1201-11EF-AE91-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> this is the second version of my patch series that removes global state
> from "builtin/config.c". Changes compared to v1:
>
>   - Reinstated a comment in patch 5.
>
>   - Fixed a memory leak in patch 9.
>
>   - A couple of commit message fixes.
>
> The series continues to build on top of ps/config-subcommands.

I do not offhand know if this iteration has already been seen by me,
but a few recent CI runs of 'seen' did break with *-leaks jobs in
t13XX series around "config".  Hopefully with the fix in "patch 9"
listed above the problem has gone away?  We'll know soon enough when
I push out the integration result.

Thanks.
