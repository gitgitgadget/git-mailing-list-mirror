From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: Rebasing a merged branch
Date: Sat, 10 Jul 2010 09:19:55 +0200
Message-ID: <20100710071955.GA12251@m62s10.vlinux.de>
References: <alpine.DEB.2.00.1007081247410.18908@ds9.cixit.se>
 <20100710065541.GB15600@foursquare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: Chris Frey <cdfrey@foursquare.net>
X-From: git-owner@vger.kernel.org Sat Jul 10 09:20:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXUM2-0003YW-UZ
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 09:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856Ab0GJHUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jul 2010 03:20:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:33801 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751697Ab0GJHT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jul 2010 03:19:59 -0400
Received: (qmail invoked by alias); 10 Jul 2010 07:19:57 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp065) with SMTP; 10 Jul 2010 09:19:57 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1+0yu8sYHO0ck6fwZSEiLLaFllwUyMDP9BaXwVlK9
	9uPEvOVExAwqz/
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id AECF2DC5B0; Sat, 10 Jul 2010 09:19:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100710065541.GB15600@foursquare.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150714>

On Sat, Jul 10, 2010 at 02:55:41AM -0400, Chris Frey wrote:
> On Thu, Jul 08, 2010 at 12:52:08PM +0100, Peter Krefting wrote:
> > Hi!
> > 
> > If I slightly modify the example from the git-rebase manual page to look 
> > like this:
> > 
> >   o---o---o---o  master
> >          \
> >           o---o---o---o---o  topicA
> >            \     /
> >             A---B---C---D  topicB
> > 
> > (topicA has merged "B" into its history; its first-parent from the line of 
> > "o"s).
> > 
> > If I now do a "git rebase --onto master topicA topicB", I only get commit C 
> > and D, as it sees A and B as being part of both branches.
> > 
> > Is there a way to make git rebase pick up A, B, C and D (and only them)?
> > 
> > I.e., I would like "all commits on topicB which are not in topicA's 
> > --first-parent history".
> 
> 
> I'm no expert on rebase --onto, but aren't you trying to rebase so that
> the tree looks like this afterward?
> 
> 
>    o---o---o---o  master
>             \   \
>              \   A---B---C---D  topicB
>               \
>                o---o---o---o---o  topicA
>                 \     /
>                  A---B
>  
> In which case, won't this work?
> 
> 	git checkout topicB
> 	git rebase master
> 
> - Chris

No, this won't work. You will also rebase A^ (the o) commit in both branches
A and B.

AFAIK doing the following should do the trick:

git checkout topicB
git rebase --onto master A~1 topicB
