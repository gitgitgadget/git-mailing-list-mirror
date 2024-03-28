Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7815544376
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 19:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711654401; cv=none; b=kD276J60Hhl6iRevg2tvlKSg+kRONK2zbv0BBkgjgpTeOBBrgS5bSATlRBzceTVh7qKyv9VFl7sR6tml7hEu0MhFPWNdpL+gRSKdqSjAHAyEyxDs4XsRiCxX1HSEfYlrfJBiZYib6mT4NIhsYo8x/9dJdnVT5WtreWO6nYKNO7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711654401; c=relaxed/simple;
	bh=j735oIc3vii5VjKndbOc1pIkf5TKjnKYdlXVWF8hjZM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UWdVR5iwJ8O2+ot1TkdWCzXUimQZe28EkXiYEfrLW3mpowHrWwCLCDm7s2zwZFr85lX4klBdxs6ODUlAWaYeQuk2e8XOP+m+O4il3vvHgRnK6YsC2nf09bR0R+5CwEXOlH1rT5V5WdgFCTLmLQsLn7+rNnsDf1oKMCVdfVlWtEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lc1XXXjH; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lc1XXXjH"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 319EB1DD671;
	Thu, 28 Mar 2024 15:33:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=j735oIc3vii5VjKndbOc1pIkf5TKjnKYdlXVWF
	8hjZM=; b=lc1XXXjHcZo3oo+s2qwiuy8jXADhYpObE9ImT4CgTd77yiFue8GiM1
	cjwAZB40yqrkyS6OtE7zrmLTRECB15CMR8fpqgqt7CzJ6hno1gZAKpJaPEswe+8Z
	wighhYVWnc9HTnsyUCs8b3HkpqEg51IQm6Y9rsysmE7Qse9HMo2Ik=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 28ED61DD670;
	Thu, 28 Mar 2024 15:33:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 865D51DD66F;
	Thu, 28 Mar 2024 15:33:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Steven Jeuris via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,  Jeff
 King <peff@peff.net>,  Linus Arver <linusa@google.com>,  Johannes Sixt
 <j6t@kdbg.org>,  Steven Jeuris <steven.jeuris@gmail.com>,  Steven Jeuris
 <steven.jeuris@3shape.com>
Subject: Re: [PATCH v4] userdiff: better method/property matching for C#
In-Reply-To: <pull.1682.v4.git.git.1711653257043.gitgitgadget@gmail.com>
	(Steven Jeuris via GitGitGadget's message of "Thu, 28 Mar 2024
	19:14:16 +0000")
References: <pull.1682.v3.git.git.1711613220277.gitgitgadget@gmail.com>
	<pull.1682.v4.git.git.1711653257043.gitgitgadget@gmail.com>
Date: Thu, 28 Mar 2024 12:33:15 -0700
Message-ID: <xmqqv856tamc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 065D3E28-ED3A-11EE-BC3C-25B3960A682E-77302942!pb-smtp2.pobox.com

"Steven Jeuris via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     As before, I ran into many regex limitations (no possessive quantifiers,
>     no lookahead). It also seems different regex evaluators are used on
>     different test runs. Which one does git diff use? Maybe it is about time
>     to update this? E.g., if speed is a concern, possessive quantifiers can
>     speed up search.

When you make regcomp(3) and regexec(3) calls, you'll be using the
system library that supplies them.  IOW, we use whatever is on the
system.
