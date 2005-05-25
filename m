From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Allow dot files in ls-files as well (take #2).
Date: Tue, 24 May 2005 18:20:08 -0700
Message-ID: <7vwtpoqeyf.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vhdgstb7x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505241723060.2307@ppc970.osdl.org>
	<7v8y24taai.fsf@assigned-by-dhcp.cox.net>
	<7v1x7wt9qm.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505241753300.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 03:19:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DakXq-0007fJ-GA
	for gcvg-git@gmane.org; Wed, 25 May 2005 03:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbVEYBUQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 21:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbVEYBUQ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 21:20:16 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:7886 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262226AbVEYBUK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 21:20:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050525012008.QQSB550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 24 May 2005 21:20:08 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505241753300.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 24 May 2005 17:54:33 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This attempts to match "the directory '.git' anywhere in the
tree is ignored" approach taken in update-cache.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
cd /opt/packrat/playpen/public/in-place/git/git.junio/
PATH=.:$PATH jit-diff : ls-files.c
# - linus: git-update-cache: allow dot-files
# + (working tree)
diff --git a/ls-files.c b/ls-files.c
--- a/ls-files.c
+++ b/ls-files.c
@@ -136,7 +136,10 @@ static void read_directory(const char *p
 		while ((de = readdir(dir)) != NULL) {
 			int len;
 
-			if (de->d_name[0] == '.')
+			if ((de->d_name[0] == '.') &&
+			    (de->d_name[1] == 0 ||
+			     !strcmp(de->d_name + 1, ".") ||
+			     !strcmp(de->d_name + 1, "git")))
 				continue;
 			if (excluded(de->d_name) != show_ignored)
 				continue;



