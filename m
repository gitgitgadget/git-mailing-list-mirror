Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DC3762CD
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 23:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712619268; cv=none; b=lDG+CiuhE3BQDKbmZbikbLP+uoV0x/JJvBoWRvJu8UaftVQj4uG0rQIYn2S4AkWmQKJOiJDNn5srMapiciNtV2BlWqMyiQN5I4bEw2stWlSHHImf+lNoOS5Qz4wmuagOS848BFyhfBV0t9YrLcjSiqboZ5NX0aEwTXpv6v5YS6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712619268; c=relaxed/simple;
	bh=sYQCrAA2us/fEsYL70vtlQLRIhvgzXMLiGZv/5/tGm4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JUy1IPb8/hc1jdNArqqpUZAZL4ZaFNltZIuVV4F2boptPEtggB6gATkOrhH9F2rD5aeFUWYh5StYT+RLKH15KTza0DTYTEDLMApXNdmwLl8P9LC47El9HtGOJ/z98cNf1rKhrBdnO82Kk10m74GAsmih7SZG5OYHAbeJKOLBa4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=b1dpLdkp; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="b1dpLdkp"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D1DE02096E;
	Mon,  8 Apr 2024 19:34:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=sYQCrAA2us/fEsYL70vtlQLRIhvgzXMLiGZv/5
	/tGm4=; b=b1dpLdkp02Hh3IvQE7oe35hEmF2afCcmqhyLTFDNmEqTqibygyzpDU
	37j7qVD2YhhjMK/fJPUaHqv9LzrPcFKiG7IAY35hVju4ORS0enmTO5Z1E9SBtkX4
	h+v4r81hrDGO5ponUXVsjl4NxkIl1JXA45SG7ywssOccrS05mIbW8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CA30D2096D;
	Mon,  8 Apr 2024 19:34:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5535F2096A;
	Mon,  8 Apr 2024 19:34:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Paul Smith <psmith@gnu.org>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Dario Gjorgjevski
 <dario.gjorgjevski@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH] Makefile(s): avoid recipe prefix in conditional statements
In-Reply-To: <606990048585347654f3b4b187ec27f4dc1b85e3.camel@gnu.org> (Paul
	Smith's message of "Mon, 08 Apr 2024 19:24:16 -0400")
References: <CAJm4QYOxn_s8ktJiC6ju2j4OyEYaM2ay7Ca--ZWFWa7APVnTbA@mail.gmail.com>
	<9d14c08ca6cc06cdf8fb4ba33d2470053dca3966.1712591504.git.me@ttaylorr.com>
	<xmqqle5n8rcr.fsf@gitster.g>
	<606990048585347654f3b4b187ec27f4dc1b85e3.camel@gnu.org>
Date: Mon, 08 Apr 2024 16:34:21 -0700
Message-ID: <xmqqh6gb5szm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 87C9C1F6-F600-11EE-A7D2-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Paul Smith <psmith@gnu.org> writes:

> Just to note that this usage clearly contravenes the documentation,
> which states that preprocessor statement lines cannot begin with a TAB.
> It was a bug that this was allowed by the GNU Make parser.
>
> I understand that in many projects (Linux, probably Git :)) if the
> documentation and behavior disagreed then the documentation would be
> changed, not the behavior.

If a bug is left in a released version long enough, it becomes a
feature your users depend upon.  We saw that happen to us, I am sure
the mantra "don't break userspace" the kernel project had comes from
the same place.

I am not sure what benefits are gained by the existing users with
this change to ease fixing some parser bug (I didn't bother to see
your bug tracker) so I cannot judge if the benefit outweighs the
cost of them all having to scramble and adjust to the new world
order.

