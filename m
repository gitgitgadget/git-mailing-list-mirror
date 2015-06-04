From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH v5 3/3] git-am: add am.threeWay config variable
Date: Fri,  5 Jun 2015 01:24:44 +0200
Message-ID: <1433460284-20240-3-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
References: <1433460284-20240-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 01:25:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0eVY-00006S-Jd
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 01:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbbFDXZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 19:25:04 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:33289 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932147AbbFDXY7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jun 2015 19:24:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 12DC348872;
	Fri,  5 Jun 2015 01:24:58 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JArBQvISv6BB; Fri,  5 Jun 2015 01:24:57 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id ED36748864;
	Fri,  5 Jun 2015 01:24:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id E7FF520DC;
	Fri,  5 Jun 2015 01:24:57 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DvE6P53yU+J7; Fri,  5 Jun 2015 01:24:57 +0200 (CEST)
Received: from Groseille.home (AGrenoble-652-1-407-223.w90-42.abo.wanadoo.fr [90.42.42.223])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id 0F16520D4;
	Fri,  5 Jun 2015 01:24:56 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1433460284-20240-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270805>

Add the am.threeWay configuration variable to use the -3 or --3way
option of git am by default. When am.threeway is set and not desired
for a specific git am command, the --no-3way option can be used to
override it.

Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
---
 Only one change compared to previous version:
 
 "git-config(1)" replaced by "linkgit:git-config[1]"

 Documentation/config.txt |  8 ++++++++
 Documentation/git-am.txt |  7 +++++--
 git-am.sh                |  9 +++++++++
 t/t4150-am.sh            | 19 +++++++++++++++++++
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d44bc85..36b75d9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -769,6 +769,14 @@ am.keepcr::
 	by giving '--no-keep-cr' from the command line.
 	See linkgit:git-am[1], linkgit:git-mailsplit[1].
 
+am.threeWay::
+	By default, `git am` will fail if the patch does not apply cleanly. When
+	set to true, this setting tells `git am` to fall back on 3-way merge if
+	the patch records the identity of blobs it is supposed to apply to and
+	we have those blobs available locally (equivalent to giving the `--3way`
+	option from the command line). Defaults to `false`.
+	See linkgit:git-am[1].
+
 apply.ignoreWhitespace::
 	When set to 'change', tells 'git apply' to ignore changes in
 	whitespace, in the same way as the '--ignore-space-change'
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 0d8ba48..dbea6e7 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git am' [--signoff] [--keep] [--[no-]keep-cr] [--[no-]utf8]
-	 [--3way] [--interactive] [--committer-date-is-author-date]
+	 [--[no-]3way] [--interactive] [--committer-date-is-author-date]
 	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
 	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
 	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
@@ -90,10 +90,13 @@ default.   You can use `--no-utf8` to override this.
 
 -3::
 --3way::
+--no-3way::
 	When the patch does not apply cleanly, fall back on
 	3-way merge if the patch records the identity of blobs
 	it is supposed to apply to and we have those blobs
-	available locally.
+	available locally. `--no-3way` can be used to override
+	am.threeWay configuration variable. For more information,
+	see am.threeWay in linkgit:git-config[1].
 
 --ignore-space-change::
 --ignore-whitespace::
diff --git a/git-am.sh b/git-am.sh
index c460dd0..75e701a 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -390,6 +390,11 @@ then
     keepcr=t
 fi
 
+if test "$(git config --bool --get am.threeWay)" = true
+then
+    threeway=t
+fi
+
 while test $# != 0
 do
 	case "$1" in
@@ -401,6 +406,8 @@ it will be removed. Please do not use it anymore."
 		;;
 	-3|--3way)
 		threeway=t ;;
+	--no-3way)
+		threeway=f ;;
 	-s|--signoff)
 		sign=t ;;
 	-u|--utf8)
@@ -658,6 +665,8 @@ fi
 if test "$(cat "$dotest/threeway")" = t
 then
 	threeway=t
+else
+	threeway=f
 fi
 git_apply_opt=$(cat "$dotest/apply-opt")
 if test "$(cat "$dotest/sign")" = t
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 6ced98c..b822a39 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -303,6 +303,25 @@ test_expect_success 'am -3 -p0 can read --no-prefix patch' '
 	git diff --exit-code lorem
 '
 
+test_expect_success 'am with config am.threeWay falls back to 3-way merge' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout -b lorem4 base3way &&
+	test_config am.threeWay 1 &&
+	git am lorem-move.patch &&
+	test_path_is_missing .git/rebase-apply &&
+	git diff --exit-code lorem
+'
+
+test_expect_success 'am with config am.threeWay overridden by --no-3way' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout -b lorem5 base3way &&
+	test_config am.threeWay 1 &&
+	test_must_fail git am --no-3way lorem-move.patch &&
+	test_path_is_dir .git/rebase-apply
+'
+
 test_expect_success 'am can rename a file' '
 	grep "^rename from" rename.patch &&
 	rm -fr .git/rebase-apply &&
-- 
1.9.1
