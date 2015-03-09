From: Dongcan Jiang <dongcan.jiang@gmail.com>
Subject: [PATCH v3/GSoC/MICRO] revision: forbid combining --graph and --no-walk
Date: Mon,  9 Mar 2015 12:09:54 +0800
Message-ID: <297580e4cf8a1152224394ce27f67e2457657615.1425865346.git.dongcan.jiang@gmail.com>
References: <1425632110-31863-1-git-send-email-dongcan.jiang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sunshine@sunshineco.com, l.s.r@web.de,
	Dongcan Jiang <dongcan.jiang@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 05:45:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUpZT-0000Nt-VA
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 05:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbbCIEpf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2015 00:45:35 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:43361 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbbCIEpe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 00:45:34 -0400
Received: by pdjp10 with SMTP id p10so54882342pdj.10
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 21:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4bRVJSqVCRVPX62DYyTHKMG67H1FSbb7PRvHgNGOg/4=;
        b=VMj/Yr5K4skXmaM83iU3SMxvaKX4tQufi6pS0kgiVKZpEoUqqYatRjp8V04z1Fx1JY
         oiM6qX+wUpVZ9WH8RGCvmliTC7BdgcxpuUWjrQy0jJn3r1iB0NLKWrwnRKNvMzq/B6FJ
         QvnbQ/rU2pJGZQrIovBbH3MkCBzEZdgxt3rx1NOVw26N3xZlKpxLOUk0IM9rZ1wA29j4
         HwzrXz1i5hXQAvOlzUP8o7yEy1lJIgMgh/91FYfNMlrxVtzRxZ1h+YkyZle+ODIBWeIQ
         D6Up65KzL3ao/6CB0YOj/TAGzrvc9q3PF4P0vm7g0MDMAv3GUB9241x74hNNRBULb1Lk
         AgLA==
X-Received: by 10.70.55.8 with SMTP id n8mr10910136pdp.167.1425876334076;
        Sun, 08 Mar 2015 21:45:34 -0700 (PDT)
Received: from localhost.localdomain ([162.105.205.253])
        by mx.google.com with ESMTPSA id ji6sm16801764pac.30.2015.03.08.21.45.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Mar 2015 21:45:33 -0700 (PDT)
X-Mailer: git-send-email 2.3.1.252.ge67f612
In-Reply-To: <1425632110-31863-1-git-send-email-dongcan.jiang@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265124>

Because "--graph" is about connected history while --no-walk
is about discrete points, it does not make sense to allow
giving these two options at the same time. [1]

This change allows git-show to have such options' combination
as a special case, because git-show itself has underlying
--no-walk option, while "git show --graph" is a legal and
useful operation which is tested in t4052. [2,3]

2 testcases have been added to test this patch.

[1]: http://article.gmane.org/gmane.comp.version-control.git/216083
[2]: http://article.gmane.org/gmane.comp.version-control.git/264950
[3]: http://article.gmane.org/gmane.comp.version-control.git/265107

Helped-By: Eric Sunshine <sunshine@sunshineco.com>
Helped-By: Ren=C3=A9 Scharfe <l.s.r@web.de>
Helped-By: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Dongcan Jiang <dongcan.jiang@gmail.com>
---
 Documentation/rev-list-options.txt | 2 ++
 builtin/log.c                      | 1 +
 revision.c                         | 4 ++++
 revision.h                         | 3 +++
 t/t4202-log.sh                     | 4 ++++
 t/t6014-rev-list-all.sh            | 4 ++++
 6 files changed, 18 insertions(+)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-lis=
t-options.txt
index 4ed8587..136abdf 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -679,6 +679,7 @@ endif::git-rev-list[]
 	given on the command line. Otherwise (if `sorted` or no argument
 	was given), the commits are shown in reverse chronological order
 	by commit time.
+	Cannot be combined with `--graph`.
=20
 --do-walk::
 	Overrides a previous `--no-walk`.
@@ -781,6 +782,7 @@ you would get an output like this:
 	on the left hand side of the output.  This may cause extra lines
 	to be printed in between commits, in order for the graph history
 	to be drawn properly.
+	Cannot be combined with `--no-walk`.
 +
 This enables parent rewriting, see 'History Simplification' below.
 +
diff --git a/builtin/log.c b/builtin/log.c
index dd8f3fc..5b5d028 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -524,6 +524,7 @@ int cmd_show(int argc, const char **argv, const cha=
r *prefix)
=20
 	memset(&match_all, 0, sizeof(match_all));
 	init_revisions(&rev, prefix);
+	rev.cmd_is_show =3D 1;
 	rev.diff =3D 1;
 	rev.always_show_header =3D 1;
 	rev.no_walk =3D REVISION_WALK_NO_WALK_SORTED;
diff --git a/revision.c b/revision.c
index 66520c6..5d6fbef 100644
--- a/revision.c
+++ b/revision.c
@@ -1399,6 +1399,8 @@ void init_revisions(struct rev_info *revs, const =
char *prefix)
=20
 	revs->commit_format =3D CMIT_FMT_DEFAULT;
=20
+	revs->cmd_is_show =3D 0;
+
 	init_grep_defaults();
 	grep_init(&revs->grep_filter, prefix);
 	revs->grep_filter.status_only =3D 1;
@@ -2339,6 +2341,8 @@ int setup_revisions(int argc, const char **argv, =
struct rev_info *revs, struct s
=20
 	if (revs->reflog_info && revs->graph)
 		die("cannot combine --walk-reflogs with --graph");
+	if (!revs->cmd_is_show && revs->no_walk && revs->graph)
+		die("cannot combine --no-walk with --graph");
 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
 		die("cannot use --grep-reflog without --walk-reflogs");
=20
diff --git a/revision.h b/revision.h
index 0ea8b4e..378c3bf 100644
--- a/revision.h
+++ b/revision.h
@@ -146,6 +146,9 @@ struct rev_info {
 			track_first_time:1,
 			linear:1;
=20
+	/* cmd type */
+	unsigned int  cmd_is_show:1;
+
 	enum date_mode date_mode;
=20
 	unsigned int	abbrev;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 5f2b290..f111705 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -887,4 +887,8 @@ test_expect_success GPG 'log --graph --show-signatu=
re for merged tag' '
 	grep "^| | gpg: Good signature" actual
 '
=20
+test_expect_success 'log --graph --no-walk is forbidden' '
+	test_must_fail git log --graph --no-walk
+'
+
 test_done
diff --git a/t/t6014-rev-list-all.sh b/t/t6014-rev-list-all.sh
index 991ab4a..c9bedd2 100755
--- a/t/t6014-rev-list-all.sh
+++ b/t/t6014-rev-list-all.sh
@@ -35,4 +35,8 @@ test_expect_success 'repack does not lose detached HE=
AD' '
=20
 '
=20
+test_expect_success 'rev-list --graph --no-walk is forbidden' '
+	test_must_fail git rev-list --graph --no-walk HEAD
+'
+
 test_done
--=20
2.3.1.252.ge67f612
