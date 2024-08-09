Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0767115FA8A
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230402; cv=none; b=tQf2KfWJicjxGB93rPfmIuOiLeo5hWD4gAaYy4sPPWRX2HW3Wbfp3K/F7g/4tGWt2lsq8Q0VxTsvxuI9rBZTIsHLzZqRFDkJ5anhuBFUVgKITwiqnbxXkyD6Q/FcZeuxJOkSL5i0iauFcDQwvMg369IBDMKcVIx9mD9jqOQZGPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230402; c=relaxed/simple;
	bh=zvLGTNJGOxqa0Cs6WwinANH185WJJqmix90LxzokWlU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J7ws3Lz1PgTXBMh9S7sTICNLsSPs114lNXCb8OiV3dsPo0w6dpQzP3o36MqfwY3nspQjiQMk5Qxc0DJHPjn038ZRcva84rCwzB1WTREEvuoR3rz8T/iLqbOwe20s6/wl5rT5DnTEEupPKdFbdgNx6NlkD2/K0XFeMUNIDQ/Oyz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=N1nPQjYl; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="N1nPQjYl"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9294F2EF4E;
	Fri,  9 Aug 2024 15:06:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zvLGTNJGOxqa0Cs6WwinANH185WJJqmix90Lxz
	okWlU=; b=N1nPQjYlQSvB/M7ZDzIRmSYBVbmJ7xHHdStuJdq6IgPl8aIHaynRpu
	NLivic+sOJBgD1ggfxWMLNDPuI6d875k4Vw1yVE81n1PddSfdolCkYxbPqfVhjx1
	C5O5YG8j3NiQ78fCeIQvZmrf0RS51Hqs5uOnkMBG5QTf2UU4JDLCE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8AEB72EF4D;
	Fri,  9 Aug 2024 15:06:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0FD102EF4C;
	Fri,  9 Aug 2024 15:06:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 3/4] t-reftable-readwrite: use 'for' in place of
 infinite 'while' loops
In-Reply-To: <20240809111312.4401-4-chandrapratap3519@gmail.com> (Chandra
	Pratap's message of "Fri, 9 Aug 2024 16:35:43 +0530")
References: <20240807141608.4524-1-chandrapratap3519@gmail.com>
	<20240809111312.4401-1-chandrapratap3519@gmail.com>
	<20240809111312.4401-4-chandrapratap3519@gmail.com>
Date: Fri, 09 Aug 2024 12:06:35 -0700
Message-ID: <xmqqfrrdcy84.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8058E0A4-5682-11EF-B81B-BF444491E1BC-77302942!pb-smtp20.pobox.com

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> Using a for loop with an empty conditional statement is more concise
> and easier to read than an infinite 'while' loop in instances
> where we need a loop variable. Hence, replace such instances of a
> 'while' loop with the equivalent 'for' loop.

Quite honestly, the above is counter-productive if pushed as a
general guideline, because the goodness of it depends what happens
in the third part of the for () control (i.e., what should happen at
the end of each iteration and if it wants to be bypassed in the
conditional inside the loop).

In this particular case, it probably is OK, but still is a
subjective, borderline Meh, to me.

I see no violation of correctness in the rewrite, though ;-)

