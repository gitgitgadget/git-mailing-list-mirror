From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 1/6] i18n win32: add git-am eval_gettext variable prefix
Date: Wed, 25 May 2011 23:19:49 +0000
Message-ID: <1306365594-22061-2-git-send-email-avarab@gmail.com>
References: <1306365594-22061-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 01:20:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPNN6-0007rM-PM
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 01:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952Ab1EYXUG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2011 19:20:06 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37010 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194Ab1EYXUE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 19:20:04 -0400
Received: by eyx24 with SMTP id 24so106223eyx.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 16:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=RQ1uqPfv9geLcP4koa7zl8f6ZHlFVw/uQ7oPynHsulU=;
        b=cTFdyTsx3iQ0fomppycBmu/lLJ44mMSzKPuTOwPER1acT5HquUVKqqFANqeK1lBuMO
         qKYhAcYF8iz8J1LaKvLWBqTzxQ7wetKwkKSh2w8iB9RMnrQdyO3hrIldylPsUavnO6/J
         1dhMR70TKPkGrkz63XFvly3FkgkCnJbzAW7X0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=iBVt8A2GJmonTCRfFJU4nPO//MiFZTjbH8Q4dPxyRtPTe4IDVgOAblRAHGIh3Y+BTP
         P91VrHlXODOE1O7HghHU1F2YPbHH2kyKm/iOe5Cj6b65Ih/aXjoAM4QSsw7peomvqu32
         pkVtG9UFhFpli2144urTdtF6XUEStI70s17Ec=
Received: by 10.213.108.132 with SMTP id f4mr84706ebp.133.1306365603044;
        Wed, 25 May 2011 16:20:03 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b1sm102972eeg.19.2011.05.25.16.20.02
        (version=SSLv3 cipher=OTHER);
        Wed, 25 May 2011 16:20:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306365594-22061-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174474>

Change the eval_gettext() invocations to use the GIT_I18N_VARIABLE_
prefix for variables used in eval_gettext. On Windows environment
variables are case insensitive, so e.g. $PATH clashes with $path. By
using a sufficiently unique prefix we work around that issue.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |   29 +++++++++++++++++++----------
 1 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index df918bb..02ecf66 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -102,9 +102,11 @@ stop_here_user_resolve () {
 	    printf '%s\n' "$resolvemsg"
 	    stop_here $1
     fi
-    eval_gettext "When you have resolved this problem run \"\$cmdline =
--resolved\".
-If you would prefer to skip this patch, instead run \"\$cmdline --skip=
\".
-To restore the original branch and stop patching run \"\$cmdline --abo=
rt\"."; echo
+
+    GIT_I18N_VARIABLE_cmdline=3D$cmdline
+    eval_gettext "When you have resolved this problem run \"\$GIT_I18N=
_VARIABLE_cmdline --resolved\".
+If you would prefer to skip this patch, instead run \"\$GIT_I18N_VARIA=
BLE_cmdline --skip\".
+To restore the original branch and stop patching run \"\$GIT_I18N_VARI=
ABLE_cmdline --abort\"."; echo
=20
     stop_here $1
 }
@@ -310,7 +312,8 @@ split_patches () {
 		;;
 	*)
 		if test -n "$parse_patch" ; then
-			clean_abort "$(eval_gettext "Patch format \$patch_format is not sup=
ported.")"
+			GIT_I18N_VARIABLE_patch_format=3D$patch_format
+			clean_abort "$(eval_gettext "Patch format \$GIT_I18N_VARIABLE_patch=
_format is not supported.")"
 		else
 			clean_abort "$(gettext "Patch format detection failed.")"
 		fi
@@ -407,6 +410,7 @@ fi
=20
 if test -d "$dotest"
 then
+	GIT_I18N_VARIABLE_dotest=3D$dotest
 	case "$#,$skip$resolved$abort" in
 	0,*t*)
 		# Explicit resume command and we do not have file, so
@@ -425,7 +429,7 @@ then
 		false
 		;;
 	esac ||
-	die "$(eval_gettext "previous rebase directory \$dotest still exists =
but mbox given.")"
+	die "$(eval_gettext "previous rebase directory \$GIT_I18N_VARIABLE_do=
test still exists but mbox given.")"
 	resume=3Dyes
=20
 	case "$skip,$abort" in
@@ -522,7 +526,8 @@ case "$resolved" in
 	if test "$files"
 	then
 		test -n "$HAS_HEAD" && : >"$dotest/dirtyindex"
-		die "$(eval_gettext "Dirty index: cannot apply patches (dirty: \$fil=
es)")"
+		GIT_I18N_VARIABLE_files=3D$files
+		die "$(eval_gettext "Dirty index: cannot apply patches (dirty: \$GIT=
_I18N_VARIABLE_files)")"
 	fi
 esac
=20
@@ -611,9 +616,10 @@ do
 			go_next && continue
=20
 		test -s "$dotest/patch" || {
+			GIT_I18N_VARIABLE_cmdline=3D$cmdline
 			eval_gettext "Patch is empty.  Was it split wrong?
-If you would prefer to skip this patch, instead run \"\$cmdline --skip=
\".
-To restore the original branch and stop patching run \"\$cmdline --abo=
rt\"."; echo
+If you would prefer to skip this patch, instead run \"\$GIT_I18N_VARIA=
BLE_cmdline --skip\".
+To restore the original branch and stop patching run \"\$GIT_I18N_VARI=
ABLE_cmdline --abort\"."; echo
 			stop_here $this
 		}
 		rm -f "$dotest/original-commit" "$dotest/author-script"
@@ -742,7 +748,8 @@ To restore the original branch and stop patching ru=
n \"\$cmdline --abort\"."; ec
 		stop_here $this
 	fi
=20
-	say "$(eval_gettext "Applying: \$FIRSTLINE")"
+	GIT_I18N_VARIABLE_FIRSTLINE=3D$FIRSTLINE
+	say "$(eval_gettext "Applying: \$GIT_I18N_VARIABLE_FIRSTLINE")"
=20
 	case "$resolved" in
 	'')
@@ -797,7 +804,9 @@ did you forget to use 'git add'?"; echo
 	fi
 	if test $apply_status !=3D 0
 	then
-		eval_gettext 'Patch failed at $msgnum $FIRSTLINE'; echo
+		GIT_I18N_VARIABLE_msgnum=3D$msgnum
+		GIT_I18N_VARIABLE_FIRSTLINE=3D$FIRSTLINE
+		eval_gettext 'Patch failed at $GIT_I18N_VARIABLE_msgnum $GIT_I18N_VA=
RIABLE_FIRSTLINE'; echo
 		stop_here_user_resolve $this
 	fi
=20
--=20
1.7.5.1
