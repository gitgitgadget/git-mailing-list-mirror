From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: kernel.org now has gitweb installed
Date: Thu, 28 Apr 2005 10:23:19 +0100
Message-ID: <1114680199.12012.363.camel@baythorne.infradead.org>
References: <42703E79.8050808@zytor.com>
	 <1114673723.12012.324.camel@baythorne.infradead.org>
	 <20050428081005.GG8612@pasky.ji.cz>
	 <1114676955.12012.346.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 11:22:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR5D5-00089q-13
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 11:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVD1JZ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 05:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbVD1JZ5
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 05:25:57 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:33958 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261946AbVD1JXV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 05:23:21 -0400
Received: from localhost.localdomain ([127.0.0.1])
	by baythorne.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DR5Eu-0000AV-4j; Thu, 28 Apr 2005 10:23:20 +0100
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <1114676955.12012.346.camel@baythorne.infradead.org>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-04-28 at 09:29 +0100, David Woodhouse wrote:
> Let us assume that C and A were already in Linus' tree (and on our web
> page) yesterday. Thus, they should be last. The newly-pulled stuff
> should be first -- FEDBCA.
> 
> I'd say "depth-first, remote parent first" but that would actually show
> show 'A' (as a parent of D) long before it shows C. Walking of remote
> parents should stop as soon as we hit a commit which was accessible
> through a more local parent, rather than as soon as we hit a commit
> which we've already printed.

Walk the tree once. For each commit, count the number of _children_.
That's not hard -- each new commit you find below HEAD has one child to
start with, then you increment that figure by one each time you find
another path to the same commit.

When printing, you walk the tree depth-first, remote-parent-first. If
you hit a commit with multiple children, decrement its count by one. If
the count is still non-zero, ignore that commit (and its parents) and
continue. If the count _is_ zero, then this is the "most local" path to
the commit in question, so print it and continue to process its
parents...

(Actually I'd probably do it by adding real pointers to the children
instead of using a counter. Operations like convert-cache would be far
better off working that way round, and 'cg comments' is going to need to
do something very similar to convert-cache.)

-- 
dwmw2


