From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: path limiting broken
Date: Sun, 16 Apr 2006 19:39:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604161931530.19020@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0604161411120.15345@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0604160850230.3701@g5.osdl.org>
 <Pine.LNX.4.63.0604161835410.17985@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0604161000550.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 16 19:39:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVBDb-0001np-E8
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 19:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWDPRjP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 13:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWDPRjP
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 13:39:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:45738 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750765AbWDPRjO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 13:39:14 -0400
Received: (qmail invoked by alias); 16 Apr 2006 17:39:13 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp034) with SMTP; 16 Apr 2006 19:39:13 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604161000550.3701@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18795>

Hi,

me again.

I finally found the commit which removed parse_whatchanged_opt() from 
log-tree.c by

	git-rev-list 4a617..next | while read commit; do \
		echo $commit; \
		git diff $commit^..$commit log-tree.c | \
			grep parse_whatchanged; \
	done | less

where obviously 4a617 is the commit I last merged with. The winner is: 

	43f934aa90... Merge branch 'lt/logopt' into next

However, the combined diff of that commit does not show it, while the diff 
to the first parent does:

	git-show --cc 43f934aa90 | grep parse_whatchanged

shows nothing (-c -p shows half of the truth), while

	git-diff 43f934aa90^..43f934aa90 | grep parse_whatchanged

shows something, and 

	git-diff 43f934aa90^2..43f934aa90 | grep parse_whatchanged

again does not.

Time to understand the combined diff logic, I guess...

Ciao,
Dscho
