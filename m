Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEDDC8C7
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719860655; cv=none; b=qf4H8ZZBgO2TnIhU1XVKXdCNAIg2e2x7KpTB17QKFKED6+I4bJKKCT3BJyEeFv2W9yxB9gIcS8Okq9sov+jlVIHB5WyXhSNxyuzOZmO36quDomcG7ELJ0fGnTHEv5us1WDoGXC3r5BxXtheGTSca9hD8B2VzIN0TV/htthrUTtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719860655; c=relaxed/simple;
	bh=V/kHenhIsAuObvlMq+iQ0U26VBpYcZKKQI7CwMCDrN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XQq3qQxCiQpAx3Kbxet/RV8jTamhcYTAGfF8FuoOeNO9v/Eu3RF+8KtuyXPpVmhFviFzU6gUlpCdH5UWU0Kk8cdXBjVm1SIQK7i61vgOhGUkY+/tI2pkNY+A8zgqNcO6lpxDq7xKVu4/DgCAhocXUQFTZb/PvD+h7czrwyLbKW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uI4JpB56; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uI4JpB56"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E5ED91A642;
	Mon,  1 Jul 2024 15:04:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=V/kHenhIsAuObvlMq+iQ0U26VBpYcZKKQI7CwM
	CDrN0=; b=uI4JpB56c4jGooMLxQDrARtSHHjip3P9IM6UzgwrJjRFu65KBBCGoj
	Qd52Ulx3Hj4Q5g8BhUw5AZ5D99Zcb8xTHZ1BehImmI7QoOjaNYlaGX8yi1Wi6VjV
	WjRmV322j2GngMG5s2Ky/9bbHh3bEXeo8ov7XAo0N1Z4o/SvhcJJ0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BB7DA1A641;
	Mon,  1 Jul 2024 15:04:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1DF451A640;
	Mon,  1 Jul 2024 15:04:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Jonathan Nieder <jrnieder@gmail.com>,  limin <1159309551xcz@gmail.com>,
  git@vger.kernel.org
Subject: Re: Git remote origin leaks user access token
In-Reply-To: <ZoLY_yxpQBjmp8O3@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 1 Jul 2024 16:27:43 +0000")
References: <CALFtjBBvk+JPmU_GzrnM=ANwaQDdiLtzh4YkZFbcVENyCu9fxA@mail.gmail.com>
	<ZoKW-yDJMsz9JPSI@google.com>
	<ZoLY_yxpQBjmp8O3@tapette.crustytoothpaste.net>
Date: Mon, 01 Jul 2024 12:04:03 -0700
Message-ID: <xmqqsewtvsrg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AFADA5B6-37DC-11EF-8676-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I'll point out that we already document this in the Git FAQ (git help
> gitfaq):
>
> ----
> How do I specify my credentials when pushing over HTTP?
> ...
>
> We also have a FAQ entry about how to read credentials from the
> environment as well, since that's a common thing people want to do.
> ...
>
> I do want to point out that several people, not just me, have worked
> together to make using a credential helper as easy and robust as
> possible.  I mention this not to contradict Jonathan, who I think is
> also trying to help in this regard, but mostly to mention that as a
> project we've been trying to gently nudge people into doing the more
> secure thing.

Two and a half things.

 - Perhaps we want to explicitly single out URLs that embed
   credential in the documentation and tell readers not to use that.
   I wonder if it would be possible to deprecate the support of such
   URLs over time.

 - The original talks about "malicious tool runs "git remote get-url
   ..." but if you let malicious tools to run as your self, you can
   easily steal the credential out of system keychain as well, so
   "do not let malicious things to run as/for you---they will do
   malicious things to you" may be a good general advice.  Those who
   need that kind of advice would not be helped all that much by
   moving away from using URLs that embed credential and instead
   start using credential helpers.

Thanks.

    

