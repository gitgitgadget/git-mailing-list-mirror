Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5A617C8
	for <git@vger.kernel.org>; Fri, 10 May 2024 01:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715303728; cv=none; b=WnPUVybZoijq07U4dYbKe+dCjccqCvdZHJRn6hGfjtzdzB9yiDWUvJ8jg0/1reT2bgrFaF9585KedWbZiSXdkJ47oDMe+rxw+2NN254mGoAILTSzr9mDx1xqxjVWOvGZq9IhAGPiHvGXeuBvtUuP3tti7HNzjSmvaD4y2cPRuaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715303728; c=relaxed/simple;
	bh=8XMUL0SzPVBDAZozBb+pxj4wV+HMrzwLmpZOr2KAUKs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qJb5WCG/f8xq7WTXZvIJkJkIqCwJLQbB7eWdFo6jhY3TFMh4JgyiuppxfHySE5XQLt3SJbN6mPL6s9wZfplkgjbM2LugMq+oGAk41D1MagU1K7U0wHTzP/lxSLuBptt+oPhqme3IZil0L6kRCjYPSLcnRfHSm5yd3jgYMaxkAwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HavygCze; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HavygCze"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D4C8C29C13;
	Thu,  9 May 2024 21:15:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8XMUL0SzPVBDAZozBb+pxj4wV+HMrzwLmpZOr2
	KAUKs=; b=HavygCzep9fzGckBS2KMaA6o2utqpUecXT6YzSLO13I6mUWDVBUrXL
	gyFUIKTqAlPuKyfK3Lm/Gnjd4FAGBWfNoUArqI3LyLRjVJBsEIjMVriu6CihZ0NN
	jM1iv1LXykTagPPVu3loPRR2aT638MwIAhJccgkgJLRsif50VBKcc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CE60F29C12;
	Thu,  9 May 2024 21:15:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3B0FF29C11;
	Thu,  9 May 2024 21:15:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: git@vger.kernel.org
Subject: Re: git-cherry-pick(1) -- path
In-Reply-To: <e5pklmijfpbsnl2trj4n4czam7n7i37gx7w56med2pfaf6q3yx@wizseio2ickk>
	(Alejandro Colomar's message of "Fri, 10 May 2024 00:32:30 +0200")
References: <e5pklmijfpbsnl2trj4n4czam7n7i37gx7w56med2pfaf6q3yx@wizseio2ickk>
Date: Thu, 09 May 2024 18:15:24 -0700
Message-ID: <xmqqv83mqxg3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C7C32FF4-0E6A-11EF-9290-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Alejandro Colomar <alx@kernel.org> writes:

> I'd be interested in being able to partially cherry-pick commits, based
> on a path filter (similar to how many other git(1) commands behave with
> -- path).
>
> Do you have any opinions on that?

Opinions?  

Personally it is a "Meh" for me, because I would instead do

    $ git format-patch --stdout -1 $ThatCommit -- $ThisPath |
      git am -3

which would be mostly sufficient for my purpose, but I do not see
any fundamental reason why it should not exist.

It is already well known that future merges from the same branch
will have to deal with duplicated changes brought in by picking
commits with "git cherry-pick".  Having a pathspec-limited variant
of "git cherry-pick" would not make the world a worse place.
