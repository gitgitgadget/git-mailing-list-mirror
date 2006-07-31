From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git merge (resolve) _is_ stupid
Date: Mon, 31 Jul 2006 13:13:04 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607311307350.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v7j1u88ol.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0607311236070.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v7j1u6nsx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 31 13:13:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7Vi1-00042g-AV
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 13:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWGaLNJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 07:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWGaLNJ
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 07:13:09 -0400
Received: from mail.gmx.net ([213.165.64.21]:36258 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932232AbWGaLNI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jul 2006 07:13:08 -0400
Received: (qmail invoked by alias); 31 Jul 2006 11:13:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 31 Jul 2006 13:13:04 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j1u6nsx.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24514>

Hi,

On Mon, 31 Jul 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > The culprit is the call to parse_commit() in merge_bases(). How about 
> > this?
> 
> Do you mean merge_bases() in commit.c which is called by
> get_merge_bases()?

Yes, the same.

> If so the patch feels like papering over a more grave bug -- the result 
> from make_virtual_commit does not seem to have any proper parent 
> information, so how is merge_bases() expected to return anything 
> sensible?

It is not a grave bug, but very much by design: remember, a recursive 
merge means that if you have more than one merge base, then the merge 
bases are merged first. And the result is -- tada -- a virtual commit.

It does have (virtual) parents, but we do _not_ want to traverse them in 
merge_bases().

However, they have (virtual) children, and _these_ relationships are 
important: in your case (I guess) that the merge_bases() finds the 
virtual commit, since (with the virtual history) the other commit 
is just a fast-forward.

So, a virtual commit is something like a merge base combining two or more 
merge bases.

> I am confused, but going to bed first.

I know the feeling ;-)

Ciao,
Dscho
