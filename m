From: marcnarc@xiplink.com
Subject: [PATCHv2] fetch: Only call a new ref a "branch" if it's under refs/heads/.
Date: Fri, 13 Apr 2012 13:08:24 -0400
Message-ID: <1334336904-18649-1-git-send-email-marcnarc@xiplink.com>
Cc: Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 19:08:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIjyb-00088f-RH
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 19:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755305Ab2DMRH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 13:07:57 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:27682 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750916Ab2DMRH4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Apr 2012 13:07:56 -0400
Received: from xiplink.com (rincewind.xiplink.com [192.168.1.166])
	by farnsworth.xiplink.com (8.14.2/8.14.2/Debian-2build1) with ESMTP id q3DH7spL010855;
	Fri, 13 Apr 2012 13:07:55 -0400
X-Mailer: git-send-email 1.7.10.2.ge89da
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195427>

From: Marc Branchaud <marcnarc@xiplink.com>

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

Re-rolled atop of Jens's fix.

Thanks guys -- glad I finally itched this scratch!

		M.


 builtin/fetch.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index cfb43df..b6f737e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -293,14 +293,18 @@ static int update_local_ref(struct ref *ref,
 		const char *msg;
 		const char *what;
 		int r;
-		if (!strncmp(ref->name, "refs/tags/", 10)) {
+		if (!prefixcmp(ref->name, "refs/tags/")) {
 			msg = "storing tag";
 			what = _("[new tag]");
 		}
-		else {
+		else if (!prefixcmp(ref->name, "refs/heads/")) {
 			msg = "storing head";
 			what = _("[new branch]");
 		}
+		else {
+			msg = "storing ref";
+			what = _("[new ref]");
+		}
 
 		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
 		    (recurse_submodules != RECURSE_SUBMODULES_ON))
-- 
1.7.10.2.ge89da
