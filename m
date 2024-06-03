Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46381135A46
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717438111; cv=none; b=W982uFhTt75Gmei6Go8IK7qeTzBN7EJQOvur3W1gT0hEYB0W59UaRn/0ovfL08UPl7jgMVMDeLkfBi306XlVTg0nWQR67gVWS2BrDDkRDVngwZcpVmtkHmV19kelvRDfKOt4kSmOQUifLfWaUrmN05f7ZIIlouzV+P9hicvLgow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717438111; c=relaxed/simple;
	bh=E5jnS2yJqycTReBAbcTvYuYisP9f0f7qDwgpkX79aJ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ntw3hbskO5Vqgnyomi/8NE77Z4eNMBKnFN9n8IW7GIgk0ZwXY/A3P5dglmNn11rVm7uSRSXpTHOo5rZLwciC4Meg/d7UwOByhvAHHe3QrVOb4xeKOfyfdjK22o4gadeUXgllY/W//Du/djW+zOBXfef6AWGlMYCpOEo0AhgwjP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YmYQ7Mq2; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YmYQ7Mq2"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A2D63460B;
	Mon,  3 Jun 2024 14:08:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=E5jnS2yJqycTReBAbcTvYuYisP9f0f7qDwgpkX
	79aJ8=; b=YmYQ7Mq2JjqiQ/Vz/mmAuXFXQvUvrG9yqy7XkvnBl7YIbFOAGw7K6i
	vPZeYHxteEW9Lfpc2rxXKl0cmIuB/UpNtOSPRgV1QkqGdrNK+f29GcX9G5szH+P8
	fo4uVfmRm6FJrEF/1uZ5fx9vMHXDO2F040D62ST62RykI1fDsgtN8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 320E73460A;
	Mon,  3 Jun 2024 14:08:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6157734609;
	Mon,  3 Jun 2024 14:08:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 03/27] refs/reftable: stop micro-optimizing refname
 allocations on copy
In-Reply-To: <085d90c8b63e937e3d76637ce2422320b5801ebb.1717402403.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 3 Jun 2024 11:39:10 +0200")
References: <cover.1716983704.git.ps@pks.im> <cover.1717402403.git.ps@pks.im>
	<085d90c8b63e937e3d76637ce2422320b5801ebb.1717402403.git.ps@pks.im>
Date: Mon, 03 Jun 2024 11:08:27 -0700
Message-ID: <xmqqo78h3nms.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4743396E-21D4-11EF-8745-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> When copying refs, we execute `write_copy_table()` to write the new
> table. As the names arge given to use via `arg->newname` and

arge???

> `arg->oldname`, respectively, we optimize away some allocations by
> assigning those fields to the reftable records we are about to write.
> This requires us to cast the input to `char *` pointers as they are in
> fact constant strings. Later on, we then unset the refname for all of
> the records before calling `reftable_log_record_release()` on them.
>
> We also do this when assigning the "HEAD" constant, but here we do not
> cast because its type is `char[]` by default. It's about to be turned
> into `const char *` though once we enable `-Wwrite-strings` and will
> thus cause another warning.
>
> It's quite dubious whether this micro-optimization really helps. We're
> about to write to disk anyway, which is going to be way slower than a
> small handful of allocations. Let's drop the optimization altogther and
> instead copy arguments to simplify the code and avoid the future warning
> with `-Wwrite-strings`.

It certainly makes the final clean-up part simpler, which is a good
sign.
