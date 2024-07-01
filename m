Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6530A172BC9
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 23:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719877421; cv=none; b=gLLf6aRqzPRpbfGHAIulcnCj4B45oPors1g2awP6faZpqoK/P2rrrmM6MLdjhF/LpwSaqy9rl9yvtr9X7+YYdq2WmP4WEFk+UsqOMY55WG1p++KnjDj0X0S7lp276JPZLHluYGFI264ekfVBnx/yso66adaXl7geOx01RZBRPLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719877421; c=relaxed/simple;
	bh=52huoV51HXwWLO21TfVl391g+9jFkS6bl1VnmgLiwsc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PZuj6HootQKiRJh4fyagIarsveyzPOoDqKKVz2GjPW5usCHTUTY1bCm2ok5kBHhiIFS+wd8CBUitmxEN6lXhwVH/r1GdTnogald3qP4LZE6RJz5cfzaaFMh14v4SMSg88CjhK+4xLEJYFZhD8ozQthvTvv1LwjSd1/B+Tr3OTdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pi/yjxJf; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pi/yjxJf"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 43D092CC00;
	Mon,  1 Jul 2024 19:43:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=52huoV51HXwWLO21TfVl391g+9jFkS6bl1Vnmg
	Liwsc=; b=Pi/yjxJfI7BPUWnoB69uCndSC6BP24wszY4o4czny0xUJeAoq5Ex54
	IWO+x/2D8VqoFNTF4RxFUz0r3v0bnGvkYVShE/icFxOexzY2srvJpVCGNcafY2ju
	cKhl0lmVjw5jZfslUzpBkzp47LQxaCvsbAPZVWq/FBqOHzwkDsWZM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A9142CBFF;
	Mon,  1 Jul 2024 19:43:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AC1032CBFE;
	Mon,  1 Jul 2024 19:43:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?=
 Scharfe
 <l.s.r@web.de>
Subject: Re: [PATCH 1/2] test-lib: allow test snippets as here-docs
In-Reply-To: <CAPig+cQdioTBinkacLFb7yktm168oB+qyP9MpZtTRE=1aBz5yg@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 1 Jul 2024 18:45:19 -0400")
References: <20240701220815.GA20293@coredump.intra.peff.net>
	<20240701220840.GA20631@coredump.intra.peff.net>
	<CAPig+cQdioTBinkacLFb7yktm168oB+qyP9MpZtTRE=1aBz5yg@mail.gmail.com>
Date: Mon, 01 Jul 2024 16:43:37 -0700
Message-ID: <xmqq8qyku192.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BD81B9B2-3803-11EF-BDF9-965B910A682E-77302942!pb-smtp2.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> We lose `chainlint` functionality for test bodies specified in this manner.

Ouch.

> Restoring such functionality will require some (possibly)
> not-so-subtle changes. There are at least a couple issues which need
> to be addressed:
>
> (1) chainlint.pl:ScriptParser::parse_cmd() only currently recognizes
> `test_expect_* [prereq] 'title' 'body'` but will now also need to
> recognize `test_expect_success [prereq] 'title' - <body-as-here-doc>`.
>
> (2) Until now, chainlint.pl has never had to concern itself with the
> body of a here-doc; it just throws them away. With this new calling
> convention, here-doc bodies become relevant and must be returned by
> the lexer. This may involve some not-so-minor surgery.
