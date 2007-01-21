From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] prune: --expire=time
Date: Sun, 21 Jan 2007 17:01:15 -0500
Message-ID: <20070121220114.GA24729@coredump.intra.peff.net>
References: <20070118175134.GH15428@spearce.org> <20070118222919.GA22060@moooo.ath.cx> <7vy7o0klt1.fsf@assigned-by-dhcp.cox.net> <20070119034404.GA17521@spearce.org> <20070119104935.GA5189@moooo.ath.cx> <7vfya6hll3.fsf@assigned-by-dhcp.cox.net> <20070120111832.GA30368@moooo.ath.cx> <7vlkjw50nl.fsf@assigned-by-dhcp.cox.net> <20070121103724.GA23256@moooo.ath.cx> <7vejpo39zg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 21 23:01:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8kkc-0006KP-KV
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 23:01:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbXAUWBS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 17:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbXAUWBS
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 17:01:18 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1283 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751699AbXAUWBS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 17:01:18 -0500
Received: (qmail 15457 invoked from network); 21 Jan 2007 17:01:36 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 21 Jan 2007 17:01:36 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 21 Jan 2007 17:01:15 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vejpo39zg.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37350>

On Sun, Jan 21, 2007 at 03:17:07AM -0800, Junio C Hamano wrote:

> If we wanted to apply this grace period conservatively,
> protecting young objects is not enough.  You need to protect
> everything they refer to as well.  In the above scenario, you

That's not sufficient either. You might not _have_ the young objects
yet, think the blob is dangling, and delete it. Meanwhile, the tree that
references it arrives. IOW,
  1. blob B arrives, but already exists
  2. prune deletes unreference and old blob B
  3. tree T arrives, referencing blob B
I think this might be safe if you add objects in a top-down way (i.e., T
before B). However, that doesn't make sense for the commit operation, in
which you add blobs (with git-add), and then eventually construct a
tree.

-Peff
