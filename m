From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH] tg-files: list files changed by the topic branch
Date: Mon,  4 Oct 2010 15:16:34 +0200
Message-ID: <1286198194-12873-1-git-send-email-bert.wesarg@googlemail.com>
References: <20101004065918.GL28679@pengutronix.de>
Cc: git@vger.kernel.org, Peter Simons <simons@cryp.to>, pasky@suse.cz,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 15:16:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2kuL-0001FJ-7A
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 15:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755905Ab0JDNQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 09:16:41 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:32850 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755901Ab0JDNQk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 09:16:40 -0400
Received: by bwz11 with SMTP id 11so3523998bwz.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 06:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:to;
        bh=de8mS/hLcojijpmN44C4VPceLfVtXNzWR05/JsJLyVA=;
        b=HyuN5qWpzYXxIM+2bX80lZcw5/ADYRGGIgDjkrVoQipLoGMUXg5zohGiCFbfNVtAuQ
         3zJY8je4wuGJIy4RK0qVxFjzN/On0b4p6sHAkRFv+z+U8AsXjGgkB6s0sXexLDzbbMkN
         xOWsOlWCoIbK6lZoOBecBNmLUuNQLyE6Z5lms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sVF8RhcW46CuSMwfFs4H2trgoSaYFP3MbnDS2BGp7EUbPatCjNQUhVGV28Z9xYaIM5
         0vP/a/CDYxARydjW9FByIfO06U6ZzCjl2gQFWNIB2TDx7nuhvIdDBWtlre2BIlWNqi7P
         aiH4l9Yqg65dEpnsfXonHIsPJ/wC6Id/zZnr0=
Received: by 10.204.75.81 with SMTP id x17mr6826526bkj.72.1286198197979;
        Mon, 04 Oct 2010 06:16:37 -0700 (PDT)
Received: from localhost (p5B0F7A6E.dip.t-dialin.net [91.15.122.110])
        by mx.google.com with ESMTPS id x19sm3667755bkv.21.2010.10.04.06.16.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 06:16:36 -0700 (PDT)
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <20101004065918.GL28679@pengutronix.de>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158044>

this could also be a --name-only option to tg-patch. But I Like the
similarity to 'quilt files'.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---

> For these we need pretty_tree -i and pretty_tree -w?!
Done and moved to tg.sh. tg-patch should now be updated.

Regards,
Bert

 .gitignore                 |    2 +
 README                     |    8 +++++++
 contrib/tg-completion.bash |    1 +
 tg-export.sh               |    9 --------
 tg-files.sh                |   43 ++++++++++++++++++++++++++++++++++++++
 tg.sh                      |   49 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 103 insertions(+), 9 deletions(-)

diff --git a/.gitignore b/.gitignore
index 0342e09..0dc4d0e 100644 .gitignore
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
index f103d92..46f564a 100644 README
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
index 0ee233c..38567d0 100755 contrib/tg-completion.bash
--- a/contrib/tg-completion.bash
+++ b/contrib/tg-completion.bash
@@ -467,6 +467,7 @@ _tg ()
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
index 0000000..4e9c5cd tg-files.sh
--- /dev/null
+++ b/tg-files.sh
@@ -0,0 +1,43 @@
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
+	-i)
+		[ -z "$topic" ] || die "-i and -w are mutually exclusive"
+		topic=-i;;
+	-w)
+		[ -z "$topic" ] || die "-i and -w are mutually exclusive"
+		topic=-w;;
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
+	die "-i/-w are mutually exclusive with NAME"
+
+[ -n "$name" ] || name="$(git symbolic-ref HEAD | sed 's#^refs/\(heads\|top-bases\)/##')"
+base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)" ||
+	die "not a TopGit-controlled branch"
+
+b_tree=$(prett_tree "$name" -b)
+t_tree=$(prett_tree "$name" $topic)
+
+git diff-tree --name-only -r $b_tree $t_tree
+
+# vim:noet
diff --git a/tg.sh b/tg.sh
index 9d08d63..ff39483 100644 tg.sh
--- a/tg.sh
+++ b/tg.sh
@@ -39,6 +39,55 @@ cat_file()
 	esac
 }
 
+# get tree for topic
+get_tree_()
+{
+	echo "$1"
+}
+
+# get tree for base
+get_tree_b()
+{
+	echo "refs/top-bases/$1"
+}
+
+# get tree for index
+get_tree_i()
+{
+	git write-tree
+}
+
+# get tree for worktree
+get_tree_w()
+{
+	i_tree=$(git write-tree)
+	(
+		TMP_INDEX="$(mktemp -t tg-files-index.XXXXXX)"
+		rm -f "$TMP_INDEX" &&
+		: ${GIT_DIR:="$root_dir/.git"} &&
+		cp -p ${GIT_INDEX_FILE-"$GIT_DIR/index"} "$TMP_INDEX" &&
+		GIT_INDEX_FILE="$TMP_INDEX" &&
+		export GIT_INDEX_FILE &&
+		git read-tree -m $i_tree &&
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
+prett_tree()
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
tg: (9404aa1..) bw/files (depends on: master)
