Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B731BC58
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720289719; cv=none; b=uSW3zEy3HuQ1SXy2Lsb93YstKZ79056jCKK7D8Nqnm4D8jKGNvzmtl7RaREl8vWksURFbA2enlYZs2PoA2qIkglc2a+LqaJGSgEeP3MjYVVxuWzuML0PFZl2rp7ob1y53eSRAQttn0NsXZztDc+QWpKRM7QwH9RBGJJVQ3iU6VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720289719; c=relaxed/simple;
	bh=4s6pEN/Ejch4zFxEiWAGRxfvE/t1t7lWAdPKT2Frv+k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N+wvM/tIMxQk7KOarlp1iGMPNtgf2PV4wRqQStP9wLFwIdNlh0VA7B5pugZ5gTm6KCZu5t4jssUK/qoIeIU9tqjpmJs2Mfo8bGrlKnM8REhqXGAiWQGQyNwq9wkqC9d9t0YTnZb60jx8kDFU58F9hrbb5OkTBVZcSaA9qvNK5zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ACVFIOOU; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ACVFIOOU"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CF49F2668E;
	Sat,  6 Jul 2024 14:15:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4s6pEN/Ejch4zFxEiWAGRxfvE/t1t7lWAdPKT2
	Frv+k=; b=ACVFIOOUyTJtXpoty//Rz0tbhpIXsZvD97LqfV05f78XG24FqAW/dW
	pADWHUNZE7qZA4pvrB8rZw+bDg7k8T2Ctf/KPXa5wV+wARpe9epCqRE/vBMsLGGJ
	kMwYqhysnG//HF3qoSN9nwG7dFJf5XBKvogc51RrnqABAtVHaWkw8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C5F4A2668D;
	Sat,  6 Jul 2024 14:15:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 94FAF2668C;
	Sat,  6 Jul 2024 14:15:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  brianmlyles
 <brianmlyles@gmail.com>,  git@vger.kernel.org,  Sean Allred
 <allred.sean@gmail.com>
Subject: Re: [BUG REPORT] git-gui invokes prepare-commit-msg hook incorrectly
In-Reply-To: <752d41f9-6ce3-4c31-a0a2-4960c7dc1b2b@kdbg.org> (Johannes Sixt's
	message of "Sat, 6 Jul 2024 16:03:51 +0200")
References: <17df67804ef7a3c8.df629cdadcf4ea15.524a056283063601@EPIC94403>
	<CAPig+cRQPrtGBTxM49nUeHvsVr0qEOnKZ5W_4by=A9mXEsR3DA@mail.gmail.com>
	<m034onpng4.fsf@epic96565.epic.com>
	<CAPig+cS2r-b22ikZZ6QHpzfneQ07n6s=E40Sb+QYmCnezVFAww@mail.gmail.com>
	<752d41f9-6ce3-4c31-a0a2-4960c7dc1b2b@kdbg.org>
Date: Sat, 06 Jul 2024 11:15:04 -0700
Message-ID: <xmqqtth2petz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AC3F4F98-3BC3-11EF-BD0F-C38742FD603B-77302942!pb-smtp20.pobox.com

Johannes Sixt <j6t@kdbg.org> writes:

> My take-away is:
>
> - The commit message that is entered in the edit box must appear in the
> commit unmodified. There is no such concept as "comment lines" in git
> gui's commit message edit box. The commit-msg hook can overrule
> nevertheless as a means to enforce message hygiene, but otherwise the
> user must have full authority.
>
> - A commit message template and the MERGE_MSG file are populated in a
> manner that is suitable for `git commit`, i.e. can (and do) contain
> comment lines. It is, therefore, necessary to remove them when their
> text is used to populate git gui's edit box.
>
> I suggest that removing comment lines ("message-washing") should not
> happen as a post-processing step, but as a preprocessing step when text
> is gathered from particular sources that are known to contain
> inessential cruft.

I agree most of the things you said, but with one reservation.

There may be two classes of comments CLI "git commit" users would be
seeing, ones coming from the "git commit" itself that describe what
CLI "git commit" does (e.g., "lines starting with '#' are ignored",
"absolutely empty message buffer aborts the command"), and others
coming from project specific template and other mechanisms that
describe what the project expects (e.g., "please keep your lines
shorter than 72 columns").

I agree that it makes perfect sense not to show the former at all to
the end-user in git-gui UI, especially if git-gui does not ignore
lines starting with '#' or abort commit with an empty message.

I am not sure if it is safe to strip the latter out of user's view,
though.
