From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] bisect: fix missing "exit"
Date: Sun, 9 Nov 2008 15:25:55 +0100
Message-ID: <20081109152555.8407cee0.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 15:24:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzBDj-0002ZB-TU
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 15:24:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755003AbYKIOXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 09:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754920AbYKIOXk
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 09:23:40 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:39419 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754890AbYKIOXj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 09:23:39 -0500
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id E210C19743;
	Sun,  9 Nov 2008 15:23:37 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g19.free.fr (Postfix) with SMTP id 6E36B197AB;
	Sun,  9 Nov 2008 15:23:37 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100446>

In my previous patch:

6a54d97 (2008-09-06 07:27:03 +0200 Christian Couder) bisect: remove "checkout_done" variable used when checking merge bases

I forgot to move '|| exit' to a line above.

This patch should fix that.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 79de701..0d0e278 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -455,7 +455,7 @@ bisect_next() {
 	good=$(git for-each-ref --format='^%(objectname)' \
 		"refs/bisect/good-*" | tr '\012' ' ') &&
 	skip=$(git for-each-ref --format='%(objectname)' \
-		"refs/bisect/skip-*" | tr '\012' ' ') &&
+		"refs/bisect/skip-*" | tr '\012' ' ') || exit
 
 	# Maybe some merge bases must be tested first
 	check_good_are_ancestors_of_bad "$bad" "$good" "$skip"
-- 
1.6.0.3.614.g0f3b9
