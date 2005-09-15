From: Junio C Hamano <junkio@cox.net>
Subject: Re: Avoid wasting memory in git-rev-list
Date: Thu, 15 Sep 2005 15:02:26 -0700
Message-ID: <7v7jdiyop9.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0509151434470.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 00:05:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EG1oR-0003eq-4l
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 00:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054AbVIOWCc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 18:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965283AbVIOWCc
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 18:02:32 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:15056 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S965054AbVIOWCc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 18:02:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050915220228.YOYQ18319.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 15 Sep 2005 18:02:28 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509151434470.26803@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 15 Sep 2005 14:43:17 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8643>

So using this I could also avoid wasting memory by the "are we
already walking the commit reachable from our existing refs"
check by doing something like this?

------------
git diff
diff --git a/fetch.c b/fetch.c
--- a/fetch.c
+++ b/fetch.c
@@ -207,6 +207,7 @@ int pull(char *target)
 	unsigned char sha1[20];
 	int fd = -1;
 
+	save_commit_buffer = 0;
 	if (write_ref && current_ref) {
 		fd = lock_ref_sha1(write_ref, current_ref);
 		if (fd < 0)
