Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CC8199EB6
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 20:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714508418; cv=none; b=m7ez7L1343r3mU11dXQfYt+K8NAWWXkpZHwzxLMHA+QFIuaV97/YrKJti5Lv9kfhUE0jv7MvVAPrWZOk3nzgghmLa5rkf/0htvnRVRNLMOlAwxiqNTZ6p2cd6L/aSKbfJtVak3mCp9r0ZJDkL+hZbjxey4AsVdPsZXjSJV/dEY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714508418; c=relaxed/simple;
	bh=qTQQlXni+xOQnf6ItS2Fn7sa/jf7zkskKsVzQq4DIbM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n9cyAtH6tabRUmub7dg0hfeKDmAIHhNRhSwIvhUGqyri8k0vCgBtTZ+NDwG+frRAWGL36iWF66Eq21SNm6V+luiTbbZrIbdHfX1vvI1jbQKpnWoc7p9F2zV9+0B2AebrlbB6S1F+oprhmXtec+YeYZcxZ9vFIfZ8x0GCW7LyK1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GUiBQL4E; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GUiBQL4E"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4111A20E2E;
	Tue, 30 Apr 2024 16:20:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qTQQlXni+xOQnf6ItS2Fn7sa/jf7zkskKsVzQq
	4DIbM=; b=GUiBQL4EmGniMNFJw7pWiYAYENwWzIx7U250XvbhSOZUe66zzDAowf
	Us+1ATmqW+QKOmhjiYU2I2pm5ZYEhB3Mzdw0VUvMEJcd0ZWLHQWm6TSoO/1rI0SS
	T+Fi7cfBhYIwREiKte+OE4iXJ6Slq7wsoLPxtW1WL9DzA/XVepkU0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 38CEB20E2D;
	Tue, 30 Apr 2024 16:20:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B09C320E2C;
	Tue, 30 Apr 2024 16:20:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Karthik Nayak
 <karthik.188@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,
  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 04/10] refs: rename `is_pseudoref()` to `is_root_ref()`
In-Reply-To: <3d7ea704177c84e5afeceea5848f5606f11e99f4.1714479928.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 30 Apr 2024 14:26:37 +0200")
References: <cover.1714398019.git.ps@pks.im> <cover.1714479928.git.ps@pks.im>
	<3d7ea704177c84e5afeceea5848f5606f11e99f4.1714479928.git.ps@pks.im>
Date: Tue, 30 Apr 2024 13:20:09 -0700
Message-ID: <xmqqplu6y552.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0BF71516-072F-11EF-B1C0-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Rename `is_pseudoref()` to `is_root_ref()` to adapt to the newly defined
> terminology in our gitglossary(7).

OK.  root-ref is a good name that is not yet tainted.
