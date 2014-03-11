From: Sandy Carter <sandy.carter@savoirfairelinux.com>
Subject: [PATCH v2] status merge: guarentee space between msg and path
Date: Tue, 11 Mar 2014 19:23:31 -0400
Message-ID: <1394580211-13383-1-git-send-email-sandy.carter@savoirfairelinux.com>
References: <1394555447-1805-1-git-send-email-sandy.carter@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, pclouds@gmail.com,
	Sandy Carter <sandy.carter@savoirfairelinux.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 00:22:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNW0J-0003VS-6y
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 00:22:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755922AbaCKXWX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Mar 2014 19:22:23 -0400
Received: from mail.savoirfairelinux.com ([209.172.62.77]:51040 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755900AbaCKXWA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 19:22:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8395610D7531;
	Tue, 11 Mar 2014 19:21:59 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jre5DGLXtn0w; Tue, 11 Mar 2014 19:21:56 -0400 (EDT)
Received: from scarter-X220.mtl.sfl (mtl.savoirfairelinux.net [208.88.110.46])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C043110D7530;
	Tue, 11 Mar 2014 19:21:56 -0400 (EDT)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394555447-1805-1-git-send-email-sandy.carter@savoirfairelinux.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243911>

Add space between how and one when printing status of unmerged data.
This fixes an appending of the how message when it is longer than 20,
such  is the case in some translations such as the french one where the
colon gets appended to the file:
    supprim=C3=A9 par nous :wt-status.c
    modifi=C3=A9 des deux c=C3=B4t=C3=A9s :wt-status.h
Additionally, having a space makes the file in question easier to selec=
t
in console to quickly address the problem. Without the space, the colon
(and, sometimes the last word) of the message is selected along with th=
e
file.

The previous french example should now print as, which is more proper:
    supprim=C3=A9 par nous :      wt-status.c
    modifi=C3=A9 des deux c=C3=B4t=C3=A9s : wt-status.h

try 2:
Add function so wt_status_print_unmerged_data() and
wt_status_print_change_data() make use of the same padding technique
defined as wt_status_status_padding_string()

This has the additionnal advantage of aligning unmerged paths with path=
s
of regular statuses.

Signed-off-by: Sandy Carter <sandy.carter@savoirfairelinux.com>
---
 t/t7060-wtstatus.sh         |  16 +++----
 t/t7506-status-submodule.sh |  18 ++++----
 t/t7508-status.sh           |  94 +++++++++++++++++++-----------------=
---
 t/t7512-status-help.sh      |  30 ++++++-------
 wt-status.c                 | 104 +++++++++++++++++++++++++++++-------=
--------
 5 files changed, 149 insertions(+), 113 deletions(-)

diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index 7d467c0..f49f3b3 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -38,7 +38,7 @@ You have unmerged paths.
 Unmerged paths:
   (use "git add/rm <file>..." as appropriate to mark resolution)
=20
-	deleted by us:      foo
+	deleted by us:   foo
=20
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
@@ -142,8 +142,8 @@ You have unmerged paths.
 Unmerged paths:
   (use "git add/rm <file>..." as appropriate to mark resolution)
=20
-	both added:         conflict.txt
-	deleted by them:    main.txt
+	both added:      conflict.txt
+	deleted by them: main.txt
=20
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
@@ -175,9 +175,9 @@ You have unmerged paths.
 Unmerged paths:
   (use "git add/rm <file>..." as appropriate to mark resolution)
=20
-	both deleted:       main.txt
-	added by them:      sub_master.txt
-	added by us:        sub_second.txt
+	both deleted:    main.txt
+	added by them:   sub_master.txt
+	added by us:     sub_second.txt
=20
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
@@ -198,12 +198,12 @@ You have unmerged paths.
=20
 Changes to be committed:
=20
-	new file:   sub_master.txt
+	new file:        sub_master.txt
=20
 Unmerged paths:
   (use "git rm <file>..." to mark resolution)
=20
-	both deleted:       main.txt
+	both deleted:    main.txt
=20
 Untracked files not listed (use -u option to show untracked files)
 EOF
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index d31b34d..745d88b 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -38,7 +38,7 @@ test_expect_success 'status with modified file in sub=
module' '
 	(cd sub && git reset --hard) &&
 	echo "changed" >sub/foo &&
 	git status >output &&
-	test_i18ngrep "modified:   sub (modified content)" output
+	test_i18ngrep "modified:        sub (modified content)" output
 '
=20
 test_expect_success 'status with modified file in submodule (porcelain=
)' '
@@ -53,7 +53,7 @@ test_expect_success 'status with modified file in sub=
module (porcelain)' '
 test_expect_success 'status with added file in submodule' '
 	(cd sub && git reset --hard && echo >foo && git add foo) &&
 	git status >output &&
