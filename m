From: Dongcan Jiang <dongcan.jiang@gmail.com>
Subject: [PATCH v2/GSoC/MICRO] revision: forbid combining --graph and --no-walk
Date: Sat,  7 Mar 2015 12:56:47 +0800
Message-ID: <3de5837561c07fbf8d6187578fc37b3dbf2ea5f7.1425702676.git.dongcan.jiang@gmail.com>
References: <1425632110-31863-1-git-send-email-dongcan.jiang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Dongcan Jiang <dongcan.jiang@gmail.com>
To: sunshine@sunshineco.com, l.s.r@web.de, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 07 06:30:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YU7Jf-00051I-Op
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 06:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752273AbbCGFaT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Mar 2015 00:30:19 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:39991 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758AbbCGFaR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2015 00:30:17 -0500
Received: by padfb1 with SMTP id fb1so47814611pad.7
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 21:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:in-reply-to
         :references:content-type:content-transfer-encoding;
        bh=EwO5OiZwBKqlo/ipd2NzQn/LyhKO7NLCxatEiBTxOHQ=;
        b=MrPbEPXpLl5hLOII5Mm+kuHi6U/KteZZGUTkeAuLVFEwKGh3mr5Po1uJNweEp3/+FV
         PZONQC0bvWvROMpq8Xt6vjgkqXthotfLVukE3dBd1hVUbHpE0BSs/UjrW2Z0CxvveiC5
         rYXwMjrIIV6Y4fjkjTOfvu60zNOExGZKc1BgYN9jq2vCPCjZ7Jfiq2CTepXIsmeEnjzR
         OYF4iYKomsStEOuGaFT3IgGg7M/3KmseZYvPqH1HwCfUsbL0SB6ko6aKV0LeEkcXsmp9
         yMRMlUF3LtqOUU9cW+57TdOK9MXM6tOKd+M5P3oIM4YkLNhGHCqsrXszc7TQHqIDAGS3
         KEHg==
X-Received: by 10.70.140.75 with SMTP id re11mr31872047pdb.112.1425706217278;
        Fri, 06 Mar 2015 21:30:17 -0800 (PST)
Received: from localhost.localdomain ([162.105.205.253])
        by mx.google.com with ESMTPSA id om6sm11112100pdb.40.2015.03.06.21.30.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Mar 2015 21:30:16 -0800 (PST)
X-Mailer: git-send-email 2.3.1.253.g3de5837
In-Reply-To: <1425632110-31863-1-git-send-email-dongcan.jiang@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264991>

Because --graph is about connected history while
--no-walk is about discrete points. [1]

It's a pity that git-show has to allow such combination
in order to make t4052-stat-output.sh compatible. [2]

2 testcases have been added to test this patch.

[1]: http://article.gmane.org/gmane.comp.version-control.git/216083
[2]: http://article.gmane.org/gmane.comp.version-control.git/264950

Signed-off-by: Dongcan Jiang <dongcan.jiang@gmail.com>

Thanks-to: Eric Sunshine, Ren=C3=A9 Scharfe, Junio C Hamano
---
 Documentation/rev-list-options.txt | 2 ++
 builtin/log.c                      | 1 +
 revision.c                         | 4 ++++
 revision.h                         | 3 +++
 t/t4202-log.sh                     | 6 ++++++
 t/t6014-rev-list-all.sh            | 6 ++++++
 6 files changed, 22 insertions(+)

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

 	revs->commit_format =3D CMIT_FMT_DEFAULT;

+	revs->cmd_is_show =3D 0;
+
 	init_grep_defaults();
 	grep_init(&revs->grep_filter, prefix);
 	revs->grep_filter.status_only =3D 1;
@@ -2339,6 +2341,8 @@ int setup_revisions(int argc, const char **argv, =
struct rev_info *revs, struct s

 	if (revs->reflog_info && revs->graph)
 		die("cannot combine --walk-reflogs with --graph");
+	if (!revs->cmd_is_show && revs->no_walk && revs->graph)
+		die("cannot combine --no-walk with --graph");
 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
 		die("cannot use --grep-reflog without --walk-reflogs");

diff --git a/revision.h b/revision.h
index 0ea8b4e..378c3bf 100644
--- a/revision.h
+++ b/revision.h
@@ -146,6 +146,9 @@ struct rev_info {
 			track_first_time:1,
 			linear:1;

+	/* cmd type */
+	unsigned int  cmd_is_show:1;
+
 	enum date_mode date_mode;

 	unsigned int	abbrev;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 5f2b290..fed162e 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -887,4 +887,10 @@ test_expect_success GPG 'log --graph --show-signat=
ure for merged tag' '
 	grep "^| | gpg: Good signature" actual
 '

+test_expect_success 'log --graph --no-walk is forbidden' '
+	echo "fatal: cannot combine --no-walk with --graph" >expect-error &&
+	test_must_fail git log --graph --no-walk 2>error &&
+	test_cmp expect-error error
+'
+
 test_done
diff --git a/t/t6014-rev-list-all.sh b/t/t6014-rev-list-all.sh
index 991ab4a..574e8d9 100755
--- a/t/t6014-rev-list-all.sh
+++ b/t/t6014-rev-list-all.sh
@@ -35,4 +35,10 @@ test_expect_success 'repack does not lose detached H=
EAD' '

 '

+test_expect_success 'rev-list --graph --no-walk is forbidden' '
+	echo "fatal: cannot combine --no-walk with --graph" >expect-error &&
+	test_must_fail git rev-list --graph --no-walk 2>error &&
+	test_cmp expect-error error
+'
+
 test_done
--
2.3.1.253.g3de5837
