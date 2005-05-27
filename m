From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] ls-tree path restriction semantics fixes
Date: Fri, 27 May 2005 11:16:53 -0700
Message-ID: <7vmzqgzg8a.fsf@assigned-by-dhcp.cox.net>
References: <20050527120851.GA11823@port.evillabs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 20:16:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbjMg-0002iG-NM
	for gcvg-git@gmane.org; Fri, 27 May 2005 20:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbVE0SRV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 14:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbVE0SRV
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 14:17:21 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:1209 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S262051AbVE0SQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 14:16:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050527181654.PCPC7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 27 May 2005 14:16:54 -0400
To: Jason McMullan <jason.mcmullan@timesys.com>
In-Reply-To: <20050527120851.GA11823@port.evillabs.net> (Jason McMullan's
 message of "Fri, 27 May 2005 08:08:51 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JM" == Jason McMullan <jason.mcmullan@timesys.com> writes:

JM> This patch fixes the git-ls-tree semantics to be less stupid, namely:
JM> 	* ls of a 'tree' path should just return the SHA1 of the tree
JM> 	* ls of a 'tree' path with a trailing '/' should work properly
JM> 	* ls of two identical paths should have the same output as ls of
JM> 	  a single path. (I consider ls-tree's output to be a hash dictionary)

I haven't read your code yet, but...

JM> Old Results:

JM> 	$ git-ls-tree t
JM> 	040000 tree 4eeb3990955b8badc4c14712b89d8cd9fff02f15    t
JM> 	100644 blob 6882e23be568ccf14f3adb0c766139086f2ee952    t/Makefile
JM> 	100644 blob 2a94fdb0b83ab5fcbf1a2c6edaf36c2dbe765ec6    t/README
JM> 	100644 blob d920c6b3a3bfbb5994244a78d1ad99ce02748122    t/lib-read-tree-m-3way.sh
JM> 	...

I presume the counterpart to this one in your "New Results"
example, which is spelled "git-ls-tree f" is a typo of
"git-ls-tree t", but if that is the case I strongly disagree.

What you really want is something similar to '-d' flag to
/bin/ls.  You are interested in the directory itself not its
contents and I think your gripe is that giving a path that
matches a tree always descends into it (i.e. there is no way to
do the equivalent of "/bin/ls -d t").  I agree that it is a
problem, but changing "/bin/ls t" not to show the directory
contents of "t" is not a solution.

JM> 	$ git-ls-tree t/
JM> 	(no output)

I agree with you that this is not what we want and we should
behave the same way as "git-ls-tree t" would in this case.

JM> 	$ git-ls-tree t t
JM> 	040000 tree 4eeb3990955b8badc4c14712b89d8cd9fff02f15    t

I do not know what you wanted to say in this example.  Your
"Old" and "New" look the same to me.





