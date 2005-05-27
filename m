From: Jonas Fonseca <fonseca@diku.dk>
Subject: [RFC] Removing git-*.html references from manpages
Date: Sat, 28 May 2005 00:58:50 +0200
Message-ID: <20050527225850.GA25491@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 00:57:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dbnl5-0002Ye-6Z
	for gcvg-git@gmane.org; Sat, 28 May 2005 00:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbVE0W67 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 18:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbVE0W66
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 18:58:58 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:20440 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S262652AbVE0W6x (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2005 18:58:53 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 9F8D96E181F; Sat, 28 May 2005 00:58:23 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 587FC6E135A; Sat, 28 May 2005 00:58:23 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 38A2261FE0; Sat, 28 May 2005 00:58:51 +0200 (CEST)
To: David Greaves <david@dgreaves.com>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.8 required=5.0 tests=BAYES_00,HTML_MESSAGE 
	autolearn=ham version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

Just a minor issue but still. Currently the manpages contains the
following:

	git-export: git-export.html

I'd like to have the interlinking references removed from the manpages
so it becomes just:

	git-export

or what ever was put between the square brackets of the link: macro.

The fix requires the introduction of an asciidoc.conf file and a new
link macro which I've called gitlink: but it could be shorter (and also
smarter so link:git-CMD.html[git-CMD] could become man:git-CMD[]).

Below is a small patch probe to show the basic idea.

What do you think?

--- a/Documentation/Makefile  (mode:100644)
+++ b/Documentation/Makefile  (mode:100644)
@@ -32,10 +32,10 @@
 	rm -f *.xml *.html *.1 *.7
 
 %.html : %.txt
-	asciidoc -b css-embedded -d manpage $<
+	asciidoc -b css-embedded -d manpage -f asciidoc.conf $<
 
 %.1 %.7 : %.xml
 	xmlto man $<
 
 %.xml : %.txt
-	asciidoc -b docbook -d manpage $<
+	asciidoc -b docbook -d manpage -f asciidoc.conf $<
--- /dev/null  (tree:f6db9be9d431080d9e7f61edb616b8bac8c9618f)
+++ b/Documentation/asciidoc.conf  (mode:100644)
@@ -0,0 +1,14 @@
+ifdef::backend-docbook[]
+
+# Don't show the link target to git-*.html pages in the man page
+[gitlink-inlinemacro]
+<emphasis>{attrlist}</emphasis>
+
+endif::backend-docbook[]
+
+ifdef::backend-css-embedded[]
+
+[gitlink-inlinemacro]
+<a href="{target}">{0={target}}</a>
+
+endif::backend-css-embedded[]
--- a/Documentation/git.txt  (mode:100644)
+++ b/Documentation/git.txt  (mode:100644)
@@ -39,34 +39,34 @@
 
 Manipulation commands
 ~~~~~~~~~~~~~~~~~~~~~
-link:git-checkout-cache.html[git-checkout-cache]::
+gitlink:git-checkout-cache.html[git-checkout-cache]::
 	Copy files from the cache to the working directory
 
-link:git-commit-tree.html[git-commit-tree]::
+gitlink:git-commit-tree.html[git-commit-tree]::
 	Creates a new commit object
 
-link:git-init-db.html[git-init-db]::
+gitlink:git-init-db.html[git-init-db]::
 	Creates an empty git object database
 
-link:git-merge-base.html[git-merge-base]::
+gitlink:git-merge-base.html[git-merge-base]::
 	Finds as good a common ancestor as possible for a merge
 
-link:git-mkdelta.html[git-mkdelta]::
+gitlink:git-mkdelta.html[git-mkdelta]::
 	Creates a delta object
 
-link:git-mktag.html[git-mktag]::
+gitlink:git-mktag.html[git-mktag]::
 	Creates a tag object
 
-link:git-read-tree.html[git-read-tree]::
+gitlink:git-read-tree.html[git-read-tree]::
 	Reads tree information into the directory cache
 
-link:git-update-cache.html[git-update-cache]::
+gitlink:git-update-cache.html[git-update-cache]::
 	Modifies the index or directory cache
 
-link:git-write-blob.html[git-write-blob]::
+gitlink:git-write-blob.html[git-write-blob]::
 	Creates a blob from a file
 
-link:git-write-tree.html[git-write-tree]::
+gitlink:git-write-tree.html[git-write-tree]::
 	Creates a tree from the current cache
 
 Interrogation commands

-- 
Jonas Fonseca
