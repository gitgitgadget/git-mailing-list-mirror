From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 19/51] i18n: git-pull "rebase against" / "merge with" messages
Date: Sun,  3 Apr 2011 16:45:43 +0000
Message-ID: <1301849175-1697-20-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:47:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QSI-00055g-J8
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892Ab1DCQqu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:46:50 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:33259 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870Ab1DCQqt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:46:49 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1505908ewy.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=mW9rn+ZZDlrqk1UBZ64B9WsPc3NorPayeDGmcce8Uw8=;
        b=KFeRxlSiWzd15WSyOeXl5lvgzd6BTRnR0eQ7bKg6JJUGYxY+v/asT4/85+dK1Jb312
         4JiHPS+bkOglK+daeHSEfa+sxdtKMa2elqf8Qe6Z0giMPWQRbqSVpvPrilysVTle2vxv
         2jsebglKoXwk4/SeudHwuX6kBK2fUJeFozJ3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kKFzAc1OPvDWqNayo2iDy8iQWTvkQaoo8rskkOg2zAzADej1Hi617Ljk/zuBJAiILB
         pkmz3oxQdWbzUmxpLbsNfOtGnNsNYaSraQPmf6nhHvzDG2kYpr49xntOJ1/azS2BExnh
         yvK+I3gJfQwAwOch3j5oVSOk5Sxo/dq2aJC20=
Received: by 10.213.29.196 with SMTP id r4mr1189384ebc.42.1301849208470;
        Sun, 03 Apr 2011 09:46:48 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.47
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170716>

Gettextize the two messages that used "rebase against" and "merge
with". Split them into two depending on whether we are rebasing or not.

This results in some duplication, but makes it much easier for
translators to translate these messages.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-pull.sh |   84 ++++++++++++++++++++++++++++++++++++---------------=
-------
 1 files changed, 52 insertions(+), 32 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 14d9eb5..ea87ac7 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -140,15 +140,6 @@ error_on_no_merge_candidates () {
 		esac
 	done
=20
-	if test true =3D "$rebase"
-	then
-		op_type=3Drebase
-		op_prep=3Dagainst
-	else
-		op_type=3Dmerge
-		op_prep=3Dwith
-	fi
-
 	curr_branch=3D${curr_branch#refs/heads/}
 	upstream=3D$(git config "branch.$curr_branch.merge")
 	remote=3D$(git config "branch.$curr_branch.remote")
@@ -177,30 +168,59 @@ Please specify which remote branch you want to us=
e on the command
 line and try again (e.g. 'git pull <repository> <refspec>').
 See git-pull(1) for details."; echo
 	elif [ -z "$upstream" ]; then
-		echo "You asked me to pull without telling me which branch you"
-		echo "want to $op_type $op_prep, and 'branch.${curr_branch}.merge' i=
n"
-		echo "your configuration file does not tell me, either. Please"
-		echo "specify which branch you want to use on the command line and"
-		echo "try again (e.g. 'git pull <repository> <refspec>')."
-		echo "See git-pull(1) for details."
-		echo
-		echo "If you often $op_type $op_prep the same branch, you may want t=
o"
-		echo "use something like the following in your configuration file:"
-		echo
-		echo "    [branch \"${curr_branch}\"]"
-		echo "    remote =3D <nickname>"
-		echo "    merge =3D <remote-ref>"
-		test rebase =3D "$op_type" &&
-			echo "    rebase =3D true"
-		echo
-		echo "    [remote \"<nickname>\"]"
-		echo "    url =3D <url>"
-		echo "    fetch =3D <refspec>"
-		echo
-		echo "See git-config(1) for details."
+		if test true =3D "$rebase"
+		then
+			eval_gettext "You asked me to pull without telling me which branch =
you
+want to rebase against, and 'branch.\${curr_branch}.merge' in
+your configuration file does not tell me, either. Please
+specify which branch you want to use on the command line and
+try again (e.g. 'git pull <repository> <refspec>').
+See git-pull(1) for details.
+
+If you often rebase against the same branch, you may want to
+use something like the following in your configuration file:
+
+    [branch \"\${curr_branch}\"]
+    remote =3D <nickname>
+    merge =3D <remote-ref>
+    rebase =3D true
+
+    [remote \"<nickname>\"]
+    url =3D <url>
+    fetch =3D <refspec>
+
+See git-config(1) for details."; echo
+		else
+			eval_gettext "You asked me to pull without telling me which branch =
you
+want to merge with, and 'branch.\${curr_branch}.merge' in
+your configuration file does not tell me, either. Please
+specify which branch you want to use on the command line and
+try again (e.g. 'git pull <repository> <refspec>').
+See git-pull(1) for details.
+
+If you often merge with the same branch, you may want to
+use something like the following in your configuration file:
+
+    [branch \"\${curr_branch}\"]
+    remote =3D <nickname>
+    merge =3D <remote-ref>
+
+    [remote \"<nickname>\"]
+    url =3D <url>
+    fetch =3D <refspec>
+
+See git-config(1) for details."; echo
+		fi
 	else
-		echo "Your configuration specifies to $op_type $op_prep the ref '${u=
pstream#refs/heads/}'"
-		echo "from the remote, but no such ref was fetched."
+		upstream_branch=3D"${upstream#refs/heads/}"
+		if test true =3D "$rebase"
+		then
+			eval_gettext "Your configuration specifies to rebase against the re=
f '\$upstream_branch'
+from the remote, but no such ref was fetched."; echo
+		else
+			eval_gettext "Your configuration specifies to merge with the ref '\=
$upstream_branch'
+from the remote, but no such ref was fetched."; echo
+		fi
 	fi
 	exit 1
 }
--=20
1.7.4.1
