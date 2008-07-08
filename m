From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008
	projects?
Date: Tue, 8 Jul 2008 16:42:39 +0200
Message-ID: <20080708144239.GJ6726@leksak.fem-net>
References: <200807080227.43515.jnareb@gmail.com> <7vmyktxjlq.fsf@gitster.siamese.dyndns.org> <20080708014734.GE6726@leksak.fem-net> <200807080939.31216.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 16:44:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGEQC-0002Cn-51
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 16:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757150AbYGHOmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 10:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757127AbYGHOmt
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 10:42:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:38851 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757070AbYGHOms (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 10:42:48 -0400
Received: (qmail invoked by alias); 08 Jul 2008 14:42:46 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp050) with SMTP; 08 Jul 2008 16:42:46 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+yoOcRfV6yrPxFGhLPcTXzfPXifaCovjOZgU9QSo
	hVcOPRykN+P+02
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KGEOt-0000ku-A8; Tue, 08 Jul 2008 16:42:39 +0200
Content-Disposition: inline
In-Reply-To: <200807080939.31216.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87767>

Hi,

Jakub Narebski wrote:
> > Yes, you are right that am --rebasing is a no-op.
> > That option was a little mystery to me, because it seemed to do nothing
> > special, but I'll check again (bash-completion etc) and do appropriate
> > changes.
> 
> Undocumented option '--rebasing' to git-am is internal option changing
> git-am behavior to be better used by git-rebase, namely it does not
> change commit message even if it doesn't follow git commit message
> convention,

Ah yes, I've seen it now.
It is taking the commit message from the commit in the "From <commit> .*"
line, does *not* change it in any way and then applies the changes using
threeway merge.

Keeping that in mind what about dealing with --rebasing like that:
if --rebasing is given, git am simply generates
	pick <commit>
lines, instead of
	patch -3 -k <msg>
as it is now (and this is not enough, as it seems).

Does someone have strong objections against that?

Speed could be one point in the case that git-apply just works without
needing threeway-fallback, but in the case of the fallback this will be
slower than pick, I think. So I'd not value that too high, but perhaps
there are opinions against my view.
Perhaps I am missing another point, too?


The alternative for doing "pick" is teaching git-sequencer's "patch"
insn an option that emulates the --rebasing behavior.

For me this feels somehow unclean. But perhaps there are good reasons.

> for example if it begins not with single line summary
> of commit, separated by empty line, but by multi-line paragraph.
> See also t/t3405-rebase-malformed.sh

Well, I have a test script that runs
 for i in t0023* t3350* t340* t3901* t4014* t4150* t5520* t7402*
and I run that script before I do a commit and after I rebased.
And I ran the whole test suite before I posted the patchset to the list.
What I want to say is: t3405 did not fail with my --rebasing no-op.

That's perhaps one reason why I forgot about implementing --rebasing
correctly.

> Although I am not sure if when rebase is rewritten using git-sequencer
> implementing "git am --rebasing" would be truly needed.

I didn't want to touch that behavior for several reasons.

Of course, somehow I think that rebase and rebase-i should be merged,
calling sequencer directly, with the main difference that -i will
invoke an editor to allow editing of the TODO file.
But nobody is hurt, if I put such a change far far away.


Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
