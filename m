Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCD32C3257
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 04:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237588; cv=none; b=if2oOVON3QTk4szGf9s19O53hKq59mwiF34OP50XFimwStpJv4MYqpSt/t9yhL/jo3UXqvo06a1goBD69UO3+MzfkJWKb2vQ5yt4CJDZkJrj+j83RzetbMhKRPnBiMigGN4bPg8LQ9vXlQU2+zkaOf0EHbgyX+89aXNp3OhHxyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237588; c=relaxed/simple;
	bh=F4kFXVITUOCqpZx1jj4UmdC78hbOTBDH8TsThXCWcoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K867Dwz5g8Z3PP2w2K17POLV4vGJ4eSlkasfscy9GJeltlA5QMcG1wLRc9Cp6E8YCQxsscWyZlZmTMJBSu1cbQxHD+8JCs/JoQJh+YOsw0qYuNdfDaBmfxEN/yCrHWtqsnZD3ahppgzvW+zGVUXHsSVw10QQcFfOBxwhPdaWqf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LiXNs90k; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LiXNs90k"
Received: (qmail 6827 invoked by uid 106); 1 Sep 2026 04:39:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=F4kFXVITUOCqpZx1jj4UmdC78hbOTBDH8TsThXCWcoc=; b=LiXNs90kUzYDaGQyWDdJh43fogs83MOhnufzzevoDcQxPPvA4jNwiFRo+yDEntxGP4dnW/I54r0ejqoLpQLbLDzafgiLPhH+f8Hir9Dzi3wX59PSHQiiuwmrQ+rh+r/G8vDkPb4sFTxHOnzK93UTEj5a4BSFKs9pJHSuOiwpaQI0eoG98P6N8cANKvx+7L2/XDyS1BD7GBoGtAM9efVKecSSNFMVClzSIkKT88Z0sUvqwIGfgtYzW6D74y/zCbcVBxrcX0h/y/eAtXrWQaAodBuEZDy7AbSRdA1VvO5XJq22wyXORRlTu+m1JmWd39aONbQ8a38EOOudXHWohuZTKQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Sep 2026 04:39:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32865 invoked by uid 111); 1 Sep 2026 04:39:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Sep 2026 00:39:44 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 1 Sep 2026 00:39:44 -0400
From: Jeff King <peff@peff.net>
To: Andrew Pleeter via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Andrew Pleeter <andrewpleeter@gmail.com>
Subject: Re: [PATCH v2] builtin/ident: add new 'ident' command
Message-ID: <20260901043944.GA1074757@coredump.intra.peff.net>
References: <pull.2388.git.git.1787690802942.gitgitgadget@gmail.com>
 <pull.2388.v2.git.git.1788220746663.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2388.v2.git.git.1788220746663.gitgitgadget@gmail.com>

On Mon, Aug 31, 2026 at 11:59:06PM +0000, Andrew Pleeter via GitGitGadget wrote:

> While existing plumbing commands like 'git var' and 'git config' expose
> individual pieces of identity and configuration, discovering what identity
> and signing key will actually be attached to a new commit requires multiple
> independent queries and manual correlation. 'git config' only reads raw
> values without performing environment overrides or GECOS detection, while
> 'git var' returns full ident strings with timestamps without exposing
> commit signing status.

This is just my gut reaction, but: would it be simpler to teach git var
to provide those broken-down pieces than to introduce a whole new
command?

This works now:

  git var GIT_COMMITTER_IDENT

but why not:

  git var GIT_COMMITTER_NAME
  git var GIT_COMMITTER_EMAIL
  git var GIT_COMMITTER_DATE

Those are well-known names already; they're what we use for reading in
the broken-down values from the environment. And likewise for
GIT_AUTHOR_*.

Let's see what else is in your feature list:

> 'git ident' provides a unified command with additive, composable options:
>   - Identity scope selectors (-a / --author, -c / --committer) choose
>     which identities to format (defaulting to both when neither is specified).

I think that works by switching between the two var families above.

>   - Component selectors (-n / --name, -e / --email) choose which parts
>     to format (defaulting to full 'Name <email>' when neither or both are
>     specified).

We don't allow mix-and-match here (nor even multiple values!), so you'd
have to do:

  ident="$(git var GIT_AUTHOR_NAME) <$(git var GIT_AUTHOR_EMAIL)"

I think it would be reasonable for git-var to accept multiple values and
output them one per line (or with NULs via "-z"). That doesn't really
make things easier in shell, but it might help scripts in other
languages.

We _could_ go as far as providing a format language like we do in
for-each-ref, etc, where we offer to shell-quote. And then you can do:

  eval "$(git var --shell-quote --format='
		name=%(GIT_AUTHOR_NAME)
		email=%(GIT_AUTHOR_EMAIL)
	')"

but IMHO that is probably going too far. It sometimes lets you simplify
shell use of the tool at the expense of a weird and complicated
interface (I kind of which we didn't have it in for-each-ref).

>   - -v / --verbose prepends 'Author: ' or 'Committer: ' role labels.

Seems like something that git-var might benefit from, too.

>   - -s / --signing-key resolves and outputs the commit signing key.

Likewise, this feels like it should be a git-var entry.

>   - --porcelain produces machine-readable key-value pairs.
>   - -z / --null terminates output records with NUL bytes.

Likewise.


My main feeling on suggesting this is that:

  1. We already have a lot of commands, and this one feels very
     specialized.

  2. Most of these suggestions could make git-var better for reading
     idents _and_ for reading its other variables.

-Peff
