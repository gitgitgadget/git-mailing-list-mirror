From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Fri, 05 Jan 2007 13:37:18 -0800
Message-ID: <7vtzz5duk1.fsf@assigned-by-dhcp.cox.net>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
	<Pine.LNX.4.64.0701031737300.4989@woody.osdl.org>
	<7v1wmbnw9x.fsf@assigned-by-dhcp.cox.net>
	<204011cb0701040958k884b613i8a4639201ae6443b@mail.gmail.com>
	<7v1wmalez6.fsf@assigned-by-dhcp.cox.net>
	<204011cb0701050919w2001105asefe2fd99165dfa95@mail.gmail.com>
	<7vbqldfg56.fsf@assigned-by-dhcp.cox.net>
	<204011cb0701051133r1ede14a6gd5093a3e7fa88cb5@mail.gmail.com>
	<20070105193958.GE8753@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Chris Lee <chris133@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Jan 05 22:37:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2wkf-0003C1-6H
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 22:37:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbXAEVhV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 16:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbXAEVhV
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 16:37:21 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:36503 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbXAEVhT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 16:37:19 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070105213719.SJMP97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Fri, 5 Jan 2007 16:37:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 7ZcW1W0081kojtg0000000; Fri, 05 Jan 2007 16:36:30 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070105193958.GE8753@spearce.org> (Shawn O. Pearce's message of
	"Fri, 5 Jan 2007 14:39:58 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36027>

Subject: [PATCH] builtin-prune: memory diet.

Somehow we forgot to turn save_commit_buffer off while walking
the reachable objects.  Releasing the memory for commit object
data that we do not use matters for large projects (for example,
about 90MB is saved while traversing linux-2.6 history).

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * The linux-2.6 history number for me is inflated because I
   have grafts that connects historical archive behind the
   current v2.6.12-rc2 based history...

 builtin-prune.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-prune.c b/builtin-prune.c
index 00a53b3..b469c43 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -253,6 +253,8 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 		usage(prune_usage);
 	}
 
+	save_commit_buffer = 0;
+
 	/*
 	 * Set up revision parsing, and mark us as being interested
 	 * in all object types, not just commits.
