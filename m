Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE90C1879
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 19:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711567493; cv=none; b=IQ2LmIkP6tfNSB7dGFT4bjSwMgmC/BbJ4TCYonCU1bEZhRXCNPQD08+FX+gXtxMH4ivNm7RFjFus+E6qdSKIAXUoGy/PMjuqVThzJJ3G1z9maA3UoDVP3nu1MEyFNahdYT+FVNMHiUWm9sPK2+4JvViCQBikf2Qs4h1cFiLTkJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711567493; c=relaxed/simple;
	bh=PkuHb/d609zihw87UjjlVvnNxihWEhJZmhJDa37jUTM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a+iSYva1ROaUHbpcb1il+5fUFdcSCAouNMHRUEfw3W7xpfUrBNkgG2SizyU7B5WqWHwYotDMxBzFYBLecc798LqA9WZfhM0/eS4m04OeVhy+yCsY2hcye8pz8DhuCZiBByUGXoNc7tKxvXjToqlYkJCYBRbGIn28uEuSyGm6UnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VV9tTirH; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VV9tTirH"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 56523379E1;
	Wed, 27 Mar 2024 15:24:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PkuHb/d609zihw87UjjlVvnNxihWEhJZmhJDa3
	7jUTM=; b=VV9tTirHHjMBqHlIjuDGkVJtWWh6mZ/+wAX8mO0iiZEwVP2gqkkK/5
	m5ogqAw9MC0m+fayXbSoruB09p1GoUo5NKKIBOw6HJ+mIVsnSgG+6ciiNz0an8jB
	+KhKsl7QTcEFHUg3WzRw+miD9wmG+IGHRNFxTd09+8bxxCz9j0Aew=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F749379E0;
	Wed, 27 Mar 2024 15:24:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 28011379DF;
	Wed, 27 Mar 2024 15:24:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: Christian Couder <christian.couder@gmail.com>,  Stefan Haller
 <lists@haller-berlin.de>,  git@vger.kernel.org
Subject: Re: Allow git bisect to auto-skip
In-Reply-To: <7556a3de-a6a6-4284-8c36-3635ae43c653@schinagl.nl> (Olliver
	Schinagl's message of "Wed, 27 Mar 2024 19:33:03 +0100")
References: <3d835c4b-d026-4c6a-b68e-6989a7a2065f@schinagl.nl>
	<xmqqwmptzyny.fsf@gitster.g>
	<01e09c64-4d62-406d-85fe-9fb77939cf63@haller-berlin.de>
	<xmqqle68x008.fsf@gitster.g>
	<e896da79-c87b-4475-9890-10051d8ddf76@haller-berlin.de>
	<CAP8UFD2DhkmVias+RfMESJz9Z-rKKHWHB+MFHcDb9QLO16TOhg@mail.gmail.com>
	<xmqq8r27sclp.fsf@gitster.g>
	<7556a3de-a6a6-4284-8c36-3635ae43c653@schinagl.nl>
Date: Wed, 27 Mar 2024 12:24:43 -0700
Message-ID: <xmqqfrwb1nr8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AB2338B6-EC6F-11EE-A71A-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Olliver Schinagl <oliver@schinagl.nl> writes:

> Anyway, want I was thinking of, based a key somewhere in the message
> body (GIT_BISECT_SKIP=1 for example), mark the commit in the list to
> be skipped, as `git bisect skip` would. This so the skipped commit
> actualyl ends up on the list of skipped commits
> (`refs/bisect/skip-*`).

I think it is very unlikely that we'd adopt any hardcoded scheme
that allows only one supported way of marking commits as not to be
tested.  Certainly not the kind that the committer is forced to know
the commit must be skipped during a bisection session before
creating the commit.  So I am not sure how much good it will do to
know that commit_list->item is a commit object on the list, or
calling repo_get_commit_buffer() on it would give the contents of
the commit object.

Knowing that commit_list->item->object.oid is the object name of
such a commit, and calling oid_to_hex() on such an object name
stringifies it, should be sufficient to write a new code that calls
out to a script specified via "git bisect --skip-when=<script>"
using the run_command() API to decide if the commit object should be
skipped, and if you do want GIT_BISECT_SKIP=1 in the log message,
your script given via --skip-when may be a single-liner:

    #!/bin/sh
    # usage: this-script $commit_object_name
    # expected to exit with 0 when the commit should not be tested
    git cat-file commit "$1" | sed -e '1,/^$/d' | grep GIT_BISECT_SKIP=1

Thanks.
