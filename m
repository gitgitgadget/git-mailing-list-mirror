From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 20/20] cvsserver Documentation: new cvs ... -r support
Date: Sat, 13 Oct 2012 23:42:33 -0600
Message-ID: <1350193353-19210-21-git-send-email-mmogilvi_git@miniinfo.net>
References: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 07:58:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNHDq-0007Eo-HX
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 07:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214Ab2JNF6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 01:58:17 -0400
Received: from qmta11.emeryville.ca.mail.comcast.net ([76.96.27.211]:54810
	"EHLO qmta11.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752043Ab2JNF6D (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 01:58:03 -0400
Received: from omta15.emeryville.ca.mail.comcast.net ([76.96.30.71])
	by qmta11.emeryville.ca.mail.comcast.net with comcast
	id Atxf1k0021Y3wxoABty3kb; Sun, 14 Oct 2012 05:58:03 +0000
Received: from mmogilvi.homeip.net ([24.9.53.136])
	by omta15.emeryville.ca.mail.comcast.net with comcast
	id Att21k00F2wKXRC8btt2t5; Sun, 14 Oct 2012 05:53:03 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id A39BA1E9601D; Sat, 13 Oct 2012 23:43:20 -0600 (MDT)
X-Mailer: git-send-email 1.7.10.2.484.gcd07cc5
In-Reply-To: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207634>

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 Documentation/git-cvsserver.txt | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 88d814a..940c2ba 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -359,6 +359,43 @@ Operations supported
 
 All the operations required for normal use are supported, including
 checkout, diff, status, update, log, add, remove, commit.
+
+Most CVS command arguments that read CVS tags or revision numbers
+(typically -r) work, and also support any git refspec
+(tag, branch, commit ID, etc).
+However, CVS revision numbers for non-default branches are not well
+emulated, and cvs log does not show tags or branches at
+all.  (Non-main-branch CVS revision numbers superficially resemble CVS
+revision numbers, but they actually encode a git commit ID directly,
+rather than represent the number of revisions since the branch point.)
+
+Note that there are two ways to checkout a particular branch.
+As described elsewhere on this page, the "module" parameter
+of cvs checkout is interpreted as a branch name, and it becomes
+the main branch.  It remains the main branch for a given sandbox
+even if you temporarily make another branch sticky with
+cvs update -r.  Alternatively, the -r argument can indicate
+some other branch to actually checkout, even though the module
+is still the "main" branch.  Tradeoffs (as currently
+implemented): Each new "module" creates a new database on disk with
+a history for the given module, and after the database is created,
+operations against that main branch are fast.  Or alternatively,
+-r doesn't take any extra disk space, but may be significantly slower for
+many operations, like cvs update.
+
+If you want to refer to a git refspec that has characters that are
+not allowed by CVS, you have two options.  First, it may just work
+to supply the git refspec directly to the appropriate CVS -r argument;
+some CVS clients don't seem to do much sanity checking of the argument.
+Second, if that fails, you can use a special character escape mechanism
+that only uses characters that are valid in CVS tags.  A sequence
+of 4 or 5 characters of the form (underscore (`"_"`), dash (`"-"`),
+one or two characters, and dash (`"-"`)) can encode various characters based
+on the one or two letters: `"s"` for slash (`"/"`), `"p"` for
+period (`"."`), `"u"` for underscore (`"_"`), or two hexadecimal digits
+for any byte value at all (typically an ASCII number, or perhaps a part
+of a UTF-8 encoded character).
+
 Legacy monitoring operations are not supported (edit, watch and related).
 Exports and tagging (tags and branches) are not supported at this stage.
 
-- 
1.7.10.2.484.gcd07cc5
