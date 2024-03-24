Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE13681E
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 02:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711247093; cv=none; b=m4aZS1Z9Z+iAeYomrHAkLICP3H5SlxZHm27t7HGvCaEbmgXRYgGpKHe4Kzw3IY/c7LKkMQwVH4jP9jgBu/5HlXfIVXEQNxSkmL8EBLs33hmoGu132QlF2BfNBn2z2URtHHLrCsHFymJGBXvPJfDgk4dQM/pmkWTvLWflwJG6vfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711247093; c=relaxed/simple;
	bh=wToSJCYDG5n9MDyn0iQ9cvtlrZaCGyHLrlgtB4QwUw4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VsWzy4FKXXOawkWTqDCqlfGufTjZgF2oLlw75+OBoLQGb1/qBsFk3QqocnAhRMYO43JtTFDnUMv9TMuumjsymayeEo7MsQx9qPAvGX5urHw8mHiNA68MBX45cYMdmvR6KQpw+T/OOdf5IkL9Hd/SUERcZgWAFsSrNF0h3i/3peY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Kwo7DY16; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Kwo7DY16"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3556A248A2;
	Sat, 23 Mar 2024 22:24:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wToSJCYDG5n9MDyn0iQ9cvtlrZaCGyHLrlgtB4
	QwUw4=; b=Kwo7DY16GJkxM6ugAlYNC8fcBN6jHQbT4DmOicnBTqV+1ZBXua1LBl
	nabm0E0KuGbsE71kP81koJ/FmblrNkMQ9DtDtbqknhxoy0r84RwkhahE84uO5S0l
	fmsDQuqy4uonBclzN00/FIXocXeifQ7L6owlOCxGJcVw1sI0o/nxg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2DB40248A1;
	Sat, 23 Mar 2024 22:24:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AD7B9248A0;
	Sat, 23 Mar 2024 22:24:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Matthew John Cheetham <mjcheetham@outlook.com>,
  M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH 00/13] Support for arbitrary schemes in credentials
In-Reply-To: <20240324011301.1553072-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Sun, 24 Mar 2024 01:12:48 +0000")
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
Date: Sat, 23 Mar 2024 19:24:46 -0700
Message-ID: <xmqqedc0v029.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AF5F91DC-E985-11EE-B811-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> ... and because of this difficulty and the fact that NTLM uses cryptography
> known to be insecure since 1995, there is often little interest in
> implementing this support outside of libcurl. However, it would be
> helpful if people who want to use it can still use it.

This position was a bit surprising to me to come from you, but
perhaps I am mixing up my recollection of your past work on this
project with somebody else's?  I somehow expected to hear something
more like "if a less secure thing is cumbersome to implement, let it
be, as that is better for the world".  But I am OK to add less secure
thing as long as it is an opt-in "easy way out".

Everything else I read in the cover letter made sense to me.  I just
wanted to say that the above part was a bit surprising.

Thanks.
