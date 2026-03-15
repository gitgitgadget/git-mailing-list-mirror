Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D69834DCFF
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773597397; cv=none; b=BfIDnKFE0oNxgXPyi9ZQZhEgd7D+wX4vqzTFewZ3d5V88HNseq1Ex8K7AODlEAqYZkETEP0Bd5C0zuf94Kc88l3DJDmfcREb+OYC/bP3PDYdhmxVIqqVDoTxEKyVP8IaipjIzSFKB7Snt6W36De+9TKT5jcpdFOeW8038Swo97Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773597397; c=relaxed/simple;
	bh=0TU0M1fD9B6tNKYzV+wLUJZ94NFyFjBSy4dKUPeSaT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZUAvXiv2BoZ5j01syrJUjn0bqEmyOXEcWZsqyVyAnn0N5SsEx1EJXg9Bi8wd2Zn7Wo9gXWTzk1Oe3MDvThKvBlgR955Ff716jrbdiRs7BOCJz70FD/u1YMFpx+wDkU0VdSlAZAZ1KRl4fxuIRyeba3jFX+nzqHRPj4/IGulcI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=mmPPGrJj; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="mmPPGrJj"
Date: Sun, 15 Mar 2026 18:56:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773597392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iwy9E6j2/+t5d8IwoXdmY6p2CfZ3BvYtqAZGLA5zlLU=;
	b=mmPPGrJjyO41BAGZmUbuO4dJ2JyUbepJn/vAJa5tWp9NllBQi18bMkO4jvw2l3gmIa8S38
	axDOiPR607dbsuvWzlny9ONjjoa8jGISTB23eJRECtCFf8DrWko8R+36XDxBQvQz/3RS4O
	VJQJSubqjAJLyt504es7rrptvwSUqAKZRgZhZUtlpeimIeqMA0XSg/ppt2NDPf6kvZB0kS
	sK4fXhoSVKZdgSlZmvOMQ24JdzWyfBNjd2UrBairn35m+tAxZQALeQshRz+1k+hFW/5mfT
	J2yHtl9RiYuW/KRfLpSQK6oRoPO4yc1aqU+QWQXf2Fuc7++sPyhbcskLuDGFJg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] apply.c: fix -p argument parsing
Message-ID: <abbv5kG15y7a9wj7@exploit>
References: <20260309232700.553168-1-mroik@delayed.space>
 <eda5f191-7dfa-4bc0-8ab9-225b20a5e88b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eda5f191-7dfa-4bc0-8ab9-225b20a5e88b@gmail.com>
X-Spamd-Bar: --

On Mon, Mar 16, 2026 at 01:22:03AM +0800, Tian Yuchen wrote:
> <<-\EOF should swallow the leading tab, but since you're using spaces for
> indentation here, that would result in a space at the beginning of every
> line, right? I think <<\EOF is correct here.
> 
> But Junio said you don't need to worry about it, it's all good ;)

I think that's an issue with how the email is rendered. If you view in
plaintext the raw mailbox file it does uses tabs.

> 
> The rest are just minor flaws (in my opinion) that you can safely ignore:
> 
> > +	if (strtol_i(arg, 10, &state->p_value) < 0 || state->p_value < 0)
> > +		die("<num> has to be a non-negative integer");
> 
> I think something like:
> 
> if (strtol_i(arg, 10, &state->p_value) || state->p_value < 0)
> die(_("option -p expects a non-negative integer, got '%s'"), arg);
> 
> might be a bit better;

You're right, users that haven't looked at the help usage in a while
might not realize which argument "<num>" is, especially if there are
multiple.

Will fix this

> > +test_expect_success 'apply fails due to trailing non-digit in -p' '
> > +	test_when_finished "rm -rf t test" &&
> > +	test_must_fail git apply -p 2q patch
> > +'
> > +
> > +test_expect_success 'apply fails due to negative number in -p' '
> > +	test_when_finished "rm -rf t test patch" &&
> > +	test_must_fail git apply -p -1 patch
> > +'
> > +
> >   test_expect_success 'apply git diff with -p2' '
> >   	cp file1.saved file1 &&
> >   	git apply -p2 patch.file
> 
> The 'patch' is created in the first test case, will it prevent the
> subsequent test cases from running on their own?

You are right, the tests that come after that require 'patch' might not
be able to run on their own. But it is a common to not clean up files
that are required for multiple tests and only do so at the last test.

That's even the case for files generated in a 'setup' script, they are
reused for multiple tests.


On another note, you replied to the first version of the patch while
referencing the 4th. In this case it was obvious since I used a heredoc
only in the last one, but it is not always the case. Just a heads up to
reply to the correct message-id.

Thank you for the review :)
