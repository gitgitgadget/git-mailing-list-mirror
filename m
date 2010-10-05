From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH v4] tg-files: list files changed by the topic branch
Date: Tue,  5 Oct 2010 21:03:22 +0200
Message-ID: <1286305402-28284-1-git-send-email-bert.wesarg@googlemail.com>
References: <20101005071723.GG11737@pengutronix.de>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	Peter Simons <simons@cryp.to>, pasky@suse.cz,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Tue Oct 05 21:03:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3Cna-0004x5-HJ
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 21:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647Ab0JETD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 15:03:29 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41450 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005Ab0JETD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 15:03:28 -0400
Received: by fxm4 with SMTP id 4so668183fxm.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 12:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:to;
        bh=fkdguLlETQEiKsaZBC7YUTgvX9qOaQQw/N0mhb/UrZQ=;
        b=VEhqG8i1IInN8PcY0g6TAZoVbMHHRttKdb6ZoNtnXfix1zs5LBXso1Tc3n2mdmClhh
         iNuZvGMmymffHe999WrgpsJiYc4LKVXfQaz3q2cPjzDX4ZE0oaarf8HwBXqVBaZWy9VI
         8N86+tdyMvdJ3JyDuzz9yvGRLw4IJ/VH9AdQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Z7upsI3oLQ3mV5Yb06a/XKFNub8hZa87JUbqTQx1kIuB08k/P3zWpRtvPYhTKog5Y/
         pUfsDFawDoZBlOvOvSmyVSrFnYiseXBB4F6ldP8G+bauzF5kL6ktS8n54lDNvw3fTgH2
         QdMxyArYwrQaNu4rrybrn4nR5/XQ4e5np5I44=
Received: by 10.223.106.8 with SMTP id v8mr11500728fao.42.1286305406575;
        Tue, 05 Oct 2010 12:03:26 -0700 (PDT)
Received: from localhost (p5B0F75F8.dip.t-dialin.net [91.15.117.248])
        by mx.google.com with ESMTPS id r5sm3111951faq.32.2010.10.05.12.03.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 Oct 2010 12:03:24 -0700 (PDT)
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <20101005071723.GG11737@pengutronix.de>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158222>

this could also be a --name-only option to tg-patch. But I Like the
similarity to 'quilt files'.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---

 Changes:
  v4:
   * apply Uwe's suggestions
  v3:
   * use --index-output= option in read-tree
   * use $git_dir instead of $root_dir/.git
   * bring back the y
  v2:
   * work on trees

 .gitignore                 |    2 +
 README                     |    8 +++++++
 contrib/tg-completion.bash |    1 +
 tg-export.sh               |    9 --------
 tg-files.sh                |   40 +++++++++++++++++++++++++++++++++++
 tg.sh                      |   49 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 100 insertions(+), 9 deletions(-)

diff --git a/.gitignore b/.gitignore
index 3298889..2a4d165 100644 .gitignore
--- a/.gitignore
+++ b/.gitignore
@@ -22,6 +22,8 @@
 /tg-depend.txt
 /tg-export
 /tg-export.txt
+/tg-files
+/tg-files.txt
 /tg-import
 /tg-import.txt
 /tg-info
diff --git a/README b/README
index ce0c3a6..705791b 100644 README
--- a/README
+++ b/README
@@ -272,6 +272,14 @@ tg depend
 
 	TODO: Subcommand for removing dependencies, obviously
 
+tg files
+~~~~~~~~
+	List files changed by the current or specified topic branch.
+
+	Options:
+	  -i		list files based on index instead of branch
+	  -w		list files based on working tree instead of branch
+
 tg info
 ~~~~~~~
 	Show a summary information about the current or specified
diff --git a/contrib/tg-completion.bash b/contrib/tg-completion.bash
index ccf1a32..48e47c7 100755 contrib/tg-completion.bash
--- a/contrib/tg-completion.bash
+++ b/contrib/tg-completion.bash
@@ -482,6 +482,7 @@ _tg ()
 	delete)      _tg_delete ;;
 	depend)      _tg_depend ;;
 	export)      _tg_export ;;
