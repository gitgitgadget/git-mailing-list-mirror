From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 4/6] tg-prev/tg-next: commands to explore dependencies
Date: Sun,  3 Oct 2010 23:25:55 +0200
Message-ID: <1286141157-30422-4-git-send-email-bert.wesarg@googlemail.com>
References: <AANLkTim3gnU+_krD2QM0BAMf9DZi2_4hva6dq4WXcatH@mail.gmail.com>
 <1286141157-30422-1-git-send-email-bert.wesarg@googlemail.com>
 <1286141157-30422-2-git-send-email-bert.wesarg@googlemail.com>
 <1286141157-30422-3-git-send-email-bert.wesarg@googlemail.com>
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
	id 1P2W4r-0003XG-7S
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 23:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755232Ab0JCV0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 17:26:11 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49127 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755197Ab0JCV0J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 17:26:09 -0400
Received: by bwz11 with SMTP id 11so3198232bwz.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 14:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:to;
        bh=nz2buUnbhz7f4/I3DFBXTUCH4WIZp+eT9Nyyfu+phRo=;
        b=q7Gl7J3wAVaha2u99dAijt+JYnHujKh/yA07G7z6E2jubv+B++d+wrmkwhLxhlkAvM
         1p50b0BBMMmuDWVeZFBmiR7o+MeDGu55WOkvgrDYJpOg9oTgfUvyn4nVDHzJU0jWXVHv
         ALAadwRI0712wOXlgvotfUTnmg3bQT0zCFM/M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CDDBzXq8VSRx6Zb1TAUN0IIeP7nRUcirNYDEDRm8Gb96yALh86grR5+hTKLN+D3fM6
         suSQgNuPPNdWWItwy/m69z371FWBzb9WyQIX+TXJs9za2JgLKHO0lc/M85sippaLG/Bb
         eZfFz5ReMZDkYgudIWrzmAU/9Fi35A2ngf940=
Received: by 10.204.73.13 with SMTP id o13mr6063815bkj.173.1286141168156;
        Sun, 03 Oct 2010 14:26:08 -0700 (PDT)
Received: from localhost (p5B0F7E04.dip.t-dialin.net [91.15.126.4])
        by mx.google.com with ESMTPS id f10sm3047199bkl.5.2010.10.03.14.26.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 14:26:07 -0700 (PDT)
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <1286141157-30422-3-git-send-email-bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157930>

Two new commands to explore the dependencies of TopGit branches:

  a) tg prev [-i | -w] [NAME]
     outputs the dependencies of NAME

  b) tg next [-i | -w] [NAME]
     outputs branches which depends on NAME

Obviously, quilt next was the inspiration.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 .gitignore                 |    4 +++
 README                     |   16 +++++++++++++++
 contrib/tg-completion.bash |   34 +++++++++++++++++++++++++++++++++
 tg-next.sh                 |   45 ++++++++++++++++++++++++++++++++++++++++++++
 tg-prev.sh                 |   38 +++++++++++++++++++++++++++++++++++++
 5 files changed, 137 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 0342e09..fe4bdc1 100644 .gitignore
--- a/.gitignore
+++ b/.gitignore
@@ -28,8 +28,12 @@
 /tg-info.txt
 /tg-mail
 /tg-mail.txt
+/tg-next
+/tg-next.txt
 /tg-patch
 /tg-patch.txt
+/tg-prev
+/tg-prev.txt
 /tg-push
 /tg-push.txt
 /tg-remote
diff --git a/README b/README
index f103d92..f2d18a2 100644 README
--- a/README
+++ b/README
@@ -522,6 +522,22 @@ tg base
 	repository, so you will not see work done by your
 	collaborators.)
 
+tg prev
+~~~~~~~
+	Outputs the direct dependencies for the current or named patch.
+
+	Options:
+	  -i		show dependencies based on index instead of branch
+	  -w		show dependencies based on working tree instead of branch
+
+tg next
+~~~~~~~
+	Outputs all patches which directly depend on the current or
+	named patch.
+
+	Options:
+	  -i		show dependencies based on index instead of branch
+	  -w		show dependencies based on working tree instead of branch
 
 TODO: tg rename
 
