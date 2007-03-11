From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] git-bundle: die if a given ref is not included in
 bundle
Date: Sun, 11 Mar 2007 02:54:22 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703110244130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0703090348300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45F0D1B3.9020204@gmail.com> <7vejny7umx.fsf@assigned-by-dhcp.cox.net>
 <45F17EF0.5060008@gmail.com> <7v1wjy56qf.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703101637300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45F2D955.8050800@gmail.com> <Pine.LNX.4.63.0703101749270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45F2F934.8060407@gmail.com> <Pine.LNX.4.63.0703110201450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vy7m4y3cn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 02:54:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQDGV-0006B2-2z
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 02:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbXCKByY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 20:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbXCKByY
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 20:54:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:36385 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932446AbXCKByX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 20:54:23 -0500
Received: (qmail invoked by alias); 11 Mar 2007 01:54:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 11 Mar 2007 02:54:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+jTqIJBTyjWjT5x/emYYzlw8NziBHSgTiUp8iNbm
	NQqmB2KRfn9vW2
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vy7m4y3cn.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41894>

Hi,

On Sat, 10 Mar 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Basically, I am saying that this whole bundle concept is not thought 
> > through, that it is too loosely defined, and that it will result in 
> > unmet expectations sooner or later. (Which usually means sooner.)
> 
> Earlier I thought you said that bundle had a clearly defined semantics, 
> which I did not quite understand, but now you are agreeing with me...

git-bundle (as is in "next") has clearly defined semantics.

But the bundle concept is not thought through. Obviously, the clearly 
defined semantics of git-bundle do not match what people want to use 
bundles for.

> > So, either we have to rethink how to handle prerequisites (so that 
> > only those are checked which are strictly necessary for _the one_ ref 
> > you are updating), or we have to make it _very_ obvious to (human) 
> > users of git-bundle that you should _not_ bundle two unrelated -- or 
> > only remotely related -- refs into one bundle.
> 
> I've been wondering if we can define prereqs per listed head.

That is a substantial change, and it makes creating a bundle potentially 
very expensive. We would have to find out reachability for every boundary 
commit from each ref.

Granted, we could do that while finding the boundary objects, but we only 
have 28-16 bits left to store from which ref the commit is reachable, 
which means only 12 refs, and if you have more (which is likely when you 
say "--all" and have a reasonable number of tags) you need to allocate a 
bitfield for the remaining refs _for each_ traversed commit's parents.

So I wonder if there is not a better way.

Ciao,
Dscho
