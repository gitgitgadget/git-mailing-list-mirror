From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] diff: show file creation/deletion and type change in diffstat
Date: Wed, 16 Jan 2013 20:16:12 +0700
Message-ID: <1358342172-25581-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 16 14:16:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvSr2-00062r-9g
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 14:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757158Ab3APNQH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jan 2013 08:16:07 -0500
Received: from mail-da0-f44.google.com ([209.85.210.44]:40483 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757119Ab3APNQD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 08:16:03 -0500
Received: by mail-da0-f44.google.com with SMTP id z20so568237dae.17
        for <git@vger.kernel.org>; Wed, 16 Jan 2013 05:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=TVgdomthuHTRaaQd0QdMrdDZAsUV0Q5tjuCLmzspPak=;
        b=pX0uKXClfNmW6LuABvDsWm0fi0UZp1b+vV8Jux3DzyC0PfyyWtuk+QRGE23xQfQKUh
         Ym/NaVE8MNRFkrmqeiqCAqhPNmy4k9qMrD4ajL+3Db8rDTYCOCZzfKuK6X/ItKDbAc7Y
         Pfmvxlw0mFvswQD0ISE1S07tRIlL6gSJplow2jIv3UP5xrKBzN36H4aXlqmKZtKgAlrc
         1S3BGKityNqpSsw6IX+YoD1o76mFrLvpqQKHOnUYn+wIh3ucqvuMSL3fAHhHUyBbB6/V
         Ug3iRZGe8EcqszRdGhcP7Aw+TDtnI2jGyS0tskC827pje4jDnih8RMwjJqSB0CpCFygk
         MXtA==
X-Received: by 10.68.136.73 with SMTP id py9mr2702834pbb.43.1358342162202;
        Wed, 16 Jan 2013 05:16:02 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id i6sm5418252paw.19.2013.01.16.05.15.56
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Jan 2013 05:16:01 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 16 Jan 2013 20:16:13 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213752>

A short string is appended after the path name in diffstat:

- "(new)"     for new 0644 files
- "(new +x)"  for new 0755 files
- "(new +l)"  for new symlinks
- "(gone)"    for deleted files
- "(mode +x)" for files gaining executable permission
- "(mode -x)" for files losing executable permission

This shows most of the information from --summary, but in a more compac=
t
format. The only missing information is rewrite percentage. This makes
--stat a replacement for --summary in most cases. In a diff where a
lot of files are added/removed, not displaying --summary shortens the
stat significantly (e.g. a pull)

Another good point is the information is now all in one line. The user
does not have to match two lines from --stat and --summary of the same
file anymore.

The summary piece is short enough that it will not eat too much into
the diffstat estate.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 A resurrection of [1] but without colors.

 [1] http://thread.gmane.org/gmane.comp.version-control.git/207749

 diff.c                                             | 44 ++++++++++++++=
++++++--
 t/t3404-rebase-interactive.sh                      |  2 +-
 t/t3406-rebase-message.sh                          |  4 +-
 t/t4012-diff-binary.sh                             |  4 +-
 ...diff-tree_--cc_--patch-with-stat_--summary_side |  6 +--
 t/t4013/diff.diff-tree_--cc_--stat_--summary_side  |  6 +--
 ...pretty=3Doneline_--root_--patch-with-stat_initial |  6 +--
 .../diff.diff-tree_--pretty_--patch-with-stat_side |  6 +--
 ...-tree_--pretty_--root_--patch-with-stat_initial |  6 +--
 ...f-tree_--pretty_--root_--stat_--summary_initial |  6 +--
 .../diff.diff-tree_--pretty_--root_--stat_initial  |  6 +--
 ...diff.diff-tree_--root_--patch-with-stat_initial |  6 +--
 t/t4013/diff.diff-tree_-c_--stat_--summary_side    |  6 +--
 .../diff.diff_--patch-with-stat_-r_initial..side   |  6 +--
 t/t4013/diff.diff_--patch-with-stat_initial..side  |  6 +--
 t/t4013/diff.diff_--stat_initial..side             |  6 +--
 t/t4013/diff.diff_-r_--stat_initial..side          |  6 +--
 ..._--attach_--stdout_--suffix=3D.diff_initial..side |  6 +--
 ....format-patch_--attach_--stdout_initial..master | 16 ++++----
 ...format-patch_--attach_--stdout_initial..master^ | 10 ++---
 ...ff.format-patch_--attach_--stdout_initial..side |  6 +--
 ...nline_--stdout_--numbered-files_initial..master | 16 ++++----
 ...tdout_--subject-prefix=3DTESTCASE_initial..master | 16 ++++----
 ....format-patch_--inline_--stdout_initial..master | 16 ++++----
 ...format-patch_--inline_--stdout_initial..master^ | 10 ++---
 ...ormat-patch_--inline_--stdout_initial..master^^ |  6 +--
 ...ff.format-patch_--inline_--stdout_initial..side |  6 +--
 ...tch_--stdout_--cover-letter_-n_initial..master^ | 18 ++++-----
 ...at-patch_--stdout_--no-numbered_initial..master | 16 ++++----
 ...ormat-patch_--stdout_--numbered_initial..master | 16 ++++----
 t/t4013/diff.format-patch_--stdout_initial..master | 16 ++++----
 .../diff.format-patch_--stdout_initial..master^    | 10 ++---
 t/t4013/diff.format-patch_--stdout_initial..side   |  6 +--
 t/t4013/diff.log_--patch-with-stat_master          | 16 ++++----
 ..._--root_--cc_--patch-with-stat_--summary_master | 22 +++++------
 ...f.log_--root_--patch-with-stat_--summary_master | 22 +++++------
 t/t4013/diff.log_--root_--patch-with-stat_master   | 22 +++++------
 ...og_--root_-c_--patch-with-stat_--summary_master | 22 +++++------
 t/t4013/diff.show_--patch-with-stat_--summary_side |  6 +--
 t/t4013/diff.show_--patch-with-stat_side           |  6 +--
 t/t4013/diff.show_--stat_--summary_side            |  6 +--
 t/t4013/diff.show_--stat_side                      |  6 +--
 t/t4013/diff.whatchanged_--patch-with-stat_master  | 16 ++++----
 ..._--root_--cc_--patch-with-stat_--summary_master | 22 +++++------
 ...anged_--root_--patch-with-stat_--summary_master | 22 +++++------
 ...iff.whatchanged_--root_--patch-with-stat_master | 22 +++++------
 ...ed_--root_-c_--patch-with-stat_--summary_master | 22 +++++------
 t/t4045-diff-relative.sh                           |  2 +-
 t/t4049-diff-stat-count.sh                         |  4 +-
 t/t4052-stat-output.sh                             | 18 ++++-----
 t/t4202-log.sh                                     | 28 +++++++-------
 t/t7602-merge-octopus-many.sh                      | 12 +++---
 52 files changed, 327 insertions(+), 291 deletions(-)

diff --git a/diff.c b/diff.c
index 348f71b..7005628 100644
--- a/diff.c
+++ b/diff.c
@@ -1250,7 +1250,8 @@ static void fn_out_consume(void *priv, char *line=
, unsigned long len)
 	}
 }
