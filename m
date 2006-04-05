From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] parse_date(): fix parsing 03/10/2006
Date: Tue, 04 Apr 2006 23:00:04 -0700
Message-ID: <7vodzg4l5n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>
X-From: git-owner@vger.kernel.org Wed Apr 05 08:00:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FR13u-0006YT-LZ
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 08:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWDEGAJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 02:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWDEGAJ
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 02:00:09 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:19181 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751104AbWDEGAH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Apr 2006 02:00:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060405060006.EQSC20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Apr 2006 02:00:06 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18412>

The comment associated with the date parsing code for three
numbers separated with slashes or dashes implied we wanted to
interpret using this order:

	yyyy-mm-dd
	yyyy-dd-mm
	mm-dd-yy
	dd-mm-yy

However, the actual code had the last two wrong, and making it
prefer dd-mm-yy format over mm-dd-yy.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
 * Spotted, thanks to Len Brown and Andrew Morton.

 date.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

f5cd7df6e8322a0b783668b31881ab95a5ce33bd
diff --git a/date.c b/date.c
index 416ea57..18a0710 100644
--- a/date.c
+++ b/date.c
@@ -257,10 +257,10 @@ static int match_multi_number(unsigned l
 				break;
 		}
 		/* mm/dd/yy ? */
-		if (is_date(num3, num2, num, tm))
+		if (is_date(num3, num, num2, tm))
 			break;
 		/* dd/mm/yy ? */
-		if (is_date(num3, num, num2, tm))
+		if (is_date(num3, num2, num, tm))
 			break;
 		return 0;
 	}
-- 
1.3.0.rc2.g110c
