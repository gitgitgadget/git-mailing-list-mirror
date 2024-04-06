Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA4212B89
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 01:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712367012; cv=none; b=Qnew4BR7H8JkgXyZ3gzIRnENnVZUxhRRDtS7ovUwuQXFMlT2HUt8auEJ1geF8GFtxvqGBm9QV/IIxjhzKU154XAa/RoCMeC73/eae2zwZeehF/DkVVwRRvgJweMXWVYE2kfnB5hXnALx5h4YCDe64ol2hyh4bpKVYIQQvHoFd8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712367012; c=relaxed/simple;
	bh=kZHvLfYNvmS2XjWcEzmM7B1IjJBIokxG3iQkhyCjiAs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q9NPYqFL6/UMiTU3BaJLLOf0CPP3vCDuF6MO5lNgKeq7rjAoqeZQvOTMDWP2KdRUqTaWhxYy+YxX+CAlSwVLbl66moTAOJ/ugP2c4q7Ha6lqa3iE7HTmr5zTej+FLBvy26tUMLE+yAVFbM7xIs0VDxzdl1ean2NALMjSAw9qjT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nGGGbrky; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nGGGbrky"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 97FF41DBB58;
	Fri,  5 Apr 2024 21:30:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=kZHvLfYNvmS2XjWcEzmM7B1IjJBIokxG3iQkhy
	CjiAs=; b=nGGGbrkyAgND80iFhwQSF7xOukmkgCe75l0C0/ky1LUXZWak9rTs7i
	lNC/Y8QTXF02uyY/SGOu0sZOYXFgkUyXTTJaXX2XgsLSqyRVLBO0jw43fMuUYJ8c
	eSFCyMNEqaSN5uTZ23jEVo5eU8kqz+ASbxOS42edz+SRFWD7xHpPs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DED621DBB56;
	Fri,  5 Apr 2024 21:30:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 845511DBB53;
	Fri,  5 Apr 2024 21:30:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  code@khaugsbakk.name
Subject: Re: [PATCH v3] send-email: make it easy to discern the messages for
 each patch
In-Reply-To: <235fa26a0803f7a8868fe908e4689bda@manjaro.org> (Dragan Simic's
	message of "Sat, 06 Apr 2024 03:17:56 +0200")
References: <e3212c0a4ad331685c68c13afcdbced20982ab32.1712364420.git.dsimic@manjaro.org>
	<xmqq8r1rs39g.fsf@gitster.g>
	<235fa26a0803f7a8868fe908e4689bda@manjaro.org>
Date: Fri, 05 Apr 2024 18:30:05 -0700
Message-ID: <xmqqttkfqnvm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 33BF6B62-F3B5-11EE-8BB6-25B3960A682E-77302942!pb-smtp2.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> According to my research, the "->ornaments(0)" call should work in
> all environments as expected.  It's also officially documented. [1]
>
> [1] https://perldoc.perl.org/Term::ReadLine#ornaments

Go back to the DESCRIPTION section and realize that it is a
front-end for different implementations.  The functions are listed
in separate sections, the first section being "Minimal set of
supported functions", the other one being "Additional" that may or
may not be available/effective for everybody.  Which side does
ornaments fall in that page?

