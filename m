Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641B91350D6
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709836213; cv=none; b=I4f44LNJHsDL8EU3oug4TgD64ltrW+d7W3ifj2fRs4P762Cja9DPCyrl3hPu8wNGBwaBK0BLvzJbVfx/+aefS9uW67wWLll+baAyZllP5BCx8Ms6TGS4KgA2heFUuwnGfZc6dCnTrpc4hDXvc8wi2Q/0g+rBIBRWImQ9OqhYqhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709836213; c=relaxed/simple;
	bh=qc0SNwZ3lTcAdq0vWijPn/W7u2veuGsoQLjbHSCEQW4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GL5dMjGeogBDSG9xYAHJYxGLMJLdbYWPt1ZLXrUo5gMfrlq/1WruudreFfjdJGVjwgl9UFC11LVHs2YzB8Ppmy8J3RDssoACR1VzAEm9WsKEOUwtmAS/Ts8BykR2U0OhPjsIuCMmCd0hfZWoIia+bUnBeDQaGp3XEX8qMC6eFOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=n1qNH+xV; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n1qNH+xV"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E654728221;
	Thu,  7 Mar 2024 13:30:10 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qc0SNwZ3lTcAdq0vWijPn/W7u2veuGsoQLjbHS
	CEQW4=; b=n1qNH+xVU1LqpclZ8L62lHRYPT/BktFFa7QsKOKgiTHtmkKlcE5LjN
	ZayVRfMjBn2WfOYggNifMmByWcHberxioe0bANmoZ1BomKhYeJr2rziU1jNSFYOf
	8I52OLrD4yjknZ3VbM83+CZArhMvqB1OanyvB5eMUz+jiPEpt+oZ0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DE19728220;
	Thu,  7 Mar 2024 13:30:10 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3B29D2821F;
	Thu,  7 Mar 2024 13:30:07 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Aryan Gupta <garyan447@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,  Aryan Gupta via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Patrick
 Steinhardt [ ]" <ps@pks.im>,  =?utf-8?Q?Michal_Such=C3=A1nek_=5B_=5D?=
 <msuchanek@suse.de>,
  =?utf-8?Q?Jean-No=C3=ABl_AVILA_=5B_=5D?= <jn.avila@free.fr>,  Eric
 Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] tests: modernize the test script t0010-racy-git.sh
In-Reply-To: <xmqqjzmdnbz4.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	07 Mar 2024 10:17:03 -0800")
References: <pull.1675.v3.git.1709676557639.gitgitgadget@gmail.com>
	<pull.1675.v4.git.1709716446874.gitgitgadget@gmail.com>
	<CAP8UFD31udQB2e=+G-LpCevuS+JxQdWqwaq=5qvGEn21595faQ@mail.gmail.com>
	<CAMbn=B73boxu1HDy2UHGz83wxnE7=udmbSv4nFsV+ngA0Bn0Sg@mail.gmail.com>
	<xmqqjzmdnbz4.fsf@gitster.g>
Date: Thu, 07 Mar 2024 10:30:05 -0800
Message-ID: <xmqqfrx1nbde.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B91545DC-DCB0-11EE-B2BF-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> I was wondering about the same thing.  I still see an unwanted "[ ]"
> around Kristoffer's e-mail address that will break responding to the
> message in your [PATCH v4] e-mail that can be seen at
>
>   https://lore.kernel.org/git/pull.1675.v4.git.1709716446874.gitgitgadget@gmail.com/raw
>
> so, the experiment revealed that it did send some headers were
> broken.

This does not necessarily mean GGG is broken.  The majority of the
patches I see here from GGG are without these funny [square-bracket]
around addresses at all, and this was the only patch (or it is
possible that your other patches may have had the same issue; I do
not remember) with that problem.  It might be caused by what you
feed GGG (e.g., the messages you give it in your pull request) that
caused GGG to hiccup, perhaps?


