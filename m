From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 8/8] gettextize: git-pull "rebase against" / "merge with" messages
Date: Mon, 13 Sep 2010 19:35:58 +0000
Message-ID: <1284406558-23684-9-git-send-email-avarab@gmail.com>
References: <1284406558-23684-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 13 21:36:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvEpR-0005HT-9L
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 21:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755223Ab0IMTg2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 15:36:28 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49809 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755216Ab0IMTgY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 15:36:24 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so6574868wyf.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 12:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=4tvUW24A+WeXfBMWJHxG7oF3m+khW6eQge4H8KbpQtU=;
        b=sSeUsGPAHUh4jAk0jp55eZ3Ig4Qx3pLAvYjFlgq5I6VfW0BCfnGtynwL9MqGhOJKa0
         3AJhMq3uTnKqejIHLVImrg0uHO2Gj0xF5mOUdDuV5vA0lVotO5qG6Z8idm90RjFbPVGH
         LSqewW5PriVhD1FnqevueCy3P9CTDPtfaFDOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=paLE7FI9p50SI2V8q+Tyh2e5yGCfYgikFKK0y05UivhefT07D1N2YCvt0P5DNB+Zh1
         b9qU5ge1TfQAAI7gCRNYNheEksc6icOzXlY684yv/LW8CUiz2oM/K2RnSFwAuE5qty7/
         fE542A0TWF9x83fxAX1tqYj8UwMMUj4eQKKSA=
Received: by 10.227.39.222 with SMTP id h30mr1667369wbe.6.1284406584317;
        Mon, 13 Sep 2010 12:36:24 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k7sm4178195wej.2.2010.09.13.12.36.22
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Sep 2010 12:36:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.110.g6776a.dirty
In-Reply-To: <1284406558-23684-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156120>

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
index ec37d1c..2576e06 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -132,15 +132,6 @@ error_on_no_merge_candidates () {
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
@@ -169,30 +160,59 @@ Please specify which remote branch you want to us=
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
1.7.3.rc1.110.g6776a.dirty
