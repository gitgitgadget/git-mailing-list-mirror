Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FBC1B947
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725897489; cv=none; b=HkRX3kZ4D7MoPjZcCAjRfUxEXwm+HeQNSpM3+H3UMztqW7JFV9KTbffgt2UcAElA+789/YGvw+KBkC67CMB5wqHE+4uXFrKZ0Wv4PFyOU9IrSbvRKQwFZ9z/LcxKttou+/GKEkzNh/ox/XaQM9E6gNNYJ9euinywYHRU+RD7NiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725897489; c=relaxed/simple;
	bh=IdPvmH4wDgWegOP/RnmqAposy/NGckHm0B2R3K2Dcbk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R0DHEsOAf4k2rLgyt/OoWZpALWJiGLktboJjn6JbQOA5wT0jMkkpSJaDVjKHbC7ey6tCzchIw0Pe/H7dKwLN4Ylp+PXZnTV5cxA/RiHp0XSLLHHKS5cORw4ZHBdfk/Hrw/BUo3/h1qgTs8I9swd/b5mTqjUJI7Z0i/Utsev1EY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hKKqUXn0; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hKKqUXn0"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 75FA227655;
	Mon,  9 Sep 2024 11:58:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IdPvmH4wDgWegOP/RnmqAposy/NGckHm0B2R3K
	2Dcbk=; b=hKKqUXn0eoYf8Jvtg22IGfAG4PDanHD/2VjE3n2wbJO4aKelsDz/x5
	7zZYgTIIavh0e1eaWCYH23hn6/9tNlMnIVaThvXVy2hVij1M/UXjTMZXwql1VRjs
	gLOnD8pA/gDDJygfQyBe0eluvx/fLscGkoRwNHVmgKJxf0pQhnbbg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6CA9B27653;
	Mon,  9 Sep 2024 11:58:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7833727652;
	Mon,  9 Sep 2024 11:58:05 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Brian Lyles <brianmlyles@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3] interpret-trailers: handle message without trailing
 newline
In-Reply-To: <5f804f35-a69c-454e-a505-4ceeb9859387@gmail.com> (Phillip Wood's
	message of "Mon, 9 Sep 2024 10:13:41 +0100")
References: <20240905173445.1677704-1-brianmlyles@gmail.com>
	<20240906145743.2059405-1-brianmlyles@gmail.com>
	<xmqqy144wy60.fsf@gitster.g>
	<5f804f35-a69c-454e-a505-4ceeb9859387@gmail.com>
Date: Mon, 09 Sep 2024 08:58:03 -0700
Message-ID: <xmqqmskgu8dw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4CEE583E-6EC4-11EF-8B58-9B0F950A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> I assume it means invalid in the sense that the trailers are not
> separated from the rest of the message by a blank line, not in the
> sense that the resulting commit object is invalid.

OK, then "invalid message" -> "message with invalid trailer lines",
perhaps.

>> But of course, various tools to manipulate the messages (e.g.
>> "commit --amend" and your editor that gets invoked by it,
>> "interpret-trailers") may not be prepared to see any arbitrary
>> bytes.  I would have written
>>      While a commit message can contain arbitrary byte sequence, the
>>      fact that the user invoked the interpret-trailers command on it
>>      means that the contents is expected to be a proper text, which
>>      should not end in an incomplete line.  Instead of detecting and
>>      erroring out upon seeing such a log message, complete the last
>>      line if it lacks the terminating LF.
>> or something like that, if I were working on this change.

Thanks.
