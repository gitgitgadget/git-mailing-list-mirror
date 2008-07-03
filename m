From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: ':/<oneline prefix>' notation doesn't support full file syntax
Date: Thu, 3 Jul 2008 13:38:57 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807031333150.9925@racer>
References: <279b37b20807022242q69ad2fcbwb8c11a9d6165272d@mail.gmail.com>  <7vfxqr2won.fsf@gitster.siamese.dyndns.org> <279b37b20807030150t2e9cbcc8wf099a5872568af8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 14:52:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEOIj-0005Az-8d
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 14:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757271AbYGCMkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 08:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753223AbYGCMkw
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 08:40:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:38114 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757248AbYGCMkv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 08:40:51 -0400
Received: (qmail invoked by alias); 03 Jul 2008 12:40:49 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp062) with SMTP; 03 Jul 2008 14:40:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX190KX5ipJ90TXUQUHvN31oH5gYQ1nUEonTK1HNc3Q
	eNnpsbCk8e7WCQ
X-X-Sender: gene099@racer
In-Reply-To: <279b37b20807030150t2e9cbcc8wf099a5872568af8@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87280>

Hi,

On Thu, 3 Jul 2008, Eric Raible wrote:

> On Thu, Jul 3, 2008 at 1:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > "Eric Raible" <raible@gmail.com> writes:
> >
> > Is there anything to fix?  In that example, you are looking for a 
> > commit that talks about "object name:sha1_name.c" in the comment.
> 
> Yes.  What if I'm looking for specific file (i.e. sha1_name.c) in the 
> commit described by ":/object name:", just like I can do with 
> 28a4d9404:sha1_name.c?
> 
> This is not ambiguous if we first consider the entire string as the 
> prefix. If that fails we look for a filename after the final ':'.

It is super-expensive, as you have to look through the whole history just 
to find that you do not find anything.

And then, it could be that you do find a commit that starts with that 
string, but what you really wanted it a file, not a commit.

And then, a file name can contain colons.  What to do in that case?

I think your "fix" is not worth it.  ":/<oneline>" is to help you find a 
commit, and it will only ever find the first commit anyway, so you are 
probably better off using

	$ git show $(git log --pretty=format:%H:path/to/file.c \
		--grep=^<oneline>)

to begin with.

Really, the only reason I ever wrote support for ":/blah" is when someone 
less-than-helpful says "In commit 'Bla bla bla' you broke XYZ" and I want 
to
	$ git show :/Bla

Nowadays, however, I would

	$ git log -p --grep=^Bla

so I'd vote to remove the ":/" syntax altogether.  We need not even 
concern ourselves with scripts using that syntax, since the semantics are 
so limited that nobody should use it in scripts anyway.

Ciao,
Dscho
