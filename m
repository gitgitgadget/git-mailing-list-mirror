From: Junio C Hamano <junkio@cox.net>
Subject: [RFH] Merge driver
Date: Sat, 10 Sep 2005 21:58:52 -0700
Message-ID: <7vr7bwxks3.fsf@assigned-by-dhcp.cox.net>
References: <20050907164734.GA20198@c165.ib.student.liu.se>
	<7v1x407min.fsf@assigned-by-dhcp.cox.net>
	<431F34FF.5050301@citi.umich.edu>
	<7vvf1cz64l.fsf@assigned-by-dhcp.cox.net>
	<4320536D.2010706@citi.umich.edu>
	<7v7jdrwlih.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509081012540.3208@g5.osdl.org>
	<43207FE6.2030108@citi.umich.edu>
	<Pine.LNX.4.58.0509081131070.5940@g5.osdl.org>
	<432089D8.4060507@citi.umich.edu>
	<7v3boen0rb.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Sep 11 07:00:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEJw8-0004J2-Fh
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 06:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbVIKE7E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 00:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbVIKE7E
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 00:59:04 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:20652 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932408AbVIKE7D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 00:59:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050911045853.RGLJ8185.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 11 Sep 2005 00:58:53 -0400
To: git@vger.kernel.org
In-Reply-To: <7v3boen0rb.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 09 Sep 2005 00:44:40 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8268>

Some people may be alarmed and feel concerned that I already
have Daniel's and Fredrik's merge in the "master" branch; I feel
this deserves some clarification.

The change Daniel made is a natural enhancement of an existing
program.  It spent unusually long time in the proposed update
queue exactly because read-tree was so fundamental, and I wanted
to make sure there is no serious regression.  Most importantly,
the original merge mechanism, git-resolve, is not dropped, and
'git-pull' uses that, not 'git-merge', after fetching a remote
head.  So for everyday use, nothing has changed.

I did the 'git-merge' strategy backend mechanism because I
wanted to play it safe.  It makes it easy to give the set of
conservative strategies as default for every day use, while
allowing us to try more experimental strategies which can be
used only by an explicit user request.  Introduction of
additional merge strategies, such as the Fredrik merge or
rename-detect merge which is yet to be written, is in a sense
similar to adding new filesystems to the stable kernel tree --
as long as they stay optional and do not touch the core deeply,
they tend to be safer changes than other kinds, and we can add
them more or less anytime in the stable series without impacting
stability.

I intend to eventually update git-pull to use git-merge, and I
am hoping that I can do so before we hit 1.0, once we are sure
that 'git-merge -s stupid' behaves identically as 'git-resolve',
and 'git-merge -s resolve' fares no worse than 'git-resolve'.  I
personally feel I've done enough tests to ensure that already,
but help from the community is as always appreciated.