-	test_i18ngrep "modified:   sub (modified content)" output
+	test_i18ngrep "modified:        sub (modified content)" output
 '
=20
 test_expect_success 'status with added file in submodule (porcelain)' =
'
@@ -68,7 +68,7 @@ test_expect_success 'status with untracked file in su=
bmodule' '
 	(cd sub && git reset --hard) &&
 	echo "content" >sub/new-file &&
 	git status >output &&
-	test_i18ngrep "modified:   sub (untracked content)" output
+	test_i18ngrep "modified:        sub (untracked content)" output
 '
=20
 test_expect_success 'status -uno with untracked file in submodule' '
@@ -87,7 +87,7 @@ test_expect_success 'status with added and untracked =
file in submodule' '
 	(cd sub && git reset --hard && echo >foo && git add foo) &&
 	echo "content" >sub/new-file &&
 	git status >output &&
-	test_i18ngrep "modified:   sub (modified content, untracked content)"=
 output
+	test_i18ngrep "modified:        sub (modified content, untracked cont=
ent)" output
 '
=20
 test_expect_success 'status with added and untracked file in submodule=
 (porcelain)' '
@@ -105,7 +105,7 @@ test_expect_success 'status with modified file in m=
odified submodule' '
 	(cd sub && echo "next change" >foo && git commit -m "next change" foo=
) &&
 	echo "changed" >sub/foo &&
 	git status >output &&
-	test_i18ngrep "modified:   sub (new commits, modified content)" outpu=
t
+	test_i18ngrep "modified:        sub (new commits, modified content)" =
output
 '
=20
 test_expect_success 'status with modified file in modified submodule (=
porcelain)' '
@@ -120,7 +120,7 @@ test_expect_success 'status with modified file in m=
odified submodule (porcelain)
 test_expect_success 'status with added file in modified submodule' '
 	(cd sub && git reset --hard && echo >foo && git add foo) &&
 	git status >output &&
-	test_i18ngrep "modified:   sub (new commits, modified content)" outpu=
t
+	test_i18ngrep "modified:        sub (new commits, modified content)" =
output
 '
=20
 test_expect_success 'status with added file in modified submodule (por=
celain)' '
@@ -135,7 +135,7 @@ test_expect_success 'status with untracked file in =
modified submodule' '
 	(cd sub && git reset --hard) &&
 	echo "content" >sub/new-file &&
 	git status >output &&
-	test_i18ngrep "modified:   sub (new commits, untracked content)" outp=
ut
+	test_i18ngrep "modified:        sub (new commits, untracked content)"=
 output
 '
=20
 test_expect_success 'status with untracked file in modified submodule =
(porcelain)' '
@@ -149,7 +149,7 @@ test_expect_success 'status with added and untracke=
d file in modified submodule'
 	(cd sub && git reset --hard && echo >foo && git add foo) &&
 	echo "content" >sub/new-file &&
 	git status >output &&
-	test_i18ngrep "modified:   sub (new commits, modified content, untrac=
ked content)" output
+	test_i18ngrep "modified:        sub (new commits, modified content, u=
ntracked content)" output
 '
=20
 test_expect_success 'status with added and untracked file in modified =
