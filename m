Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A8B3211
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717606066; cv=none; b=bKXMO574e+UT3JS9dv/cFXN9xYp39/H76mLhwK31TPDJ84kA0oyzgSbBKlphHQUsQ3aywFfy0sS1tSRvsCG/6PTQVntqgMin9sPNwbdPNbwmG46I3uCOGGOecZIAOI04e6ZxSSKDbn3GFFw1I+YyFVnq9gIpjeJA0c6vAyLl/Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717606066; c=relaxed/simple;
	bh=c9FaH4o6n4b+cswQNOF78OLsVFxONVjvxYGC3ZUNi1k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xr4Y50HzCZFCJAyRrlAGlxn06YvEctqGkA5UAp8s40Vbn3g3HWSMx4Y3+aaGz/k7JnyLFiybvNayy5Cs1JSFwcS40EFRVJ40OHvlmanEeMYvF11x6r4YxWT64Bu0JamZ6LBoLPZV1waQf8WOWvT2b4DYvklVmzQ7HRx1TixXEgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=W5vonncX; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W5vonncX"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 20D0625D4E;
	Wed,  5 Jun 2024 12:47:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=c9FaH4o6n4b+
	cswQNOF78OLsVFxONVjvxYGC3ZUNi1k=; b=W5vonncXWFgfHhdSE8DVOcpjpiPH
	9Ddq2agKVGuRZtNIdIhfF0LCAMpMO0ZmG+o15zbcS/K4YJHXGxowQB6FXeGehCxf
	Z8k2KCJkzHhJ/pLq3KARLRmjH2fIhSY/uPwq3p1jrNvtlhiSiCkl3wXjuWt2d02W
	9wEBM0iqVR0x6FE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1748F25D4D;
	Wed,  5 Jun 2024 12:47:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 82D3425D4C;
	Wed,  5 Jun 2024 12:47:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org,  German Lashevich <german.lashevich@gmail.com>,
  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/3] diff: fix --exit-code with external diff
In-Reply-To: <6fa51a62-5dc1-4865-9f79-eaf7d65189ab@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Wed, 5 Jun 2024 10:31:32 +0200")
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
	<82561c70-ec33-41bf-b036-52310ffc1926@web.de>
	<e2e4a4e9-55db-403c-902d-fd8af3aea05c@web.de>
	<6fa51a62-5dc1-4865-9f79-eaf7d65189ab@web.de>
Date: Wed, 05 Jun 2024 09:47:42 -0700
Message-ID: <xmqqed9buyj5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 545322A8-235B-11EF-9AB2-B84BEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>   t4020: test exit code with external diffs
>   userdiff: add and use struct external_diff
>   diff: let external diffs report that changes are uninteresting

OK, we now need to mark each external diff driver if we want to
honor their exit status, but that awkwardness is to be blamed on the
original design.  Thanks for addressing the misdesign I made years
ago in the mildest way possible not to introduce any unnecessary
regressions.
