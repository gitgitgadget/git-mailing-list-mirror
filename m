Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF67615A48A
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078631; cv=none; b=hh9Bp+gYwbhhIhcxECyMCn6aAkhyGML/FBC22l/dxWpuZkNVZiXFhNdJ8BQAepmWTHBXLkQFTdv226/S0CFSItfIS4J0oU5a8CUmSCO88PtZGkhcXjUgLmGYuXT9nLdaVP1Vo53jTKoOua0qOxg7Dg+AODYm1J++T/sOt6su450=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078631; c=relaxed/simple;
	bh=NKAaZJhtbYXD0cjk4zOScrtgk4Lph+lHTYuAZntDyKY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cq7gOCZx0G5FI+RtrSS0UX08GaAH36ZnjRazPc2JJc684va1rn9XosLpwkAmFY/ILSD+3AW92J8akFblXn/9LzxffxUmUlX/rq8VAjMPIWGNhRgz4yVJhDm4fxAl4+Pkhw0u5mqODiFnrMEMj7egh7ImhS1w8dqQ31JVayMGWs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LNa7yfOQ; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LNa7yfOQ"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6D59427165;
	Tue,  2 Apr 2024 13:23:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NKAaZJhtbYXD0cjk4zOScrtgk4Lph+lHTYuAZn
	tDyKY=; b=LNa7yfOQrihfJF8x4M6xmZySB9beTbXby4O9uVsAyRhcRhoXnCHlmD
	yPvz8oHujefDpd1CiJVK8s3FFm78PPstR3trkyGtD9O6v2nR1iMcBvsYYAHn81Qm
	QgIH1jP+65KXrBxWeaO4mXwhDYRQuatDqY6c0gmsIb0RuZ6Y2aRns=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6532327164;
	Tue,  2 Apr 2024 13:23:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6B60A27163;
	Tue,  2 Apr 2024 13:23:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 1/3] reftable/stack: add env to disable autocompaction
In-Reply-To: <ZguygYtc7plWTIA2@tanuki> (Patrick Steinhardt's message of "Tue,
	2 Apr 2024 09:23:45 +0200")
References: <pull.1683.v2.git.1711060819.gitgitgadget@gmail.com>
	<pull.1683.v3.git.1711685809.gitgitgadget@gmail.com>
	<2fdd8ea11331da13ec56d511fe4cadd47544419f.1711685809.git.gitgitgadget@gmail.com>
	<ZguygYtc7plWTIA2@tanuki>
Date: Tue, 02 Apr 2024 10:23:43 -0700
Message-ID: <xmqqfrw365ls.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C27BF28C-F115-11EE-866B-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> -	if (!add->stack->disable_auto_compact)
>> +	if (!add->stack->disable_auto_compact && !git_env_bool("GIT_TEST_REFTABLE_NO_AUTOCOMPACTION", 0))
>>  		err = reftable_stack_auto_compact(add->stack);
>
> The double-negation in `GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=false` may be
> somewhat hard to parse. Should we rename this to
> `GIT_TEST_REFTABLE_AUTO_COMPACTION` with a default value of `1`?

Sounds like a nice improvement.  Also the overlong line should be
folded.

Thanks.
