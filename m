From: Sean <seanlkml@sympatico.ca>
Subject: Re: Problem with bisect
Date: Mon, 6 Aug 2007 14:12:33 -0400
Message-ID: <20070806141233.3d8a43cc.seanlkml@sympatico.ca>
References: <46B5F48D.7020907@lwfinger.net>
	<20070805145234.554bf671.seanlkml@sympatico.ca>
	<46B623D6.7070809@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Larry Finger <larry.finger@lwfinger.net>
X-From: git-owner@vger.kernel.org Mon Aug 06 20:13:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II74g-0006sx-Mk
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 20:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757346AbXHFSMv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 14:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757001AbXHFSMv
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 14:12:51 -0400
Received: from bay0-omc2-s36.bay0.hotmail.com ([65.54.246.172]:63095 "EHLO
	bay0-omc2-s36.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757216AbXHFSMu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Aug 2007 14:12:50 -0400
Received: from bayc1-pasmtp06.bayc1.hotmail.com ([65.54.191.166]) by bay0-omc2-s36.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Mon, 6 Aug 2007 11:12:49 -0700
X-Originating-IP: [64.231.205.174]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([64.231.205.174]) by bayc1-pasmtp06.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Mon, 6 Aug 2007 11:13:37 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1 with smtp (Exim 4.43)
	id 1II74R-0003d5-KC; Mon, 06 Aug 2007 14:12:47 -0400
In-Reply-To: <46B623D6.7070809@lwfinger.net>
X-Mailer: Sylpheed 2.4.2 (GTK+ 2.10.13; i686-pc-linux-gnu)
X-OriginalArrivalTime: 06 Aug 2007 18:13:37.0843 (UTC) FILETIME=[829C0030:01C7D855]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55163>

On Sun, 05 Aug 2007 14:24:06 -0500
Larry Finger <larry.finger@lwfinger.net> wrote:

> Sean wrote:
> > On Sun, 05 Aug 2007 11:02:21 -0500
> > Larry Finger <Larry.Finger@lwfinger.net> wrote:
> > 
> >> I'm helping someone find what looks like a regression in bcm43xx-mac80211 between v2.6.22 and 
> >> v2.6.23-rc1. This driver is not in the mainstream kernel, but is found in John Linville's 
> >> wireless-dev git tree. When we do the first bisection between the current state and v2.6.22, we 
> >> obtain a kernel whose Makefile says it is v2.6.22; however, it's code is based on a state before 
> >> bcm43xx-mac80211 was introduced into this tree. My memory isn't what it used to be, but I think this 
> >> code was put into this tree during 2.6.19 or .20. When I used visualize to see the tree, the bottom 
> >> is all the way to v2.6.16, which I think is the origin of the git process.
> >>
> >> Is this a git bug, or is it some flaw in this particular tree? We have worked around the problem by 
> >> arbitrarily calling each bisection that does not have the bcm43xx-mac80211 code as "good". It has 
> >> been a source of confusion for the guy I'm helping as it is his first bisection. Unfortunately, the 
> >> bug doesn't show on my machine.
> >>
> The git repo is git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-dev.git.
> 
> The commands were:
> 
> git bisect start
> git bisect bad
> git bisect good v2.6.22
> 
> I'm using git version 1.4.4.2.g04509

The directory "drivers/net/wireless/bcm43xx-mac80211" is only introduced in
commit v2.6.23-rc1-1621-gd05daff.   It didn't exist in v2.6.22.

You can see this with the command:

  $ git log -- drivers/net/wireless/bcm43xx-mac80211

Where the last listed commit is d05daff.  So of course there will be many
bisection points back to v2.6.22 where that directory just doesn't exist.
A bit of digging with Git shows this history for most of the files in
that directory:

  renamed in v2.6.23-rc1-1621 as bcm43xx-mac80211
  renamed in v2.6.21-rc1-809 as mac80211
  renamed in v2.6.17-rc2-357 as d80211/bcm43xx
 Imported in v2.6.16-1725 as bcm43xx-d80211

HTH,
Sean
