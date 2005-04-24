From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: git pull on ia64 linux tree
Date: Sun, 24 Apr 2005 06:02:46 +0100
Message-ID: <E1DPZGY-0000VJ-00@skye.ra.phy.cam.ac.uk>
References: <Pine.LNX.4.58.0504221521260.2344@ppc970.osdl.org>
Cc: tony.luck@intel.com, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 06:58:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPZC3-0007lM-TV
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 06:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbVDXFCw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 01:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbVDXFCw
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 01:02:52 -0400
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:46814 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262255AbVDXFCu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 01:02:50 -0400
Received: from skye.ra.phy.cam.ac.uk ([131.111.48.158] ident=mail)
	by mraos.ra.phy.cam.ac.uk with esmtp (Exim 4.43)
	id 1DPZGY-0002pb-AF; Sun, 24 Apr 2005 06:02:46 +0100
Received: from sanjoy by skye.ra.phy.cam.ac.uk with local (Exim 3.35 #1)
	id 1DPZGY-0000VJ-00; Sun, 24 Apr 2005 06:02:46 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: Your message of "Fri, 22 Apr 2005 15:34:32 PDT."
             <Pine.LNX.4.58.0504221521260.2344@ppc970.osdl.org> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> I think it would be nice to use the TZ data to show the thing in the
> timezone of the committer, though. Dunno how to do that, maybe
> something like
>	TZ=$tz date -d "1970-01-01 + $sec sec"
> Sadly, it looks like "date" doesn't understand timezone syntax like
> that

Try:

negzone=`echo $tz | tr '[-]+' '+-'`
date -u -R -d "1970-01-01 $negzone + $sec sec" | sed "s/+0000/$tz/"

Or as a script:

#!/bin/bash
# usage: show-date.sh <utcseconds> <zone>
negzone=`echo $2 | tr '[-]+' '+-'`
date -u -R -d "1970-01-01 $negzone + $1 sec" | sed "s/+0000/$2/"

A simple test:

$ show-date.sh 10 +0200
Thu, 01 Jan 1970 02:00:10 +0200

Negating the timezone is an ugly workaround for date not understanding
a sensible TZ format.  I almost always use -u with date, otherwise I
get confused about what timezone it is using to interpret and to print
the date.

-Sanjoy