submodule (porcelain)' '
@@ -174,7 +174,7 @@ test_expect_success 'setup .git file for sub' '
 test_expect_success 'status with added file in modified submodule with=
 .git file' '
 	(cd sub && git reset --hard && echo >foo && git add foo) &&
 	git status >output &&
-	test_i18ngrep "modified:   sub (new commits, modified content)" outpu=
t
+	test_i18ngrep "modified:        sub (new commits, modified content)" =
output
 '
=20
 test_expect_success 'rm submodule contents' '
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index c987b5e..460c653 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -72,13 +72,13 @@ test_expect_success 'status --column' '
 # Changes to be committed:
 #   (use "git reset HEAD <file>..." to unstage)
 #
-#	new file:   dir2/added
+#	new file:        dir2/added
 #
 # Changes not staged for commit:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working dir=
ectory)
 #
-#	modified:   dir1/modified
+#	modified:        dir1/modified
 #
 # Untracked files:
 #   (use "git add <file>..." to include in what will be committed)
@@ -102,13 +102,13 @@ cat >expect <<\EOF
 # Changes to be committed:
 #   (use "git reset HEAD <file>..." to unstage)
 #
-#	new file:   dir2/added
+#	new file:        dir2/added
 #
 # Changes not staged for commit:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working dir=
ectory)
 #
-#	modified:   dir1/modified
+#	modified:        dir1/modified
 #
 # Untracked files:
 #   (use "git add <file>..." to include in what will be committed)
@@ -158,10 +158,10 @@ test_expect_success 'commit ignores status.displa=
yCommentPrefix=3Dfalse in COMMIT_
 cat >expect <<\EOF
 On branch master
 Changes to be committed:
-	new file:   dir2/added
+	new file:        dir2/added
=20
 Changes not staged for commit:
-	modified:   dir1/modified
+	modified:        dir1/modified
=20
 Untracked files:
 	dir1/untracked
@@ -233,13 +233,13 @@ On branch master
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
=20
-	new file:   dir2/added
+	new file:        dir2/added
=20
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working direc=
tory)
=20
-	modified:   dir1/modified
+	modified:        dir1/modified
=20
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
@@ -296,13 +296,13 @@ On branch master
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
=20
-	new file:   dir2/added
+	new file:        dir2/added
=20
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working direc=
tory)
=20
-	modified:   dir1/modified
+	modified:        dir1/modified
=20
 Ignored files:
   (use "git add -f <file>..." to include in what will be committed)
@@ -362,13 +362,13 @@ On branch master
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
=20
-	new file:   dir2/added
+	new file:        dir2/added
=20
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working direc=
tory)
=20
-	modified:   dir1/modified
+	modified:        dir1/modified
=20
 Untracked files not listed (use -u option to show untracked files)
 EOF
@@ -386,10 +386,10 @@ test_expect_success 'status -uno (advice.statusHi=
nts false)' '
 	cat >expect <<EOF &&
 On branch master
 Changes to be committed:
-	new file:   dir2/added
+	new file:        dir2/added
=20
 Changes not staged for commit:
-	modified:   dir1/modified
+	modified:        dir1/modified
=20
 Untracked files not listed
 EOF
