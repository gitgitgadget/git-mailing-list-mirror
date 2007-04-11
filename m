From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] cvsserver: Fix handling of diappeared files on update
Date: Wed, 11 Apr 2007 17:39:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704111737180.27922@iabervon.org>
References: <Pine.LNX.4.64.0704111158220.27922@iabervon.org>
 <11763238991005-git-send-email-frank@lichtenheld.de> <7v1wiqoaph.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org,
	Martin Langhoff <martin@catalyst.net.nz>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 11 23:39:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbkXK-0005ym-EI
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 23:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161221AbXDKVj0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 17:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161223AbXDKVj0
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 17:39:26 -0400
Received: from iabervon.org ([66.92.72.58]:3046 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161221AbXDKVjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 17:39:25 -0400
Received: (qmail 6882 invoked by uid 1000); 11 Apr 2007 21:39:24 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Apr 2007 21:39:24 -0000
In-Reply-To: <7v1wiqoaph.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44260>

On Wed, 11 Apr 2007, Junio C Hamano wrote:

> Frank Lichtenheld <frank@lichtenheld.de> writes:
> 
> > Only send a modified response if the client sent a
> > "Modified" entry. This fixes the case where the
> > file was locally deleted on the client without
> > being removed from CVS. In this case the client
> > will only have sent the Entry for the file but nothing
> > else.
> >
> > Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
> > ---
> >  git-cvsserver.perl |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> >  We really, really need a test suite for cvsserver...
> >  I've tested this as good for regressions as I could
> >  think of but am still unsure about it.
> >
> > diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> > index 68aa752..25816c5 100755
> > --- a/git-cvsserver.perl
> > +++ b/git-cvsserver.perl
> > @@ -843,6 +843,7 @@ sub req_update
> >          if ( defined ( $wrev )
> >               and defined($meta->{revision})
> >               and $wrev == $meta->{revision}
> > +             and defined($state->{entries}{$filename}{modified_hash})
> >               and not exists ( $state->{opt}{C} ) )
> >          {
> >              $log->info("Tell the client the file is modified");
> > -- 
> > 1.5.1
> 
> This would make the modified response go away, but would it
> cause a fresh re-checkout to happen?

It falls through into the appropriate case, evidently. At least, it seems 
to resolve my issue.

	-Daniel
*This .sig left intentionally blank*
