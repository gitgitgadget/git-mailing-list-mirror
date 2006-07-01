From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: A note on merging conflicts..
Date: Sun, 2 Jul 2006 01:01:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607020056300.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
 <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
 <20060701150926.GA25800@lsrfire.ath.cx> <7vfyhldvd2.fsf@assigned-by-dhcp.cox.net>
 <44A6CD1D.2000600@lsrfire.ath.cx> <7vzmftcd60.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 01:01:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwoT6-0004wG-0o
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 01:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbWGAXBh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 19:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbWGAXBh
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 19:01:37 -0400
Received: from mail.gmx.de ([213.165.64.21]:49072 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751542AbWGAXBg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Jul 2006 19:01:36 -0400
Received: (qmail invoked by alias); 01 Jul 2006 23:01:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp011) with SMTP; 02 Jul 2006 01:01:34 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmftcd60.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23074>

Hi,

On Sat, 1 Jul 2006, Junio C Hamano wrote:

> Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
> 
> > I wonder why the two clear_commit_marks() calls at the end of
> > get_merge_bases() are not sufficient, though.

I wonder, too. In all of my tests, this call was sufficient to reset the 
marks. I really wonder what happens here. At least one of the three flags 
should be set in _any_ commit get_merge_bases() touches. Help!

> I missed to notice that Johannes had added those calls there; we
> should remove them from get_merge_bases().

As you hinted with your patch in another mail: no, we should not. Stuff 
them into an if(), yes. But the point of a library function is not to make 
it hard on users, but rather to make life easier. The user should _not_ 
have to investigate which loops to jump through to make use of this 
function several times.

> The normal case of git-merge-base calling get_merge_bases() once
> and exiting should NOT have to pay for the clean-up cost at all.

Note that this was partly the reason for my hesitation to propose this 
patch for inclusion already. If you make this function a library function, 
the main user is _not_ git-merge-base any more. Everybody can use it from 
now on.

Ciao,
Dscho

P.S.: I was having to much fun tonight to investigate in detail... Sorry.
