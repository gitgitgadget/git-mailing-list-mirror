From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 5/8] cogito: Simplify recursion in cg-object-id.
Date: Mon, 19 Sep 2005 22:21:34 -0400
Message-ID: <1127182894.31115.29.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 20 04:22:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHXlP-0006Gp-E8
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 04:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbVITCVh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 22:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbVITCVg
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 22:21:36 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:2732 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S964842AbVITCVg
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 22:21:36 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EHXlH-0006I4-8u
	for git@vger.kernel.org; Mon, 19 Sep 2005 22:21:35 -0400
Received: from proski by dv.roinet.com with local (Exim 4.52)
	id 1EHXlG-0001i7-Eh
	for git@vger.kernel.org; Mon, 19 Sep 2005 22:21:34 -0400
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8957>

Simplify recursion in cg-object-id.

It's not needed to call the whole cg-object-id script from itself.  It's
sufficient to call normalize_id() from itself.

diff --git a/cg-object-id b/cg-object-id
--- a/cg-object-id
+++ b/cg-object-id
@@ -32,12 +32,12 @@ normalize_id()
 {
 	local id="$1"
 
 	if [ "${id:(-1):1}" = "^" ]; then
 		# find first parent
-		id=$(cg-object-id "${id%^}") || exit 1
-		normid=$(git-cat-file commit "$id" | \
+		normalize_id "${id%^}"
+		normid=$(git-cat-file commit "$normid" | \
 			 awk '/^parent/{print $2; exit};/^$/{exit}') || exit 1
 		type="commit"
 		return
 	fi
 


-- 
Regards,
Pavel Roskin
