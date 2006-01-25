From: Junio C Hamano <junkio@cox.net>
Subject: [RFD] remembering hand resolve...
Date: Wed, 25 Jan 2006 05:00:45 -0800
Message-ID: <7v4q3ssbr6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jan 25 14:01:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1kGb-0004GU-0B
	for gcvg-git@gmane.org; Wed, 25 Jan 2006 14:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWAYNAr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jan 2006 08:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWAYNAr
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jan 2006 08:00:47 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:948 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751158AbWAYNAq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2006 08:00:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060125125929.OEWD6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 25 Jan 2006 07:59:29 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15130>

As people on the list may know, I keep many mini topic-branches
and keep combining them on top of then-current master to publish
"pu".  This involves resolving merge conflicts by hand, when the
areas topic-branches touch overlap.

The thing is, I find myself resolving the same conflicts over
and over.  This is because the master branch tends to advance
faster than topic branches that touch an overlapping area.  I'd
take more time than I usually do to decide what to do with them;
as a result, overlapping topic branches tend to stay unmerged
into "master" longer than other topic branches.

If I linearize topic-branches that conflict with each other in
some way, say base topic B on top of topic A, I would not have
problem merging them into "pu" as long as I do not change my
mind later and try to merge only topic B without topic A.  But
that defeats the whole point of having independent topic
branches.

I would imagine that people who use StGIT or quilt would have
similar issues.  If they are in the same series, then inside of
that queue the patches are already ordered to be in some way,
probably conflict is resolved once when the patch is refreshed
and they stay applicable as long as the base part cleanly
applies to the updated base version, but patches in the queue
then depend on the earlier ones in the same series, and
extracting and applying only the later parts of the queue would
need you to manually un-resolve the conflict you earlier
resolved.  If you keep different topics in separate queues, on
the other hand, I would imagine you would have exactly the same
"oh, I know this and that patch conflict with each other and I
recall I resolved that last time I merged everything up" issue.

How do people on patch-queue based systems like StGIT and quilt
deal with this?  I am wondering if somebody have a clever idea
to record and reuse an earlier conflict resolution.

A trivial solution would be to save the diff between conflicted
automerge result before hand resolving, and the result of my
hand resolve, and apply with "patch" when I see a conflicted
automerge the next time.  I've tried this by hand and it worked
quite well tonight, but I felt it was somewhat kludgy.  We
should be able to do better than that, with some tool support.

Another obvious way is to avoid rebuilding "pu"; instead I could
pull "master" into "pu" every time I have added something new to
"master".  That would work most of the time, until I decide to
change the order the topic branches are merged into "pu" (or
drop one of them).
