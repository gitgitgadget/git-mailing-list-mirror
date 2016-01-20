From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/7] log: add --rename-notes to correct renames per commit
Date: Wed, 20 Jan 2016 18:06:05 +0700
Message-ID: <1453287968-26000-5-git-send-email-pclouds@gmail.com>
References: <1453287968-26000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 12:07:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLqbM-0003Vn-W8
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 12:07:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbcATLGz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2016 06:06:55 -0500
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34555 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964817AbcATLGu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 06:06:50 -0500
Received: by mail-pa0-f66.google.com with SMTP id yy13so252965pab.1
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 03:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qYxi+yilzp7Q1HLiuQtkcwXckQgeEi8wQNBvwyxeVl8=;
        b=yYw8LzXdkn7+byC64kdsCSH0EwvYFrcrUiIIutRiOaX0k70D2BaqfVOxyYlWHjmzya
         EKOJjKgN+SBPK0sY7M3E2njTddTmR9s4iIZmLVc2rYNQTipLCASoOF3OkSHrl+abK3I+
         IiN65a1oWg7aY50ivGY0xoTqknEmaiCWZnJJDDc2eFlMgbDf4/gLQSwcHfgxIkKh4b7g
         1JwZOPbELzNWDllsRq9WlNB0Ltay8Xaxw5CraPVpGfKcMQbHzJniSrOyoDqxe4gH5mPN
         A59O6BcwA9s5qbuZ+clhpQaIs65UZFXd53BAUxtEwYbp/V4zYQi7ekE18O/FaUYIspoZ
         9bAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=qYxi+yilzp7Q1HLiuQtkcwXckQgeEi8wQNBvwyxeVl8=;
        b=WXI8e7apji5NK7jI2GqDPPoFKlwYwPNFWHQK1WoBNpMefautphRkBtgxtFYWnpOJmn
         fopcw88fBQD+mKQQkCCNeAB4Et2oYRsaEeAkT2bzzIlYJZ34rhGKvf/Ru9lXDMKbUhuw
         vw5DnMSFxKb9qv6StlZWg7tBG4KG2IpptW8NIGOZAB1WQkUg0gHwrGikGshXPz4VIG6j
         J3FU+ZYUL/L7CZ7t17XkCEp28W9qaQY+6sc6xOolSpAC9LY1ipz7kXaRqC2YfkP6IfVt
         diLgBgqGQTK3DhH+qRUC1tu5aYk7HI3oWmQf/LnLwEdu55iFRv0RJ0r9EZKEVuz6nLE1
         2SJA==
X-Gm-Message-State: ALoCoQlD2KFK7fPnlBMM56luFIbpGVrxVCoojmgpUhAfrpaU8Q/OpGdQ96Idd9WXNZYIfIrncXLQK59z9EMYGjudIc4mgddzCQ==
X-Received: by 10.66.255.97 with SMTP id ap1mr51639289pad.135.1453288009823;
        Wed, 20 Jan 2016 03:06:49 -0800 (PST)
Received: from lanh ([115.72.43.83])
        by smtp.gmail.com with ESMTPSA id t67sm48041388pfa.14.2016.01.20.03.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2016 03:06:48 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 20 Jan 2016 18:06:44 +0700
X-Mailer: git-send-email 2.7.0.125.g9eec362
In-Reply-To: <1453287968-26000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284451>

=46or simplicity, the note of commit A implies rename correction betwee=
n
A^ and A. If parents are manipulated (e.g. "git log --reflog") then
the rename output may surprise people.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/pretty-options.txt |  5 +++++
 log-tree.c                       | 32 ++++++++++++++++++++++++++++++++
 revision.c                       | 10 ++++++++++
 revision.h                       |  1 +
 t/t4001-diff-rename.sh           | 24 ++++++++++++++++++++++++
 5 files changed, 72 insertions(+)

diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-op=
tions.txt
index 4b659ac..15a2971 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -75,6 +75,11 @@ being displayed. Examples: "--notes=3Dfoo" will show=
 only notes from
 --[no-]standard-notes::
 	These options are deprecated. Use the above --notes/--no-notes
 	options instead.
+
+--rename-notes=3D<ref>::
+	Get per-commit rename instructions from notes. See option
+	`--rename-file` for more information. If both `--rename-notes`
+	and `--rename-file` are specified, the last one takes effect.
 endif::git-rev-list[]
