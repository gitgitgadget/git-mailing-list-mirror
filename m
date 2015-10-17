From: =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: [PATCH] Add ls-files --eol-staged, --eol-worktree
Date: Sat, 17 Oct 2015 22:18:06 +0200
Message-ID: <D68CC6D0-3FD5-4423-A9E2-905DF18E893F@web.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 17 22:18:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnXvm-0004HU-Vc
	for gcvg-git-2@plane.gmane.org; Sat, 17 Oct 2015 22:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214AbbJQUSN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Oct 2015 16:18:13 -0400
Received: from mout.web.de ([212.227.17.12]:53249 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751214AbbJQUSL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Oct 2015 16:18:11 -0400
Received: from [192.168.209.21] ([213.66.56.100]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M2uWg-1aep4Y1jPC-00shWl; Sat, 17 Oct 2015 22:18:08
 +0200
X-Mailer: Apple Mail (2.1878.6)
X-Provags-ID: V03:K0:GdI9M+6BIJSNX6mqXyQR9P1/fBMyFO1ZioLqGy/zDyOErjI/64I
 tV4wvcAxK2slMMJ36BazUUqlQOBX9DXTCP4B/2tb8abgQnrS+VYRZy2yHHBhbJLWVODMXdP
 0fzcY0Q+L1S1U6Pm+hF0jbG3QlFGl6gwuKlHZJHuQgRbMFkXMpFep/2A/q/PbsmAbxy2gsk
 ZSe00TLjkQyANtbj9mnag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8omftzdH2b0=:K4EUNKBn/UzNjaxxlJrhBm
 EL6wZ9VIlotenJJkFo+0ceFj2NBYqO65eMIoglSls3lUZ2qaUaQzqT5bn+5yy9g36Z4bczDX/
 E/JePJtEgZWAFPfxc84D4GbJuj1SC0aH+2C264gZJJerDz1XaeH+j6O4bzI2jAsXfW94HzoO3
 mFHU1d3Ozo00GrEflJuxa/2o28JjvxJYQIyAMEU9SiR1JFidfcYy80jopniGPgG6dNLs5Rtnh
 COQX8l/QzkbuOV0bdnwBOohwFW65eATD03Olfa8m+3PHyckFctnORqxdSPYgFEswIvqAXEDGG
 xZp8xtp8VPGBQwLl7KaclLWoZNiYjgoPy4IP7uZWGUvN6VygHTlnRw9o9/YY/u4ngi0UTehLH
 vhLqrwqERP9KQkrHxNsWIh2QKLdwqyglek1Psg5fTTFeUCG9XZ9GynObOWzE3aHZwzzwnDceK
 fvTc7rCIivpadrxO/bGn8YCjsffq19MXe8b138nGhIMfZ8MnixuxE2M7Tyx7R+Lrdss9N4Boc
 EamFXR91ebie32UmrMu+qMq5ktT456I/vyKCPgUwK84HGIXp0HEWefghEgTVckC29iQC8HqRg
 bBuSm/rQG8EWRyEjbtA4pXpFrP4fnX8vptIsXM7KOI4AldapU+k42z/DsPajwHc+EioLkON3X
 zqlTHReFdfNfVIHORlwl2kQVqgoPSGgs92Oh+jkll34s9FBaPXerciAzK9WLRHmqB+xcU2E87
 cco9iYwKkeQTEfJhZzwWqLxWkACZu9DhDuWdTW/VVjzRfbtplgyWYgw7wIDzQBc13q0U+2Hj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279793>

Make it possible to show the line endings of files.
=46iles which are staged and/or files in the working tree:

git ls-files --eol-staged
git ls-files --eol-worktree

Both will show an output like this:

empty    empty_file
bin      binary_file_or_with_cr_handled_as_binary
txt-crlf text_file_with_crlf
txt-mix  text_file_with_crlf_and_lf
txt-lf   text_file_with_lf
txt      text_file_with_no_eol_at_all

Implementation details:
Make struct text_stat, is_binary() and gather_stats() from convert.c
public, add a new function get_convert_stats_ascii() and use it
in and use them in ls-files.
git ls-files --eol-staged will give a line like this:

Signed-off-by: Torsten B=F6gershausen <tboegi@web.de>
---
This needs to go on top of tb/t0027-crlf

builtin/ls-files.c | 21 +++++++++++++++++++++
convert.c          | 51 +++++++++++++++++++++++++++++++++++++++++------=
----
convert.h          | 14 ++++++++++++++
3 files changed, 76 insertions(+), 10 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b6a7cb0..c989e94 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -27,6 +27,8 @@ static int show_killed;
static int show_valid_bit;
static int line_terminator =3D '\n';
static int debug_mode;
+static int show_eol_staged;
+static int show_eol_wt;

static const char *prefix;
static int max_prefix_len;
@@ -68,6 +70,11 @@ static void show_dir_entry(const char *tag, struct d=
ir_entry *ent)
		return;

	fputs(tag, stdout);
+	if (show_eol_wt) {
+		printf("%s ", get_convert_stats_ascii(ent->name,
+																					GET_CONVERT_STATS_ASCII_WT, 0));
+	}
+
	write_name(ent->name);
}

@@ -170,6 +177,14 @@ static void show_ce_entry(const char *tag, const s=
truct cache_entry *ce)
		       find_unique_abbrev(ce->sha1,abbrev),
		       ce_stage(ce));
	}
