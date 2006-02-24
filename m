From: Linus Torvalds <torvalds@osdl.org>
Subject: Removal of "--merge-order"?
Date: Fri, 24 Feb 2006 08:32:43 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602240824110.3771@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Feb 24 17:33:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCfsE-00037h-5s
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 17:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWBXQcv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 11:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWBXQcv
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 11:32:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57733 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932372AbWBXQcu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2006 11:32:50 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1OGWkDZ000753
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 24 Feb 2006 08:32:47 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1OGWhEj029198;
	Fri, 24 Feb 2006 08:32:45 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16714>


I just tested it again, and

	git-rev-list --merge-order HEAD

takes an inordinate amount of time:

	real    5m1.139s
	user    4m59.504s
	sys     0m1.220s

and that's on a reasonably fast machine (not my fastest, but no slouch by 
any measure - my fastest machine I'm not allowed to really benchmark 
publicly ;)

It may be a cool algorithm, but it's essentially useless on any bigger 
tree. And nobody uses it, since "--topo-order" gives the guarantees that 
people really care about, and finishes in 0.537 seconds on the same 
machine with the same tree.

It also depends on the openssh "bignum" stuff, which means that any 
machine where we just rely on our own SHA1 implementation and don't use 
openssh doesn't have the flag anyway.

In other words, I'd really prefer if it was gone. Some of the things I 
might do to git-rev-list would be much simpler if I didn't have to worry 
about merge-order, and the way it interfaces with the rest of 
git-rev-list.

Comments?

			Linus
