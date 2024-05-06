Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364CC15746B
	for <git@vger.kernel.org>; Mon,  6 May 2024 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715016181; cv=none; b=m4rQrwKK3NnaYE9Ko47Uj3MSHhhvvHv5xkxxN+ii62tS4uzUVAMB7/RPqrOGpdYWVCrmnlmQUj+IKy78IiSNcruq1E7yy9+92UjF7s6oRTJZkaOK6vJreA3rUPst2/t5dzeB7mkZMZAgUSgZ34CBy85NX0qTIGKNCY3naz9C77g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715016181; c=relaxed/simple;
	bh=wAB4h54uD8PQYdU38LnzmNTFlI884uPL6MN+fVJGgiM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D+/g1ephgGysQPd3MsEvSksjwYgmjh0+kjgD2mYXu4ScwAA/9umuHHNJeOzJKtWWnZ0NQLlqxzT2/BY2VrAu6UegnZauGJfLtIB4bG/f0vVIKNx8YjIUcLIi30420IspAtg79+Vt7OkQqQsx96bduemuwmqOTmFVXcYjfyfGIhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=sCwkAWRr; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sCwkAWRr"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BCE5E2A67A;
	Mon,  6 May 2024 13:22:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wAB4h54uD8PQ
	YdU38LnzmNTFlI884uPL6MN+fVJGgiM=; b=sCwkAWRrKknzUfCKfFvu1zl+AWjP
	ZW+0bt8BZ5VhRNLdH/Epg8lLoYU05o3MO8IJGzUEY3n2QR38PrTrmFKSRKwxu1Mz
	VAyqGt1WwczbMU0DAbL4fgTVRKbTL00+MaPCRYcefBdlNR31Ed1mvBbL2XHbNhYz
	LnN2TfAzL/XamzU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B5D102A679;
	Mon,  6 May 2024 13:22:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3A7402A678;
	Mon,  6 May 2024 13:22:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: German Lashevich <german.lashevich@gmail.com>,  git@vger.kernel.org
Subject: Re: Possible git-diff bug when using exit-code with diff filters
In-Reply-To: <caa6cca4-182f-4788-b08e-35806879fdca@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sun, 5 May 2024 12:19:50 +0200")
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
	<82561c70-ec33-41bf-b036-52310ffc1926@web.de>
	<xmqqy1961sxf.fsf@gitster.g>
	<caa6cca4-182f-4788-b08e-35806879fdca@web.de>
Date: Mon, 06 May 2024 10:22:54 -0700
Message-ID: <xmqqh6fazwgh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 4733AFB6-0BCD-11EF-924F-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 21.04.24 um 20:17 schrieb Junio C Hamano:
>> A much simpler fix may be to declare that these two features are
>> imcompatible and fail the execution upfront, instead of just
>> silently ignoring one of the two options.
>
> It would not be *that* simple -- if we want to error out upfront we'd
> have to evaluate the attributes of all files (or all changed files)
> first to see whether they require an external diff.

You're absolutely right.

> Reporting the incompatibility in the middle of a diff would be easier,
> but I don't see why we shouldn't support that combination.  It takes
> some effort, sure, but not prohibitively much.

OK.  Thanks.
