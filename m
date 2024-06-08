Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFD8134DE
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717872819; cv=none; b=Zle0ER6vWneYuC2PTFxQToaVBwTK8ZRFDYJIM/z3SDX5gmZvc5vBMLoyEM5GWvmHnu7QPRgg+tX7yBc7jyj3R4jN2Q5FoqsbBUA0MMv2CK9SLCTDuc/uq8A+1ydBy3Z8qyDlSFXsh99ZwY7ZywB/QAzXaMpCO3kPUAxC0+zizYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717872819; c=relaxed/simple;
	bh=ejNmIiqtCntO00mnsnpsUWWJU8MO7FhJ4dIKoDpqWKQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TUZzTHVb6FgtM3WkhTfCo1Azz+VeZz48FqcVE70xnla+IXDLm0TCd9NRM3SCNkb1KTLAbuWFgKyj7VTQTa+QaPiVjZ3U7FP2X42DgGeN+WT5oxpXc9jrrdseeDKgYMVzkHbgOBV4BXjFZKVsc6JKu4eIBBzLJ9DS70Ol5CqAxBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tynHHlfq; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tynHHlfq"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 10A9833266;
	Sat,  8 Jun 2024 14:53:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ejNmIiqtCntO00mnsnpsUWWJU8MO7FhJ4dIKoD
	pqWKQ=; b=tynHHlfqzZ3Cq6l5JoyOFj8qkHjWW8B0NtH7yuZIX763DcPb568bhl
	tlhSv2j+EOcUyhssTLFzdT310drotErCCsYlR+TIH+ADqMXmSWgZueFeB1yXR3Fv
	tMcR1szwRiZReufLxTM5XrPY6XOi6/f2iw8Tgi9DXeWqrrnSDjxbI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F02B733265;
	Sat,  8 Jun 2024 14:53:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 98A0633264;
	Sat,  8 Jun 2024 14:53:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Konstantin Tokarev <annulen@yandex.ru>,  git@vger.kernel.org
Subject: Re: Autosplit option for git add -p
In-Reply-To: <CAP8UFD3JM_h1BvK59R4wT1DeZyo6o-9T3GXGK8xE6vLnDMDCaQ@mail.gmail.com>
	(Christian Couder's message of "Sat, 8 Jun 2024 12:43:33 +0200")
References: <20240607120530.74297526@yuvnserver>
	<CAP8UFD3JM_h1BvK59R4wT1DeZyo6o-9T3GXGK8xE6vLnDMDCaQ@mail.gmail.com>
Date: Sat, 08 Jun 2024 11:53:33 -0700
Message-ID: <xmqqmsnvclle.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 685D473C-25C8-11EF-B7E6-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

> It doesn't look like there is any option to do that. About
> implementing it, it depends if it would be a command line option or a
> config option.

Having these alone make no sense to me.

I'd suggest extending the lowest level (i.e. interactive prompt
response) first so that a stronger 's' splits all hunks in the
current file.  It might be sufficient for the use case.

On top of that, it happens to be that when changes to _all_ paths
want to be split, it may prove handy to also have a command line
option.

But the reason why I am hesitant to endorse a command line option
that splits everything is because:

 (1) it is dubious to expect the user to _know_ that it makes sense
     to split all changes before starting "add -p" (and friends).

 (2) if the user gives such an option and then in the interactive
     session regrets that it was too much to split all the hunks, it
     is unclear how the user can easily recover (there is no "merge
     all hunks back to the original" operation).


