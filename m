Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF201C688
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vFp5djKL"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3C03B2A289;
	Wed,  3 Jan 2024 11:02:51 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5Vx1/NE1sIv+DMGOEUZkJnKCL13RpcKxmYvrP5
	TH9/k=; b=vFp5djKLjJ8AxG5ueqFSxPPhoi0UlQQuaCgei1nJQpy+JgExIIfj96
	LI7+gKcciIDegHWQr0OWD2iwHQneURaLCSxE9ZxYCl6TrE2dp7imIK/aNbPKD/HJ
	2ujNUXYWsXFKWJC+lDxDZRTkT3t04h+Urn8hsRugO5GqspDOiuFW8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3336A2A288;
	Wed,  3 Jan 2024 11:02:51 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BB0FA2A287;
	Wed,  3 Jan 2024 11:02:47 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  Taylor Blau <me@ttaylorr.com>,
  git@vger.kernel.org,  christian.couder@gmail.com
Subject: Re: [PATCH 2/2] ref-filter: support filtering of operational refs
In-Reply-To: <ZZWCXFghtql4i4YE@tanuki> (Patrick Steinhardt's message of "Wed,
	3 Jan 2024 16:50:52 +0100")
References: <20231221170715.110565-1-karthik.188@gmail.com>
	<20231221170715.110565-3-karthik.188@gmail.com>
	<xmqqzfy3l270.fsf@gitster.g>
	<CAOLa=ZRedfBUjukbN8dFT9CZETe4pz1UR+eWfJwORWuMHSk0Rw@mail.gmail.com>
	<xmqqsf3oj3u8.fsf@gitster.g>
	<CAOLa=ZTPxWXnZ8kpBB7=cybNfdEv6d6O37Em7Vpmcw=enpY1_w@mail.gmail.com>
	<ZZRaOhK869S1Sg1h@nand.local> <ZZUgUUlB8A-rhep5@tanuki>
	<CAOLa=ZS4OOAmyRvf4HH-c_3GvnVkh6zS2kD3hEhRZ7NZT-rvyA@mail.gmail.com>
	<xmqqwmsqbhyt.fsf@gitster.g> <ZZWCXFghtql4i4YE@tanuki>
Date: Wed, 03 Jan 2024 08:02:46 -0800
Message-ID: <xmqqsf3ebe1l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 89E8020E-AA51-11EE-BDB8-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The downside of an empty prefix is that you wouldn't be able to filter
> refs outside of the "refs/" hierarchy in case we'd use the empty prefix.
> A better alternative would be to use "/" as an indicator that you want
> to list refs outside of "refs/". That'd allow for more flexible queries:
>
>   - "/" prints all refs and pseudo refs, even those outside of the
>     "refs/" hierarchy.
>
>   - "/refs" prints your normal refs.
>
>   - "/something/else" prints refs in "$GIT_DIR/something/else".

I do not get this at all, sorry.  What makes your "/" cover "refs/"
but not "something/"?  Unless you have some rule that special cases 
"/" to apply the "hierarchy prefix" matching rule unevenly, that is
not possible.  So you can easily lose the "/" all of your above
patterns share, go back to what I showed, and apply the morally
equivalent special case to an empty prefix and you'd be OK.

In any case, I do not think supporting anything other than
pseudorefs and HEAD outside "refs/" is a good idea to begin with
(the "worktrees/$name/" example), and requiring that all normal
references live inside "refs/" hierarchy is a good idea, so all of
the above is moot, I would say.

Thanks.
