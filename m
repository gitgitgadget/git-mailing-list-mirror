Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D0F369980
	for <git@vger.kernel.org>; Fri, 29 May 2026 05:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780032111; cv=none; b=ClkkECYqlSILTGbYR2Xx9n3GaIusLDgfuxnKsh53uekguAkanY57a51xsfSlZ8hK8jTsZ2MtWNXQqin9sKGJuJSX3z7OqMQO9AVtKCLYBSnEAf4sONOEglmsKASl2xbXYEBN0H06CkXZI+Ek0G6u0hGrxvkGZNiGtITuuE+k7c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780032111; c=relaxed/simple;
	bh=OKZq9kyF9spu8v+34FrIM22fdaZspJSxlJSIXuoLBwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c24twk0q4ZRdO28RDc7btt2QlY+7As86n2p4ke1J2f22dhnPq6Kf1Agb3Q5Ygo3I3z6Fw91iaoQmHZHAYN/w41z0FFxPkAdTTR1F3pmI5YQ9Pfg9vFKwdfUogiw4UwUbzYpYGkWFE24wtQNik97yGhrlG+ISwsPjhAcEh4ORNEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Y5xzbHxI; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Y5xzbHxI"
Received: (qmail 3725 invoked by uid 106); 29 May 2026 05:21:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=OKZq9kyF9spu8v+34FrIM22fdaZspJSxlJSIXuoLBwI=; b=Y5xzbHxIz97DAwcq3uhB/f9RuxNpHffuKNtil4SWDb4fiLbzDfw2bL1r6uXSpKaeLQ12cUEKkfcXF/l0m7mNAN0671CRUMKjEu5siPSXN11KDXA/GIQ9itya5ZgJeW8eJBB9QnALxeZ0/wJugtVHjQpuLRsuqIwO96zRD07RsSD9ewsRm0Gquui/gLuhj906w/PTBegv4bmrhkCVAvFaLhvIoovldHtllOnDTQYnAI3ty74xcj2XQLx4ow00V1ZaMXi8uz1V1BONoytCStp7YN6k08iMSYPkcSb6+UXsVPaXsGN3ielB2Tbwwf2yx3FzEg9oD0EMEpNyDrF6NnVFBA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 May 2026 05:21:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7114 invoked by uid 111); 29 May 2026 05:21:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 May 2026 01:21:45 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 29 May 2026 01:21:41 -0400
From: Jeff King <peff@peff.net>
To: Wesley Schwengle <wesleys@opperschaap.net>
Cc: Git maillinglist <git@vger.kernel.org>
Subject: Re: git hook question
Message-ID: <20260529052141.GA1099450@coredump.intra.peff.net>
References: <cc9fda14-d8e8-4982-9a3d-9aa816c0b90c@opperschaap.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cc9fda14-d8e8-4982-9a3d-9aa816c0b90c@opperschaap.net>

On Fri, May 29, 2026 at 01:01:34AM -0400, Wesley Schwengle wrote:

> I understand the why, normally pre-push gets `<local-ref> SP
> <local-object-name> SP <remote-ref> SP <remote-object-name> LF'. This has a
> similar feel, albeit a different syntax. The difference feels like a minor
> bug, but not one I'm worried about at this moment: you would expect it to
> get the same arguments/parameters as the regular pre-push hook. But I
> digress.

I think the "git hook" command is mostly intended for scripting, and the
caller is expected to understand the context and provide the appropriate
arguments. The hook command itself doesn't know about what a "pre-push"
hook should look like.

So not a bug, but definitely a gotcha that could perhaps be better
explained in the documentation.

> My actual question is: Is there a way to tell the hook "Don't give me
> arguments, just run the plain command that is defined". I looked in `man 1
> git-hook', but I was unable to find something that looks like it.

I don't think so; the command is expected to handle (or ignore) the
arguments as appropriate. You could obviously write a wrapper script to
handle that, but since hook commands are run with a shell you can inline
it, like:

  git config hook.npm-test.command 'npm run test #'

Git will paste together the shell command:

  npm run test # "$@"

which then treats everything after the "#" as a comment. The more
general form of this trick is to use a shell function, like:

  f() { your_cmd_here; }; f

which would do what you want, but also let you access the arguments
however you like. For example:

  f() { some_cmd "$1"; another_cmd "$2"; }; f

would let you consider the arguments independently.

But for your purposes, using "#" to ignore them is simpler to write.

-Peff
