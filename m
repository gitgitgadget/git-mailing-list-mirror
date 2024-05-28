Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5376416EBE2
	for <git@vger.kernel.org>; Tue, 28 May 2024 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716915989; cv=none; b=llwoUNCoZJQaE9nmI2QHLp8zLSosqhbo0OgfwEf2e6pmnoAHPnXNBSln69tTblxPUihS5EtLmO555rUkmthe1FAmao5SFesh/J5KK5h4275e6xEd20GeWuJ15NrBWfMXu1Z7MZ3Q7x36KqZuIkoqw2CXBdjMm2p5wjhyqMGJtSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716915989; c=relaxed/simple;
	bh=BH3Xg4FWUIDFTpAvrFSx48QwR1k1qDCbev4EFf/awpo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CyXMzy5UF7iNZq5fyNwOQO+D9BymOenS+czBqqZZWrmxiJ5aDIdYBZ9hcf0gKmeTIxuXhZ3CIeN+uW/D/IZMlnC9RP5k1YPJrsZD2NkUaPIUKn4O66/De28u4oYicqznC88L6RDFB1zZte4quVruLWGgh4niC42xWNeCp0POzT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=l9/H+giW; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="l9/H+giW"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2DA8C1AFDA;
	Tue, 28 May 2024 13:06:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=BH3Xg4FWUIDFTpAvrFSx48QwR1k1qDCbev4EFf
	/awpo=; b=l9/H+giWL+nlweM/a5o0nFrZTtkXkSijbAo03zE7Xcyn4ZW2w4r8ij
	S6Q24KSdo5R4dlKfL6KIkHyAVF3BI+zoPzRIeDNNdru+4cIeZBZAF4R7e8Kdn+Cr
	W0RW8ZftuXdmJ3mkWV0ijepFqI30yOG0ljSRiD1+TtR7vDWEk3B7w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 257731AFD9;
	Tue, 28 May 2024 13:06:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 859E41AFD8;
	Tue, 28 May 2024 13:06:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: darcy via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  darcy <acednes@gmail.com>
Subject: Re: [PATCH] fix: prevent date underflow when using positive
 timezone offset
In-Reply-To: <ZlXkvEeR-PgZMitx@tanuki> (Patrick Steinhardt's message of "Tue,
	28 May 2024 16:05:48 +0200")
References: <pull.1726.git.git.1716801427015.gitgitgadget@gmail.com>
	<ZlXkvEeR-PgZMitx@tanuki>
Date: Tue, 28 May 2024 10:06:24 -0700
Message-ID: <xmqqmso96f3j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9DCB6C08-1D14-11EF-BE0D-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, May 27, 2024 at 09:17:06AM +0000, darcy via GitGitGadget wrote:
>> From: darcy <acednes@gmail.com>
>
> The commit message should start with the subsystem that you're touching,
> which in this case would be "date", e.g.:
>
>     date: detect underflow when parsing dates with positive timezone offset
>
>> Overriding the date of a commit to be `1970-01-01` with a large enough
>> timezone for the equivalent GMT time to before 1970 is no longer
>> accepted.
>
> Okay.

"is no longer accepted" made me read the sentence three times to get
what the author wants to say.  Initially I thought the author wanted
to report a regression where we used to accept but with a recent
change we stopped accepting.

In our convention, we present the status quo, point out why it is
awkard/incorrect/bad, and then propose a new behaviour.

    Overriding ... before 1970 BEHAVES THIS WAY.

    This leads to BAD BEHAVIOUR FOR SUCH AND SUCH REASONS.

    Instead check the timezone offset and fail if the resulting time
    becomes before the epoch, "1970-01-01T00:00:00Z", when parsing.

with the blanks filled in appropriately would have been much easier
to see.

>> Example: `GIT_COMMITTER_DATE='1970-01-01T00:00:00+10' git commit` would
>> previously be accepted, only to unexpectedly fail in other parts of the
>> code, such as `git push`. The timestamp is now checked against postitive
>> timezone values.
>
> How exactly does the failure look like before and after?

Yes, good question.

>> Signed-off-by: darcy <acednes@gmail.com>
>> ---

I cannot offhand tell if Documentation/SubmittingPatches:real-name
is followed here or ignored, so just to double check...

Everything else in your review made sense to me.  I guess that
checking for tm_hour is assuming that TZ offset should always come
before the values necessary to compute the timestamp comes, but it
smells like an unwarranted assumption and not explaining the change
in the proposed log message is a bad sign.

Thanks.
