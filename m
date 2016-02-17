From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] rebase: move cleanup code to exit_rebase()
Date: Wed, 17 Feb 2016 20:36:40 +0700
Message-ID: <1455716201-29784-3-git-send-email-pclouds@gmail.com>
References: <vpqio1nsk0q.fsf@anie.imag.fr>
 <1455716201-29784-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu.Moy@grenoble-inp.fr, sbeller@google.com, peff@peff.net,
	christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 14:36:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW2Hq-0002Ud-EU
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 14:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423010AbcBQNgt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Feb 2016 08:36:49 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33937 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422802AbcBQNgs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 08:36:48 -0500
Received: by mail-pa0-f46.google.com with SMTP id fy10so11539856pac.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 05:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+WkDHjzLWxnhku0zIT6/FJyySHcQnYCgCAULvoL+eCo=;
        b=mPiCHg39NJeEHW+o3zL1DoWQDaFdGSDOYs11XYSwUFfyU2rUirMkrHr9g5WFHVslPu
         +pI9Or0NlVYPzmErBd8Df9fnM0JsgnXuWIRp6R3hwpViE/helXP6OcM0BOS6N5LwsshV
         XLpHz8Oh/S2jiRuRrEED9D8CKOqYYuECqEweNQP+hdU454iamNdg6MmomFjA5pVX3mtO
         YfxkIsqOF75LSSy9FPhl1FdQSxcOHMGlhDEFOwLpALET1w9y8BkKoChBvQJ38CyHU3+K
         Ewg7CUPqf40BxUpCFJIV4/du4RozHiXaZLHnvgQIRhz8G/aeRxo3itYOXsC37dOIwXOp
         uySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=+WkDHjzLWxnhku0zIT6/FJyySHcQnYCgCAULvoL+eCo=;
        b=OuFa0pbrGh/5QqWISwQBKLttHcomXVr3LN77b/SxsxgYVPRWc3tHpmo/gxM1tTk49t
         5voh1qHhf0Qcr6smVgvfGM7k/KVA2eexd2E0hc2fPOIWLfmQ8cna4ayFRAmwAwPdtOTD
         xnomDdMNCwqyyi7CRIvF86iLQU4EBpHBRa/7Yca0L8CGfk+x5Dio3gydRa9Egy5ol1Bz
         QqugQTk58eYVxxqpn4pMSNAwz0BUV1cPO61+0kdSMKWl8kqV+PHSHhc0+pBGaE4DIpud
         P7FbS+p3MAWm2VJiQSVGUeO1Gy/8KE35UEMtqlS7ymv6VLgTAzv7ORlgjwZV6qRFe7SJ
         AebQ==
X-Gm-Message-State: AG10YOTjNeWNcTmHsnOb96oI+sa2gykQZKy7DINtxYx3IopJYvWSMFs97DTAGsQdMBwSvw==
X-Received: by 10.66.255.39 with SMTP id an7mr2180204pad.2.1455716208579;
        Wed, 17 Feb 2016 05:36:48 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id yj1sm2923260pac.16.2016.02.17.05.36.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Feb 2016 05:36:47 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 17 Feb 2016 20:37:11 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455716201-29784-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286500>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git-rebase--lib.sh (mode +x) | 38 ++++++++++++++++++++++++++++++++++++=
++
 git-rebase.sh                | 37 +-----------------------------------=
-
 2 files changed, 39 insertions(+), 36 deletions(-)
 mode change 100644 =3D> 100755 git-rebase--lib.sh

diff --git a/git-rebase--lib.sh b/git-rebase--lib.sh
old mode 100644
new mode 100755
index 8bec516..a876fc2
--- a/git-rebase--lib.sh
+++ b/git-rebase--lib.sh
@@ -39,3 +39,41 @@ move_to_original_branch () {
 		;;
 	esac
 }
+
+apply_autostash () {
+	if test -f "$state_dir/autostash"
+	then
+		stash_sha1=3D$(cat "$state_dir/autostash")
+		if git stash apply $stash_sha1 2>&1 >/dev/null
+		then
+			echo "$(gettext 'Applied autostash.')"
+		else
+			git stash store -m "autostash" -q $stash_sha1 ||
+			die "$(eval_gettext "Cannot store \$stash_sha1")"
+			gettext 'Applying autostash resulted in conflicts.
+Your changes are safe in the stash.
+You can run "git stash pop" or "git stash drop" at any time.
+'
+		fi
+	fi
+}
+
+finish_rebase () {
+	apply_autostash &&
+	{ git gc --auto || true; } &&
+	rm -rf "$state_dir"
+}
+
+exit_rebase () {
+	ret=3D$1
+	if test $ret -eq 0
+	then
+		finish_rebase
+	elif test $ret -eq 2 # special exit status for rebase -i
+	then
+		apply_autostash &&
+		rm -rf "$state_dir" &&
+		die "Nothing to do"
+	fi
+	exit $ret
+}
diff --git a/git-rebase.sh b/git-rebase.sh
index dc29474..0c70381 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -115,31 +115,6 @@ read_basic_state () {
 		gpg_sign_opt=3D"$(cat "$state_dir"/gpg_sign_opt)"
 }
=20
-
-apply_autostash () {
-	if test -f "$state_dir/autostash"
-	then
-		stash_sha1=3D$(cat "$state_dir/autostash")
-		if git stash apply $stash_sha1 2>&1 >/dev/null
-		then
-			echo "$(gettext 'Applied autostash.')"
-		else
-			git stash store -m "autostash" -q $stash_sha1 ||
-			die "$(eval_gettext "Cannot store \$stash_sha1")"
-			gettext 'Applying autostash resulted in conflicts.
-Your changes are safe in the stash.
-You can run "git stash pop" or "git stash drop" at any time.
-'
-		fi
-	fi
-}
-
-finish_rebase () {
-	apply_autostash &&
-	{ git gc --auto || true; } &&
-	rm -rf "$state_dir"
-}
-
 run_specific_rebase () {
 	if [ "$interactive_rebase" =3D implied ]; then
 		GIT_EDITOR=3D:
@@ -147,17 +122,7 @@ run_specific_rebase () {
 		autosquash=3D
 	fi
 	. git-rebase--$type
-	ret=3D$?
-	if test $ret -eq 0
-	then
-		finish_rebase
-	elif test $ret -eq 2 # special exit status for rebase -i
-	then
-		apply_autostash &&
-		rm -rf "$state_dir" &&
-		die "Nothing to do"
-	fi
-	exit $ret
+	exit_rebase $?
 }
=20
 run_pre_rebase_hook () {
--=20
2.7.0.377.g4cd97dd
