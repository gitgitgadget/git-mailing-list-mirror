Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEA0154C17
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134961; cv=none; b=By/8TrO4y+zBM9JDgocp9DhXZGfE9uRkCfFM5sk9GYFORwBJQAleHW7EgJzRJG+tR3lQqvZJn8UIMrKaIUVNxSKEKeDuan9kNdy1boOTs+/39OVsEqq4g8+lbAttFlV39e4+bJq/c/t9WVCfIVn4ghU4+tmP8mrKBWzgfZ/ToNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134961; c=relaxed/simple;
	bh=vQ0S10bTmthUvUAwZvU43iDYCVo1YlDzrXF6M5pKPSU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dVk6aGVoCewKsg/LEBBxOZpGJDV27MPS3w8l9tThQJAE+aF4NxJOUdGZ3NuwWzx4NPTXwwyousGM1CoDl/YNQjXtyj3/ARDyLAQVIQebnsH1XvoE1QSkNAkTYKoMvwNkTSh8ZPKwdci0dxSaHVIneB5YAGWUo3wJ+X300L+K9RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jQrf1rgr; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jQrf1rgr"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9BF9F22B16;
	Thu,  8 Aug 2024 12:35:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vQ0S10bTmthU
	vUAwZvU43iDYCVo1YlDzrXF6M5pKPSU=; b=jQrf1rgrgYWrb8Li2x6ofqSOOWd+
	9yaWaSZFcMWFz4kEtcOEJlYN1rwQ7oBRFjxwcWFyy9lka8ZGnjdWmcOErluk1mQJ
	QqxzOKVdhGVYXsmai6o384Os2cepHKaE8rXn79ggqk9V7MeSeTc4bqXsbOdSmdYe
	gUK/J8nWatZp8mo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 92FB022B15;
	Thu,  8 Aug 2024 12:35:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E6DF922B14;
	Thu,  8 Aug 2024 12:35:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phil Sainty <phil@catalyst.net.nz>
Cc: pclouds@gmail.com,  git@vger.kernel.org, hvoigt@hvoigt.net,
 me@ikke.info, rafa.almas@gmail.com
Subject: Re: Adding nested repository with slash adds files instead of gitlink
In-Reply-To: <s5wr0azfeh9.fsf@catalyst.net.nz> (Phil Sainty's message of "Thu,
	08 Aug 2024 23:20:18 +1200")
References: <s5wr0azfeh9.fsf@catalyst.net.nz>
Date: Thu, 08 Aug 2024 09:35:55 -0700
Message-ID: <xmqqed6zht04.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 499AF0EA-55A4-11EF-A9E2-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Phil Sainty <phil@catalyst.net.nz> writes:

>> On Wed, Jun 20, 2018 at 1:55 PM Rafael Ascens=C3=A3o <rafa.almas@gmail=
.com> wrote:
>> > On Wed, Jun 20, 2018 at 5:39 AM Kevin Daudt <me@ikke.info> wrote:
>> > > What this is about that when doing `git add path/` (with trailing =
/),
>> >
>> > This is what I was referring to. If you search for 'Fake Submodules'=
,
>> > you'll see that some people were/are intentionally using this instea=
d of
>> > subtrees or submodules. Unfortunately the original article [1] seems=
 to
>> > be dead, but searching url in the mailing list archives leads to som=
e
>> > additional discussion on the subject [2,3].
>>
>> Abusing a long standing bug does not make it a feature. I'm not
>> opposed to having a new option to keep that behavior, but it should
>> not be the default. If you use it that way, you're on your own.
>
> Was such an option ever worked on?

No. =20

I do not recall hearing anybody who have been active in the
development community saying anything good about such an option.
For the past 6 or so years, nobody who actively works on git thought
it was an interesting and/or useful thing to work on.

I cannot quite say that they thought that it is actively a bad idea
to offer such an option, though.
