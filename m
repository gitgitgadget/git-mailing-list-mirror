Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1388287E
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 18:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757959728; cv=none; b=aGQxkfqoLarNJYuq6+uBQCUhwIHx9KraU9RUbBk0VqjZFE+9AHOBH/fVbgM9j8Apaq19+edqqGqnpRkENm1o2fkpQK1kZePdZOTX/XBEZ1c4LITWsjNbyffIL3hVhl/HXkBGqVxMmtzBIsL+xGOsuSXdxIGMv5PZHyrxe5sOe/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757959728; c=relaxed/simple;
	bh=jLwWruC3UM2sJpoAWgv6XlPoWlZFnigWLs9MUuSc8W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o48d1FS743mt6FnJcXPUCZvg68R+t0jQLUDOEMC/lMyZ5TzbKicT38qUfDCJjsRHi/nFU6apqCV/FhsuaMeFM3/TSv9jBnoV2N4aNxI5RutgDyBKpbCEs6PlkOgrzbZYDEfRm3NO6JDLJRfMOuMqyIOSeMJrV3YGKewgAeR3Qjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bfQcwlaN; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bfQcwlaN"
Received: (qmail 90034 invoked by uid 109); 15 Sep 2025 18:08:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jLwWruC3UM2sJpoAWgv6XlPoWlZFnigWLs9MUuSc8W0=; b=bfQcwlaNOFK723Hs16v62sAsV+e+efCBrfE6HHkqrsxbxI2dDHnVmMmzijUIiswrc4atox6KXtcsL40wg9FNAza8But64mbJ7a2sAHf7IOU04+4QoDxeoMnw1A7ITsklq8C4+KMNSrFJd4PU15ncxHAWNqeVy/YhzxHsfSKalUz/xVCdcIYYdGX+pr+CKOUkzyUsBxGj9Svy9kan4agTScIx+BELZfqWocao3+5b8tU88jOx0XpSKvJLiG4OsYAEMyY485RWfO+6ynehRwjVSFzbURK9ozebHKcjeHNCWf/B+u70K34XklT2a3zrHRwMKMG6AOPfI7BAiRLaX61vpg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 15 Sep 2025 18:08:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 150640 invoked by uid 111); 15 Sep 2025 18:08:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 15 Sep 2025 14:08:43 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 15 Sep 2025 14:08:42 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH] git: run alias subprocess according to the API
Message-ID: <20250915180842.GA642496@coredump.intra.peff.net>
References: <ad7066022efe5344eb1972d1c489372d97b2d18a.1757842206.git.code@khaugsbakk.name>
 <xmqqms6wi08y.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqms6wi08y.fsf@gitster.g>

On Mon, Sep 15, 2025 at 01:33:01AM -0700, Junio C Hamano wrote:

> > From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> >
> > `run-command.h` tells us that this is how we should run git(1) commands.
> 
> Perhaps that comment needs to be updated at the same time?
> 
> >     The only other thing I found was in `upload-pack.c`.
> >     
> >         strvec_push(&pack_objects.args, "git");
> >     
> >     But that one is intentional; this is inside an else-block and the
> >     if-block has `pack_objects.git_cmd = 1;`.  And attempts to refactor it
> >     broke `t5544-pack-objects-hook.sh`.
> 
> Hmph, doesn't it indicate that it is wrong to use ".git_cmd = 1"
> unconditionally, no?  I.e., the instruction you found might make it
> sound as if the only difference is to spawn "git" directly or doing
> it via the "shell", but because it is not, the result of your update
> broke that test, right?
> 
> So, we want to tell programmers when to use it, with the comment
> that says "most of the time, if you are spawning a "git" command,
> use the .git_cmd = 1 mechanism, but if you are doing X or Y then,
> spawn that "git" command just like any other programs spawned via
> the shell, because of such and such reasons", no?

I'm not sure there _is_ any reason to use a raw "git" instead of
".git_cmd". The case in upload-pack is _not_ running a git command
directly. It is passing the name of a git command to the hook. So you
end up running:

  /path/to/my/hook git pack-objects ...args...

So I don't think there is any X or Y, and the rule can just be "you
should use .git_cmd".

That said, I do not think it is particularly important to use .git_cmd;
it really is just prepending "git" to argv. It does also override
.use_shell, but it is nonsense to set both flags in the first place
(which is something we could perhaps flag with a BUG() if we cared to).
But I have no problem with preferring .git_cmd to "git" as a style
preference.

-Peff
