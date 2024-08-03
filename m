Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C83A81E
	for <git@vger.kernel.org>; Sat,  3 Aug 2024 00:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722644866; cv=none; b=g9rU6V4/q83MV63yZT+8sntqEtwQ2DUDz5KOntjdl7fLD8lYpJzOV6F70FVoddGVYE2XA4okkQRqJAKnXGhxQ0kblZchDoMzNY5Kr42Q7r4c8Hylr6mHo6WMsBHWa2cs8pnix1I70W/1Mboh4/hEA7nrQQC2mLmoZRymcHda4nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722644866; c=relaxed/simple;
	bh=VKN91gJFFmOZBjzqamcUwlkUWSKqHa+zAfquIUz3bG4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iYpB/rpTkf8MQuZevKSBeK8xwRp78Ek2Yx4AtWSWRxWhmr9wzp/4EXRWxVpM48qlXn85G/05TtefP5k2HnPmear7Zu/KowyV2gxyOTJ3kQEl4jWEZAz2FLh5l6PuJVVaS/6oyjj0kq0LO68aljezgr0IBmNyVMNDoWUPUJJcwv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=I17K3sqO; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="I17K3sqO"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9B1FE1E054;
	Fri,  2 Aug 2024 20:27:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VKN91gJFFmOZBjzqamcUwlkUWSKqHa+zAfquIU
	z3bG4=; b=I17K3sqO/NgHs064RBIvvXdPC86bL85LV4Abt3LpGJG9NDR/VcyJVx
	Ht/IJMfCwMN7AVEJmtz0f2j26X1UoCJSBGs5eRJw7f7y1FEurMG09V4ECLLSeaXK
	T9quXiiku4NL9GXT5xavWhKKqNeGXExPT8yv2z1lBT3x3ZUZhBYTk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 85CF01E053;
	Fri,  2 Aug 2024 20:27:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 868751E052;
	Fri,  2 Aug 2024 20:27:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Lippincott <spectral@google.com>
Cc: Kyle Lippincott via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 3/3] t6421: fix test to work when repo dir contains d0
In-Reply-To: <CAO_smVh-gQWy7xUJgFjd6gUWCTV5jTYJ9E9E3rvaQg0EY-2BdQ@mail.gmail.com>
	(Kyle Lippincott's message of "Fri, 2 Aug 2024 17:03:45 -0700")
References: <pull.1756.git.git.1722571853.gitgitgadget@gmail.com>
	<pull.1756.v2.git.git.1722632287.gitgitgadget@gmail.com>
	<818dc9e6b3e8a4d449cb9dbce689bfadb95099ff.1722632287.git.gitgitgadget@gmail.com>
	<xmqqr0b6a9hp.fsf@gitster.g>
	<CAO_smVh-gQWy7xUJgFjd6gUWCTV5jTYJ9E9E3rvaQg0EY-2BdQ@mail.gmail.com>
Date: Fri, 02 Aug 2024 17:27:32 -0700
Message-ID: <xmqqcymq8n7v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2DCF4100-512F-11EF-98FB-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Kyle Lippincott <spectral@google.com> writes:

>> So it really didn't have to clarify what it is looking for, as it
>> would not help seeing what false positives the patterns are designed
>> to avoid matching.  Sorry about that.
>
> I would have included examples, but they're quite long (>>>80 chars),
> so seemed very out of place in both commit description and in the
> codebase.

Absolutely.  It turned out not to be so useful to show the shape of
potential matches, like this one:

 ... run-command.c:733            | d0 | main      | child_start  |...

To explain why spaces around " d0 " matters, the readers need to
understand that other trace entries that are irrelevant for our
purpose, like this one

    ... | label:do_write_index /path/to/t/trash directory.../.git/index.lock

we want reject, and for that we want the pattern to be specific
enough by looking for " do " that is followed by " child_start ".
Otherwise the leading paths that can contain anything won't easily
match, and the original of looking for just "d0" was way too error
prone.  But it is hard to leave a concise hint for that there.

So, again, sorry about the bad suggestion.

> I considered using `awk -F"|" "\$2~/d0/ &&
> \$9~/fetch\\.negotiationAlgorithm/{ print }" trace.output >fetches`,
> but it was longer, possibly less clear, and less specific (since it
> didn't include the $4~/child_start/ condition)

Yeah, using the syntactic clue -F"|" would also be a way to convey
the intention (i.e. "we are dealing with tabular output and we
expect nth column to be X"), but what you have is probably good
enough---it certainly is simpler to read and understand.  I briefly
considered that looking for "| d0 |" (i.e. explicitly mentioning the
column separator in the pattern) would make it even more obvious
what we are looking for, but having to worry about quoting "|" in
regexp would negate the benefit of obviousness out of the approach
to use "grep".

Thanks.
