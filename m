X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] make commit message a little more consistent and conforting
Date: Thu, 14 Dec 2006 23:15:44 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612142307160.18171@xanadu.home>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
 <200612132237.10051.andyparkins@gmail.com>
 <7vk60vbcfz.fsf@assigned-by-dhcp.cox.net>
 <200612140959.19209.andyparkins@gmail.com>
 <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0612141343200.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 15 Dec 2006 04:15:54 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <Pine.LNX.4.64.0612141343200.18171@xanadu.home>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34470>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv4UD-0003QM-H6 for gcvg-git@gmane.org; Fri, 15 Dec
 2006 05:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965065AbWLOEPr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 23:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbWLOEPr
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 23:15:47 -0500
Received: from relais.videotron.ca ([24.201.245.36]:29910 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932178AbWLOEPq (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 23:15:46 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JAA00I8URU80HG0@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Thu,
 14 Dec 2006 23:15:45 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

It is nicer to let the user know when a commit succeeded all the time, 
not only the first time.  Also the commit sha1 is much more useful than 
the tree sha1 in this case.

This patch also introduces a -q switch to supress this message as well 
as the summary of created/deleted files.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
index 47505aa..1c31159 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -336,17 +336,9 @@ $ commit=$(echo 'Initial commit' | git-commit-tree $tree)
 $ git-update-ref HEAD $commit
 ------------------------------------------------
 
-which will say:
-
-----------------
-Committing initial tree 8988da15d077d4829fc51d8544c097def6644dbb
-----------------
-
-just to warn you about the fact that it created a totally new commit
-that is not related to anything else. Normally you do this only *once*
-for a project ever, and all later commits will be parented on top of an
-earlier commit, and you'll never see this "Committing initial tree"
-message ever again.
+In this case this creates a totally new commit that is not related to
+anything else. Normally you do this only *once* for a project ever, and
+all later commits will be parented on top of an earlier commit.
 
 Again, normally you'd never actually do this by hand. There is a
 helpful script called `git commit` that will do all of this for you. So
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 97d66ef..0b74cd7 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -113,6 +113,9 @@ but can be used to amend a merge commit.
 	as well.  This is usually not what you want unless you
 	are concluding a conflicted merge.
 
+-q|--quiet::
+	Supress commit summary message.
+
 \--::
 	Do not interpret any more arguments as options.
 
diff --git a/Documentation/tutorial-2.txt b/Documentation/tutorial-2.txt
index 6389de5..8606381 100644
--- a/Documentation/tutorial-2.txt
+++ b/Documentation/tutorial-2.txt
@@ -22,14 +22,14 @@ defaulting to local storage area
 $ echo 'hello world' > file.txt
 $ git add .
 $ git commit -a -m "initial commit"
-Committing initial tree 92b8b694ffb1675e5975148e1121810081dbdffe
+Created initial commit 54196cc2703dc165cbd373a65a4dcf22d50ae7f7
  create mode 100644 file.txt
 $ echo 'hello world!' >file.txt
 $ git commit -a -m "add emphasis"
+Created commit c4d59f390b9cfd4318117afde11d601c1085f241
 ------------------------------------------------
 
-What are the 40 digits of hex that git responded to the first commit
-with?
+What are the 40 digits of hex that git responded to the commit with?
 
 We saw in part one of the tutorial that commits have names like this.
 It turns out that every object in the git history is stored under
@@ -39,13 +39,25 @@ the same data twice (since identical data is given an identical SHA1
 name), and that the contents of a git object will never change (since
 that would change the object's name as well).
 
+It is expected that the content of the commit object you created while
+following the example above generates a different SHA1 hash than
+the one shown above because the commit object records the time when
+it was created and the name of the person performing the commit.
+
 We can ask git about this particular object with the cat-file
-command--just cut-and-paste from the reply to the initial commit, to
-save yourself typing all 40 hex digits:
+command. Don't copy the 40 hex digits from this example but use those
+from your own version. Note that you can shorten it to only a few
+characters to save yourself typing all 40 hex digits:
 
 ------------------------------------------------
-$ git cat-file -t 92b8b694ffb1675e5975148e1121810081dbdffe
-tree
+$ git-cat-file -t 54196cc2
+commit
+$ git-cat-file commit 54196cc2
+tree 92b8b694ffb1675e5975148e1121810081dbdffe
+author J. Bruce Fields <bfields@puzzle.fieldses.org> 1143414668 -0500
+committer J. Bruce Fields <bfields@puzzle.fieldses.org> 1143414668 -0500
+
+initial commit
 ------------------------------------------------
 
 A tree can refer to one or more "blob" objects, each corresponding to
@@ -102,8 +114,7 @@ $ find .git/objects/
 
 and the contents of these files is just the compressed data plus a
 header identifying their length and their type.  The type is either a
-blob, a tree, a commit, or a tag.  We've seen a blob and a tree now,
-so next we should look at a commit.
+blob, a tree, a commit, or a tag.
 
 The simplest commit to find is the HEAD commit, which we can find
 from .git/HEAD:
diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index e2e690a..856f3cd 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -107,8 +107,6 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 		if (new_parent(parents))
 			parents++;
 	}
-	if (!parents)
-		fprintf(stderr, "Committing initial tree %s\n", argv[1]);
 
 	init_buffer(&buffer, &size);
 	add_buffer(&buffer, &size, "tree %s\n", sha1_to_hex(tree_sha1));
diff --git a/git-commit.sh b/git-commit.sh
index 05828bb..395bcd2 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -80,6 +80,7 @@ no_edit=
 log_given=
 log_message=
 verify=t
+quiet=
 verbose=
 signoff=
 force_author=
@@ -241,6 +242,10 @@ $1"
 		signoff=t
 		shift
 		;;
+	-q|--q|--qu|--qui|--quie|--quiet)
+		quiet=t
+		shift
+		;;
 	-v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
 		verbose=t
 		shift
@@ -615,11 +620,17 @@ then
 	git-rerere
 fi
 
-if test -x "$GIT_DIR"/hooks/post-commit && test "$ret" = 0
+if test "$ret" = 0
 then
-	"$GIT_DIR"/hooks/post-commit
+	if test -x "$GIT_DIR"/hooks/post-commit 
+	then
+		"$GIT_DIR"/hooks/post-commit
+	fi
+	if test -z "$quiet"
+	then
+		echo "Created${initial_commit:+ initial} commit $commit"
+		git-diff-tree --summary --root --no-commit-id HEAD
+	fi
 fi
 
-test "$ret" = 0 && git-diff-tree --summary --root --no-commit-id HEAD
-
