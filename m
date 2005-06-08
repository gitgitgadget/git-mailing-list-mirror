From: Junio C Hamano <junkio@cox.net>
Subject: [RFC] rename/rename conflicts: do they matter?
Date: Wed, 08 Jun 2005 10:21:43 -0700
Message-ID: <7vll5k69y0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 08 19:19:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg4D5-0003zD-Fy
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 19:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVFHRXD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 13:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVFHRWy
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 13:22:54 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:23792 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261466AbVFHRVv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2005 13:21:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050608172144.JJIX1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 8 Jun 2005 13:21:44 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I was reviewing git-merge-one-file-script, and started
thinking...

It currently has a logic that says if both branches deleted the
same file, instead of taking that as a concensus to remove it,
it refuses to merge the path.  The error message states "This is a
potential rename conflict." as the rationale for doing so.  It
is trying to be careful about one branch renaming the file to
something while the other renaming it to something else.

However, it happily deletes "deleted in one and unchanged in the
other".  If we are so careful about "rename/rename conflicts", I
would think it would make more sense to be careful to consider
the possibility that one branch renamed this file, thereby
creating a copy at another path, while the other branch kept it
intact (the other side of this operation is "added in one"), but
we do not seem to bother worrying about it.  If we try to be
anal about this, then even a simple "added in one" case could
trigger "copy/copy" conflict.

My current thinking is that the current logic for "both delete"
is too anal, and we should treat this case just like other
"concensus" cases; simply removing the path in this case would
be better.

