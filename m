From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: branch management
Date: Wed, 10 Jun 2009 10:37:16 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906101026121.6847@localhost.localdomain>
References: <7vfxe9udln.fsf@alter.siamese.dyndns.org> <4A2E0C88.70805@gmail.com> <20090609080612.GG9993@laphroaig.corp> <7viqj5nzgz.fsf@alter.siamese.dyndns.org> <20090609172302.GH9993@laphroaig.corp> <08614AC584A6ED42BD836DE9286376E12A211FA9CA@spswchi6mail1.peak6.net>
 <20090609195018.GA17848@blimp.localdomain> <08614AC584A6ED42BD836DE9286376E12A211FA9D0@spswchi6mail1.peak6.net> <m3d49c40ai.fsf@localhost.localdomain> <alpine.LFD.2.00.0906101118070.31536@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Harry Duin <hduin@optionshouse.com>,
	"'Alex Riesen'" <raa.lkml@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jun 10 19:38:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MERkT-0003Hb-Hl
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 19:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802AbZFJRh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 13:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754674AbZFJRh4
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 13:37:56 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41625 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754208AbZFJRh4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2009 13:37:56 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5AHbH93017159
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Jun 2009 10:37:19 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5AHbGgI025310;
	Wed, 10 Jun 2009 10:37:16 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0906101118070.31536@xanadu.home>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.466 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121288>



On Wed, 10 Jun 2009, Nicolas Pitre wrote:

> On Wed, 10 Jun 2009, Jakub Narebski wrote:
> 
> > Harry Duin <hduin@optionshouse.com> writes:
> > 
> > > 2. show list of files/directories touched by a branch (useful when
> > >    looking for past fixes, but are unsure where the fix was done)
> > 
> > If you can use pickaxe search (git log -S...), or git-blame, or just
> > looking throught "git log ... -- <path>", you can use
> > 
> > $ git rev-list master..branch | 
> >   git diff-tree --stdin -r --name-only |
> >   sort -u
> 
> What I use in that case is simply
> 
> 	git diff --stat master...branch

No, that's not going to work in general. The "master...branch" thing works 
most of the time, but there isn't always a single merge-point, and in the 
case of criss-cross merges, you'll get it wrong.

It will also hide changes that got reverted (or undone some other way), 
which can be relevant.

That said, the "git rev-list | git diff-tree" thing has a new name. We 
call it "git log". 

So what Jakub wrote can generally be written as

	git log --name-only --pretty=format:'' master..branch | sort -u

if you're willing to accept the empty line from all the suppressed commit 
messages (with that "git diff-tree" he'll see all the commit numbers, 
though, so I guess the 'git log' thing is still better)

			Linus
