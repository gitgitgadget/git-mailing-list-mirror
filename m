From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git-send-pack: broken handling of ref specs with wildcards
Date: Fri, 8 Jun 2007 14:47:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0706081357420.5848@iabervon.org>
References: <20070607225302.GA10633@steel.home> <Pine.LNX.4.64.0706072356220.4046@racer.site>
 <7v8xavlzu0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 20:47:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwjV3-0005mp-Gb
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 20:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031449AbXFHSru (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 14:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S939235AbXFHSrs
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 14:47:48 -0400
Received: from iabervon.org ([66.92.72.58]:3872 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S939198AbXFHSrr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 14:47:47 -0400
Received: (qmail 2750 invoked by uid 1000); 8 Jun 2007 18:47:46 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Jun 2007 18:47:46 -0000
In-Reply-To: <7v8xavlzu0.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49492>

On Thu, 7 Jun 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Fri, 8 Jun 2007, Alex Riesen wrote:
> >
> >> Try something like this:
> >> 
> >>     git-send-pack --remote=origin --thin /some/other/repo \
> >>     'refs/heads/*:refs/remotes/child/*'
> >> 
> >> The result looks broken: the sent reference are created not in
> >> refs/remotes/child/ but just in refs/heads/ of /some/other/repo.
> >
> > I had the impression that it was git-push, a porcelain, which handles 
> > refspec wildcards, not send-pack, which is plumbing.
> 
> Well, I do not think it is wrong per-se if plumbing send-pack
> starts understanding 'a/*:b/*'.  Earlier it only understood
> concrete refspecs, and such a refspec that has asterisks cannot
> be concrete, as '*' is an invalid char in a refname.  So there
> is no risk of confusion.
> 
> That is, as long as it is done right, which was not true in this
> case.

Good catch; all of my configurations have a {foo}/*:{foo}/* pattern for 
the push, and I hadn't figured out a way to write tests for push and 
fetch.

The code looks like it should do the right thing... now that somebody's 
fixed it before I got to it. You people are far too efficient.

I'll probably break out a function for applying a pattern, since there are 
multiple places that need to do it, but that can go into a series I'm 
working on now.

	-Daniel
*This .sig left intentionally blank*
