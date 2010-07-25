From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 9/9] commit: suppress status summary when no changes staged
Date: Sat, 24 Jul 2010 20:02:30 -0500
Message-ID: <20100725010230.GI18420@burratino>
References: <20100725005443.GA18370@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 03:03:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ocpcx-0000ch-Gj
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 03:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148Ab0GYBDe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 21:03:34 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:59999 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061Ab0GYBDe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 21:03:34 -0400
Received: by gwb20 with SMTP id 20so1101925gwb.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 18:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=xzqlV9f6+CVeAQc8KBE/dl5rvOUMiDX7MP5Io9NyQbo=;
        b=Vifn6Q3mrPrsTfxC8vJgPp7cujtBhLPi1KIDlx7ybVI8GaffSM4DacLCEvzzyFbqVJ
         tGFK+ejRqJdf+MXTXi9ZgDqrLWYy+00Razh6f1F1XzCMBT2QzWZA6fqIUwa1hfWEMvLE
         I/5FoivPMNZhrE0acIJTgFu2Idd0CU/PDrjrU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ePGIMhmQ7vILrXaTzdlRiKNgN+1tcO/v145eNAgifsWIkOiqFRAX3teIPGWh8pqozE
         qa2p8tLUKtH44//FfrQ9XL7GeSpe3GhOQioXhpen2IFJqsDohfWJnP5+rfopH+mVR+dG
         1WKgYM3MjCoMWYqmh8zEdmK2jZSCPJhijG3HE=
Received: by 10.150.61.12 with SMTP id j12mr7620133yba.131.1280019813208;
        Sat, 24 Jul 2010 18:03:33 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id w3sm4326560ybl.9.2010.07.24.18.03.32
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 18:03:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100725005443.GA18370@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151701>

Starting out, it can be unnerving that =E2=80=9Cgit commit=E2=80=9D spe=
ws out
a list of changes instead of just making a commit when the user
has forgotten to stage any changes.

So give some focused advice in that case, by suppressing the
status summary so the existing message about the need to stage
changes can be read more easily.

Example: before:

	$ git commit
	# On branch master
	# Changed but not updated:
	#   (use "git add <file>..." to update what will be committed)
	#   (use "git checkout -- <file>..." to discard changes in working dir=
ectory)
	#
	#	modified:   dir1/modified
	#
	# Untracked files:
	#   (use "git add <file>..." to include in what will be committed)
	#
	#	actual
	#	dir1/untracked
	#	dir2/modified
	#	dir2/untracked
	#	expect
	#	output
	#	untracked
	no changes added to commit (use "git add" and/or "git commit -a")
	$

After:

	$ git commit
	no changes added to commit (use "git add" and/or "git commit -a")
	$

Cc: Jakub Narebski <jnareb@gmail.com>
Cc: Jeff King <peff@peff.net>
Cc: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That=E2=80=99s the end of the series.  Thanks for reading.

 builtin/commit.c  |   10 +++++++++-
 t/t7508-status.sh |    7 ++++---
 wt-status.c       |    2 +-
 wt-status.h       |    1 +
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 9a4ea34..a2588a9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -96,7 +96,8 @@ static int null_termination;
 static enum {
 	STATUS_FORMAT_LONG,
 	STATUS_FORMAT_SHORT,
-	STATUS_FORMAT_PORCELAIN
+	STATUS_FORMAT_PORCELAIN,
+	STATUS_FORMAT_NOCHANGES
 } status_format =3D STATUS_FORMAT_LONG;
 static int status_show_branch;
=20
@@ -443,6 +444,9 @@ static int run_status(FILE *fp, const char *index_f=
ile, const char *prefix, int
 	case STATUS_FORMAT_LONG:
 		wt_status_print(s);
 		break;
+	case STATUS_FORMAT_NOCHANGES:
+		wt_status_print_nochanges(s);
+		break;
 	}
=20
 	return s->commitable;
@@ -711,6 +715,8 @@ static int empty_commit_ok(const char *index_file, =
const char *prefix,
 	if (in_merge || allow_empty || (amend && is_a_merge(head_sha1)))
 		return 1;
=20
+	if (status_format =3D=3D STATUS_FORMAT_LONG)
+		status_format =3D STATUS_FORMAT_NOCHANGES;
 	run_status(stdout, index_file, prefix, 0, s);
 	if (amend)
 		fputs(empty_amend_advice, stderr);
@@ -1170,6 +1176,8 @@ int cmd_status(int argc, const char **argv, const=
 char *prefix)
 		s.ignore_submodule_arg =3D ignore_submodule_arg;
 		wt_status_print(&s);
 		break;
+	case STATUS_FORMAT_NOCHANGES:
+		return error("unexpected status format");
 	}
 	return 0;
 }
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 882e5d7..c41a54c 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -800,10 +800,11 @@ test_expect_success 'status submodule summary (cl=
ean submodule)' '
 	git commit -m "commit submodule" &&
 	git config status.submodulesummary 10 &&
 	test_when_finished "git config --unset status.submodulesummary" &&
-	test_must_fail git commit --dry-run >output &&
+	test_must_fail git commit --dry-run >actual &&
+	git status >output &&
 	test_cmp expect output &&
-	git status >output &&
-	test_cmp expect output
+	echo '\''no changes added to commit (use "git add" and/or "git commit=
 -a")'\'' >expect &&
+	test_cmp expect actual
 '
=20
 test_expect_success 'status -s submodule summary (clean submodule)' '
diff --git a/wt-status.c b/wt-status.c
index 90a0824..83d2ae2 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -612,7 +612,7 @@ static void wt_status_print_verbose(struct wt_statu=
s *s)
 	run_diff_index(&rev, 1);
 }
=20
-static void wt_status_print_nochanges(struct wt_status *s)
+void wt_status_print_nochanges(struct wt_status *s)
 {
 	if (s->amend)
 		fprintf(s->fp, "# No changes\n");
diff --git a/wt-status.h b/wt-status.h
index 9df9c9f..1cee54b 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -65,5 +65,6 @@ void wt_status_collect(struct wt_status *s);
=20
 void wt_shortstatus_print(struct wt_status *s, int null_termination, i=
nt show_branch);
 void wt_porcelain_print(struct wt_status *s, int null_termination);
+void wt_status_print_nochanges(struct wt_status *s);
=20
 #endif /* STATUS_H */
--=20
1.7.2.9.ge3789.dirty
