Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16E516F836
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719862174; cv=none; b=RwTTbIHW8k9qZjX9/taioupvVu2TpDvto4W330KTsGUKdc9Sm80Ilw5804Ws0HoJ/xf1qOblNKczv3VXq8Z9i1j7Q3OMmqYYpH5CX6gTBSz/vjeKR6POeUIVaTIwaypcDZ2l8oviww4f072Hb3RWNjzP/T1qTeQ+rxouSaBrGlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719862174; c=relaxed/simple;
	bh=zzQYKC1A2TWxowzIGr6HzdyV/pg40fzz9zOqTVq9oQA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RgeXob4Y4+Zfc5SPsol8pkBzsG8hJDGc7Vr5dV78I455Gzz6WCIudHZxeTry4ShuLR/NIrUGUVTp7qwFphzGzSJMAX3I51jp+9UUIcsiYj0w26p+j4z2e7uAY0TK2+ZhilQbDR6+XfB9KIRotWpQBVY1mhMaiHtzD+NpBDCT/pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=npDiAqgn; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="npDiAqgn"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9109E1DFD3;
	Mon,  1 Jul 2024 15:29:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zzQYKC1A2TWx
	owzIGr6HzdyV/pg40fzz9zOqTVq9oQA=; b=npDiAqgnT8GcNh9/XSLNiDIxfzyD
	k3uQNtpyJq2sw518iY3S8bsW3iSpAebXHMWlqoMLuGi8legDuLRzRRY7AEvRkrpj
	iAPY/zQfhLZ1LAWdRbKJo883N6DZsfnMd+eZL1rUd7OdUMAunfOWP8IlsdRW44XJ
	ZwVTNwZylslCZdI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8A12E1DFD2;
	Mon,  1 Jul 2024 15:29:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 53BFB1DFD1;
	Mon,  1 Jul 2024 15:29:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,  Eric
 Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] test-lib: fix GIT_TEST_SANITIZE_LEAK_LOG
In-Reply-To: <20240701034911.GE610406@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 30 Jun 2024 23:49:11 -0400")
References: <f4ae6e2a-218a-419c-b6c4-59a08be247a0@gmail.com>
	<20240701034911.GE610406@coredump.intra.peff.net>
Date: Mon, 01 Jul 2024 12:29:26 -0700
Message-ID: <xmqq5xtox65l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 3B946396-37E0-11EF-805C-C38742FD603B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Jeff King <peff@peff.net> writes:

> On Sun, Jun 30, 2024 at 08:42:06AM +0200, Rub=C3=A9n Justo wrote:
>
>> This has already been sent:=20
>> https://lore.kernel.org/git/54253e98-10d5-55ef-a3ac-1f1a8cfcdec9@gmail=
.com/
>
> Thanks for that link. As soon as I read the subject, I thought "Uh oh,
> wasn't there some tricky complexity here?". But going back to that
> thread explained it all. :)
>
> I think the patch you've sent here covers what was discussed there, and
> is the right thing to do.

Thanks, both.
Will queue.
