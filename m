From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: [PATCH] Improved documentation for the ciabot scripts.
Date: Thu, 23 Aug 2012 00:10:53 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20120823041053.GA11353@thyrsus.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 23 06:12:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4OmB-00043p-9u
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 06:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967Ab2HWEL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 00:11:28 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:33795
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745Ab2HWEL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 00:11:27 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 4E534420EF; Thu, 23 Aug 2012 00:10:53 -0400 (EDT)
Content-Disposition: inline
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204110>

Signed-off-by: Eric S. Raymond <esr@thyrsus.com>
---
 contrib/ciabot/INSTALL |   39 +++++++++++++++++++++++++++++++++++++++
 contrib/ciabot/README  |   14 ++++++++++++--
 2 files changed, 51 insertions(+), 2 deletions(-)
 create mode 100644 contrib/ciabot/INSTALL

diff --git a/contrib/ciabot/INSTALL b/contrib/ciabot/INSTALL
new file mode 100644
index 0000000..dbfd165
--- /dev/null
+++ b/contrib/ciabot/INSTALL
@@ -0,0 +1,39 @@
+= Installation instructions =
+
+Two scripts are included.  The Python one (ciabot.py) is faster and
+more capable; the shell one (ciabot.sh) is a fallback in case Python
+gives your git hosting site indigestion. (I know of no such sites.)
+
+It is no longer necessary to modify the script in order to put it
+in place; in fact, this is now discouraged. It is entirely
+configurable with the following git config variables:
+
+ciabot.project = name of the project (required)
+ciabot.repo = name of the project repo for gitweb/cgit purposes
+ciabot.xmlrpc  = if true (default), ship notifications via XML-RPC
+ciabot.revformat = format in which the revision is shown
+
+The ciabot.repo value defaults to ciabot.project lowercased.
+
+The revformat variable may have the following values
+raw -> full hex ID of commit
+short -> first 12 chars of hex ID
+describe -> describe relative to last tag, falling back to short
+The default is 'describe'.
+
+Once you've set these variables, try your script with -n to see the
+notification message dumped to stdout and verify that it looks sane.
+
+After verifying correct function, install one of these scripts either
+in a post-commit hook or in an update hook.
+
+In post-commit, run it without arguments. It will query for
+current HEAD and the latest commit ID to get the information it
+needs.
+
+In update, call it with a refname followed by a list of commits:
+You want to reverse the order git rev-list emits because it lists
+from most recent to oldest.
+
+/path/to/ciabot.py ${refname} $(git rev-list ${oldhead}..${newhead} | tac)
+
diff --git a/contrib/ciabot/README b/contrib/ciabot/README
index 3b916ac..9eccca3 100644
--- a/contrib/ciabot/README
+++ b/contrib/ciabot/README
@@ -8,5 +8,15 @@ You probably want the Python version; it's faster, more capable, and
 better documented.  The shell version is maintained only as a fallback
 for use on hosting sites that don't permit Python hook scripts.
 
-You will find installation instructions for each script in its comment
-header.
+To test these scripts, your project needs to have been registered with
+the CIA site.  Here are the steps:
+
+1. Open an IRC window on irc://freenode/commits or your registered 
+   project IRC channel.  
+
+2. Run ciabot.py and/or ciabot.sh from any directory under git
+   control, using the -p option to pass in your project name.
+
+You should see a notification on the channel for your most recent commit.
+
+See the file INSTALL for installation instructions.
-- 
1.7.9.5

-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
