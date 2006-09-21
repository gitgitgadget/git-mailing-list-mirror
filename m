From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 4/5] pack-refs: do not pack symbolic refs.
Date: Thu, 21 Sep 2006 00:06:05 -0700
Message-ID: <7vmz8taeci.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0609111158390.3960@g5.osdl.org>
	<Pine.LNX.4.64.0609111632050.27779@g5.osdl.org>
	<7vy7shr5zw.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609180934360.4388@g5.osdl.org>
	<7v64fhd7ns.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 09:06:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQIdY-0004D0-EV
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 09:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWIUHGN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 03:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWIUHGN
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 03:06:13 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:62111 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750767AbWIUHGG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 03:06:06 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060921070606.HLII6711.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Sep 2006 03:06:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Qv5r1V00K1kojtg0000000
	Thu, 21 Sep 2006 03:05:52 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27461>

Now we can tell which one is symbolic and which one is not, it
is easy to do so.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-pack-refs.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index 9871089..0fc8a55 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -14,7 +14,9 @@ static int handle_one_ref(const char *pa
 {
 	FILE *refs_file = cb_data;
 
-	fprintf(refs_file, "%s %s\n", sha1_to_hex(sha1), path);
+	/* Do not pack the symbolic refs */
+	if (!(flags & REF_ISSYMREF))
+		fprintf(refs_file, "%s %s\n", sha1_to_hex(sha1), path);
 	return 0;
 }
 
-- 
1.4.2.1.g4dc7
