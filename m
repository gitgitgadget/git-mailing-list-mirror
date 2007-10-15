From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/7] Bisect: factorise "bisect_{bad,good,dunno}" into
 "bisect_state".
Date: Mon, 15 Oct 2007 13:38:53 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710151338000.25221@racer.site>
References: <20071014143003.23ae649f.chriscool@tuxfamily.org>
 <Pine.LNX.4.64.0710141710230.25221@racer.site> <200710150542.17667.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio Hamano <junkio@cox.net>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Oct 15 14:39:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhPDy-0007hb-58
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 14:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758814AbXJOMjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 08:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758804AbXJOMjA
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 08:39:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:59918 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758798AbXJOMi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 08:38:59 -0400
Received: (qmail invoked by alias); 15 Oct 2007 12:38:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp028) with SMTP; 15 Oct 2007 14:38:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+czLghKZCctJRUv1uWcyI0AZifq0efaHyUuEJYuB
	A0fzxtWOAY8mpS
X-X-Sender: gene099@racer.site
In-Reply-To: <200710150542.17667.chriscool@tuxfamily.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60990>

Hi,

On Mon, 15 Oct 2007, Christian Couder wrote:

> Le dimanche 14 octobre 2007, Johannes Schindelin a ?crit :
>
> > On Sun, 14 Oct 2007, Christian Couder wrote:
> > > -bisect_bad() {
> > > +bisect_state() {
> > >  	bisect_autostart
> > > -	case "$#" in
> > > -	0)
> > > -		rev=$(git rev-parse --verify HEAD) ;;
> > > -	1)
> > > -		rev=$(git rev-parse --verify "$1^{commit}") ;;
> > > +	state=$1
> > > +	case "$#,$state" in
> > > +	0,*)
> > > +		die "Please call 'bisect_state' with at least one argument." ;;
> > > +	1,bad|1,good|1,dunno)
> > > +		rev=$(git rev-parse --verify HEAD) ||
> > > +			die "Bad rev input: HEAD"
> > > +		bisect_write "$state" "$rev" ;;
> > > +	2,bad)
> > > +		rev=$(git rev-parse --verify "$2^{commit}") ||
> > > +			die "Bad rev input: $2"
> > > +		bisect_write "$state" "$rev" ;;
> >
> > Really?  As far as I see, "2,bad" is an error in the current bisect.
> 
> But the new "bisect_state" takes one more argument, because the first 
> one must be "good" "bad" or "dunno".
> 
> So when there is only one argument HEAD is used, and when there are 2 
> arguments, $2 is used as the good|bad|dunno rev.

Ah, that explains it!  But do you not need to do "2,bad|2,good|2,dunno" in 
that case?  Or even better: "2,*"?

Thanks,
Dscho