+	files)       _tg_patch ;;
 	help)        _tg_help ;;
 	import)      _tg_import ;;
 	info)        _tg_info ;;
diff --git a/tg-export.sh b/tg-export.sh
index 6d82d55..4b0148c 100644 tg-export.sh
--- a/tg-export.sh
+++ b/tg-export.sh
@@ -63,15 +63,6 @@ trap 'rm -rf "$playground"' EXIT
 
 ## Collapse driver
 
-# pretty_tree NAME
-# Output tree ID of a cleaned-up tree without tg's artifacts.
-pretty_tree()
-{
-	git ls-tree --full-tree "$1" \
-	| awk -F '	' '$2 !~ /^.top/' \
-	| git mktree
-}
-
 create_tg_commit()
 {
 	name="$1"
diff --git a/tg-files.sh b/tg-files.sh
new file mode 100644
index 0000000..5983a7b tg-files.sh
--- /dev/null
+++ b/tg-files.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+# TopGit - A different patch queue manager
+# (c) Petr Baudis <pasky@suse.cz>  2008
+# GPLv2
+
+name=
+topic=
+
+
+## Parse options
+
+while [ -n "$1" ]; do
+	arg="$1"; shift
+	case "$arg" in
+	-i|-w)
+		[ -z "$topic" ] || die "-i and -w are mutually exclusive"
+		topic="$arg";;
+	-*)
+		echo "Usage: tg [...] files [-i | -w] [NAME]" >&2
+		exit 1;;
+	*)
+		[ -z "$name" ] || die "name already specified ($name)"
+		name="$arg";;
+	esac
+done
+
+
+[ -n "$name" -a -n "$topic" ] &&
+	die "$topic are mutually exclusive with NAME"
+
+[ -n "$name" ] || name="$(git symbolic-ref HEAD | sed 's#^refs/\(heads\|top-bases\)/##')"
+base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)" ||
+	die "not a TopGit-controlled branch"
+
+b_tree=$(pretty_tree "$name" -b)
+t_tree=$(pretty_tree "$name" $topic)
+
+git diff-tree --name-only -r $b_tree $t_tree
+
+# vim:noet
diff --git a/tg.sh b/tg.sh
index 3718702..535120e 100644 tg.sh
--- a/tg.sh
+++ b/tg.sh
@@ -39,6 +39,55 @@ cat_file()
 	esac
 }
 
+# get tree for the committed topic
+get_tree_()
+{
+	echo "$1"
+}
+
+# get tree for the base
+get_tree_b()
+{
+	echo "refs/top-bases/$1"
+}
+
+# get tree for the index
+get_tree_i()
+{
+	git write-tree
+}
+
+# get tree for the worktree
+get_tree_w()
+{
+	i_tree=$(git write-tree)
+	(
+		# the file for --index-output needs to sit next to the
+		# current index file
+		: ${GIT_INDEX_FILE:="$git_dir/index"}
+		TMP_INDEX="$(mktemp "${GIT_INDEX_FILE}-tg.XXXXXX")"
+		git read-tree -m $i_tree --index-output="$TMP_INDEX" &&
+		GIT_INDEX_FILE="$TMP_INDEX" &&
+		export GIT_INDEX_FILE &&
+		git diff --name-only -z HEAD |
+			git update-index -z --add --remove --stdin &&
+		git write-tree &&
+		rm -f "$TMP_INDEX"
+	)
+}
+
+# pretty_tree NAME [-b | -i | -w]
+# Output tree ID of a cleaned-up tree without tg's artifacts.
+# NAME will be ignored for -i and -w, but needs to be present
+pretty_tree()
+{
+	name=$1
+	source=${2#?}
+	git ls-tree --full-tree "$(get_tree_$source "$name")" |
+		awk -F '	' '$2 !~ /^.top/' |
+		git mktree
+}
+
 # setup_hook NAME
 setup_hook()
 {
-- 
tg: (ff59ac7..) bw/files (depends on: master)
