Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDFD91F744
	for <e@80x24.org>; Tue, 21 Jun 2016 07:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbcFUHcF (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 03:32:05 -0400
Received: from mout.gmx.net ([212.227.17.21]:51355 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753105AbcFUHcD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 03:32:03 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MVIva-1asc8b28MQ-00Yf1Y; Tue, 21 Jun 2016 09:31:47
 +0200
Date:	Tue, 21 Jun 2016 09:31:45 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/7] log-tree: respect diffopt's configured output
 file stream
In-Reply-To: <xmqqwplju74a.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1606210920510.22630@virtualbox>
References: <cover.1466244194.git.johannes.schindelin@gmx.de> <cover.1466420060.git.johannes.schindelin@gmx.de> <babf95df5f610feb6c2ae7f2ed3cff98bab47fe2.1466420060.git.johannes.schindelin@gmx.de> <xmqqwplju74a.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:l9pp/mcn7E4SqGnYSSoSGok8rJN5Vs9C2z+kPea16nV9HVOKAh8
 3yr+MGraRC0BOvaXSzYod8P57qR37N53kE/6rW0Ar45PVizBskjX/Pb/5VpkKIMTXx8TEQL
 T+/k/5upyKL2wuitALJDeXI/Y3Iz7O9c8GOiY5s7Z0cO4832xEvM7jswjSbbj1GkIE4Cvax
 9RFV/klGg5ivt/D5/2WBA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:XfDZiufM8Uw=:0cdy4wgrgTVhii0PFbgp/H
 KVa6tWHztniFd2sAGUufbjHt06gHiVO0FuNxdcxg1Gg4AxdNwaxi8ZISHjyd6FYTQNGKyyxnW
 eSAEjzyEna5W2V+rvbJk5QZu5BQcHxpy56rKKbpyC2Lr4wxD7JuZvBTCih8OzKLt1vte7lP2p
 K1xHofkx1ti7o9yKv1kzsM7DaHgac4rVMHnssUnQiUQpRKVxLlmGWkOYTLGA4QX10ofbBSR5R
 K+ph4U57oalPNSldXIbkKvQIGB9yZc7qonhXdAdQ/E6j0Lzi7vRNOWXUrlRecQjsJZhrW8kzV
 coeVGiH/K06qZRoeL8Y2AmcwUrDBrpIs8Vak1kWWUfAHAZl68OsWRyoB5zk82leQVwuKYTHab
 3Ip6AjG6pKR07YRf6TV+F9+jgzBZxZ6oFfVfUm+VONPjB4CVzLo46xUw8+KOBtQIVB3VujsXf
 eI8jqWrkFrB13A5JKROw+FQPsyzUtxHCdMurvCJ9at3bSVe0R6zikuwMp0CPbmBaYf750skCA
 dj7XwW/dRinamMQlcNBx2H+z2uT0cRBtk8PS0IRsjVzljYwDiBj68IQsmOEdKCwMUkWmR0a2p
 +X7iwhHNcXhJGKnBQFQD2IQnbRoQJpiN5Fa+28VCWZKCN4D7f6R3rvoaOcUgt94n2PWkW78/R
 vo1MtGFvDr6NLdEK1SiiFgPckA02W3RUS1BkLUGd6qIAFvlCcW3628g0PPdj6ZAB3rzXIGa38
 JhoBgHLcbzH0uaRN3aHpqt85EFI7S82AjZvDNI2s4goYu35/j9oRbeBusRQ0NOKR2+CARL1fN
 JdnX/uG
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Mon, 20 Jun 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > The diff options already know how to print the output anywhere else
> > than stdout. The same is needed for log output in general, e.g.  when
> > writing patches to files in `git format-patch`. Let's allow users to
> > use log_tree_commit() *without* changing global state via freopen().
> 
> I wonder if this change is actually fixing existing bugs.  Are there
> cases where diffopt.file is set, i.e. the user expects the output to be
> sent elsewhere, but the code here unconditionally emits to the standard
> output?  I suspect that such a bug can be demonstratable in a test or
> two, if that were the case.

It is conceivable, but I did not have time to chase those cases down yet.

> I am sort-of surprised that we didn't do this already even though we
> had diffopt.file for a long time since c0c77734 (Write diff output
> to a file in struct diff_options, 2008-03-09).
> 
> Use of freopen() to always write patches through stdout may have
> been done as a lazy workaround of the issue this patch fixes, but
> what is surprising to me is that doing it the right way like this
> patch does is not that much of work.  Perhaps that was done long
> before c0c77734 was done, which would mean doing it the right way
> back then when we started using freopen() it would have been a lot
> more work and we thought taking a short-cut was warranted.

Back when I implemented the feature to write to individual files, I indeed
used freopen() out of laziness: 0377db7 (Teach fmt-patch to write
individual files., 2006-05-05). I could not have used diffopt.file at that
stage, anyway: that field still was almost two years in the future.

> >  		if (opt->children.name)
> >  			show_children(opt, commit, abbrev_commit);
> >  		show_decorations(opt, commit);
> >  		if (opt->graph && !graph_is_commit_finished(opt->graph)) {
> > -			putchar('\n');
> > +			fputc('\n', opt->diffopt.file);
> 
> Hmph.  putc() is the "to the given stream" equivalent of putchar()
> in the "send to stdout" world, not fputc().  I do not see a reason
> to force the call to go to a function avoiding a possible macro here.

TBH I did not even *know* putc(). It is amazing how you can learn new
things about the POSIX API after decades of working with it.

> Likewise for all the new fputc() calls in this series that were
> originally putchar().

Goes without saying.

> > @@ -880,8 +880,9 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
> >  		shown = 1;
> >  	}
> >  	if (opt->track_linear && !opt->linear && opt->reverse_output_stage)
> > -		printf("\n%s\n", opt->break_bar);
> > +		fprintf(opt->diffopt.file, "\n%s\n", opt->break_bar);
> >  	opt->loginfo = NULL;
> > -	maybe_flush_or_die(stdout, "stdout");
> > +	if (opt->diffopt.file == stdout)
> > +		maybe_flush_or_die(stdout, "stdout");
> >  	return shown;
> >  }
> 
> This one looks fishy.
> 
> Back when we freopen()'ed to write patches only through stdout, we
> always called maybe_flush_or_die() to make sure that the output is
> flushed correctly after processing each commit.  This change makes
> it not to care, which I doubt was what you intended.  Instead, my
> suspicion is that you didn't want to say "stdout" when writing into
> a file.
> 
> But even when writing to on-disk files, the code before your series
> would have said "stdout" when it had trouble flushing, so I do not
> think this new "if()" condition is making things better.  If "it
> said stdout when having trouble flushing to a file" were a problem
> to be fixed, "let's not say stdout by not even attempting to flush
> and catch errors when writing to a file" would not be the right
> solution, no?
> 
> Personally, I do not think it hurts if we kept saying 'stdout' here,
> even when we flush opt->diffopt.file and found a problem.

Okay, I changed it back to be unconditional.

My original thinking was that we will fclose() the file (if it is not
stdout) anyway, which implies flushing. But the more I think about it,
the more I come to the conclusion that this is more of a side effect,
based on deep knowledge of the current code. So I now agree with you that
it would be "too clever".

Expect v3 in a moment.

Ciao,
Dscho
