From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 1/2] Print a sane error message if an alias expands to an invalid git command
Date: Sat, 10 Feb 2007 19:33:57 -0500
Message-ID: <1171154038778-git-send-email-tytso@mit.edu>
References: <11711540383470-git-send-email-tytso@mit.edu>
Cc: git@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 11 01:34:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HG2fQ-0007w2-3r
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 01:34:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbXBKAeD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 19:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752427AbXBKAeD
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 19:34:03 -0500
Received: from THUNK.ORG ([69.25.196.29]:58104 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752249AbXBKAeB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 19:34:01 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HG2kR-0003fT-4I; Sat, 10 Feb 2007 19:39:19 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HG2fG-0002AW-U5; Sat, 10 Feb 2007 19:33:58 -0500
X-Mailer: git-send-email 1.5.0.rc4.2.g4249
In-Reply-To: <11711540383470-git-send-email-tytso@mit.edu>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39269>

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 git.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index 82a8357..c43d4ff 100644
--- a/git.c
+++ b/git.c
@@ -387,8 +387,15 @@ int main(int argc, const char **argv, char **envp)
 		done_alias = 1;
 	}
 
-	if (errno == ENOENT)
+	if (errno == ENOENT) {
+		if (done_alias) {
+			fprintf(stderr, "Expansion of alias '%s' failed; "
+				"'%s' is not a git-command\n",
+				cmd, argv[0]);
+			exit(1);
+		}
 		help_unknown_cmd(cmd);
+	}
 
 	fprintf(stderr, "Failed to run command '%s': %s\n",
 		cmd, strerror(errno));
-- 
1.5.0.rc4.2.g4249
