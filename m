From: Maaartin <grajcar1@seznam.cz>
Subject: Re: git describe weird behaviour
Date: Wed, 10 Nov 2010 08:47:55 +0000 (UTC)
Message-ID: <loom.20101110T092918-964@post.gmane.org>
References: <20101110010016.GC22105@genesis.frugalware.org> <20101110041428.GA8955@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 10 09:48:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PG6M0-00074Z-Vj
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 09:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755007Ab0KJIsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 03:48:11 -0500
Received: from lo.gmane.org ([80.91.229.12]:44312 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754948Ab0KJIsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 03:48:09 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PG6Lg-0006wE-40
	for git@vger.kernel.org; Wed, 10 Nov 2010 09:48:08 +0100
Received: from 188-120-198-113.luckynet.cz ([188-120-198-113.luckynet.cz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 09:48:08 +0100
Received: from grajcar1 by 188-120-198-113.luckynet.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 09:48:08 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.120.198.113 (Opera/9.80 (Windows NT 5.2; U; en) Presto/2.6.30 Version/10.63)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161139>

Jeff King <peff <at> peff.net> writes:
> PS This would be a much simpler algorithm to write in a depth-first way.
>    But that would also involve traversing the entire graph down to the
>    roots, which we try to avoid.  Which reminds me of my "tag
>    --contains" depth first algorithm, and gives me some ideas on how to
>    make it work in a breadth-first way. So even if my idea here is
>    flawed, this thinking hasn't been completely fruitless. :)

IMHO, using BFS and counting commits is flawed, since the output is hard to 
understand and quite meaningless for humans. Imagine a merge of two long 
branches, one with a tag 10 commits deep and the other with a tag 11 commits 
deep. Do you see any reason for a human to prefer the first one? I do not.

I could imagine to always prefer the first branch, which leads to DFS. What is 
your reason for avoiding traversing to the roots?

It could be better to traverse the first branch only to the point where the 
other started, then traverse the other one, and then continue down the common 
trunk. This sounds a bit complicated to implement and may be hard to specify in 
more complicated cases. A rule like "tag T1 can be returned only if there's no 
tag T2 higher (i.e. newer) in the tree", could possibly solve it.

Finally, using a chronological ordering instead of counting commits seems to be 
the most straightforward to me. An implementation using a priority queue is no 
less and no more complicated then BFS or DFS. I think, it could be an 
interesting and easy to comprehend option. In case I'm talking non-sense, pls 
bare with me, since I'm still a beginner.
