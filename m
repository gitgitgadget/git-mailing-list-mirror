From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH 4/4] Disallow working directory commands in a bare
 repository.
Date: Tue, 2 Jan 2007 22:42:05 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701022236520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <3ffc8ddd9b500c2a34d2bd6ba147dc750d951bcd.1167539318.git.spearce@spearce.org>
 <20061231043238.GD5823@spearce.org> <7virfsk4sd.fsf@assigned-by-dhcp.cox.net>
 <20061231061122.GB6106@spearce.org> <7vk608fq9u.fsf@assigned-by-dhcp.cox.net>
 <20061231124921.GA14286@thunk.org> <Pine.LNX.4.63.0612311606330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vr6ufeuvf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Theodore Tso <tytso@mit.edu>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 22:42:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1rOf-0006np-Ug
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 22:42:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754950AbXABVmK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 16:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754981AbXABVmK
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 16:42:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:55877 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754966AbXABVmI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 16:42:08 -0500
Received: (qmail invoked by alias); 02 Jan 2007 21:42:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 02 Jan 2007 22:42:07 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr6ufeuvf.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35823>

Hi,

On Sun, 31 Dec 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> While we're talking about potentially deprecating GIT_DIR for users,
> >> out of curiosity, what valid workflows would cause users to want to
> >> use GIT_INDEX_FILE and GIT_OBJECT_DIRECTORY?  Seems like they would
> >> cause more confusion and support problems than anything else.  
> >
> > Easy, guys.
> >
> > It is a valid -- indeed, useful -- thing to be able to script nice 
> > helpers. For example, in one project I track tar balls. So, I wrote a 
> > script which will unpack the tar ball in a directory, build a new index 
> > from it, and commit the corresponding tree on top of the tracking branch. 
> > This setup relies _heavily_ on being able to redirect GIT_INDEX_FILE and 
> > GIT_DIR.
> 
> I do agree INDEX_FILE and OBJECT_DIRECTORY are handy things for
> the user to muck around.  What I am not sure about is GIT_DIR,
> in the sense that I suspect it is not such a pain to do without
> for such a script.

Uhm. In the example I illustrated, I need to set GIT_DIR, because I want 
to commit a new version into a branch of my current repository, but 
without touching the working tree and the index.

Thus, I have to create a temporary directory, unpack the new 
(upstream) version, set GIT_DIR _and_ GIT_INDEX_FILE, do a write-tree and 
a commit-tree with some automatic message, and then update the ref. Yes, I 
could separate the steps, but why make it harder than it needs be?

> > ...  Now, if somebody starts git in a 
> > bare repo, where "index" is present, it could die with a helpful message 
> > like
> >
> > 	It seems that this is a bare git repository, but there is an index 
> > 	file present, which contradicts that assumption. If the repository
> > 	is indeed bare, please remove the index file.
> 
> That is probably worse.  
> 
>  * there is no reason for non working-tree operations such as
>    git-log to fail when you go to a bare repository (or for that
>    matter .git in a repository with a working-tree).  we should
>    not have to error out nor remove the index we will not use.
> 
>  * if you did the above in response to a misguided 'git
>    checkout' in a bare repository, the next error message the
>    user will get will be 'huh?  you are in a bare repository,
>    bozo'.
> 
> So I do not think the helpful message should even be necessary.

Yeah, I meant this message only to appear when you call a program which 
needs a working directory. But I agree that this is probably stupid.

Ciao,
Dscho
