From: "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: rsync update appears broken now
Date: Thu, 20 Oct 2005 11:03:00 -0400
Message-ID: <1129820581.3298.7.camel@orbit.scot.redhat.com>
References: <86vezs9wy9.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Stephen Tweedie <sct@redhat.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 17:08:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESbxG-0003zT-Rp
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 17:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbVJTPDL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 11:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbVJTPDK
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 11:03:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22671 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751541AbVJTPDI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 11:03:08 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j9KF37FA020745;
	Thu, 20 Oct 2005 11:03:07 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j9KF37V12390;
	Thu, 20 Oct 2005 11:03:07 -0400
Received: from dhcp83-93.boston.redhat.com (dhcp83-93.boston.redhat.com [172.16.83.93])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id j9KF32bf009116;
	Thu, 20 Oct 2005 11:03:06 -0400
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86vezs9wy9.fsf@blue.stonehenge.com>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10363>

Hi,

On Thu, 2005-10-20 at 05:47 -0700, Randal L. Schwartz wrote:
> Doing my daily git-pull now broke in this way (using yesterday's git version):
> ...
> * committish: 6e1c6c103c522d01829f3a63992a023ff031e851
>   branch 'master' of rsync://rsync.kernel.org/pub/scm/git/git
> * refs/heads/origin: does not fast forward to branch 'master' of rsync://rsync.kernel.org/pub/scm/git/git;
>   not updating.

Seen here too.  My HEAD and HEAD^ as of yesterday's pull was:

commit ea5a65a59916503d2a14369c46b1023384d51645
Author: Junio C Hamano <junkio@cox.net>
Date:   Tue Oct 18 18:42:19 2005 -0700

    Do not ask for objects known to be complete.

    On top of optimization by Linus not to ask refs that already match, we
    can walk our refs and not issue "want" for things that are known to be
    reachable from them.

    Signed-off-by: Junio C Hamano <junkio@cox.net>

commit f8765797a41a39f4dfc7030098c38283e6461a83
Author: Junio C Hamano <junkio@cox.net>
Date:   Tue Oct 18 18:42:14 2005 -0700

    Even when overwriting tags, report if they are changed or not.

    Signed-off-by: Junio C Hamano <junkio@cox.net>

Today, looking at git-web I can see that that HEAD^ commit is still
there, but yesterday's HEAD is simply not in the commit chain any more:
there are a couple of other commits and then the "Do not ask for objects
known to be complete" commit appears with SHA
49bb805e69f97e75472e54a68e9eb24e08dee011.

Somebody broke this by rsyncing a non-superset tree to kernel.org,
maybe?

"git reset --hard HEAD^" got rid of the missing HEAD commit and allowed
me to pull from the new commit chain, but that really shouldn't be
necessary.

--Stephen
