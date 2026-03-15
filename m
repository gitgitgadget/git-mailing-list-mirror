Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F50D42AA9
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773564613; cv=none; b=BqZzmEqTQUAoq5sVQnDwEpq48a9CqNIfG0gZUZVypDpyXAP83PMoF6/qJ7/L4chin2QYKLYKgnyAL2oCtRRz67WYl7gO24W9+zWKnHB4QnUvGNgEE9WPstgyguy8KyHG1TqwVcx2YIEOyEDi5EtSW5bHwpTByyLGO7CoHVey5iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773564613; c=relaxed/simple;
	bh=ArfonAWLt+vXlqTJU8OEdcKNYm1UDe/+4fXSNEGesK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrRCVcAenUABXTnzPB07xqewPJMwQaQu4p557XHBsLm33/pYBvZQlXPuFZLTc+QhMrXwV1MWn82wFJfrLj9a/BqI0QKn78uV/4kbq7NcUiZJQBF36hPHwWFtMgq9y11nfpD3BjrdO0dlEsjYIdauzHy6ZQpYIXRJh/B4uvUlHTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=SLCvvSFp; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="SLCvvSFp"
Date: Sun, 15 Mar 2026 09:50:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773564608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jnlIQuP9BZXp6PpBo2RIYid0apYE6lgwm76G+UOSkrA=;
	b=SLCvvSFpetJ3MP75+izZOTJaytxCch4AF60W0i6Oi9yc5ABIh5AHkxhoA0BfPl/WJPHhVf
	LSChePIyScXllyqEU2zgB7kDgvAKu5P0IvyUgpUw7ho5bgZccDT0M+sdvmZKBPKXteszDk
	kVo0t/iPQuyAygBQ/uqWp596z3rU8rvxHpBZo5N71GFDnK+BWAchQQhloEcTmiRBNMPG+A
	3EcguS0ic+RNtkeDMSulwhdDrBIrLVWuh6TPQ8HnscYUVyeDNXQi5ac9avoQQSwVpFrom+
	cumaX0XLydEVdFaZKV963hR8kBITr3QugdwtcboFKJAJS3EQyY+uNSit/IhcwQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH] t0008: fix "large exclude file ignored in tree"
Message-ID: <abZwbCF1R0_bnFBv@exploit>
References: <20260315034851.2261530-1-mroik@delayed.space>
 <xmqqv7extzd9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7extzd9.fsf@gitster.g>
X-Spamd-Bar: --

On Sat, Mar 14, 2026 at 10:50:42PM -0700, Junio C Hamano wrote:
> > Subject: Re: [PATCH] t0008: fix "large exclude file ignored in tree"
> 
> Strange.  That is clearly not what this patch is touching.
> 
>   Subject: t0008: fix cleanup in 'symlinks not respected in-tree'
> 
> or something?

The test I'm touching is "symlinks not respected in-tree", but the test
failing is "large exclude file ignored in tree". That's why in the
following section it mentions "the previous test".

> > Add cleanup to previous test for file that is unrequired to test the
> > size of the ignored exclude file.
> 
> This description is also inaccurate. It seems to be talking about the
> next test in the file ("large exclude file ignored in tree") rather than
> the one it's actually changing. Worse, the next test does its own
> creation of the "large" .gitignore file and also cleans it up itself,
> so there seem to be no need to fix it, either.
> 
>     The test 'symlinks not respected in-tree' creates a 'subdir'
>     directory and 'subdir/.gitignore' symlink, but only removes the
>     top-level '.gitignore' file in its cleanup.
> 
>     Add 'subdir' to the test_when_finished command to ensure the
>     worktree is properly cleaned up after the test.
> 
> or something, perhaps?

When running "GIT_TEST_OPTS='-l -v' git make t0008-ignores.sh", "large
exclude file ignored in tree" fails with the comparison failing due to
an extra warning "warning: unable to access 'subdir/.gitignore': Too
many levels of symbolic links".

I don't know if this tests fails only on my setup, but seeing that the
failing test is supposed to check for .gitignore size only, the "subdir"
directory is not strictly necessary, without it the test works just
fine.

> This patch has some disturbing characteristics.
> 
> - The subject line and commit message describe a fix for the "large
>   exclude file ignored in tree" test, but the code change actually
>   modifies the "symlinks not respected in-tree" test.
> - The description mentions a file "unrequired to test the size", which
>   doesn't logically apply to the change being made (adding a directory
>   to a cleanup command in a symlink test).
> - This kind of context-mixing (applying a correct fix for one test but
>   attributing it to a neighboring one) is a common pattern in LLM
>   outputs.

Sorry for very bad commit message. When writing it and knowing where the
problem is, I found it obvious. Now reading it again, it doesn't make
sense at all without additional context.

> Is this generated with LLM sent without any sanity-checking by a
> human?

No, this was all hand written. This mess is all due to my incompetency.

> > diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
> > index db8bde280e..18e048ee8c 100755
> > --- a/t/t0008-ignores.sh
> > +++ b/t/t0008-ignores.sh
> > @@ -946,7 +946,7 @@ test_expect_success SYMLINKS 'symlinks respected in info/exclude' '
> >  '
> >  
> >  test_expect_success SYMLINKS 'symlinks not respected in-tree' '
> > -	test_when_finished "rm .gitignore" &&
> > +	test_when_finished "rm -rf subdir .gitignore" &&
> >  	ln -s ignore .gitignore &&
> >  	mkdir subdir &&
> >  	ln -s ignore subdir/.gitignore &&
