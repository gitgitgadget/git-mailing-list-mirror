From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFC v3 4/4] git-am: add am.threeWay config variable
Date: Tue,  2 Jun 2015 19:34:06 +0200
Message-ID: <1433266446-2845-4-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
References: <1433266446-2845-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 19:34:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzq5B-0006eG-95
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 19:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759900AbbFBRea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 13:34:30 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:53365 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754320AbbFBReX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2015 13:34:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 83D9127BC;
	Tue,  2 Jun 2015 19:34:21 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IcRfwtkhC3Yz; Tue,  2 Jun 2015 19:34:21 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 72C0327A4;
	Tue,  2 Jun 2015 19:34:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 6C85320E4;
	Tue,  2 Jun 2015 19:34:21 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DXVDIzCNqjDg; Tue,  2 Jun 2015 19:34:21 +0200 (CEST)
Received: from Groseille.grenet.fr (wificampus-030200.grenet.fr [130.190.30.200])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 7F4CB20DD;
	Tue,  2 Jun 2015 19:34:20 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1433266446-2845-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270571>

Add the am.threeWay configuration variable to use the -3 or --3way
option of git am by default. When am.threeway is set and not desired
for a specific git am command, the --no-3way option can be used to
override it.

Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
---
 Even if git am will be rewritten soon, the code that will have to be
 ported is not the most important part of the patch and the tests and
 documentation parts can be reused.

 Documentation/config.txt |  8 ++++++++
 Documentation/git-am.txt | 11 ++++++++++-
 git-am.sh                |  9 +++++++++
 t/t4150-am.sh            | 19 +++++++++++++++++++
 4 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d44bc85..669f5fc 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -769,6 +769,14 @@ am.keepcr::
 	by giving '--no-keep-cr' from the command line.
 	See linkgit:git-am[1], linkgit:git-mailsplit[1].
 
+am.threeWay::
+	By default, git-am will fail if the patch does not apply cleanly. When
+	set to true, this setting tells git-am to fall back on 3-way merge if
+	the patch records the identity of blobs it is supposed to apply to and
+	we have those blobs available locally (equivalent to giving the --3way
+	option from the command line).
+	See linkgit:git-am[1].
+
 apply.ignoreWhitespace::
 	When set to 'change', tells 'git apply' to ignore changes in
 	whitespace, in the same way as the '--ignore-space-change'
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index d412f6b..0472182 100644
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
@@ -34,6 +34,14 @@ am.keepcr::
 	by giving '--no-keep-cr' from the command line.
 	See linkgit:git-am[1], linkgit:git-mailsplit[1].
 
+am.threeWay::
+	By default, git-am will fail if the patch does not apply cleanly. When
+	set to true, this setting tells git-am to fall back on 3-way merge if
+	the patch records the identity of blobs it is supposed to apply to and
+	we have those blobs available locally (equivalent to giving the --3way
+	option from the command line).
+	See linkgit:git-am[1].
+
 OPTIONS
 -------
 (<mbox>|<Maildir>)...::
@@ -100,6 +108,7 @@ default.   You can use `--no-utf8` to override this.
 
 -3::
 --3way::
+--no-3way::
 	When the patch does not apply cleanly, fall back on
 	3-way merge if the patch records the identity of blobs
 	it is supposed to apply to and we have those blobs
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
