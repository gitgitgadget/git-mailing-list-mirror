From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] prune: --expire=time
Date: Sun, 21 Jan 2007 17:38:57 -0800
Message-ID: <45B415B1.30407@midwinter.com>
References: <20070118175134.GH15428@spearce.org> <20070118222919.GA22060@moooo.ath.cx> <7vy7o0klt1.fsf@assigned-by-dhcp.cox.net> <20070119034404.GA17521@spearce.org> <20070119104935.GA5189@moooo.ath.cx> <7vfya6hll3.fsf@assigned-by-dhcp.cox.net> <20070120111832.GA30368@moooo.ath.cx> <7vlkjw50nl.fsf@assigned-by-dhcp.cox.net> <20070121103724.GA23256@moooo.ath.cx> <7vejpo39zg.fsf@assigned-by-dhcp.cox.net> <20070121220114.GA24729@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 02:39:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8o9J-0001zH-W7
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 02:39:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbXAVBi7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 20:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbXAVBi7
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 20:38:59 -0500
Received: from tater.midwinter.com ([216.32.86.90]:50061 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751731AbXAVBi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 20:38:59 -0500
Received: (qmail 20998 invoked from network); 22 Jan 2007 01:38:58 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.128?) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 22 Jan 2007 01:38:58 -0000
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
To: Jeff King <peff@peff.net>
In-Reply-To: <20070121220114.GA24729@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37379>

Jeff King wrote:
> That's not sufficient either. You might not _have_ the young objects
> yet, think the blob is dangling, and delete it. Meanwhile, the tree that
> references it arrives. IOW,
>   1. blob B arrives, but already exists
>   2. prune deletes unreference and old blob B
>   3. tree T arrives, referencing blob B
> I think this might be safe if you add objects in a top-down way (i.e., T
> before B). However, that doesn't make sense for the commit operation, in
> which you add blobs (with git-add), and then eventually construct a
> tree.
>   

Shouldn't the repository be locked against operations like prune while a 
commit is in progress anyway? That seems like it's pretty prudent and 
reasonable to me -- doing otherwise is just asking for a zillion little 
race conditions. Prune should be a rare enough operation that having it 
abort (or better, block) while a commit is going on wouldn't be a big 
problem, I'd think.

-Steve
