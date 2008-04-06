From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 4/6] fmt-merge-msg: add '--(no-)log' options and 'merge.log'
	config variable
Date: Sun,  6 Apr 2008 03:23:45 +0200
Message-ID: <1207445027-3152-5-git-send-email-szeder@ira.uka.de>
References: <7vtzigw2wo.fsf@gitster.siamese.dyndns.org>
	<1207445027-3152-1-git-send-email-szeder@ira.uka.de>
	<1207445027-3152-2-git-send-email-szeder@ira.uka.de>
	<1207445027-3152-3-git-send-email-szeder@ira.uka.de>
	<1207445027-3152-4-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Teemu Likonen <tlikonen@iki.fi>,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 06 03:25:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiJd8-0004kF-NB
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 03:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413AbYDFBYP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Apr 2008 21:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755393AbYDFBYO
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 21:24:14 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:63496 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755399AbYDFBYL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 21:24:11 -0400
Received: from [127.0.1.1] (p5B132413.dip0.t-ipconnect.de [91.19.36.19])
	by mrelayeu.kundenserver.de (node=mrelayeu0) with ESMTP (Nemesis)
	id 0MKwh2-1JiJbv3se4-0008Nt; Sun, 06 Apr 2008 03:24:01 +0200
X-Mailer: git-send-email 1.5.5.rc3.9.gba703
In-Reply-To: <1207445027-3152-4-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V01U2FsdGVkX1+umQlLPZkXGFj2ZI8ez1050B4s0fYstSCPc7z
 nVP9ql5dT0/gsoV4hxhAs5RdoBENuxgCaNN0jC2aU7NcScfHtn
 xk7LYoDVjCfgJneSuZteg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78879>

These are doing the same as the '--(no-)summary' options or the
'merge.summary' config variable, but are consistent with the soon to be
added 'merge --(no-)log' options.  The 'merge.summary' config variable
and '--(no-)summary' options are still accepted, but are not advertised=
=2E
'merge.log' takes precedence over 'merge.summary'.

Update documentation and test accordingly.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/git-fmt-merge-msg.txt |   10 +++++-----
 Documentation/merge-config.txt      |    2 +-
 builtin-fmt-merge-msg.c             |   14 ++++++++++----
 t/t6200-fmt-merge-msg.sh            |    6 +++---
 4 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fm=
t-merge-msg.txt
index 8615ae3..bf9c26b 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -9,8 +9,8 @@ git-fmt-merge-msg - Produce a merge commit message
 SYNOPSIS
 --------
 [verse]
-git-fmt-merge-msg [--summary | --no-summary] <$GIT_DIR/FETCH_HEAD
-git-fmt-merge-msg [--summary | --no-summary] -F <file>
+git-fmt-merge-msg [--log | --no-log] <$GIT_DIR/FETCH_HEAD
+git-fmt-merge-msg [--log | --no-log] -F <file>
=20
 DESCRIPTION
 -----------
@@ -24,12 +24,12 @@ automatically invoking `git-merge`.
 OPTIONS
 -------
=20
---summary::
+--log::
 	In addition to branch names, populate the log message with
 	one-line descriptions from the actual commits that are being
 	merged.
=20
---no-summary::
+--no-log::
 	Do not list one-line descriptions from the actual commits being
 	merged.
=20
@@ -40,7 +40,7 @@ OPTIONS
 CONFIGURATION
 -------------
=20
-merge.summary::
+merge.log::
 	Whether to include summaries of merged commits in newly
 	merge commit messages. False by default.
=20
diff --git a/Documentation/merge-config.txt b/Documentation/merge-confi=
g.txt
index 6d0a797..9719311 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -2,7 +2,7 @@ merge.stat::
 	Whether to print the diffstat berween ORIG_HEAD and merge result
 	at the end of the merge.  True by default.
=20
-merge.summary::
+merge.log::
 	Whether to include summaries of merged commits in newly created
 	merge commit messages. False by default.
=20
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index ebb3f37..d49f545 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -6,13 +6,18 @@
 #include "tag.h"
=20
 static const char *fmt_merge_msg_usage =3D
-	"git-fmt-merge-msg [--summary] [--no-summary] [--file <file>]";
+	"git-fmt-merge-msg [--log] [--no-log] [--file <file>]";
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
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 9f70afc..1a04b89 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -107,7 +107,7 @@ EOF
=20
 test_expect_success 'merge-msg test #3' '
=20
-	git config merge.summary true &&
+	git config merge.log true &&
=20
 	git checkout master &&
 	setdate &&
@@ -137,7 +137,7 @@ EOF
=20
 test_expect_success 'merge-msg test #4' '
=20
-	git config merge.summary true &&
+	git config merge.log true &&
=20
 	git checkout master &&
 	setdate &&
@@ -149,7 +149,7 @@ test_expect_success 'merge-msg test #4' '
=20
 test_expect_success 'merge-msg test #5' '
=20
-	git config merge.summary yes &&
+	git config merge.log yes &&
=20
 	git checkout master &&
 	setdate &&
--=20
1.5.5.rc3.9.gba703
