From: Andreas Zeidler <az@zitc.de>
Subject: bash completion of "addable" files for `git add`
Date: Fri, 9 Nov 2012 14:22:27 +0100
Message-ID: <5E69B894-C392-4DD5-A4F1-723DA1A3D059@zitc.de>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 14:30:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWofO-0005YC-Ny
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 14:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367Ab2KINaZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Nov 2012 08:30:25 -0500
Received: from mail.zitc.de ([188.40.64.176]:56361 "EHLO mail.zitc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751880Ab2KINaX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Nov 2012 08:30:23 -0500
X-Greylist: delayed 474 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Nov 2012 08:30:23 EST
Received: from mail.zitc.de ([188.40.64.176] helo=[10.0.0.23])
	by mail.zitc.de with asmtp (Exim 3.36 #1)
	id 1TWoXU-0008Mp-00; Fri, 09 Nov 2012 14:22:28 +0100
X-Mailer: Apple Mail (2.1499)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209216>

hi,

i've always been annoyed by having to type =97 or copy & paste =97 path=
s when i wanted to simply add some files to the index.  i know about th=
e `add -i` interface, and that improves things a little, but having bas=
h completion for so many other things it still seemed to much hassle.

so here's a patch adding bash completion on `git add` for modified, upd=
ated and untracked files.  i've also set up a pull request =97 before i=
 found `Documentation/SubmittingPatches`.  fwiw, it's at https://github=
=2Ecom/git/git/pull/29

best regards,


andi


=46rom cbac6caee7e788569562cb7138eb698cc46a1b8f Mon Sep 17 00:00:00 200=
1
=46rom: Andreas Zeidler <az@zitc.de>
Date: Fri, 9 Nov 2012 13:05:43 +0100
Subject: [PATCH] add bash completion for "addable" files

this adds support for completing only modified, updated and untracked
files on `git add`, since almost always these are what you want to add
to the index.

the list of possible completions is determined using `git status` and
filtered using `egrep` and `sed`.

Signed-off-by: Andreas Zeidler <az@zitc.de>
---
 contrib/completion/git-completion.bash | 15 +++++++++++++++
 t/t9902-completion.sh                  | 11 +++++++++++
 2 files changed, 26 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index be800e0..4aa0981 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -799,6 +799,16 @@ _git_apply ()
 	COMPREPLY=3D()
 }
=20
+__git_addable ()
+{
+	local dir=3D"$(__gitdir)"
+	if [ -d "$dir" ]; then
+		git --git-dir=3D"$dir" status --short --untracked=3Dall |\
+			egrep '^.[UM?] ' | sed 's/^.. //'
+		return
+	fi
+}
+
 _git_add ()
 {
 	__git_has_doubledash && return
@@ -810,6 +820,11 @@ _git_add ()
 			--ignore-errors --intent-to-add
 			"
 		return
+		;;
+	*)
+		__gitcomp "$(__git_addable)"
+		return
+		;;
 	esac
 	COMPREPLY=3D()
 }
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index cbd0fb6..a7c81d3 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -288,4 +288,15 @@ test_expect_failure 'complete tree filename with m=
etacharacters' '
 	EOF
 '
=20
+test_expect_success 'add completes untracked and modified names' '
+	echo other content >file1 &&
+	echo content >file2 &&
+	echo more >file3 &&
+	git add file1 &&
+	test_completion_long "git add f" <<-\EOF
+	file2_
+	file3_
+	EOF
+'
+
 test_done
--=20
1.8.0.1.g43af610


--=20
pgp key at http://zitc.de/pgp - http://wwwkeys.de.pgp.net/
upgrade to plone 4! -- http://plone.org/4
