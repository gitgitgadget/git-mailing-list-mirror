Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C7612CD88
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720649618; cv=none; b=kxRZhIkqQukElsAQsJ8FjmRcwR13Y/PwVdtaY2xRuCnYNGoSbryMHO2/5gx2vpOFEI1wNnR3onII17zLXEb53VUUYjrzN8pk6dMPMfoIqtiwo2eLS5OqCgrzzvoHOPxp24s2MWKYM+YjwNL0D6ftgu1/139ZHqW3Yd6V+larnGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720649618; c=relaxed/simple;
	bh=VQLU+DISRRUAzzhuWV1bccbdSOKvLIeOONsxyE6F2po=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tpCE4MTQAam6AuvzqHSyszGVjKtxAa5vI7Egw5ApGrVUsBu7diVgTi/c6osbStPlhEp06Y3b89454W/DwhdNdTwnnWLXQINmqVN8yIkVK6weSkY26tapipRqui8XGJVAgEMhWtFV/3VrMQgjFQ1/oyWanTkzrlMsJMQrHZR5iSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mBD2HzPn; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mBD2HzPn"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 589F820B07;
	Wed, 10 Jul 2024 18:13:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VQLU+DISRRUA
	zzhuWV1bccbdSOKvLIeOONsxyE6F2po=; b=mBD2HzPnjX8bI16uiaBAPpGqoNdF
	L9chAcKe5pkrxiLdXQ7LSdsnMjGq/st5YNW4q1fcSrLgdpsnCkor+JzOXYrjhnb/
	UjVj02964Awj6EhVkrxE8PZFSRvhVWSa75sq2kJGsRZ7UW09EzejovIEg33sp75d
	w2HBRDEbahzu51A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E35F20B06;
	Wed, 10 Jul 2024 18:13:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B8EC020B05;
	Wed, 10 Jul 2024 18:13:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,
  Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH 0/6] unit-tests: add and use TEST_RUN to simplify tests
In-Reply-To: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sat, 29 Jun 2024 17:33:38 +0200")
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
Date: Wed, 10 Jul 2024 15:13:33 -0700
Message-ID: <xmqqy168uc8i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 A6382950-3F09-11EF-AB5D-5B6DE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> The macro TEST only allows defining a test that consists of a single
> expression.  This requires wrapping tests made up of one or more
> statements in a function, which is a small, but avoidable hurdle.  This
> series provides a new macro, TEST_RUN, that provides a way to define
> tests without requiring to declare a function.
>
>   t0080: move expected output to a file
>   unit-tests: add TEST_RUN
>   t-ctype: use TEST_RUN
>   t-reftable-basics: use TEST_RUN
>   t-strvec: use TEST_RUN
>   t-strbuf: use TEST_RUN
>
>  t/helper/test-example-tap.c      |  33 +++
>  t/t0080-unit-test-output.sh      |  48 +----
>  t/t0080/expect                   |  76 +++++++
>  t/unit-tests/t-ctype.c           |   4 +-
>  t/unit-tests/t-reftable-basics.c | 228 +++++++++-----------
>  t/unit-tests/t-strbuf.c          |  79 +++----
>  t/unit-tests/t-strvec.c          | 356 ++++++++++++++-----------------
>  t/unit-tests/test-lib.c          |  42 +++-
>  t/unit-tests/test-lib.h          |   8 +
>  9 files changed, 462 insertions(+), 412 deletions(-)
>  create mode 100644 t/t0080/expect

So, looking back the discussion list on

  https://lore.kernel.org/git/85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de=
/

any loose ends still need to be addressed?  I didn't spot any
myself, so I am willing to merge it to 'next' soonish, but please
stop me if there were something I missed.

Thanks.
