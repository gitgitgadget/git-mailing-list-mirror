From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-log fatal error in empty repo
Date: Thu, 07 Jun 2007 13:29:10 -0700
Message-ID: <7vps47o6eh.fsf@assigned-by-dhcp.cox.net>
References: <588192970706070634s4c25ae45g68be32c06a30d043@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Steve Hoelzer" <shoelzer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 22:29:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwObe-0004c6-3M
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 22:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936351AbXFGU3N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 16:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936599AbXFGU3N
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 16:29:13 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:55428 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936590AbXFGU3L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 16:29:11 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070607202910.EXTQ9600.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 7 Jun 2007 16:29:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8kVA1X00o1kojtg0000000; Thu, 07 Jun 2007 16:29:11 -0400
In-Reply-To: <588192970706070634s4c25ae45g68be32c06a30d043@mail.gmail.com>
	(Steve Hoelzer's message of "Thu, 7 Jun 2007 08:34:20 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49383>

"Steve Hoelzer" <shoelzer@gmail.com> writes:

> git-log will return a fatal error for an empty repo, like so:
>
> $ git --version
> git version 1.5.2.73.g18bece
> $ mkdir mytest
> $ cd mytest
> $ git-init
> Initialized empty Git repository in .git/
> $ git-log
> fatal: bad default revision 'HEAD'
>
> It would be nice if git-log was quiet or returned a "no log" message
> instead of the fatal error.

Maybe, but I highly doubt if it is worth to bother about it.

 revision.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/revision.c b/revision.c
index 0a29b53..0573b86 100644
--- a/revision.c
+++ b/revision.c
@@ -1218,8 +1218,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		unsigned char sha1[20];
 		struct object *object;
 		unsigned mode;
-		if (get_sha1_with_mode(def, sha1, &mode))
+		if (get_sha1_with_mode(def, sha1, &mode)) {
+			if (!strcmp("HEAD", def))
+				die("You have no history yet on your HEAD");
 			die("bad default revision '%s'", def);
+		}
 		object = get_reference(revs, def, sha1, 0);
 		add_pending_object_with_mode(revs, object, def, mode);
 	}
