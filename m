Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2BB19BDC
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 22:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713997414; cv=none; b=LrwPipdc8HMRc86KgFjUjhIx6hfkBlsyTvw3m12It++i+Eewy6TdsCIO1Sd9XH1utYdKUAmc7yiFnGcnIAhuD7yx4t8aPMrBw0Z8HPMAl4YyWaQveKGazM9bid2n59b8pZu5rcFK7r0F98YC1Tc4LnspYUgQ41nF+IaI2MQmoOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713997414; c=relaxed/simple;
	bh=0c+kQrfC8R+ssjIZeUxLrm/zGrYunObJpCj0jkrf+XI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aSxaOIjBC6iD0FLa31N4rKMQv4+bzlHQH8b5rmTzJglur70IDyTGBEXCsaIGbU0u9LkbGifK4XFmdkbburb7QxLyAIvkTLS6LtfF8hbdCBdBc2MKQsXkpNIrcbVQYHBWGjz4E+CA+yEGDDiGQ9jyqsGTcRU/6paOuQbIcy2/tB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RVajBgmN; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RVajBgmN"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E0BDF36EAE;
	Wed, 24 Apr 2024 18:23:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0c+kQrfC8R+ssjIZeUxLrm/zGrYunObJpCj0jk
	rf+XI=; b=RVajBgmNb3GacrcbUdY55Ywp1Nz1cSytMemEsH87fnoWrQ6uZod71q
	UZ08N53HKNnp91iR+18llmnKRHmprI+y2yrx52/twE5p9/RXF/pcm0Ap/ovdB2eH
	oWJBM17vI1/HddrJ3SicjU2kws3T6xwyC+T9zmqq9mOC9K2XxBIjY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D990936EAD;
	Wed, 24 Apr 2024 18:23:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 34DFF36EAC;
	Wed, 24 Apr 2024 18:23:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Dan Demp <drdemp@gmail.com>,  git@vger.kernel.org
Subject: Re: Git Bug Report: git add --patch > "e" makes keyboard unresponsive
In-Reply-To: <Zil_m_1B0wcLejNH@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 24 Apr 2024 21:54:35 +0000")
References: <CADs5QabwDtUpehNY3hr6BzKyfpp-Ts54TANGkygWPcN3T=OSOg@mail.gmail.com>
	<Zil_m_1B0wcLejNH@tapette.crustytoothpaste.net>
Date: Wed, 24 Apr 2024 15:23:27 -0700
Message-ID: <xmqqedauwgbk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 46BCA1B6-0289-11EF-9F26-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Using the "e" option should invoke your editor and wait until it exits.
> The only way Git has to know that you're done editing is that the editor
> process it invokes has exited.

Whichever editor was launched, unless the user explicitly said the hint
is not necessary by setting advice.waitingForEditor to false, the code
should have given something like this:

    hint: Waiting for your editor to close the file...

so ...

> What does "git var GIT_EDITOR" at a Git Bash prompt print?  If you have
> your editor configured to open in an existing editor window, does
> closing the new editor tab or window that Git causes to be opened fix
> the problem?

... I would expect that there may be something more than a silly
"the editor is running elsewhere and the user is stuck, expecting
something to happen but the editor is waiting for the user" problem
here.  For example, could there be funny interaction with "single
key" mode with editor on Windows (which I do not use myself but I
think I saw the word in the original report)?  Is the configuration
"interactive.singlekey" enabled?
