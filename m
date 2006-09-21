From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] add receive.denyNonFastforwards config variable
Date: Thu, 21 Sep 2006 11:08:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609211103130.19042@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0609210027430.19042@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfyemf9ah.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0609210107140.19042@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vlkoeds82.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0609210211570.19042@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060921055252.GA29479@coredump.intra.peff.net> <7vbqp9d8j2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 11:08:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQKXl-0000MB-Fc
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 11:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWIUJIG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 05:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWIUJIG
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 05:08:06 -0400
Received: from mail.gmx.de ([213.165.64.20]:9917 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751064AbWIUJIF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Sep 2006 05:08:05 -0400
Received: (qmail invoked by alias); 21 Sep 2006 09:08:03 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 21 Sep 2006 11:08:03 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqp9d8j2.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27468>

Hi,

On Wed, 20 Sep 2006, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >>     X - a - b - c - Y
> >>   /           /
> >> o - d - e - f
> >
> > In your example, git-merge-base X Y returns X. In fact, I could only get
> > one merge base out of git-merge-base --all. I tried looking in the tests
> > to find a case that produced multiple merge bases, but I was unable to
> > find one. Is there an example floating around somewhere?
> 
> There are quite a few in git.git itself.  In the recent history,
> this counts 42, the answer to everything.
> 
> #!/bin/sh
> LF='
> '
> git rev-list --parents master..next |
> while read it p1 p2 octo
> do
> 	case "$p2" in '') continue ;; esac
>         mb=`git merge-base --all "$p1" "$p2"`

At this point you should also check if $p2 is in $mb.

> 	case "$mb" in ?*"$LF"?*) echo "$p1 $p2" : $mb ;;
>         esac
> done

The question was, if there is a fast-forward with more than one merge 
base, i.e. if the loop we jump^H^H^H^Hdo over bases is necessary.

And no, I am not aware of any such example.

Probably because X would mark all ancestors (_including_ all other 
possible merge bases) as uninteresting.

Therefore, I am convinced that there is no fast-forward returning more 
than one merge base. It is technically impossible. And thus, our loop is 
not necessary, but what the heck.

Ciao,
Dscho
