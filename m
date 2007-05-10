From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/3] Move remote parsing into a library file out of
 builtin-push.
Date: Thu, 10 May 2007 04:04:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705100355560.18541@iabervon.org>
References: <Pine.LNX.4.64.0705092203130.18541@iabervon.org>
 <7vhcqlma1l.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0705100328260.18541@iabervon.org>
 <7vmz0dktdf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 10 10:04:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm3dL-0003cG-CQ
	for gcvg-git@gmane.org; Thu, 10 May 2007 10:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927AbXEJIEP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 04:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755171AbXEJIEP
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 04:04:15 -0400
Received: from iabervon.org ([66.92.72.58]:4169 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752927AbXEJIEM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 04:04:12 -0400
Received: (qmail 3894 invoked by uid 1000); 10 May 2007 08:04:10 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 May 2007 08:04:10 -0000
In-Reply-To: <7vmz0dktdf.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46843>

On Thu, 10 May 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Thu, 10 May 2007, Junio C Hamano wrote:
> >
> >> This seems to break t9400, with "fatal: bad repository 'gitcvs.git",
> >> upon "git push".
> >> 
> >> : gitster t/db/remote; sh t9400-git-cvsserver-server.sh -i -v
> >> * expecting success: cvs -Q co -d cvswork master &&
> >>    test "$(echo $(grep -v ^D cvswork/CVS/Entries|cut -d/ -f2,3,5))" = "empty/1.1/"
> >> cvs checkout: Updating cvswork
> >> U cvswork/empty
> >> *   ok 1: basic checkout
> >> 
> >> * expecting success: echo testfile1 >testfile1 &&
> >>    git add testfile1 &&
> >>    git commit -q -m "Add testfile1" &&
> >>    git push gitcvs.git >/dev/null &&
> >
> > The man page doesn't think this is valid, since it only claims absolute 
> > paths to work for local repositories.
> 
> Does it?  I suspect we need to fix the manpage then, as it is
> fairly common to do 
> 
> 	$ git fetch ../next-door-neighbour
> 
> and expect the opposite to work as well.
> 
> And I think it does today.

Hmm, and I guess URIs on the command line work the same way. How about 
requiring a '/' somewhere in a repository argument in order to treat it as 
a repository instead of a remote name? Then "../next-door-neighbour" would 
work, "./gitcvs.git" would work (in the odd case where you actually have a 
bare repository sitting in your working directory), but we'd avoid the 
current default of pushing to a bare repository in "./origin/" if nothing 
at all is configured.

	-Daniel
*This .sig left intentionally blank*
