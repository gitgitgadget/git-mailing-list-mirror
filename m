From: Russell Steicke <russellsteicke@gmail.com>
Subject: [PATCH] [TopGit] Make "tg help cmd" print cmd help
Date: Mon, 4 Aug 2008 22:39:22 +0800
Message-ID: <20080804143922.GE11179@maggie.localnet>
Reply-To: Russell Steicke <russellsteicke@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Aug 04 16:40:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ1Eg-0003GE-Vg
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 16:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611AbYHDOjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 10:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753652AbYHDOjc
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 10:39:32 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:14548 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbYHDOjb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 10:39:31 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2128443rvb.1
        for <git@vger.kernel.org>; Mon, 04 Aug 2008 07:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:reply-to:mime-version:content-type:content-disposition
         :x-boo:x-message-flag:x-disclaimer:x-system:x-uptime:user-agent;
        bh=SJ8oA+9IVX88EPMseTF3DHIdvM/NErjhwQ+bzf58+dc=;
        b=do7MY372Nbv4PN0ul3kWAoos26gdX63N4DSCgO2MgyFPqGvfs3sWhj/f8qBX7UcPXY
         QaySQ4j1bJPJkiAUPLqTrcMogWew3o3gLE+QTCc7OW4t7rE5aLnF4tpeJRgVdXzeZoi0
         HAuHjXlS/ZgCn559bROsoMzgvEGBHRpLzAuPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-type:content-disposition:x-boo:x-message-flag:x-disclaimer
         :x-system:x-uptime:user-agent;
        b=CbDD8mK/Nzs0qFOf+ubkGsrokP6kq2UipxgLNGqdhG7aZV1UgS3gkN79h/unLjl6nj
         +3VrA/es78tw9zzS+liKZ8NTsBdGjM2P6jm8rATiymhYuBLNguWWFibuXVhZhF3HEdmi
         GtiOjeDjk/DMZ3PZEeXaXbO/G9T5+jdqAHFvw=
Received: by 10.140.157.4 with SMTP id f4mr7576490rve.118.1217860770805;
        Mon, 04 Aug 2008 07:39:30 -0700 (PDT)
Received: from localhost ( [203.33.247.40])
        by mx.google.com with ESMTPS id c20sm7059735rvf.1.2008.08.04.07.39.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Aug 2008 07:39:29 -0700 (PDT)
Content-Disposition: inline
X-Boo: Boo!
X-message-flag: I see that you run Outlook...
X-Disclaimer: This message represents the official view of the voices in my head.
X-System: Linux maggie 2.6.18-6-powerpc64 
X-Uptime: 08:58:05 up 4 days, 15:17, 16 users,  load average: 4.74, 4.35, 3.89
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91362>

"tg help" looked like it needed help, and stuff it needed to know
about was already in README.

Use awk to extract help information from the README file.  Store
the help files in $(PREFIX)/share/topgit.  "tg help foo" will cat
$(PREFIX)/share/topgit/tg-foo.txt.

This is instead of the previous patch.  It fixes a bug where the
help for the last command (update) wasn't terminated properly.

Signed-off-by: Russell Steicke <russellsteicke@gmail.com>

---
 .gitignore     |    6 ++++++
 Makefile       |   11 +++++++++--
 create-help.sh |   17 +++++++++++++++++
 tg.sh          |   16 ++++++++++++++--
 4 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/.gitignore b/.gitignore
index 53ca141..6f0727f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,8 +1,14 @@
 hooks/pre-commit
 tg-create
+tg-create.txt
 tg-delete
+tg-delete.txt
 tg-info
+tg-info.txt
 tg-patch
+tg-patch.txt
 tg-summary
+tg-summary.txt
 tg-update
+tg-update.txt
 tg
diff --git a/Makefile b/Makefile
index 3913d66..501df5a 100644
--- a/Makefile
+++ b/Makefile
@@ -2,6 +2,7 @@
 PREFIX = $(HOME)
 bindir = $(PREFIX)/bin
 cmddir = $(PREFIX)/libexec/topgit
+sharedir = $(PREFIX)/share/topgit
 hooksdir = $(cmddir)/hooks
 
 
@@ -10,18 +11,22 @@ hooks_in = hooks/pre-commit.sh
 
 commands_out = $(patsubst %.sh,%,$(commands_in))
 hooks_out = $(patsubst %.sh,%,$(hooks_in))
+help_out = $(patsubst %.sh,%.txt,$(commands_in))
 
-all::	tg $(commands_out) $(hooks_out)
+all::	tg $(commands_out) $(hooks_out) $(help_out)
 
 tg $(commands_out) $(hooks_out): % : %.sh
 	@echo "[SED] $@"
 	@sed -e 's#@cmddir@#$(cmddir)#g;' \
 		-e 's#@hooksdir@#$(hooksdir)#g' \
 		-e 's#@bindir@#$(bindir)#g' \
+		-e 's#@sharedir@#$(sharedir)#g' \
 		$@.sh >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
 
+$(help_out): README create-help.sh
+	./create-help.sh `echo $@ | sed -e 's/tg-//' -e 's/\.txt//'`
 
 install:: all
 	install tg "$(bindir)"
@@ -29,6 +34,8 @@ install:: all
 	install $(commands_out) "$(cmddir)"
 	install -d -m 755 "$(hooksdir)"
 	install $(hooks_out) "$(hooksdir)"
+	install -d -m 755 "$(sharedir)"
+	install $(help_out) "$(sharedir)"
 
 clean::
-	rm -f tg $(commands_out) $(hooks_out)
+	rm -f tg $(commands_out) $(hooks_out) $(help_out)
diff --git a/create-help.sh b/create-help.sh
new file mode 100755
index 0000000..502b6c3
--- /dev/null
+++ b/create-help.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+# Create the tg-foo.txt files which contain help for the tg-foo command.
+
+if [ $# -ne 1 ] ; then
+	echo "Usage: $0 tgcommand" 1>&2
+	exit 1
+fi
+
+< README awk '
+	BEGIN { incommand = 0; }
+	/^tg '"$1"'$/ { incommand = 1; next; }
+	/^[a-zA-Z]/ { incommand = 0; next; }
+	/^~/ { next; } # Ignore the title underlines.
+	{ if (incommand) { print $0; } }
+'  > tg-"$1".txt
+
diff --git a/tg.sh b/tg.sh
index e7c42cd..03a392b 100644
--- a/tg.sh
+++ b/tg.sh
@@ -148,6 +148,19 @@ switch_to_base()
 	git symbolic-ref HEAD "$_base"
 }
 
+# Show the help messages.
+do_help()
+{
+	if [ -z "$1" ] ; then
+		echo "TopGit v0.1 - A different patch queue manager"
+		echo "Usage: tg (create|delete|info|patch|summary|update|help) ..."
+	elif [ -f "@sharedir@/tg-$1.txt" ] ; then
+		cat "@sharedir@/tg-$1.txt"
+	else
+		echo "`basename $0`: no help for $1" 1>&2
+	fi
+}
+
 
 ## Initial setup
 
@@ -171,8 +184,7 @@ shift
 
 case "$cmd" in
 help)
-	echo "TopGit v0.1 - A different patch queue manager"
-	echo "Usage: tg (create|delete|info|patch|summary|update|help) ..."
+	do_help "$1"
 	exit 1;;
 create|delete|info|patch|summary|update)
 	. "@cmddir@"/tg-$cmd;;
-- 
tg: (24367cc..) t/help (depends on: master)




-- 
Russell Steicke

-- Fortune says:
BOFH excuse #144:

Too few computrons available.
