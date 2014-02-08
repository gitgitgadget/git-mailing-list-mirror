From: David Kastrup <dak@gnu.org>
Subject: [PATCH] builtin/blame.c::prepare_lines: fix allocation size of sb->lineno
Date: Sat,  8 Feb 2014 10:19:26 +0100
Message-ID: <1391851166-10393-1-git-send-email-dak@gnu.org>
Cc: David Kastrup <dak@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 08 10:20:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WC44r-0002kc-BX
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 10:19:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbaBHJTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Feb 2014 04:19:49 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:40488 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582AbaBHJTs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 04:19:48 -0500
Received: from localhost ([127.0.0.1]:39531 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WC44h-0001ov-2I; Sat, 08 Feb 2014 04:19:47 -0500
Received: by lola (Postfix, from userid 1000)
	id 71858E12E5; Sat,  8 Feb 2014 10:19:30 +0100 (CET)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241830>

If we are calling xrealloc on every single line, the least we can do
is get the right allocation size.

Signed-off-by: David Kastrup <dak@gnu.org>
---
This should be less contentious than the patch in
<URL:http://permalink.gmane.org/gmane.comp.version-control.git/241561>,
Message-ID: <1391550392-17118-1-git-send-email-dak@gnu.org> as it
makes no stylistic decisions whatsoever and only fixes a clear bug.

builtin/blame.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index e44a6bb..29eb31c 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1779,7 +1779,7 @@ static int prepare_lines(struct scoreboard *sb)
 	while (len--) {
 		if (bol) {
 			sb->lineno = xrealloc(sb->lineno,
-					      sizeof(int *) * (num + 1));
+					      sizeof(int) * (num + 1));
 			sb->lineno[num] = buf - sb->final_buf;
 			bol = 0;
 		}
@@ -1789,7 +1789,7 @@ static int prepare_lines(struct scoreboard *sb)
 		}
 	}
 	sb->lineno = xrealloc(sb->lineno,
-			      sizeof(int *) * (num + incomplete + 1));
+			      sizeof(int) * (num + incomplete + 1));
 	sb->lineno[num + incomplete] = buf - sb->final_buf;
 	sb->num_lines = num + incomplete;
 	return sb->num_lines;
-- 
1.8.3.2
