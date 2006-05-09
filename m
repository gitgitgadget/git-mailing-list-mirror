From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-feed-mail-list.sh
Date: Mon, 8 May 2006 20:06:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605081951390.3718@g5.osdl.org>
References: <1146678513.20773.45.camel@pmac.infradead.org>
 <7vmzdy9zl2.fsf@assigned-by-dhcp.cox.net> <1147131877.2694.37.camel@shinybook.infradead.org>
 <Pine.LNX.4.64.0605081715270.3718@g5.osdl.org>
 <4fb292fa0605081755m22e8239cjda0b1ac74b84c0d9@mail.gmail.com>
 <7vac9sc8m3.fsf@assigned-by-dhcp.cox.net> <4fb292fa0605081809r6aa76baai5eac9823183fc3fc@mail.gmail.com>
 <7vwtcvc42s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bertrand Jacquin <beber.mailing@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 05:06:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdIYj-000481-4l
	for gcvg-git@gmane.org; Tue, 09 May 2006 05:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWEIDGm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 23:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWEIDGm
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 23:06:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38048 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751346AbWEIDGl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 May 2006 23:06:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4936atH013002
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 8 May 2006 20:06:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4936ZtG029569;
	Mon, 8 May 2006 20:06:36 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtcvc42s.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19811>



On Mon, 8 May 2006, Junio C Hamano wrote:

> "Bertrand Jacquin" <beber.mailing@gmail.com> writes:
> 
> > But I would like to send an email after merge to inform people that:
> >
> > o tree ``a'' and ``b'' have been merged.
> > o made by John Doe at a time
> > o show a diffstat.
> > o show a --short-log=oneline from merge base.
> 
> Forgetting about a fast-forward merge,  (1) and (2) are
> available in the commit header and the commit log, so is (4) if
> you enable merge.summary configuration like Linus does in his
> kernel repository.

NOTE! Please don't enable "merge.summary" if you ever merge from the 
upstream tree. That just looks ugly. Your merge messages will be just 
filled with crap that has nothing to do with your tree - and everything to 
do with all the _unrelated_ normal development that happened in the tree.

So in general, "merge.summary" makes sense only for trees that pull from 
downstreams, and never merge with anything upstream. My tree obviously 
does that for the kernel. Think of it as a "top-level maintainer" flag, 
although it works find also for sub-maintainers as long as they 
synchronize upwards _purely_ by being pulled from, not by pulling.

But if you want to get it for any random merges, you can always just do

	git log -11 --pretty=oneline ^$commit^ $commit^@ |
		sed 's/[0-9a-f]* // ; 11 s/.*/\.\.\./' 

which will show up to the ten first commits that were merged (and turn the 
eleventh one, if it exists, into "..." - that's a pretty disgusting trick 
to make it show when you left things out).

That "^$commit^ $commit^@" part is important. It may look like some 
deranged git smiley, but it does exactly what you want it to do: take all 
the parents of the commit, but ignore any commit reachable from the first 
one (the "mainline" of the person who did the commit).

The ^@ syntax is obviously pretty new, so it requires a modern git.

		Linus
