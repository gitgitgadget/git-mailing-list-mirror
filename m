Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558A9451051
	for <git@vger.kernel.org>; Wed,  6 May 2026 12:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778072071; cv=none; b=rbQmjnC6WXnWrF1ePXn3/vFpOo4oK+wMzBHuKh6u1Qn0vQl0tGOfHrSBigBiaEFMABoZoUzZWN7I5lxk4k9lbsSKwf45lZZupdH3WYyVXicJrP8+CwWMivdtHS1/PIdrWNg2tIIJjqruc7qiTfMtbQ8KOgkBZLjjjw+jslc03Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778072071; c=relaxed/simple;
	bh=fvOtZYq3AL0JI/4Wr1T+ckVvkuvSuJrMnM4mMisLFPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdbZgqFysWYNd+1AgWzJQRcTWEpNdyz6ErCfOM/eAQGC7LAeGxiI8sLPSBDThbqpDArvWG3Ml7yRBLnSPv/t5WusrASGY55iDhLJhwhcbqln1xv3W/YrTFXTw4Zh8eLodWCKSPtN566s7Z1SpU3uS+SKo/ijC/sK2cAf9ZxFZ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=WVH1HlIY; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="WVH1HlIY"
Date: Wed, 6 May 2026 14:54:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1778072065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kKvKZQnGKVDWFX/nwbOaRH17uUrOdWP31V3hKbUrSeI=;
	b=WVH1HlIYmaO1CscycTau9oA6eDzw/dhbMQP2qmplSsJfDBvn7VLj9QFGtcY2ry06VJescp
	ZvHjFkxB7jQCY3zRwlb1B9DA25OTXY6OhaFHgzijq1pSaMrwTea9rrCxMARihKCN/Exixk
	vQIfdKCGM1lxHKZc4ADcNsRDVd7NKyI1oyTQNW+o3QY5rwUc9cbMPgdvl8hvZnHxtctX/R
	HyDL1GTGbz+o1Gc/tQnFdrUeTXPwJcsGrARtfzYSwnaHdlILQqWefuOBwgwIcNiOia7pAG
	iuWEMsCtcZsQCmFtKe+9wADsPM4XoHzoPTvd+VnaS7xIrHN4oXKjuM9Q5ZBRCQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>, Patrick Steinhardt <ps@pks.im>, Tian Yuchen <cat@malon.dev>, 
	Ben Knoble <ben.knoble@gmail.com>, Chris Torek <chris.torek@gmail.com>, git@vger.kernel.org, 
	Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v6] revision.c: implement --max-count-oldest
Message-ID: <afs2QVHerGLALFcl@exploit>
References: <2f71a00b035e25b971641b77a6fa7626f1e2459c.1777578676.git.mroik@delayed.space>
 <ce8d1ff49ef418ae3720265a124ef53a959d289e.1778017966.git.mroik@delayed.space>
 <7250e6c1-633e-417b-aacb-94e35d240d3f@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7250e6c1-633e-417b-aacb-94e35d240d3f@kdbg.org>
X-Spamd-Bar: -

On Wed, May 06, 2026 at 08:45:36AM +0200, Johannes Sixt wrote:
> > +`--max-count-oldest=<number>`::
> > +   Just like `--max-count=<number>`, it limits the output to _<number>_
> > +   commits. But instead of limiting to the first _<number>_ commits it
> > +   limits to the last _<number>_ commits.
> > +
> 
> "Just like --max-count" is a surprising addendum in this sentence,
> because the only thing they have in common is the limiting of commits,
> which it repeats anyway. It's more like "Unlike --max-count, limits the
> output to _<number>_ last commits."

Will fix in v7.

> BTW, this makes me think whether this kind of limiting could be
> triggered by a negative argument to --max-count.

Would be a good idea if it weren't for the fact that --max-count < 0 has
for a long time acted like no max count. I'd imagine many could be
asssuming this behaviour in their scripts.

