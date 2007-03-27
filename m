From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Bisect: add checks at the beginning of "git bisect run".
Date: Tue, 27 Mar 2007 06:49:57 +0200
Message-ID: <20070327064957.34dad72a.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 06:42:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW3VP-0003Lk-P5
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 06:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933059AbXC0Elp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 00:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933078AbXC0Elp
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 00:41:45 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:55297 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933059AbXC0Elp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 00:41:45 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 486E6B5A50;
	Tue, 27 Mar 2007 06:41:43 +0200 (CEST)
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43227>

We may be able to "run" with only one good revision given
and then verify that the result of the first run is bad.
And perhaps also the other way around.

But for now let's check that we have at least one bad and
one good revision before we start to run.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index fda1712..57d6754 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -223,6 +223,14 @@ bisect_replay () {
 }
 
 bisect_run () {
+    # Check that we have everything to run correctly.
+    test -d "$GIT_DIR/refs/bisect" || {
+	echo >&2 'You need to start by "git bisect start".'
+	echo >&2 'And then by "git bisect bad" and "git bisect good".'
+	exit 1
+    }
+    bisect_next_check fail
+
     while true
     do
       echo "running $@"
-- 
1.5.1.rc2.2.gcc08
