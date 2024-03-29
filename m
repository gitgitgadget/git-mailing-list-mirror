Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6057413C9D1
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 20:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711746002; cv=none; b=oFLufORyFx6OHNFbrI81NJD66/P5KvRey37CgX3nvWVBMMiANAOJzfA8RiljYpKOdWSS4yX/QvjYrGFqd6Acr3iSpwg1NLJgF9yr+n4yQ9tOo1Nw4Oyeor5z6DApy7elTwU+N0zHQfTk0dNMo8umsW4QnBouFtyItmoI3oQ7/d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711746002; c=relaxed/simple;
	bh=z7qexvuXaYICrgNBaOWusqO/1HxTQ5g/gWd85Mn4i7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Km6TvoYRaq9XAkgl64wG9R56c4INHrSjPO8fmrxPpg1IbB155P8BOMMvczqp9ISoQ84zkFZy/xCSztH0khXuKA6Z0WffVGs0BNhEk/smLdm4iMiuU6S5eFGfWwlNfgd3rO6LjIpHyQkRwXEG6QLUeQP/CmL4KKw2iB9H5TpRDnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=G3BomjKK; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G3BomjKK"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 995D927AB2;
	Fri, 29 Mar 2024 16:59:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=z7qexvuXaYIC
	rgNBaOWusqO/1HxTQ5g/gWd85Mn4i7c=; b=G3BomjKKlLQ2i6/963BpZmZVWfTg
	rVDpCWX2aB/Y9FX2w88F2JLX7ubqhIWXApzx+8Dic0G4ESPcTX2+agoMEH5hGLZ5
	7IQY7ldouQfwuTr3DO3fHKKJpOkw7CjfS321KR6Mn01XkkMTEneSyMIQltXTxZfU
	PhPZkz2GBO4aBNw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 915B927AB1;
	Fri, 29 Mar 2024 16:59:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0AF7727AB0;
	Fri, 29 Mar 2024 16:59:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] add: use advise_if_enabled for
 ADVICE_ADD_EMBEDDED_REPO
In-Reply-To: <a76a0935-78e6-4ad3-9bf9-989f5ed53b84@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Fri, 29 Mar 2024 20:59:27 +0100")
References: <06c9b422-b22e-4310-ad5b-1686616ab860@gmail.com>
	<0e38da05-efd6-451e-bd8a-b2b3457c0c75@gmail.com>
	<xmqqcyrczzv7.fsf@gitster.g>
	<de916779-3c0c-4cf0-b78e-d0536c65af0e@gmail.com>
	<xmqqjzlkygvh.fsf@gitster.g>
	<a76a0935-78e6-4ad3-9bf9-989f5ed53b84@gmail.com>
Date: Fri, 29 Mar 2024 13:59:15 -0700
Message-ID: <xmqq8r20yct8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 34AB0730-EE0F-11EE-AB9B-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> On Fri, Mar 29, 2024 at 12:31:30PM -0700, Junio C Hamano wrote:
>> Rub=C3=A9n Justo <rjusto@gmail.com> writes:
>>=20
>> >> This one also needs a similar justification, but with a twist.
>> >
>> > May I ask what you would find a good justification?
>> >
>> > Perhaps "newer" -> "now preferred"?
>>=20
>> That is merely shifting justification around.  You'd now need to
>> answer: Why do you consider it preferred?
>
> Because it's newer ;-D

A newer thing is not necessarily better, though.

> Maybe I'll point to the commit where advise_if_enabled() was introduced=
,
> b3b18d1621 (advice: revamp advise API, 2020-03-02). We have some
> arguments there.  I'll sleep on it.

I think I've already given my verison of justification in the
message you are responding to.  I'll stop spending time on this
topic while you are sleeping on it ;-)

