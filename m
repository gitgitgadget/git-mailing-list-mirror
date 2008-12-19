From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: [PATCH] Make git revert warn the user when reverting a merge commit.
Date: Thu, 18 Dec 2008 20:39:15 -0600
Message-ID: <200812182039.15169.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 19 03:41:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDVIg-0002h1-P6
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 03:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbYLSCjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 21:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbYLSCjD
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 21:39:03 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:59160 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbYLSCjA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 21:39:00 -0500
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.123])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LDVGW-00065y-7X
	for git@vger.kernel.org; Fri, 19 Dec 2008 02:39:00 +0000
X-Eric-Conspiracy: There is no conspiracy.
Content-Disposition: inline
X-UID: 7
X-Length: 2172
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103531>

Signed-off-by: Boyd Stephen Smith Jr <bss@iguanasuicide.net>
---
On Thursday 2008 December 18 18:21:25 Linus Torvalds wrote:
> I suspect we should warn about reverting merges.

Here is a patch (aginst c0ceb2c, which I believe is master currently) that
does just that.

After applying the patch I get the following test results:
fixed   1
success 4108
failed  0
broken  4
total   4113

 builtin-revert.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index 4038b41..7f121a5 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -296,6 +296,21 @@ static int revert_or_cherry_pick(int argc, const char 
**argv)
 		int cnt;
 		struct commit_list *p;
 
+		do {
+			switch (action) {
+			case REVERT:
+				warning("revert on a merge commit may not do what you expect.");
+				continue;
+			case CHERRY_PICK:
+				/* Cherry picking a merge doesn't merge the history, but
+				 * I don't think many people expect that.
+				 */
+				continue;
+			}
+			/* Unhandled enum member. */
+			die("Unknown action on a merge commit.");
+		} while (0);
+
 		if (!mainline)
 			die("Commit %s is a merge but no -m option was given.",
 			    sha1_to_hex(commit->object.sha1));
-- 
1.5.6
-- 
Boyd Stephen Smith Jr.                     ,= ,-_-. =. 
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-' 
http://iguanasuicide.net/                      \_/     
