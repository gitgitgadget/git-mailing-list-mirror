From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH v3] tg-files: list files changed by the topic branch
Date: Mon,  4 Oct 2010 20:27:47 +0200
Message-ID: <1286216867-14701-1-git-send-email-bert.wesarg@googlemail.com>
References: <AANLkTinv40O_gdMdEbTOV6LQKBNjksAGKMOtewwauMjP@mail.gmail.com>
Cc: git@vger.kernel.org, Peter Simons <simons@cryp.to>, pasky@suse.cz,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 20:28:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2pla-0004mk-Q2
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 20:28:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158Ab0JDS1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 14:27:54 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42782 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932111Ab0JDS1x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 14:27:53 -0400
Received: by bwz11 with SMTP id 11so3847976bwz.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 11:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:to;
        bh=1I+pH9cx4Wdim11VbhWNwB/K0GwvO06igvUzxyP90IU=;
        b=Ku3T+ewP+a6oRik/Dlj54U0Ygyk0D3dECr4Hqo4A+iB9YVeZvcjpeBUpKV7AYG7GtU
         pePdWkaopLEnGSg2KBI9b8qtL4iX0b3h2iS4hTLuYM4L3g7qd2MUBRWMroOsOrcRwghN
         DMmgnQ7ZAM/pkr9IcNYadkmyyuBTxDSA+/Cvo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nO19EADeOl8bDXFgSpgHQAkxw4iGMesPLdfrF4+LGg0Mt51sKVndCQcTiWh0zWHKeh
         ti1UrpKxg01+tq10g37AOOYvfsw4jNIYg/SktEBh0KkJV64HccW3NbuA78yMj1UfjJuI
         3RnxWsRC3Bt8cIsperL9R9TW4i/QKJrV7hxn4=
Received: by 10.204.98.66 with SMTP id p2mr7248261bkn.178.1286216871846;
        Mon, 04 Oct 2010 11:27:51 -0700 (PDT)
Received: from localhost (p5B0F7A6E.dip.t-dialin.net [91.15.122.110])
        by mx.google.com with ESMTPS id x13sm4019356bki.0.2010.10.04.11.27.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 11:27:50 -0700 (PDT)
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <AANLkTinv40O_gdMdEbTOV6LQKBNjksAGKMOtewwauMjP@mail.gmail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158086>

this could also be a --name-only option to tg-patch. But I Like the
similarity to 'quilt files'.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---

 Changes:
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
index 0000000..b88940a tg-files.sh
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
+b_tree=$(pretty_tree "$name" -b)
+t_tree=$(pretty_tree "$name" $topic)
+
+git diff-tree --name-only -r $b_tree $t_tree
+
+# vim:noet
diff --git a/tg.sh b/tg.sh
index 9d08d63..2bc6bed 100644 tg.sh
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
tg: (9404aa1..) bw/files (depends on: master)
