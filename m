Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF84A2A1C5
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725378744; cv=none; b=r8uQo41+0zIUp753ciWjooHhUD2BjjybIuo/GR9KzOAohgjYq5bfbZjhNbmDXtLnNzemL6MJkCADGiQ5UrR0KSWnkZZZovyDFFmCY6hR6DxAiQSjq41Bb4VpuDtKlwVLq9gNw90KdhrRi5aBnv3JJgnkhDNb0Rkpcg2S+w3P3Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725378744; c=relaxed/simple;
	bh=GRcbd2Adgbvc7gGla5d9bF1A/GpSZMLqsghCqG57S5U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CtQ8qv8CLjNLxu00o+iDL+TzSKEDtbsBEd+A6SkauaLwXkxZc0HWZIeyXmDhGZ3mQS/dneMNF87iR6rojwmuDNBFUoS+IjbxWMIypV0qrvmFt9e5jcVmt6GlMqD+1TfYlHgmfJ264dQ4FqIXob15lJYjAqmxdbTOJ2Q41l38QlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Sxgcs6l4; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sxgcs6l4"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D3EE363D4;
	Tue,  3 Sep 2024 11:52:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GRcbd2Adgbvc7gGla5d9bF1A/GpSZMLqsghCqG
	57S5U=; b=Sxgcs6l4i8EZEmn8cK9EwE3dFoeNGMX4QTnGrMVzLBQsrquF4n6zQy
	z8CNuz8th0/LHT6q1X3Fh91cxaeTrbrFAW37HFox2GBv6qDiq91oW178Lea9586s
	poIvL98N+ZZD5LB5vMApJOE+EXfNQBAOYODVLiCQV5IUe64WQ0Sag=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 43197363D3;
	Tue,  3 Sep 2024 11:52:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AAF7C363D1;
	Tue,  3 Sep 2024 11:52:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Ilya K
 <me@0upti.me>,  git@vger.kernel.org
Subject: Re: git 2.46.0 crashes when trying to verify-pack outside of a repo
In-Reply-To: <ZtXCBcn6WZIHr65b@tanuki> (Patrick Steinhardt's message of "Mon,
	2 Sep 2024 15:47:55 +0200")
References: <14ec9394-a7ea-456c-800a-6a84c52e5cda@0upti.me>
	<xmqq7cbvpf8v.fsf@gitster.g> <ZtT8p06fdTwXO7iX@tanuki>
	<ZtW7LtQEobPpVB99@tapette.crustytoothpaste.net>
	<ZtXCBcn6WZIHr65b@tanuki>
Date: Tue, 03 Sep 2024 08:52:14 -0700
Message-ID: <xmqqv7zcn39t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7DF56A38-6A0C-11EF-8F30-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> I'd personally recommend just requiring the `--object-format=` option,
>> but of course if you want to write pack v5, don't let me stop you.
>
> Well, in the context of this issue I'd definitely aim for the easier fix
> first. Regardless of whether or not we introduce v5, we'd still have to
> address the underlying issue for repositories that do not (yet) have v5
> packfiles.

I would be hesitant to reroactively tightening the rules, though.
If a tool has worked well for those who can and wants to assume a
hash function (because it has been the default, or perhaps because
the user configured the tool as such) even outside a repository,
such a tightening is a regression.  If such a change is done to
avoid triggering a data corrupting bug, we may be able to come up
with a valid justification, but on the other hand, to discourage
certain uses of the tool, even if the discouraged use is an insecure
one, feels a bit too opinionated for a tool.  It has the same smell
as updating the "md5sum" tool to discourage the use of the function
so that it always exits with 1 (after computing and showing the
hash) or something silly like that.

I am not saying that it is bad for a tool to be opinionated.  When
we design a new feature, it is part of the design process to make
sure that use of the feature encourages use of better workflows.

But disabling what has worked to user's expectation so far is a bit
different story.

