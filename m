From: David Greaves <david@dgreaves.com>
Subject: [PATCH 5/5] Docs - delta object
Date: Sun, 22 May 2005 18:44:17 +0100
Message-ID: <E1DZuUr-0008N8-SC@ash.dgreaves.com>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 22 19:48:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZuYH-0004Cg-99
	for gcvg-git@gmane.org; Sun, 22 May 2005 19:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVEVRs4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 13:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVEVRs4
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 13:48:56 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:38630 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261339AbVEVRo1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2005 13:44:27 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 7B32FE6DAB; Sun, 22 May 2005 18:43:40 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 10517-18; Sun, 22 May 2005 18:43:40 +0100 (BST)
Received: from oak.dgreaves.com (modem-1750.lemur.dialup.pol.co.uk [217.135.134.214])
	by mail.ukfsn.org (Postfix) with ESMTP
	id B54D1E6DB9; Sun, 22 May 2005 18:43:37 +0100 (BST)
Received: from [10.0.0.90] (helo=ash.dgreaves.com)
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DZuUw-00016S-Bf; Sun, 22 May 2005 18:44:22 +0100
Received: from david by ash.dgreaves.com with local (Exim 4.50)
	id 1DZuUr-0008N8-SC; Sun, 22 May 2005 18:44:17 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Added delta documentation

Signed-off-by: David Greaves <david@dgreaves.com>

---
commit e45371bf4e895f1ff0343c2f1e3cafbdf44dd3e4
tree e07586b3428cb3c605ddfb9c09919bbf0039a473
parent 702d4ba4f44643b77f3eadbec62b0dd0c22053fd
author David Greaves <david@dgreaves.com> Sun, 22 May 2005 18:39:11 +0100
committer David Greaves <david@dgreaves.com> Sun, 22 May 2005 18:39:11 +0100

 Documentation/git-fsck-cache.txt |    5 +++-
 Documentation/git-mkdelta.txt    |   45 ++++++++++++++++++++++++++++++++++++++
 Documentation/git.txt            |    3 ++
 README                           |   46 +++++++++++++++++++++++++++++++--------
 4 files changed, 89 insertions(+), 10 deletions(-)

Index: Documentation/git-fsck-cache.txt
===================================================================
--- d25a34a8599fec7c11f9ba515b8338cad5837292/Documentation/git-fsck-cache.txt  (mode:100644)
+++ e07586b3428cb3c605ddfb9c09919bbf0039a473/Documentation/git-fsck-cache.txt  (mode:100644)
@@ -9,7 +9,7 @@
 
 SYNOPSIS
 --------
-'git-fsck-cache' [--tags] [--root] [[--unreachable] [--cache] <object>\*]
+'git-fsck-cache' [--tags] [--root] [--delta-depth] [[--unreachable] [--cache] <object>\*]
 
 DESCRIPTION
 -----------
@@ -34,6 +34,9 @@
 	Consider any object recorded in the cache also as a head node for
 	an unreachability trace.
 
+--delta-depth::
+	Report back the length of the longest delta chain found.
+
 It tests SHA1 and general object sanity, and it does full tracking of
 the resulting reachability and everything else. It prints out any
 corruption it finds (missing or bad objects), and if you use the
Index: Documentation/git-mkdelta.txt
===================================================================
--- /dev/null  (tree:d25a34a8599fec7c11f9ba515b8338cad5837292)
+++ e07586b3428cb3c605ddfb9c09919bbf0039a473/Documentation/git-mkdelta.txt  (mode:100644)
@@ -0,0 +1,45 @@
+git-mkdelta(1)
+==============
+May 2005
+
+NAME
+----
+git-mkdelta - Creates a delta object
+
+
+SYNOPSIS
+--------
+'git-mkdelta' [-v] [-d N | --max-depth=N ] <reference_object> <target_object> [ <next_object> ... ]
+
+DESCRIPTION
+-----------
+Creates a delta object to replace <reference_object> by using an
+ordered list of potential objects to deltafy against earlier objects
+in the list.
+
+A cap on the depth of delta references can be provided as well,
+otherwise the default is to not have any limit.  A limit of 0 will
+also undeltafy a given object.
+
+
+OPTIONS
+-------
+-v::
+	Verbose
+
+-d|--max-depth::
+	limit the number of delta references in a chain
+	If 0 then all objects are undeltafied.
+	
+Author
+------
+Git is written by Linus Torvalds <torvalds@osdl.org> and the git-list <git@vger.kernel.org>.
+
+Documentation
+--------------
+Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the link:git.html[git] suite
+
Index: Documentation/git.txt
===================================================================
--- d25a34a8599fec7c11f9ba515b8338cad5837292/Documentation/git.txt  (mode:100644)
+++ e07586b3428cb3c605ddfb9c09919bbf0039a473/Documentation/git.txt  (mode:100644)
@@ -51,6 +51,9 @@
 link:git-merge-base.html[git-merge-base]::
 	Finds as good a common ancestor as possible for a merge
 
