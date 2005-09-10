From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-bisect failure
Date: Sat, 10 Sep 2005 12:07:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509101202070.30958@g5.osdl.org>
References: <20050909011034.12f2bf64.akpm@osdl.org> <7virx9ir3a.fsf@assigned-by-dhcp.cox.net>
 <20050910022638.20832803.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 10 21:09:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEAhk-0006h9-8D
	for gcvg-git@gmane.org; Sat, 10 Sep 2005 21:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVIJTH5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Sep 2005 15:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbVIJTH5
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Sep 2005 15:07:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47554 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750732AbVIJTH5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Sep 2005 15:07:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8AJ7pBo024798
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 10 Sep 2005 12:07:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8AJ7leN029758;
	Sat, 10 Sep 2005 12:07:49 -0700
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050910022638.20832803.akpm@osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8260>



On Sat, 10 Sep 2005, Andrew Morton wrote:
>
> Junio C Hamano <junkio@cox.net> wrote:
> >
> > So it _might_
> >  be possible that you said "current LDT" was bad when it was
> >  actually good.  That is one possible explanation.
> 
> I agree.  Mea culpa.  Sorry.

Well, this was actually something I hit when testign bisection too: it 
_is_ very unforgiving of mistakes.

That _may_ be something fundamental (hey, the point of bisection is that
you can get a lot of work done thanks to the log2(n) behaviour, but it
also means that a mistake ends up being easily multiplied). But on the 
other hand, maybe there could be nicer interfaces.

In particular, I suspect that we should save off the sequence of good/bad 
markers, so that it can be more easily re-created. Right now we only track 
the last "bad" marker, and we don't keep track of the order of the ones 
marked good. That's technically _sufficient_ for the job, but maybe we 
should have more of an audit trail.

With an audit trail, people could re-do the bisection if something goes 
wrong. Right now, if you by mistake mark something bad, and you 
immediately realize that it was a mistake, you can't undo it - because the 
old bad state was overwritten.

So the bisection algorithm may have done the right thing from a technical 
standpoint, but I suspect it could be made to be a bit more forgiving, or 
at least when somebody realizes that bisection didn't work right, we could 
have the trail of good/bad markings to try to debug what happened...

		Linus
