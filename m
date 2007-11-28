From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Rollback of git commands
Date: Wed, 28 Nov 2007 16:47:22 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711281600320.5349@iabervon.org>
References: <9e4733910711271523p3be94010jac9c79e6b95f010d@mail.gmail.com> 
 <7vmyszb39s.fsf@gitster.siamese.dyndns.org> 
 <9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com> 
 <20071128092234.GA12977@diana.vm.bytemark.co.uk>
 <9e4733910711280713n6b439866m55bea4824efd959@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 22:47:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxUl3-0006TV-3t
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 22:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756949AbXK1VrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 16:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755573AbXK1VrY
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 16:47:24 -0500
Received: from iabervon.org ([66.92.72.58]:52815 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754218AbXK1VrX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 16:47:23 -0500
Received: (qmail 5168 invoked by uid 1000); 28 Nov 2007 21:47:22 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Nov 2007 21:47:22 -0000
In-Reply-To: <9e4733910711280713n6b439866m55bea4824efd959@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66430>

On Wed, 28 Nov 2007, Jon Smirl wrote:

> all my patches applied
> git rebase
> cursing.... I immediately knew what I had done
> update stg and install it
> stg repair
> four of my 15 patches tried to apply, I received messages that there
> were all empty
> most stg commands won't work, they complain that the commit references
> in the stg .git/* state are not correct.
> 
> I then proceed to manually attempt repair.

This sounds like the content of the applied patches got pulled into the 
non-stgit history of the branch it's working on, sort of like a stg commit 
except that stgit didn't know you'd done it. Then cleaning everything up 
from stgit's perspective caused all of those patches to become empty, 
since they were already applied in the base.

I think fundamental issue you're having is that stgit is implementing the 
functionality of quilt using git's engine, not providing a version control 
system for patch series, which is what you really want. I've actually been 
working on a design for a git builtin for the idea that the patch series 
is your work product, and you want to version control that (additionally, 
you want to use git's engine to help with working on the series and 
represent it).

Out of curiousity, are you using stgit as an integrator (with your work 
being keeping a collection of patches produced separately up-to-date) or 
as a patch developer (with your work being producing a state containing a 
single large new feature while maintaining this change as a series of 
self-contained patches)? I've been thinking primarily about the integrator 
task, in part because I've found it easy enough to do the developer task 
without anything other than current git. (That is, "git rebase -i" seems 
to work fine for making changes to a single logical patch series, all of 
whose patches are prepared locally and aren't independantly named in some 
particular fashion; the things that aren't handled are "I need to replace 
the pull of netdev.git with a new pull of netdev.git" or "I need to 
replace '[PATCH] fix-the-frobnozzle-gadget' with 
'[PATCH v2] fix-the-frobnozzle-gadget'.)

The developer assist I'd actually like to see is: "I've got a single 
commit on top of a series of commits on top of an upstream commit; I want 
to distribute the changes made in the final commit to points in the series 
where the code that gets replaced (or context that gets inserted into) in 
the final commit gets introduced, with interactive stuff for sticking 
other hunks into particular commits or into new commits at some point in 
the series." That is, I want to do my revision of a patch series on the 
final commit of the series, and then have these changes distributed to the 
appropriate points, rather than doing work on intermediate states (unless 
what I'm fixing is stub code that gets replaced again in a later patch).

	-Daniel
*This .sig left intentionally blank*
