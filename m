Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D839983CD9
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407537; cv=none; b=OYX4UI/dzU+hrAh/9vM6bbDqxA5lzcRXnQEBUw1/b9B/EISW4a+RteZEvNjUOJg8/I8CreRUKYuFPmAHWjwIiNbmIJ6RhMhA4uzOaoLLMQ+F15EOQQYRlD3ZKQ2gEisRoi/259ctjKlmUQrVQ25177HMHxHQ//BgkbG+Q8op86g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407537; c=relaxed/simple;
	bh=/WME3fDW7GAmTfMzkmTg9N0S//2wf7QGKn49nFAYWl8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mPXRp8u95WFGQe6WcleakCvgpfCEbC+RKGTzytd1AcA7ElGlEmsJ0UbhbQXIF7cAy5yZsdhogzbPrOJzy2HCHaC/BmhUWIkG9M/uczD53JhJX3U7j5utxyI0qjzRcOt/x1Cjc2CfXyJATzaqhnJiwGkkt/emOpGtFbvEeGHQIXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MzAyJh8b; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MzAyJh8b"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4DC343E662;
	Mon, 29 Apr 2024 12:18:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/WME3fDW7GAmTfMzkmTg9N0S//2wf7QGKn49nF
	AYWl8=; b=MzAyJh8bHKi4RrsvXUr40py9RRsJ7HjlbiJQcLRw+zevZ5WmI5KTXu
	JMruor4LoNLQJjs/Xh6Adhk8Hn1SFrpXhXQfEpUvoXAL69xaOmCKnozYyFSU1MDQ
	1d7eFmlp0IEb+iDSjEKSplFCGrof6qwGSfiiXur8TwKHJP/dztvwU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 45C4F3E661;
	Mon, 29 Apr 2024 12:18:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B4ECB3E656;
	Mon, 29 Apr 2024 12:18:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: Jeff King <peff@peff.net>,  Phillip Wood <phillip.wood@dunelm.org.uk>,
  Karthik Nayak <karthik.188@gmail.com>,  christian.couder@gmail.com,
  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v4 1/7] refs: accept symref values in
 `ref_transaction[_add]_update`
In-Reply-To: <b2977495-3b4a-4f2a-85dc-d0568f34f2e9@gmail.com> (phillip's
	message of "Mon, 29 Apr 2024 10:32:58 +0100")
References: <20240423212818.574123-1-knayak@gitlab.com>
	<20240426152449.228860-1-knayak@gitlab.com>
	<20240426152449.228860-2-knayak@gitlab.com>
	<xmqq1q6rc44n.fsf@gitster.g>
	<20240426211529.GD13703@coredump.intra.peff.net>
	<b2977495-3b4a-4f2a-85dc-d0568f34f2e9@gmail.com>
Date: Mon, 29 Apr 2024 09:18:47 -0700
Message-ID: <xmqqo79sxhug.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 29063F38-0644-11EF-8572-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

phillip.wood123@gmail.com writes:

> ALLOW_ONELEVEL just disables the check that the refname contains a '/'
> and I think it is aimed at checking branch and tag names without a
> refs/{heads,tags} prefix. If we want to move away from using
> refname_is_safe() perhaps we could add an ALLOW_PSEUDOREF flag that
> only allows the name to contain '[A-Z_]' if there is no '/'.

Makes sense.

I wonder if we eventually can get rid of ALLOW_ONELEVEL, though.  If
all callers that use ALLOW_ONELEVEL know under which prefix they
plan to hang the refname they are checking (if the refname passed
the check), we can force the check to be performed always on the
full refname, and it will become easier to make the check more
consistent---as the check will have full context information.

For example, with ALLOW_ONELEVEL the check may say "HEAD" is OK, but
if we get rid of ALLOW_ONELEVEL and force the callers to always test
the full refname, we may say "refs/heads/HEAD" is not acceptable,
neither is "refs/tags/HEAD", but "refs/remotes/origin/HEAD" is good.

