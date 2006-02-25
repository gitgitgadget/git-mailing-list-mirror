From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] diff-delta: produce optimal pack data
Date: Sat, 25 Feb 2006 11:18:59 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602251114070.22647@g5.osdl.org>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain>
 <7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net> <20060224174422.GA13367@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241252300.31162@localhost.localdomain>
 <20060224183554.GA31247@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0602241350190.31162@localhost.localdomain>
 <20060224192354.GC387@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0602241152290.22647@g5.osdl.org>
 <7vpslc8oni.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602241613030.31162@localhost.localdomain>
 <Pine.LNX.4.64.0602241637480.22647@g5.osdl.org>
 <Pine.LNX.4.64.0602242130030.31162@localhost.localdomain>
 <Pine.LNX.4.64.0602241952140.22647@g5.osdl.org>
 <Pine.LNX.4.64.0602242326381.31162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Carl Baldwin <cnb@fc.hp.com>
X-From: git-owner@vger.kernel.org Sat Feb 25 20:27:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FD54w-0006xz-4a
	for gcvg-git@gmane.org; Sat, 25 Feb 2006 20:27:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161082AbWBYT1a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Feb 2006 14:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161084AbWBYT13
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Feb 2006 14:27:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51847 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161082AbWBYT13 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Feb 2006 14:27:29 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1PJJ1DZ004137
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 25 Feb 2006 11:19:02 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1PJIx5m014755;
	Sat, 25 Feb 2006 11:19:00 -0800
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0602242326381.31162@localhost.localdomain>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16761>



On Sat, 25 Feb 2006, Nicolas Pitre wrote:
> 
> Yes, the hash is larger.  There is a cost in memory usage but not really 
> in CPU cycles.

Note that memory usage translates almost 1:1 (or worse) to CPU cycles in 
almost all real-life behaviours. Only in carefully tuned benchmarks does 
it not.

Increased memory usage means more paging, and worse cache behaviour. Now, 
hashes aren't wonderful for caches in the first place, but imagine the 
hump you pass when the data doesn't fit in a 64kB L1 any more (or a 256kB 
L2). Huge.

> > You'll find a lot of that in any file: three or four bytes of similarity 
> > just doesn't sound worthwhile to go digging after. 
> 
> Well after having experimented a lot with multiple parameters I think 
> they are worth it after all.  Not only they provide for optimal deltas, 
> but their hash is faster to compute than larger blocks which seems to 
> counter balance for the cost of increased hash list.

Hey, numbers talk. If you've got the numbers, I'll just shut up ;)

		Linus
