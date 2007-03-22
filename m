From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
Date: Thu, 22 Mar 2007 01:51:17 -0700
Message-ID: <7vd531veyi.fsf@assigned-by-dhcp.cox.net>
References: <20070321120643.GI20583@mellanox.co.il>
	<7v648u38ws.fsf@assigned-by-dhcp.cox.net>
	<20070322083330.GA16915@segfault.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 22 10:05:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUJEn-0000T6-Pq
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 10:05:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbXCVJFD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 05:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbXCVJFD
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 05:05:03 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:53054 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030254AbXCVJFA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 05:05:00 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070322090500.IANR2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 22 Mar 2007 05:05:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id dl4z1W00Z1kojtg0000000; Thu, 22 Mar 2007 05:05:00 -0400
In-Reply-To: <20070322083330.GA16915@segfault.peff.net> (Jeff King's message
	of "Thu, 22 Mar 2007 04:33:31 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42849>

Jeff King <peff@peff.net> writes:

> I don't think it necessarily means distrust; I always do a fetch +
> inspect + merge, and I am often fetching my own code to a different
> platform!
>
> My reason is that the inspect step takes an arbitrary amount of time,
> and I don't want to lose my place. That is, I might go eat dinner in the
> middle of the 'inspect' and then come back. By using my branch head as a
> checkpoint, I am recording "I have inspected up to my master"; when I am
> done inspecting, the merge moves my checkpoint forward.

Oh, I very much agree with you, but then I would just use
another "inspection" branch, like:

	git checkout -b inspect-jeffs-work master
        git pull $jeff
        git log master..
        ... takes quite time.
        ... interrupted, goes back to work on _my_ master
        git checkout master
        ... does whatever
        git checkout inspect-jeffs-work
        ... continue
        ... looks good
        git checkout master
        git pull $jeff

        git log inspect-jeffs-work..master
	... things that jeff did since I inspected them on the branch

        ... If I do not like them ...
        git reset --hard HEAD^

The advantage is of course I can get interrupted at any time.
