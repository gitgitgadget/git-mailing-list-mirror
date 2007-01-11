From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: tree corrupted on disk quota full
Date: Thu, 11 Jan 2007 23:58:12 +0200
Message-ID: <20070111215812.GK17999@mellanox.co.il>
References: <Pine.LNX.4.64.0701111324350.3594@woody.osdl.org>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 22:58:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H57w9-0006yl-Gs
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 22:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbXAKV6P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 16:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbXAKV6P
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 16:58:15 -0500
Received: from p02c11o141.mxlogic.net ([208.65.145.64]:42232 "EHLO
	p02c11o141.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932071AbXAKV6O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 16:58:14 -0500
Received: from unknown [194.90.237.34] (EHLO p02c11o141.mxlogic.net)
	by p02c11o141.mxlogic.net (mxl_mta-4.0.1-4)
	with ESMTP id 6f2b6a54.2002836400.11751.00-501.p02c11o141.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Thu, 11 Jan 2007 14:58:14 -0700 (MST)
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o141.mxlogic.net (mxl_mta-4.0.1-4)
	with ESMTP id 0f2b6a54.2023816112.11697.00-022.p02c11o141.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Thu, 11 Jan 2007 14:58:08 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 11 Jan 2007 23:59:30 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Thu, 11 Jan 2007 23:56:26 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701111324350.3594@woody.osdl.org>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 11 Jan 2007 21:59:30.0955 (UTC) FILETIME=[C56285B0:01C735CB]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14930.000
X-TM-AS-Result: No--11.779600-4.000000-31
X-Spam: [F=0.2763370120; S=0.276(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36619>

>  - your "git pull" failed, because it was fetching objects that were 
>    corrupt in your local database - and the rule is that local objects 
>    ALWAYS override remote objects. That's an important security thing (a 
>    "pull" is _never_ allowed to overwrite something you already have, and 
>    it doesn't matter if it's corrupt or not, you're not ever going to have 
>    a "git pull" overwriting old data)

...

> That's true robustness.
> 
> 			Linus

OK, now that I know what happened, this makes sense to me.
But I'd like to understand whether what created this in the first place:

> 
>  - you had gotten some corrupt objects due to the disk filling up 
>    (probably during the pull that thus populated the object database with
>    partially written objects)
> 
>    In particular, the 4d4d30be967d3284cbf59afd4fba6ab536e295f5 object was 
>    corrupt. fsck gave a confusing error message:
> 
> 	error: 4d4d30be967d3284cbf59afd4fba6ab536e295f5: object not found
> 	error: c03590b581d51d5fa43adbef9415e935d0229412: object not found
> 
>    which is really because the _file_ for that object does exist, but the 
>    file doesn't actually contain the object it expects (due to 
>    corruption), so the object wasn't "found". 

is something expected?

-- 
MST
