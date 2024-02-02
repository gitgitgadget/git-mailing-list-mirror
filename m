Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FAD14C5B1
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 17:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895831; cv=none; b=NAvij/HhHRyVI6KuX91LZH5YsNLOkaz/LfTItw+yjE4i5/H694VxjcNqCiKMmdZGy+muHwvqfyU4WpcFxqa2akxVtM3i5+m5uEq3JrvKQmMN/fFXJwf7aT69DfjDhb3ucp9F6uH9xeTpXYOqK/dZ0uwAo6xidHBYSTo9+odze7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895831; c=relaxed/simple;
	bh=L5NlZUlKBSu5tJsgRU4TlhAKnKvahMNrt30qA0mGYOk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cQ0yzWDcrvh6dV3f7y4IZGd9t9pellzthY1VvqX7Azg7Ac/lrBMcYbZhED17j/cFrknMIEShtdRuiOFNF7fT298E+8/bkM7WgGmImIS6N+3hiXtCJifn9Js/fh2R8viFUkZeSa+A6reQGvFpZ9/V3GfNUmLxOfdSuRjaV6o8L7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HEBoQj3V; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HEBoQj3V"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6FE6725783;
	Fri,  2 Feb 2024 12:43:49 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=L5NlZUlKBSu5tJsgRU4TlhAKnKvahMNrt30qA0
	mGYOk=; b=HEBoQj3V27nuvmk+zXZLQulW7xZxXJwqOB3R8qjMSk9XXpF3ExDKAX
	ZPL9TW6F7KMGUaGSb+vUk0M0iFu2KI4gLPq4eKKliVLoKJEBZ0xJGxgAOuYTC4AB
	B21GSWq0tIX+nkmdwQsAb0kOTBJnlcHeh2HmFAc/HPTm7j7loSTVA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 68EEA25782;
	Fri,  2 Feb 2024 12:43:49 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A3DA525781;
	Fri,  2 Feb 2024 12:43:45 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 2/2] add-patch: classify '@' as a synonym for 'HEAD'
In-Reply-To: <xmqqh6iqu73y.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	02 Feb 2024 09:08:17 -0800")
References: <20240128181202.986753-2-shyamthakkar001@gmail.com>
	<20240202150434.11256-1-shyamthakkar001@gmail.com>
	<20240202150434.11256-3-shyamthakkar001@gmail.com>
	<xmqqh6iqu73y.fsf@gitster.g>
Date: Fri, 02 Feb 2024 09:43:44 -0800
Message-ID: <xmqqv876sqwf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9D17761C-C1F2-11EE-BD88-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> You decided to use is_rev_head() instead of user_meant_head(), so
> you'd need to update the above description to match, I think.

Having said this, I have a slight fear that normal users would
expect is_rev_head(X) to say "yes" for "master" when the current
branch is "master", though.  is_head(X) would have the same
downside.



