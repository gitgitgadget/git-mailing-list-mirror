Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4746335839E
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773176709; cv=none; b=AQjlEp9iV87b0cL/2ZcOpGhRQr7XOrtR33v801SvCnPmagRTiyQgQQ/FCkBp/G1byI0pRqyWVFIZ4dMmGonlzBaMaNwt2S9TotbC5HfxWwJpAn9ANhm738omUBV8EMxSiuKlt3tqxa61R9P78cplzKCbmQ3ymS+dDQa2zVVAJXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773176709; c=relaxed/simple;
	bh=LK8jyehOxaS/BM+Q/qlywhbxxM6nxr1dSswRvjFBgOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxLesUuozh5hIbfb+U0Q5nVR1z1zELCqzswKJc3Itj5sYHu98a66OTXrrdYOPaU1orTL6hp+tV5vaP7ucT7JKz0tr7O4PhQmte/y259mDj+bmqkQ0rEJtbOc3drGOGNPYgfUgXRdVrvGbxyStBJCfE3VZM/WwbXstG/1fUEEzBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=A+PFYVBZ; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="A+PFYVBZ"
Date: Tue, 10 Mar 2026 22:05:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773176705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y6brBNqcdfn554XKTQ6QCHjcUCyfV7MoooFSrPsTCF4=;
	b=A+PFYVBZ57DQ69civxRhK1lx9ADbpkRlVi0bMqdjDSHOKvV3qqtRSs3w8MRw8/Z+QwmmiQ
	NjYdoI9Ds/APhnJmUzu42P8YkjMiFkowVHEiVNJmsavRHeX6fosM4s1Fa4T0rLvfwNHpY7
	8fMOt3NuqwxgWZvE+0BXgguaz5O3TtT7wX74xOvySu+Ccazr3ow95CyKa/yQzj8QydoP7/
	pVDvjV7e+3kqYG+d5PIkHWIZwzwN6WGjIz0ZGkw+Oy61SgoEEgCgzl2xQvcNYuORnBOFCH
	/qn99BacQe+HgkuPe/XIc/etNqeiJr+H6SuthZFydfb0qnMF/Kzyme75AIj2sQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mroik <mroik@delayed.space>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 3/5] format-patch: add ability to use alt cover format
Message-ID: <abCFlUkXbth08nPS@exploit>
References: <cover.1772837832.git.mroik@delayed.space>
 <cover.1772839973.git.mroik@delayed.space>
 <316c9e76ee49d73aff75b63299c970e9f55f79b6.1772839973.git.mroik@delayed.space>
 <8f49d551-9741-4461-b076-3caba75e6122@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f49d551-9741-4461-b076-3caba75e6122@gmail.com>
X-Spamd-Bar: --

On Tue, Mar 10, 2026 at 02:33:46PM +0000, Phillip Wood wrote:
> > Give format-patch the ability to specify an alternative format spec
> > through the "--cover-letter-format" option. This option either takes
> > "shortlog", which is the current format, or a format spec prefixed with
> > "log:".
> 
> That sounds like a nice improvement over using the shortlog output. However
> it is rather cumbersome to have to type "log:" each time. As
> --cover-letter-format=shortlog is a nonsensical format I don't think we need
> to require the "log:" prefix. --no-cover-letter-format should behave like
> --cover-letter-format=shortlog.

This was done to avoid having "anything that is not shortlog should be
in pretty-print format". Having it this way in the future we can check
for the prefix and see if the user indeed would like the pretty-print
format, otherwise check againts other formats available (so far only
shortlog). If "log:" is too cumbersome maybe we can drop it and check
instead for existing presets first, "shortlog, etc..." and then when
nothing is found interpret it as pp format. I like the explicit prefix
but I guess it is unlikely that a user will want to print "shortlog" on
every line.

Do we all agree on dropping the prefix?

> This is unnecessary as commit_line is initialized in the declaration above.

Will remove

> This loop is a bit confusing, I wonder if it would be simpler to count up
> 	for (int i = 1; i <= n; i++) {
> 		rev.nr = i
> 		repo_format_commit_message(the_repository, list[n - i], ...);

Will rewrite for readability

> > +test_expect_success 'cover letter with subject, author and count' '
> > +	rm -rf patches &&
> > +	test_when_finished "git reset --hard HEAD~1" &&
> > +	test_when_finished "rm -rf patches result test_file" &&
> > +	touch test_file &&
> > +	git add test_file &&
> > +	git commit -m "This is a subject" &&
> > +	git format-patch --cover-letter \
> > +	--cover-letter-format="log:[%(count)/%(total)] %s (%an)" -o patches HEAD~1 &&
> > +	grep "^\[1/1\] This is a subject (A U Thor)$" patches/0000-cover-letter.patch >result &&
> 
> using test_grep here would make it easier to debug test failures.

Will do

> > +	test_line_count = 1 result
> > +'
> > +
> > +test_expect_success 'cover letter shortlog' '
> > +	test_when_finished "git reset --hard HEAD~1" &&
> > +	test_when_finished "rm -rf patches result test_file" &&
> > +	touch test_file &&
> > +	git add test_file &&
> > +	git commit -m "This is a subject" &&
> > +	git format-patch --cover-letter --cover-letter-format=shortlog \
> > +	-o patches HEAD~1 &&
> > +	sed -n -e "/^A U Thor/p;" patches/0000-cover-letter.patch >result &&
> 
> This just checks that the author name appears in the coverletter, not that
> the patches are formatted with shortlog.

The name at the start of the line can appear only if the foramt is
shortlog, but if in the future it we do decide to support more prefix
that might not be true anymore. Will rewrite this test to be more
robust.
