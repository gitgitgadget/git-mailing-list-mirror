Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5687212B72
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 18:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709316436; cv=none; b=g6z8czAFxpgkjOmdfDD623va99A9scaehW0JrszEOU5YFTVUMmm0T2RflFg+4YK5x4GiL/1g05QE3R72Td5BnoIhme4Ch1TqZ3jvj2op1+Limaf+u0KtfjdnnFYiLFViUhkvdndTS5wRnAUDGG6QbTsbu58FcvIrnR1W5RrfBg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709316436; c=relaxed/simple;
	bh=unj0eMpnOY9MRYo2MaO5c7Rr4ckP33pYmGv1JjeTKZ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gkj/XdIyCtmLohjlSEqOIrZfJPtwhahjr+wtRxjJxON5I8Ie6QLy/eoFKxZtzqww2E5CEAK6Tjek1CF1br2Rm+fi40DxkN8K3wbK0JOEzu7E9G1fKyuAvsNN7LvOLiIj2k6Ynnlu4uvIHvdOH4mHy2fGTFFvaIjLwEuFpqQ8DFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KUagYBmd; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KUagYBmd"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2ABB31E136;
	Fri,  1 Mar 2024 13:07:15 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=unj0eMpnOY9M
	RYo2MaO5c7Rr4ckP33pYmGv1JjeTKZ4=; b=KUagYBmdRnq8Zar9CA0rzz5dvga2
	/EuRU2XMrAAPPD+cgpxtaVyuf4MHHKgxf3f1YJzz228fgiNlB7SngWLvRSoJKulM
	3t9etXowsetFN1ecsX7HGjGp8XGmsoWgnTGVqVHDQ2UJZIIIyRAYP27I29p/KXHe
	Ii6bfwq7YTGFcfg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 232121E135;
	Fri,  1 Mar 2024 13:07:15 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3093D1E134;
	Fri,  1 Mar 2024 13:07:12 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Sergey Organov" <sorganov@gmail.com>,  git@vger.kernel.org,
  =?utf-8?Q?Jean-No=C3=ABl?=
 Avila <avila.jn@gmail.com>
Subject: Re: [PATCH] clean: improve -n and -f implementation and documentation
In-Reply-To: <86ce3c89-4a58-42bf-a31a-96fa6b74e937@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 01 Mar 2024 16:29:38 +0100")
References: <xmqq34v6gswv.fsf@gitster.g> <875xy76qe1.fsf@osv.gnss.ru>
	<51a196c0-ea57-4ec5-99ea-c3f09cd90962@gmail.com>
	<87frxam35f.fsf@osv.gnss.ru>
	<86ce3c89-4a58-42bf-a31a-96fa6b74e937@app.fastmail.com>
Date: Fri, 01 Mar 2024 10:07:10 -0800
Message-ID: <xmqqttlp6d2p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 87035872-D7F6-11EE-9687-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> On Fri, Mar 1, 2024, at 15:34, Sergey Organov wrote:
>>> Please use backticks for options, configuration and environment names=
:
>>> `clean.requireForce`
>>
>> I did consider this. However, existing text already has exactly this o=
ne
>> unquoted, so I just did the same. Hopefully it will be fixed altogethe=
r
>> later, or are you positive I better resend the patch with quotes?
>
> Sometimes I see widespread changes (like formatting many files) get
> rejected because it is considered _churn_. Not fixing this in this
> series and then maybe someone else fixing it later seems like churn as
> well. Isn=E2=80=99t it better to fix it while you are changing the text=
?

Any one of these is fine:

 (1) add the new paragraph with mark-up consistent with existing
     text (which is what Sergey did).

 (2) add the new paragraph with correct mark-up, making the document
     less consistent overall.

 (3) have one patch to fix broken mark-up of existing text, followed
     by another patch to add the new paragraph with correct mark-up.

If you take one of the first two, it would be a very good idea to
have a comment in the proposed log message to note the need for
later clean-up.  Without being written down anywhere, your discovery
and the brain cycles you spent while deciding what to do will be
wasted, which is not what you want.

Thanks, both.
