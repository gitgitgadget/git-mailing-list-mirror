Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65EEDF76
	for <git@vger.kernel.org>; Sun, 10 May 2026 00:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778373683; cv=none; b=O7RP8cvvzlT9qoQDhzy87Tvslzt4bl278MakFbCcjpGAZkEzNLlN0fVVXgiCCgyCiYAc99RxJ4Lds/TegAb0FjOH1LqD8IbUvEsSXDTmqFE9FDPW75nAIU8k0l9I8kplyhQ9PzTWDpdUiKUwhz9jZBUTBrlAJOJsUQl+oC+gROI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778373683; c=relaxed/simple;
	bh=p348OpgEVx+ZIbYTv3nKqNrNV+D5gKHFBROf1UoZRdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h//xyMdkX1TIDzQQsfPu8WAnUD18dP9Z8IRNHS7Jo3FEqgqV+TCpnVo8D9R94MWoMCYPoqSy6kVyLboeBbEu5sMrjXtle707Ie88Ato5NYeMiYlUYCIbRXyfBKB4e9HkmNNQaJ/afQvG41/hiRjrVSXaizSfIUY6/fHvpaWNyqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=lElL7lNq; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="lElL7lNq"
Date: Sun, 10 May 2026 02:41:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1778373680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=51CQmO4cQ7RtUdIDF1rtVBrGFmNu8tAOtDDkUeBQFYY=;
	b=lElL7lNq7ceIWdjR5gTY7bnsZI6sKk3gyJq0mwmQ4kn5a9LPyGdsICb6h+5mU4vl0bqP2R
	fDvuOAMSfxFJ5h9cezhwpW9MTl0En0FJvCLVx5HY1U7xLjT5UKzS87k2q1iUJ1VmGZ1ezH
	KPaXFJwvnKj2JCCKGYc5ACykVYpC6YIuFnwb/SbEYrYR3IDNZ60+jyBejFJLBVmm+gXtyJ
	4InnutVonEoTavVLXT8RVlJML7iPLlXgyXeBiZWYaJfNc3nkS2QiIqBZkhYzIVdsflpmT8
	sEeIquLL1+7db6Rv3Y/M3MDnQVW+xjpvCvBO44hy1R6GuOb0Z5b5+emXsh67jw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>, Tian Yuchen <cat@malon.dev>, 
	Ben Knoble <ben.knoble@gmail.com>, Johannes Sixt <j6t@kdbg.org>, 
	Chris Torek <chris.torek@gmail.com>, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v6] revision.c: implement --max-count-oldest
Message-ID: <af_Td41Mga0Z-MMv@exploit>
References: <2f71a00b035e25b971641b77a6fa7626f1e2459c.1777578676.git.mroik@delayed.space>
 <ce8d1ff49ef418ae3720265a124ef53a959d289e.1778017966.git.mroik@delayed.space>
 <2409449.ElGaqSPkdT@piment-oiseau>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2409449.ElGaqSPkdT@piment-oiseau>
X-Spamd-Bar: -

On Sat, May 09, 2026 at 02:46:26PM +0200, Jean-Noël AVILA wrote:
> On Tuesday, 5 May 2026 23:54:56 CEST Mirko Faina wrote:
> > --max-count is a commit limiting option sets a maximum amount of commits
> > to be shown. If a user wants to see only the first N commits of the
> > history (the oldest commits) they'd have to do something like
> > 
> >     git log $(git rev-list HEAD | tail -n N | head -n 1)
> > 
> > This is not very user-friendly.
> > 
> > Teach get_revision() the --max-count-oldest option.
> > 
> > Signed-off-by: Mirko Faina <mroik@delayed.space>
> > ---
> > Since v5 I've reworded the commit message and rewrote the docs for
> > --max-count-oldest to be clearer on its functionality.
> > 
> >  Documentation/rev-list-options.adoc |  5 ++
> >  revision.c                          | 77 +++++++++++++++++++++++++++--
> >  revision.h                          |  2 +
> >  t/t4202-log.sh                      | 14 ++++++
> >  4 files changed, 95 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/rev-list-options.adoc
> > b/Documentation/rev-list-options.adoc index 2d195a1474..9f857cabcc 100644
> > --- a/Documentation/rev-list-options.adoc
> > +++ b/Documentation/rev-list-options.adoc
> > @@ -18,6 +18,11 @@ ordering and formatting options, such as `--reverse`.
> >  `--max-count=<number>`::
> >     Limit the output to _<number>_ commits.
> > 
> > +`--max-count-oldest=<number>`::
> > +   Just like `--max-count=<number>`, it limits the output to _<number>_
> > +   commits. But instead of limiting to the first _<number>_ commits it
> > +   limits to the last _<number>_ commits.
> > +
> 
> Putting aside the discussion of --max-count=<neg-value> vs --max-count-
> oldest=<value>, I do not think that defining --max-count-old with respect with 
> --max-count is legible. It would be better to refine the definition of --max-
> count (i.e. "Limit the output to the _<number>_ first commits") and just 
> define --max-count-oldest on its own in the same manner. Referring to another 
> entry is only practicable when it avoids repeating a long explanation. 
> Otherwise, each entry's explanation should be as self-contained as possible.

Will do in v7.

> >  `--skip=<number>`::
> >     Skip _<number>_ commits before starting to show the commit output.
> > 
> > diff --git a/revision.c b/revision.c
> > index 599b3a66c3..3aaa77ced5 100644
> > --- a/revision.c
> > +++ b/revision.c
> > @@ -2339,10 +2339,24 @@ static int handle_revision_opt(struct rev_info 
> *revs, int
> > argc, const char **arg }
> > 
> >     if ((argcount = parse_long_opt("max-count", argv, &optarg))) {
> > +       if (revs->max_count_type == 1)
> > +           die(_("can't use --max-count with --max-count-oldest"));
> >         revs->max_count = parse_count(optarg);
> >         revs->no_walk = 0;
> > +       revs->max_count_type = 0;
> >         return argcount;
> > +   } else if ((argcount = parse_long_opt("max-count-oldest", argv, 
> &optarg))) {
> > +       if (revs->max_count_type == 0 && revs->max_count != -1)
> > +           die(_("can't use --max-count with --max-count-oldest"));
> > +       if (revs->skip_count > 0)
> > +           die(_("con't use --max-count-oldest with --skip"));
> 
> Typo here (con't → can't). In any case, please prefer 
> die_for_incompatible_opt2, to uniformize the messages and limit the number of 
> translation strings.

Will do.

> Adding a test for these incompatibilities would be great too.

Yes, should've done that sooner. Will do.

> > +       revs->max_count = parse_count(optarg);
> > +       revs->no_walk = 0;
> > +       revs->max_count_type = 1;
> > +       revs->max_count_stage = 0;
> >     } else if ((argcount = parse_long_opt("skip", argv, &optarg))) {
> > +       if (revs->max_count_type == 1)
> > +           die(_("con't use --max-count-oldest with --skip"));
> 
> ditto

Will do.

> >         revs->skip_count = parse_count(optarg);
> >         return argcount;
> >     } else if ((*arg == '-') && isdigit(arg[1])) {
> > @@ -4521,15 +4535,68 @@ static struct commit *get_revision_internal(struct 
> rev_info
> > *revs) return c;
> >  }
> > 

Thank you
