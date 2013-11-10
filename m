From: John Keeping <john@keeping.me.uk>
Subject: [RFC/PATCH 3/4] lost-found: remove deprecated command
Date: Sun, 10 Nov 2013 15:47:30 +0000
Message-ID: <7c5fd82b538fd8e1137b06904d39c42e0755fc0e.1384098226.git.john@keeping.me.uk>
References: <cover.1384098226.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 10 16:48:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfXFG-0000NX-LO
	for gcvg-git-2@plane.gmane.org; Sun, 10 Nov 2013 16:48:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782Ab3KJPsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Nov 2013 10:48:08 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:50474 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714Ab3KJPsG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Nov 2013 10:48:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id C5B3460653E;
	Sun, 10 Nov 2013 15:48:05 +0000 (GMT)
X-Quarantine-ID: <t65q4EZz7ydq>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t65q4EZz7ydq; Sun, 10 Nov 2013 15:47:56 +0000 (GMT)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 67388606538;
	Sun, 10 Nov 2013 15:47:51 +0000 (GMT)
X-Mailer: git-send-email 1.8.5.rc0.170.g772b8ec
In-Reply-To: <cover.1384098226.git.john@keeping.me.uk>
In-Reply-To: <cover.1384098226.git.john@keeping.me.uk>
References: <cover.1384098226.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237589>

"git lost-found" has been deprecated since commit fc8b5f0 (Deprecate
git-lost-found, 2007-11-08), included in version 1.5.4.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 .gitignore                             |  1 -
 Documentation/git-lost-found.txt       | 74 ----------------------------------
 Makefile                               |  1 -
 command-list.txt                       |  1 -
 contrib/completion/git-completion.bash |  1 -
 git-lost-found.sh                      | 33 ---------------
 6 files changed, 111 deletions(-)
 delete mode 100644 Documentation/git-lost-found.txt
 delete mode 100755 git-lost-found.sh

diff --git a/.gitignore b/.gitignore
index 88b313a..c141b2a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -75,7 +75,6 @@
 /git-init-db
 /git-instaweb
 /git-log
-/git-lost-found
 /git-ls-files
 /git-ls-remote
 /git-ls-tree
diff --git a/Documentation/git-lost-found.txt b/Documentation/git-lost-found.txt
deleted file mode 100644
index d549328..0000000
--- a/Documentation/git-lost-found.txt
+++ /dev/null
@@ -1,74 +0,0 @@
-git-lost-found(1)
-=================
-
-NAME
-----
-git-lost-found - Recover lost refs that luckily have not yet been pruned
-
-SYNOPSIS
---------
-[verse]
-'git lost-found'
-
-DESCRIPTION
------------
-
-*NOTE*: this command is deprecated.  Use linkgit:git-fsck[1] with
-the option '--lost-found' instead.
-
-Finds dangling commits and tags from the object database, and
-creates refs to them in the .git/lost-found/ directory.  Commits and
-tags that dereference to commits are stored in .git/lost-found/commit,
-and other objects are stored in .git/lost-found/other.
-
-
-OUTPUT
-------
-Prints to standard output the object names and one-line descriptions
-of any commits or tags found.
-
-EXAMPLE
--------
-
-Suppose you run 'git tag -f' and mistype the tag to overwrite.
-The ref to your tag is overwritten, but until you run 'git
-prune', the tag itself is still there.
-
-------------
-$ git lost-found
-[1ef2b196d909eed523d4f3c9bf54b78cdd6843c6] GIT 0.99.9c
-...
-------------
-
-Also you can use gitk to browse how any tags found relate to each
-other.
-
-------------
-$ gitk $(cd .git/lost-found/commit && echo ??*)
-------------
-
-After making sure you know which the object is the tag you are looking
-for, you can reconnect it to your regular `refs` hierarchy by using
-the `update-ref` command.
-
-------------
-$ git cat-file -t 1ef2b196
-tag
-$ git cat-file tag 1ef2b196
-object fa41bbce8e38c67a218415de6cfa510c7e50032a
-type commit
-tag v0.99.9c
-tagger Junio C Hamano <junkio@cox.net> 1131059594 -0800
-
-GIT 0.99.9c
-
-This contains the following changes from the "master" branch, since
-...
-$ git update-ref refs/tags/not-lost-anymore 1ef2b196
-$ git rev-parse not-lost-anymore
-1ef2b196d909eed523d4f3c9bf54b78cdd6843c6
-------------
-
-GIT
----
-Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 4fc2378..7ffd705 100644
--- a/Makefile
+++ b/Makefile
@@ -452,7 +452,6 @@ SCRIPT_SH += git-am.sh
 SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
-SCRIPT_SH += git-lost-found.sh
 SCRIPT_SH += git-merge-octopus.sh
 SCRIPT_SH += git-merge-one-file.sh
 SCRIPT_SH += git-merge-resolve.sh
diff --git a/command-list.txt b/command-list.txt
index f8fc5b8..7bf2420 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -64,7 +64,6 @@ git-init                                mainporcelain common
 git-instaweb                            ancillaryinterrogators
 gitk                                    mainporcelain
 git-log                                 mainporcelain common
-git-lost-found                          ancillarymanipulators	deprecated
 git-ls-files                            plumbinginterrogators
 git-ls-remote                           plumbinginterrogators
 git-ls-tree                             plumbinginterrogators
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1081ad1..c071614 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -673,7 +673,6 @@ __git_list_porcelain_commands ()
 		index-pack)       : plumbing;;
 		init-db)          : deprecated;;
 		local-fetch)      : plumbing;;
-		lost-found)       : infrequent;;
 		ls-files)         : plumbing;;
 		ls-remote)        : plumbing;;
 		ls-tree)          : plumbing;;
diff --git a/git-lost-found.sh b/git-lost-found.sh
deleted file mode 100755
index 0b3e8c7..0000000
--- a/git-lost-found.sh
+++ /dev/null
@@ -1,33 +0,0 @@
-#!/bin/sh
-
-USAGE=''
-SUBDIRECTORY_OK='Yes'
-OPTIONS_SPEC=
-. git-sh-setup
-
-echo "WARNING: '$0' is deprecated in favor of 'git fsck --lost-found'" >&2
-
-if [ "$#" != "0" ]
-then
-    usage
-fi
-
-laf="$GIT_DIR/lost-found"
-rm -fr "$laf" && mkdir -p "$laf/commit" "$laf/other" || exit
-
-git fsck --full --no-reflogs |
-while read dangling type sha1
-do
-	case "$dangling" in
-	dangling)
-		if git rev-parse -q --verify "$sha1^0" >/dev/null
-		then
-			dir="$laf/commit"
-			git show-branch "$sha1"
-		else
-			dir="$laf/other"
-		fi
-		echo "$sha1" >"$dir/$sha1"
-		;;
-	esac
-done
-- 
1.8.5.rc0.170.g772b8ec
