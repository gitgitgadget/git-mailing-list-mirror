From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 29/73] gettextize: git-commit "enter the commit message" message
Date: Tue, 22 Feb 2011 23:41:48 +0000
Message-ID: <1298418152-27789-30-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:46:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1w2-0000rs-5t
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755400Ab1BVXoJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:44:09 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39209 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755166Ab1BVXoB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:01 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866615bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=sU4WS9cGkuQuMaTIL6sv2peh45JalwAXJT0UvmTMqVc=;
        b=Wlq3yBVHrJtl14ALtVKWDV9Fm/wftW+N/Cfxe2MkE+Fu5dw6wk8m8YR/5Fi7LTGuKm
         H4EBWNdQ62+WTMaIZ30UNdj2Oqurq7hvOJ1RxCjAyPb7MLzH3xj72EXzEQjNs4M+Wswi
         kpGMDgUKw19pivk3E8J39l/lt8DuAbQlhI1QI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KmQpgjLBwt0Y4WdBKjcgqwguR8uQmYLd5EqIawOvjK5C1FaEKj5ULU3ebsbV9eRCsE
         T1NDnvMOhec/E3TT+E7cUQbQvLTCcp+SwK2a8haZeds/GliyBDlAW+3BlGja3L6+LN/Q
         L1Olkcer308dTppgkMA84uxlKof50157447uY=
Received: by 10.204.99.145 with SMTP id u17mr3051110bkn.1.1298418240425;
        Tue, 22 Feb 2011 15:44:00 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.43.59
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:43:59 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167639>

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
index 162527c..92cd3f5 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -59,7 +59,7 @@ test_expect_success 'adding comments to a template sh=
ould not commit' '
 	)
 '
=20
-test_expect_success 'adding real content to a template should commit' =
'
+test_expect_success C_LOCALE_OUTPUT 'adding real content to a template=
 should commit' '
 	(
 		test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
 		git commit --template "$TEMPLATE"
@@ -67,7 +67,7 @@ test_expect_success 'adding real content to a templat=
e should commit' '
 	commit_msg_is "template linecommit message"
 '
=20
-test_expect_success '-t option should be short for --template' '
+test_expect_success C_LOCALE_OUTPUT '-t option should be short for --t=
emplate' '
 	echo "short template" > "$TEMPLATE" &&
 	echo "new content" >> foo &&
 	git add foo &&
@@ -78,7 +78,7 @@ test_expect_success '-t option should be short for --=
template' '
 	commit_msg_is "short templatecommit message"
 '
=20
-test_expect_success 'config-specified template should commit' '
+test_expect_success C_LOCALE_OUTPUT 'config-specified template should =
commit' '
 	echo "new template" > "$TEMPLATE" &&
 	git config commit.template "$TEMPLATE" &&
 	echo "more content" >> foo &&
@@ -277,7 +277,7 @@ test_expect_success 'commit --squash works with -c =
for same commit' '
 	commit_msg_is "squash! edited commit"
 '
=20
-test_expect_success 'commit --squash works with editor' '
+test_expect_success C_LOCALE_OUTPUT 'commit --squash works with editor=
' '
 	commit_for_rebase_autosquash_setup &&
 	test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
 	git commit --squash HEAD~1 &&
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index dad1b2b..1f29b5c 100755
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
+test_expect_success C_LOCALE_OUTPUT 'cleanup commit messages (strip,-F=
,-e): output' '
+	test_cmp expect actual
 '
=20
 echo "#
@@ -244,7 +246,10 @@ test_expect_success C_LOCALE_OUTPUT 'author differ=
ent from committer' '
=20
 	echo >>negative &&
 	git commit -e -m "sample"
-	head -n 7 .git/COMMIT_EDITMSG >actual &&
+	head -n 7 .git/COMMIT_EDITMSG >actual
+'
+
+test_expect_success C_LOCALE_OUTPUT 'author different from committer: =
output' '
 	test_cmp expect actual
 '
=20
@@ -264,7 +269,10 @@ test_expect_success C_LOCALE_OUTPUT 'committer is =
automatic' '
 		test_must_fail git commit -e -m "sample"
 	) &&
 	head -n 8 .git/COMMIT_EDITMSG |	\
-	sed "s/^# Committer: .*/# Committer:/" >actual &&
+	sed "s/^# Committer: .*/# Committer:/" >actual
+'
+
+test_expect_success C_LOCALE_OUTPUT 'committer is automatic: output' '
 	test_cmp expect actual
 '
=20
--=20
1.7.2.3
