Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C5916FF30
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 19:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710014157; cv=none; b=VDOH7Mq2/vqoeAu4wxx4PxR5CBozS7IqcD4azKZ7fHluQt2kWTBJrrNla8lZMKBAL14J4/L4g4IWAEJPfLv+GbFpCisjBog0o6Ar1qmH4uwDTolYjmWXcqhou/dn18VBdO4KLrqSSjyyq5F169i7E49e8AeguD6XtzOr1t3Mht0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710014157; c=relaxed/simple;
	bh=znpEhZWwF2Kq9fyGZ/MQlFVmSiZsLFUNSEuv2j0KaEs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZZjKzKkVmqJK/nWkHFsJ20ZLpbTV8lBhMTmnaOSXTw58DnL+Q0hkyc/sJ7Y1E4hV4NeFpkA2uWUAkERfzrm3J4s8GiQXShrdrsMFCTK6FNKJo+HvqnpSVUnRlewigpXYMgfHZZfVLZ8KSxBaQz1kRcf7S4tou9LNSrt3joAJWmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=v0Bjchgi; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="v0Bjchgi"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BF6061B280;
	Sat,  9 Mar 2024 14:55:55 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=znpEhZWwF2Kq9fyGZ/MQlFVmSiZsLFUNSEuv2j
	0KaEs=; b=v0BjchgiVQvkn+5nQ9Iv6GhE/4mVlZjskO03UpD1A+lwD5xOtOFcYX
	e7IifvNDTGAv9HNwPeqaFW/3mR4szR36yoc21+u7QmAqIQwCOaRwP3gVv6TVjdEH
	bAzBZ/KUifJoP0iUiD9JpXi8mFQn6EF5odH6H6ecTztJSS+ioowfk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AB8FE1B27F;
	Sat,  9 Mar 2024 14:55:55 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4BC4D1B27E;
	Sat,  9 Mar 2024 14:55:52 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] sequencer: allow disabling conflict advice
In-Reply-To: <570a8736-5552-6279-4aea-8acdf8af50df@gmail.com> (Philippe
	Blain's message of "Sat, 9 Mar 2024 13:58:45 -0500")
References: <pull.1682.git.1709396291693.gitgitgadget@gmail.com>
	<xmqqwmqiudna.fsf@gitster.g>
	<6ef490d2-ce0a-f8bd-8079-6b4ef3e37eda@gmail.com>
	<570a8736-5552-6279-4aea-8acdf8af50df@gmail.com>
Date: Sat, 09 Mar 2024 11:55:50 -0800
Message-ID: <xmqqle6rch89.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 089BC514-DE4F-11EE-8C51-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Thinking about this more and looking at the code, using 'advice_enabled' in the condition
> instead of using 'advise_if_enabled' for each message has a side effect:
> the text "hint: Disable this message with "git config advice.sequencerConflict false"
> will not appear, which I find less user friendly...

Good eyes.

I agree that you have to do that part yourself at the end of that
"if () { ... }" block using turn_off_instructions[] string.
