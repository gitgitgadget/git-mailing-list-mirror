From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Let me ask again: How do we import patches from non-git sources?
Date: Tue, 12 Jun 2007 14:13:13 -0400
Message-ID: <20070612181313.GB26767@fieldses.org>
References: <1180017010.21181.2.camel@zealous.synapsedev.com> <1181151454.6086.23.camel@zealous.synapsedev.com> <20070606175458.GH12774@fieldses.org> <1181665653.4194.24.camel@zealous.synapsedev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Marc Singer <elf@synapse.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 20:13:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyArk-0000j2-VW
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 20:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755675AbXFLSNP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 14:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755299AbXFLSNP
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 14:13:15 -0400
Received: from mail.fieldses.org ([66.93.2.214]:34787 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755205AbXFLSNO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 14:13:14 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HyArh-0000PE-B8; Tue, 12 Jun 2007 14:13:13 -0400
Content-Disposition: inline
In-Reply-To: <1181665653.4194.24.camel@zealous.synapsedev.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49985>

On Tue, Jun 12, 2007 at 09:27:33AM -0700, Marc Singer wrote:
> On Wed, 2007-06-06 at 13:54 -0400, J. Bruce Fields wrote:
> > Based on my notes from the last time I needed to feed a bunch of
> > non-mbox, non-git-produced patches into git-am, the hard part was
> > figuring out how it split a file into separate messages; my notes say:
> > 
> > 	"Finds lines begining with "From " and ending with "hh:mm:ss
> > 	yyyy".  See builtin-mailsplit code for more details."
> > 
> > Other than that, I think it just needs and From: and Subject: lines to
> > get author and first-line of the commit.  the git-am man page has some
> > documentation of this.  It could probably use more.
> > 
> 
> I'm not sure that I understand your response. 
> 
> git-am complains that it cannot find an email address, but raw patches
> seldom have these.  So, either we could use another command, or it would
> be handy if we could supply the email address to git-am (or some other
> data it needs so that it can split the patch.)  I suppose the mistaken
> assumption is that the patch source in an email instead of already being
> a nice clean patch.

I think it's intentional.  You need some standard format git-am can use
to split out the patches and find the comments and the authorship
information (for the Author: field on the commit), so why not just use
something like mbox?

And it could provide some fallback for the "Author:" information in the
case where it didn't find that, but we wouldn't want that to be the
default if it meant risking silently losing authorship information.  I
suppose an "--author" option to git-am might be convenient sometimes.

But personally I always just add those headers by hand (or with a
script).  It's not that hard; I the minimum required is just three
lines, I think:

	From git-owner@vger.kernel.org Tue jun 12 11:43:40 2007
	From: someone <someone@example.com>
	Subject: [PATCH] do something
	
	Do something complicated.
	
	---
	
	diff a/foo b/foo
	...

And often I need different authors on different patches anyway, so
git-am --author wouldn't help.

Of course if you've just got one patch to import, you can git-apply and
then commit.

--b.

(PS: Standard practice around here is to leave people on the To: and/or
Cc: lines when you reply, and for me at least that'd be easier.)
