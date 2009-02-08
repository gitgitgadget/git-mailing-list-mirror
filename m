From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] rev-list: fix showing distance when using --bisect-all
Date: Sun, 8 Feb 2009 15:54:47 +0100
Message-ID: <20090208155447.a56eeb26.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 15:58:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWB7P-0004DO-8y
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 15:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbZBHOz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 09:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbZBHOz0
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 09:55:26 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:35580 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751593AbZBHOzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 09:55:25 -0500
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id BC56C4B0034;
	Sun,  8 Feb 2009 15:55:17 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with SMTP id 7D21D4B014F;
	Sun,  8 Feb 2009 15:55:14 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108985>

Since commit d467a52 ("Make '--decorate' set an explicit 'show_decorations'
flag", Nov 3 2008), "git rev-list --bisect-all" doesn't show the distance
any more when displaying the best bisection commits.

For example:

$ git rev-list --bisect-all HEAD --not HEAD^

gives:

621f1b4bcf40f1469fc59202248df35619e33c82

instead of:

621f1b4bcf40f1469fc59202248df35619e33c82 (dist=0)

This patch fixes that.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-rev-list.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 857742a..436afa4 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -608,6 +608,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		if (!strcmp(arg, "--bisect-all")) {
 			bisect_list = 1;
 			bisect_find_all = 1;
+			revs.show_decorations = 1;
 			continue;
 		}
 		if (!strcmp(arg, "--bisect-vars")) {
-- 
1.6.2.rc0.dirty
