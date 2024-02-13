Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49241612F1
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 20:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857378; cv=none; b=pVMvXB1hxwquhlBdanq3y1EPML8z+Ev55yo+si5usaVg0jqrBBwVbZBlMTTbgUF2ayAK3ViqAfQRohm6ibRK8UuJdvVZDtptfb1+ngDIofa1u9eXztNEVFQXTDc7FjOdtaGyxH2Al1eyftDWKdSFrmdn9+YruvSrfp0shu34V4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857378; c=relaxed/simple;
	bh=1KD7gzcubhTqn90gJZdwfIlNJkdfHJYktyswlNflWHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NKrCPuV43Ky3vWpdsueWihrvFLJT8OfC1Z57tGfspNYbZig9xUq+SyLdFKmC3tljHZ9M1HvU+Wqg/bNHaNhVwYUoU/xZLJmq3VkOaQkmM5xOx9g1ErtshaydV7+mADj3herv0csXubkvXHi9XlJ4L9Yf63iZz0kPtLoYpHC/hL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mYyZudsQ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mYyZudsQ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AFFC019FA1;
	Tue, 13 Feb 2024 15:49:36 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1KD7gzcubhTqn90gJZdwfIlNJkdfHJYktyswlN
	flWHs=; b=mYyZudsQihCgOtfR8EIZ/kf4xUYSiIhykhjAyUcgVy0eaZvucdAyp9
	k0FaTLSA9KacnRO5ZT9Bf3OrmvasNsgtlqASy0g3OePPDKLJDKVRszRVfh11+QfM
	FPiwRW4r08N5dSSYvOyiPpI1BlKEV3qAFSTKKNiXRC6URER04bH/4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A895719FA0;
	Tue, 13 Feb 2024 15:49:36 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5869A19F9F;
	Tue, 13 Feb 2024 15:49:33 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusa@google.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] git: --no-lazy-fetch option
In-Reply-To: <owlyo7ck9k3y.fsf@fine.c.googlers.com> (Linus Arver's message of
	"Tue, 13 Feb 2024 12:37:05 -0800")
References: <xmqq1q9mmtpw.fsf@gitster.g>
	<owlyr0hg9kr3.fsf@fine.c.googlers.com>
	<owlyo7ck9k3y.fsf@fine.c.googlers.com>
Date: Tue, 13 Feb 2024 12:49:31 -0800
Message-ID: <xmqqsf1w3x9g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 642D3130-CAB1-11EE-84F6-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Linus Arver <linusa@google.com> writes:

> Linus Arver <linusa@google.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Sometimes, especially during tests of low level machinery, it is
>>> handy to have a way to disable lazy fetching of objects.  This
>>> allows us to say, for example, "git cat-file -e <object-name>", to
>>> see if the object is locally available.
>>
>> Nit: perhaps s/locally/already locally/ is better?
>
> I forgot to mention that the new flag is missing a documentation entry
> in Documentation/git.txt. Perhaps something like
>
>     --no-lazy-fetch::
>         Do not fetch missing objects. Useful together with `git cat-file -e
>         <object-name>`, for example, to see if the object is already
>         locally available.
>
> ?

Wonderful.  Thanks for an extra set of eyes.
