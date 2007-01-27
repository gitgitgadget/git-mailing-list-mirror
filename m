From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/3] write_in_full: size_t is unsigned.
Date: Fri, 26 Jan 2007 17:49:10 -0800
Message-ID: <7vlkjpqlwp.fsf@assigned-by-dhcp.cox.net>
References: <11698503133039-git-send-email-nico@cam.org>
	<7vbqkluzcm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Jan 27 02:49:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAch0-0001gs-K1
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 02:49:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265AbXA0BtQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 20:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752266AbXA0BtQ
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 20:49:16 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:34244 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbXA0BtP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 20:49:15 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070127014911.LUSQ19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Fri, 26 Jan 2007 20:49:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id G1oD1W0071kojtg0000000; Fri, 26 Jan 2007 20:48:13 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37912>

It received the return value from xwrite() in a size_t variable
'written' and expected comparison with 0 would catch an error
from xwrite().

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * and this is the third bug t7207-co.sh caught.  I haven't
   bothered to look at the assembly, but I suspect the error
   return path could have been totally optimized out X-<.

 write_or_die.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/write_or_die.c b/write_or_die.c
index 046e79d..5c4bc85 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -23,7 +23,7 @@ int write_in_full(int fd, const void *buf, size_t count)
 	ssize_t total = 0;
 
 	while (count > 0) {
-		size_t written = xwrite(fd, p, count);
+		ssize_t written = xwrite(fd, p, count);
 		if (written < 0)
 			return -1;
 		if (!written) {
-- 
1.5.0.rc2.g8ac6-dirty
