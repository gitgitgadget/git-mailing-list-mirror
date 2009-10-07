From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH] Teach 'rebase -i' the command "reword"
Date: Wed, 07 Oct 2009 08:13:23 +0200
Message-ID: <4ACC3183.4050604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Oct 07 08:15:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvPoV-0004Th-SG
	for gcvg-git-2@lo.gmane.org; Wed, 07 Oct 2009 08:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412AbZJGGOg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Oct 2009 02:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752798AbZJGGOg
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Oct 2009 02:14:36 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:35651 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbZJGGOf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2009 02:14:35 -0400
Received: by ey-out-2122.google.com with SMTP id 4so951818eyf.19
        for <git@vger.kernel.org>; Tue, 06 Oct 2009 23:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=tq8sDwOtHeriHn/a6dZbdrncmdjU7CfnycL0TFvwlcU=;
        b=TcRPweW0+skt83ixfjQGrtU2T6fNsSgcmwVncN+yuqGyvHHU19hxCe+txA0GuLh9VP
         bojkA6aoCxOd116fSv4PMAKjOjM2IPDFL4nMccdk2NivNc3+Ez93MKcLaajYRMddglgP
         20HrhcmcW3mzGusPIS2sJktY0BBrnwaXbl9VI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=Jrbed8cxn/L/BHqv6r0KNmv+B9nAg6gaDn3g741hQbFnjyJwp5xKGssQlU3blvwMtv
         FIHTQQ8G3s1Lu2/e4ZFhQQOgYbdbXhUzW2eaz/b5LSrPfUyKrPai+55EtSTZ61st7SFf
         0ByvnOxR82eiLNLDI1aFsK3rjSMMN2p86lFFM=
Received: by 10.211.173.11 with SMTP id a11mr2467932ebp.42.1254896006610;
        Tue, 06 Oct 2009 23:13:26 -0700 (PDT)
Received: from bitis.local (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 10sm1171872eyz.34.2009.10.06.23.13.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Oct 2009 23:13:25 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129638>

Make it easier to edit just the commit message for a commit
using 'git rebase -i' by introducing the "reword" command.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
Re-roll of my patch with improvements to the documentation
and help text suggested by Johannes Sixt and Stephen Boyd.

 Documentation/git-rebase.txt  |    9 ++++++---
 git-rebase--interactive.sh    |    9 +++++++++
 t/lib-rebase.sh               |    6 +++---
 t/t3404-rebase-interactive.sh |   14 ++++++++++++++
 4 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index 0aefc34..33e0ef1 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -368,14 +368,17 @@ By replacing the command "pick" with the command =
"edit", you can tell
 the files and/or the commit message, amend the commit, and continue
 rebasing.
=20
+If you just want to edit the commit message for a commit, replace the
+command "pick" with the command "reword".
+
 If you want to fold two or more commits into one, replace the command
 "pick" with "squash" for the second and subsequent commit.  If the
 commits had different authors, it will attribute the squashed commit t=
o
 the author of the first commit.
=20
-In both cases, or when a "pick" does not succeed (because of merge
-errors), the loop will stop to let you fix things, and you can continu=
e
-the loop with `git rebase --continue`.
+'git-rebase' will stop when "pick" has been replaced with "edit" or
+when a command fails due to merge errors. When you are done editing
+and/or resolving conflicts you can continue with `git rebase --continu=
e`.
=20
 For example, if you want to reorder the last 5 commits, such that what
 was HEAD~4 becomes the new HEAD. To achieve that, you would call
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 23ded48..a43ee22 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -340,6 +340,14 @@ do_next () {
 		pick_one $sha1 ||
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
 		;;
+	reword|r)
+		comment_for_reflog reword
+
+		mark_action_done
+		pick_one $sha1 ||
+			die_with_patch $sha1 "Could not apply $sha1... $rest"
+		output git commit --amend
+		;;
 	edit|e)
 		comment_for_reflog edit
=20
@@ -752,6 +760,7 @@ first and then run 'git rebase --continue' again."
 #
 # Commands:
 #  p, pick =3D use commit
+#  r, reword =3D use commit, but edit the commit message
 #  e, edit =3D use commit, but stop for amending
 #  s, squash =3D use commit, but meld into previous commit
 #
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 260a231..62f452c 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -9,8 +9,8 @@
 #
 #	"[<lineno1>] [<lineno2>]..."
 #
-#   If a line number is prefixed with "squash" or "edit", the respecti=
ve line's
-#   command will be replaced with the specified one.
+#   If a line number is prefixed with "squash", "edit", or "reword", t=
he
+#   respective line's command will be replaced with the specified one.
=20
 set_fake_editor () {
 	echo "#!$SHELL_PATH" >fake-editor.sh
@@ -32,7 +32,7 @@ cat "$1".tmp
 action=3Dpick
 for line in $FAKE_LINES; do
 	case $line in
-	squash|edit)
+	squash|edit|reword)
 		action=3D"$line";;
 	*)
 		echo sed -n "${line}s/^pick/$action/p"
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index 4cae019..3a37793 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -470,4 +470,18 @@ test_expect_success 'avoid unnecessary reset' '
 	test 123456789 =3D $MTIME
 '
=20
+test_expect_success 'reword' '
+	git checkout -b reword-branch master &&
+	FAKE_LINES=3D"1 2 3 reword 4" FAKE_COMMIT_MESSAGE=3D"E changed" git r=
ebase -i A &&
+	git show HEAD | grep "E changed" &&
+	test $(git rev-parse master) !=3D $(git rev-parse HEAD) &&
+	test $(git rev-parse master^) =3D $(git rev-parse HEAD^) &&
+	FAKE_LINES=3D"1 2 reword 3 4" FAKE_COMMIT_MESSAGE=3D"D changed" git r=
ebase -i A &&
+	git show HEAD^ | grep "D changed" &&
+	FAKE_LINES=3D"reword 1 2 3 4" FAKE_COMMIT_MESSAGE=3D"B changed" git r=
ebase -i A &&
+	git show HEAD~3 | grep "B changed" &&
+	FAKE_LINES=3D"1 reword 2 3 4" FAKE_COMMIT_MESSAGE=3D"C changed" git r=
ebase -i A &&
+	git show HEAD~2 | grep "C changed"
+'
+
 test_done
--=20
1.6.4.4
