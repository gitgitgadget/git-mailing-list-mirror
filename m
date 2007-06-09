From: Johan Herland <johan@herland.net>
Subject: [PATCH 4/7] Softrefs: Add manual page documenting git-softref and
 softrefs subsystem in general
Date: Sat, 09 Jun 2007 20:23:13 +0200
Message-ID: <200706092023.13537.johan@herland.net>
References: <200706040251.05286.johan@herland.net>
 <200706092019.13185.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 20:23:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx5aq-0004Sb-Ht
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 20:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756436AbXFISXT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 14:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756386AbXFISXT
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 14:23:19 -0400
Received: from smtp.getmail.no ([84.208.20.33]:54167 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755219AbXFISXS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 14:23:18 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJD00C03SET4M00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 20:23:17 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJD00BDXSEPAL00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 20:23:14 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJD000G7SEPUT50@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 20:23:13 +0200 (CEST)
In-reply-to: <200706092019.13185.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49596>

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-softref.txt |  119 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 119 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-softref.txt

diff --git a/Documentation/git-softref.txt b/Documentation/git-softref.txt
new file mode 100644
index 0000000..6a3e13b
--- /dev/null
+++ b/Documentation/git-softref.txt
@@ -0,0 +1,119 @@
+git-softref(1)
+==============
+
+NAME
+----
+git-softref - Create, list and administer soft references
+
+
+SYNOPSIS
+--------
+[verse]
+'git-softref' --list [<from-object>]
+'git-softref' --has <from-object> <to-object>
+'git-softref' --add <from-object> <to-object>
+'git-softref' --rebuild-tags
+'git-softref' --merge-unsorted [<softrefs-file>]
+'git-softref' --merge-sorted <softrefs-file>
+
+
+DESCRIPTION
+-----------
+Query and administer soft references in a git repository.
+
+Soft references are used to declare reachability between already existing
+objects. An object (called the 'to-object') may be declared reachable from
+another object (the 'from-object') without affecting the immutability of either
+object.
+
+The `--list` option will list existing softrefs in the database. If given the
+optional <from-object>, the list is limited to softrefs from the given object.
+The `--has` option is used to check for the existence of a softref between two
+given objects, similarly the `--add` option is used to add such a softref.
+
+The `--rebuild-tags` option is used to generate softrefs for all tag objects in
+the repository reachable from tag refs. Tag objects use softrefs to declare
+reachability 'from' the tagged object, 'to' the tag object. This allows for tag
+objects to the cloned/fetched/pushed along with their associated objects.
+
+Finally, the `--merge-unsorted` and `--merge-sorted` options are used to merge
+softrefs files into the sorted softrefs db. The filename argument must point
+to an existing file in unsorted/sorted softrefs format. The softrefs entries
+in this file will be merged into the sorted softrefs db. The `--merge-unsorted`
+option may be used 'without' a filename, in which case the currently unsorted
+portion of the softrefs db will be merged into the sorted db. Note that this
+last operation is also done regularly by default when adding softrefs, so
+there is no need to invoke this option during regular use.
+
+
+OPTIONS
+-------
+--list [<from-object>]::
+	List all softrefs that have the given '<from-object>'.
+	If '<from-object>' is not given, list 'all' softrefs in the repository.
+
+--has <from-object> <to-object>::
+	Return with exit code 1 if the given softref exists in the repository.
+	Return with exit code 0 otherwise.
+
+--add <from-object> <to-object>::
+	Add a softref from the given '<from-object>' to the given '<to-object>'.
+	The '<to-object>' will from now on be considered reachable from the
+	'<from-object>'.
+
+--rebuild-tags::
+	Automatically generate softrefs for all tag objects reachable from
+	tag refs in the repository.
+
+--merge-unsorted [<softrefs-file>]::
+	Merge the softrefs in the given unsorted '<softrefs-file>' into the
+	sorted softrefs db. If a filename is not given, force a merge of the
+	internal unsorted softrefs store into the sorted softrefs db.
+
+--merge-sorted <softrefs-file>::
+	Merge the softrefs in the given sorted '<softrefs-file>' into the
+	sorted softrefs db.
+
+
+DISCUSSION
+----------
+Soft references (softrefs) is a general mechanism for declaring a relationship
+between two existing arbitrary objects in the repo. Softrefs differ from the
+existing reachability relationship in that a softref may be created after
+'both' of the involved objects have been added to the repo. In contrast,
+regular reachability depends on the reachable object's name being stored
+'inside' the other object. A reachability relationship can therefore not be
+created at a later time without violating the immutability of git objects.
+
+Softrefs are defined as going 'from' one object 'to' another object. Once
+a softref between two objects has been created, the "to" object is considered
+reachable from the "from" object.
+
+Also, softrefs are stored in a way that makes it easy and quick to find all
+the "to" objects reachable from a given "from" object.
+
+The softrefs db consists of two files: `.git/softrefs.unsorted` and
+`.git/softrefs.sorted`. Both files use the same format; one softref per line
+of the form "`<from-sha1> <to-sha1>\n`". Each sha1 sum is 40 bytes long; this
+makes each entry exactly 82 bytes long.
+
+The entries in `.git/softrefs.sorted` are sorted on `<from-sha1>`, in order to
+make lookup fast. This file is also known as the "sorted softrefs db".
+
+The entries in `.git/softrefs.unsorted` are 'not' sorted. This is to make
+insertion fast. This file is also known as the "unsorted softrefs db".
+
+When softrefs are created, they are appended to `.git/softrefs.unsorted`.
+When `.git/softrefs.unsorted` reach a certain number of entries, all the
+entries in `.git/softrefs.unsorted` are automatically merged into
+`.git/softrefs.sorted`.
+
+
+Author
+------
+Written by Johan Herland <johan@herland.net>.
+
+
+GIT
+---
+Part of the gitlink:git[7] suite
-- 
1.5.2.1.144.gabc40
