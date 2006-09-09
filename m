From: Paul Mackerras <paulus@samba.org>
Subject: Re: Change set based shallow clone
Date: Sat, 9 Sep 2006 11:05:12 +1000
Message-ID: <17666.4936.894588.825011@cargo.ozlabs.ibm.com>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com>
	<20060908184215.31789.qmail@science.horizon.com>
	<9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com>
	<Pine.LNX.4.64.0609081600530.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jon Smirl <jonsmirl@gmail.com>,
	"linux@horizon.com" <linux@horizon.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 09 03:05:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLrHj-0004uz-P2
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 03:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWIIBFW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 21:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWIIBFV
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 21:05:21 -0400
Received: from ozlabs.org ([203.10.76.45]:15494 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751270AbWIIBFU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Sep 2006 21:05:20 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 9D8E667BAB; Sat,  9 Sep 2006 11:05:19 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609081600530.27779@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26728>

Linus Torvalds writes:

> [ One way to do it might be: the normal ordering of revisions without 
>   "--topo-order) is "_close_ to topological", and gitk could just decide 
>   to re-compute the whole graph whenever it gets a commit that has a 
>   parent that it has already graphed. Done right, it would probably almost 
>   never actually generate re-computed graphs (if you only actually 
>   generate the graph when the user scrolls down to it).
> 
>   Getting rid of the --topo-order requirement would speed up gitk 
>   absolutely immensely, especially for unpacked cold-cache archives. So it 
>   would probably be a good thing to do, regardless of any shallow clone 
>   issues ]
> 
> Hmm?

I recently added code to gitk to add extra commits after the graph has
been laid out, provided that the extra commits have one parent and no
children.  If I generalized that to handle arbitrary numbers of
parents and children, it might go close to what you're suggesting.

It might get nasty if we have laid out A and then later B, and then C
comes along and turns out to be a child of A but a parent of B,
meaning that both B and C have to be put above A.

Another thing I have been thinking of is that gitk probably should
impose a time limit of say 3 months by default, unless the user
specifies some other ending condition (such as commitid.., ^commitid
or --since=something-else).  Together with a menu to select the time
limit, I think that would be quite usable and would make gitk start up
*much* faster.

Paul.
