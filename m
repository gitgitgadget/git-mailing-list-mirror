Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 919991F955
	for <e@80x24.org>; Fri, 29 Jul 2016 13:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855AbcG2NBF (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 09:01:05 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:44525 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbcG2NBC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 09:01:02 -0400
Received: from mfilter24-d.gandi.net (mfilter24-d.gandi.net [217.70.178.152])
	by relay5-d.mail.gandi.net (Postfix) with ESMTP id E721941C0A9;
	Fri, 29 Jul 2016 15:00:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter24-d.gandi.net
Received: from relay5-d.mail.gandi.net ([IPv6:::ffff:217.70.183.197])
	by mfilter24-d.gandi.net (mfilter24-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id JNmK3UunKiDb; Fri, 29 Jul 2016 15:00:58 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 06D8441C080;
	Fri, 29 Jul 2016 15:00:56 +0200 (CEST)
Date:	Fri, 29 Jul 2016 06:00:55 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	Richard Ipsum <richard.ipsum@codethink.co.uk>
Cc:	git@vger.kernel.org, linux-kernel@vger.kernel.org,
	dborowitz@google.com
Subject: Re: [ANNOUNCE] git-series: track changes to a patch series over time
Message-ID: <20160729130054.GD4340@x>
References: <20160729064055.GB25331@x>
 <20160729101011.GA3469@salo>
 <20160729110426.GA2945@x>
 <20160729124443.GA3686@salo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160729124443.GA3686@salo>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 29, 2016 at 01:44:44PM +0100, Richard Ipsum wrote:
> On Fri, Jul 29, 2016 at 04:04:26AM -0700, Josh Triplett wrote:
> > I hope to use git notes with git-series in the future, by putting
> > another gitlink under the git-series for notes related to the series.
> > I'd intended that for more persistent notes; putting them in the series
> > solves some of the problems related to notes refs, pushing/pulling, and
> > collaboration.  Using notes for review comments makes sense as well,
> > whether in a series or in a separate ref.
> 
> Sounds interesting, can you explain how this works in more detail?

The tree within a git-series commit includes a blob "cover" for the
cover letter, a gitlink "base" for the base commit, and a gitlink
"series" for the top of the series.  I could add a gitlink "notes",
which acts like a notes ref; then, each version of the series would have
its own notes ref.  As with the series, git-series would track the
"history of history"; since git-notes themselves use git history to
store a set of notes, git-series would store the history of the notes.
So if you add, remove, or change a note, git-series would track that as
a change to the notes ref.  If you merge/rebase/etc the notes ref to
merge notes, git-series would track that too.  A different series would
have a different set of notes, so you wouldn't be limited to
one notes ref per repository.

This doesn't solve the problem of merging notes, but it *does* mean you
have a full history of the changes to notes, not just the notes
themselves.

Something similar might work for the Gerrit notesdb.

> > > I've been considering taking the perl-notedb prototype and writing
> > > a C library for it with bindings for other languages (i.e. Rust).
> > 
> > A C library based on libgit2 seems like a good idea; ideally the
> > bindings could interoperate with git2-rs.  (Alternatively, Rust can
> > *export* a C interface, so you could write directly with git2-rs. :) )
> 
> Certainly a fair alternative, though it may arguably be safer to write
> the C and export to other languages, as cool as Rust looks it's not
> established the way C is, so may be a slightly riskier foundation,
> in my view.

I was mostly joking there.  Rust makes that potentially reasonable,
unlike most languages that can consume but not easily provide a C API,
but that doesn't make it the ideal solution quite yet. :)

> And ofcourse in C we have native access to libgit2.

Right.

> > One of the items on my long-term TODO list is a completely federated
> > GitHub; I've been looking at other aspects of that, but federated
> > reviews/comments/etc seem critical to that as well.
>
> I agree.
