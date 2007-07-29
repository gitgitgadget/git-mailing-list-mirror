From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] symbolic-ref, update-ref: do not refuse reflog
 message with LF
Date: Sat, 28 Jul 2007 18:10:51 -0700
Message-ID: <7vps2cnhes.fsf_-_@assigned-by-dhcp.cox.net>
References: <724DFB31-0471-4A5E-95DF-F5F74876AC77@lrde.epita.fr>
	<7v8x90sp25.fsf@assigned-by-dhcp.cox.net>
	<20070728083536.540e471d.seanlkml@sympatico.ca>
	<7vodhwptba.fsf@assigned-by-dhcp.cox.net>
	<20070728092914.48f6305c.seanlkml@sympatico.ca>
	<7vk5skps1g.fsf@assigned-by-dhcp.cox.net>
	<20070728101156.20304d11.seanlkml@sympatico.ca>
	<7vd4ycp8ff.fsf@assigned-by-dhcp.cox.net>
	<7vzm1gnhin.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benoit SIGOURE <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sun Jul 29 03:10:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IExJA-0001Be-Nv
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 03:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758600AbXG2BKy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 21:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757752AbXG2BKy
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 21:10:54 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:47833 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569AbXG2BKx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 21:10:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070729011051.ZCTQ1349.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sat, 28 Jul 2007 21:10:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id VDAr1X00T1kojtg0000000; Sat, 28 Jul 2007 21:10:52 -0400
In-Reply-To: <7vzm1gnhin.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 28 Jul 2007 18:08:32 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54072>

Earlier these tools refused to create a reflog entry when the
message given by the calling Porcelain had a LF in it, partially
to keep the file format integrity of reflog file, which is
one-entry-per-line.  These tools should not be dictating such a
policy.

Instead, let the codepath to write out the reflog entry worry
about the format integrity and allow messages with LF in them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-symbolic-ref.c |    2 --
 builtin-update-ref.c   |    2 --
 2 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/builtin-symbolic-ref.c b/builtin-symbolic-ref.c
index d41b406..9eb95e5 100644
--- a/builtin-symbolic-ref.c
+++ b/builtin-symbolic-ref.c
@@ -43,8 +43,6 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 			msg = argv[1];
 			if (!*msg)
 				die("Refusing to perform update with empty message");
-			if (strchr(msg, '\n'))
-				die("Refusing to perform update with \\n in message");
 		}
 		else if (!strcmp("--", arg)) {
 			argc--;
diff --git a/builtin-update-ref.c b/builtin-update-ref.c
index feac2ed..8339cf1 100644
--- a/builtin-update-ref.c
+++ b/builtin-update-ref.c
@@ -23,8 +23,6 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 			msg = argv[++i];
 			if (!*msg)
 				die("Refusing to perform update with empty message.");
-			if (strchr(msg, '\n'))
-				die("Refusing to perform update with \\n in message.");
 			continue;
 		}
 		if (!strcmp("-d", argv[i])) {
-- 
1.5.3.rc3.24.g83b3d
