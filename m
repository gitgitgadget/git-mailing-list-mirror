From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 2/4] git-commit: set GIT_EDITOR=: if editor will not be launched
Date: Mon, 21 Jan 2008 15:06:45 +0100
Message-ID: <3e99e048c3f249bb0440ec6ab221ef622a2db825.1200933409.git.bonzini@gnu.org>
References: <2885c7896ba72adee6bc5c9e2210a8881904f601.head.git.bonzini@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 13:21:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM0KT-0006Pl-Gm
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 13:21:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754066AbYBDMUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 07:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753744AbYBDMUq
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 07:20:46 -0500
Received: from fencepost.gnu.org ([140.186.70.10]:42351 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753673AbYBDMUp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 07:20:45 -0500
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1JM0JY-0007oE-6U
	for git@vger.kernel.org; Mon, 04 Feb 2008 07:20:44 -0500
In-Reply-To: <2885c7896ba72adee6bc5c9e2210a8881904f601.head.git.bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72497>

This is a preparatory patch that provides a simple way for the future
prepare-commit-msg hook to discover if the editor will be launched.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>

---
 Documentation/hooks.txt |    4 ++++
 builtin-commit.c        |    2 ++
 2 files changed, 6 insertions(+)

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
index fc59660..955cc84 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -593,6 +593,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		use_editor = 0;
 	if (edit_flag)
 		use_editor = 1;
+	if (!use_editor)
+		setenv("GIT_EDITOR", ":", 1);
 
 	if (get_sha1("HEAD", head_sha1))
 		initial_commit = 1;
