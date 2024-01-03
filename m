Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFC11C687
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 17:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="U6JZw5Rf"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 16CEA1DDBD9;
	Wed,  3 Jan 2024 12:21:15 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=UyGO4ImXeQUuFftf4kG26FR673MRCnkUElp+IK
	+KtNY=; b=U6JZw5RfDrpvVb5C9yF3tvsav1y+Fxnzvd3n37tj29jMEwa3O2bufe
	MQwXamzlRW7+c8kl/ziM94ITLr0yK4jFzGM2B+JOX6RvqrlGurjpoEtqvJhSQYTw
	1OI079F+YDP3grXwNCnmvU5u3+AbaI8wZIz39ha4Kk0jzuvbeBwJQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D8441DDBD8;
	Wed,  3 Jan 2024 12:21:15 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5F5271DDBD6;
	Wed,  3 Jan 2024 12:21:14 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  Taylor Blau <me@ttaylorr.com>,
  git@vger.kernel.org,  christian.couder@gmail.com
Subject: Re: [PATCH 2/2] ref-filter: support filtering of operational refs
In-Reply-To: <ZZWIlx-9D2r9AfDW@tanuki> (Patrick Steinhardt's message of "Wed,
	3 Jan 2024 17:17:27 +0100")
References: <xmqqzfy3l270.fsf@gitster.g>
	<CAOLa=ZRedfBUjukbN8dFT9CZETe4pz1UR+eWfJwORWuMHSk0Rw@mail.gmail.com>
	<xmqqsf3oj3u8.fsf@gitster.g>
	<CAOLa=ZTPxWXnZ8kpBB7=cybNfdEv6d6O37Em7Vpmcw=enpY1_w@mail.gmail.com>
	<ZZRaOhK869S1Sg1h@nand.local> <ZZUgUUlB8A-rhep5@tanuki>
	<CAOLa=ZS4OOAmyRvf4HH-c_3GvnVkh6zS2kD3hEhRZ7NZT-rvyA@mail.gmail.com>
	<xmqqwmsqbhyt.fsf@gitster.g> <ZZWCXFghtql4i4YE@tanuki>
	<xmqqsf3ebe1l.fsf@gitster.g> <ZZWIlx-9D2r9AfDW@tanuki>
Date: Wed, 03 Jan 2024 09:21:13 -0800
Message-ID: <xmqqil4a9vue.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7F46F304-AA5C-11EE-A152-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> ... But the problem is that tools like git-update-ref(1) don't
> enforce this, so something like `git update-ref foo/bar HEAD` happily
> creates "$GIT_DIR/foo/bar". And I bet there are other ways to write refs
> at arbitrary paths.

I think we should tighten things up over time.  First by teaching
the ref backend that anything that is not a pseudoref, HEAD or a
proper ref (one item of whose definition is "lives under refs/
hierarchy) should not resolve_ref() successfully.  That should
correctly fail things like

    $ git rev-parse worktrees/$name/bisect/bad
    $ git update-ref foo/bar HEAD

I'd hope.

Thanks.

