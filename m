From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v4 2/7] gettext: Add a Gettext interface for shell scripts
Date: Wed,  2 Jun 2010 01:05:59 +0000
Message-ID: <1275440764-26153-3-git-send-email-avarab@gmail.com>
References: <AANLkTimhxqGRPjYz-k5f-LTIk6KajEwUuGJWt-dAKZQT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 02 03:06:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJcPo-0004k8-NZ
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 03:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757469Ab0FBBGT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 21:06:19 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55589 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756793Ab0FBBGR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 21:06:17 -0400
Received: by mail-fx0-f46.google.com with SMTP id 8so1482447fxm.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 18:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=esho48d41aS42zIOgyjiKdzHWa5IMAJuleOqNE9Qwpo=;
        b=YuQPEZl7KURdxFgzw4ieOQCnZnn4kcpOm64ORPndgfiNqKanwrJFoyki0q8wyRlUTw
         njuOBzETxoqeSQy6VgPHNVgZk84qn/ELpgyuyK1fibQM0ZphffNgTZT5+AWz0KTUG3BD
         UEz1qtk85OHNM5crBR/DQfr4rxAC6/K88hr8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=s1yAvRO/HTcmJ+w6ScZMgQrVd6RthXmlOheszxe1wM5oOK7L0AHNrCszr9ZOkgMFT+
         LKLl1MoI+UpAD4TSm3TexwDL6N8xbnPCV7Y4fPS4q6gpOMHjvg/IJHaVBKgkGrfKwgLC
         CGvfgPOxWL0wMWhef3WCcbOjYyrVbqTKwh/2E=
Received: by 10.223.92.153 with SMTP id r25mr7885584fam.76.1275440776009;
        Tue, 01 Jun 2010 18:06:16 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id 13sm49688716fad.7.2010.06.01.18.06.14
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 18:06:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.gec7f5.dirty
In-Reply-To: <AANLkTimhxqGRPjYz-k5f-LTIk6KajEwUuGJWt-dAKZQT@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148187>

Use GNU's gettext.sh in git-sh-setup if it's available, otherwise
fallback on our own custom functions.

A couple of strings in git-pull.sh are now translatable as a proof of
concept, including a multiline string.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Makefile        |    7 +++++--
 git-pull.sh     |   15 ++++++++-------
 git-sh-setup.sh |   38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 4de0627..dce2faa 100644
--- a/Makefile
+++ b/Makefile
@@ -272,6 +272,7 @@ mandir =3D share/man
 infodir =3D share/info
 gitexecdir =3D libexec/git-core
 sharedir =3D $(prefix)/share
+localedir =3D $(sharedir)/locale
 template_dir =3D share/git-core/templates
 htmldir =3D share/doc/git-doc
 ifeq ($(prefix),/usr)
@@ -285,7 +286,7 @@ lib =3D lib
 # DESTDIR=3D
 pathsep =3D :
=20
-export prefix bindir sharedir sysconfdir
+export prefix bindir sharedir localedir sysconfdir
=20
 CC =3D gcc
 AR =3D ar
@@ -1455,6 +1456,7 @@ htmldir_SQ =3D $(subst ','\'',$(htmldir))
 prefix_SQ =3D $(subst ','\'',$(prefix))
 sharedir_SQ =3D $(subst ','\'',$(sharedir))
=20
+LOCALEDIR_SQ =3D $(subst ','\'',$(localedir))
 SHELL_PATH_SQ =3D $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ =3D $(subst ','\'',$(PERL_PATH))
 PYTHON_PATH_SQ =3D $(subst ','\'',$(PYTHON_PATH))
@@ -1548,6 +1550,7 @@ $(RM) $@ $@+ && \
 sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
     -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
+    -e 's|@@LOCALEDIR@@|$(LOCALEDIR_SQ)|g' \
     -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
     -e $(BROKEN_PATH_FIX) \
     $@.sh >$@+
@@ -1881,7 +1884,7 @@ cscope:
 	$(FIND) . -name '*.[hcS]' -print | xargs cscope -b
=20
 pot:
-	$(XGETTEXT) -k_ -o po/git.pot $(C_OBJ:o=3Dc)
+	$(XGETTEXT) -k_ -o po/git.pot $(C_OBJ:o=3Dc) $(SCRIPT_SH)
=20
 POFILES :=3D $(wildcard po/*.po)
 MOFILES :=3D $(patsubst po/%.po,share/locale/%/LC_MESSAGES/git.mo,$(PO=
=46ILES))
diff --git a/git-pull.sh b/git-pull.sh
index 1a4729f..22a6da2 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -121,8 +121,8 @@ error_on_no_merge_candidates () {
 	do
 		case "$opt" in
 		-t|--t|--ta|--tag|--tags)
-			echo "Fetching tags only, you probably meant:"
-			echo "  git fetch --tags"
+			gettext "Fetching tags only, you probably meant:"; echo
+			gettext "  git fetch --tags"; echo
 			exit 1
 		esac
 	done
@@ -154,11 +154,12 @@ error_on_no_merge_candidates () {
 		echo "a branch. Because this is not the default configured remote"
 		echo "for your current branch, you must specify a branch on the comm=
and line."
 	elif [ -z "$curr_branch" ]; then
-		echo "You are not currently on a branch, so I cannot use any"
-		echo "'branch.<branchname>.merge' in your configuration file."
-		echo "Please specify which remote branch you want to use on the comm=
and"
-		echo "line and try again (e.g. 'git pull <repository> <refspec>')."
-		echo "See git-pull(1) for details."
+        gettext "You are not currently on a branch, so I cannot use an=
y
+'branch.<branchname>.merge' in your configuration file.
+Please specify which remote branch you want to use on the command
+line and try again (e.g. 'git pull <repository> <refspec>').
+See git-pull(1) for details.";
+        echo
 	elif [ -z "$upstream" ]; then
 		echo "You asked me to pull without telling me which branch you"
 		echo "want to $op_type $op_prep, and 'branch.${curr_branch}.merge' i=
n"
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 6131670..53cfc42 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -211,3 +211,41 @@ case $(uname -s) in
 	}
 	;;
 esac
+
+# Try to use libintl's gettext.sh, or fall back to English if we
+# can't.
+. gettext.sh
+if test $? -eq 0
+then
+	TEXTDOMAIN=3Dgit
+	export TEXTDOMAIN
+	if [ -z "$GIT_TEXTDOMAINDIR" ]
+	then
+		TEXTDOMAINDIR=3D"@@LOCALEDIR@@"
+	else
+		TEXTDOMAINDIR=3D$GIT_TEXTDOMAINDIR
+	fi
+	export TEXTDOMAINDIR
+else
+	# Since GNU gettext.sh isn't available we'll have to define our
+	# own dummy functions.
+
+	# This code adapted from NessusClient-1.0.2's nessusclient-mkcert
+	# by Michel Arboi <arboi@alussinan.org>. The original code is
+	# under the GPLv2.
+
+	# Not everyone has echo -n
+	case $(echo -n) in
+		\-n)	Xn=3D	  ; Xc=3D'\c' ;;
+		*)		Xn=3D-n ; Xc=3D
+	esac
+
+	gettext () {
+		echo $Xn "$1" $Xc
+	}
+
+	eval_gettext () {
+		eval_gettext_var=3D"echo $1"
+		echo $Xn `eval $eval_gettext_var` $Xc
+	}
+fi
--=20
1.7.1.251.gec7f5.dirty
