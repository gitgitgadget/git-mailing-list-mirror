From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] --amend Rename --pretty=changelog to --pretty=gnucl
Date: Sat, 03 Mar 2007 04:38:35 -0800
Message-ID: <7v649icxis.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702271621120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0702280258200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<alpine.LRH.0.82.0702272147590.29426@xanadu.home>
	<Pine.LNX.4.63.0702281343200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vslcoghcd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Simon Josefsson <simon@josefsson.org>, junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 03 13:38:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNTVY-0001YI-6G
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 13:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbXCCMih (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 07:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbXCCMih
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 07:38:37 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:52130 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030220AbXCCMig (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 07:38:36 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070303123835.HBXV3546.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Mar 2007 07:38:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WCeb1W00L1kojtg0000000; Sat, 03 Mar 2007 07:38:36 -0500
In-Reply-To: <7vslcoghcd.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 02 Mar 2007 00:49:54 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41291>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Earlier, this code played dumb by outputting the file name and the comma
> separately (to make it easier to determine when to output a colon
> instead of the comma). This misguided code is fixed by this patch.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	I know that this is a dead topic branch, but I did not want
> 	to leave buggy code behind for future reference.

Huh?  How did you measure bugginess before and after the change?

$ ./git show -s --pretty=gnucl ':/convert object type h'
2007-02-26  Nicolas Pitre <nico@cam.org>

* archive-tar.c, archive-zip.c, blob.c, builtin-apply.c, 
          uiltin-blame.c, builtin-cat-file.c, builtin-commit-tree.c, 
          uiltin-for-each-ref.c, builtin-grep.c, builtin-log.c, 
          uiltin-pack-objects.c, builtin-prune.c, builtin-reflog.c, 
          uiltin-unpack-objects.c, cache.h, combine-diff.c, commit.c, 
          onvert-objects.c, diff.c, entry.c, fast-import.c, http-push.c, 
          ndex-pack.c, merge-file.c, merge-recursive.c, merge-tree.c, 
          ktag.c, mktree.c, object.c, object.h, pack-check.c, read-cache.c,
          sha1_file.c, tag.c, tree-diff.c, tree.c, unpack-file.c: convert
          object type handling from a string to a number


Perhaps you would want something like this...

diff --git a/utf8.c b/utf8.c
index ea23a6e..3a7b923 100644
--- a/utf8.c
+++ b/utf8.c
@@ -268,7 +268,9 @@ int print_wrapped_text(const char *text, int indent, int indent2, int width)
 			}
 			else {
 				putchar('\n');
-				text = bol = space + 1;
+				if (isspace(*space))
+					space++;
+				text = bol = space;
 				space = NULL;
 				w = indent = indent2;
 			}
