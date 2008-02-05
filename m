From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH-v2 2/4] git-commit: set GIT_EDITOR=: if editor will not be launched
Date: Tue,  5 Feb 2008 11:01:45 +0100
Message-ID: <1202205704-10024-2-git-send-email-bonzini@gnu.org>
References: <1202205704-10024-1-git-send-email-bonzini@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 11:52:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMLPZ-0003uq-Bu
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 11:52:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756302AbYBEKvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 05:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756267AbYBEKvb
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 05:51:31 -0500
Received: from fencepost.gnu.org ([140.186.70.10]:36289 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756203AbYBEKv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 05:51:28 -0500
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1JMLOh-000237-LL
	for git@vger.kernel.org; Tue, 05 Feb 2008 05:51:27 -0500
X-Mailer: git-send-email 1.5.4.1138.g882bc-dirty
In-Reply-To: <1202205704-10024-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72645>

This is a preparatory patch that provides a simple way for the future
prepare-commit-msg hook to discover if the editor will be launched.
---
 Documentation/hooks.txt |    4 ++++
 builtin-commit.c        |    2 ++
 2 files changed, 6 insertions(+), 0 deletions(-)

	This has not changed.

diff --git a/Documentation/hooks.txt b/Documentation/hooks.txt
index f110162..e8d80cf 100644
--- a/Documentation/hooks.txt
+++ b/Documentation/hooks.txt
@@ -61,6 +61,10 @@ The default 'pre-commit' hook, when enabled, catches introduction
 of lines with trailing whitespaces and aborts the commit when
 such a line is found.
 
+All the `git-commit` hooks are invoked with the environment
+variable `GIT_EDITOR=:` if the command will not bring up an editor
+to modify the commit message.
+
 commit-msg
 ----------
 
diff --git a/builtin-commit.c b/builtin-commit.c
index 405c8b5..7d1059c 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -599,6 +599,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		use_editor = 0;
 	if (edit_flag)
 		use_editor = 1;
+	if (!use_editor)
+		setenv("GIT_EDITOR", ":", 1);
 
 	if (get_sha1("HEAD", head_sha1))
 		initial_commit = 1;
-- 
1.5.3.4.910.gc5122-dirty
