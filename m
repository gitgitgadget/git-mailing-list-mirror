From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] config: deprecate using "" as boolean value false.
Date: Mon, 11 Feb 2008 08:22:16 +0100
Message-ID: <20080211082216.e9212310.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 08:17:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOSuZ-00025K-Dq
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 08:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315AbYBKHQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 02:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752260AbYBKHQb
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 02:16:31 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:58290 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751908AbYBKHQU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 02:16:20 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 273D21AB2E6;
	Mon, 11 Feb 2008 08:16:19 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id C824A1AB2C4;
	Mon, 11 Feb 2008 08:16:18 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73474>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 config.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/config.c b/config.c
index 526a3f4..b5f1a11 100644
--- a/config.c
+++ b/config.c
@@ -300,8 +300,19 @@ int git_config_bool(const char *name, const char *value)
 {
 	if (!value)
 		return 1;
-	if (!*value)
+	if (!*value) {
+		fprintf(stderr,
+			"Warning: using an empty value for boolean config "
+			"variables is deprecated.\n"
+			"An empty value currently means 'false' as a "
+			"boolean, but may very well means 'true' in the "
+			"future!\n"
+			"Please consider using a 'false' value explicitely "
+			"for variable '%s', so that your config is future "
+			"proof. You can do that using:\n"
+			"\tgit config %s false\n", name, name);
 		return 0;
+	}
 	if (!strcasecmp(value, "true") || !strcasecmp(value, "yes"))
 		return 1;
 	if (!strcasecmp(value, "false") || !strcasecmp(value, "no"))
-- 
1.5.4.20.gc135a-dirty