+	if (show_eol_staged) {
+		printf("%s ",
+					 get_convert_stats_ascii(ce->name, GET_CONVERT_STATS_ASCII_BLOB, =
0));
+	}
+	if (show_eol_wt) {
+		printf("%s ", get_convert_stats_ascii(ce->name,GET_CONVERT_STATS_ASC=
II_WT,
+																					ce->ce_stat_data.sd_size));
+	}
	write_name(ce->name);
	if (debug_mode) {
		const struct stat_data *sd =3D &ce->ce_stat_data;
@@ -206,6 +221,10 @@ static void show_ru_info(void)
			printf("%s%06o %s %d\t", tag_resolve_undo, ui->mode[i],
			       find_unique_abbrev(ui->sha1[i], abbrev),
			       i + 1);
+			if (show_eol_wt) {
+				printf("%s ",
+							 get_convert_stats_ascii(path, GET_CONVERT_STATS_ASCII_WT, 0));
+			}
			write_name(path);
		}
	}
@@ -433,6 +452,8 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
		OPT_BIT(0, "directory", &dir.flags,
			N_("show 'other' directories' names only"),
			DIR_SHOW_OTHER_DIRECTORIES),
+		OPT_BOOL(0, "eol-staged", &show_eol_staged, N_("show line endings of=
 the staged file")),
+		OPT_BOOL(0, "eol-worktree", &show_eol_wt, N_("show line endings of t=
he file in work tree")),
		OPT_NEGBIT(0, "empty-directory", &dir.flags,
			N_("don't show empty directories"),
			DIR_HIDE_EMPTY_DIRECTORIES),
diff --git a/convert.c b/convert.c
index 814e814..a1c24cd 100644
--- a/convert.c
+++ b/convert.c
@@ -22,15 +22,7 @@ enum crlf_action {
	CRLF_AUTO
};

-struct text_stat {
-	/* NUL, CR, LF and CRLF counts */
-	unsigned nul, cr, lf, crlf;
-
-	/* These are just approximations! */
-	unsigned printable, nonprintable;
-};
-
-static void gather_stats(const char *buf, unsigned long size, struct t=
ext_stat *stats)
+void gather_stats(const char *buf, unsigned long size, struct text_sta=
t *stats)
{
	unsigned long i;

@@ -76,7 +68,7 @@ static void gather_stats(const char *buf, unsigned lo=
ng size, struct text_stat *
/*
 * The same heuristics as diff.c::mmfile_is_binary()
 */
-static int is_binary(unsigned long size, struct text_stat *stats)
+int is_binary(unsigned long size, struct text_stat *stats)
{

	if (stats->nul)
@@ -95,6 +87,45 @@ static int is_binary(unsigned long size, struct text=
_stat *stats)
	return 0;
}

+
+const char *gather_stats_ascii(const char *data, unsigned long size)
+{
+	struct text_stat stats;
+	if (!data || !size)
+		return("empty   ");
+	gather_stats(data, size, &stats);
+	if (is_binary(size, &stats))
+		return("bin     ");
+	else if (stats.cr !=3D stats.crlf)
+		return("bin     ");
+	else if (stats.crlf && (stats.crlf =3D=3D stats.lf))
+		return("txt-crlf");
+	else if (stats.crlf && stats.lf)
+		return("txt-mix ");
+	else if (stats.lf)
+		return("txt-lf  ");
+	else
+		return("txt     ");
+}
+
+const char *get_convert_stats_ascii(const char *path, int flags, size_=
t hint)
+{
+	const char *ret =3D "";
+	if (flags & GET_CONVERT_STATS_ASCII_BLOB) {
+		unsigned long sz;
+		void *data =3D read_blob_data_from_cache(path, &sz);
+		ret =3D gather_stats_ascii(data, sz);
+		if (data)
+			free(data);
+	} else if (flags & GET_CONVERT_STATS_ASCII_WT){
+		struct strbuf sb =3D STRBUF_INIT;
+		strbuf_read_file(&sb, path, hint);
+		ret =3D gather_stats_ascii(sb.buf, sb.len);
+		strbuf_release(&sb);
+	}
+	return ret;
+}
+
static enum eol output_eol(enum crlf_action crlf_action)
{
	switch (crlf_action) {
diff --git a/convert.h b/convert.h
index d9d853c..566cf0e 100644
--- a/convert.h
+++ b/convert.h
@@ -31,6 +31,20 @@ enum eol {
#endif
};

+struct text_stat {
+	/* NUL, CR, LF and CRLF counts */
+	unsigned nul, cr, lf, crlf;
+
+	/* These are just approximations! */
+	unsigned printable, nonprintable;
+};
+void gather_stats(const char *buf, unsigned long size, struct text_sta=
t *stats);
+int is_binary(unsigned long size, struct text_stat *stats);
+const char *gather_stats_ascii(const char *buf, unsigned long size);
+#define GET_CONVERT_STATS_ASCII_BLOB           (1<<0)
+#define GET_CONVERT_STATS_ASCII_WT             (1<<1)
+const char *get_convert_stats_ascii(const char *path, int isBlob, size=
_t hint);
+
extern enum eol core_eol;

/* returns 1 if *dst was used */
--=20
2.6.1.443.g36d7748
