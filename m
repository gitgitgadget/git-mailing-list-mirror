From: bdowning@lavos.net (Brian Downing)
Subject: Re: Some git performance measurements..
Date: Sat, 8 Dec 2007 17:04:03 -0600
Message-ID: <20071208230402.GK6212@lavos.net>
References: <finmvm$da8$1@ger.gmane.org> <alpine.LFD.0.9999.0711291812530.8458@woody.linux-foundation.org> <alpine.LFD.0.99999.0711292131350.9605@xanadu.home> <B161871F-E812-44B4-A699-44341B5783D3@zib.de> <e2b179460712070535x2eb10710s75a581664139e0cf@mail.gmail.com> <Pine.LNX.4.64.0712071348100.27959@racer.site> <e2b179460712070809r4127dc0br8dc20f55b1076501@mail.gmail.com> <Pine.LNX.4.64.0712071816100.27959@racer.site> <e2b179460712071115k369dddcatb0f6456d0028acbb@mail.gmail.com> <Pine.LNX.4.64.0712081103430.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 09 00:06:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J18ik-0000fS-Mb
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 00:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668AbXLHXEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 18:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752711AbXLHXEI
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 18:04:08 -0500
Received: from mxsf08.insightbb.com ([74.128.0.78]:18304 "EHLO
	mxsf08.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbXLHXEH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 18:04:07 -0500
X-IronPort-AV: E=Sophos;i="4.23,271,1194238800"; 
   d="scan'208";a="161744298"
Received: from unknown (HELO asav01.insightbb.com) ([172.31.249.124])
  by mxsf08.insightbb.com with ESMTP; 08 Dec 2007 18:04:06 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aq4HAHKxWkdKhvkY/2dsb2JhbACBWg
X-IronPort-AV: E=Sophos;i="4.23,271,1194238800"; 
   d="scan'208";a="99943006"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav01.insightbb.com with ESMTP; 08 Dec 2007 18:04:03 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 2E742309F21; Sat,  8 Dec 2007 17:04:03 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0712081103430.27959@racer.site>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67576>

On Sat, Dec 08, 2007 at 11:05:35AM +0000, Johannes Schindelin wrote:
> On Fri, 7 Dec 2007, Mike Ralphson wrote:
> > I've just tried the mergesort implementation as used in msysgit and that 
> > performs faster for me. It's simpler, and compatibly licensed. It looks 
> > good.
> 
> Now I'm confused.  You said you tested qsortG, NetBSD qsort and qlibc, 
> with glibc performing the slowest.  Now, 4msysgit's implementation is 
> based on glibc (Thanks Brian!), so I wonder if you could redo the 
> performance tests and say if qsortG still is substantially faster than 
> 4msysgit's qsort?

This is just me guessing, but when he said:

> I benchmarked 3 alternative qsorts, qsortG [2] was the fastest on my
> system but has funky licensing, the NetBSD qsort was middle-range and
> the glibc one the slowest of the three (but that could be due to it
> being tuned for a "Sun 4/260"). All of them show over 100x speed
> improvements on a git-status of my main repo (104s -> ~0.7s)

It's possible he tried glibc's actual quicksort implementation, rather
than their "qsort."  Their qsort basically has the following behavior:

if size < 1024
    mergesort with temporary array on stack
if allocating size bytes would likely cause swapping
    quicksort in place
else
    mergesort with temporary array in heap

I removed the "quicksort in place" possibility, as it would have added
another sort algorithm and I had no way to easily determine whether
"allocating size bytes would likely cause swapping."

-bcd
