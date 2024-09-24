Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28402E419
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727199000; cv=none; b=YhriVuPyzxfgzm4TkRC71MX2RdrWUi1yIuf+FdRRCuhBxnw1UCHQfEihnVP2m9eWiFgFux2Q6KVgtGRsxbKz81qjjfTwpM42GIRvXNEnu0IfVZaHYSQD5kPCzGAs0tO8EGeyFEhYd0Psx/Zz2dSMxdkspRAAF1fPR0cWkWj81bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727199000; c=relaxed/simple;
	bh=VhqJpfucwTQyzmcHrqdno1c1KoQCyKRQXQP6Mypklxs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b19zOeU+13jQXc3zjvgbqVxOw3KLkB8RaAnVyDmtYWHke9eDr/fFU1xm8MjT4H6dLx0sjjGaXk2sfSEvyjeKn1K+UpzsfxheHuP/mr0YSNg4dnJFs1REYd5xRtu2Qb1JbUGoC9bvIwLmDC1Ro7pE/G27X6A715bJ0amYasQK3QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AY2JAcNH; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AY2JAcNH"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B1C21A8D7;
	Tue, 24 Sep 2024 13:29:57 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VhqJpfucwTQy
	zmcHrqdno1c1KoQCyKRQXQP6Mypklxs=; b=AY2JAcNHA47gcObzID66mpxNVCEz
	KZiqmxbuyroOipKHj/Zy3ecxgVj6ou3CLDNMF4W9GP3vUCAmKee6otRyKIcd/CGm
	km6ZpFamzptFmXo0i6Mu1dqSOp3Iv9nGg5KZZD3Eg96TdbOOQ0MyjBj5wuRimI9S
	OWVvD+fBdoKIoB4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F9FF1A8D6;
	Tue, 24 Sep 2024 13:29:57 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A7F2D1A8D5;
	Tue, 24 Sep 2024 13:29:56 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Eric Ju <eric.peijian@gmail.com>,  git@vger.kernel.org,
  calvinwan@google.com,  jonathantanmy@google.com,
  chriscool@tuxfamily.org,  karthik.188@gmail.com,  toon@iotcl.com,
  jltobler@gmail.com
Subject: Re: [PATCH v2 4/6] transport: add client support for object-info
In-Reply-To: <CAP8UFD0WVgTfgY5aBr8wUxFWi8ggTxL66jnRLLnVkTOniL0Wvg@mail.gmail.com>
	(Christian Couder's message of "Tue, 24 Sep 2024 13:45:44 +0200")
References: <20240628190503.67389-1-eric.peijian@gmail.com>
	<20240720034337.57125-1-eric.peijian@gmail.com>
	<20240720034337.57125-5-eric.peijian@gmail.com>
	<CAP8UFD0WVgTfgY5aBr8wUxFWi8ggTxL66jnRLLnVkTOniL0Wvg@mail.gmail.com>
Date: Tue, 24 Sep 2024 10:29:55 -0700
Message-ID: <xmqq1q19ufho.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 9E0F6B36-7A9A-11EF-BA2E-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Sat, Jul 20, 2024 at 5:43=E2=80=AFAM Eric Ju <eric.peijian@gmail.com=
> wrote:
>
> [...]
>
>>  fetch-pack.c       |  24 +++++++++
>>  fetch-pack.h       |  10 ++++
>>  transport-helper.c |   8 ++-
>>  transport.c        | 118 +++++++++++++++++++++++++++++++++++++++++++-=
-
>>  transport.h        |  11 +++++
>>  5 files changed, 164 insertions(+), 7 deletions(-)
>
> Karthik suggested adding tests at this stage, but I see no tests here.
> Maybe the tests are added later, but I agree with Karthik that it
> would be nice to add them early if possible.
> ...
>> +       if (args.object_info) {
>> +               struct ref *ref_cpy_reader =3D object_info_refs;
>> +               for (int i =3D 0; ref_cpy_reader; i++) {
>> +                       oid_object_info_extended(the_repository, &ref_=
cpy_reader->old_oid, &args.object_info_data[i], OBJECT_INFO_LOOKUP_REPLAC=
E);
>
> This line might want to be folded.

Thanks for a review on this long patch.
