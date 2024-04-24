Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C44156964
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 23:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714001507; cv=none; b=Ht8OGri4aVySv3hG0aeZlOP5U+JDTSXG6rnnDocJqPZSdTYbg4nzo5JGQArgaJbnQ3Pi8qnbyewPpD1I6ibHxApE7p6V+ejf4bCWSbRjXIycwpWuik9QPzzDN9PUpHtqPUp8T1UYsp6qKrV7URNQDCobRgEBXcJP0BH4c9by5mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714001507; c=relaxed/simple;
	bh=ssXCvoGiFo5soCkpzpana/bHgoswHSy/dE8MU6fr1Ew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NYHSYFIHyGEnavj/UNQ2t3lTivrJzPJdBvhuwv9JTmqTuS8xoCBe8H5vykOOEDO2DtjycCPti+F19xjlrlt3iBdyQYKRIBsAL5pPhnBiRKisiqhVElNbpVdwYcG/iD/3+hhTpjt+YOemikMhuTJ44/TZuGmaWYQTybSgzRpTNcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mZ2a1ayQ; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mZ2a1ayQ"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CD12B1E2DD;
	Wed, 24 Apr 2024 19:31:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ssXCvoGiFo5soCkpzpana/bHgoswHSy/dE8MU6
	fr1Ew=; b=mZ2a1ayQinAX9iXkIV6/dnXxJesEXBRflgc1cBblr7koeXx8jj6rcQ
	KOKG8GzYaEYGEonHIiVzT+blwdTEaBY1aPCGx/lGYZrTmgSHM8q4pjULjv2vF576
	jQ6onrfw0Ab4r1EdQSNAxEuwZtr55uXkqWpI11yLMmkAgZy8TmMWQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C52981E2DC;
	Wed, 24 Apr 2024 19:31:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 34E6F1E2DB;
	Wed, 24 Apr 2024 19:31:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chris Torek <chris.torek@gmail.com>
Cc: Tim Chase <git@tim.thechases.com>,  git@vger.kernel.org
Subject: Re: Stashing just index..working-copy rather than HEAD..working-copy?
In-Reply-To: <CAPx1GvcxyDDQmCssMjEnt6JoV6qPc5ZUpgPLX3mpUC_4PNYA1w@mail.gmail.com>
	(Chris Torek's message of "Wed, 24 Apr 2024 15:17:41 -0700")
References: <ZikMqXeDnOqK_wlq@thechases.com>
	<CAPx1GvcxyDDQmCssMjEnt6JoV6qPc5ZUpgPLX3mpUC_4PNYA1w@mail.gmail.com>
Date: Wed, 24 Apr 2024 16:31:37 -0700
Message-ID: <xmqq1q6uwd5y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CBF8CD74-0292-11EF-91C5-25B3960A682E-77302942!pb-smtp2.pobox.com

Chris Torek <chris.torek@gmail.com> writes:

> With all that said, I'd like to make one last suggestion, which
> I think is a lot simpler: *stop using `git stash`*.  Just make
> a commit!

;-)

If I recall correctly, the original design of "git stash" was "I
save everything in the working tree, so that I can start working on
an urgent request immediately, and then later restore everything",
and there was no "--index" option for application, even though the
stash entries were the W commit that is a merge of the I (index)
commit and the B (base) commit.  The "apply/pop --index" was a mere
afterthought that does not work very well and made things more
confusing.  It wasn't meant to be used in anything complex, for
which a separate branch with real commits were the way to go.

There were some reasons (like, working tree side post-commit hooks
that are not well written to distinguish temporary commits from real
ones and send out notifications outside) that some folks wanted to
avoid making a commit on a temporary branch and to them, having a
bit more complex "stash" may have been a way for them to avoid
triggering those poorly designed workflow around post-commit hooks.
But with modern Git in this age with workflows and disciplines
better understood, I agree that we should encourage use of more
temporary branches with real commits.  If there are reasons to cause
developers fear of commitment (e.g., "my $CORP environment forces me
to show every commit I make to CI server, which slows me down and
wastes resources if I make many tentative commits only for
snapshot"), they should be solved in a way that users do not have to
fear commitments.

Thanks.



