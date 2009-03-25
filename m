From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH] tg-tred: Print the transitive reduction of the dependecies
Date: Wed, 25 Mar 2009 11:35:41 +0100
Message-ID: <1237977341-32173-1-git-send-email-bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	u.kleine-koenig@pengutronix.de
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Mar 25 11:37:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmQUP-0007zb-Vu
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 11:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756964AbZCYKgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 06:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756448AbZCYKgE
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 06:36:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:31753 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755361AbZCYKgB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 06:36:01 -0400
Received: by fg-out-1718.google.com with SMTP id 16so701689fgg.17
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 03:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=6PV+aQH14eBXvL9FbYJP1llY3UgUQpqN8T6z/JzFKKM=;
        b=CBjh3bFerxhZyDHpnfoiUeq17JEi7Y/PPkArvA1pzNu7sc7nhh09L00SDLPUQEYd7L
         F5CSiAyQR5kz0ke8m/wX26eUTKAN8Bce1jdGdPf7W4v+uiupHoBujwrncDv9lwAAVP5q
         ULy1yFBVGsrxEMJqyJpgV1HBctkpHZ5GHO8Fw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=SbOWQKGdYTnHT0w5BpxvZTzGPhWX9yM2xC9URL4mWUjJ7SHgoBQltx98XUsDfRIasK
         C3x5UYnThx9/U/qP1//QcMlCTcPGKb8NP6owUKdpr9T5xkeWkz81dE5ej/SYPm6KjPvn
         IAVaCe5tVDX822UuA4AoysJencWTmoQ+5aOWM=
Received: by 10.86.59.2 with SMTP id h2mr5374659fga.73.1237977358427;
        Wed, 25 Mar 2009 03:35:58 -0700 (PDT)
Received: from localhost (p5B0F7A07.dip.t-dialin.net [91.15.122.7])
        by mx.google.com with ESMTPS id d4sm3595983fga.13.2009.03.25.03.35.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Mar 2009 03:35:57 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.148.g0b7ce
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114581>

This uses the tred(1) and gvpr(1) program from the graphviz package to reduce
the dependencies of the given TopGit branch.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 .gitignore |    2 ++
 README     |   22 ++++++++++++++++++++++
 tg-tred.sh |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index eb56446..1061d93 100644
--- a/.gitignore
+++ b/.gitignore
@@ -13,6 +13,8 @@
 /tg-patch.txt
 /tg-summary
 /tg-summary.txt
+/tg-tred
+/tg-tred.txt
 /tg-update
 /tg-update.txt
 /tg-export
diff --git a/README b/README
index d2f095d..a941cb6 100644
--- a/README
+++ b/README
@@ -480,6 +480,28 @@ tg update
 
 	TODO: tg update -a for updating all topic branches
 
+tg tred
+~~~~~~~
+	Prints the transitive reduction of the dependecies for the current
+	or named TopGit branch.
+
+	To actually use this reduced dependencies list, feed the output into
+	the .topdeps file, commit and run tg update, like:
+
+	$ tg tred > .topdeps
+	$ tg add -f .topdeps
+	$ git commit -m "transitive reduce TopGit dependencies"
+	$ tg update
+
+	If you want to see the differences to the current dependencies, run
+	this:
+
+	$ diff -u -L current -L tred <(git show :.topdeps) <(tg tred)
+
+	TODO: tg tred -a for reducing all branches
+	TODO: tg tred -r for reducing recursive all from the current/named
+	      branch
+
 TODO: tg rename
 
 
diff --git a/tg-tred.sh b/tg-tred.sh
new file mode 100644
index 0000000..f41e051
--- /dev/null
+++ b/tg-tred.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+# TopGit - A different patch queue manager
+# (c) Petr Baudis <pasky@suse.cz>              2008
+# (c) Bert Wesarg <bert.wesarg@googlemail.com> 2009
+# GPLv2
+
+name=
+
+
+## Parse options
+
+while [ -n "$1" ]; do
+	arg="$1"; shift
+	case "$arg" in
+	-*)
+		echo "Usage: tg [...] tred [NAME]" >&2
+		exit 1;;
+	*)
+		[ -z "$name" ] || die "name already specified ($name)"
+		name="$arg";;
+	esac
+done
+
+[ -n "$name" ] || name="$(git symbolic-ref HEAD | sed 's#^refs/\(heads\|top-bases\)/##')"
+base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)" ||
+	die "not a TopGit-controlled branch"
+
+type tred >/dev/null 2>&1 ||
+	die "need the tred(1) tool from the graphviz package"
+type gvpr >/dev/null 2>&1 ||
+	die "need the gvpr(1) tool from the graphviz package"
+
+$tg summary --graphviz |
+	tred |
+	gvpr -a "\"${name}\"" '
+BEG_G {
+    node_t  ctr;
+    edge_t  e;
+
+    ctr = isNode($, ARGV[0]);
+    for (e = fstedge(ctr); e; e = nxtedge(e,ctr)) {
+        if (e.head.name != ARGV[0])
+            printf("%s\n", e.head.name);
+    }
+    exit(0);
+}
+'
-- 
tg: (fcb488d..) bw/tred (depends on: master)
