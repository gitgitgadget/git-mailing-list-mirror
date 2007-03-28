From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Bisect: Improve error message in "bisect_next_check".
Date: Wed, 28 Mar 2007 05:19:53 +0200
Message-ID: <20070328051953.82456ba6.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 05:11:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWOZf-0003Qg-8v
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 05:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbXC1DLo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 23:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752834AbXC1DLo
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 23:11:44 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:52111 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752817AbXC1DLn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 23:11:43 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 20655B61F4;
	Wed, 28 Mar 2007 05:11:42 +0200 (CEST)
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43347>

So we can remove the specific message in "bisect_run".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---

Junio C Hamano wrote:

> Doesn't that suggest the existing messages from "git bisect good/bad"
> can use the same improvement you added only to "bisect run"?

You mean something like this patch ?


 git-bisect.sh |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 57d6754..47f0b8b 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -123,7 +123,12 @@ bisect_next_check() {
 	case "$next_ok,$1" in
 	no,) false ;;
 	no,fail)
-	    echo >&2 'You need to give me at least one good and one bad revisions.'
+	    USE_START=''
+	    test -d "$GIT_DIR/refs/bisect" ||
+	        USE_START='start by "git bisect start" and then'
+	    echo >&2 'You need to' $USE_START\
+		'give me at least one good and one bad revisions' \
+		'by "git bisect good" and "git bisect bad".'
 	    exit 1 ;;
 	*)
 	    true ;;
@@ -223,12 +228,6 @@ bisect_replay () {
 }
 
 bisect_run () {
-    # Check that we have everything to run correctly.
-    test -d "$GIT_DIR/refs/bisect" || {
-	echo >&2 'You need to start by "git bisect start".'
-	echo >&2 'And then by "git bisect bad" and "git bisect good".'
-	exit 1
-    }
     bisect_next_check fail
 
     while true
-- 
1.5.1.rc2.15.g465b3-dirty
