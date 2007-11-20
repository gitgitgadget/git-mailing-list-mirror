From: carbonated beverage <ramune@net-ronin.org>
Subject: Re: t9106 failure, bisect weirdness
Date: Mon, 19 Nov 2007 22:13:14 -0800
Message-ID: <20071120061314.GA21819@net-ronin.org>
References: <20071119230601.GA15624@net-ronin.org>
 <200711200552.27001.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Nov 20 07:13:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuMMc-0001Tu-8R
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 07:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756705AbXKTGNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 01:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756667AbXKTGNS
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 01:13:18 -0500
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:48715 "EHLO
	pd2mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756565AbXKTGNR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 01:13:17 -0500
Received: from pd2mr5so.prod.shaw.ca (pd2mr5so-qfe3.prod.shaw.ca [10.0.141.8])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JRS00J2KJY4GVD0@l-daemon> for git@vger.kernel.org; Mon,
 19 Nov 2007 23:13:16 -0700 (MST)
Received: from pn2ml2so.prod.shaw.ca ([10.0.121.146])
 by pd2mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JRS0036XJY43E60@pd2mr5so.prod.shaw.ca> for
 git@vger.kernel.org; Mon, 19 Nov 2007 23:13:16 -0700 (MST)
Received: from prophet.net-ronin.org ([70.67.106.153])
 by l-daemon (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JRS0073AJY3LP40@l-daemon> for git@vger.kernel.org; Mon,
 19 Nov 2007 23:13:16 -0700 (MST)
Received: from ramune by prophet.net-ronin.org with local (Exim 4.50)
	id 1IuMME-0005i1-MB; Mon, 19 Nov 2007 22:13:14 -0800
In-reply-to: <200711200552.27001.chriscool@tuxfamily.org>
Content-disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65528>

> Could you try running the test twice when you bisect ?
> This way bisecting should give you the real first bad commit. 

I re-ran it several times, and also manually -- there were times it'd
succeed 6 times in a row before failing.  Weird.

Finally, the bisect came down to:

  ramune/lycaeum:git: git bisect good
  c74d9acf20ba0c69bbd67c5b0bb3bd3c2349cebe is first bad commit
  commit c74d9acf20ba0c69bbd67c5b0bb3bd3c2349cebe
  Author: Eric Wong <normalperson@yhbt.net>
  Date:   Mon Nov 5 03:21:47 2007 -0800
  
      git-svn: fix dcommit clobbering when committing a series of diffs

Modifying the failing t9106-git-svn-dcommit-clobber-series.sh test to
add touch statements as so:

  test x\"\`sed -n -e 4p < file\`\" = x4444 && touch '/tmp/eleven' &&
  test x\"\`sed -n -e 7p < file\`\" = x7777 && touch '/tmp/twelve' &&
  test x\"\`sed -n -e 58p < file\`\" = x5588 && touch '/tmp/thirteen' &&
  test x\"\`sed -n -e 61p < file\`\" = x6611

Line 52 was the culprit:

  test x\"\`sed -n -e 58p < file\`\" = x5588 &&

-- DN
Daniel
