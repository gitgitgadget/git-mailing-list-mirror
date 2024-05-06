Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C613715D5C2
	for <git@vger.kernel.org>; Mon,  6 May 2024 23:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715037736; cv=none; b=n5SXmWpdzZM7N3Tme0Mg01JfanZM1MVSBOweBTe1iEofXIpTBnfSuvoTR8xXKdwxhJoT7+aa/nNCWsxssgbVobUZtaiWEWkZt5gXAJote29685K0V8CMkPMt0o9hCTm/8JhOVJiluU34VY0D+6T9sCTBzcor2MtFUr0ji9mj3fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715037736; c=relaxed/simple;
	bh=UyLHahHpI6b9ddzC/+vzwWg+cOrTXBrBRD8PIJl6+Zg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HT3PbD7zD98dgRezaksjHxJQzMVfSTNKJAJ6qgFLZ5SDRwGrGTf0sm5SddeMZ+mB5SwwtBwal6+5pXy5YvZHC6npiGbqrf1SxJuNOkFB/fJkTwTmuezPXzmEASJnSDHdNq4CK5cIlTzwkYZ9iHZw7ukdTy2H9CNdLNCAiqZosUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gvbNhzNs; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gvbNhzNs"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8820A2459F;
	Mon,  6 May 2024 19:22:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=UyLHahHpI6b9ddzC/+vzwWg+cOrTXBrBRD8PIJ
	l6+Zg=; b=gvbNhzNsvUr9UE/LXYnNe1EXJjklh0QZNrrcIg+2nlSUUXDDWt9z0p
	Axtw8ZlEuV4w8vGrvBW640HoJ0o/ISttA6Vz3+f2Km4UapTN5LfNCOiodvb77omr
	rjlUHrJ3Ad0y9JPMXW3cqkssdG8bF+Z2d6BxQQjbDW3/K1ijWl+kQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EC622459E;
	Mon,  6 May 2024 19:22:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E257A2459D;
	Mon,  6 May 2024 19:22:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: Feature request: secondary index by path fragment
In-Reply-To: <robbat2-20240506T225759-090424131Z@orbis-terrarum.net> (Robin
	H. Johnson's message of "Mon, 6 May 2024 23:11:37 +0000")
References: <robbat2-20240506T225759-090424131Z@orbis-terrarum.net>
Date: Mon, 06 May 2024 16:22:11 -0700
Message-ID: <xmqqttjawmos.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 77FD814E-0BFF-11EF-A707-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Robin H. Johnson" <robbat2@gentoo.org> writes:

> Gentoo has some tooling that boils down to repeated runs of 'git log -- somepath/'
> via cgit as well as other shell tooling.
> ...
> I was wondering if Git could gain a secondary index of commits, based on
> path prefixes, that would speed up the 'git log' run.

Perhaps the bloom filters are good fit for the use case?
