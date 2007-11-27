From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Tue, 27 Nov 2007 12:14:07 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711271212360.27959@racer.site>
References: <Pine.LNX.4.64.0711252236350.4725@wbgn129.biozentrum.uni-wuerzburg.de>
 <7vbq9hiz6a.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711261236280.27959@racer.site>
 <7vsl2sgadf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Nov 27 13:14:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwzKj-0005cr-JH
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 13:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752820AbXK0MOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 07:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753283AbXK0MOO
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 07:14:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:55499 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751374AbXK0MON (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 07:14:13 -0500
Received: (qmail invoked by alias); 27 Nov 2007 12:14:11 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp048) with SMTP; 27 Nov 2007 13:14:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX190hkhCTjt0UoLSAvpVrbcR2vyY6vMpI7SjDEC/bl
	S7SBT+lSrBHRhX
X-X-Sender: gene099@racer.site
In-Reply-To: <7vsl2sgadf.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66197>

Hi,

[Shawn Cc'ed, since it affects fast-import]

On Mon, 26 Nov 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sun, 25 Nov 2007, Junio C Hamano wrote:
> >
> >> I am not sure if abort should be the default.
> >
> > I tried to be conservative.
> >
> >> If a straight dump-restore is made without rewriting, the result will 
> >> be identical to the original, right?
> >
> > Yep.
> > ...
> > I agree that for most serious operations sed is not good enough.
> 
> My comment was more about the perception from a new user (not a "new git
> user", but a "new fast-export and fast-import user").
> 
> When you see a command pair foo-export and foo-import, and it is
> advertised that you can pipe them together, a new user would first try a
> straight dump-restore, and would see the warning even though he did not
> do any editing on the stream.
> 
> 	Huh?  Why does a tag signature become invalid because of merely
> 	exporting and then importing?  What is this warning about?

Okay, I did not see that.

> You would explain "yeah in your trial run you did not edit but the
> command pair is to allow you editing the contents in between, and if you
> do that, the object names might change.".
> 
> If the default were "straight copy", then the user will not get an
> invalid signature on his trial run, but will get an invalid signature
> when he rewrites the object stream.  You would get a message on the list
> like this:
> 
> 	Hello, I tried fast-export piped to fast-import so that I can
> 	rewrite my repository, but I am getting invalid signature on
> 	signed tags.  It does not seem to happen if I do not edit but
> 	just use the fast-export output without modification.  What am I
> 	doing wrong?
> 
> And that is the time the explanation first becomes useful.  IOW, you are
> warning at the wrong place.  "It may or may not corrupt the signature, I
> do not know.  Because it depends on what you are going to do with my
> output, I cannot know.  I am warning you anyway to cover my backside".
> 
> I am wondering if fast-import input syntax can be extended to allow
> checking inconsistencies.  A command to import a tag could take an
> additional object name and tell it to warn if the name of the tagged
> object (the one sent with "from:%d\n" part) is different from that
> object name.  At that point, you know the object was rewritten and the
> signature is invalid, and the choice of warning, stripping or aborting
> becomes a useful thing to have.

Why not check by default?  Whenever there is a tag message containing the 
magic BEGIN line, it should check and at least warn if it does not 
match...

Ciao,
Dscho
