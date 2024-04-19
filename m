Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E4A77F13
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 19:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713554180; cv=none; b=ILs33uzu2eHwqiNbbFiW7rCYlNwydTzc+hP6cg0wXgwMBCNE8upHmsTT5QgB7sVFWw/f9y5c5ANGUHIi2zXeo2WrPAamKlK6vNZfoDS3KYjecGAsjdGVgQ+tiepj3Y0DIJN3FFtI3E5f7fm/vW2e1F+6XtJYGe5gBj8UXrf0660=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713554180; c=relaxed/simple;
	bh=mWQKavsKKc3ckFLQxb+U75nU9XOfTtknqGmHkXObw30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WbGeq8pVJw3Ko5I+29+ekMxS8M5D81zllBE4ihI+WgO22gjz/n8EmnKn4uAN3p2f3o0hjhel2/kzOzIUNXvj2v9Q0PFogZs2jgPmhA+VEeTXBv+WlDElXBGJikgndpYGw80Q+AmZ92X3PT5U+pn7EY8U+76sMq/6JezKMsqHnqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tpyVm8EQ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tpyVm8EQ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DBD9F1F5132;
	Fri, 19 Apr 2024 15:16:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mWQKavsKKc3ckFLQxb+U75nU9XOfTtknqGmHkX
	Obw30=; b=tpyVm8EQGmUzXcGt/tb9oRQ1zWiZECuPWIGeKeG/UeOmMvE3bn6bdA
	zCnW6++INdDaxPrHu/Pz1NCA39BAYyhgbkIlpijQGtN0nWQuq316qCqYoyQ9igpY
	7svhdorhWypOxelPaSIjOt7oKyzwGXfVHyC2f6SYOsxLjSmqSiYys=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D40B51F5131;
	Fri, 19 Apr 2024 15:16:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3FC091F5130;
	Fri, 19 Apr 2024 15:16:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 00/11] Stop relying on SHA1 fallback for `the_hash_algo`
In-Reply-To: <ZiLCO8Wn0-4jyDdp@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 19 Apr 2024 19:12:59 +0000")
References: <cover.1713519789.git.ps@pks.im>
	<ZiLCO8Wn0-4jyDdp@tapette.crustytoothpaste.net>
Date: Fri, 19 Apr 2024 12:16:16 -0700
Message-ID: <xmqq34rh6u4f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4BE79422-FE81-11EE-9275-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I've taken a look, and other than the minor typo I noted, this seems
> fine.  I'm in favour of getting rid of the SHA-1 default, even though my
> gut tells me we might find a bug or two along the way where things
> aren't initialized properly.  I still think that'll be okay and it's
> worth doing, since it'll help us prepare for the case in the future
> where we want to switch the default and also for libification, where we
> won't want to make those kinds of assumptions.

Yup, thanks for reviewing (and thanks Patrick for writing the
series).
