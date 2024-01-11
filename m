Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3A715AC0
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 00:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O6qCLUej"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DCCC432308;
	Wed, 10 Jan 2024 19:04:38 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=V3TqO4oppZxqPYSv4K+gXLXrZ1uFgVJfWZvc8N
	0V2Pk=; b=O6qCLUejyu1HH4js8Z4Gvv0Q0fwNC8j20gHcBFEzMtCr8SGJesRM5m
	E2SjKgSx+EkfHm+fAP77aHT3hF7b3XQ/vgm0Q4l8EQ9AfeQnX/7Ph8MCBxss7erO
	rwgMbhNxf2KkTASAO0QWb6Bhq1Hb3oT0zCnAoZUdmolu9ewMLjtx8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D568332307;
	Wed, 10 Jan 2024 19:04:38 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2171132303;
	Wed, 10 Jan 2024 19:04:33 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: Limited operations in unsafe repositories
In-Reply-To: <ZZ8pbAMNaBDFgf3G@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 10 Jan 2024 23:34:04 +0000")
References: <ZZr-JLxubCvWe0EU@tapette.crustytoothpaste.net>
	<20240110120531.GA25541@coredump.intra.peff.net>
	<ZZ8pbAMNaBDFgf3G@tapette.crustytoothpaste.net>
Date: Wed, 10 Jan 2024 16:04:31 -0800
Message-ID: <xmqq7ckg91m8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FFBE1856-B014-11EE-9DB3-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2024-01-10 at 12:05:31, Jeff King wrote:
>> My thinking is to flip that around: run all code, but put protection in
>> the spots that do unsafe things, like loading config or examining
>> hooks. I.e., a patch like this:
>
> I think that's much what I had intended to do with not invoking binaries
> at all, except that it was limited to rev-parse.  I wonder if perhaps we
> could do something similar if we had the `--assume-unsafe` argument you
> proposed, except that we would only allow the `git` binary and always
> pass that argument to it in such a case.
>
> I don't think reading config is intrinsically unsafe; it's more of what
> we do with it, which is spawning external processes, that's the problem.
> I suppose an argument could be made for injecting terminal sequences or
> such, though.  Hooks, obviously, are definitely unsafe.

Sure.  And we allow the location of hook programs to be specified as
configuration variable values, which would make the config even more
dangerous X-<.
