Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352501D546
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 21:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340477; cv=none; b=Avpc4DmO9DJtneBU3SI9DZrw9/sCDgds7HC6b11JuAiGH3j6vrlqyR+/FamJTUXcQt2vX0TVz0+4vUzY/NsPF9WRxPqRWZQ5mPKSlNHbxO/oO5aXfr9QckitjvnsrPoQha2CTtPwNlzlSPY3t5LN0XqAe9zGkJkJVtQKx1EirUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340477; c=relaxed/simple;
	bh=VREXeRe4lvj8+yddb/gUHROtYG2S9s8dKgNSEBgXHl0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YNT/V62OAkIsBS7NMnU6bdmU8LK3/8nvopDk0SjX/uOGuxALZaWkntENe2H9RLeR8/G8GQUHP/h22AT9LgQt1VEk3zfkjYQciNJEqk6TYLFx70KazmkoXBsGvzXCSDoibl6PHgwlmFwO3Uw3gHfRUM+fuIXA5+B3B48xzuweSHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=M/xJhJny; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M/xJhJny"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9C6AC2EE2E;
	Wed,  7 Feb 2024 16:14:35 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VREXeRe4lvj8+yddb/gUHROtYG2S9s8dKgNSEB
	gXHl0=; b=M/xJhJnyHCaclP2pw08on6ujQPiBrRRzkIqPEQ2p3hkWaiSU2ScXeq
	Zd+KQaiYHryWpE9b6Rufy6f3hNfaCmz7LdQx+ryk/fGz6azCzdDiSopowJnTd6+q
	2ZCgzRXpCFo8UyJgGPGyNi4ZqSyJ1QDKDxggAGU76hNI2Ua2LQqIM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 94CB52EE2D;
	Wed,  7 Feb 2024 16:14:35 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4B4A02EE29;
	Wed,  7 Feb 2024 16:14:32 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 0/6] test-tool: add unit test suite runner
In-Reply-To: <cover.1706921262.git.steadmon@google.com> (Josh Steadmon's
	message of "Fri, 2 Feb 2024 16:50:25 -0800")
References: <cover.1705443632.git.steadmon@google.com>
	<cover.1706921262.git.steadmon@google.com>
Date: Wed, 07 Feb 2024 13:14:30 -0800
Message-ID: <xmqqy1bw564p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E3238542-C5FD-11EE-8CE6-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> Some known remaining bits of work:
> * We should investigate switching the Windows CI to use `test-tool`
>   instead of prove. However, Windows CI seems broken on
>   jk/unit-tests-buildfix, and I haven't had time to determine why.
> * We should determine whether it is confusing or otherwise harmful to
>   people's workflow to have the unit tests run in parallel with shell
>   tests when using prove as the default test target.

The first one seems to have been resolved.  The latter can happen
while it cooks, I would presume.  If there is no other comments,
let's mark the topic for 'next'.

Thanks.

