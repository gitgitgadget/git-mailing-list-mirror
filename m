Return-Path: <SRS0=cZ0k=DR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12057C2BD0C
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 23:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8617C2075E
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 23:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="fK+PAhmm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731505AbgJJW4T (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Oct 2020 18:56:19 -0400
Received: from mout02.posteo.de ([185.67.36.66]:42453 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731354AbgJJTLi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Oct 2020 15:11:38 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 38FC92400FC
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 16:02:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1602338527; bh=UVOC/a2S8KPNxNSBK0Hnx8PTSelMVyyir1fFSfaDx8I=;
        h=Date:From:To:Cc:Subject:From;
        b=fK+PAhmm87+J7G4annQU0jytnwgX7tJ2SBu7qLgMHNLmso3tKubWBj6IuGUhauUsS
         2ydMtu0ODXIq6aqUqVIWaVKmU4gWSESB7RUrQ6zRNtuDlKvqyV6Xdf6otEhaZUoizM
         T1XNtL56Zvm9MxdXY/+A3z/fNsqqv81sEuHlIfelZtEQeTP41J3wOlZPw71cMz5NIl
         m25EVmAdhvPnTOh4NveThJfxVhKrcJ+D67tTmsXobRMb/3zbRhddR1xK7JUytoRV+M
         TKcWe0gAqmxWnKcUPRtldA7QHTqRGn/nPkqFYTVLBdYfGKmsU1dsKOC24zeT2GAZ+q
         vGB2dwMDGzrhA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4C7mpP5qJHz6tm9;
        Sat, 10 Oct 2020 16:02:05 +0200 (CEST)
Date:   Sat, 10 Oct 2020 16:02:02 +0200
From:   Robert Karszniewicz <avoidr@posteo.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] log: add log.showStat configuration variable
Message-ID: <20201010140202.GA20470@HP>
References: <20201008162015.23898-1-avoidr@posteo.de>
 <xmqq1ri8y4zl.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1ri8y4zl.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 08, 2020 at 10:58:22AM -0700, Junio C Hamano wrote:
> Robert Karszniewicz <avoidr@posteo.de> writes:
> 
> > Changes default behaviour of `git log` and `git show` when no
> > command-line options are given. Doesn't affect behaviour otherwise (same
> > behaviour as with stash.showStat).
> > ---
> > I've wanted to have `show` and `log` show --stat by default, and I
> > couldn't find any better solution for it. And I've discovered that there
> > is stash.showStat, which is exactly what I want. So I wanted to bring
> > stash.showStat to `show` and `log`.
> 
> I would be happy if I can configure my "git show" to 
> 
>  - show not just patch but stat by default;
>  - keep showing nothing when told to be silent with "git show -s"
> 
> independently what happens to my "git log".  Specifically, I do not
> want to see a configuration that I use to tweak "git show" the way I
> want (see above) to make my "git log" to become "git log --stat".
> 
> And why is "stat" so special?  I am sure there are people who want
> to do --numstat or --summary or combinations of these by default,

I think --stat is "special" because it is the most prominent one,
popularized by the format-patch format. I've personally come to like
--stat very much, to me it serves as a TOC of a commit, an extension of
the commit message, an essential description of a commit/patch.

It makes sense for format-patch, but it does not make less sense for
`show`. (Or does it? I mean, if it is a good idea for distributable
patch files, why is it less of a good idea for local commits/patches?)

Then we also have `stash-show`, which shows nothing /but/ --stat by
default. Here again: what's the difference between `show` and
`stash-show`? One might say "different contexts", but I don't see them
being that different, really. It just seems inconsistent to me. 

And that was what I wanted to achieve with my patch - to make it
possible to make the three formats consistent with each other.

That's how I think --stat is special. For other "unknown"/"custom"
options I would use an alias, as I already do for variations of `log`
options.
Then why did I still add log.showStat? Because it seemed like too close
of a relative not to do it. Also because I personally use it and I
believe that commit message and stat belong together and it's an
injustice to separate them. And still only because "--stat is special".

> > diff --git a/revision.h b/revision.h
> > index f6bf860d19..e402c519d8 100644
> > --- a/revision.h
> > +++ b/revision.h
> > @@ -204,6 +204,7 @@ struct rev_info {
> >  			show_merge:1,
> >  			show_notes_given:1,
> >  			show_signature:1,
> > +			show_stat:1,
> >  			pretty_given:1,
> >  			abbrev_commit:1,
> >  			abbrev_commit_given:1,
> 
> The change to the code we saw in builtin/log.c, e.g.
> 
> > +	if (!rev->diffopt.output_format) {
> > +		/* Turn --cc/-c into -p --cc/-c when -p was not given */
> > +		if (rev->combine_merges)
> > +			rev->diffopt.output_format = DIFF_FORMAT_PATCH;
> > +
> > +		if (rev->show_stat)
> > +			rev->diffopt.output_format |= DIFF_FORMAT_DIFFSTAT;
> > +	}
> 
> hints us that this new bit belongs to the group that the
> combine_merges bit belongs to, not here, no?

Right! I remember being unsure about it, but then the peer pressure of
all the show* variables made me group it to them.

> 
> But again, I am not sure if a new bit in rev_info structure is a
> good way to proceed---after all, when a diff (in various forms, like
> "patch", "stat only", "patch and stat", "patch, stat, and summary")
> is shown, how exactly they are shown is not controlled by bits in this
> structure (rather, that comes from the diffopt field).

I will try to find a better way.

> 
> Thanks.

Thank you for your comments.
