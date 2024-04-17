Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C4717167A
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373094; cv=none; b=HGwmCixpCUMgtpwV8SNm+z1XGJAOBVwOdzQJYyzKWoU46o5ktABaE52JDAbHpN6RKlB9wB0ui3b0oN/F2zWMLfTffIntvKVPUPEZRpcWVQjFK4dk2oGqai+aqgXR9ZSeRuA+k0fKa2s3V2QZOY5U+3OVGqeGlZnLXVa/I7iF80s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373094; c=relaxed/simple;
	bh=JEz++chHYm4wqdV7tzdJCOVYFXoBxqs517dbkffU96Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iQhk8wBJ0VIFm4NoUEH2JOfqkWEnrv7JBuHIc6T9t2WfbNlyypR+/7zif9WKKDQM0P4RAAMoCAfAlGMJHq/8VTWCvR74wjkVeSdwoRQ7ztMzX4lyYnWE9IoRVJI+kxmslI7rXA026HaFbLt5Zw0s+D6NZmb5H6g3nWkObLVNLPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=k/h6NAKA; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k/h6NAKA"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E4271DB3D2;
	Wed, 17 Apr 2024 12:54:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JEz++chHYm4wqdV7tzdJCOVYFXoBxqs517dbkf
	fU96Y=; b=k/h6NAKAFzM/yqoj5X612qsQIgoYLNXWE2ybYUkoMmvZvgOGHCxt3Y
	tEcwN0LjgUzIZ5YKJGmR+geyne6ysgpeVYbnU/A+1ojmTQ8mceNYJZAJ+73gCsNU
	vqk78FhItVtTeUsX0NeXdc6RrPDVZZJ1GTTNnWM4+UcGgkgPPS7fk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 957F31DB3D1;
	Wed, 17 Apr 2024 12:54:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0BBED1DB3D0;
	Wed, 17 Apr 2024 12:53:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH 0/2] builtin/receive-pack: convert to use
 git-maintenance(1)
In-Reply-To: <CAOLa=ZTRY6hmQqC2BozFkLmLQWnkQ4+sSug_8N1ZY9+aHNqCTg@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 17 Apr 2024 16:19:43 +0000")
References: <cover.1713334241.git.ps@pks.im>
	<CAOLa=ZTRY6hmQqC2BozFkLmLQWnkQ4+sSug_8N1ZY9+aHNqCTg@mail.gmail.com>
Date: Wed, 17 Apr 2024 09:53:58 -0700
Message-ID: <xmqqwmow7wwp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1681B51C-FCDB-11EE-B1A4-25B3960A682E-77302942!pb-smtp2.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

>> this small patch series adapts git-receive-pack(1) to spawn `git
>> maintenance run --auto` instead of `git gc --auto` like all the other
>> parts of our codebase do nowadays. This removes the last internal user
>> of `git gc --auto`.
>
> I don't have enough context here, so why do this?

I think the intent of a95ce124 (maintenance: replace run_auto_gc(),
2020-09-17) was to update all codepaths that run "git gc --auto" to
instead run "git maintenance --auto", but only updated the ones that
used to call run_auto_gc().  The codepath Patrick found runs "git gc
--auto" without using run_auto_gc() and was left behind when the
others were converted.

So why do this?  I think "To follow through a95ce124 started" would
probably be a good enough reason, if a reader is on board with what
a95ce124 wanted to do.

Do we have a handy reference that compares "gc --auto" and
"maintenance --auto"?  Are they essentially the same thing these
days?  What are the things that is done by one but not by the other?

THanks.
