Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C9E18130E
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 18:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718388468; cv=none; b=SSc0mxuEFj0STvGXGCFUVHeup5HqDGZrp6ho++mhAuF1cIiVR6ZZ4xLIxmLIIx8AKJxX+Y2ICL7vaXwCeIrDP/VETG4QdqhgMPzry8weiR27rIkeYLCpyYeugaOcGEeFdioi0ba0GYL6wIoUXj+/hXKFpwpCkEaB8c9HiqSO/PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718388468; c=relaxed/simple;
	bh=+hZIMjEa5VIdQCPCag72CbE/UmYp2DjmK6kkCns1bL4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mhg+/jS4VdNQwDI4Y2DQw9m/+YYGlqRxvoDBRDr70bS1vkmPiyyYYUntMZpa/qVZhYG9q4cCNg1T5HveBMA1zh1XHES7Mf5JGexdNQs5grcZ961QIKZFNvw8iV6OeGK+CL24tK9z2wOrcmldaGfh7gx9svYwosFn/SC36B7sKpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HqMu5f7W; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HqMu5f7W"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 88D31240F6;
	Fri, 14 Jun 2024 14:07:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+hZIMjEa5VId
	QCPCag72CbE/UmYp2DjmK6kkCns1bL4=; b=HqMu5f7W+DtCHlyW+AECAoNRdd4B
	qhZP+aLrt8T7TpfzwS5UYSLw/v8n0MVAVAfUxmhjvdHijSE6bY+nDjRivygeAwMk
	ifv93la7Q8jJwjFtHU8k86hXk0RurL1MyB349QXgsC93+Xw1Bjv7YaDs6+SeeiEQ
	BLKJ4k53vWVpNOQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8053D240F5;
	Fri, 14 Jun 2024 14:07:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EB8AC240F4;
	Fri, 14 Jun 2024 14:07:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Tom Scogland <scogland1@llnl.gov>,  Tom Scogland via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2] archive: make --add-virtual-file honor --prefix
In-Reply-To: <01b21870-b37e-47fe-9bd7-225499ae5eaf@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Mon, 20 May 2024 19:07:22 +0200")
References: <pull.1719.git.git.1715721327429.gitgitgadget@gmail.com>
	<pull.1719.v2.git.git.1715967267420.gitgitgadget@gmail.com>
	<bc3711a7-37d5-46bc-979e-83bd0b2cf900@web.de>
	<95B94723-BCBF-48B4-A02C-A5C61FB060DA@llnl.gov>
	<01b21870-b37e-47fe-9bd7-225499ae5eaf@web.de>
Date: Fri, 14 Jun 2024 11:07:41 -0700
Message-ID: <xmqqh6dvflea.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 FEB99780-2A78-11EF-88A3-965B910A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> I'm not sure I have an opinion on that topic, yet.  Fixing the
> documentation is certainly easier.  Adding the prefix to the path of
> virtual files as well is a breaking change.  I feel that the easier
> route should at least be mentioned in the commit message and why it
> was not taken.

It has been a few weeks since this discussion stalled.  Let me make
an executive decision on the direction here---let's keep the behaviour
and align the documentation so that we won't break existing users.

Thanks.