+link:git-mkdelta.html[git-mkdelta]::
+	Creates a delta object
+
 link:git-mktag.html[git-mktag]::
 	Creates a tag object
 
Index: README
===================================================================
--- d25a34a8599fec7c11f9ba515b8338cad5837292/README  (mode:100644)
+++ e07586b3428cb3c605ddfb9c09919bbf0039a473/README  (mode:100644)
@@ -32,8 +32,8 @@
 All objects have a statically determined "type" aka "tag", which is
 determined at object creation time, and which identifies the format of
 the object (i.e. how it is used, and how it can refer to other
-objects).  There are currently four different object types: "blob",
-"tree", "commit" and "tag".
+objects).  There are currently five different object types: "blob",
+"tree", "commit", "tag" and "delta"
 
 A "blob" object cannot refer to any other object, and is, like the tag
 implies, a pure storage object containing some user data.  It is used to
@@ -62,13 +62,17 @@
 objects. It contains the identifier and type of another object, a
 symbolic name (of course!) and, optionally, a signature.
 
-Regardless of object type, all objects are share the following
-characteristics: they are all in deflated with zlib, and have a header
-that not only specifies their tag, but also size information about the
-data in the object.  It's worth noting that the SHA1 hash that is used
-to name the object is the hash of the original data (historical note:
-in the dawn of the age of git this was the sha1 of the _compressed_
-object)
+A "delta" object is used internally by the object database to minimise
+disk usage. Instead of storing the entire contents of a revision, git
+can behave in a similar manner to RCS et al and simply store a delta.
+
+Regardless of object type, all objects share the following
+characteristics: they are all deflated with zlib, and have a header
+that not only specifies their tag, but also provides size information
+about the data in the object.  It's worth noting that the SHA1 hash
+that is used to name the object is the hash of the original data or
+the delta. (Historical note: in the dawn of the age of git the hash
+was the sha1 of the _compressed_ object)
 
 As a result, the general consistency of an object can always be tested
 independently of the contents or the type of the object: all objects can
@@ -215,6 +219,30 @@
 A tag is created with link:git-mktag.html[git-mktag] and
 it's data can be accessed by link:git-cat-file.html[git-cat-file]
 
+Delta Object
+~~~~~~~~~~~~
+
+The "delta" object is used internally by the object database to
+minimise storage usage by using xdeltas (byte level diffs). Deltas can
+form chains of arbitrary length as RCS does (although this is
+configureable at creation time). Most operations won't see or even be
+aware of delta objects as they are automatically 'applied' and appear
+as 'real' git objects In other words, if you write your own routines
+to look at the contents of the object database then you need to know
+about this - otherwise you don't. Actually, that's not quite true -
+one important area where deltas are likely to prove very valuable is
+in reducing bandwidth loads - so the more sophisticated network tools
+for git repositories will be aware of them too.
+
+Finally, git repositories can (and must) be deltafied in the
+background - the work to calculate the differences does not take place
+automatically at commit time.
+
+A delta can be created (or undeltafied) with
+link:git-mkdelta.html[git-mkdelta] it's raw data cannot be accessed at
+present.
+
+
 The "index" aka "Current Directory Cache"
 -----------------------------------------
 The index is a simple binary file, which contains an efficient