@@ -419,13 +419,13 @@ On branch master
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
=20
-	new file:   dir2/added
+	new file:        dir2/added
=20
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working direc=
tory)
=20
-	modified:   dir1/modified
+	modified:        dir1/modified
=20
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
@@ -477,13 +477,13 @@ On branch master
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
=20
-	new file:   dir2/added
+	new file:        dir2/added
=20
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working direc=
tory)
=20
-	modified:   dir1/modified
+	modified:        dir1/modified
=20
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
@@ -540,13 +540,13 @@ On branch master
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
=20
-	new file:   ../dir2/added
+	new file:        ../dir2/added
=20
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working direc=
tory)
=20
-	modified:   modified
+	modified:        modified
=20
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
@@ -611,13 +611,13 @@ On branch <GREEN>master<RESET>
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
=20
-	<GREEN>new file:   dir2/added<RESET>
+	<GREEN>new file:        dir2/added<RESET>
=20
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working direc=
tory)
=20
-	<RED>modified:   dir1/modified<RESET>
+	<RED>modified:        dir1/modified<RESET>
=20
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
@@ -741,13 +741,13 @@ On branch master
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
=20
-	new file:   dir2/added
+	new file:        dir2/added
=20
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working direc=
tory)
=20
-	modified:   dir1/modified
+	modified:        dir1/modified
=20
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
@@ -791,7 +791,7 @@ On branch master
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
=20
-	modified:   dir1/modified
+	modified:        dir1/modified
=20
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
@@ -833,14 +833,14 @@ On branch master
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
=20
-	new file:   dir2/added
-	new file:   sm
+	new file:        dir2/added
+	new file:        sm
=20
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working direc=
tory)
=20
-	modified:   dir1/modified
+	modified:        dir1/modified
=20
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
@@ -893,14 +893,14 @@ On branch master
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
=20
-	new file:   dir2/added
-	new file:   sm
+	new file:        dir2/added
+	new file:        sm
=20
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working direc=
tory)
=20
-	modified:   dir1/modified
+	modified:        dir1/modified
=20
 Submodule changes to be committed:
=20
@@ -956,7 +956,7 @@ Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working direc=
tory)
=20
-	modified:   dir1/modified
+	modified:        dir1/modified
=20
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
@@ -1005,14 +1005,14 @@ On branch master
 Changes to be committed:
   (use "git reset HEAD^1 <file>..." to unstage)
=20
-	new file:   dir2/added
-	new file:   sm
+	new file:        dir2/added
+	new file:        sm
=20
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working direc=
tory)
=20
-	modified:   dir1/modified
+	modified:        dir1/modified
=20
 Submodule changes to be committed:
=20
@@ -1060,13 +1060,13 @@ On branch master
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
=20
-	modified:   sm
+	modified:        sm
=20
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working direc=
tory)
=20
-	modified:   dir1/modified
+	modified:        dir1/modified
=20
 Submodule changes to be committed:
=20
@@ -1170,15 +1170,15 @@ On branch master
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
=20
-	modified:   sm
+	modified:        sm
=20
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working direc=
tory)
   (commit or discard the untracked or modified content in submodules)
=20
-	modified:   dir1/modified
-	modified:   sm (modified content)
+	modified:        dir1/modified
+	modified:        sm (modified content)
=20
 Submodule changes to be committed:
=20
@@ -1228,14 +1228,14 @@ On branch master
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
=20
-	modified:   sm
+	modified:        sm
=20
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working direc=
tory)
=20
-	modified:   dir1/modified
-	modified:   sm (new commits)
+	modified:        dir1/modified
+	modified:        sm (new commits)
=20
 Submodule changes to be committed:
=20
@@ -1310,14 +1310,14 @@ cat > expect << EOF
 ; Changes to be committed:
 ;   (use "git reset HEAD <file>..." to unstage)
 ;
-;	modified:   sm
+;	modified:        sm
 ;
 ; Changes not staged for commit:
 ;   (use "git add <file>..." to update what will be committed)
 ;   (use "git checkout -- <file>..." to discard changes in working dir=
ectory)
 ;
-;	modified:   dir1/modified
-;	modified:   sm (new commits)
+;	modified:        dir1/modified
+;	modified:        sm (new commits)
 ;
 ; Submodule changes to be committed:
 ;
@@ -1361,7 +1361,7 @@ Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working direc=
tory)
=20
-	modified:   dir1/modified
+	modified:        dir1/modified
=20
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 3cec57a..8fa69b0 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -33,7 +33,7 @@ You have unmerged paths.
 Unmerged paths:
   (use "git add <file>..." to mark resolution)
=20
-	both modified:      main.txt
+	both modified:   main.txt
=20
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
@@ -54,7 +54,7 @@ All conflicts fixed but you are still merging.
=20
 Changes to be committed:
=20
-	modified:   main.txt
+	modified:        main.txt
=20
 Untracked files not listed (use -u option to show untracked files)
 EOF
