From: Finn Arne Gangstad <finnag@pvv.org>
Subject: [PATCH 4/7] git push: Display warning on unconfigured default push
Date: Mon,  9 Mar 2009 23:35:48 +0100
Message-ID: <1236638151-6465-5-git-send-email-finnag@pvv.org>
References: <1236638151-6465-1-git-send-email-finnag@pvv.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 00:22:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgonm-0003QR-Jk
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 00:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775AbZCIXUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 19:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753564AbZCIXUq
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 19:20:46 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:36513 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753538AbZCIXUo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 19:20:44 -0400
Received: from decibel.pvv.ntnu.no
	([129.241.210.179] helo=localhost.localdomain ident=finnag)
	by decibel.pvv.ntnu.no with esmtp (Exim 4.69)
	(envelope-from <finnag@pvv.org>)
	id 1Lgo5B-0002Lo-Sw
	for git@vger.kernel.org; Mon, 09 Mar 2009 23:36:31 +0100
X-Mailer: git-send-email 1.6.2.99.g52e77
In-Reply-To: <1236638151-6465-1-git-send-email-finnag@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112759>

As a preparation for a possible future "git push" default behaviour change,
display a prominent warning for operations that may change behaviour
in the future. The warning explains for the user how to configure this
permanently so the warning will not be seen again after proper configuration.

Signed-off-by: Finn Arne Gangstad <finnag@pvv.org>
---
 builtin-push.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 5706c99..b9fe206 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -74,11 +74,34 @@ static void setup_push_current(struct remote *remote)
 						branch->merge[n]->src));
 }
 
+static const char *warn_unconfigured_push_msg[] = {
+	"You did not specify any refspecs to push, and the current remote",
+	"has not configured any push refspecs. The default action in this",
+	"case has been to push all matching refspecs, that is, all branches",
+	"that exist both locally and remotely will be updated.",
+	"This default may change in the future.",
+	"",
+	"You can specify what action you want to take in this case, and",
+	"avoid seeing this message again, by configuring 'push.default' to:",
+	"  'nothing'  : Do not push anythig",
+	"  'matching' : Push all matching branches (the current default)",
+	"  'current'  : Push the current branch to whatever it is tracking",
+	""
+};
+
+static void warn_unconfigured_push()
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(warn_unconfigured_push_msg); i++)
+		warning("%s", warn_unconfigured_push_msg[i]);
+}
+
 static void handle_default_push(struct remote *remote, int *flags)
 {
 	git_config(git_default_config, NULL);
 	switch (push_default) {
 	case PUSH_DEFAULT_UNSPECIFIED:
+		warn_unconfigured_push();
 		/* fallthrough */
 
 	case PUSH_DEFAULT_MATCHING:
-- 
1.6.2.105.g6ff1f.dirty
