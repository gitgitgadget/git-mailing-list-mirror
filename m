From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/4] merge-one-file: use 'wc' more portably
Date: Thu, 25 Jan 2007 09:35:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701250934380.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0701240213330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v3b60dl24.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jan 25 09:35:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA05K-0006df-Kx
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 09:35:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965710AbXAYIfw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 03:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965711AbXAYIfw
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 03:35:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:54811 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965710AbXAYIfv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 03:35:51 -0500
Received: (qmail invoked by alias); 25 Jan 2007 08:35:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 25 Jan 2007 09:35:50 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v3b60dl24.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37713>

Hi,

On Wed, 24 Jan 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Some wc prefix the number by a tab. Be prepared for this.
> >
> > Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > ---
> >  git-merge-one-file.sh |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
> > index 7d62d79..bc7c5ef 100755
> > --- a/git-merge-one-file.sh
> > +++ b/git-merge-one-file.sh
> > @@ -87,9 +87,9 @@ case "${1:-.}${2:-.}${3:-.}" in
> >  		# This extracts OUR file in $orig, and uses git-apply to
> >  		# remove lines that are unique to ours.
> >  		orig=`git-unpack-file $2`
> > -		sz0=`wc -c <"$orig"`
> > +		sz0=`wc -c <"$orig" | tr -dc 0-9`
> >  		diff -u -La/$orig -Lb/$orig $orig $src2 | git-apply --no-add 
> > -		sz1=`wc -c <"$orig"`
> > +		sz1=`wc -c <"$orig" | tr -dc 0-9`
> >  
> >  		# If we do not have enough common material, it is not
> >  		# worth trying two-file merge using common subsections.
> 
> I would prefer losing dq around the $sz0 and $sz1 where they are
> used, instead of spawning tr here, and also tighten error
> checking by stringing these command sequence with && followed by
> a || exit.

I only needed a quick fix to make it work on my machine. The fact that it 
was broken for so long, unnoticed by me, shows that this code path was 
rarely -- if at all -- used.

But since I want it builtin, I don't want to spend time on the script...

Ciao,
Dscho
