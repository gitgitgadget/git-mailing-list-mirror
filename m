From: David Greaves <david@dgreaves.com>
Subject: [PATCH] Docs update
Date: Thu, 21 Apr 2005 21:40:44 +0100
Message-ID: <42680FCC.6030901@dgreaves.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070800080501010103050305"
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 22:37:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOiPu-0000ga-QB
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 22:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVDUUlX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 16:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVDUUlX
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 16:41:23 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:17039 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261867AbVDUUks (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 16:40:48 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 27CDDE6D90; Thu, 21 Apr 2005 21:38:55 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 04296-04; Thu, 21 Apr 2005 21:38:55 +0100 (BST)
Received: from oak.dgreaves.com (modem-2040.lynx.dialup.pol.co.uk [217.135.199.248])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 22635E6D4F; Thu, 21 Apr 2005 21:38:53 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DOiTc-0002fh-9v; Thu, 21 Apr 2005 21:40:44 +0100
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------070800080501010103050305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added commit-tree, diff-cache and environment info


Signed-off-by: David Greaves <david@dgreaves.com>
---


--------------070800080501010103050305
Content-Type: text/plain;
 name="README.reference.patch2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="README.reference.patch2"

Index: README.reference
===================================================================
--- c0260bfb82da04aeff4e598ced5295d6ae2e262d/README.reference  (mode:100644 sha1:8186a561108d3c62625614272bd5e2f7d5826b4b)
+++ 5f204110aef2538fdc512e09e4a075b3afac8eff/README.reference  (mode:100644 sha1:b5fc4fb969ec3f52877408c8df4ba131a8c4a7b2)
@@ -109,12 +109,173 @@
 
 ################################################################
 commit-tree
-	commit-tree <sha1> [-p <sha1>]* < changelog
+	commit-tree <sha1> [-p <parent sha1>...] < changelog
 
+Creates a new commit object based on the provided tree object and
+emits the new commit object id on stdout. If no parent is given then
+it is considered to be an initial tree.
+
+A commit object usually has 1 parent (a commit after a change) or 2
+parents (a merge) although there is no reason it cannot have more than
+2 parents.
+
+While a tree represents a particular directory state of a working
+directory, a commit represents that state in "time", and explains how
+to get there.
+
+Normally a commit would identify a new "HEAD" state, and while git
+doesn't care where you save the note about that state, in practice we
+tend to just write the result to the file ".git/HEAD", so that we can
+always see what the last committed state was.
+
+Options
+
+<sha1>
+	An existing tree object
+
+-p <parent sha1>
+	Each -p indicates a the id of a parent commit object.
+	
+
+Commit Information
+
+A commit encapsulates:
+	all parent object ids
+	author name, email and date
+	committer name and email and the commit time.
+
+If not provided, commit-tree uses your name, hostname and domain to
+provide author and committer info. This can be overridden using the
+following environment variables.
+	AUTHOR_NAME
+	AUTHOR_EMAIL
+	AUTHOR_DATE
+	COMMIT_AUTHOR_NAME
+	COMMIT_AUTHOR_EMAIL
+(nb <,> and CRs are stripped)
+
+A commit comment is read from stdin (max 999 chars)
+
+see also: write-tree
+
+
+################################################################
+diff-cache
+	diff-cache [-r] [-z] <tree/commit sha1>
+
+Compares the content and mode of the blobs found via a tree object
+with the content of the current cache and, optionally, the stat state
+of the file on disk.
+
+(This is basically a special case of diff-tree that works with the
+current cache as the first tree.)
+
+<tree sha1>
+	The id of a tree or commit object to diff against.
+
+-r
+	recurse
+
+-z
+	/0 line termintation on output
+
+--cached
+	do not consider the on-disk file at all
+
+Output format:
+
+For files in the tree but not in the cache
+-<mode> <type>	<sha1>	<filename>
+
+For files in the cache but not in the tree
++<mode> <type>	<sha1>	<filename>
+
+For files that differ:
+*<tree-mode>-><cache-mode> <type>	<tree sha1>-><cache sha1>	path/<filename>
+
+In the special case of the file being changed on disk and out of sync with the cache, the sha1
+
+Operating Modes
+You can choose whether you want to trust the index file entirely
+(using the "--cached" flag) or ask the diff logic to show any files
+that don't match the stat state as being "tentatively changed".  Both
+of these operations are very useful indeed.
+
+Cached Mode
+If --cached is specified, it allows you to ask:
+	show me the differences between HEAD and the current index
+	contents (the ones I'd write with a "write-tree")
+
+For example, let's say that you have worked on your index file, and are
+ready to commit. You want to see eactly _what_ you are going to commit is
+without having to write a new tree object and compare it that way, and to
+do that, you just do
+
+	diff-cache --cached $(cat .git/HEAD)
+
+Example: let's say I had renamed "commit.c" to "git-commit.c", and I had 
+done an "upate-cache" to make that effective in the index file. 
+"show-diff" wouldn't show anything at all, since the index file matches 
+my working directory. But doing a diff-cache does:
+	torvalds@ppc970:~/git> diff-cache --cached $(cat .git/HEAD)
+	-100644 blob    4161aecc6700a2eb579e842af0b7f22b98443f74        commit.c
+	+100644 blob    4161aecc6700a2eb579e842af0b7f22b98443f74        git-commit.c
+
+And as you can see, the output matches "diff-tree -r" output (we
+always do "-r", since the index is always fully populated
+??CHECK??).
+You can trivially see that the above is a rename.
+
+In fact, "diff-tree --cached" _should_ always be entirely equivalent to
+actually doing a "write-tree" and comparing that. Except this one is much
+nicer for the case where you just want to check where you are.
+
+So doing a "diff-cache --cached" is basically very useful when you are 
+asking yourself "what have I already marked for being committed, and 
+what's the difference to a previous tree".
+
+Non-cached Mode
+
+The "non-cached" mode takes a different approach, and is potentially
+the even more useful of the two in that what it does can't be emulated
+with a "write-tree + diff-tree". Thus that's the default mode.  The
+non-cached version asks the question
+
+   "show me the differences between HEAD and the currently checked out 
+    tree - index contents _and_ files that aren't up-to-date"
+
+which is obviously a very useful question too, since that tells you what
+you _could_ commit. Again, the output matches the "diff-tree -r" output to
+a tee, but with a twist.
+
+The twist is that if some file doesn't match the cache, we don't have a
+backing store thing for it, and we use the magic "all-zero" sha1 to show
+that. So let's say that you have edited "kernel/sched.c", but have not
+actually done an update-cache on it yet - there is no "object" associated
+with the new state, and you get:
+
+	torvalds@ppc970:~/v2.6/linux> diff-cache $(cat .git/HEAD )
+	*100644->100664 blob    7476bbcfe5ef5a1dd87d745f298b831143e4d77e->0000000000000000000000000000000000000000      kernel/sched.c
+
+ie it shows that the tree has changed, and that "kernel/sched.c" has is
+not up-to-date and may contain new stuff. The all-zero sha1 means that to
+get the real diff, you need to look at the object in the working directory
+directly rather than do an object-to-object diff.
+
+NOTE! As with other commands of this type, "diff-cache" does not actually 
+look at the contents of the file at all. So maybe "kernel/sched.c" hasn't 
+actually changed, and it's just that you touched it. In either case, it's 
+a note that you need to upate-cache it to make the cache be in sync.
+
+NOTE 2! You can have a mixture of files show up as "has been updated" and
+"is still dirty in the working directory" together. You can always tell
+which file is in which state, since the "has been updated" ones show a
+valid sha1, and the "not in sync with the index" ones will always have the
+special all-zero sha1.
 
 ################################################################
 diff-tree
-	diff-tree [-r] [-z] <tree sha1> <tree sha1>
+	diff-tree [-r] [-z] <tree sha1> <tree sha1> 
 
 
 ################################################################
@@ -156,3 +317,23 @@
 unpack-file
 	unpack-file.c <sha1>
 
+
+
+git Environment Variables
+GIT_CACHE_DIRECTORY
+AUTHOR_NAME
+AUTHOR_EMAIL
+AUTHOR_DATE
+RSYNC_FLAGS
+GIT_INDEX_FILE
+
+
+.git Repository Files
+
+.git/HEAD
+This file always contains the last (head) commit object created for this branch of the repository.
+(Usually symlinked to a file in .git/heads/)
+
+.git/heads/
+This directory contains a file for each branch of the .git repository.
+The name of the file is the friendly name of the branch (eg pasky)

--------------070800080501010103050305--
