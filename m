Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53E0132117
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 14:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736175336; cv=none; b=QFeCveAfQX5R+x9lWV+oPE9Qlnj9j7wWjeN0dzwjwd1h/MkhUMMw5wUQ/FykDiUStNM1A5IURa4Qj5PTiYrLKY5zx9BgjmVUqe1FjiEqGv9rceUfnO/vRl1lXQJnbsl6qAo6wmcHqFcViyaAU2qjNP/bwCVOHlNNQtpFzqcgQa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736175336; c=relaxed/simple;
	bh=9B3RR7x4+4hmBzX2ALMvsHEKT/U3GskkCHSoALTt+3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUz16LIhHZGBxY7O/xZI5jGBmqPOAh/7v/hwfcx7QM89ek+hMky4RmWfSdrVhCQOJtYYRXzrmekAwHCy9vwEuK9hG6PM1r5omN8OHGqO1oHz9HrBYg6KhLG450GkAXo2QL0zSJ4tH1oqxhlF/Ax1Rl2ORD7xFIaubE5PZnxW1rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9vbHbkf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9vbHbkf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F48C4CED2;
	Mon,  6 Jan 2025 14:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736175336;
	bh=9B3RR7x4+4hmBzX2ALMvsHEKT/U3GskkCHSoALTt+3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X9vbHbkfTCTk+YO/NM7jKhEhaSeREuV9v71hf1w0/WRWDfKn3O2C7SQkqul2x2lOW
	 C6/j2bVKD9Kc4T+LpGvscwWs3UngQ28DdSL0SqOncIlhMcTZ2cpi/H1tDRBnoRgq7H
	 mOp8DMp/aQj9eHih/XIs3C1DXACR1WJsQriWsM1H7o9E+1R3bDF5O/sLWNxjsrhQBH
	 EC9CMiyEq4a9YwP4qX5TC9+QhjruLkaZ6p7sKXW7FrLRd70ORlGqxuSkWXyNV38tND
	 2SHx3OFEB+gFNfS5tZyhCATj4sJEA0QFUjBnrBTnXY3XAdioS5TW9AmJ52DUU71U2K
	 ukPNmWYwA6OKw==
Date: Mon, 6 Jan 2025 15:55:32 +0100
From: Carlos Maiolino <cem@kernel.org>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [Bug report] signingKey beying bypassed
Message-ID: <cw6ggzhw4o5c5v5juh7sx2ubfaidnzugxx3ydgfvdlywqhndzf@6rfdfajvscif>
References: <hx6q4liyd7udyezlqy2fzanxlicu24imtdqielig622sdqz2wc@lxa4ybnzyjs5>
 <20241216113543.GD2201417@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216113543.GD2201417@coredump.intra.peff.net>

On Mon, Dec 16, 2024 at 06:35:43AM -0500, Jeff King wrote:
> On Fri, Dec 13, 2024 at 09:23:29PM +0100, Carlos Maiolino wrote:
> 

Sorry the late reply Jeff... Holidays, family, the whole thing...

> > the git-tag manpage states:
> > 
> > "
> > CONFIGURATION
> > 	By default, git tag in sign-with-default mode (-s) will use your committer
> > 	identity (of the form Your Name <your@email.address>) to find a key. If you
> > 	want to use a different default key, you can specify it in the repository
> > 	configuration as follows:
> > 
> >            [user]
> >                signingKey = <gpg-key-id>
> > "
> > 
> > 
> > I do have my $HOME/.gitconfig configured to always sign tags with a specific key
> > per above documentation, and I just take it for granted.
> > Today I had two smartcards connected, and when signing a tag, git-tag used the
> > wrong key to sign the tag, instead of the specified in the .gitconfig.
> > 
> > I believe this might be a bug or some expected behavior that doesn't match the
> > manpage. Or perhaps I misinterpreted the manpage?
> 
> No, I'd expect it to sign with the key that you configured. Two things
> I'd check:
> 
>   1. Try "git config --list --show-origin" to make sure you do not
>      accidentally have incorrect config somewhere overriding what you
>      expect.

Ok, this returns the 'correct' key:

$ git config --list --show-origin|grep sign
file:$HOME/.gitconfig user.signingkey=0C...

yet just creating a dummy tag on a dummy repo:

$ git tag --verify foo
object 5d3928490fc1506afa0e0cfada15819e2eac922f
type commit
tag foo
.
.
.
gpg:                using ECDSA key A6...


> 
>   2. Try signing with "GIT_TRACE=1" set in the environment, which will
>      show the gpg command we run. E.g.:
> 
>        $ GIT_TRACE=1 git -c user.signingkey=foobar tag -s -m foo bar
>        [...]trace: built-in: git tag -s -m foo bar
>        [...]trace: run_command: gpg --status-fd=2 -bsau foobar
>        [...]trace: start_command: /usr/bin/gpg --status-fd=2 -bsau foobar

Hmm, this actually works. Doing this, the tag is signed with the key I pass on
the CLI.

> 
>      If git is passing the correct "-u" option to gpg, then the bug (or
>      misconfiguration) may be in gpg.

I particularly think git is the 'problem' here. After I tried GIT_TRACE, I decided
to run it without specifying the key on the CLI as I'd normally do, and it did
work normally, and I think I what happens is git defaults for another key, if
the specified key is not available.

As I mentioned earlier, the key configured on my .gitconfig, is inside a
smartcard.
I just tested creating a tag, without the smartcard connected, and git
ignored the signing key I passed, using another key.

I am not sure how right I am, so please correct me if I'm not, but I would
expect git tag to fail, or at least give me a big warning if for any reason it
could not sign the tag with the specified key.

Cheers and happy new year


> 
> -Peff
