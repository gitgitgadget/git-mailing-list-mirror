Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646594655D
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 23:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721690934; cv=none; b=n7MkJLuwSDrkrapyMqPTS+Cv3XdqSzU8w0nPQQ/zs1u6rkSk0oSVNaJQpMZx4jF2HdIwv7xx9ejPAQIKo7Dj0t7YcTFb7KPQoVckzMJhS/TirZoVmerj9UXpuZjtjFI2rGwZWJ0tKs1jCmVeMebm+bUvlRpfcpUXOK4UjNt3mcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721690934; c=relaxed/simple;
	bh=S9dVWHlw2wQdKY8hMxehfP5xjju65TJ3XmYjyLVnyzI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MfgHV2gIZwK8xsN39acr+7c99vL2Zq3MPPEJxwNLaNq6nL0N960kI3Mnrc+wJiC1oqLZkDz21SSDxKKbHL0+HHQ2arTMhHFIjmnRIl0TCZ/FuMUE2fWQl1rMUeBZXwMeqJvaPBQVnJcJRigauSqhhKt0qfe93etuSFVjHsD866s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=G7wIa2SU; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G7wIa2SU"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A7F4F26CF5;
	Mon, 22 Jul 2024 19:28:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=S9dVWHlw2wQdKY8hMxehfP5xjju65TJ3XmYjyL
	VnyzI=; b=G7wIa2SU7168c2xK8jXDiWxO8Pv03SYjh3p06iYgxxuNX1aGCwygPM
	kl1hTl2n2/u5di4LQl4CtNJRDFDbPG0AjBlrMq4aEE8gcy7MYNlqvcWlA68w72yX
	vzKYYDS5i1K1uRPzYei+TRxxGMX+T0DBIPa9msTrxi+HFtdn7+Z+c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9FEEB26CF4;
	Mon, 22 Jul 2024 19:28:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3136526CF2;
	Mon, 22 Jul 2024 19:28:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Lippincott <spectral@google.com>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
  phillip.wood@dunelm.org.uk,  Git List
 <git@vger.kernel.org>,  Dragan Simic <dsimic@manjaro.org>,  Jeff King
 <peff@peff.net>
Subject: Re: Re* [PATCH v3 4/4] add-patch: render hunks through the pager
In-Reply-To: <CAO_smVhd4LY_F0Wgt1CfsidFAB1n_8Rv3sXaBCgrCuOVMxS5cw@mail.gmail.com>
	(Kyle Lippincott's message of "Mon, 22 Jul 2024 16:12:21 -0700")
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
	<ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
	<efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
	<1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com>
	<xmqqttgqyzwa.fsf@gitster.g>
	<2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
	<88f9256e-04ba-4799-8048-406863054106@gmail.com>
	<a2ea00e2-08e4-4e6b-b81c-ef3ba02b4b1f@gmail.com>
	<xmqqv80xcpe5.fsf@gitster.g>
	<079901fe-7889-4e1f-bb91-610e1eae25d3@gmail.com>
	<xmqqa5i9b51m.fsf@gitster.g> <xmqqbk2p9lwi.fsf_-_@gitster.g>
	<CAO_smVhd4LY_F0Wgt1CfsidFAB1n_8Rv3sXaBCgrCuOVMxS5cw@mail.gmail.com>
Date: Mon, 22 Jul 2024 16:28:47 -0700
Message-ID: <xmqq8qxt80r4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 25FEA3FE-4882-11EF-8BD6-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Kyle Lippincott <spectral@google.com> writes:

> I don't know how easily discoverable this is, though. I think I'd
> still want some linkage between t/check-non-portable-shell.pl and this
> section of this file?

Patches welcome.  I personally think CodingGuidelines would be more
promiment source of information than a linter script, and comments
in the lint script cannot grow too elaborate, so that is the reason
why I did this patch first.  Once we have something to refer to in a
section in an authoritative and canonical document, it should be
easy to point at the section from other places, like the linter
script.

Thanks.
