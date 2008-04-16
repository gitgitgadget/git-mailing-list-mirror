From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2 05/12] fmt-merge-msg: add '--(no-)log' options and
	'merge.log' config variable
Date: Wed, 16 Apr 2008 02:39:04 +0200
Message-ID: <1208306351-20922-6-git-send-email-szeder@ira.uka.de>
References: <7vzls7so8m.fsf@gitster.siamese.dyndns.org>
	<1208306351-20922-1-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-2-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-3-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-4-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-5-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 06:29:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlvgy-0007Zm-2b
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 02:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815AbYDPAjV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Apr 2008 20:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754607AbYDPAjU
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 20:39:20 -0400
Received: from moutng.kundenserver.de ([212.227.126.174]:52115 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960AbYDPAjS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 20:39:18 -0400
Received: from [127.0.1.1] (p5B13305D.dip0.t-ipconnect.de [91.19.48.93])
	by mrelayeu.kundenserver.de (node=mrelayeu2) with ESMTP (Nemesis)
	id 0MKwtQ-1JlvgC3Z1P-0002NW; Wed, 16 Apr 2008 02:39:17 +0200
X-Mailer: git-send-email 1.5.5.76.g546c
In-Reply-To: <1208306351-20922-5-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V01U2FsdGVkX1+Y5Q3YC/C09fip9cp4QJKCE4RqfnJns33eEhu
 naPCO295f0zeve68G8wUTp67aFNFxBthdIN0218iMpX1uzeHZV
 AyhIERu/5PFn1HRtF0pYw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79647>

These options and config variable have the same effect as the current
'--(no-)summary' options and 'merge.summary' config variable.
'merge.log' takes precedence over 'merge.summary'.

Documentation and bash completion are updated accordingly.  Tests are
also updated and new tests are added to ensure that the command line
options are working properly and are overriding the config variables.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/git-fmt-merge-msg.txt    |    7 ++++-
 Documentation/merge-config.txt         |    1 +
 builtin-fmt-merge-msg.c                |   14 ++++++++---
 contrib/completion/git-completion.bash |    1 +
 t/t6200-fmt-merge-msg.sh               |   40 ++++++++++++++++++++++++=
++++++-
 5 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fm=
t-merge-msg.txt
index 8615ae3..cd441c5 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -9,8 +9,8 @@ git-fmt-merge-msg - Produce a merge commit message
 SYNOPSIS
 --------
 [verse]
-git-fmt-merge-msg [--summary | --no-summary] <$GIT_DIR/FETCH_HEAD
-git-fmt-merge-msg [--summary | --no-summary] -F <file>
+git-fmt-merge-msg [--[no-]log | --[no-]summary] <$GIT_DIR/FETCH_HEAD
+git-fmt-merge-msg [--[no-]log | --[no-]summary] -F <file>
=20
 DESCRIPTION
 -----------
@@ -24,11 +24,13 @@ automatically invoking `git-merge`.
 OPTIONS
 -------
=20
+--log::
 --summary::
 	In addition to branch names, populate the log message with
 	one-line descriptions from the actual commits that are being
 	merged.
=20
+--no-log::
 --no-summary::
 	Do not list one-line descriptions from the actual commits being
 	merged.
@@ -40,6 +42,7 @@ OPTIONS
 CONFIGURATION
 -------------
=20
+merge.log::
 merge.summary::
 	Whether to include summaries of merged commits in newly
 	merge commit messages. False by default.
diff --git a/Documentation/merge-config.txt b/Documentation/merge-confi=
g.txt
index 15efc0d..a0f71e6 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -3,6 +3,7 @@ merge.diffstat::
 	Whether to print the diffstat berween ORIG_HEAD and merge result
 	at the end of the merge.  True by default.
=20
+merge.log::
 merge.summary::
 	Whether to include summaries of merged commits in newly created
 	merge commit messages. False by default.
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index ebb3f37..3df8ff8 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -6,13 +6,18 @@
 #include "tag.h"
=20
 static const char *fmt_merge_msg_usage =3D
-	"git-fmt-merge-msg [--summary] [--no-summary] [--file <file>]";
+	"git-fmt-merge-msg [--log | --summary] [--no-log | --no-summary] [--f=
ile <file>]";
=20
 static int merge_summary;
=20
 static int fmt_merge_msg_config(const char *key, const char *value)
 {
-	if (!strcmp("merge.summary", key))
+	static int found_merge_log =3D 0;
+	if (!strcmp("merge.log", key)) {
+		found_merge_log =3D 1;
+		merge_summary =3D git_config_bool(key, value);
+	}
+	if (!found_merge_log && !strcmp("merge.summary", key))
 		merge_summary =3D git_config_bool(key, value);
 	return 0;
 }
@@ -250,9 +255,10 @@ int cmd_fmt_merge_msg(int argc, const char **argv,=
 const char *prefix)
 	git_config(fmt_merge_msg_config);
=20
 	while (argc > 1) {
-		if (!strcmp(argv[1], "--summary"))
+		if (!strcmp(argv[1], "--log") || !strcmp(argv[1], "--summary"))
 			merge_summary =3D 1;
-		else if (!strcmp(argv[1], "--no-summary"))
+		else if (!strcmp(argv[1], "--no-log")
+				|| !strcmp(argv[1], "--no-summary"))
 			merge_summary =3D 0;
 		else if (!strcmp(argv[1], "-F") || !strcmp(argv[1], "--file")) {
 			if (argc < 3)
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 4caff8d..276a984 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1023,6 +1023,7 @@ _git_config ()
 		log.showroot
 		merge.tool
 		merge.stat
+		merge.log
 		merge.summary
 		merge.verbosity
 		pack.window
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 1af3ab2..20704eb 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -138,7 +138,8 @@ EOF
=20
 test_expect_success 'merge-msg test #4' '
=20
-	git config merge.summary true &&
+	git config --unset merge.summary &&
+	git config merge.log true &&
=20
 	git checkout master &&
 	setdate &&
@@ -150,7 +151,7 @@ test_expect_success 'merge-msg test #4' '
=20
 test_expect_success 'merge-msg test #5' '
=20
-	git config merge.summary yes &&
+	git config merge.log yes &&
=20
 	git checkout master &&
 	setdate &&
@@ -160,4 +161,39 @@ test_expect_success 'merge-msg test #5' '
 	git diff actual msg.left_right.log
 '
=20
+test_expect_success 'merge-msg command line options #1' '
+	git config --unset merge.log &&
+
+	git checkout master &&
+	setdate &&
+	git fetch . left &&
+
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	git diff actual msg.left.nolog
+'
+
+test_expect_success 'merge-msg command line options #2' '
+	git fmt-merge-msg --log <.git/FETCH_HEAD >actual &&
+	git diff actual msg.left.log
+'
+
+test_expect_success 'merge-msg command line options #3' '
+	git fmt-merge-msg --summary <.git/FETCH_HEAD >actual &&
+	git diff actual msg.left.log
+'
+
+test_expect_success 'merge-msg command line option overrides config #1=
' '
+	git config merge.log true &&
+
+	git fmt-merge-msg --no-log <.git/FETCH_HEAD >actual &&
+	git diff actual msg.left.nolog
+'
+
+test_expect_success 'merge-msg command line option overrides config #2=
' '
+	git config merge.log false &&
+
+	git fmt-merge-msg --log <.git/FETCH_HEAD >actual &&
+	git diff actual msg.left.log
+'
+
 test_done
--=20
1.5.5.76.g546c
