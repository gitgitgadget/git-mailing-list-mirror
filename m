From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: Multiple pulls from the same branch in .git/remotes/origin
Date: Tue, 8 Aug 2006 01:33:15 +0300
Message-ID: <20060807223315.GB24393@mellanox.co.il>
References: <7vzmegyzgb.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 08 00:31:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GADdD-00006I-FN
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 00:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWHGWb2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 18:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWHGWb2
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 18:31:28 -0400
Received: from mxl145v68.mxlogic.net ([208.65.145.68]:61640 "EHLO
	p02c11o145.mxlogic.net") by vger.kernel.org with ESMTP
	id S932237AbWHGWb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 18:31:28 -0400
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o145.mxlogic.net (mxl_mta-3.0.0-12)
	with ESMTP id f3fb7d44.2155928496.20772.00-006.p02c11o145.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Mon, 07 Aug 2006 16:31:27 -0600 (MDT)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 8 Aug 2006 01:37:21 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Tue,  8 Aug 2006 01:33:15 +0300
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmegyzgb.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 07 Aug 2006 22:37:21.0296 (UTC) FILETIME=[0BC25100:01C6BA72]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25049>

Quoting r. Junio C Hamano <junkio@cox.net>:
> Subject: Re: Multiple pulls from the same branch in .git/remotes/origin
> 
> "Michael S. Tsirkin" <mst@mellanox.co.il> writes:
> 
> > It seems that have to make path_match in connect.c return an array
> > of indexes for that to work. Right?
> 
> I do not recall why Linus placed that "*s = 0" in there.  That
> is the one that makes the same ref not match more than once.

Hmm, as I read it, this marks the *match* as already found.
This seems to be what makes the sanity check in main work:

                /* If the heads to pull were given, we should have
                 * consumed all of them by matching the remote.
                 * Otherwise, 'git-fetch remote no-such-ref' would
                 * silently succeed without issuing an error.
                 */

What stops it is return i + 1 in path_match, no?
I think the issue is that path_match will stop at first match and not
label multiple matches, so later sanity check in main errors out.

> It _could_ be that the fix is just the matter of removing that
> line, but it may have interesting consequences; I dunno offhand.
> 
> 

What I did is just scan the full list of refspecs instead of breaking
out at the first match.

-- 
MST
