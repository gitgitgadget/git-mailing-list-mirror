From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Allow dot files in ls-files as well.
Date: Tue, 24 May 2005 17:44:33 -0700
Message-ID: <7v1x7wt9qm.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vhdgstb7x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505241723060.2307@ppc970.osdl.org>
	<7v8y24taai.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 02:43:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DajzM-0005A9-AS
	for gcvg-git@gmane.org; Wed, 25 May 2005 02:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbVEYAow (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 20:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbVEYAow
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 20:44:52 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:33937 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S262208AbVEYAof (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 20:44:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050525004433.CRWX12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 24 May 2005 20:44:33 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v8y24taai.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Tue, 24 May 2005 17:32:37 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:
LT> I considered it, but it's so much easier to allow things
LT> later than deny them, that I preferred being anal about it.

JCH> That is not the point.  GIT_DIR set to "GIT" would happily suck
JCH> index file in.  You are not being anal enough.

... which makes me feel that, since you cannot be anal enough
anyway, it would be more consistent not to be more restrictive
than necessary (the user has every right to screw himself
anyway).

No matter what you end up doing, you would need something like
this as well (I am not screening .git here but that should be
easy for you to add).

------------
Allow dot files in ls-files as well.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
cd /opt/packrat/playpen/public/in-place/git/git.junio/
PATH=.:$PATH jit-diff 1: ls-files.c
# - linus: git-update-cache: allow dot-files
# + (working tree)
diff --git a/ls-files.c b/ls-files.c
--- a/ls-files.c
+++ b/ls-files.c
@@ -136,7 +136,9 @@ static void read_directory(const char *p
 		while ((de = readdir(dir)) != NULL) {
 			int len;
 
-			if (de->d_name[0] == '.')
+			if (de->d_name[0] == '.' &&
+			    (de->d_name[1] == 0 ||
+			     (de->d_name[1] == '.' && de->d_name[2] == 0)))
 				continue;
 			if (excluded(de->d_name) != show_ignored)
 				continue;


