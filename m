Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA38B1DA3A
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 23:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709940736; cv=none; b=WH+tio9grIWEZn+eailvzyq5MYUdOlX4yj0fNA0Wkhk8l4DGQAfcnxfE4P22knUVa/DUFFvm3W96Pida9OlWkLmB5THvwJpbX1moIOYIwRWSAVrNYnLpG8mKJzIw5KATroDyEUbXSZwMTuZrIbbxfx1ZTKMoxoJevFF6KwV/y2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709940736; c=relaxed/simple;
	bh=hJIsR9t8NorZ0oP04ISEYL+G/NNGA2AEkl339MSYeJs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D6YDfXQUXilEIBT3yuGMKpCwf+lvBOadWY/ygx3LEeLRnVcAqWaTKgTakmcz0vVVV/H0eYvNH0fYwdWzdeI3ZFndkDp0xEY2hvOuYbgvwUoYVarC6/PRq34BRZDKMvFmw3HfFJgFDspGpGFbVD+yumiNKqsIovchsOmBer44dCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=g5Qcft+8; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g5Qcft+8"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6BB2C1EFFD5;
	Fri,  8 Mar 2024 18:32:13 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hJIsR9t8NorZ0oP04ISEYL+G/NNGA2AEkl339M
	SYeJs=; b=g5Qcft+8nSc39GljHFgWzjSuXPueQPREKo7MfEUqi8E1mHpLi64+Bk
	9VMNLvO802cf12waTJf1svDXJp2+duv/nUnVhH3PPs3pUWxI8Pb8kJTEYHJNnKGo
	UUDdEjuyybAD9n9RNzVi97ZO5Lien987U91XXSvfsVW6o5kr4PYkk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6325E1EFFD4;
	Fri,  8 Mar 2024 18:32:13 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B9FFC1EFFD3;
	Fri,  8 Mar 2024 18:32:12 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Lippincott <spectral@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] setup: make bareRepository=explicit work in GIT_DIR
 of a secondary worktree
In-Reply-To: <CAO_smVjrKJeKr7QgQWryZRErStFk=Y+1T=dwrR_boXQD_X9_Mg@mail.gmail.com>
	(Kyle Lippincott's message of "Fri, 8 Mar 2024 15:10:16 -0800")
References: <xmqqv85zqniu.fsf@gitster.g>
	<20240308211957.3758770-1-gitster@pobox.com>
	<20240308211957.3758770-3-gitster@pobox.com>
	<CAO_smVjrKJeKr7QgQWryZRErStFk=Y+1T=dwrR_boXQD_X9_Mg@mail.gmail.com>
Date: Fri, 08 Mar 2024 15:32:11 -0800
Message-ID: <xmqqy1ase1vo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1725AEAC-DDA4-11EE-A614-25B3960A682E-77302942!pb-smtp2.pobox.com

Kyle Lippincott <spectral@google.com> writes:

>>     $ cat ../seconary/.git
>
> Nit: typo, should be `secondary` (missing the `d`)

Good eyes.  Thanks.

>> +       /*
>> +        * We should be a subdirectory of /.git/worktrees inside
>> +        * the $GIT_DIR of the primary worktree.
>> +        *
>> +        * NEEDSWORK: some folks create secondary worktrees out of a
>> +        * bare repository; they don't count ;-), at least not yet.
>> +        */
>> +       if (!strstr(path, "/.git/worktrees/"))
>
> Do we need to be concerned about path separators being different on
> Windows? Or have they already been normalized here?

I am not certain offhand, but if they need to tolerate different
separators, they can send in patches.

>> +               goto out;
>> +
>> +       /*
>> +        * Does gitdir that points at the ".git" file at the root of
>> +        * the secondary worktree roundtrip here?
>> +        */
>
> What loss of security do we have if we don't have as stringent of a
> check? i.e. if we just did `return !!strstr(path, "/.git/worktrees/)`?

No loss of security.

These "keep result the status we want to return if we want to return
immediately here, and always jump to the out label instead of
returning" patterns is mere a disciplined way to make it easier to
write code that does not leak.  The very first one may not have to
do the "goto out" and instead immediately return, but by writing
this way, I do not need to be always looking out to shoot down
patches that adds new check and/or allocations before this
condition and early "out".

> Or maybe we even combine the existing ends_with(.git) check with this

At the mechanical level, perhaps, but I'd want logically separate
things treated as distinct cases.  One is about being inside
$GIT_DIR of the primary worktrees (where more than majority of users
will encounter) and the new one is about being inside $GIT_DIR of
secondaries.
