Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3772DDB8
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721312500; cv=none; b=YJHYVFQD/ENAPq8YqMht7XSJVvC8mMAMVn7QF88qRg9AgMbgwzBLQupA0y7Af3K6+Nt/4rMhk2quTXcIzsygCV5aiYTS3AEMyHS6mRx3aWaP+7YzxYhS4aK6CFExFf22OmJIvjYBeYU2EyhKbs5toWoVJvA76upX21BXoKQAr94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721312500; c=relaxed/simple;
	bh=xo2OzHspBjdmbX4eGV2qqz8QbYM6cO3m1Eo8SnTngIA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mJBk10E9NqTKL3gcV7bK2c8vI6yb/FxMxX/eVpmjdoakCwpT8qty08xfmuxkOTg521YJIZeV6QxyB0vfjgZEc7LyceKkPVUFf2aqZnVmcBgGQ/neanAWkPc7T1hCU4AivbIFiVLgfecTyOKILnBoLCYpu/Cy+f6Ox6i2BrAuw4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=EenUFP3G; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EenUFP3G"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8BFF52AB07;
	Thu, 18 Jul 2024 10:21:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xo2OzHspBjdmbX4eGV2qqz8QbYM6cO3m1Eo8Sn
	TngIA=; b=EenUFP3G+fkmg+dRD3Tc300wjlrqt3UOHwKs6FwOxXAVb6YHy0U4Bb
	3zGiD5299+aPU0rjPu2jsDPOEkyBJ+JyhH/SFju0OK+8g4whTXT0MWvBFI2CbhCB
	uWLp32mR7PnAx+pLIXQFLwIP572MHnGeOY7n7l0pWAerLNjjHGTI8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 853612AB06;
	Thu, 18 Jul 2024 10:21:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EED3F2AB05;
	Thu, 18 Jul 2024 10:21:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Philip Kaludercic <philipk@posteo.net>
Cc: git@vger.kernel.org
Subject: Re: Best practices for indicating what address to send patches to?
In-Reply-To: <87msmfrn3r.fsf@posteo.net> (Philip Kaludercic's message of "Thu,
	18 Jul 2024 10:49:44 +0000")
References: <87msmfrn3r.fsf@posteo.net>
Date: Thu, 18 Jul 2024 07:21:33 -0700
Message-ID: <xmqqh6cmzspe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 099EC2EE-4511-11EF-88D1-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Philip Kaludercic <philipk@posteo.net> writes:

> Hi, I was wondering if anyone had a good suggestion on how to indicate
> where to send a patch to.  Ideally I'd like to have "sendemail.to"
> configured on cloning, but that isn't possible IIUC.  There also doesn't
> seem to be a conventional file like ".git-email" that would list where
> to send a patch, without having to look it up.
>
> Is this intentional, has it been discussed in the past or is there the
> chance that it might be improved upon in the future?

The usual convention is to have the patch submission address (if a
project uses e-mail based patch as its workflow) together with other
rules and guidelines the contributors are expected to adhere to in
documents like README, CONTRIBUTING, etc.  As an e-mailed patch that
does not follow established conventions is not necessarily useful to
the receiving projects, it is a good practice to put these pieces of
information crucial to start contributing in a single place.

It would not be an improvement to add a mechanism to make it easier
to find "here is the address" to a reader who hasn't even discovered
where these contributor guide documents are.

Thanks.