@@ -87,7 +87,7 @@ Unmerged paths:
   (use "git reset HEAD <file>..." to unstage)
   (use "git add <file>..." to mark resolution)
=20
-	both modified:      main.txt
+	both modified:   main.txt
=20
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
@@ -111,7 +111,7 @@ You are currently rebasing branch '\''rebase_confli=
cts'\'' on '\''$ONTO'\''.
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
=20
-	modified:   main.txt
+	modified:        main.txt
=20
 Untracked files not listed (use -u option to show untracked files)
 EOF
@@ -146,7 +146,7 @@ Unmerged paths:
   (use "git reset HEAD <file>..." to unstage)
   (use "git add <file>..." to mark resolution)
=20
-	both modified:      main.txt
+	both modified:   main.txt
=20
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
@@ -169,7 +169,7 @@ You are currently rebasing branch '\''rebase_i_conf=
licts_second'\'' on '\''$ONTO
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
=20
-	modified:   main.txt
+	modified:        main.txt
=20
 Untracked files not listed (use -u option to show untracked files)
 EOF
@@ -224,7 +224,7 @@ Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working direc=
tory)
=20
-	modified:   main.txt
+	modified:        main.txt
=20
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
@@ -307,7 +307,7 @@ Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working direc=
tory)
=20
-	modified:   main.txt
+	modified:        main.txt
=20
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
@@ -379,7 +379,7 @@ Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working direc=
tory)
=20
-	modified:   main.txt
+	modified:        main.txt
=20
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
@@ -456,7 +456,7 @@ Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working direc=
tory)
=20
-	modified:   main.txt
+	modified:        main.txt
=20
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
@@ -602,7 +602,7 @@ rebase in progress; onto $ONTO
 You are currently rebasing branch '\''statushints_disabled'\'' on '\''=
$ONTO'\''.
=20
 Unmerged paths:
-	both modified:      main.txt
+	both modified:   main.txt
=20
 no changes added to commit
 EOF
@@ -636,7 +636,7 @@ You are currently cherry-picking commit $TO_CHERRY_=
PICK.
 Unmerged paths:
   (use "git add <file>..." to mark resolution)
=20
-	both modified:      main.txt
+	both modified:   main.txt
=20
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
@@ -660,7 +660,7 @@ You are currently cherry-picking commit $TO_CHERRY_=
PICK.
=20
 Changes to be committed:
=20
-	modified:   main.txt
+	modified:        main.txt
=20
 Untracked files not listed (use -u option to show untracked files)
 EOF
@@ -707,7 +707,7 @@ Unmerged paths:
   (use "git reset HEAD <file>..." to unstage)
   (use "git add <file>..." to mark resolution)
=20
-	both modified:      to-revert.txt
+	both modified:   to-revert.txt
=20
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
@@ -727,7 +727,7 @@ You are currently reverting commit $TO_REVERT.
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
=20
-	modified:   to-revert.txt
+	modified:        to-revert.txt
=20
 Untracked files not listed (use -u option to show untracked files)
 EOF
diff --git a/wt-status.c b/wt-status.c
index a452407..5990c99 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -245,27 +245,26 @@ static void wt_status_print_trailer(struct wt_sta=
tus *s)
=20
 #define quote_path quote_path_relative
