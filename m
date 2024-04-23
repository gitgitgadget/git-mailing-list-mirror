Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7074743AB0
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 23:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713914235; cv=none; b=OaxN9gUiPAFbrYBnpUbUhB2E8e10ed7KH1lfwFMd6OX5DZm9uzxIjmOjj7Z4X+dN7NSiMxqwI7B2s1+qMbgj5vhPYAPLaOfKMblfzUpgsOlaNy+AAzKIVxIifuHLrqJBvTq3qEtoC7XaZ+OEydNOIO8RM6KX9x/qvtuyuy5464k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713914235; c=relaxed/simple;
	bh=YM1qvC2dz7zgiXjlyhLehi2UQQvKr/SYRxa/rnvjp40=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MQY5Ivlt5uynQfEebJqhIKj05vDuS4xDhnRGwVpQnr1knqFBiHSfAuQntwrp7UClRGfvipojqTK07lwgPaPaWmz4xQQlfu9YGpVaG2nfYEQBiZ6SE24lERE6SwdiQsI8x7wj4XnB6UDnGzKeLAIuVFLBHEF2RyoPZwyT+0xR85k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FN5LYmiD; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FN5LYmiD"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BD22D2EA8B;
	Tue, 23 Apr 2024 19:17:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YM1qvC2dz7zgiXjlyhLehi2UQQvKr/SYRxa/rn
	vjp40=; b=FN5LYmiDzsmIwZdguyevLirKL5hnU099miezcSY8NLCLDjhSD7P2Fl
	0XkGCNf3IhFG1Iqvo5IeVZot2W/BOvfVvSUQD/aW+R7Mtn1ezH8W37UaEvl6Pfr+
	9tKtd+qY4stovN0W6/TufTHTPf6Mbag/2ACfHXNLWmp8pAII5Gdbs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B1DEE2EA8A;
	Tue, 23 Apr 2024 19:17:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BA40B2EA87;
	Tue, 23 Apr 2024 19:17:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>,  Christian Couder
 <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH v2 6/8] trailer: make parse_trailers() return
 trailer_info pointer
In-Reply-To: <093f68f365801bc8801f29dc3e6eaa9b07fcd57d.1713504153.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Fri, 19 Apr 2024 05:22:31
	+0000")
References: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
	<pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
	<093f68f365801bc8801f29dc3e6eaa9b07fcd57d.1713504153.git.gitgitgadget@gmail.com>
Date: Tue, 23 Apr 2024 16:17:08 -0700
Message-ID: <xmqq8r136557.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9BEBBDF6-01C7-11EF-93DB-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> ... From the trailer API user's perspective, the call
> to trailer_info_new() can be replaced with parse_trailers(); do so in
> interpret-trailers.

And from the trailer API users' perspective, it would now help to
have a bit of comment on parse_trailers() function.  The users need
to know at least:

 - what the function returns (i.e. a pointer to an opaque
   trailer_info structure),

 - what operations can be done to the opaque structure, and 

 - what informations can be extracted out of the opaque structure.

When appropriately typed and named members in the structure are
visible, the latter two are obvious in well written programs, but
now you are going to hide the data structure, "Show me your data
structures, and I won't usually need your code; it'll be obvious."
would no longer work.  You'd need to compensate for making the
structure opaque to rob the clarity from the readers with good
comments to the function and the API to help them.

The changes in this patch look more-or-less obvious.  Looking good.
