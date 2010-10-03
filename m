From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 3/6] tg-files: list files changed by the topic branch
Date: Sun,  3 Oct 2010 23:25:54 +0200
Message-ID: <1286141157-30422-3-git-send-email-bert.wesarg@googlemail.com>
References: <AANLkTim3gnU+_krD2QM0BAMf9DZi2_4hva6dq4WXcatH@mail.gmail.com>
 <1286141157-30422-1-git-send-email-bert.wesarg@googlemail.com>
 <1286141157-30422-2-git-send-email-bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Peter Simons <simons@cryp.to>, pasky@suse.cz,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 23:26:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2W4r-0003XG-TU
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 23:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216Ab0JCV0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 17:26:11 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41867 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755164Ab0JCV0H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 17:26:07 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so3198195bwz.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 14:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:to;
        bh=QBfpV+WlXp7vuWQaXwCNp/gy0UccpWoA+q+duuv5sDE=;
        b=m/JBKn7BjPDspefzslFdMw2BPAzEbLhmVqn84UTFmIotOR+F0NYquNqi+uBN+1pCFd
         t2a3KGi+F9XHpLHpzw+96iVxGwAPiSh3Qi8w8EpclB8CcOzgCZCs5dieI7FGrRVy9gcW
         95CMLLwVwUoMoVRF8l2aDKSWjqTAQweTZOuB8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kuPQBdMndvFlnIY2yzk+FDL1M8CSYutk1zgdjrj/H1bi6jeyiUlnY3d3Gfc9aWmFDI
         zRstqtZe5hEs0gLf0FcbWJBd2pd3Atj6MeBX/P2MS5OEpwvljoUjb+IlWFDG8jFRgkvd
         IRAumMVhVpHT7qQ1MmuOraJwL0OrmVysCWzsc=
Received: by 10.204.57.146 with SMTP id c18mr6003524bkh.205.1286141165554;
        Sun, 03 Oct 2010 14:26:05 -0700 (PDT)
Received: from localhost (p5B0F7E04.dip.t-dialin.net [91.15.126.4])
        by mx.google.com with ESMTPS id d27sm3046075bku.22.2010.10.03.14.26.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 14:26:04 -0700 (PDT)
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <1286141157-30422-2-git-send-email-bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157931>

this could also be a --name-only option to tg-patch. But I Like the
similarity to 'quilt files'.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 .gitignore                 |    2 +
 README                     |    8 ++++++
 contrib/tg-completion.bash |    1 +
 tg-files.sh                |   52 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+), 0 deletions(-)

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
diff --git a/tg-files.sh b/tg-files.sh
new file mode 100644
index 0000000..0723bf1 tg-files.sh
--- /dev/null
+++ b/tg-files.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+# TopGit - A different patch queue manager
+# (c) Petr Baudis <pasky@suse.cz>  2008
+# GPLv2
+
+name=
+
+topic=
+diff_opts=
+diff_committed_only=yes	# will be unset for index/worktree
+
+
+## Parse options
+
+while [ -n "$1" ]; do
+	arg="$1"; shift
+	case "$arg" in
+	-i)
+		topic='(i)'
+		diff_opts="$diff_opts --cached";
+		diff_committed_only=;;
+	-w)
+		topic='(w)'
+		diff_committed_only=;;
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
+[ -n "$name"  -a  -z "$diff_committed_only" ]  &&
+	die "-i/-w are mutually exclusive with NAME"
+
+[ -n "$name" ] || name="$(git symbolic-ref HEAD | sed 's#^refs/\(heads\|top-bases\)/##')"
+base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)" ||
+	die "not a TopGit-controlled branch"
+
+# if not index/worktree, topic is current branch
+[ -z "$topic" ] && topic="$name"
+
+
+
+# Evil obnoxious hack to work around the lack of git diff --exclude
+git diff --name-only $diff_opts "$base_rev" ${diff_committed_only:+"$name"} -- |
+	fgrep -vx ".topdeps" |
+	fgrep -vx ".topmsg" || : # fgrep likes to fail randomly?
+
+# vim:noet
-- 
tg: (9404aa1..) bw/files (depends on: master)
