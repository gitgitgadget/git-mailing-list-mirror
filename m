Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFB718786E
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921343; cv=none; b=Jbv99ukpgh/W+swdr9Y/pWYdcoJdVOhCaFMOUJk27O6tE2B/x7qyG+n3h3Ed6z8bWzwbPGHXwzWmhq7t3FPjrBL7cYf/QldHDw0XLGQw7uT8wN/9ntU8x7TAMkr+UiJGhK68dqq4DjzbtbaGpECGd58rT2PqhJTmrkBXuZC/MF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921343; c=relaxed/simple;
	bh=v6ebHtAzEeMt+lu6t1WJSeQx7/ww8qxfeUwhAFn0qsg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nAWXgzx29muX08TUmRkY8GdgnOn2ejV8lJ0R5Khd5cPbTPAgCm55ssVhA5NKK6CstK+Ny9oW0NJxzWlUGWnG46RxdHNTZlNLdofmKD4TVnKrUBBWRzBK5rNcAMz7xisHwgylfatC/KGXfY/fVB5/3o+7tFICBCGxJvSjeNqmohw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xDHKw+cY; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xDHKw+cY"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 46F5924914;
	Thu, 25 Jul 2024 11:29:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=v6ebHtAzEeMt+lu6t1WJSeQx7/ww8qxfeUwhAF
	n0qsg=; b=xDHKw+cYTlbS94deZpqrHkhRjg+0h16fo/3Q4QiGwZQcnXzLGcuutN
	KvYqAlSQBa2ClVW4L75d9oud1L6FWz3TOjj994w3RkY+7cWR3R18o17IXLVFLqzT
	A7amrZ/rxJFzPmZ5Sm+nQuwGC3qTZUxJ8lLUN5gZ6E2H42FoiZjXM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C7CF24913;
	Thu, 25 Jul 2024 11:29:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9B8A024912;
	Thu, 25 Jul 2024 11:28:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  "Randall S. Becker"
 <the.n.e.key@gmail.com>,  git@vger.kernel.org,  "Randall S. Becker"
 <randall.becker@nexbridge.ca>,  "Randall S . Becker"
 <rsbecker@nexbridge.com>
Subject: Re: [PATCH v2 1/2] Teach git version --build-options about libcurl
In-Reply-To: <20240725065214.GA590196@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 25 Jul 2024 02:52:14 -0400")
References: <20240621180947.64419-1-randall.becker@nexbridge.ca>
	<20240621180947.64419-2-randall.becker@nexbridge.ca>
	<f44f1e25-41ca-0784-3186-f9e1bdae0d4f@gmx.de>
	<xmqqed8me36c.fsf@gitster.g>
	<20240624235557.GA2727@coredump.intra.peff.net>
	<402c12c2-7ada-4d9e-c3da-1a78827e7496@gmx.de>
	<20240724205541.GA557365@coredump.intra.peff.net>
	<8ef819f0-e80a-74ec-274d-fe10991fe992@gmx.de>
	<20240725065214.GA590196@coredump.intra.peff.net>
Date: Thu, 25 Jul 2024 08:28:58 -0700
Message-ID: <xmqq7cd9lccl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9D5182B8-4A9A-11EF-BB63-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

>> A command with a name along the lines of `git diagnose`, I'd say.
>
> OK. I don't really care much either way how it is spelled, though my
> inclination is that we already have a confusing number of commands and
> should avoid adding more.

I think what you are responding to is an oblique reference to a
command that already exists, and there is no need to worry about
adding more ;-).  If "bugreport" is not farming out the task of
collecting the information to it, "bugreport" need to be corrected
to do so (while "diagnose" may have to learn to collect more, if
"bugreport" collects things that "diagnose" does not (yet)).

> But my main point was that we have two ways of collecting data now, and
> it would be easier for users if they were unified, however the result is
> invoked.

Yup.
