From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add suggestion to hard-to-understand error message
Date: Wed, 21 Dec 2005 17:15:46 -0800
Message-ID: <7vd5jqvsn1.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0512220048360.13453@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 02:15:54 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpF3f-00044s-Qh
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 02:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbVLVBPt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 20:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbVLVBPt
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 20:15:49 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:22702 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S965012AbVLVBPs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 20:15:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051222011359.PZTT17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Dec 2005 20:13:59 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13926>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Dummies like me do not understand readily that "remote object abcdef...
> does not exist on local" means: "Hey, you did not pull this, did you?".
> So, add "(pull first?)" to that message.

I am ambivalent about this one.  It is a special case of "remote
is not a strict subset of local" situation, so we might be
better if we just said the same as the other error message and
be done with it.  On the other hand, the code does know the
difference of the two situations at this point, and it could be
argued that giving the same error is losing information.

Earlier I once rewound the "master" branch head by one commit
too much by mistake.  The next push to the public server would
have given me a different error message, depending on whether I
pruned my private repository or not in between.  For example,
after this sequence:

    $ git commit -m 'initial'
    $ git commit -m 'next'
    $ git push remote master
    $ git reset --hard HEAD^
    $ git commit -m 'third but second'

If you do not prune at this point, then the remote commit "next"
still exists in the local repository (but not reachable).  Then

    $ git push remote master

would not say "pull first?".  But if you prune local repository
before pushing, it would now say "pull first?".

In a sense, both are "pull first?" situation, and it probably is
more confusing to give different messages to the user in these
two cases.  From the end-user point of view they are the same
"remote is not strict subset.".
