Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6364310FA
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 02:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711073473; cv=none; b=e1Fga/VYdxoswW/V6LMjfq2RMoTbOKR4NAFCuaQXaL4O37XK4BXtFw2PBkGEEnGbJr2VFPleTgNBTdhFrf1ZMYoI7vSlBLEX9ZyOFHRMtP6R95F8tl9OeBdxAA8rziJVmkkyCtBJYCpDYLqzeELzIx8ZGQeJv6NFmM/ALtjqCmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711073473; c=relaxed/simple;
	bh=w8r3E97jNkRK108Ul08OkVD1rZow4ve2/6okE4qMngw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VIAcD2GXWK2bXHZBdRkKfZa8nBV9Se2Wdlkr2+7qBS7RvfF3pdJqBeBPd7tLQL4A3ZULJqqkGrJJjaOhxGmfMubWU2XyHSmbf6jwa8Y3ZdOIyerfWPjHm6Li7KENMh9Jxor8VS4vacLnKsvBPIDNfO9l5EFBgsnZ1F49f21xe+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iOSpnYcO; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iOSpnYcO"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E6A31F3E77;
	Thu, 21 Mar 2024 22:11:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=w8r3E97jNkRK108Ul08OkVD1rZow4ve2/6okE4
	qMngw=; b=iOSpnYcOFh9EwCh0HSS+FvfpZS1iIxzCegAkoTjUpzYmnE53W6/kFo
	Kv6eHvGQj8lNuCALqIkdZoxFHmjghtt7qyQwm0msCuCYT3wrnGXtGxTYzVATLsfc
	/kVJVgIWascf1ISLEFB9gBuQUirxYf9MxtYttvDBsluQ2F2E1Wx54=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 06D911F3E76;
	Thu, 21 Mar 2024 22:11:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 698041F3E75;
	Thu, 21 Mar 2024 22:11:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  rsbecker@nexbridge.com,  Angelo Dureghello <angelo@kernel-space.org>
Subject: Re: [PATCH] t5601: exercise clones with "includeIf.*.onbranch"
In-Reply-To: <ZfzmdcBT5MUqoxrk@tanuki> (Patrick Steinhardt's message of "Fri,
	22 Mar 2024 03:01:25 +0100")
References: <72771da0-a0ef-4fd9-8071-6467cd7b6a6b@kernel-space.org>
	<0bede59a53862585c49bc635f82e44e983144a7f.1710246859.git.ps@pks.im>
	<xmqqo7bjjid9.fsf@gitster.g> <ZfzmdcBT5MUqoxrk@tanuki>
Date: Thu, 21 Mar 2024 19:11:09 -0700
Message-ID: <xmqq34sj583m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7369E85C-E7F1-11EE-8C8C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> With Git v2.44 this behaviour did indeed change, and arguably for the
> better. This is because we now pre-init "HEAD" to "refs/heads/.invalid"
> instead of using the default branch name. Thus, we do not match "master"
> anymore, which is likely the correct thing to do.

;-)

> Thus the current version of my test that simply asserts that this does
> something successfully instead of crashing. In my opinion, we need to
> put more thought into how this is supposed to work before adding more
> tests.

OK.  That is a sensible position to take.

Thanks.

