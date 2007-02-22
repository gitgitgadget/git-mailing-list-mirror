From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach git-diff{,-files} the new option `--no-index`
Date: Thu, 22 Feb 2007 17:25:49 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702221724090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702201944340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzm76fpia.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 22 17:26:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKGlY-0003Zv-4m
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 17:25:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbXBVQZv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 11:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbXBVQZv
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 11:25:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:33809 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751048AbXBVQZu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 11:25:50 -0500
Received: (qmail invoked by alias); 22 Feb 2007 16:25:49 -0000
X-Provags-ID: V01U2FsdGVkX18i72cDEFEiI9LjYzXkPL+h/7ukqNSL4jw2zbsIG7
	a2OA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vzm76fpia.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40357>

Hi,

On Thu, 22 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > +int run_diff_files(struct rev_info *revs, int argc, const char **argv)
> >  {
> >  	int entries, i;
> > +	int diff_unmerged_stage;
> > +	int silent_on_removed;
> > +
> > +	if (handle_diff_files_args(revs, argc, argv, &silent_on_removed))
> > +		return -1;
> > +
> > +	diff_unmerged_stage = revs->max_count;
> > +
> > +	if (revs->max_count == -2) {
> > +		if (revs->diffopt.nr_paths != 2)
> > +			return error("need two files/directories with --no-index");
> > +		queue_diff(&revs->diffopt, revs->diffopt.paths[0],
> > +				revs->diffopt.paths[1]);
> > +		diffcore_std(&revs->diffopt);
> > +		diff_flush(&revs->diffopt);
> > +		return 0;
> > +	}
> 
> I do not mind the "max_count == -2 is some magic" hack too much,
> but I do not think it belongs to a generic service function
> whose purpose is to run "diff-files" aka "diff between index and
> working tree".  run_diff_files() is used by other applications
> (most notably wt-status) for example, and I expect we would need
> that when we rewrite git-commit itself in C.

Well, the alternative is to duplicate code, as you need both the option 
parsing and the special handling of max_count==-2 in both builtin-diff.c 
and builtin-diff-files.c.

Ciao,
Dscho
