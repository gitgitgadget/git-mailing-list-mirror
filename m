Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3686D2C69C
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398523; cv=none; b=WSg5tgwkNrA418FoMfK4UN7uknzucpsYeucPe778StDJ0x8VN80+5fDeympjKhbn0WRjqV1kpNn+3/xgCZF5xxgW03Mhq2IbJPqsYuzzmyM+BudG9G5mwlA4AlDe+QWf3PrzgccHNW1bo8VGd4CRqpFDHl0KpvLo2WZUdBNwEk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398523; c=relaxed/simple;
	bh=YaQe/MXG2KGT5L9y0ygdDoNxgXUHTXTFzCtQDNcUgmc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DCDVnu32ZEBelrd45tCI0v5IaU8kzX9Byz98JgEL+le2VaZJYQIuvih+jMcwiIzpcJ1PI4ot+IUyua3oh/L8qWvJoPrqkaX7pRp9FhLx9ZGqIcVPljit92ma3GHuvKd98ygjjM112Tcvb8FQ2rMEv23xDeLc7Vnhenqv6lIKBH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PN1TOHFY; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PN1TOHFY"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EBACB21EEC;
	Mon, 29 Apr 2024 09:48:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YaQe/MXG2KGT5L9y0ygdDoNxgXUHTXTFzCtQDN
	cUgmc=; b=PN1TOHFYXSZTvz1b7MHKOhxs7J96tuyJ6kIKP44p5hBghUnh5454Zn
	VlnDsscc12ImoTPP/4C23LbrYkjR4OAn7anAgGxzpu8JdevBauv+ZWqySNZV6DJo
	9vh2/8umOVBLfbwiyIObs4HFdvlA85/pUJmiAO/yFsJ8yvC7DQNNM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E1AC621EEB;
	Mon, 29 Apr 2024 09:48:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 538EA21EEA;
	Mon, 29 Apr 2024 09:48:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: James Liu <james@jamesliu.io>,  git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] advice: add --no-advice global option
In-Reply-To: <37512328b1f3db4e8075bdb4beeb8929@manjaro.org> (Dragan Simic's
	message of "Mon, 29 Apr 2024 06:15:33 +0200")
References: <20240424035857.84583-1-james@jamesliu.io>
	<20240429010925.93205-1-james@jamesliu.io>
	<20240429010925.93205-2-james@jamesliu.io>
	<37512328b1f3db4e8075bdb4beeb8929@manjaro.org>
Date: Mon, 29 Apr 2024 06:48:33 -0700
Message-ID: <xmqqmspc1dqm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2C05FE9A-062F-11EF-B1FD-25B3960A682E-77302942!pb-smtp2.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Huh, I was under impression that having an environment
> variable to control this behavior was frowned upon by
> Junio?

It is frowned upon.  It is secondary who frowns upon it ;-)

We _might_ be able to pass --no-advice to all internal invocations
of subprocesses, but that is a chore, and if a code path calls a
subprocess that is *not* a git program that in turn calls a git
program, such an approach would not work.  But an environment
variable would.

So using an environment variable as an internal detail and marking
it as "internal use only---do not set or unset it yourself" is the
best we could do, and I do not think I would mind.  At that point,
those who set the variable themselves are outside those whose
breakage we care about.
