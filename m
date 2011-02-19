From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 28/72] gettextize: git-commit "enter the commit message" message
Date: Sat, 19 Feb 2011 19:24:11 +0000
Message-ID: <1298143495-3681-29-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:30:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsW1-0004Tk-Jt
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:30:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755873Ab1BSTa0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:30:26 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40522 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755890Ab1BST1s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:27:48 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so2347071eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=UyNNj/PHIgXAlMd1fEgeULOK5EbSwofGWoRpv5t4QiY=;
        b=MMwupVusKOPJJk9DWp9S/Z6SyaebTtCyvJmjtpz7hffsKq2NEndVU1FrovURUxTg55
         fbAVJ/UXmXstaWIelOyvYWhzjxGIOvvQeCcEyp59W/LX6oN0UWmWDme4mjZ4W1DPBty7
         pMgRDjbds2oWqAVo6c0KAmB/DTriMyMOy01NU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ocElfMqijJMp5c31jn/Q+XAyEwcoekrTXZRG2Pma+GFd1YoZCfXvH0VPpMXq7zKlKz
         svBxPBdyYxI6vQonEA62ALxZkCwauj0AaEEvv2xC9m0Siq4HSGLgWCTWunt3qrAI+lxN
         5u6Z9OADn2aTgV42gYnpNAtWowaaTTIu9yTVQ=
Received: by 10.213.17.200 with SMTP id t8mr1003331eba.1.1298143668103;
        Sat, 19 Feb 2011 11:27:48 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.27.47
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:27:47 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167374>

Gettextize the "# Please enter the commit message for your changes."
message. Several tests in t7500-commit.sh and t7502-commit.sh assume
that this message starts with a newline. Change the tests to to skip
under GETTEXT_POISON=3DYesPlease.

These fail under GETTEXT_POISON=3DYesPlease because the poison editor
message doesn't do the right thing with comments and line breaks, so
these messages will be incorrectly broken up across lines.

This test should not be skipped under a hypothetical future testing
mode that tests Git under language locales, since those messages
should all start with a newline like the original.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/commit.c  |   12 ++++++------
 t/t7500-commit.sh |    8 ++++----
 t/t7502-commit.sh |   26 +++++++++++++++++---------
 3 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index c90a8cf..ac8da45 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -705,19 +705,19 @@ static int prepare_to_commit(const char *index_fi=
le, const char *prefix,
 				git_path("MERGE_HEAD"));
=20
 		fprintf(fp,
-			"\n"
-			"# Please enter the commit message for your changes.");
+			_("\n"
+			"# Please enter the commit message for your changes."));
 		if (cleanup_mode =3D=3D CLEANUP_ALL)
 			fprintf(fp,
-				" Lines starting\n"
+				_(" Lines starting\n"
 				"# with '#' will be ignored, and an empty"
-				" message aborts the commit.\n");
+				" message aborts the commit.\n"));
 		else /* CLEANUP_SPACE, that is. */
 			fprintf(fp,
-				" Lines starting\n"
+				_(" Lines starting\n"
 				"# with '#' will be kept; you may remove them"
 				" yourself if you want to.\n"
-				"# An empty message aborts the commit.\n");
+				"# An empty message aborts the commit.\n"));
 		if (only_include_assumed)
 			fprintf(fp, "# %s\n", only_include_assumed);
=20
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 162527c..70dfc88 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -59,7 +59,7 @@ test_expect_success 'adding comments to a template sh=
ould not commit' '
 	)
 '
=20
-test_expect_success 'adding real content to a template should commit' =
'
+test_expect_success NO_GETTEXT_POISON 'adding real content to a templa=
te should commit' '
 	(
 		test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
 		git commit --template "$TEMPLATE"
@@ -67,7 +67,7 @@ test_expect_success 'adding real content to a templat=
e should commit' '
 	commit_msg_is "template linecommit message"
 '
=20
-test_expect_success '-t option should be short for --template' '
+test_expect_success NO_GETTEXT_POISON '-t option should be short for -=
-template' '
 	echo "short template" > "$TEMPLATE" &&
 	echo "new content" >> foo &&
 	git add foo &&
@@ -78,7 +78,7 @@ test_expect_success '-t option should be short for --=
template' '
 	commit_msg_is "short templatecommit message"
 '
=20
-test_expect_success 'config-specified template should commit' '
+test_expect_success NO_GETTEXT_POISON 'config-specified template shoul=
d commit' '
 	echo "new template" > "$TEMPLATE" &&
 	git config commit.template "$TEMPLATE" &&
 	echo "more content" >> foo &&
@@ -277,7 +277,7 @@ test_expect_success 'commit --squash works with -c =
for same commit' '
 	commit_msg_is "squash! edited commit"
 '
=20
-test_expect_success 'commit --squash works with editor' '
+test_expect_success NO_GETTEXT_POISON 'commit --squash works with edit=
or' '
 	commit_for_rebase_autosquash_setup &&
 	test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
 	git commit --squash HEAD~1 &&
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 298f7d9..6586355 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -221,19 +221,21 @@ test_expect_success 'cleanup commit messages (str=
ip,-F)' '
=20
 '
=20
-echo "sample
-
-# Please enter the commit message for your changes. Lines starting
-# with '#' will be ignored, and an empty message aborts the commit." >=
expect
-
 test_expect_success 'cleanup commit messages (strip,-F,-e)' '
=20
 	echo >>negative &&
 	{ echo;echo sample;echo; } >text &&
 	git commit -e -F text -a &&
-	head -n 4 .git/COMMIT_EDITMSG >actual &&
-	test_cmp expect actual
+	head -n 4 .git/COMMIT_EDITMSG >actual
+'
+
+echo "sample
=20
+# Please enter the commit message for your changes. Lines starting
+# with '#' will be ignored, and an empty message aborts the commit." >=
expect
+
+test_expect_success NO_GETTEXT_POISON 'cleanup commit messages (strip,=
-F,-e): output' '
+	test_cmp expect actual
 '
=20
 echo "#
@@ -244,7 +246,10 @@ test_expect_success NO_GETTEXT_POISON 'author diff=
erent from committer' '
=20
 	echo >>negative &&
 	git commit -e -m "sample"
-	head -n 7 .git/COMMIT_EDITMSG >actual &&
+	head -n 7 .git/COMMIT_EDITMSG >actual
+'
+
+test_expect_success NO_GETTEXT_POISON 'author different from committer=
: output' '
 	test_cmp expect actual
 '
=20
@@ -264,7 +269,10 @@ test_expect_success NO_GETTEXT_POISON 'committer i=
s automatic' '
 		test_must_fail git commit -e -m "sample"
 	) &&
 	head -n 8 .git/COMMIT_EDITMSG |	\
-	sed "s/^# Committer: .*/# Committer:/" >actual &&
+	sed "s/^# Committer: .*/# Committer:/" >actual
+'
+
+test_expect_success NO_GETTEXT_POISON 'committer is automatic: output'=
 '
 	test_cmp expect actual
 '
=20
--=20
1.7.2.3
