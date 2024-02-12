Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA0D1DDC5
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773236; cv=none; b=iqW4nQMTpgzpvjq3yMlFnv4MHP1tecjPjBiWQMSDcUt7FH5auTz4a5nfGDvhvOedgDJgcEMVJxbpvLkgU28UjOzv9sXU8uvO/D5l0RnQHZZasxc909K0miwAEBUZrxj54GmMET9RfGEnRsNnaiKbtYeySMqV7lEuI/jw109mawg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773236; c=relaxed/simple;
	bh=Sm/GGCEVz/fbQsmF0kpLt0SVBF7iYaTj3gIKKiRplas=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=izY4gTwEHV34F5BfObstQzfQ1ctPHEgyvBJUXZK3p5WldMGOOtzXW5+AFsxC2aJzyIRZLap6VYM8iROMei7RzOKBkxGZ0DiIdFd5/bZU+lwxXQNS3pE9xHnvf7yB75EuMOTPty7Ta7Iq5C7nJOMjt0YGSK/wY7ZcQuVNOX62YZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LwclipAk; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LwclipAk"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 153A41E03E7;
	Mon, 12 Feb 2024 16:27:13 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Sm/GGCEVz/fbQsmF0kpLt0SVBF7iYaTj3gIKKi
	Rplas=; b=LwclipAk70MD6YUyTt5EFn1+HESfKxNeDBXZQliy7/KFNtm3MiVxhK
	RvZDP3P9PVMgXh/fGq7FSn40OqB4A634YzBGl5UGoWKfgWJrlJmf4SN1bGXbwS+G
	RrA1qASgXaPUwk595h2az/oOtrx8yYvKoVjHhx+Q1DBRZd5MCIpbE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BAA81E03E6;
	Mon, 12 Feb 2024 16:27:13 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6855C1E03E5;
	Mon, 12 Feb 2024 16:27:12 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,
  johannes.schindelin@gmx.de,  phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 1/6] t0080: turn t-basic unit test into a helper
In-Reply-To: <ZcqFOVuR0sxFDDUv@google.com> (Josh Steadmon's message of "Mon,
	12 Feb 2024 12:53:13 -0800")
References: <cover.1705443632.git.steadmon@google.com>
	<cover.1706921262.git.steadmon@google.com>
	<da756b4bfb9d1ce0d1213d585e72acfbf667e2a2.1706921262.git.steadmon@google.com>
	<20240207225802.GA538110@coredump.intra.peff.net>
	<ZcqFOVuR0sxFDDUv@google.com>
Date: Mon, 12 Feb 2024 13:27:11 -0800
Message-ID: <xmqq34tx5q6o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7C45EDF8-C9ED-11EE-BA9F-25B3960A682E-77302942!pb-smtp2.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> I see this line in the docs [1]: "As with wildcard expansion in rules,
> the results of the wildcard function are sorted". GNU Make has restored
> the sorted behavior of $(wildcard) since 2018 [2]. I'll leave the sort
> off for now, but if folks feel like we need to support older versions of
> `make`, I'll add it back.
>
> [1] https://www.gnu.org/software/make/manual/html_node/Wildcard-Function.html
> [2] https://savannah.gnu.org/bugs/index.php?52076

Thanks for digging.  I thought I was certain that woldcard is sorted
and stable and was quite perplexed when I could not find the mention
in a version of doc I had handy ("""This is Edition 0.75, last
updated 19 January 2020, of 'The GNU Make Manual', for GNU 'make'
version 4.3.""").



