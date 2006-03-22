From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH] Cogito: Allow https:// URLs
Date: Wed, 22 Mar 2006 12:45:08 +0100
Message-ID: <20060322114508.G66c5922@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Mar 22 12:45:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FM1mQ-0001aB-Jv
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 12:45:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWCVLpS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 06:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWCVLpS
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 06:45:18 -0500
Received: from ncs.stosberg.net ([217.195.44.246]:30122 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1750705AbWCVLpQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Mar 2006 06:45:16 -0500
Received: from leonov (p213.54.82.166.tisdip.tiscali.de [213.54.82.166])
	by ncs.stosberg.net (Postfix) with ESMTP id D2FD5AEBA00D
	for <git@vger.kernel.org>; Wed, 22 Mar 2006 12:45:06 +0100 (CET)
Received: by leonov (Postfix, from userid 500)
	id 5287FE554F; Wed, 22 Mar 2006 12:45:09 +0100 (CET)
To: git@vger.kernel.org
Content-Disposition: inline
X-ICQ: 63537718
X-PGP-Key: 94951CAB
User-Agent: mutt-ng/devel-r790 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17812>


Hello,

Two trivial changes allow Cogito to pull from and push to https://
URLs.  The list of available transports in cg-branch-add is being
updated as well.

Thanks, 
Dennis

[Please CC me, I'm not subscribed to this list]

---

 cg-branch-add |    6 ++++--
 cg-fetch      |    2 +-
 cg-push       |    2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/cg-branch-add b/cg-branch-add
index 4cb5a26..6c7b222 100755
--- a/cg-branch-add
+++ b/cg-branch-add
@@ -27,10 +27,12 @@
 #
 # 3. HTTP - `http://host/path`
 #
-# 4. SSH - `git+ssh://host/path` or `host:path` (the latter can change);
+# 4. HTTPS - `https://host/path`
+#
+# 5. SSH - `git+ssh://host/path` or `host:path` (the latter can change);
 #    note that the path must be absolute in the first case.
 #
-# 5. GIT-Daemon - `git://host/path` - this won't clone tags.
+# 6. GIT-Daemon - `git://host/path` - this won't clone tags.
 #
 #
 # The URL can have a fragment part, which identifies a branch inside of
diff --git a/cg-fetch b/cg-fetch
index 9f41124..e8a51e8 100755
--- a/cg-fetch
+++ b/cg-fetch
@@ -288,7 +288,7 @@ orig_head=
 
 packed_transport=
 
-if echo "$uri" | grep -q "^http://"; then
+if echo "$uri" | grep -q "^https\?://"; then
 	get=get_http
 	fetch=fetch_http
 elif echo "$uri" | grep -q "^git+ssh://"; then
diff --git a/cg-push b/cg-push
index fb212db..b6b8954 100755
--- a/cg-push
+++ b/cg-push
@@ -68,7 +68,7 @@ if echo "$uri" | grep -q '#'; then
 fi
 sprembranch=":refs/heads/$rembranch"
 
-if [ "${uri#http://}" != "$uri" ]; then
+if [ "${uri#http://}" != "$uri" -o "${uri#https://}" != "$uri" ]; then
 	# git-http-push doesn't like $sprembranch
 	git-http-push "$uri/" "$locbranch:$rembranch"
 elif [ "${uri#git+ssh://}" != "$uri" ]; then
-- 
1.2.GIT
