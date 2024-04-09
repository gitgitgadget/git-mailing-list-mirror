Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED582657AE
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 05:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712640898; cv=none; b=fY7YPf2WXkK/jj6DJGKZaCHie3mlxH4jRxf6GtPz3OJZQuTj1OVsgUuys83bECOgdSvV5EzkvjQnHoXFRKccc32r82MjY+F7ZGn5HLwn8K/KJRiGZ5fndqwvMsIjDFbOtjf821fD3vLiZBG7SPX+laYrYZ/dR8pMP1EaqQX13QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712640898; c=relaxed/simple;
	bh=A1hyxBesPEzfOHnr+aKb6pIkp8eqCfhFal7r84OU8fY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O7NrjlPl9nnoUcRnEnP5MnhLGNzWrpWj+fG3FxLEdyZisWRG75frErIVr1JQUvALsRvq5g0rNr8xBEomsqcNeHXa0wY87OrqaidMAYKpaUI35LP9JVM4mIWBfTLhOVePADG2vkV1E/ldjo6aKXJk4+mtaLaGX/hwa6KY7vHrf/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=sjfSMOJP; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sjfSMOJP"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 954EB1DFB62;
	Tue,  9 Apr 2024 01:34:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=A1hyxBesPEzfOHnr+aKb6pIkp8eqCfhFal7r84
	OU8fY=; b=sjfSMOJPHMOLmydqTqEZsNkkhRhK6uC6G6IY7HUcHDBX1x9OtN4ep0
	INrHJ7OD7osXB8MLZaGEeXlaQ7+oi3H/1XBDlcVY7ktRhLcAOiuUTcGc62uIKe0N
	IJTf5HK0WD33RBCPvRS6VhfsBlXt3ALf9SzCU0WdR+NdRGjOiZrp4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C5241DFB61;
	Tue,  9 Apr 2024 01:34:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0651B1DFB60;
	Tue,  9 Apr 2024 01:34:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Han-Wen Nienhuys <hanwenn@gmail.com>,  Josh
 Steadmon <steadmon@google.com>,  Luca Milanesio
 <luca.milanesio@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 00/12] t: exercise Git/JGit reftable compatibility
In-Reply-To: <ZhS5Ws7e0tjwlW6y@tanuki> (Patrick Steinhardt's message of "Tue,
	9 Apr 2024 05:43:22 +0200")
References: <cover.1712235356.git.ps@pks.im> <cover.1712555682.git.ps@pks.im>
	<xmqqle5n2sbf.fsf@gitster.g> <ZhS5Ws7e0tjwlW6y@tanuki>
Date: Mon, 08 Apr 2024 22:34:53 -0700
Message-ID: <xmqqbk6j2j5u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E54631E8-F632-11EE-A898-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Apr 08, 2024 at 07:17:08PM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > CI runs for this series:
>> >
>> >     - https://github.com/git/git/actions/runs/8595241646/
>> >     - https://gitlab.com/gitlab-org/git/-/pipelines/1243766428
>> 
>> Thanks.
>> 
>> When this is queued on 'seen', I seem to be getting test errors from
>> t0610.  I suspect that it is not a breakage in this series, but the
>> fact that this series enables reftable tests without setting any
>> GIT_TEST_ environment variables, that causes an existing breakage
>> (or two) more visible.  I did not have time to locate which (other)
>> topic introduces the breakage, though.
>
> Interesting, I cannot reproduce any failures with the current state of
> seen (17ff004052 (Merge branch 'ps/ci-test-with-jgit' into seen,
> 2024-04-08)). Was this on your local machine or in CI? Which platform
> are you using? Could you maybe provide logs of the failing tests?

Local execution on some variant of Debian testing.

The tests that fail are t0610.29 and t0610.30, both of which are
"honors core.sharedRepository" with umask 002 and umask 022.
They expect "-rw-rw-r--", but actually get "-rw-rw----" when
the user's umask is 077 (or 007 for that matter).

If you add "umask 002" or "umask 022" near the beginning of the
script (e.g. before including test-lib.sh), the tests pass even when
the user's umask is 077 or 007 when the tests are run, of course, so
there is something the test must be doing in the test repository
before it forces the umask to 002/022.

