From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a -z option to 'git status' to safely feed shell
 programs with path names
Date: Sat, 17 May 2008 11:14:01 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805171109000.30431@racer>
References: <20080517023340.GG10006@kali.thurne.chezwam.org> <20080517025133.GQ29038@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sebastien Gross <seb-git@chezwam.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat May 17 12:15:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxJRX-0000hg-Kx
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 12:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634AbYEQKN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 06:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752679AbYEQKN5
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 06:13:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:50426 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751742AbYEQKN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 06:13:56 -0400
Received: (qmail invoked by alias); 17 May 2008 10:13:55 -0000
Received: from R06ea.r.pppool.de (EHLO racer.local) [89.54.6.234]
  by mail.gmx.net (mp017) with SMTP; 17 May 2008 12:13:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18I26EgXjcIW0Ma/14FoCjDGHwIZAeiXqN4mu/5Lh
	6vI2X5qZN1fTzA
X-X-Sender: gene099@racer
In-Reply-To: <20080517025133.GQ29038@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82341>

Hi,

On Fri, 16 May 2008, Shawn O. Pearce wrote:

> Sebastien Gross <seb-git@chezwam.org> wrote:
> > Add a -z option to 'git status' to get a list of all files
> > but ignored, starting with modification type or 'untracked'
> > as prefix and ending with '\0'.
> 
> Hmm.  Is the plumbing really that broken that you need to add -z support 
> to porcelain rather than using the -z support already built into the 
> plumbing?

To answer the retorical question: no, it is not.  git ls-files already has 
the "-z" flag, and we even have the scripts in contrib/examples/ to prove 
that it works very fine, thankyouverymuch.

Just as an example: this ugly, long line

git status -z | gawk 'BEGIN{RS="\0"; ORS="\0";}/^untracked/ \
        {sub("^.+:", "");print}' | xargs -0 -r rm

could be expressed like this:

git ls-files --others -z | xargs -0 -r rm

I believe.  If not, this should provide a good starting point, without 
changing Git at all!

> A very large and intrusive looking patch for what can already be 
> obtained easier through existing, stable porcelain.  Not something I am 
> in favor of seeing added at this time.

It is not only intrusive looking.  It is sneaky: it changes git-commit at 
the same time, even if you would not begin to guess from the shortline.

It adds a function that is clearly path-related into quote.c!

And then, the commit message is quite different from the other commit 
messages in git.git, no?

Opposed to the patch,
Dscho