> >  `--skip=<number>`::
> >     Skip _<number>_ commits before starting to show the commit output.
> >  
> > diff --git a/revision.c b/revision.c
> > index 599b3a66c3..3aaa77ced5 100644
> > --- a/revision.c
> > +++ b/revision.c
> > @@ -2339,10 +2339,24 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
> >     }
> >  
> >     if ((argcount = parse_long_opt("max-count", argv, &optarg))) {
> > +       if (revs->max_count_type == 1)
> > +           die(_("can't use --max-count with --max-count-oldest"));
> 
> To help translators, the usual pattern is to say (here and later)
> 
> 	die(_("options '%s' and '%s' cannot be used together"),
> 		"--max-count", "--max-count-oldest");

Will do.

> > @@ -4521,15 +4535,68 @@ static struct commit *get_revision_internal(struct rev_info *revs)
> >     return c;
> >  }
> >  
> > +static void retrieve_oldest_commits(struct rev_info *revs,
> > +                   struct commit_list **queue)
> > +{
> > +   struct commit *c;
> > +   int max_count = revs->max_count;
> > +   int queuei_count = 0;
> > +   int queueo_count = 0;
> > +   struct commit_list *queueo = NULL;
> > +   struct commit_list *queuei = NULL;
> > +   struct commit_list *reversed_queue = NULL;
> > +
> > +   revs->max_count = -1;
> > +   while ((c = get_revision_internal(revs))) {
> > +       c->object.flags &= ~SHOWN;
> > +       commit_list_insert(c, &queuei);
> > +       queuei_count++;
> > +       while (queuei_count + queueo_count > max_count) {
> > +           if (!queueo_count) {
> > +               while (queuei_count > 0) {
> > +                   c = pop_commit(&queuei);
> > +                   queuei_count--;
> > +                   commit_list_insert(c, &queueo);
> > +                   queueo_count++;
> > +               }
> > +           }
> > +           pop_commit(&queueo);
> > +           queueo_count--;
> > +       }
> > +   }
> > +
> > +   while ((c = pop_commit(&queueo)))
> > +       commit_list_insert(c, &reversed_queue);
> > +   while ((c = pop_commit(&queuei)))
> > +       commit_list_insert(c, &queueo);
> > +   while ((c = pop_commit(&queueo)))
> > +       commit_list_insert(c, &reversed_queue);
> > +
> > +   while ((c = pop_commit(&reversed_queue)))
> > +       commit_list_insert(c, queue);
> > +}
> > +
> >  struct commit *get_revision(struct rev_info *revs)
> >  {
> >     struct commit *c;
> >     struct commit_list *reversed;
> > +   struct commit_list *queue = NULL;
> > +
> > +   if (revs->max_count_type == 1 && !revs->max_count_stage) {
> > +       retrieve_oldest_commits(revs, &queue);
> > +       commit_list_free(revs->commits);
> > +       revs->commits = queue;
> > +       revs->max_count_stage = 1;
> > +   }
> >  
> >     if (revs->reverse) {
> >         reversed = NULL;
> > -       while ((c = get_revision_internal(revs)))
> > -           commit_list_insert(c, &reversed);
> > +       if (revs->max_count_type == 1)
> > +           while ((c = pop_commit(&revs->commits)))
> > +               commit_list_insert(c, &reversed);
> > +       else
> > +           while ((c = get_revision_internal(revs)))
> > +               commit_list_insert(c, &reversed);
> >         commit_list_free(revs->commits);
> >         revs->commits = reversed;
> >         revs->reverse = 0;
> 
> I would have expected that this kind of commit counting is handled at
> the same spot where --max-count is handled, i.e., in
> get_revision_internal(). It could make a difference in combination with
> sorting options, --boundary, and --graph. The goal is that --max-count
> and --max-count-oldest behave the same in this regard. (But I am in no
> way an expert of the revision walker.)

It doesn't affect sorting options and the graph output by itself is
handled by setting the commits as not shown when we store them, but the
boundary option does break.

Will fix in v7.

Thank you
