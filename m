Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA6512A15B
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 17:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116901; cv=none; b=gMwIetsk5rKJwH3hLjenG0BxL4k4le9/j0gxE/l5vUsDKRvOpeYWXbrjpz5d/KM5+go8oqnu5CuH9GQ+A4dx21OKyrhmWzT24yst20Xxv985sKlBn6wFWfGq6Xcdpx4zuJ5UQBr16dMyjOOzW3XOxi78piAXVX9hHl6tgNA4oeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116901; c=relaxed/simple;
	bh=IioAFM+C+Y324wT+leWSE/PREXtviccOitBWHkKrxSg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AJ/9rIb0mcT8wLxplce/ywLRCkAJ90CP5rX4Tm4k28Ksb2wqgRM5hqHtRJ8Ul2L34szN0yzVD9Fnirq/pIHFk2tPaNdsZ++2Q/bda3jrblubnNlbmybID3v4oU7gEfvHErJBUGILUu9zbWAMG4oWxU04gw6JasuLTL7dc1PTnqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vlIF5bCm; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vlIF5bCm"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C649A23D4C;
	Wed, 24 Jan 2024 12:21:38 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IioAFM+C+Y324wT+leWSE/PREXtviccOitBWHk
	KrxSg=; b=vlIF5bCmcYCWNM/L81bpsGoZFoicX7sCPmsholitwnyoIGtiwA1v8I
	yePvFI2MhC167VfoA//BcXEHb4lJ71VTuHIdMFqhBtvDRqIkRiCG8oUDGkDIb014
	zMZ3ujbvo03JfLXkPBsB/Y1Dha7WqQtbRh/suhlqIAR0nu1rivgjE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BEE7A23D4B;
	Wed, 24 Jan 2024 12:21:38 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 84F3023D43;
	Wed, 24 Jan 2024 12:21:33 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Sergey Organov <sorganov@gmail.com>
Cc: Elijah Newren <newren@gmail.com>,  git@vger.kernel.org
Subject: Re: what should "git clean -n -f [-d] [-x] <pattern>" do?
In-Reply-To: <87plxr3zsr.fsf@osv.gnss.ru> (Sergey Organov's message of "Wed,
	24 Jan 2024 11:23:32 +0300")
References: <xmqq34v6gswv.fsf@gitster.g>
	<CABPp-BHUVLS4vB5maZzU5gS33ve6LkKgij+rc1bBZges6Xej-g@mail.gmail.com>
	<87a5ow9jb4.fsf@osv.gnss.ru> <xmqqsf2nnbkj.fsf@gitster.g>
	<87plxr3zsr.fsf@osv.gnss.ru>
Date: Wed, 24 Jan 2024 09:21:32 -0800
Message-ID: <xmqqa5ouhckj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 055D37CE-BADD-11EE-B7AC-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Sergey Organov <sorganov@gmail.com> writes:

> Whereas obsoleting second -f in favor of new --nested-repo might be a
> good idea indeed, I believe it's still a mistake for "dry run" to
> somehow interfere with -f, sorry.

No need to be sorry ;-)

I actually think the true culprit of making this an odd-man-out is
that the use of "-f" in "git clean", especially with its use of the
configuration variable clean.requireForce that defaults to true, is
utterly non-standard.

The usual pattern of defining what "-f" does is that the "git foo"
command without any options does its common thing but refuses to
perform undesirable operations (e.g. "git add ."  adds everything
but refrains from adding ignored paths). And "git foo -f" is a way
to also perform what it commonly skips.

In contrast, with clean.requireForce that defaults to true, "git
clean" does not do anything useful by default.  Without such a
safety, "git clean" would be a way to clean expendable paths, and
"git clean -f" might be to also clean precious paths.  But it does
not work that way.  It always requires "-f" to do anything.  Worse
yet, it is not even "by default it acts as if -n is given and -f is
a way to countermand that implicit -n".  It is "you must give me
either -f (i.e. please do work) or -n (i.e. please show what you
would do) before I do anything".

  $ git clean
  fatal: clean.requireForce defaults to true and neither -i, -n, nor -f given; refusing to clean

Given that, it is hard to argue that it would be a natural end-user
expectation that the command does something useful (i.e. show what
would be done) when it is given "-f" and "-n" at the same time.
What makes this a rather nonsense UI is the fact that "-f" does not
work the way we would expect for this command.







