From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/3] commit: add --cleanup=scissors
Date: Mon, 17 Feb 2014 19:15:32 +0700
Message-ID: <1392639332-7703-4-git-send-email-pclouds@gmail.com>
References: <1392521840-21628-1-git-send-email-pclouds@gmail.com>
 <1392639332-7703-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 17 13:16:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFN7U-00014D-LL
	for gcvg-git-2@plane.gmane.org; Mon, 17 Feb 2014 13:16:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595AbaBQMQL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Feb 2014 07:16:11 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:36817 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470AbaBQMQK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Feb 2014 07:16:10 -0500
Received: by mail-pb0-f52.google.com with SMTP id jt11so15222196pbb.25
        for <git@vger.kernel.org>; Mon, 17 Feb 2014 04:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=EXOb3rVOz1iY3H62riAbVvbR4VmQVISKbk3Ly7Ac+9c=;
        b=R74QLN4rrYvtU+BUg04wOcHcEhRC/3E+7up8S8G4DSvftfUAhUcSWCXYT+Lu8oWe9G
         9JcJEgMtlk1qK6zVyT9D/MfaN5n97V1UEc+ItI3yzdu/swIxsPhdN3qVunPAs3CWQDm8
         QifoJLi9uMx1OT49vMHADRarigELOqqjD+ONpeT7+IcjXqlvvIp1JgQjWfa46QF8l7fD
         HQEPx8pgdWWhJm0d5auA6KYqu4NbxGXSFBeYW1ew7DCeWBNIfhTZMqXS2owGnePAIL1W
         8ZmKprIeoVzPVE3VWTQQ2g+bdwsgXS8BNi30EzwZF6R8+X3m0LF5kCWP75ECvKhu315f
         NkXA==
X-Received: by 10.66.232.68 with SMTP id tm4mr25887148pac.114.1392639369385;
        Mon, 17 Feb 2014 04:16:09 -0800 (PST)
Received: from lanh ([115.73.228.211])
        by mx.google.com with ESMTPSA id q7sm45240446pbc.20.2014.02.17.04.16.06
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 17 Feb 2014 04:16:08 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 17 Feb 2014 19:16:21 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1392639332-7703-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242256>

Since 1a72cfd (commit -v: strip diffs and submodule shortlogs from the
commit message - 2013-12-05) we have a less fragile way to cut out
"git status" at the end of a commit message but it's only enabled for
stripping submodule shortlogs. Add new cleanup option that reuses the
same mechanism for the entire "git status" without accidentally
removing lines starting with '#'

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-commit.txt |  8 +++++++-
 builtin/commit.c             |  9 +++++++--
 t/t7502-commit.sh            | 16 ++++++++++++++++
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.tx=
t
index 1a7616c..7948233 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -176,7 +176,7 @@ OPTIONS
 --cleanup=3D<mode>::
 	This option determines how the supplied commit message should be
 	cleaned up before committing.  The '<mode>' can be `strip`,
-	`whitespace`, `verbatim`, or `default`.
+	`whitespace`, `verbatim`, `scissors` or `default`.
 +
 --
 strip::
@@ -186,6 +186,12 @@ whitespace::
 	Same as `strip` except #commentary is not removed.
 verbatim::
 	Do not change the message at all.
+scissors::
+	Same as `whitespace`, except that everything from (and
+	including) the line
+	"`# ------------------------ >8 ------------------------`"
+	is truncated if the message is to be edited. "`#`" can be
+	customized with core.commentChar.
 default::
 	Same as `strip` if the message is to be edited.
 	Otherwise `whitespace`.
diff --git a/builtin/commit.c b/builtin/commit.c
index 3767478..ea2912f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -113,6 +113,7 @@ static char *sign_commit;
 static enum {
 	CLEANUP_SPACE,
 	CLEANUP_NONE,
+	CLEANUP_SCISSORS,
 	CLEANUP_ALL
 } cleanup_mode;
 static const char *cleanup_arg;
@@ -777,6 +778,8 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 				_("Please enter the commit message for your changes."
 				  " Lines starting\nwith '%c' will be ignored, and an empty"
 				  " message aborts the commit.\n"), comment_line_char);
+		else if (cleanup_mode =3D=3D CLEANUP_SCISSORS)
+			wt_status_add_cut_line(s->fp);
 		else /* CLEANUP_SPACE, that is. */
 			status_printf(s, GIT_COLOR_NORMAL,
 				_("Please enter the commit message for your changes."
@@ -1132,6 +1135,8 @@ static int parse_and_validate_options(int argc, c=
onst char *argv[],
 		cleanup_mode =3D CLEANUP_SPACE;
 	else if (!strcmp(cleanup_arg, "strip"))
 		cleanup_mode =3D CLEANUP_ALL;
+	else if (!strcmp(cleanup_arg, "scissors"))
+		cleanup_mode =3D use_editor ? CLEANUP_SCISSORS : CLEANUP_SPACE;
 	else
 		die(_("Invalid cleanup mode %s"), cleanup_arg);
=20
@@ -1600,8 +1605,8 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 		die(_("could not read commit message: %s"), strerror(saved_errno));
 	}
=20
-	/* Truncate the message just before the diff, if any. */
-	if (verbose)
+	if (verbose || /* Truncate the message just before the diff, if any. =
*/
+	    cleanup_mode =3D=3D CLEANUP_SCISSORS)
 		wt_status_truncate_message_at_cut_line(&sb);
=20
 	if (cleanup_mode !=3D CLEANUP_NONE)
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 6313da2..9a3f3a1 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -223,6 +223,22 @@ test_expect_success 'cleanup commit messages (whit=
espace option,-F)' '
=20
 '
=20
+test_expect_success 'cleanup commit messages (scissors option,-F,-e)' =
'
+
+	echo >>negative &&
+	cat >text <<EOF &&
+
+# to be kept
+# ------------------------ >8 ------------------------
+to be removed
+EOF
+	echo "# to be kept" >expect &&
+	git commit --cleanup=3Dscissors -e -F text -a &&
+	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	test_cmp expect actual
+
+'
+
 test_expect_success 'cleanup commit messages (strip option,-F)' '
=20
 	echo >>negative &&
--=20
1.8.5.2.240.g8478abd
