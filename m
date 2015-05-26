From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH 3/3] git-am: add am.threeWay config variable
Date: Tue, 26 May 2015 23:32:55 +0200
Message-ID: <1432675975-11020-3-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
References: <1432675975-11020-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 26 23:40:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxMaa-0000tA-68
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 23:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbbEZVkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 17:40:40 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:57487 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751492AbbEZVki (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 May 2015 17:40:38 -0400
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 May 2015 17:40:37 EDT
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 9B2F948827;
	Tue, 26 May 2015 23:33:49 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8NuIsKw9zLzc; Tue, 26 May 2015 23:33:49 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 8019848813;
	Tue, 26 May 2015 23:33:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 7CB8F20DF;
	Tue, 26 May 2015 23:33:49 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sKoCJlpUxaVo; Tue, 26 May 2015 23:33:49 +0200 (CEST)
Received: from Groseille.home (AGrenoble-652-1-368-161.w82-122.abo.wanadoo.fr [82.122.243.161])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 1271720D1;
	Tue, 26 May 2015 23:33:49 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1432675975-11020-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269981>

Add the am.threeWay configuration variable to use the -3 or --3way
option of git am by default. When am.threeway is set and not desired
for a specific git am command, the --no-3way option can be used to
override it.

Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
---
 Even if git am will be rewritten soon, the code that will have to be
 ported is not the most important part of the patch and the tests and
 documentation parts can be reused.

 Documentation/config.txt |  7 +++++++
 Documentation/git-am.txt |  6 ++++--
 git-am.sh                |  7 +++++++
 t/t4150-am.sh            | 15 +++++++++++++++
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d44bc85..8e42752 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -769,6 +769,13 @@ am.keepcr::
 	by giving '--no-keep-cr' from the command line.
 	See linkgit:git-am[1], linkgit:git-mailsplit[1].
 
+am.threeWay::
+	If true, git-am will fall back on 3-way merge when the patch
+	cannot be applied cleanly, in the same way as the '-3' or
+	'--3-way' option. Can be overridden by giving '--no-3-way'
+	from the command line.
+	See linkgit:git-am[1].
+
 apply.ignoreWhitespace::
 	When set to 'change', tells 'git apply' to ignore changes in
 	whitespace, in the same way as the '--ignore-space-change'
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 0d8ba48..3190c05 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -89,11 +89,13 @@ default.   You can use `--no-utf8` to override this.
 	linkgit:git-mailinfo[1]).
 
 -3::
---3way::
+--[no-]3way::
 	When the patch does not apply cleanly, fall back on
 	3-way merge if the patch records the identity of blobs
 	it is supposed to apply to and we have those blobs
-	available locally.
+	available locally.  `am.threeWay` configuration variable
+	can be used to specify the default behaviour.  `--no-3way`
+	is useful to override `am.threeWay`.
 
 --ignore-space-change::
 --ignore-whitespace::
diff --git a/git-am.sh b/git-am.sh
index 761befb..781507c 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -389,6 +389,11 @@ then
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
@@ -400,6 +405,8 @@ it will be removed. Please do not use it anymore."
 		;;
 	-3|--3way)
 		threeway=t ;;
+	--no-3way)
+		threeway=f ;;
 	-s|--signoff)
 		sign=t ;;
 	-u|--utf8)
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 8f85098..e16ef0e 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -288,6 +288,21 @@ test_expect_success 'am -3 falls back to 3-way merge' '
 	git diff --exit-code lorem
 '
 
+test_expect_success 'am with config am.threeWay falls back to 3-way merge' '
+	setup_temporary_branch lorem2 &&
+	test_config am.threeWay 1 &&
+	git am lorem-move.patch &&
+	test_path_is_missing .git/rebase-apply &&
+	git diff --exit-code lorem
+'
+
+test_expect_success 'am with config am.threeWay overridden by --no-3way' '
+	setup_temporary_branch lorem2 &&
+	test_config am.threeWay 1 &&
+	test_must_fail git am --no-3way lorem-move.patch &&
+	test_path_is_dir .git/rebase-apply
+'
+
 test_expect_success 'am -3 -p0 can read --no-prefix patch' '
 	setup_temporary_branch lorem2 &&
 	git am -3 -p0 lorem-zero.patch &&
-- 
1.9.1
