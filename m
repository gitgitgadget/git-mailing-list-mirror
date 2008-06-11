From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] git-sequencer.txt
Date: Wed, 11 Jun 2008 13:07:55 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806111246000.19665@iabervon.org>
References: <20080607220101.GM31040@leksak.fem-net> <m3d4mqwnxh.fsf@localhost.localdomain> <20080610012159.GI8079@leksak.fem-net> <200806100646.36528.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-595739305-1213204075=:19665"
Cc: Stephan Beyer <s-beyer@gmx.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Joerg Sommer <joerg@alea.gnuu.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 19:08:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Tod-00023A-Ke
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 19:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350AbYFKRH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 13:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760205AbYFKRH5
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 13:07:57 -0400
Received: from iabervon.org ([66.92.72.58]:59011 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339AbYFKRH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 13:07:56 -0400
Received: (qmail 1362 invoked by uid 1000); 11 Jun 2008 17:07:55 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Jun 2008 17:07:55 -0000
In-Reply-To: <200806100646.36528.chriscool@tuxfamily.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84624>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-595739305-1213204075=:19665
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 10 Jun 2008, Christian Couder wrote:

> Le mardi 10 juin 2008, Stephan Beyer a écrit :

> > But it leads me to an open question I've also noticed on testing:
> >
> > If you currently start a rebase or am and there's a conflict and
> > you do
> > 	git sequencer --continue
> > instead of
> > 	git rebase --continue
> > or
> > 	git am --resolved
> > the cleanup code of rebase/am is not executed and thus the job is not
> > properly finished.
> >
> > How to prevent this?
> > My first idea is the one I don't really like: the user tools temporarily
> > generate some "post-sequencer scripts", that get executed after
> > finished sequencing. This way, it doesn't matter if you call git
> > sequencer --continue, git rebase --continue or git am --resolved to
> > finish the job.
> >
> > The second idea is that somehow the user tool should set a "CALLER"
> > environment variable or tell the caller otherwise (--caller=rebase?)
> > and git-sequencer only continues if called by the same caller.
> 
> Maybe the sequencer can look at the filename it is passed.
> If it is something like "$GIT_DIR/*/git-rebase--interactive-todo" that can 
> mean it is called by "git rebase --interactive".
> 
> And then maybe when "git sequencer --continue" is called interactively, it 
> can say something like:
> 
> "This sequencer run was started by 'git rebase --interactive' please 
> continue using 'git rebase --continue'."

I expect that most script users will do something like:

  generate-todo-file | git-sequencer

So, if there's anything to do to clean up after the outer script, the file 
git-sequencer gets is probably stdin.

One solution would be to have a "caller" option to sequencer, and when 
sequencer finishes, it runs "git $caller --cleanup". That way, you can use 
"git sequencer --continue", and it will do the caller-specific cleanup 
(also, don't forget the --abort case).

It might also be good to have options for some generic stuff, like "remove 
a particular directory" for callers that can just put all their temporary 
stuff in a single directory and don't have anything to clean up other than 
getting rid of it.

	-Daniel
*This .sig left intentionally blank*
--1547844168-595739305-1213204075=:19665--
