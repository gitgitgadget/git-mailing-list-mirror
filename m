From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 00/15] git-note: A mechanisim for providing free-form
 after-the-fact annotations on commits
Date: Tue, 29 May 2007 00:37:42 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705290029420.4648@racer.site>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <200705281840.50814.johan@herland.net> <alpine.LFD.0.98.0705280957070.26602@woody.linux-foundation.org>
 <200705281948.27329.johan@herland.net> <7vwsysbrtg.fsf@assigned-by-dhcp.cox.net>
 <20070528213511.GB7044@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Johan Herland <johan@herland.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 29 01:38:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hsoml-0001sf-W4
	for gcvg-git@gmane.org; Tue, 29 May 2007 01:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685AbXE1Xh5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 19:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752838AbXE1Xh5
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 19:37:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:59528 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752759AbXE1Xh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 19:37:56 -0400
Received: (qmail invoked by alias); 28 May 2007 23:37:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 29 May 2007 01:37:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19sx5pPWcdsNwyUfpsNVVPfHyx4wMqOaX0938kXX8
	3MxhwTnQAovwoy
X-X-Sender: gene099@racer.site
In-Reply-To: <20070528213511.GB7044@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48653>

Hi,

On Mon, 28 May 2007, Shawn O. Pearce wrote:

> Junio C Hamano <junkio@cox.net> wrote:
> > Johan Herland <johan@herland.net> writes:
> > > Ok. But the reverse mapping will help with this, won't it?
> > > We'll look up the interesting commits and find their associated
> > > note objects directly.
> > 
> > The issue Linus brought up worries me, too.
> > 
> > The "efficient reverse mapping" is still handwaving at this
> > stage.  What it needs to do is an equivalent to your
> > implementation with "refs/notes/<a dir per commit>/<note>".  The
> > "efficient" one might do a flat file that says "notee note" per
> > line sorted by notee, or it might use BDB or sqlite, but the
> > amount of the data and complexity of the look-up is really the
> > same.  A handful notes per each commit in the history (I think
> > Linus's "Acked-by after the fact" example a very sensible thing
> > to want from this subsystem).
> 
> Please, don't use BDB or sqllite.  I really don't trust either.
> I've lost data to both.  I've *never* lost data to a Git packfile.
> ;-)

Also, there is the question of dependencies. We don't have to repeat SVN's 
errors.

As for sqllite: the only reason I was _not_ horrified when I realized that 
cvsserver needs sqllite was that it is not really important for the 
common user.

> I'm actually thinking pack v4.  OK, I know its just a virtual hand
> waving thing still, but there's really no reason Nico and I cannot
> get the damn thing finished before we both wind up buying the farm.

Maybe I am missing something important here, but I think we do not at all 
need a generic database here. Just a key/value store.

As it happens, we already have such a beast. It is called object store 
here.

Now, the only reason we cannot do something like "SHA-1 ^ 0xff[...]ff" is 
the SHA-1 for the note for that commit, is that you could possibly have 
more than one note for the commit.

Of course, without that restriction, we could reuse our object store logic 
for notes.

Side note: the more I think about this notes thing, the more I get 
disgusted by the deep changes we'd have to do just to accomodate for them. 
Are they really worth it? Or would something like a pseudo-branch suffice, 
being one strand of notes (commits), where the second commit parent is 
actually the commit the note is for?

Ciao,
Dscho
