From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFT] cvsserver: only allow checkout of branches
Date: Thu, 4 Oct 2007 22:49:03 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710042248330.4174@racer.site>
References: <200710031348.50800.wielemak@science.uva.nl>
 <46823.146.50.26.20.1191496739.squirrel@webmail.science.uva.nl>
 <Pine.LNX.4.64.0710041352480.4174@racer.site> <200710041506.13154.wielemak@science.uva.nl>
 <Pine.LNX.4.64.0710041622070.4174@racer.site> <20071004211555.GG31659@planck.djpig.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Thu Oct 04 23:49:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdYZY-0005xZ-0M
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 23:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757571AbXJDVtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 17:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756545AbXJDVtI
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 17:49:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:35400 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757571AbXJDVtG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 17:49:06 -0400
Received: (qmail invoked by alias); 04 Oct 2007 21:49:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp043) with SMTP; 04 Oct 2007 23:49:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+9TLk176W9mB8FNuu2lCxV54kl4hdFp3i71WAkKA
	HBB3RkJ/1vLVDj
X-X-Sender: gene099@racer.site
In-Reply-To: <20071004211555.GG31659@planck.djpig.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60012>

Hi,

On Thu, 4 Oct 2007, Frank Lichtenheld wrote:

> On Thu, Oct 04, 2007 at 04:29:04PM +0100, Johannes Schindelin wrote:
> > diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> > index 13dbd27..869690c 100755
> > --- a/git-cvsserver.perl
> > +++ b/git-cvsserver.perl
> > @@ -770,6 +770,14 @@ sub req_co
> >  
> >      $log->debug("req_co : " . ( defined($data) ? $data : "[NULL]" ) );
> >  
> > +    if( system("git", "rev-parse", "--verify", "refs/heads/$module" ) != 0 )
> > +    {
> > +	$log->warn("Checkout failed: $module is not a branch");
> > +	print "error 1 Checkout failed: $module is not a branch\n";
> > +	chdir "/";
> > +	exit;
> > +    }
> > +
> >      $log->info("Checking out module '$module' ($state->{CVSROOT}) to '$checkout_path'");
> >  
> >      $ENV{GIT_DIR} = $state->{CVSROOT} . "/";
> 
> I've found a problem with the patch. Since git-rev-parse will produce
> output (which will end up at the client and confuse it), we will have to use a fork/exec
> combination instead of system to be able to close STDOUT and STDERR of the child.
> 
> Should I sent a patch on top of this one or as a replacement?

Better a replacement.  Otherwise I have to fly to California with a brown 
paper bag over my HEAD.

Ciao,
Dscho
