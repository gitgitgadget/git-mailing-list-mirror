From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-name-rev off-by-one bug
Date: Wed, 30 Nov 2005 00:37:46 -0800
Message-ID: <7vek4ywmxx.fsf@assigned-by-dhcp.cox.net>
References: <20051129080529.20705.qmail@science.horizon.com>
	<7voe43iyyu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 10:35:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhNTL-00023k-PT
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 09:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbVK3Iht (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 03:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbVK3Iht
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 03:37:49 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:60037 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751128AbVK3Ihs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 03:37:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051130083640.BTPQ17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 30 Nov 2005 03:36:40 -0500
To: linux@horizon.com
In-Reply-To: <7voe43iyyu.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 29 Nov 2005 01:29:29 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12993>

Junio C Hamano <junkio@cox.net> writes:

> On a related topic of removing unwanted paths, earlier I said
> 2-way is used to make sure "git checkout" takes your changes
> with you when you switch branches.  As a natural consequence of
> this, if you do not have any local changes, "git checkout"
> without "-f" does the right thing -- it removes unwanted paths
> that existed in the original branch but not in the branch you
> are switching to.

Here is an unsolicited advice ("tip of the day").

I was on a branch which had some local "throwaway" changes, and
I wanted to switch back to the master branch.  To be honest, I
even forgot I had local changes there.  So I ran "git checkout",
and here is what happened.

        junio@siamese:~/git$ git checkout master
        fatal: Entry 'Documentat...' not uptodate. Cannot merge.

The easiest is "git checkout -f master" at this point, but I
usually do not do that.  If that entry "git checkout" complains
about is something that is not in the master branch and I have
throwaway changes, "git checkout -f master" would leave that
file with throwaway changes behind.  So I did this first:

        junio@siamese:~/git$ git reset --hard

This would sync my working tree to the current branch.  Then

        junio@siamese:~/git$ git checkout master

would switch branches properly, removing that new file that
should not exist in the working tree.
