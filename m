Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491CD28E22
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 23:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707174441; cv=none; b=npIRcc+7mi1FvnSCDK9/GhzTieCf1L1AsKo/zt6CIvHntWnUo7sAN0ggMDTfDksKf5N43/h/PZgCuSW0JHbE9ary5w6w8QWdTn/sfRbakWFhG7MltKlk4qIqGA8yUXcDaiFQRnddd0idvCM0EDw7opCr31ua5vQS8EUmMwrlqEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707174441; c=relaxed/simple;
	bh=/jJnaaXzIFYwQd7tKDkqkHnct2P4TSAeCI592jDK+Pc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GO8TE1u4s+I/+HFrAJhGdftj9AsndMlcd20QMqfB3c8o4U4Yk5FvQDihJuMwsXIsalK0yl3mYWNLmEtIm8mdDDtNOwoxt7OY6Jzlhs6mY0TIKlZOX5akmKM+EnyL6bgq6kq9Qb+qlaYWuAbMYiqUDetUPqRiQZHV1egnne81u2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QIWLxyhT; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QIWLxyhT"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 708AF1E3354;
	Mon,  5 Feb 2024 18:07:13 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/jJnaaXzIFYwQd7tKDkqkHnct2P4TSAeCI592j
	DK+Pc=; b=QIWLxyhTe/y1NMU43UJVGui2QaE5lGly4ipyK4+71O37NeM3tp4tfI
	UzsF9giUCJMSSRlmEUjmg3jQdpTkfbbGXh5idNyAL6J/RX6cT6VSla4MPz8+8+4I
	CwI98g+6eGkrCd6gry5ZldPzdtfH6Q8+5A4a1wrey0Kcy/NGJMDhA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 68C201E3353;
	Mon,  5 Feb 2024 18:07:13 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9F42B1E3352;
	Mon,  5 Feb 2024 18:07:12 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,  git@vger.kernel.org,
  ps@pks.im
Subject: Re: [PATCH v3 2/2] add-patch: classify '@' as a synonym for 'HEAD'
In-Reply-To: <9f9f26f1-5460-468e-a893-5caf7fbea981@gmail.com> (Phillip Wood's
	message of "Mon, 5 Feb 2024 16:37:22 +0000")
References: <20240202150434.11256-1-shyamthakkar001@gmail.com>
	<20240203112619.979239-6-shyamthakkar001@gmail.com>
	<9f9f26f1-5460-468e-a893-5caf7fbea981@gmail.com>
Date: Mon, 05 Feb 2024 15:07:11 -0800
Message-ID: <xmqq34u6o6hs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4BCB0FC2-C47B-11EE-8B04-25B3960A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> As well as the places you have converted we also have an explicit test
> for "HEAD" in parse_diff() which looks like
>
> 	if (s->revision) {
> 		struct object_id oid;
> 		strvec_push(&args,
> 			    /* could be on an unborn branch */
> 			    !strcmp("HEAD", s->revision) &&
> 			    repo_get_oid(the_repository, "HEAD", &oid) ?
> 			    empty_tree_oid_hex() : s->revision);
> 	}
>
> I suspect we need to update that code as well to accept "@" as a
> synonym for "HEAD" on an unborn branch.

I actually think "@" in the input should be normalized to "HEAD" as
soon as possible.  After the if/elseif/ cascade in run_add_p() the
patch in this thread touches, there is an assignment

	s.revision = revision;

and even though we rewrite !strcmp(revision, "HEAD") to "user means
HEAD" to additionally accept "@" in that if/elseif/ cascade, here we
will stuff different values to s.revision here.  We could normalize
the end-user supplied "@" to "HEAD" before making this assignment,
then you do not have to worry about the code in parse_diff() above,
and more importantly, we do not have to rely on what the current set
of callers happen to do and do not happen to do (e.g., "git reset
-p" happens to use hardcoded "HEAD" for unborn case without using
anything obtained from the user, so the above code in parse_diff()
might be safe in that case, but we do not want to rely on such
subtlety to make sure our code is correct)

Come to think of it, we could even do the "normalizing" even before,
and that might greatly simplify things.  For example, if we did so
at the very beginning of run_add_p(), before we come to that if/else
if/ cascade, we may not even have to worry about the "user meant HEAD"
helper.  After the normalization, we can just keep using !strcmp()
with "HEAD" alone.  Simple and clean, no?

Thanks.


