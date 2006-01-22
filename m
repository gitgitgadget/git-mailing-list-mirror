From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Reverting "git push logic change"?
Date: Sun, 22 Jan 2006 13:31:00 -0800
Message-ID: <7vu0bw9ch7.fsf@assigned-by-dhcp.cox.net>
References: <20060120225336.GA29206@kroah.com>
	<7vlkxa30rd.fsf@assigned-by-dhcp.cox.net>
	<20060121001547.GA30712@kroah.com>
	<7vfynivx9s.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601221311530.25300@iabervon.org>
	<7vr770c8db.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 22 22:31:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0mni-0004t1-Cg
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 22:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWAVVbD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jan 2006 16:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWAVVbD
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jan 2006 16:31:03 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:5568 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751374AbWAVVbC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2006 16:31:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060122213003.GOBT15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 22 Jan 2006 16:30:03 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <7vr770c8db.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 22 Jan 2006 12:31:28 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15065>

Junio C Hamano <junkio@cox.net> writes:

> ...  This is a user error but that is not their fault.  It
> means that we need to document this better:

I hope something like this is clear enough?

-- >8 --
[PATCH] Recommend to remove unused `origin` in a shared repository

It is a common mistake to leave an unsed `origin` branch behind
if a shared public repository was created by first cloning from
somewhere else.  Subsequent `git push` into it with the default
"push all the matching ref" would push the `origin` branch from
the developer repository uselessly.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index b8fa299..35579cc 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -1667,6 +1667,26 @@ complain, telling you that the remote `m
 fast forward.  You need to pull and merge those other changes
 back before you push your work when it happens.
 
+The `git push` command without any explicit refspec parameter
+pushes the refs that exist both in the local repository and the
+remote repository.  So the last `push` can be done with either
+one of these:
+------------
+$ git push origin
+$ git push repo.shared.xz:/pub/scm/project.git/
+------------
+as long as the shared repository does not have any branches
+other than `master`.
+[NOTE]
+============
+If you created your shared repository by cloning from somewhere
+else, you may have the `origin` branch.  Your developers
+typically do not use that branch; remove it.  Otherwise, that
+would be pushed back by the `git push origin` because your
+developers' repository would surely have `origin` branch to keep
+track of the shared repository, and would be counted as "exist
+on both ends".
+============
 
 Advanced Shared Repository Management
 -------------------------------------
