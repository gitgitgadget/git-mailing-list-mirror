From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 10:14:08 +0100
Message-ID: <1113556448.12012.269.camel@baythorne.infradead.org>
References: <20050414002902.GU25711@pasky.ji.cz>
	 <20050413212546.GA17236@64m.dyndns.org>
	 <20050414004504.GW25711@pasky.ji.cz>
	 <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
	 <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
	 <7v64ypsqev.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	 <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>
	 <20050414121624.GZ25711@pasky.ji.cz>
	 <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 11:11:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMMr6-0001Eh-WF
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 11:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVDOJOT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 05:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbVDOJOT
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 05:14:19 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:45456 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261671AbVDOJOO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 05:14:14 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by baythorne.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DMMtt-00026v-GB; Fri, 15 Apr 2005 10:14:09 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-04-14 at 11:36 -0700, Linus Torvalds wrote:
> And "merge these two trees" (which works on a _tree_ level)
> or "find the common commit" (which works on a _commit_ level)

I suspect that finding the common commit is actually a per-file thing;
it's not just something you do for the _commit_ graph, then use for
merging each file in the two branches you're trying to merge.

Consider a simple repository which contains two files A and B. We start
off with the first version of each ('A1B1'), and the owner of each file
takes a branch and modifies their own file. There is cross-pulling
between the two, and then each modifies the _other's_ file as well as
their own...

   (A1B2)--(A2B2)--(A2'B3)
    /  \   /            \
   /    \ /              \
 (A1B1)  X               (...)
   \    / \              /
    \  /   \            /
   (A2B1)--(A2B2)--(A3B2')

Now, we're trying to merge the two branches. It appears that the most
useful common ancestor to use for a three-way merge of file A is the
version from tree 'A2B1', while the most useful common ancestor for
merging file B is that in 'A1B2'.

(I think it's a coincidence that in my example the useful files 'A2' and
'B2' actually do end up in a single tree together at some point.)

-- 
dwmw2


