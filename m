From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git rebase: unexpected conflict
Date: Wed, 7 Feb 2007 12:30:46 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702071222470.8424@woody.linux-foundation.org>
References: <7vr6t17ohb.fsf@assigned-by-dhcp.cox.net> <20070207200508.GE12140@mellanox.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
X-From: git-owner@vger.kernel.org Wed Feb 07 21:31:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEtRo-0000TM-VU
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 21:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161160AbXBGUbM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 15:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161438AbXBGUbH
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 15:31:07 -0500
Received: from smtp.osdl.org ([65.172.181.24]:35348 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161160AbXBGUbF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 15:31:05 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l17KUmdD018077
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 7 Feb 2007 12:30:49 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l17KUkJD026314;
	Wed, 7 Feb 2007 12:30:47 -0800
In-Reply-To: <20070207200508.GE12140@mellanox.co.il>
X-Spam-Status: No, hits=-0.45 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.113__
X-MIMEDefang-Filter: osdl$Revision: 1.175 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38964>



On Wed, 7 Feb 2007, Michael S. Tsirkin wrote:
> 
> Sorry about being dense. What's evil there?
> There seems to have been a merge, and a conflict was resolved.

The reason Junio marked it as "evil" is that the resolved result was also 
moved around a bit, making it really hard to see what the original 
conflict was.

If David had resolved things in place, "git show" would actually have 
shown a nicer conflict diff, and _explained_ the conflict better (most 
likely by not showing it at all - which is just a sign that it was 
resolved cleanly in one direction). As it is, the conflict diff doesn't 
tell anything about what the conflict actually was, or whether it resolved 
trivially.

[ Note! Conflict diffs do *not* necessarily show the "conflict" at all: 
  we'll happily ignore any conflict that was resolved completely in one 
  direction, and the conflict diff output is really more of a warning that 
  something bad could have happened, and somebody tried to *hide* some 
  changes by calling it a merge. ]

So what makes that an "evil merge" is that it triggers the conflict diff, 
and that one really looks like somebody tried to add code and hide it. 
There was no actual evil activity involved, it was just done in a way that 
raise the red flags of the git --cc format.

So for a "non-evil" merge, the --cc output (which is what "git show" shows 
by default) will either be empty to indicate a trivial merge, or will give 
a hint about how the problem was resolved. Because of the movement, in 
this case it did neither.

		Linus
