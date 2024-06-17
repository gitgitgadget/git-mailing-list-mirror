Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224C511CB8
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 01:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718587169; cv=none; b=LcF0rOavfGRu4tEhWl1/7Kz6JlMCXjjWVEoEt8G0vNIZEdeK7spyjEe2QrA0Wyf4iKnDM+Moi8PlK2I5VQsYzJA4fKXTCIvS/pCFF6qulkVAzGRV5/J4aSSqJ+qLasDxPpwFPouBjbn60RxoCpy0c2uPDJtus1LcdZMBQHp+LnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718587169; c=relaxed/simple;
	bh=H87Iq/WfSBHR9Q6kSqJzUGH8OYneJZB5QGwxIbSTD/M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OWeHmL8hDyh2N/PO9s3B378wIPGGBWXon4b+IqhDEUs+xwe8UruOR3leFAg3hcHKzFVPTp0gqatVHQgOM4zc0QBxo+ehO3p87jw8LUixJdrlFH02dwWx72LKsQGIXik0SBSB8ROWajOr3tLoNWYSHsS1YFXpmuXK3dahsEgYeEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wwXfmH9n; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wwXfmH9n"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F7721D156;
	Sun, 16 Jun 2024 21:19:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=H87Iq/WfSBHR9Q6kSqJzUGH8OYneJZB5QGwxIb
	STD/M=; b=wwXfmH9nRzmib1UjeSRtaK6JTgRRZ9UFwUitiIcrrdujMA1n5rn65L
	09hrgKgqmizV5pe4Aqc/gcoC6gjrWIYlh8bvUzkpKL6h7aJtKMhMIHTU8mZwcm6c
	U6pbyxVbmBpU2L1Ccnyopvwkc/BOsyP/mFIt8FxycjzBfh01w+1ks=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5787B1D155;
	Sun, 16 Jun 2024 21:19:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BD4991D154;
	Sun, 16 Jun 2024 21:19:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Devste Devste <devstemail@gmail.com>,  git@vger.kernel.org
Subject: Re: Add warning when v0 protocol is used/downgraded
In-Reply-To: <Zm8EqOfc_v4KBVVK@google.com> (Jonathan Nieder's message of "Sun,
	16 Jun 2024 15:33:41 +0000")
References: <CANM0SV3CQPRyJCDanB8JFpkAMwuoo-mg3A=_L743_GXJtoFtQA@mail.gmail.com>
	<Zm8EqOfc_v4KBVVK@google.com>
Date: Sun, 16 Jun 2024 18:19:19 -0700
Message-ID: <xmqqjziobc2w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9FD9775A-2C47-11EF-84BF-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Jonathan Nieder <jrnieder@gmail.com> writes:

> Specifying protocol version is meant to be backward compatible, and
> there are cases where the old protocol still needs to be used - for
> ...
> more so for protocol v2 for push, which doesn't exist yet - once it
> exists, it wouldn't be great if all pushes using existing servers
> produced an extra piece of noisy output. :)

I do not think it is a great idea to add this as a warning, as if
something bad is happening, either.

I also agree that it is a legitimate debugging issue.  When the user
sees some symptom, after learning that the same symptom was reported
to be associated with the use of v2 on the Internet somewhere, it is
reasonable for the user to want to see what protocol is being used,
in order to debug the configuration, especially when the user thinks
they configured to use v0 (or vice versa)

So I am all for (1) adding to, if it is not already done, this kind
of information to the GIT_TRACE* output, and (2) advertising and
advocating GIT_TRACE* stuff as a useful debugging tool.

Thanks.
