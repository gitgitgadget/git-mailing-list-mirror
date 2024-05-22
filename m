Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9EF140E2E
	for <git@vger.kernel.org>; Wed, 22 May 2024 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716395273; cv=none; b=JFm0LOIM4lnKK8eWB5QuaGp6rSJTYpjLhUacYvhre3TYU4+ccCZpgYacpSuDy2HSpL+PR3mt9Eey1MDRuT4CzNsgu7UgAmEUpwUVRECKcxrYvZJRXeOT3Cn+LeQXYuonH3HB+Rq7OX73ZB5ozEUc3lBJrQgm6Di08RcoMKN1/Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716395273; c=relaxed/simple;
	bh=xIvkdBncvOqjrPS5HbvP7OU8RFDM22ZpEMTCdJxEgvA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TnfRi/gkbJqxOVjfTlscGE/lNuB9Zfld41M5VGETlbq2XMY/aArRl0EJJwcu8bCv64Ge4wMPjPxdRNqcdBZ+rPHuNsN+/QjeF/6QGOk3ANf1sS3CwhVhZyH131kyicuxieakuotc9SBdJg0TvLQ625QHG13wWz3AUOyVXz20jQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vpVMosQc; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vpVMosQc"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 78E6B1833E;
	Wed, 22 May 2024 12:27:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xIvkdBncvOqjrPS5HbvP7OU8RFDM22ZpEMTCdJ
	xEgvA=; b=vpVMosQcWFTDtgcSoskFVy8mpin1Z4ODeXDKLD3gnF7a8mGdka7q7a
	aoHvg+XVxedeS1YNMAB/v6fZRFh2rRSWdDSL0Fqmj9/XNAi9xYJuhmnImcC3yjwa
	sd8opKV7iG29XnucKZugsiwKCb0QJbto0RwIvgmxkgC3IOYIl0WIQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 703481833D;
	Wed, 22 May 2024 12:27:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C19BA1833C;
	Wed, 22 May 2024 12:27:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] add-patch: enforce only one-letter response to prompts
In-Reply-To: <Zk3R4MuCWOYVz3_B@tanuki> (Patrick Steinhardt's message of "Wed,
	22 May 2024 13:07:12 +0200")
References: <xmqqr0dvb1sh.fsf_-_@gitster.g> <xmqqh6eqiwgf.fsf@gitster.g>
	<Zk3R4MuCWOYVz3_B@tanuki>
Date: Wed, 22 May 2024 09:27:48 -0700
Message-ID: <xmqqv8356ccb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3B042D00-1858-11EF-A8BE-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> +		/* 'g' takes a hunk number, '/' takes a regexp */
>> +		if (1 < s->answer.len && (ch != 'g' && ch != '/')) {
>
> I find this condition a bit unusual and thus hard to read. If it instead
> said `s->answer.len != 1` then it would be way easier to comprehend.

We have already eliminated the "it is 0" case, .len cannot be
negative, and the case we really care about is "is it not just
one?", so I agree with you that the inequality comparison with 1 is
easier to grok.

> I assume we also want a test for this new behaviour, right?

Hmph, yeah.  'g' has already been tested (that was what led me to do
the v2), but we probably should do 'qa' or something.

Thanks.