diff --git a/contrib/tg-completion.bash b/contrib/tg-completion.bash
index 0ee233c..fd17d5c 100755 contrib/tg-completion.bash
--- a/contrib/tg-completion.bash
+++ b/contrib/tg-completion.bash
@@ -426,6 +426,38 @@ _tg_update ()
 	COMPREPLY=()
 }
 
+_tg_next ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+
+	case "$cur" in
+	-*)
+		__tgcomp "
+			-i
+			-w
+		"
+		;;
+	*)
+		__tgcomp "$(__tg_topics)"
+	esac
+}
+
+_tg_prev ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+
+	case "$cur" in
+	-*)
+		__tgcomp "
+			-i
+			-w
+		"
+		;;
+	*)
+		__tgcomp "$(__tg_topics)"
+	esac
+}
+
 ### }}}
 ### {{{ tg completion
 
@@ -471,7 +503,9 @@ _tg ()
 	import)      _tg_import ;;
 	info)        _tg_info ;;
 	mail)        _tg_mail ;;
+	next)        _tg_next ;;
 	patch)       _tg_patch ;;
+	prev)        _tg_prev ;;
 	push)        _tg_push ;;
 	remote)      _tg_remote ;;
 	summary)     _tg_summary ;;
diff --git a/tg-next.sh b/tg-next.sh
new file mode 100644
index 0000000..9b352b3 tg-next.sh
--- /dev/null
+++ b/tg-next.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+# TopGit - A different patch queue manager
+# (c) Petr Baudis <pasky@suse.cz>  2008
+# (c) Bert Wesarg <Bert.Wesarg@googlemail.com>  2009
+# GPLv2
+
+name=
+head_deps=
+
+
+## Parse options
+
+while [ -n "$1" ]; do
+	arg="$1"; shift
+	case "$arg" in
+	-i)
+		head_deps='(i)';;
+	-w)
+		head_deps='(w)';;
+	-*)
+		echo "Usage: tg next [-i | -w] [NAME]" >&2
+		exit 1;;
+	*)
+		[ -z "$name" ] || die "name already specified ($name)"
+		name="$arg";;
+	esac
+done
+
+head="$(git symbolic-ref HEAD | sed 's#^refs/\(heads\|top-bases\)/##')"
+[ -n "$name" ] || name=$head
+
+git for-each-ref --format='%(refname)' refs/top-bases |
+	while read ref; do
+		parent="${ref#refs/top-bases/}"
+
+		deps_src=$parent
+		# select .topdeps source for HEAD branch
+		[ "x$parent" = "x$head" -a -n "$head_deps" ] &&
+			deps_src=$head_deps
+
+		cat_file "$deps_src":.topdeps | fgrep -qx "$name" ||
+			continue
+
+		echo "$parent"
+	done
diff --git a/tg-prev.sh b/tg-prev.sh
new file mode 100644
index 0000000..efef410 tg-prev.sh
--- /dev/null
+++ b/tg-prev.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+# TopGit - A different patch queue manager
+# (c) Petr Baudis <pasky@suse.cz>  2008
+# (c) Bert Wesarg <Bert.Wesarg@googlemail.com>  2009
+# GPLv2
+
+name=
+head_deps=
+
+
+## Parse options
+
+while [ -n "$1" ]; do
+	arg="$1"; shift
+	case "$arg" in
+	-i)
+		head_deps='(i)';;
+	-w)
+		head_deps='(w)';;
+	-*)
+		echo "Usage: tg next [-i | -w] [NAME]" >&2
+		exit 1;;
+	*)
+		[ -z "$name" ] || die "name already specified ($name)"
+		name="$arg";;
+	esac
+done
+
+head="$(git symbolic-ref HEAD | sed 's#^refs/\(heads\|top-bases\)/##')"
+[ -n "$name" ] || name=$head
+base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)" ||
+	die "not a TopGit-controlled branch"
+
+deps_src=$name
+# select .topdeps source for HEAD branch
+[ "x$name" = "x$head" -a -n "$head_deps" ] &&
+	deps_src=$head_deps
+cat_file "$deps_src:.topdeps"
-- 
tg: (9404aa1..) bw/next-prev-base (depends on: master)
