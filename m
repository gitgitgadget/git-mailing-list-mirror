Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AA117581
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709660258; cv=none; b=MAHRD8Q9mdOWl1Y0t8/e5DrT5PfD0hPAKdK6B0l7DBN/U/f55qnGjFQR5kQ2bL68kEjHZrILOsm8nTP4RyNo/iPpt0YB8jFiV3ZcAET4PpzACYOSJlUqieqlJQlE7kCN73EF1z6BFajThmbDDvV2mP0uGecDBxYLmH5H0m2Ht20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709660258; c=relaxed/simple;
	bh=UFD6me//ahDz+RkFpI03jtQtTzvG0ryiknoSfSyKdJs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SatUtMcmnkQ4D7z5t7CU1KN0dBmnBaxmUdBQFGCTd+qTePNcE+/Nt/YJF2hfQJme0UycmlTfkXRHtu9yA/Ce+uPynD4EeBqeqd62r1oGU0I4N3vKKCySRIESscMjYRAtWAgxwe1lZ8j2Aq8lPV4guFhLGlMneId1pTobBXy5zdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XCMRZ7mE; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XCMRZ7mE"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6127D3E4C0;
	Tue,  5 Mar 2024 12:37:36 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=UFD6me//ahDz+RkFpI03jtQtTzvG0ryiknoSfS
	yKdJs=; b=XCMRZ7mE69FQTh37gcUPNl/nA1y+lplwy6xPWPUMtxXs7nqI4dfNyO
	mqUkIx3I+w1KbzLDDzRhPiOeVqxNVK1LjJfIBDnXdmqmU4efSHDBKX+sp0hUuwAq
	om9WuDDWsCK+36tCZ1D0HGkYstuEM3jYmpJYrGxlo1fNNXtSYEOzA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 582323E4BF;
	Tue,  5 Mar 2024 12:37:36 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D32123E4BC;
	Tue,  5 Mar 2024 12:37:31 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Manlio Perillo <manlio.perillo@gmail.com>,  git@vger.kernel.org
Subject: Re: Clarify the meaning of "character" in the documentation
In-Reply-To: <9633f9be5ddd9ab3df4b79ee934e1ed47e90bd1d.1709656683.git.code@khaugsbakk.name>
	(Kristoffer Haugsbakk's message of "Tue, 5 Mar 2024 17:51:08 +0100")
References: <xmqqsf1466eh.fsf@gitster.g>
	<9633f9be5ddd9ab3df4b79ee934e1ed47e90bd1d.1709656683.git.code@khaugsbakk.name>
Date: Tue, 05 Mar 2024 09:37:30 -0800
Message-ID: <xmqqedco37hh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0B814244-DB17-11EE-B940-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

>> I personally do not see a reason, however, why we need to be limited
>> to a single byte, though.  If a patch cleanly implements to allow us
>> to use any one-or-more-byte sequence as core.commentChar, I do not
>> offhand see a good reason to reject it---it would be fully backward
>> compatible and allows you to use a UTF-8 charcter outside ASCII, as
>> well as "//" and the like.
>
> Allow one codepoint or a string?

I said "any one-or-more-byte sequence" and I meant it.  It does not
even have to be a full and complete UTF-8 character.  As long as we
correctly prefix the sequence and strip it from the front, I do not
care if the user chooses to use a broken half-character ;-).

> Maybe introduce `core.commentString` and make it a synonym for
> `core.commentChar`?

Yes, if we were to do so.  As I already said, this is not my itch,
but such a synonym would be part of the migration plan if somebody
seriously designs this as a new feature.

> diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
> index 0e8c2832bf9..2d4bbdb25fa 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -521,7 +521,7 @@ core.editor::
>  
>  core.commentChar::
>  	Commands such as `commit` and `tag` that let you edit
> -	messages consider a line that begins with this character
> +	messages consider a line that begins with this ASCII character
>  	commented, and removes them after the editor returns
>  	(default '#').
>  +

Looks sensible.  Thanks.  Will queue.

