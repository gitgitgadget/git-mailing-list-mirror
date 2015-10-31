From: =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: [PATCH v2] ls-files: Add eol diagnostics
Date: Sat, 31 Oct 2015 11:12:05 +0100
Message-ID: <52B3B0AC-037A-4872-9E0E-CDF6BE7A9695@web.de>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 31 11:12:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsT9e-0005NG-Be
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 11:12:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858AbbJaKMy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Oct 2015 06:12:54 -0400
Received: from mout.web.de ([212.227.17.11]:60031 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752542AbbJaKMw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Oct 2015 06:12:52 -0400
Received: from [192.168.39.102] ([93.222.45.164]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LzbDC-1aWZH93Sq2-014mEL; Sat, 31 Oct 2015 11:12:50
 +0100
X-Mailer: Apple Mail (2.1085)
X-Provags-ID: V03:K0:bcwzSLAG9wNm+niPWCKwABJmsLhh1rEd2cP5+FvBsa2V2GEvGHM
 zY1SQpG1MEOkxsvEu7m3Sg96OBr1GKZM4BN2iX8ZG1/0mJ4L4ZPtn2e8vY1aA8qF2G1FtmV
 7Aeuo9f0HO7x4OIgYJreZ9OYzpPbWeeZlGrF2oibzPtp8RsdWDzODcYGSzFJ9/P/hpeUIF1
 7pmHoTJWhQEmOuYyCNLqQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hlFBMlnbDqs=:jE/AD2qIi4uUOEGDLRfI2P
 j1pgYxwdhAJZRT/q2KFYqvjailDS+dl6O/Rz2otYfwETUr+uMRAk6e5QoJjfdUNpTCeu2nigv
 q2zhlu10LzCE1q2kvANHvELmMzm0DEZLJ8yiLsHJe7OBeh1L1rlscLMRFmWqHnzaQ/FXSmqey
 zu94dkCapHr7xEMfRhE+PXPPiXmPH4TjfHZ+ewCz/kZngVn9rBIAYfNRhrDa0fzTOEX2j3Mra
 NjCg7kru3p+L1IBv4qo89TQW0Hv6twnCNkVPOev8mfFwvzfjmop7EqhVBeaOjbtlJFEfLPU1+
 SHaY2oqH5fK5PGjFCgeSDb/Rph3UlBJfB7KJu1YJAyj4TpAwR3wKEqWZS1G1S9yprgLanLK6m
 Qqe/aI4E2AshcB06xN6incI0Vp6bVB267rpT4GBqNZVyKZTY6zCWwkcmDb078qvxwzUy52CI1
 oseTw2sOFuzmORJ66J67RzvkQMq71jSUwOCgsjxPrSfIDKkAB2zC3f/yICOy7nFkYniHVn0v1
 NnIxW3CooMczDXPtNEx3AhgvYIx9uTdEZnTi7oBAyLvUuUg1fohwuuMVf4pZI8q7dByTdK7nj
 7LJWD8we2p5D5gH0GKwinm4qQXvBkCQd2oIDzx6v0rJhY5hGbh0+EsUmo0gGPFzkmJ3E29YJ8
 CoFyJSeXl5PD1H1wzWSr/txqFIYbZ4mxLUZlpvb8lgMS/vLCYXIKicPuC995inSlzEu8imdQf
 vMcCYwDAzQ1fmTSzi11iA7CRCz7XUqKFGNfOccXOUsa7DjgZcSGw0vwusKXjLlQ7tU3YypqZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280575>

When working in a cross-platform environment, a user wants to
check if text files are stored normalized in the repository and if
=2Egitattributes are set appropriately.

Make it possible to let Git show the line endings in the cache and
in the working tree.

=46iles which are treated as binary by Git, are shown as "binary",
otherwise the end of lines ("eolinfo") are shown:

"text-no-eol"  text file without any EOL (or empty files)
"text-lf"      text file with LF
"text-crlf"    text file with CRLF
"text-crlf-lf" text file with mixed line endings.

git ls-files --eol gives an output like this:

ca:text-no-eol   wt:text-no-eol   t/t5100/empty
ca:binary        wt:binary        t/test-binary-2.png
ca:text-lf       wt:text-lf       t/t5100/rfc2047-info-0007
ca:text-lf       wt:text-crlf     doit.bat
ca:text-crlf-lf  wt:text-crlf-lf  locale/XX.po

Note that the output is meant to be human-readable and may change.
When e.g. a file is deleted from the working tree and another file
is a soft link, the output may look like this:

ca:text-lf       wt:text-lf       Documentation/RelNotes/2.6.1.txt
ca:text-lf       Documentation/RelNotes/2.7.0.txt
RelNotes

Signed-off-by: Torsten B=F6gershausen <tboegi@web.de>
---
The main motivation of this feature is human inspection, not shell proc=
essing.

=46or that reason I couldn't motivate to create a new command like git =
check-eol
or git get-eol.

Test cases are missing, they will be in V3,
when we know that this concept makes sense at all.

Changes since v1:
- Don't analyze the contents of softlinks
- Have only one option, --eol.
 --eol works together with -s, -o or other, but there may be combintaio=
n which
 don't make sense.
- Updated the documentation


Documentation/git-ls-files.txt | 22 ++++++++++++++++++++++
builtin/ls-files.c             | 22 ++++++++++++++++++++++
convert.c                      | 40 +++++++++++++++++++++++++++++++++++=
+++++
convert.h                      |  2 ++
4 files changed, 86 insertions(+)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
index e26f01f..4b02912 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -12,6 +12,7 @@ SYNOPSIS
'git ls-files' [-z] [-t] [-v]
		(--[cached|deleted|others|ignored|stage|unmerged|killed|modified])*
		(-[c|d|o|i|s|u|k|m])*
+		[--eol]
		[-x <pattern>|--exclude=3D<pattern>]
		[-X <file>|--exclude-from=3D<file>]
		[--exclude-per-directory=3D<file>]
@@ -147,6 +148,15 @@ a space) at the start of each line:
	possible for manual inspection; the exact format may change at
	any time.

+--eol::
+	Show line endings (eolinfo) of files for manual inspection:
+	"text-no-eol", "text-lf", "text-crlf", "text-crlf-lf" or "binary".
+	Both the cached content and the content in the working tree are shown=
 for
+	for regular files, if available.
+=09
+	Note:
+  `git ls-files --eol | grep ca:text-crlf` will show not-normailzed te=
xt files
+
\--::
	Do not interpret any more arguments as options.

@@ -161,6 +171,18 @@ which case it outputs:

        [<tag> ]<mode> <object> <stage> <file>

+'git ls-files --eol' will show
+        ca:<eolinfo> wt:<eolinfo> <file>
+
+'git ls-files --eol -d' will show
+        ca:<eolinfo>  <file>
+
+'git ls-files --eol -o' will show
+        wt:<eolinfo>  <file>
+
+'git ls-files --eol -s' will show
+[<tag> ]<mode> <object> <stage> ca:<eolinfo> wt:<eolinfo> <file>
+
'git ls-files --unmerged' and 'git ls-files --stage' can be used to exa=
mine
detailed information on unmerged paths.

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b6a7cb0..bdd0fd7 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -27,6 +27,7 @@ static int show_killed;
static int show_valid_bit;
static int line_terminator =3D '\n';
static int debug_mode;
+static int show_eol;

static const char *prefix;
static int max_prefix_len;
@@ -47,6 +48,21 @@ static const char *tag_modified =3D "";
static const char *tag_skip_worktree =3D "";
static const char *tag_resolve_undo =3D "";

+static void write_wt_convert_stats_ascii(const char *path)
+{
+	if (show_eol && !show_deleted) {
+		struct stat st;
+		if (!lstat(path, &st) && (S_ISREG(st.st_mode)))
+			printf("wt:%-13s ", get_wt_convert_stats_ascii(path));
+	}
+}
+
+static void write_ca_convert_stats_ascii(const struct cache_entry *ce)
+{
+	if (show_eol && S_ISREG(ce->ce_mode))
+		printf("ca:%-13s ", get_cached_convert_stats_ascii(ce->name));
+}
+
static void write_name(const char *name)
{
	/*
@@ -68,6 +84,7 @@ static void show_dir_entry(const char *tag, struct di=
r_entry *ent)
		return;

	fputs(tag, stdout);
+	write_wt_convert_stats_ascii(ent->name);
	write_name(ent->name);
}

@@ -170,6 +187,9 @@ static void show_ce_entry(const char *tag, const st=
ruct cache_entry *ce)
		       find_unique_abbrev(ce->sha1,abbrev),
		       ce_stage(ce));
	}
+	write_ca_convert_stats_ascii(ce);
+	write_wt_convert_stats_ascii(ce->name);
+=09
	write_name(ce->name);
	if (debug_mode) {
		const struct stat_data *sd =3D &ce->ce_stat_data;
@@ -206,6 +226,7 @@ static void show_ru_info(void)
			printf("%s%06o %s %d\t", tag_resolve_undo, ui->mode[i],
			       find_unique_abbrev(ui->sha1[i], abbrev),
			       i + 1);
+			write_wt_convert_stats_ascii(path);
			write_name(path);
		}
	}
@@ -433,6 +454,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
		OPT_BIT(0, "directory", &dir.flags,
			N_("show 'other' directories' names only"),
			DIR_SHOW_OTHER_DIRECTORIES),
+		OPT_BOOL(0, "eol", &show_eol, N_("show line endings of files")),
		OPT_NEGBIT(0, "empty-directory", &dir.flags,
			N_("don't show empty directories"),
			DIR_HIDE_EMPTY_DIRECTORIES),
diff --git a/convert.c b/convert.c
index 814e814..291f869 100644
--- a/convert.c
+++ b/convert.c
@@ -95,6 +95,46 @@ static int is_binary(unsigned long size, struct text=
_stat *stats)
	return 0;
}

+
+const char *gather_convert_stats_ascii(const char *data, unsigned long=
 size)
+{
+	struct text_stat stats;
+	if (!data)
+		return "";
+	gather_stats(data, size, &stats);
+	if (is_binary(size, &stats) || stats.cr !=3D stats.crlf)
+		return("binary");
+	else if (stats.crlf && (stats.crlf =3D=3D stats.lf))
+		return("text-crlf");
+	else if (stats.crlf && stats.lf)
+		return("text-crlf-lf");
+	else if (stats.lf)
+		return("text-lf");
+	else
+		return("text-no-eol");
+}
+
+const char *get_cached_convert_stats_ascii(const char *path)
+{
+	const char *ret;
+	unsigned long sz;
+	void *data =3D read_blob_data_from_cache(path, &sz);
+	ret =3D gather_convert_stats_ascii(data, sz);
+	free(data);
+	return ret;
+}
+
+const char *get_wt_convert_stats_ascii(const char *path)
+{
+	const char *ret =3D "";
+	struct strbuf sb =3D STRBUF_INIT;
+	if (strbuf_read_file(&sb, path, 0) < 0)
+		return "error";
+	ret =3D gather_convert_stats_ascii(sb.buf, sb.len);
+	strbuf_release(&sb);
+	return ret;
+}
+
static enum eol output_eol(enum crlf_action crlf_action)
{
	switch (crlf_action) {
diff --git a/convert.h b/convert.h
index d9d853c..a1671e9 100644
--- a/convert.h
+++ b/convert.h
@@ -32,6 +32,8 @@ enum eol {
};

extern enum eol core_eol;
+extern const char *get_cached_convert_stats_ascii(const char *path);
+extern const char *get_wt_convert_stats_ascii(const char *path);

/* returns 1 if *dst was used */
extern int convert_to_git(const char *path, const char *src, size_t len=
,
--=20
2.5.0
