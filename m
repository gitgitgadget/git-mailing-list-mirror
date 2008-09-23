From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Locking binary files
Date: Tue, 23 Sep 2008 18:29:53 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0809231811560.19665@iabervon.org>
References: <94c1db200809222333q4953a6b9g8ce0c1cd4b8f5eb4@mail.gmail.com> <94c1db200809222339t7d65081eq7471fef86fb5ec73@mail.gmail.com> <48D8983C.7070506@op5.se> <94c1db200809230054t20e7e61dh5022966d4112eee6@mail.gmail.com> <48D8A97E.8070003@op5.se>
 <94c1db200809230656q4a9a765dw2354c0058b1d940c@mail.gmail.com> <alpine.LNX.1.00.0809231216350.19665@iabervon.org> <7v7i92tzgb.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0809231551320.19665@iabervon.org> <20080923215422.GV21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Mario Pareja <mpareja.dev@gmail.com>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 00:31:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiGPR-0004vT-1R
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 00:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbYIWW3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 18:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbYIWW3z
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 18:29:55 -0400
Received: from iabervon.org ([66.92.72.58]:48552 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990AbYIWW3y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 18:29:54 -0400
Received: (qmail 12014 invoked by uid 1000); 23 Sep 2008 22:29:53 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Sep 2008 22:29:53 -0000
In-Reply-To: <20080923215422.GV21650@dpotapov.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96608>

On Wed, 24 Sep 2008, Dmitry Potapov wrote:

> On Tue, Sep 23, 2008 at 05:13:29PM -0400, Daniel Barkalow wrote:
> > 
> > The lock needs to last until you push to the repository the lock is for; 
> > otherwise you have the exclusive ability to make changes, but someone who 
> > grabs the lock right after you release it will still be working on the 
> > version without your change, which is what the lock is supposed to 
> > prevent.
> 
> It still will happen if developers work on topic branches, and it is not
> a rate situation with Git. Thus locking some particular path is stupid.
> What you may want instead is too mark SHA-1 of this file as being edited
> and later maybe as being replaced with another one. In this case, anyone
> who has the access to the central information storage will get warning
> about attempt to edit a file that is edited or already replaced with a
> new version.

No, your goal is to avoid having to do a merge in order to do a particular 
push. That push is the push to the shared location. It doesn't matter if 
you use topic branches, because your eventual goal is still to push to the 
shared location (or, possibly, to have the project maintainer push to the 
shared location with some sort of interesting delegation), so you lock the 
shared location, not your topic branch.

On the other hand, it's easily possible that other people (or you) want to 
fork the image, such that only some locations (either different paths in 
the project or the same path in different branches) get your change and 
other branches get different changes made at the same time. Of course, if 
you want to change multiple things, you need to get multiple locks.

	-Daniel
*This .sig left intentionally blank*
