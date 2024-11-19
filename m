Received: from mail-01.sigsum.org (mail-01.sigsum.org [91.223.231.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271511C1F24
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.223.231.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732010792; cv=none; b=BIajej6JiHz7mJxmwEa6LvgIMLADGFllVJq97oss58UX5b1GaaHAEpuAgAknLSXXU+ffwAptXJDiuANBntL2PrIy/jdLvdXlLNZngQu8aqinNzBwxH09egfaKzEvio1ANBDZhVOqHYMgfHSPtM86jdAZXxt6yftAosIiCtcb8hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732010792; c=relaxed/simple;
	bh=jkJhAbD2F+3qlPjL0Wi1vhTgFkdY9+FPXgvWymlZi8Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SJEe8V5Zkrn+bZ4yIEvGbCiOnPVDluLOu+8NciXLUh/sojfevyOqQzk0yKDZkJVXzXa+mUk2G/GaGAt0E5sP1UEakPsxAqQ/4EbQfG6ctF0TZQ5rU7lZZLgsJ2B+I/l4yoSVbPcN+2D3xnqdYEqJwVakTBNsAEjuyeOMpkIJ3J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=glasklarteknik.se; spf=pass smtp.mailfrom=glasklarteknik.se; dkim=pass (2048-bit key) header.d=glasklarteknik.se header.i=@glasklarteknik.se header.b=QU2wqutI; arc=none smtp.client-ip=91.223.231.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=glasklarteknik.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glasklarteknik.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=glasklarteknik.se header.i=@glasklarteknik.se header.b="QU2wqutI"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2334CC083E;
	Tue, 19 Nov 2024 11:06:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glasklarteknik.se;
	s=dkim; t=1732010786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lgKoRu98LYJ9fDaPmzxvmRZ27bfUCevuEdMxUUIU7uo=;
	b=QU2wqutI7Y63b2Bu+J8kGL+w9rsux9ghJgW6FaOWWLvSj7zO6r2WlieBQRrH1ny6jcVpy8
	6cK6+yT+EvrULEGtx5MDstsLpJxC85gEyUbO1Gnf+0aKWszLb9KAWZudhODbQho2QH5r9X
	f7fEieI49auNWpeY8PDUh6wtsuVw4LVyD7FAdhC07CEsOCZVpFgmA6rZca8Yl70paZEa8W
	LneQLhmuQU5pghnddd8fbRk3MV6vauBzUp9l092YJFzYTrvs9rPIoBPC9VUPZpnXkRlTk1
	Z7cyXsxnsoo4EWK3Hg7KV6SuDhrwVCkZfeZCio0e5e3oheOnIb+1mYqqhbFeEw==
From: =?utf-8?Q?Niels_M=C3=B6ller?= <nisse@glasklarteknik.se>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: Unexpected effect of log.showSignature on tformat:%H.
In-Reply-To: <xmqqmshvd0nn.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	19 Nov 2024 18:37:48 +0900")
References: <87cyirtweq.fsf@localhost> <xmqqmshvd0nn.fsf@gitster.g>
Date: Tue, 19 Nov 2024 11:06:21 +0100
Message-ID: <878qtftu5e.fsf@localhost>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Junio C Hamano <gitster@pobox.com> writes:

> It is a bit unexpected, but knowing how the command options evolved,
> it is not all that surprising X-<.  If you are using --format, you
> are expected to use the %G placeholder and friends when you are
> interested in signatures.

The thing is, I'm generally interested in signatures when using git
interactively (that's why I enabled log.showSignature globally). But
then I have a scripted usecase that has a tag name, and needs to query
the corresponding commit hash, and in that context, I don't care about
signatures at all. The docs for git show say that %H expands to the
commit hash, which is exactly what I want. I didn't know about the %G
formats, but after a quick look at the docs, I don't think they solves
that problem.

I can work around this problem by using "export
GIT_CONFIG_GLOBAL=3D/dev/null" in the script, which I guess might be
generally good practice when using git in scripts? But I still think it
would be useful if there were an easy and reliable way to get from tag
to commit hash, regardless of the user's config settings.

Regards,
/Niels M=C3=B6ller
