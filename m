From: Steven Cole <elenstev@mesatop.com>
Subject: [PATCH] Add help details to git help command.
Date: Sun, 17 Apr 2005 22:42:26 -0600
Message-ID: <200504172242.26326.elenstev@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 06:42:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNO5n-0001gR-FY
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 06:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVDREqb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 00:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVDREqb
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 00:46:31 -0400
Received: from taco.zianet.com ([216.234.192.159]:51972 "HELO taco.zianet.com")
	by vger.kernel.org with SMTP id S261656AbVDREqV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 00:46:21 -0400
Received: (qmail 39555 invoked from network); 18 Apr 2005 04:46:19 -0000
Received: from 216-31-65-214.zianet.com (216.31.65.214)
  by 0 with SMTP; 18 Apr 2005 04:46:19 -0000
To: Petr Baudis <pasky@ucw.cz>
User-Agent: KMail/1.6.1
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

There's a patch at the bottom of this, so please look at that first before
my reading my whining immediately below.

I'm having some troubles with git pull, so this is just an ordinary diff.
Otherwise, I would have used the in-house diff command.

<troubles>
patch: **** Only garbage was found in the patch input.
</troubles>
<more troubles>
Tracked branch, applying changes...
error: bad signature
error: verify header failed
read_cache: Invalid argument
error: bad signature
error: verify header failed
error: bad signature
error: verify header failed
</more troubles>

Anyway, it's late, and I'm sure there is an easy fix to the above.

Here is a patch which provides the comment lines in the associated
script files when the git help command is invoked with an argument
thusly:

[steven@spc git-pasky-new]$ ./git help merge

 Merge a branch to the current tree.
 Copyright (c) Petr Baudis, 2005

 Takes a parameter identifying the branch to be merged.
 Optional "-b base_commit" parameter specifies the base for the
 merge. "-a" parameter may come first to tell git merge
 to check out the full tree to the merge tree.

 It creates a new ,,merge/ directory, which is git-controlled
 but has only the changed files checked out. You then have to
 examine it and then do git commit, which will also automatically
 bring your working tree up-to-date.

---------
This patch will provide the comment lines in the shell script associated
with the command, cleaned up a bit for presentation.

BUGS: This will also print any comments in the entire file, which may
not be desired.  If a command name and shell script filename
do not follow the usual convention, this won't work, e.g. ci for commit.

Signed-off-by: Steven Cole <elenstev@mesatop.com>

--- gp-newest-orig/git	2005-04-17 22:16:55.000000000 -0600
+++ gp-newest/git	2005-04-17 22:19:49.000000000 -0600
@@ -19,6 +19,11 @@
 
 
 help () {
+
+command=$1
+scriptfile=git$command.sh
+
+if [ ! $command ]; then
 	cat <<__END__
 The GIT scripted toolkit  $(gitversion.sh)
 
@@ -48,7 +53,10 @@
 	update		COMMIT_ID
 	version
 
+Additional help is available with: git help COMMAND
+
 Note that these expressions can be used interchangably as "ID"s:
+
 	empty string (current HEAD)
 	local (the local branch if tracking a remote one)
 	remote name (as registered with git addremote)
@@ -57,6 +65,10 @@
 	commit object hash (as returned by commit-id)
 	tree object hash (accepted only by some commands)
 __END__
+fi
+if [ ! $scriptfile = "git.sh" ]; then
+grep ^# $scriptfile | grep -v "!/bin" | cut -c 2-
+fi
 }
 
 
