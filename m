From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] checkout: implement "-" shortcut name for last branch
Date: Fri, 16 Jan 2009 12:18:48 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901161213370.3586@pacific.mpi-cbg.de>
References: <1231977976-8739-1-git-send-email-trast@student.ethz.ch> <200901151501.26394.trast@student.ethz.ch> <alpine.DEB.1.00.0901151510340.3586@pacific.mpi-cbg.de> <200901161008.16234.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jan 16 12:19:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNmjV-00032O-7I
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 12:19:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762372AbZAPLR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 06:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761795AbZAPLRz
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 06:17:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:49398 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757956AbZAPLRy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 06:17:54 -0500
Received: (qmail invoked by alias); 16 Jan 2009 11:17:52 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp052) with SMTP; 16 Jan 2009 12:17:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/V3Kg0P6LVTFpPdBe3ZTGVgd1TJS5TvKzIyf18cf
	dVIswr4kvzSn3x
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200901161008.16234.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105937>

Hi,

On Fri, 16 Jan 2009, Thomas Rast wrote:

> search_reflog () {
> 	next=
> 	git reflog show HEAD |
> 	while read sha ref msg; do
> 		if test -n "$next"; then
> 			next=
> 			echo ${sha%...}
> 		fi
> 		if echo "$msg" | grep -q "^checkout: moving from $branch "; then
> 			next=t
> 		fi
> 		if echo "$msg" | grep -q "^merge $branch:"; then
> 			git rev-list --parents -1 ${sha%...} \
> 				| cut -d' ' -f3
> 		fi
> 	done
> }

How about this instead:

search_reflog () {
	sed -n 's/\([^ ]*\) .*\tcheckout: moving from $branch .*/\1/p' \
		< .git/logs/HEAD
}

Of course, this leaves out the merges...  but I'd make that a command line 
option anyway: would you like to resurrect a branch that you recently were 
on, or one that you recently merged, or one that was merged by someone 
else?

Ciao,
Dscho
