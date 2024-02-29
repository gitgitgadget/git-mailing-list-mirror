Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE1A160631
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709224748; cv=none; b=hFQKDmqHUg+GEdDEV+ZynawBC5XbcZSR8RmLy9nAtpDajcnPcnnUyTH0N2kbbcgM5l4awNJmx/w+K1eIP3L1VCQ9UB1rsI9MMm4IXo1ffvfPgvx8FebBdg6RFTh/T4VzOtelQE9YPximL4zT4hMuUMjrPiTPLdYlydX2VvXwCXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709224748; c=relaxed/simple;
	bh=ZdLas6s1BWEkyQBY9COchzmLJFbDoTpuKwpnjueog64=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ajRyZjq9pynnpHHq3VBvWGXHHPxVCXb92OH320sXvfzwmgxSqfWbX8YU74wLiGkMAYCNlueJT4surpjFkyW9HQSqHqN9we3loPqMYqcqd+00LDvYEgpr2P3jyG7maiN1mMNY9xJjAfVCz5StoAMyeR09Xa0AbqtO8/9/4fIYynE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WqXry1Jf; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WqXry1Jf"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A1F5034DEB;
	Thu, 29 Feb 2024 11:39:06 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZdLas6s1BWEkyQBY9COchzmLJFbDoTpuKwpnju
	eog64=; b=WqXry1JfpckEMujLNDvQFmzLehSrQAeC56A8k2gXPzBfbrYel2iL/n
	SbwmClEGTdGujTPI7Nm0Y+2YZzldadGQ7f0sjVgM6Hr+b0pPHyiOUNG2m1ExuOHV
	P+Dgcgm6uIHzn0eBx5I+0liMDHcD83eLvzC+wRL/YJM1RuSWSQGJY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9AF1434DEA;
	Thu, 29 Feb 2024 11:39:06 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8BC4834DE4;
	Thu, 29 Feb 2024 11:39:01 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Triplett <josh@joshtriplett.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] commit: Avoid redundant scissor line with
 --cleanup=scissors -v
In-Reply-To: <ZeAftoPPRsltswbS@localhost> (Josh Triplett's message of "Wed, 28
	Feb 2024 22:09:58 -0800")
References: <9c09cea2679e14258720ee63e932e3b9459dbd8c.1708921369.git.josh@joshtriplett.org>
	<xmqqbk83nlw5.fsf@gitster.g> <Zd2eLxPelxvP8FDk@localhost>
	<4f97933f173220544a5be2bf05c2bee2b044d2b1.1709024540.git.josh@joshtriplett.org>
	<xmqqjzmpu7k6.fsf@gitster.g> <ZeAFutaddf4M2wjM@localhost>
	<xmqqttlrj08t.fsf@gitster.g> <ZeAftoPPRsltswbS@localhost>
Date: Thu, 29 Feb 2024 08:38:59 -0800
Message-ID: <xmqqil27i5ss.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0B240574-D721-11EE-8211-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Josh Triplett <josh@joshtriplett.org> writes:

> I did add a test; v2 that you replied to has this:
>> Add a test for this.

Thanks.  Let's mark it for 'next' then.