=20
-static char *pprint_rename(const char *a, const char *b)
+static char *pprint_rename(const char *a, const char *b,
+			   const char *summary_word)
 {
 	const char *old =3D a;
 	const char *new =3D b;
@@ -1266,6 +1267,8 @@ static char *pprint_rename(const char *a, const c=
har *b)
 		quote_c_style(a, &name, NULL, 0);
 		strbuf_addstr(&name, " =3D> ");
 		quote_c_style(b, &name, NULL, 0);
+		if (summary_word)
+			strbuf_addf(&name, " (%s)", summary_word);
 		return strbuf_detach(&name, NULL);
 	}
=20
@@ -1314,6 +1317,8 @@ static char *pprint_rename(const char *a, const c=
har *b)
 		strbuf_addch(&name, '}');
 		strbuf_add(&name, a + len_a - sfx_length, sfx_length);
 	}
+	if (summary_word)
+		strbuf_addf(&name, " (%s)", summary_word);
 	return strbuf_detach(&name, NULL);
 }
=20
@@ -1324,6 +1329,7 @@ struct diffstat_t {
 		char *from_name;
 		char *name;
 		char *print_name;
+		char *summary_word;
 		unsigned is_unmerged:1;
 		unsigned is_binary:1;
 		unsigned is_renamed:1;
@@ -1407,14 +1413,17 @@ static void fill_print_name(struct diffstat_fil=
e *file)
=20
 	if (!file->is_renamed) {
 		struct strbuf buf =3D STRBUF_INIT;
-		if (quote_c_style(file->name, &buf, NULL, 0)) {
+		if (quote_c_style(file->name, &buf, NULL, 0) ||
+		    file->summary_word) {
+			strbuf_addf(&buf, " (%s)", file->summary_word);
 			pname =3D strbuf_detach(&buf, NULL);
 		} else {
 			pname =3D file->name;
 			strbuf_release(&buf);
 		}
 	} else {
-		pname =3D pprint_rename(file->from_name, file->name);
+		pname =3D pprint_rename(file->from_name, file->name,
+				      file->summary_word);
 	}
 	file->print_name =3D pname;
 }
@@ -2424,6 +2433,32 @@ static void builtin_diff(const char *name_a,
 	return;
 }
=20
+static char *get_summary_word(const struct diff_filepair *p, int is_re=
named)
+{
+	if (!is_renamed) {
+		if (p->status =3D=3D DIFF_STATUS_ADDED) {
+			if (S_ISLNK(p->two->mode))
+				return "new +l";
+			else if ((p->two->mode & 0777) =3D=3D 0755)
+				return "new +x";
+			else
+				return "new";
+		} else if (p->status =3D=3D DIFF_STATUS_DELETED)
+			return "gone";
+	}
+	if (S_ISLNK(p->one->mode) && !S_ISLNK(p->two->mode))
+		return "mode -l";
+	else if (!S_ISLNK(p->one->mode) && S_ISLNK(p->two->mode))
+		return "mode +l";
+	else if ((p->one->mode & 0777) =3D=3D 0644 &&
+		 (p->two->mode & 0777) =3D=3D 0755)
+		return "mode +x";
+	else if ((p->one->mode & 0777) =3D=3D 0755 &&
+		 (p->two->mode & 0777) =3D=3D 0644)
+		return "mode -x";
+	return NULL;
+}
+
 static void builtin_diffstat(const char *name_a, const char *name_b,
 			     struct diff_filespec *one,
 			     struct diff_filespec *two,
@@ -2443,6 +2478,7 @@ static void builtin_diffstat(const char *name_a, =
const char *name_b,
=20
 	data =3D diffstat_add(diffstat, name_a, name_b);
 	data->is_interesting =3D p->status !=3D DIFF_STATUS_UNKNOWN;
+	data->summary_word =3D get_summary_word(p, data->is_renamed);
=20
 	if (!one || !two) {
 		data->is_unmerged =3D 1;
@@ -4165,7 +4201,7 @@ static void show_mode_change(FILE *file, struct d=
iff_filepair *p, int show_name,
 static void show_rename_copy(FILE *file, const char *renamecopy, struc=
t diff_filepair *p,
 			const char *line_prefix)
 {
-	char *names =3D pprint_rename(p->one->path, p->two->path);
+	char *names =3D pprint_rename(p->one->path, p->two->path, NULL);
=20
 	fprintf(file, " %s %s (%d%%)\n", renamecopy, names, similarity_index(=
p));
 	free(names);
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index 8462be1..9124497 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -329,7 +329,7 @@ test_expect_success 'verbose flag is heeded, even a=
fter --continue' '
 	echo resolved > file1 &&
 	git add file1 &&
 	git rebase --continue > output &&
-	grep "^ file1 | 2 +-$" output
+	grep "^ file1 * | 2 +-$" output
 '
=20
 test_expect_success 'multi-squash only fires up editor once' '
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index e6a9a0d..ff33403 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -45,14 +45,14 @@ test_expect_success 'rebase -m' '
 test_expect_success 'rebase --stat' '
 	git reset --hard start &&
         git rebase --stat master >diffstat.txt &&
-        grep "^ fileX |  *1 +$" diffstat.txt
+        grep "^ fileX (new) |  *1 +$" diffstat.txt
 '
=20
 test_expect_success 'rebase w/config rebase.stat' '
 	git reset --hard start &&
         git config rebase.stat true &&
         git rebase master >diffstat.txt &&
-        grep "^ fileX |  *1 +$" diffstat.txt
+        grep "^ fileX (new) |  *1 +$" diffstat.txt
 '
=20
 test_expect_success 'rebase -n overrides config rebase.stat config' '
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 1215ae5..5aff829 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -114,8 +114,8 @@ test_expect_success 'diff --no-index with binary cr=
eation' '
 '
=20
 cat >expect <<EOF
- binfile  |   Bin 0 -> 1026 bytes
- textfile | 10000 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
+ binfile (new)  |   Bin 0 -> 1026 bytes
+ textfile (new) | 10000 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
 EOF
=20
 test_expect_success 'diff --stat with binary files and big change coun=
t' '
diff --git a/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_si=
de b/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_side
index cec33fa..ca5512d 100644
--- a/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_side
+++ b/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_side
@@ -1,8 +1,8 @@
 $ git diff-tree --cc --patch-with-stat --summary side
 c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.diff-tree_--cc_--stat_--summary_side b/t/t401=
3/diff.diff-tree_--cc_--stat_--summary_side
index 12b2eee..1e5efa5 100644
--- a/t/t4013/diff.diff-tree_--cc_--stat_--summary_side
+++ b/t/t4013/diff.diff-tree_--cc_--stat_--summary_side
@@ -1,8 +1,8 @@
 $ git diff-tree --cc --stat --summary side
 c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
 $
diff --git a/t/t4013/diff.diff-tree_--pretty=3Doneline_--root_--patch-w=
ith-stat_initial b/t/t4013/diff.diff-tree_--pretty=3Doneline_--root_--p=
atch-with-stat_initial
index 817ed06..7131b96 100644
--- a/t/t4013/diff.diff-tree_--pretty=3Doneline_--root_--patch-with-sta=
t_initial
+++ b/t/t4013/diff.diff-tree_--pretty=3Doneline_--root_--patch-with-sta=
t_initial
@@ -1,8 +1,8 @@
 $ git diff-tree --pretty=3Doneline --root --patch-with-stat initial
 444ac553ac7612cc88969031b02b3767fb8a353a Initial
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 +++
+ dir/sub (new) | 2 ++
+ file0 (new)   | 3 +++
+ file2 (new)   | 3 +++
  3 files changed, 8 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.diff-tree_--pretty_--patch-with-stat_side b/t=
/t4013/diff.diff-tree_--pretty_--patch-with-stat_side
index fe3f6b7..56c14ae 100644
--- a/t/t4013/diff.diff-tree_--pretty_--patch-with-stat_side
+++ b/t/t4013/diff.diff-tree_--pretty_--patch-with-stat_side
@@ -5,9 +5,9 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.diff-tree_--pretty_--root_--patch-with-stat_i=
nitial b/t/t4013/diff.diff-tree_--pretty_--root_--patch-with-stat_initi=
al
index 06eb77e..db0744e 100644
--- a/t/t4013/diff.diff-tree_--pretty_--root_--patch-with-stat_initial
+++ b/t/t4013/diff.diff-tree_--pretty_--root_--patch-with-stat_initial
@@ -5,9 +5,9 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
=20
     Initial
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 +++
+ dir/sub (new) | 2 ++
+ file0 (new)   | 3 +++
+ file2 (new)   | 3 +++
  3 files changed, 8 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.diff-tree_--pretty_--root_--stat_--summary_in=
itial b/t/t4013/diff.diff-tree_--pretty_--root_--stat_--summary_initial
index 680eab5..1d90882 100644
--- a/t/t4013/diff.diff-tree_--pretty_--root_--stat_--summary_initial
+++ b/t/t4013/diff.diff-tree_--pretty_--root_--stat_--summary_initial
@@ -5,9 +5,9 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
=20
     Initial
=20
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 +++
+ dir/sub (new) | 2 ++
+ file0 (new)   | 3 +++
+ file2 (new)   | 3 +++
  3 files changed, 8 insertions(+)
  create mode 100644 dir/sub
  create mode 100644 file0
diff --git a/t/t4013/diff.diff-tree_--pretty_--root_--stat_initial b/t/=
t4013/diff.diff-tree_--pretty_--root_--stat_initial
index 9722d1b..98e71a3 100644
--- a/t/t4013/diff.diff-tree_--pretty_--root_--stat_initial
+++ b/t/t4013/diff.diff-tree_--pretty_--root_--stat_initial
@@ -5,8 +5,8 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
=20
     Initial
=20
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 +++
+ dir/sub (new) | 2 ++
+ file0 (new)   | 3 +++
+ file2 (new)   | 3 +++
  3 files changed, 8 insertions(+)
 $
diff --git a/t/t4013/diff.diff-tree_--root_--patch-with-stat_initial b/=
t/t4013/diff.diff-tree_--root_--patch-with-stat_initial
index ad69ffe..23470f2 100644
--- a/t/t4013/diff.diff-tree_--root_--patch-with-stat_initial
+++ b/t/t4013/diff.diff-tree_--root_--patch-with-stat_initial
@@ -1,8 +1,8 @@
 $ git diff-tree --root --patch-with-stat initial
 444ac553ac7612cc88969031b02b3767fb8a353a
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 +++
+ dir/sub (new) | 2 ++
+ file0 (new)   | 3 +++
+ file2 (new)   | 3 +++
  3 files changed, 8 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.diff-tree_-c_--stat_--summary_side b/t/t4013/=
diff.diff-tree_-c_--stat_--summary_side
index e8dc12b..610e74a 100644
--- a/t/t4013/diff.diff-tree_-c_--stat_--summary_side
+++ b/t/t4013/diff.diff-tree_-c_--stat_--summary_side
@@ -1,8 +1,8 @@
 $ git diff-tree -c --stat --summary side
 c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
 $
diff --git a/t/t4013/diff.diff_--patch-with-stat_-r_initial..side b/t/t=
4013/diff.diff_--patch-with-stat_-r_initial..side
index be8d1ea..ca39dcc 100644
--- a/t/t4013/diff.diff_--patch-with-stat_-r_initial..side
+++ b/t/t4013/diff.diff_--patch-with-stat_-r_initial..side
@@ -1,7 +1,7 @@
 $ git diff --patch-with-stat -r initial..side
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.diff_--patch-with-stat_initial..side b/t/t401=
3/diff.diff_--patch-with-stat_initial..side
index 5424e6d..987bd17 100644
--- a/t/t4013/diff.diff_--patch-with-stat_initial..side
+++ b/t/t4013/diff.diff_--patch-with-stat_initial..side
@@ -1,7 +1,7 @@
 $ git diff --patch-with-stat initial..side
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.diff_--stat_initial..side b/t/t4013/diff.diff=
_--stat_initial..side
index b7741e2..42d216a 100644
--- a/t/t4013/diff.diff_--stat_initial..side
+++ b/t/t4013/diff.diff_--stat_initial..side
@@ -1,6 +1,6 @@
 $ git diff --stat initial..side
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
 $
diff --git a/t/t4013/diff.diff_-r_--stat_initial..side b/t/t4013/diff.d=
iff_-r_--stat_initial..side
index 5d514f5..ddf55fd 100644
--- a/t/t4013/diff.diff_-r_--stat_initial..side
+++ b/t/t4013/diff.diff_-r_--stat_initial..side
@@ -1,6 +1,6 @@
 $ git diff -r --stat initial..side
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
 $
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_--suffix=3D.di=
ff_initial..side b/t/t4013/diff.format-patch_--attach_--stdout_--suffix=
=3D.diff_initial..side
index 547ca06..459d3e7 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_--suffix=3D.diff_init=
ial..side
+++ b/t/t4013/diff.format-patch_--attach_--stdout_--suffix=3D.diff_init=
ial..side
@@ -12,9 +12,9 @@ Content-Type: text/plain; charset=3DUTF-8; format=3Df=
ixed
 Content-Transfer-Encoding: 8bit
=20
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..maste=
r b/t/t4013/diff.format-patch_--attach_--stdout_initial..master
index 52fedc1..080a952 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..master
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..master
@@ -14,9 +14,9 @@ Content-Transfer-Encoding: 8bit
=20
 This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -73,8 +73,8 @@ Content-Type: text/plain; charset=3DUTF-8; format=3Df=
ixed
 Content-Transfer-Encoding: 8bit
=20
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
@@ -121,9 +121,9 @@ Content-Type: text/plain; charset=3DUTF-8; format=3D=
fixed
 Content-Transfer-Encoding: 8bit
=20
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..maste=
r^ b/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
index 1c3cde2..b97ed20 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
@@ -14,9 +14,9 @@ Content-Transfer-Encoding: 8bit
=20
 This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -73,8 +73,8 @@ Content-Type: text/plain; charset=3DUTF-8; format=3Df=
ixed
 Content-Transfer-Encoding: 8bit
=20
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..side =
b/t/t4013/diff.format-patch_--attach_--stdout_initial..side
index 4717bd8..467fafa 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..side
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..side
@@ -12,9 +12,9 @@ Content-Type: text/plain; charset=3DUTF-8; format=3Df=
ixed
 Content-Transfer-Encoding: 8bit
=20
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_--numbered-fil=
es_initial..master b/t/t4013/diff.format-patch_--inline_--stdout_--numb=
ered-files_initial..master
index 02c4db7..eae31b0 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_init=
ial..master
+++ b/t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_init=
ial..master
@@ -14,9 +14,9 @@ Content-Transfer-Encoding: 8bit
=20
 This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -73,8 +73,8 @@ Content-Type: text/plain; charset=3DUTF-8; format=3Df=
ixed
 Content-Transfer-Encoding: 8bit
=20
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
@@ -121,9 +121,9 @@ Content-Type: text/plain; charset=3DUTF-8; format=3D=
fixed
 Content-Transfer-Encoding: 8bit
=20
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_--subject-pref=
ix=3DTESTCASE_initial..master b/t/t4013/diff.format-patch_--inline_--st=
dout_--subject-prefix=3DTESTCASE_initial..master
index c7677c5..a1c3dfa 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=3DTE=
STCASE_initial..master
+++ b/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=3DTE=
STCASE_initial..master
@@ -14,9 +14,9 @@ Content-Transfer-Encoding: 8bit
=20
 This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -73,8 +73,8 @@ Content-Type: text/plain; charset=3DUTF-8; format=3Df=
ixed
 Content-Transfer-Encoding: 8bit
=20
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
@@ -121,9 +121,9 @@ Content-Type: text/plain; charset=3DUTF-8; format=3D=
fixed
 Content-Transfer-Encoding: 8bit
=20
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..maste=
r b/t/t4013/diff.format-patch_--inline_--stdout_initial..master
index 5b3e34e..dab61d6 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master
@@ -14,9 +14,9 @@ Content-Transfer-Encoding: 8bit
=20
 This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -73,8 +73,8 @@ Content-Type: text/plain; charset=3DUTF-8; format=3Df=
ixed
 Content-Transfer-Encoding: 8bit
=20
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
@@ -121,9 +121,9 @@ Content-Type: text/plain; charset=3DUTF-8; format=3D=
fixed
 Content-Transfer-Encoding: 8bit
=20
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..maste=
r^ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
index d13f8a8..f8eca66 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
@@ -14,9 +14,9 @@ Content-Transfer-Encoding: 8bit
=20
 This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -73,8 +73,8 @@ Content-Type: text/plain; charset=3DUTF-8; format=3Df=
ixed
 Content-Transfer-Encoding: 8bit
=20
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..maste=
r^^ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^
index caec553..5e7c68e 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^
@@ -14,9 +14,9 @@ Content-Transfer-Encoding: 8bit
=20
 This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..side =
b/t/t4013/diff.format-patch_--inline_--stdout_initial..side
index d3a6762..be9f3da 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..side
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..side
@@ -12,9 +12,9 @@ Content-Type: text/plain; charset=3DUTF-8; format=3Df=
ixed
 Content-Transfer-Encoding: 8bit
=20
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initi=
al..master^ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_init=
ial..master^
index 244d964..8abfae6 100644
--- a/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..mas=
ter^
+++ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..mas=
ter^
@@ -10,10 +10,10 @@ A U Thor (2):
   Second
   Third
=20
- dir/sub | 4 ++++
- file0   | 3 +++
- file1   | 3 +++
- file2   | 3 ---
+ dir/sub      | 4 ++++
+ file0        | 3 +++
+ file1 (new)  | 3 +++
+ file2 (gone) | 3 ---
  4 files changed, 10 insertions(+), 3 deletions(-)
  create mode 100644 file1
  delete mode 100644 file2
@@ -28,9 +28,9 @@ Subject: [DIFFERENT_PREFIX 1/2] Second
=20
 This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -73,8 +73,8 @@ Date: Mon, 26 Jun 2006 00:02:00 +0000
 Subject: [DIFFERENT_PREFIX 2/2] Third
=20
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
diff --git a/t/t4013/diff.format-patch_--stdout_--no-numbered_initial..=
master b/t/t4013/diff.format-patch_--stdout_--no-numbered_initial..mast=
er
index bfc287a..ac92c50 100644
--- a/t/t4013/diff.format-patch_--stdout_--no-numbered_initial..master
+++ b/t/t4013/diff.format-patch_--stdout_--no-numbered_initial..master
@@ -6,9 +6,9 @@ Subject: [PATCH] Second
=20
 This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -51,8 +51,8 @@ Date: Mon, 26 Jun 2006 00:02:00 +0000
 Subject: [PATCH] Third
=20
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
@@ -85,9 +85,9 @@ Date: Mon, 26 Jun 2006 00:03:00 +0000
 Subject: [PATCH] Side
=20
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.format-patch_--stdout_--numbered_initial..mas=
ter b/t/t4013/diff.format-patch_--stdout_--numbered_initial..master
index 568f6f5..1229ef1 100644
--- a/t/t4013/diff.format-patch_--stdout_--numbered_initial..master
+++ b/t/t4013/diff.format-patch_--stdout_--numbered_initial..master
@@ -6,9 +6,9 @@ Subject: [PATCH 1/3] Second
=20
 This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -51,8 +51,8 @@ Date: Mon, 26 Jun 2006 00:02:00 +0000
 Subject: [PATCH 2/3] Third
=20
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
@@ -85,9 +85,9 @@ Date: Mon, 26 Jun 2006 00:03:00 +0000
 Subject: [PATCH 3/3] Side
=20
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.format-patch_--stdout_initial..master b/t/t40=
13/diff.format-patch_--stdout_initial..master
index 5f0352f..f6b80e9 100644
--- a/t/t4013/diff.format-patch_--stdout_initial..master
+++ b/t/t4013/diff.format-patch_--stdout_initial..master
@@ -6,9 +6,9 @@ Subject: [PATCH 1/3] Second
=20
 This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -51,8 +51,8 @@ Date: Mon, 26 Jun 2006 00:02:00 +0000
 Subject: [PATCH 2/3] Third
=20
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
@@ -85,9 +85,9 @@ Date: Mon, 26 Jun 2006 00:03:00 +0000
 Subject: [PATCH 3/3] Side
=20
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.format-patch_--stdout_initial..master^ b/t/t4=
013/diff.format-patch_--stdout_initial..master^
index 2ae454d..6995728 100644
--- a/t/t4013/diff.format-patch_--stdout_initial..master^
+++ b/t/t4013/diff.format-patch_--stdout_initial..master^
@@ -6,9 +6,9 @@ Subject: [PATCH 1/2] Second
=20
 This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -51,8 +51,8 @@ Date: Mon, 26 Jun 2006 00:02:00 +0000
 Subject: [PATCH 2/2] Third
=20
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
diff --git a/t/t4013/diff.format-patch_--stdout_initial..side b/t/t4013=
/diff.format-patch_--stdout_initial..side
index a7d52fb..d8d9a1d 100644
--- a/t/t4013/diff.format-patch_--stdout_initial..side
+++ b/t/t4013/diff.format-patch_--stdout_initial..side
@@ -5,9 +5,9 @@ Date: Mon, 26 Jun 2006 00:03:00 +0000
 Subject: [PATCH] Side
=20
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.log_--patch-with-stat_master b/t/t4013/diff.l=
og_--patch-with-stat_master
index ae425c4..fd768ff 100644
--- a/t/t4013/diff.log_--patch-with-stat_master
+++ b/t/t4013/diff.log_--patch-with-stat_master
@@ -12,9 +12,9 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
@@ -54,8 +54,8 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
=20
     Third
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
@@ -86,9 +86,9 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
    =20
     This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_m=
aster b/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
index 0fc1e8c..372f0b3 100644
--- a/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
@@ -44,9 +44,9 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
@@ -87,8 +87,8 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
=20
     Third
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
@@ -120,9 +120,9 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
    =20
     This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -162,9 +162,9 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
=20
     Initial
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 +++
+ dir/sub (new) | 2 ++
+ file0 (new)   | 3 +++
+ file2 (new)   | 3 +++
  3 files changed, 8 insertions(+)
  create mode 100644 dir/sub
  create mode 100644 file0
diff --git a/t/t4013/diff.log_--root_--patch-with-stat_--summary_master=
 b/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
index dffc09d..2c705a8 100644
--- a/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
@@ -12,9 +12,9 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
@@ -55,8 +55,8 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
=20
     Third
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
@@ -88,9 +88,9 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
    =20
     This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -130,9 +130,9 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
=20
     Initial
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 +++
+ dir/sub (new) | 2 ++
+ file0 (new)   | 3 +++
+ file2 (new)   | 3 +++
  3 files changed, 8 insertions(+)
  create mode 100644 dir/sub
  create mode 100644 file0
diff --git a/t/t4013/diff.log_--root_--patch-with-stat_master b/t/t4013=
/diff.log_--root_--patch-with-stat_master
index 55aa980..a51f794 100644
--- a/t/t4013/diff.log_--root_--patch-with-stat_master
+++ b/t/t4013/diff.log_--root_--patch-with-stat_master
@@ -12,9 +12,9 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
@@ -54,8 +54,8 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
=20
     Third
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
@@ -86,9 +86,9 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
    =20
     This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
=20
 diff --git a/dir/sub b/dir/sub
@@ -127,9 +127,9 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
=20
     Initial
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 +++
+ dir/sub (new) | 2 ++
+ file0 (new)   | 3 +++
+ file2 (new)   | 3 +++
  3 files changed, 8 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_mas=
ter b/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
index 019d85f..2588563 100644
--- a/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
@@ -44,9 +44,9 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
@@ -87,8 +87,8 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
=20
     Third
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
@@ -120,9 +120,9 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
    =20
     This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -162,9 +162,9 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
=20
     Initial
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 +++
+ dir/sub (new) | 2 ++
+ file0 (new)   | 3 +++
+ file2 (new)   | 3 +++
  3 files changed, 8 insertions(+)
  create mode 100644 dir/sub
  create mode 100644 file0
diff --git a/t/t4013/diff.show_--patch-with-stat_--summary_side b/t/t40=
13/diff.show_--patch-with-stat_--summary_side
index 95a474e..4c83862 100644
--- a/t/t4013/diff.show_--patch-with-stat_--summary_side
+++ b/t/t4013/diff.show_--patch-with-stat_--summary_side
@@ -5,9 +5,9 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
diff --git a/t/t4013/diff.show_--patch-with-stat_side b/t/t4013/diff.sh=
ow_--patch-with-stat_side
index 974e99b..d021de9 100644
--- a/t/t4013/diff.show_--patch-with-stat_side
+++ b/t/t4013/diff.show_--patch-with-stat_side
@@ -5,9 +5,9 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.show_--stat_--summary_side b/t/t4013/diff.sho=
w_--stat_--summary_side
index a71492f..8978cfa 100644
--- a/t/t4013/diff.show_--stat_--summary_side
+++ b/t/t4013/diff.show_--stat_--summary_side
@@ -5,9 +5,9 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
=20
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
 $
diff --git a/t/t4013/diff.show_--stat_side b/t/t4013/diff.show_--stat_s=
ide
index 9be7124..60c2bb1 100644
--- a/t/t4013/diff.show_--stat_side
+++ b/t/t4013/diff.show_--stat_side
@@ -5,8 +5,8 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
=20
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
 $
diff --git a/t/t4013/diff.whatchanged_--patch-with-stat_master b/t/t401=
3/diff.whatchanged_--patch-with-stat_master
index 1ac431b..298f1d9 100644
--- a/t/t4013/diff.whatchanged_--patch-with-stat_master
+++ b/t/t4013/diff.whatchanged_--patch-with-stat_master
@@ -5,9 +5,9 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
@@ -47,8 +47,8 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
=20
     Third
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
@@ -79,9 +79,9 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
    =20
     This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--s=
ummary_master b/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_=
--summary_master
index 30aae78..70f4da6 100644
--- a/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_=
master
+++ b/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_=
master
@@ -44,9 +44,9 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
@@ -87,8 +87,8 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
=20
     Third
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
@@ -120,9 +120,9 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
    =20
     This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -162,9 +162,9 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
=20
     Initial
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 +++
+ dir/sub (new) | 2 ++
+ file0 (new)   | 3 +++
+ file2 (new)   | 3 +++
  3 files changed, 8 insertions(+)
  create mode 100644 dir/sub
  create mode 100644 file0
diff --git a/t/t4013/diff.whatchanged_--root_--patch-with-stat_--summar=
y_master b/t/t4013/diff.whatchanged_--root_--patch-with-stat_--summary_=
master
index db90e51..6065050 100644
--- a/t/t4013/diff.whatchanged_--root_--patch-with-stat_--summary_maste=
r
+++ b/t/t4013/diff.whatchanged_--root_--patch-with-stat_--summary_maste=
r
@@ -5,9 +5,9 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
@@ -48,8 +48,8 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
=20
     Third
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
@@ -81,9 +81,9 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
    =20
     This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -123,9 +123,9 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
=20
     Initial
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 +++
+ dir/sub (new) | 2 ++
+ file0 (new)   | 3 +++
+ file2 (new)   | 3 +++
  3 files changed, 8 insertions(+)
  create mode 100644 dir/sub
  create mode 100644 file0
diff --git a/t/t4013/diff.whatchanged_--root_--patch-with-stat_master b=
/t/t4013/diff.whatchanged_--root_--patch-with-stat_master
index 9a6cc92..de03ba3 100644
--- a/t/t4013/diff.whatchanged_--root_--patch-with-stat_master
+++ b/t/t4013/diff.whatchanged_--root_--patch-with-stat_master
@@ -5,9 +5,9 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
@@ -47,8 +47,8 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
=20
     Third
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
@@ -79,9 +79,9 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
    =20
     This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
=20
 diff --git a/dir/sub b/dir/sub
@@ -120,9 +120,9 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
=20
     Initial
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 +++
+ dir/sub (new) | 2 ++
+ file0 (new)   | 3 +++
+ file2 (new)   | 3 +++
  3 files changed, 8 insertions(+)
=20
 diff --git a/dir/sub b/dir/sub
diff --git a/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--sum=
mary_master b/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--su=
mmary_master
index d1d32bd..772cfca 100644
--- a/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_ma=
ster
+++ b/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_ma=
ster
@@ -44,9 +44,9 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
=20
     Side
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
  create mode 100644 file3
=20
@@ -87,8 +87,8 @@ Date:   Mon Jun 26 00:02:00 2006 +0000
=20
     Third
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
  create mode 100644 file1
=20
@@ -120,9 +120,9 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
    =20
     This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
  delete mode 100644 file2
=20
@@ -162,9 +162,9 @@ Date:   Mon Jun 26 00:00:00 2006 +0000
=20
     Initial
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 +++
+ dir/sub (new) | 2 ++
+ file0 (new)   | 3 +++
+ file2 (new)   | 3 +++
  3 files changed, 8 insertions(+)
  create mode 100644 dir/sub
  create mode 100644 file0
diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
index 3950f50..e0f274d 100755
--- a/t/t4045-diff-relative.sh
+++ b/t/t4045-diff-relative.sh
@@ -44,7 +44,7 @@ test_expect_success "--numstat $*" "
 check_stat() {
 expect=3D$1; shift
 cat >expected <<EOF
- $expect | 1 +
+ $expect (new) | 1 +
  1 file changed, 1 insertion(+)
 EOF
 test_expect_success "--stat $*" "
diff --git a/t/t4049-diff-stat-count.sh b/t/t4049-diff-stat-count.sh
index 5b594e8..55bd81e 100755
--- a/t/t4049-diff-stat-count.sh
+++ b/t/t4049-diff-stat-count.sh
@@ -19,8 +19,8 @@ test_expect_success 'mode-only change show as a 0-lin=
e change' '
 	echo a >a &&
 	echo c >c &&
 	cat >expect <<-\EOF
-	 a | 1 +
-	 b | 0
+	 a           | 1 +
+	 b (mode +x) | 0
 	 ...
 	 4 files changed, 2 insertions(+)
 	EOF
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index b68afef..b0a5340 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -223,10 +223,10 @@ test_expect_success 'preparation for long filenam=
e tests' '
 '
=20
 cat >expect <<'EOF'
- ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++++++
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaa (new) | 1000 ++++++++++++
 EOF
 cat >expect-graph <<'EOF'
-|  ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++++++
+|  ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaa (new) | 1000 ++++++++++++
 EOF
 while read cmd args
 do
@@ -251,16 +251,16 @@ log -1 --stat
 EOF
=20
 cat >expect80 <<'EOF'
- ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++++=
+++++++++
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa (new) | 1000 +++++++++++=
+++++++++
 EOF
 cat >expect80-graph <<'EOF'
-|  ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++=
+++++++++++
+|  ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa (new) | 1000 +++++++++=
+++++++++++
 EOF
 cat >expect200 <<'EOF'
- aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+ aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa (new) | 1000 ++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 EOF
 cat >expect200-graph <<'EOF'
-|  aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+|  aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa (new) | 1000 ++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 EOF
 while read verb expect cmd args
 do
@@ -285,10 +285,10 @@ respects expect200 log -1 --stat
 EOF
=20
 cat >expect1 <<'EOF'
- ...aaaaaaa | 1000 ++++++
+ ...a (new) | 1000 ++++++
 EOF
 cat >expect1-graph <<'EOF'
-|  ...aaaaaaa | 1000 ++++++
+|  ...a (new) | 1000 ++++++
 EOF
 while read verb expect cmd args
 do
@@ -325,7 +325,7 @@ test_expect_success 'merge --stat respects COLUMNS =
(big change)' '
 '
=20
 cat >expect <<'EOF'
- aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++++=
+++++++++++++++++++++++++++++
+ aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa (new) | 1000 ++++=
+++++++++++++++++++++++++++++
 EOF
 test_expect_success 'merge --stat respects COLUMNS (long filename)' '
 	COLUMNS=3D100 git merge --stat --no-ff master >output &&
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index fa686b8..26d2057 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -554,7 +554,7 @@ cat >expect <<\EOF
 | |
 | |     reach
 | | ---
-| |  reach.t | 1 +
+| |  reach.t (new) | 1 +
 | |  1 file changed, 1 insertion(+)
 | |
 | | diff --git a/reach.t b/reach.t
@@ -577,7 +577,7 @@ cat >expect <<\EOF
 | | |
 | | |       octopus-b
 | | |   ---
-| | |    octopus-b.t | 1 +
+| | |    octopus-b.t (new) | 1 +
 | | |    1 file changed, 1 insertion(+)
 | | |
 | | |   diff --git a/octopus-b.t b/octopus-b.t
@@ -593,7 +593,7 @@ cat >expect <<\EOF
 | |
 | |       octopus-a
 | |   ---
-| |    octopus-a.t | 1 +
+| |    octopus-a.t (new) | 1 +
 | |    1 file changed, 1 insertion(+)
 | |
 | |   diff --git a/octopus-a.t b/octopus-a.t
@@ -609,7 +609,7 @@ cat >expect <<\EOF
 |
 |       seventh
 |   ---
-|    seventh.t | 1 +
+|    seventh.t (new) | 1 +
 |    1 file changed, 1 insertion(+)
 |
 |   diff --git a/seventh.t b/seventh.t
@@ -643,7 +643,7 @@ cat >expect <<\EOF
 | | | |
 | | | |     tangle-a
 | | | | ---
-| | | |  tangle-a | 1 +
+| | | |  tangle-a (new) | 1 +
 | | | |  1 file changed, 1 insertion(+)
 | | | |
 | | | | diff --git a/tangle-a b/tangle-a
@@ -665,7 +665,7 @@ cat >expect <<\EOF
 | |/| |
 | | | |       side-2
 | | | |   ---
-| | | |    2 | 1 +
+| | | |    2 (new) | 1 +
 | | | |    1 file changed, 1 insertion(+)
 | | | |
 | | | |   diff --git a/2 b/2
@@ -681,7 +681,7 @@ cat >expect <<\EOF
 | | | |
 | | | |     side-1
 | | | | ---
-| | | |  1 | 1 +
+| | | |  1 (new) | 1 +
 | | | |  1 file changed, 1 insertion(+)
 | | | |
 | | | | diff --git a/1 b/1
@@ -697,7 +697,7 @@ cat >expect <<\EOF
 | | | |
 | | | |     Second
 | | | | ---
-| | | |  one | 1 +
+| | | |  one (new) | 1 +
 | | | |  1 file changed, 1 insertion(+)
 | | | |
 | | | | diff --git a/one b/one
@@ -713,7 +713,7 @@ cat >expect <<\EOF
 |/| |
 | | |       sixth
 | | |   ---
-| | |    a/two | 1 -
+| | |    a/two (gone) | 1 -
 | | |    1 file changed, 1 deletion(-)
 | | |
 | | |   diff --git a/a/two b/a/two
@@ -729,7 +729,7 @@ cat >expect <<\EOF
 | | |
 | | |     fifth
 | | | ---
-| | |  a/two | 1 +
+| | |  a/two (new) | 1 +
 | | |  1 file changed, 1 insertion(+)
 | | |
 | | | diff --git a/a/two b/a/two
@@ -745,7 +745,7 @@ cat >expect <<\EOF
 | |
 | |       fourth
 | |   ---
-| |    ein | 1 +
+| |    ein (new) | 1 +
 | |    1 file changed, 1 insertion(+)
 | |
 | |   diff --git a/ein b/ein
@@ -761,8 +761,8 @@ cat >expect <<\EOF
 |
 |       third
 |   ---
-|    ichi | 1 +
-|    one  | 1 -
+|    ichi (new) | 1 +
+|    one (gone) | 1 -
 |    2 files changed, 1 insertion(+), 1 deletion(-)
 |
 |   diff --git a/ichi b/ichi
@@ -801,7 +801,7 @@ cat >expect <<\EOF
=20
       initial
   ---
-   one | 1 +
+   one (new) | 1 +
    1 file changed, 1 insertion(+)
=20
   diff --git a/one b/one
diff --git a/t/t7602-merge-octopus-many.sh b/t/t7602-merge-octopus-many=
=2Esh
index 955f09f..d383b50 100755
--- a/t/t7602-merge-octopus-many.sh
+++ b/t/t7602-merge-octopus-many.sh
@@ -54,9 +54,9 @@ Trying simple merge with c2
 Trying simple merge with c3
 Trying simple merge with c4
 Merge made by the 'octopus' strategy.
- c2.c | 1 +
- c3.c | 1 +
- c4.c | 1 +
+ c2.c (new) | 1 +
+ c3.c (new) | 1 +
+ c4.c (new) | 1 +
  3 files changed, 3 insertions(+)
  create mode 100644 c2.c
  create mode 100644 c3.c
@@ -71,7 +71,7 @@ test_expect_success 'merge output uses pretty names' =
'
=20
 cat >expected <<\EOF
 Merge made by the 'recursive' strategy.
- c5.c | 1 +
+ c5.c (new) | 1 +
  1 file changed, 1 insertion(+)
  create mode 100644 c5.c
 EOF
@@ -85,8 +85,8 @@ cat >expected <<\EOF
 Fast-forwarding to: c1
 Trying simple merge with c2
 Merge made by the 'octopus' strategy.
- c1.c | 1 +
- c2.c | 1 +
+ c1.c (new) | 1 +
+ c2.c (new) | 1 +
  2 files changed, 2 insertions(+)
  create mode 100644 c1.c
  create mode 100644 c2.c
--=20
1.8.0.rc2.23.g1fb49df
