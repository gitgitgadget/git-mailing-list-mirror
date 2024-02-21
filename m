Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255A212D756
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708555591; cv=none; b=PW1ZH79H3IJxbRyTkRH4GA6nLQSslHWu57qYGZjzqQ3y2e/XO98mF2tvDo+4F93+eolX8b4K6Okh/eugxi1f6oJgkki0mL2Ukb+MoEq+C4aKqa1WAwVSFN2eFwor06xDfYRrv0oP+QN0cMvwIH5vWssJjFABtZqeYgBre1br8Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708555591; c=relaxed/simple;
	bh=9UbSAnBVIhAKN4GhN2qOPLJMWVftKF8tPX0EN2ULnVM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ExER/bYG0bA950uDcv5G0IEP/XOJYXPAG66i/yveGMY3/JG7qMd7cVsWsoif4n0YB4rJhXCNqUkN9pFkZhp7TMAnSH9WdQRFWWxTJjpDI1bKuukhVRGFygDjvSj8O248AZCB2Abkad6nh6I5CkybHLBvIIJyjjFylELxMZLVFBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NLjLZHVR; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NLjLZHVR"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BA5BF1E746E;
	Wed, 21 Feb 2024 17:46:11 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9UbSAnBVIhAK
	N4GhN2qOPLJMWVftKF8tPX0EN2ULnVM=; b=NLjLZHVR7N3is5abAVFoVWk+ObKN
	ceaSQEz4Zfht/mutDLip9rvM5msKVijZEeYV3hDc+bYG/Hx0XC+7guOZc5UR474r
	zoezK7Us8IoX9sMtPqNOvoZH5QFmmQbz6ueqrMSzCJ57DaN97d7PN2GKyCULO0/z
	rze+Y3T5jrCXd1k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B0E041E746D;
	Wed, 21 Feb 2024 17:46:11 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 225BE1E746C;
	Wed, 21 Feb 2024 17:46:11 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,  Harmen Stoppels
 via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Harmen Stoppels
 <me@harmenstoppels.nl>
Subject: Re: [PATCH] rebase: make warning less passive aggressive
In-Reply-To: <2324063.ElGaqSPkdT@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
	"Wed, 21 Feb 2024 23:05:56 +0100")
References: <pull.1669.git.1708442603395.gitgitgadget@gmail.com>
	<xmqqjzmxofvn.fsf@gitster.g> <20240221183018.GB9696@kitsune.suse.cz>
	<2324063.ElGaqSPkdT@cayenne>
Date: Wed, 21 Feb 2024 14:46:10 -0800
Message-ID: <xmqq4je1mo5p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 027CA942-D10B-11EE-A1FD-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

> As a translator, I'm less bothered by editing a sentence to remove a qu=
estion=20
> mark (maybe enforcing a language style and reformulating the sentence b=
y the=20
> way), than by translating again and again similar sentences.

Sure, but if the original in C locale used to be "FOO BAR?" and you
translated it to "foo bar?" in your language, and then a patch
updates the string in the source to "FOO BAR", doesn't msgmerge
notice that the original as a "fuzzy" matching and offer you
something like

    # fuzzy
    msgid "FOO BAR"
    msgstr "foo bar?"

so that all you have to do is to remove '?' anyway?  So I do not
think you'd need to translate the "FOO BAR" part again and again.

But the above assumes that for your language, the ONLY thing to turn
such a rhetorical "passive aggressive" question into grammatically
correct statement of a fact is to remove the question mark.  It may
not be universally true for all languages, and for some language,
even after msgmerge did its job correctly, you may need to do more
than just removing the question mark to adjust the remaining "foo
bar" part.