=20
 --show-signature::
diff --git a/log-tree.c b/log-tree.c
index f70a30e..e5766a6 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -788,6 +788,36 @@ static int do_diff_combined(struct rev_info *opt, =
struct commit *commit)
 	return !opt->loginfo;
 }
=20
+static void populate_rename_notes(struct rev_info *opt, const struct o=
bject_id *oid)
+{
+	static char *last_note;
+	enum object_type type;
+	unsigned long size;
+	const unsigned char *sha1;
+
+	if (!opt->rename_notes)
+		return;
+
+	/*
+	 * "--rename-notes=3Dabc --rename-file=3Ddef" is specified in this
+	 * order, --rename-file wins.
+	 */
+	if (opt->diffopt.manual_renames !=3D NULL &&
+	    opt->diffopt.manual_renames !=3D last_note)
+		return;
+
+	free(last_note);
+	opt->diffopt.manual_renames =3D NULL;
+
+	sha1 =3D get_note(opt->rename_notes, oid->hash);
+	if (!sha1)
+		return;
+
+	last_note =3D read_sha1_file(sha1, &type, &size);
+	if (type =3D=3D OBJ_BLOB)
+		opt->diffopt.manual_renames =3D last_note;
+}
+
 /*
  * Show the diff of a commit.
  *
@@ -805,6 +835,8 @@ static int log_tree_diff(struct rev_info *opt, stru=
ct commit *commit, struct log
 	parse_commit_or_die(commit);
 	oid =3D &commit->tree->object.oid;
=20
+	populate_rename_notes(opt, &commit->object.oid);
+
 	/* Root commit? */
 	parents =3D get_saved_parents(opt, commit);
 	if (!parents) {
diff --git a/revision.c b/revision.c
index 14daefb..20346c1 100644
--- a/revision.c
+++ b/revision.c
@@ -1958,6 +1958,16 @@ static int handle_revision_opt(struct rev_info *=
revs, int argc, const char **arg
 		revs->notes_opt.use_default_notes =3D 1;
 	} else if (!strcmp(arg, "--no-standard-notes")) {
 		revs->notes_opt.use_default_notes =3D 0;
+	} else if (skip_prefix(arg, "--rename-notes=3D", &optarg)) {
+		struct strbuf buf =3D STRBUF_INIT;
+		struct notes_tree *nt;
+
+		strbuf_addstr(&buf, optarg);
+		expand_notes_ref(&buf);
+		revs->rename_notes =3D nt =3D xcalloc(1, sizeof(*nt));
+		init_notes(nt, buf.buf, NULL, 0);
+		strbuf_release(&buf);
+		revs->diffopt.manual_renames =3D NULL;
 	} else if (!strcmp(arg, "--oneline")) {
 		revs->verbose_header =3D 1;
 		get_commit_format("oneline", revs);
diff --git a/revision.h b/revision.h
index 23857c0..db2f225 100644
--- a/revision.h
+++ b/revision.h
@@ -189,6 +189,7 @@ struct rev_info {
 	/* diff info for patches and for paths limiting */
 	struct diff_options diffopt;
 	struct diff_options pruning;
+	struct notes_tree *rename_notes;
=20
 	struct reflog_walk_info *reflog_info;
 	struct decoration children;
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index ab9a666..21d9378 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -189,4 +189,28 @@ test_expect_success 'manual rename correction' '
 	)
 '
=20
+test_expect_success 'rename correction from notes' '
+	(
+		cd correct-rename &&
+		git show --summary -M HEAD | grep rename >actual &&
+		cat >expected <<-\EOF &&
+		 rename old-one =3D> new-one (100%)
+		 rename old-two =3D> new-two (100%)
+		EOF
+		test_cmp expected actual &&
+
+		cat >correction <<-\EOF &&
+		old-one =3D> new-two
+		old-two =3D> new-one
+		EOF
+		git notes --ref=3Drename add -F correction HEAD &&
+		git show --summary -M --rename-notes=3Drename HEAD | grep rename >ac=
tual &&
+		cat >expected <<-\EOF &&
+		 rename old-two =3D> new-one (100%)
+		 rename old-one =3D> new-two (100%)
+		EOF
+		test_cmp expected actual
+	)
+'
+
 test_done
--=20
2.7.0.125.g9eec362
