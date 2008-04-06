From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 6/6] merge: remove deprecated summary and diffstat options and
	config variables
Date: Sun,  6 Apr 2008 03:23:47 +0200
Message-ID: <1207445027-3152-7-git-send-email-szeder@ira.uka.de>
References: <7vtzigw2wo.fsf@gitster.siamese.dyndns.org>
	<1207445027-3152-1-git-send-email-szeder@ira.uka.de>
	<1207445027-3152-2-git-send-email-szeder@ira.uka.de>
	<1207445027-3152-3-git-send-email-szeder@ira.uka.de>
	<1207445027-3152-4-git-send-email-szeder@ira.uka.de>
	<1207445027-3152-5-git-send-email-szeder@ira.uka.de>
	<1207445027-3152-6-git-send-email-szeder@ira.uka.de>
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
	id 1JiJd8-0004kF-2W
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 03:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755405AbYDFBYL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Apr 2008 21:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755393AbYDFBYL
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 21:24:11 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:61173 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438AbYDFBYH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 21:24:07 -0400
Received: from [127.0.1.1] (p5B132413.dip0.t-ipconnect.de [91.19.36.19])
	by mrelayeu.kundenserver.de (node=mrelayeu0) with ESMTP (Nemesis)
	id 0MKwh2-1JiJc31g76-0008Qz; Sun, 06 Apr 2008 03:24:04 +0200
X-Mailer: git-send-email 1.5.5.rc3.9.gba703
In-Reply-To: <1207445027-3152-6-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V01U2FsdGVkX1/pzgtJqRZHY+j8FdftN4UcRUpR1YFl4B2J2Z5
 sufTVTxu9ZFiQACaXs/wtPX8zneN7mnaAMoWxtb/NaN7zIRM77
 Mb+eWGCyIe6lTNQmEgoiA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78877>

Also remove them from 'pull' and 'fmt-merge-msg'.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 builtin-fmt-merge-msg.c |   12 +++---------
 git-merge.sh            |    5 ++---
 git-pull.sh             |    4 ++--
 3 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index d49f545..0bf87c1 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -12,12 +12,7 @@ static int merge_summary;
=20
 static int fmt_merge_msg_config(const char *key, const char *value)
 {
-	static int found_merge_log =3D 0;
-	if (!strcmp("merge.log", key)) {
-		found_merge_log =3D 1;
-		merge_summary =3D git_config_bool(key, value);
-	}
-	if (!found_merge_log && !strcmp("merge.summary", key))
+	if (!strcmp("merge.log", key))
 		merge_summary =3D git_config_bool(key, value);
 	return 0;
 }
@@ -255,10 +250,9 @@ int cmd_fmt_merge_msg(int argc, const char **argv,=
 const char *prefix)
 	git_config(fmt_merge_msg_config);
=20
 	while (argc > 1) {
-		if (!strcmp(argv[1], "--log") || !strcmp(argv[1], "--summary"))
+		if (!strcmp(argv[1], "--log"))
 			merge_summary =3D 1;
-		else if (!strcmp(argv[1], "--no-log")
-				|| !strcmp(argv[1], "--no-summary"))
+		else if (!strcmp(argv[1], "--no-log"))
 			merge_summary =3D 0;
 		else if (!strcmp(argv[1], "-F") || !strcmp(argv[1], "--file")) {
 			if (argc < 3)
diff --git a/git-merge.sh b/git-merge.sh
index a903e2b..db79851 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -150,9 +150,9 @@ merge_name () {
 parse_config () {
 	while test $# !=3D 0; do
 		case "$1" in
-		-n|--no-stat|--no-summary)
+		-n|--no-stat)
 			show_diffstat=3Dfalse ;;
-		--stat|--summary)
+		--stat)
 			show_diffstat=3Dt ;;
 		--log|--no-log)
 			log_arg=3D$1 ;;
@@ -213,7 +213,6 @@ parse_config "$@"
 while test $args_left -lt $#; do shift; done
=20
 if test -z "$show_diffstat"; then
-    test "$(git config --bool merge.diffstat)" =3D false && show_diffs=
tat=3Dfalse
     test "$(git config --bool merge.stat)" =3D false && show_diffstat=3D=
false
     test -z "$show_diffstat" && show_diffstat=3Dt
 fi
diff --git a/git-pull.sh b/git-pull.sh
index bf0c298..11d37a6 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -23,9 +23,9 @@ rebase=3D$(git config --bool branch.$curr_branch_shor=
t.rebase)
 while :
 do
 	case "$1" in
-	-n|--no-stat|--no-summary)
+	-n|--no-stat)
 		no_stat=3D-n ;;
-	--stat|--summary)
+	--stat)
 		no_stat=3D$1 ;;
 	--log|--no-log)
 		log_arg=3D$1 ;;
--=20
1.5.5.rc3.9.gba703
