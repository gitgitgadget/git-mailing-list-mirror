Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6F82110E
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723222603; cv=none; b=YNA6/BpM8+X73sS8C75W9OsAXWUwFHRGuG78hXgwo5WmGTYStiu7ycIFcgeJ2OnQf0OM9SDcnen1wy86Io23u/zkuBrvEoQ9b3TVytQAFQKSCgs6EeV/E2Wd2Z71bQdwGiV8mlPZ6sj5dxDy6aE2ejNSoI30ZAuFvP/vmo7uk5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723222603; c=relaxed/simple;
	bh=BIQWbZJ01fybAM4M80u1LPgaJFAjtNPkzrLKmZmcKK8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kcbyNmpgtfeaNDeAhcm9cMXZ9Xjbhf2HTMQYt0h1GEVO0WNFJI54B4Dn61Jrktb9grjwSF9wPQvKBQ3tWvWvXVZwDQOZea2Z0Fg9HPfiskTGA2SfzrEFmo1jDKa5EhDOXDzMSkLjE/sx0Zcnm3HHpuHHh0VdGP3oMHkbnsde+zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=k6UvH8+M; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k6UvH8+M"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0891B2CF01;
	Fri,  9 Aug 2024 12:56:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=BIQWbZJ01fybAM4M80u1LPgaJFAjtNPkzrLKmZ
	mcKK8=; b=k6UvH8+MIqrq7GrXURqP36S7MuAnwWeOtL0GvD5GXuvaGAx4EpwZ09
	HUUXuy/UAK93oHAdEob5f0/34zvuLw2b4u0qmm5Eqv0bGI6fCM6JCEZcbQLFWg3a
	EUlHc9d60d23lNr5sllf/b1A7zkn/LDFfhMLee3vWAO779r+mnzxY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F336C2CF00;
	Fri,  9 Aug 2024 12:56:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6616D2CEFF;
	Fri,  9 Aug 2024 12:56:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,  git@vger.kernel.org,
  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 5/5] t-reftable-readwrite: add tests for print functions
In-Reply-To: <ZrR91dR3G06L9dy7@tanuki> (Patrick Steinhardt's message of "Thu,
	8 Aug 2024 10:12:05 +0200")
References: <20240807141608.4524-1-chandrapratap3519@gmail.com>
	<20240807141608.4524-6-chandrapratap3519@gmail.com>
	<ZrR91dR3G06L9dy7@tanuki>
Date: Fri, 09 Aug 2024 09:56:39 -0700
Message-ID: <xmqqplqheit4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 592F4E76-5670-11EF-A2B8-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> I can see two options:
>
>   1. Refactor these interfaces such that they take a file descriptor as
>      input that they are writing to. This would allow us to exercise
>      that the output is correct.
>
>   2. Rip out this function. I don't think this functionality should be
>      part of the library in the first place, and it really only exists
>      because of "reftable/dump.c".
>
> I think the latter is the better option. The functionality exists to
> drive `cmd__dump_reftable()` in our reftable test helper. We should
> likely make the whole implementation of this an internal implementation
> detail and not expose it.

Thanks for a review.  Are there anything other than removing this
step that this series needs?

