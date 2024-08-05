Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FED82AD13
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722883083; cv=none; b=Iguekoa4OCowWxSKWqZjt965dAD5hBnqvr14u71j88RCOhyZN0G9Sd7xYColyzobR3PkV0tMoiJO5mKFHjtsEXO7OIzVBr8cg9MdS+v8bxGv1BsteWHOEHhxQcLNE6JPTtvsxbHp+c3feGLQzhmNBUsqGQ4C/0BlAhOhQgDIreY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722883083; c=relaxed/simple;
	bh=sxyu4ZjLgioDa4yFqP/QQEfGGGlFgRPMA6dw9bASouM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jIm56sVDNoqGCxIRxAi4vxe7zEvPJpeAGLJISuPNaxXDu/2tML1DXutAPhVzu6o4Ov/AUnbDKwFz2pp3E9xAu5mzpBGkURgklGBMOeAiJ2p2gJnDMYWDU+JdSeH+KEjPpOyxqxPXGavExxecW1svpvsbqY7pG7D9/shd6vi1yj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TErgZVJX; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TErgZVJX"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D9050191E0;
	Mon,  5 Aug 2024 14:38:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=sxyu4ZjLgioDa4yFqP/QQEfGGGlFgRPMA6dw9b
	ASouM=; b=TErgZVJXn14ZMOetVLn5wk0vAxk1xDa5seLR+1yKTMb5AB6iTTNmIB
	2uMCMIvqjQ7rEnSm+ZwXNMN4rqdgscuFEj3K7VvpkBBLC9esF/3/H0Tw7ur5KaM0
	I+oRqAjqWTm39G2yxMxyXszQ+KzahYjBqYyimIex8rDxZV+WdAU3I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D1273191DF;
	Mon,  5 Aug 2024 14:38:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D8CA4191DD;
	Mon,  5 Aug 2024 14:37:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH v3 0/2] Small fixes for issues detected during internal
 CI runs
In-Reply-To: <pull.1756.v3.git.git.1722877808.gitgitgadget@gmail.com> (Kyle
	Lippincott via GitGitGadget's message of "Mon, 05 Aug 2024 17:10:06
	+0000")
References: <pull.1756.v2.git.git.1722632287.gitgitgadget@gmail.com>
	<pull.1756.v3.git.git.1722877808.gitgitgadget@gmail.com>
Date: Mon, 05 Aug 2024 11:37:55 -0700
Message-ID: <xmqqzfpq24u4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D563770C-5359-11EF-A282-E92ED1CD468F-77302942!pb-smtp21.pobox.com

"Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com> writes:

> I'm attempting to get the git test suite running automatically during our
> weekly import. I have this mostly working, including with Address Sanitizer
> and Memory Sanitizer, but ran into a few issues:
>
>  * several tests were failing due to strbuf_getcwd not clearing errno on
>    success after it internally looped due to the path being >128 bytes. This
>    is resolved in depth; though either one of the commits alone would
>    resolve our issues:
>    * modify locations that call strtoX and check for ERANGE to set errno =
>      0; prior to calling the conversion function. This is the typical way
>      that these functions are invoked, and may indicate that we want
>      compatibility helpers in git-compat-util.h to ensure that this happens
>      correctly (and add these functions to the banned list).
>    * have strbuf_getcwd set errno = 0; prior to a successful exit. This
>      isn't very common for most functions in the codebase, but some other
>      examples of this were found.
>  * t6421-merge-partial-clone.sh had >10% flakiness. This is due to our build
>    system using paths that contain a 64-hex-char hash, which had a 12.5%
>    chance of containing the substring d0.
>
> Kyle Lippincott (2):
>   set errno=0 before strtoX calls
>   t6421: fix test to work when repo dir contains d0

Both patches make perfect sense to me.  Thanks.