=20
-static void wt_status_print_unmerged_data(struct wt_status *s,
-					  struct string_list_item *it)
+static const char *wt_status_unmerged_status_string(int status)
 {
-	const char *c =3D color(WT_STATUS_UNMERGED, s);
-	struct wt_status_change_data *d =3D it->util;
-	struct strbuf onebuf =3D STRBUF_INIT;
-	const char *one, *how =3D _("bug");
-
-	one =3D quote_path(it->string, s->prefix, &onebuf);
-	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
-	switch (d->stagemask) {
-	case 1: how =3D _("both deleted:"); break;
-	case 2: how =3D _("added by us:"); break;
-	case 3: how =3D _("deleted by them:"); break;
-	case 4: how =3D _("added by them:"); break;
-	case 5: how =3D _("deleted by us:"); break;
-	case 6: how =3D _("both added:"); break;
-	case 7: how =3D _("both modified:"); break;
+	switch (status) {
+	case 1:
+		return _("both deleted");
+	case 2:
+		return _("added by us");
+	case 3:
+		return _("deleted by them");
+	case 4:
+		return _("added by them");
+	case 5:
+		return _("deleted by us");
+	case 6:
+		return _("both added");
+	case 7:
+		return _("both modified");
+	default:
+		return NULL;
 	}
-	status_printf_more(s, c, "%-20s%s\n", how, one);
-	strbuf_release(&onebuf);
 }
=20
 static const char *wt_status_diff_status_string(int status)
@@ -292,28 +291,25 @@ static const char *wt_status_diff_status_string(i=
nt status)
 	}
 }
=20
-static void wt_status_print_change_data(struct wt_status *s,
-					int change_type,
-					struct string_list_item *it)
+static const char *wt_status_status_padding_string()
 {
-	struct wt_status_change_data *d =3D it->util;
-	const char *c =3D color(change_type, s);
-	int status;
-	char *one_name;
-	char *two_name;
-	const char *one, *two;
-	struct strbuf onebuf =3D STRBUF_INIT, twobuf =3D STRBUF_INIT;
-	struct strbuf extra =3D STRBUF_INIT;
 	static char *padding;
-	const char *what;
+	const char *message;
+	int status;
 	int len;
=20
 	if (!padding) {
 		int width =3D 0;
-		/* If DIFF_STATUS_* uses outside this range, we're in trouble */
+		/* Obtain width of widest status message */
+		for (status =3D 1; status <=3D 7; status++) {
+			message =3D wt_status_unmerged_status_string(status);
+			len =3D message ? strlen(message) : 0;
+			if (len > width)
+				width =3D len;
+		}
 		for (status =3D 'A'; status <=3D 'Z'; status++) {
-			what =3D wt_status_diff_status_string(status);
-			len =3D what ? strlen(what) : 0;
+			message =3D wt_status_diff_status_string(status);
+			len =3D message ? strlen(message) : 0;
 			if (len > width)
 				width =3D len;
 		}
@@ -322,6 +318,46 @@ static void wt_status_print_change_data(struct wt_=
status *s,
 		memset(padding, ' ', width);
 	}
=20
+	return padding;
+}
+
+static void wt_status_print_unmerged_data(struct wt_status *s,
+					  struct string_list_item *it)
+{
+	const char *c =3D color(WT_STATUS_UNMERGED, s);
+	struct wt_status_change_data *d =3D it->util;
+	struct strbuf onebuf =3D STRBUF_INIT;
+	const char *one, *how =3D _("bug");
+	const char *padding =3D wt_status_status_padding_string();
+	int len;
+
+	padding =3D wt_status_status_padding_string();
+	one =3D quote_path(it->string, s->prefix, &onebuf);
+	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
+	how =3D wt_status_unmerged_status_string(d->stagemask);
+	/* 1 for colon, which is not part of "what" */
+	len =3D strlen(padding) - (utf8_strwidth(how) + 1);
+	status_printf_more(s, c, "%s:%.*s%s\n",
+			   how, len, padding, one);
+	strbuf_release(&onebuf);
+}
+
+static void wt_status_print_change_data(struct wt_status *s,
+					int change_type,
+					struct string_list_item *it)
+{
+	struct wt_status_change_data *d =3D it->util;
+	const char *c =3D color(change_type, s);
+	int status;
+	char *one_name;
+	char *two_name;
+	const char *one, *two;
+	struct strbuf onebuf =3D STRBUF_INIT, twobuf =3D STRBUF_INIT;
+	struct strbuf extra =3D STRBUF_INIT;
+	const char *padding =3D wt_status_status_padding_string();
+	const char *what;
+	int len;
+
 	one_name =3D two_name =3D it->string;
 	switch (change_type) {
 	case WT_STATUS_UPDATED:
--=20
1.9.0
