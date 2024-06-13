Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1F781AB5
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 22:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718317383; cv=none; b=kLTF/GOph0e2yYVdIb5SC5yrkJj1f86uJQgCjWGjPc0pcs7HhXTcucSVgqxmLvN1IzRfN1B+8Qn/ddzxgqF1qV70lRw3tvbawoH0I/tXLZHDLeWWi1UdU+P9FAoB1AnqsomHvhvKKsqDBr4kuQcrJPoIwd0YCRvTLj6GverXeto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718317383; c=relaxed/simple;
	bh=K5AZ045BES4tDKlr3e8DK+blxhBnYo/5DexKK//7Mlk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IGVd6pKnUJhbpdO6qKOwC0ga27M/4FvS6VCz19hyVDYgZ2gVGxo5pch/AIiaiJqaZkYyQ4+QFFUYVb+ETeuY8vhYIOsbxM6DVD3K6jmx7iM1lqQrrSeakrj6rRbDwCuSmr4eAvkYqzoubNUH360wFpdbts7Hw0r+Ut7fGe+jqds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XrlSAOnO; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XrlSAOnO"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A35611CC29;
	Thu, 13 Jun 2024 18:22:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=K5AZ045BES4tDKlr3e8DK+blxhBnYo/5DexKK/
	/7Mlk=; b=XrlSAOnO2uaAK7+X0KPhrV6ofzBH9nUBGqKhkrmgmgeAfI2gKq7Uch
	1jp7xUup69UvYazdpvXV1uTrvGrbX9jpH2pB4v4LTPeVBqxKLdlV6/WojZXMarAL
	tc5wCq//6feRpEP96MKzhWgn4jORWbBHA91GGgEtfapH2blrT45OQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A34A1CC28;
	Thu, 13 Jun 2024 18:22:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F190D1CC26;
	Thu, 13 Jun 2024 18:22:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Matt Cree
 <matt.cree@gearset.com>,  git@vger.kernel.org
Subject: Re: Unexpected git merge exit code when killing merge driver during
 ancestor merge
In-Reply-To: <CABPp-BFrcNLA-714gw+JogtAQLhmcs_sLnkkaBiGERF+riwZLQ@mail.gmail.com>
	(Elijah Newren's message of "Thu, 13 Jun 2024 13:50:04 -0700")
References: <75F8BD12-7743-4863-B4C5-049FDEC4645E@gearset.com>
	<ZhBZOY1aEFW4YoD8@tapette.crustytoothpaste.net>
	<CABPp-BEogmpG7pYmC84WhQCy0tP97cV8BZ8epPeo4fzmRjU5Rg@mail.gmail.com>
	<CABPp-BFrcNLA-714gw+JogtAQLhmcs_sLnkkaBiGERF+riwZLQ@mail.gmail.com>
Date: Thu, 13 Jun 2024 15:22:53 -0700
Message-ID: <xmqqo784jxdu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7AFDDD7A-29D3-11EF-89F9-965B910A682E-77302942!pb-smtp2.pobox.com

Elijah Newren <newren@gmail.com> writes:

> Again, sorry for the delay.  For those reading through the archives, I
> posted a fix to this and a few other issues found while investigating
> this problem over here:
> https://lore.kernel.org/git/pull.1748.git.1718310307.gitgitgadget@gmail.com/

Thanks for a pleasant read.  It mostly looked fine.  Queued.

