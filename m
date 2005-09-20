From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 3/8] cogito: "cg-object-id -p" should separate its output
	by newlines
Date: Mon, 19 Sep 2005 22:14:56 -0400
Message-ID: <1127182496.31115.21.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 20 04:15:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHXev-00051T-Uc
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 04:15:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbVITCO7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 22:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbVITCO7
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 22:14:59 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:43435 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S964831AbVITCO6
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 22:14:58 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EHXer-0006BX-RZ
	for git@vger.kernel.org; Mon, 19 Sep 2005 22:14:58 -0400
Received: from proski by dv.roinet.com with local (Exim 4.52)
	id 1EHXeq-0001hK-M3
	for git@vger.kernel.org; Mon, 19 Sep 2005 22:14:56 -0400
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8955>

"cg-object-id -p" should separate its output by newlines.

If there are several parents, they should be separated by newlines, not
by spaces.  That's what cg-diff expects.

diff --git a/cg-Xnormid b/cg-Xnormid
--- a/cg-Xnormid
+++ b/cg-Xnormid
@@ -17,11 +17,11 @@
 id="$1"
 
 if [ "${id:(-1):1}" = "^" ]; then
 	# find parent
 	id=$(cg-object-id "${id%^}") || exit 1
-	git-cat-file commit "$id" | awk '/^parent/{print $2," "};/^$/{exit}' || exit 1
+	git-cat-file commit "$id" | awk '/^parent/{print $2};/^$/{exit}' || exit 1
 	exit
 fi
 
 if [ ! "$id" ] || [ "$id" = "this" ] || [ "$id" = "HEAD" ]; then
 	read id < "$_git/HEAD"
diff --git a/cg-object-id b/cg-object-id
--- a/cg-object-id
+++ b/cg-object-id
@@ -9,12 +9,12 @@
 #
 # OPTIONS
 # -------
 # -p::
 #	Get ID of parent commit(s) to a given revision or HEAD.
-#	NOTE: Multiple SHA1s will be returned for commits with multiple
-#	parents.
+#	NOTE: Multiple SHA1s separated by newlines will be returned for
+#	commits with multiple parents.
 #
 # -t::
 #	Get ID of tree associated with given commit or HEAD.
 #
 # OBJECT_ID::
@@ -53,11 +53,11 @@ if [ "$show_parent" ]; then
 fi
 
 normid=$(. ${COGITO_LIB}cg-Xnormid "$id") || exit 1
 
 if [ "$show_parent" ]; then
-	echo ${normid% *}
+	echo "${normid% *}"
 	exit 0
 fi
 
 type=${normid#* }
 normid=${normid% *}



-- 
Regards,
Pavel Roskin
