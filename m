From: Jeff King <peff@peff.net>
Subject: Re: [question] how can i verify whether a local branch is tracking
	a remote branch?
Date: Mon, 6 Apr 2009 17:29:35 -0400
Message-ID: <20090406212935.GB882@coredump.intra.peff.net>
References: <4d8e3fd30904050332w394cccbaq5b82d2a53ed357a3@mail.gmail.com> <20090405144413.GC2076@sigill.intra.peff.net> <4d8e3fd30904051425w6739a12fp5666e71e8b2d7958@mail.gmail.com> <20090406043426.GC12341@coredump.intra.peff.net> <49D9EEE2.3000607@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Apr 06 23:31:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqwPh-0004xz-P6
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 23:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061AbZDFV34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 17:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752539AbZDFV34
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 17:29:56 -0400
Received: from peff.net ([208.65.91.99]:50123 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752048AbZDFV3z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 17:29:55 -0400
Received: (qmail 27576 invoked by uid 107); 6 Apr 2009 21:30:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 06 Apr 2009 17:30:13 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Apr 2009 17:29:35 -0400
Content-Disposition: inline
In-Reply-To: <49D9EEE2.3000607@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115884>

On Mon, Apr 06, 2009 at 02:00:34PM +0200, Michael J Gruber wrote:

> > +		if (!strcmp(name, "tracking")) {
> > +			struct branch *branch;
> > +			if (prefixcmp(ref->refname, "refs/heads/"))
> > +				continue;
> > +			branch = branch_get(ref->refname + 11);
> > +			if (branch && branch->merge && branch->merge[0] &&
> > +			    branch->merge[0]->dst)
> > +				v->s = branch->merge[0]->dst;
> 
> Isn't that missing out on those cases where you --track (i.e. follow) a
> local (upstream) branch? See
> 5e6e2b4 (Make local branches behave like remote branches when --tracked,
> 2009-04-01)

I thought the logic was in branch_get to handle it. And indeed:

  $ git checkout --track -b new master
  Branch new set up to track local branch master.
  Switched to a new branch "new"
  $ git for-each-ref --format='%(refname) %(tracking)'
  refs/heads/master
  refs/heads/new refs/heads/master

So it will point either to something in refs/remotes or in refs/heads,
as applicable.

> If we hook it up into git-branch there would be to useful directions:

The difference being that git-branch is porcelain and git-for-each-ref
is plumbing. So they really serve different purposes.

> - "git branch --follows foo" could list all branches which follow foo,
> analogous to --contains. It gives you all your feature work on top of
> foo, all branches affected by rebasing foo etc.

Sure, that would probably be useful.

> - "git branch --whatever foo" could list the branch whoch foo follows.
> 
> I just notices that "git branch -v foo" does not give me the "-v" output
> for foo... Improving that would open up the possibility to go for -vv foo.

See the "-vv" patch I just posted elsewhere in the thread.

-Peff
