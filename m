From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Remove useless uses of cat, and replace with filename
 arguments or redirection
Date: Thu, 7 Jun 2007 05:06:32 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706070506230.4046@racer.site>
References: <466639D0.1040306@freedesktop.org> <7vsl94sego.fsf@assigned-by-dhcp.cox.net>
 <46676C35.60406@freedesktop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
X-From: git-owner@vger.kernel.org Thu Jun 07 06:09:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw9JC-0008Pn-R0
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 06:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753875AbXFGEIn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 00:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754125AbXFGEIn
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 00:08:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:35152 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753875AbXFGEIn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 00:08:43 -0400
Received: (qmail invoked by alias); 07 Jun 2007 04:08:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 07 Jun 2007 06:08:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/dke0P/KXdyZmVmTwHmlEzIM1DfomNWjpOWYJ3LA
	rsgii5jujEU1Kh
X-X-Sender: gene099@racer.site
In-Reply-To: <46676C35.60406@freedesktop.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49347>

Hi,

On Wed, 6 Jun 2007, Josh Triplett wrote:

> Junio C Hamano wrote:
> > Josh Triplett <josh@freedesktop.org> writes:
> >> Replace all uses of cat that do nothing other than read a single file.  In the
> >> case of git-quilt-import, this occurs once per patch.
> >>
> >> Signed-off-by: Josh Triplett <josh@freedesktop.org>
> >> ---
> >>
> >> This revised version fixes a bug caught by Stephen Rothwell: the output of wc
> >> -l changes when it has a filename on the command line.  The same bug occurred
> >> in one other place as well.
> > 
> > Hmph...
> > 
> >> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> >> index 0c8a7df..346cf3f 100644
> >> --- a/git-filter-branch.sh
> >> +++ b/git-filter-branch.sh
> >> @@ -333,7 +333,7 @@ for commit in $unchanged; do
> >>  done
> >>  
> >>  git-rev-list --reverse --topo-order $srcbranch --not $unchanged >../revs
> >> -commits=$(cat ../revs | wc -l | tr -d " ")
> >> +commits=$(wc -l ../revs | tr -d -c 0-9)
> > 
> > ... and left unfixed ;-)?
> 
> No, just fixed differently. :) Note the change to the tr invocation: delete
> everything other than digits.

Actually, it feels wrong. For example, if some wc some day decides to 
display the size in kilobyte, even if you say "-l", it would fail badly. 
That is, it would fail to function properly, but would not tell you that 
it failed.

Things like that are known to happen, and that's why "wc -l < file" is a 
better fix than "wc -l file | tr -dc 0-9". In this case, it might not 
matter for a long time, but why not stop being sloppy here and now?

Ciao,
Dscho
