From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: [PATCH v3] ls-files: Add eol diagnostics
Date: Sat, 21 Nov 2015 08:36:26 +0100
Message-ID: <56501EFA.7050105@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 21 08:36:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a02iy-0005cq-Mt
	for gcvg-git-2@plane.gmane.org; Sat, 21 Nov 2015 08:36:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbbKUHgi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Nov 2015 02:36:38 -0500
Received: from mout.web.de ([212.227.15.4]:54938 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751405AbbKUHgh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2015 02:36:37 -0500
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0Mf0W1-1ZgYrz2odl-00OZFw; Sat, 21 Nov 2015 08:36:34
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
X-Provags-ID: V03:K0:4ieGnyY1r2rWpPQqKGebV5aMw5sVY6/8NYYGn+Aauz5o2yoMK7H
 a3SFSwiE2M/+D1FU+aMrwD03UO8iZUiT0OFQ+90eINp/hXMFnrc2l6VwXWdzWL75EEdPsQG
 drbDz8dhZuEBi6WW9YhD1ecGwXbSLmQ2edCAFWdlGUdR6upR6TtOK0xrrr4QueRZecPpAsF
 Rb0172+RA5O4vESWV2wzw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:D1fs021MIKk=:VWHRBpjh1sP7ltShMJer4G
 lsOQ8jbCmRiT307tnBw8+xE0DofNpy5xK+9H+iRZJtJU1AKgMJyJs0dj36rX6eoTKywiFwtcK
 ogLLjaAWHhUUqtF8FVoP90Oact7qNXl29ngeqRW25qhDbaQurmNlaEaHAZyU8u1AmG3NqtN+7
 /p0OpPzmL+o2uwSU9P+dEmLQHBXyIe55tEEHb9pT+Z+73C3qfHOZImGPaqLxquFpFA/8jHHU5
 ERoiCZe4mLEpefMS/AetKQ17YQq079N55rk2N5u11i/PlMAzIMuhdNvOAVCPMf6XHcqGhKA7/
 9au1t4GPyp0n/0GBVVcJNX3p0sgf6R9uHnB+sRiw8IG7F40d9KbZLzGKBCiLFuyEGrBPYo+f5
 /WzYz1Ofap77/zTlsNfrxEAgXB++J6z35CYwO1f5hWAWp5qs8+Rq869XuYPB06ZygAA+gB+C3
 X9nBBT1CrvxF9ZLl577vEZTeDEHy2BPiy+/TPrzNBbxby0ZRLRlXUjWyykY12Dp8k7zaf96We
 Lw4nWrR879+v8yIXSKapzZHaFCYOXWTTcun01O9I34GffxuBWwGF+ObblNofnRoCfGiCzfrnx
 IdaetqtO1TaV6M/hlJjsBA6YAfnT2cWdXLT+5+payCb5liRzosQrS4ptWtqgtrf4e8nC0ei/i
 7p1uz65j2MGMnQzvl29zOXnJ7ohp/c2ibn2JlCNqtJjyQqXAvBFMlWxXIwN84zeMQy/z4jCTt
 cC5a1HMA6YnLUTr7wpMawRXqIIQwxFdfzjItEWIQZoYLPEZZO1vbWA+U8hi1dTPkC+XsLOFA 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281545>

When working in a cross-platform environment, a user wants to
check if text files are stored normalized in the repository and if
=2Egitattributes are set appropriately.

Make it possible to let Git show the line endings in the index and
in the working tree and the effective text/eol attributes

The end of line ("eolinfo") are shown like this:
"binary"       binary file
"text-no-eol"  text file without any EOL
"text-lf"      text file with LF
"text-crlf"    text file with CRLF
"text-crlf-lf" text file with mixed line endings.

The effective text/eol attribute is one of these:
"", "-text", "text", "text=3Dauto", "eol=3Dlf", "eol=3Dcrlf"

git ls-files --eol gives an output like this:

i/text-no-eol   w/text-no-eol   attr/text=3Dauto t/t5100/empty
i/binary        w/binary        attr/-text     t/test-binary-2.png
i/text-lf       w/text-lf       attr/eol=3Dlf    t/t5100/rfc2047-info-0=
007
i/text-lf       w/text-crlf     attr/eol=3Dcrlf  doit.bat
i/text-crlf-lf  w/text-crlf-lf  attr/          locale/XX.po

Note that the output is meant to be human-readable and may change.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
Changes since v2:
- Major rework
- New prefix, more common to what we use in Git (i/, w/ attr/)
- Only one option: git ls-files --eol (may be combined with -s or -o or=
 -d
- Simplify the diagnostics: either the file is binary or text
  As empty files are not binary, they are text-no-eol
- Test cases in t0027
- The documentation is improved, but may need more improving

 Documentation/git-ls-files.txt |  22 +++++++++
 builtin/check-attr.c           |  34 ++++++++++++--
 builtin/ls-files.c             |  19 ++++++++
 convert.c                      |  86 +++++++++++++++++++++++++++++++++=
+
 convert.h                      |   3 ++
 t/t0027-auto-crlf.sh           | 104 +++++++++++++++++++++++++++++++++=
+++-----
 6 files changed, 252 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
index e26f01f..7c87a8d 100644
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
@@ -147,6 +148,18 @@ a space) at the start of each line:
 	possible for manual inspection; the exact format may change at
 	any time.
=20
+--eol::
+	Show line endings ("eolinfo") and the text/eol attributes ("texteolat=
tr") of files.
+	"eolinfo" is the file content identification used by Git when
+	the "text" attribute is "auto", or core.autocrlf !=3D false.
+
+	"eolinfo" is either "" (when the the info is not avaiable"), or one o=
f "binary",
+	"text-no-eol", "text-lf", "text-crlf" or "text-crlf-lf".
+	The "texteolattr" can be "", "-text", "text", "text=3Dauto", "eol=3Dl=
f", "eol=3Dcrlf".
+
+	Both the content in the index ("i/") and the content in the working t=
ree ("w/")
+	are shown for regular files, followed by the "exteolattr ("attr/").
+
 \--::
 	Do not interpret any more arguments as options.
=20
@@ -161,6 +174,15 @@ which case it outputs:
=20
         [<tag> ]<mode> <object> <stage> <file>
=20
+'git ls-files --eol' will show
+	i/<eolinfo> w/<eolinfo> attr/<eolattr> <file>
+
+'git ls-files --eol -o' will show
+	i/          w/<eolinfo> attr/<eolattr> <file>
+
+'git ls-files --eol -s' will show
+[<tag> ]<mode> <object> <stage> i/<eolinfo> w/<eolinfo> attr/<eolattr>=
 <file>
+
 'git ls-files --unmerged' and 'git ls-files --stage' can be used to ex=
amine
 detailed information on unmerged paths.
=20
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 265c9ba..7734715 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -5,6 +5,7 @@
 #include "parse-options.h"
=20
 static int all_attrs;
+static int eol_attrs;
 static int cached_attrs;
 static int stdin_paths;
 static const char * const check_attr_usage[] =3D {
@@ -17,6 +18,7 @@ static int nul_term_line;
=20
 static const struct option check_attr_options[] =3D {
 	OPT_BOOL('a', "all", &all_attrs, N_("report all attributes set on fil=
e")),
+	OPT_BOOL('e', "eol", &eol_attrs, N_("report effective eol attributes =
set on file")),
 	OPT_BOOL(0,  "cached", &cached_attrs, N_("use .gitattributes only fro=
m the index")),
 	OPT_BOOL(0 , "stdin", &stdin_paths, N_("read file names from stdin"))=
,
 	OPT_BOOL('z', NULL, &nul_term_line,
@@ -51,6 +53,23 @@ static void output_attr(int cnt, struct git_attr_che=
ck *check,
 	}
 }
=20
+static void output_eol_attr(const char *file)
+{
+	struct stat st;
+	if (lstat(file, &st) || (!S_ISREG(st.st_mode)))
+		return;
+	if (nul_term_line) {
+		printf("%s:", file);
+		if (!lstat(file, &st) && (S_ISREG(st.st_mode)))
+			printf(": %-13s ", get_convert_attr_ascii(file));
+		printf("%c", 0);
+	} else {
+		quote_c_style(file, NULL, stdout, 0);
+		printf(": %-13s ", get_convert_attr_ascii(file));
+		printf("\n");
+	}
+}
+
 static void check_attr(const char *prefix, int cnt,
 	struct git_attr_check *check, const char *file)
 {
@@ -61,7 +80,9 @@ static void check_attr(const char *prefix, int cnt,
 			die("git_check_attr died");
 		output_attr(cnt, check, file);
 	} else {
-		if (git_all_attrs(full_path, &cnt, &check))
+		if (eol_attrs)
+			output_eol_attr(full_path);
+		else if (git_all_attrs(full_path, &cnt, &check))
 			die("git_all_attrs died");
 		output_attr(cnt, check, file);
 		free(check);
@@ -123,8 +144,13 @@ int cmd_check_attr(int argc, const char **argv, co=
nst char *prefix)
 			doubledash =3D i;
 	}
=20
-	/* Process --all and/or attribute arguments: */
-	if (all_attrs) {
+	if (eol_attrs) {
+		if (doubledash >=3D 1)
+			error_with_usage("Attributes and --eol both specified");
+		cnt =3D 0;
+		filei =3D doubledash + 1;
+	} else if (all_attrs) {
+		/* Process --all and/or attribute arguments: */
 		if (doubledash >=3D 1)
 			error_with_usage("Attributes and --all both specified");
=20
@@ -159,7 +185,7 @@ int cmd_check_attr(int argc, const char **argv, con=
st char *prefix)
 			error_with_usage("No file specified");
 	}
=20
-	if (all_attrs) {
+	if (all_attrs || eol_attrs) {
 		check =3D NULL;
 	} else {
 		check =3D xcalloc(cnt, sizeof(*check));
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b6a7cb0..ef892bc 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -27,6 +27,7 @@ static int show_killed;
 static int show_valid_bit;
 static int line_terminator =3D '\n';
 static int debug_mode;
+static int show_eol;
=20
 static const char *prefix;
 static int max_prefix_len;
@@ -47,6 +48,21 @@ static const char *tag_modified =3D "";
 static const char *tag_skip_worktree =3D "";
 static const char *tag_resolve_undo =3D "";
=20
+static void write_eolinfo(const struct cache_entry *ce, const char *pa=
th)
+{
+	struct stat st;
+	const char *i_txt =3D "";
+	const char *w_txt =3D "";
+	if (!show_eol)
+		return;
+	if (ce && S_ISREG(ce->ce_mode))
+		i_txt =3D get_cached_convert_stats_ascii(ce->name);
+	if (!lstat(path, &st) && (S_ISREG(st.st_mode)))
+		w_txt =3D get_wt_convert_stats_ascii(path);
+	printf("i/%-13s w/%-13s attr/%-9s ", i_txt, w_txt,
+				 get_convert_attr_ascii(path));
+}
+
 static void write_name(const char *name)
 {
 	/*
@@ -68,6 +84,7 @@ static void show_dir_entry(const char *tag, struct di=
r_entry *ent)
 		return;
=20
 	fputs(tag, stdout);
+	write_eolinfo(NULL, ent->name);
 	write_name(ent->name);
 }
=20
@@ -170,6 +187,7 @@ static void show_ce_entry(const char *tag, const st=
ruct cache_entry *ce)
 		       find_unique_abbrev(ce->sha1,abbrev),
 		       ce_stage(ce));
 	}
+	write_eolinfo(ce, ce->name);
 	write_name(ce->name);
 	if (debug_mode) {
 		const struct stat_data *sd =3D &ce->ce_stat_data;
@@ -433,6 +451,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 		OPT_BIT(0, "directory", &dir.flags,
 			N_("show 'other' directories' names only"),
 			DIR_SHOW_OTHER_DIRECTORIES),
+		OPT_BOOL(0, "eol", &show_eol, N_("show line endings of files")),
 		OPT_NEGBIT(0, "empty-directory", &dir.flags,
 			N_("don't show empty directories"),
 			DIR_HIDE_EMPTY_DIRECTORIES),
diff --git a/convert.c b/convert.c
index 814e814..c99adcd 100644
--- a/convert.c
+++ b/convert.c
@@ -13,6 +13,11 @@
  * translation when the "text" attribute or "auto_crlf" option is set.
  */
=20
+/* Stat bits: When BIN is set, the txt bits are unset */
+#define CONVERT_STAT_BITS_TXT_LF   (1)
+#define CONVERT_STAT_BITS_TXT_CRLF (2)
+#define CONVERT_STAT_BITS_BIN      (4)
+
 enum crlf_action {
 	CRLF_GUESS =3D -1,
 	CRLF_BINARY =3D 0,
@@ -95,6 +100,63 @@ static int is_binary(unsigned long size, struct tex=
t_stat *stats)
 	return 0;
 }
=20
+static unsigned int gather_convert_stats(const char *data, unsigned lo=
ng size)
+{
+	struct text_stat stats;
+	if (!data || !size)
+		return 0;
+	gather_stats(data, size, &stats);
+	if (is_binary(size, &stats) || stats.cr !=3D stats.crlf)
+		return CONVERT_STAT_BITS_BIN;
+	else if (stats.crlf && (stats.crlf =3D=3D stats.lf))
+		return CONVERT_STAT_BITS_TXT_CRLF;
+	else if (stats.crlf && stats.lf)
+		return CONVERT_STAT_BITS_TXT_CRLF | CONVERT_STAT_BITS_TXT_LF;
+	else if (stats.lf)
+		return CONVERT_STAT_BITS_TXT_LF;
+	else
+		return 0;
+}
+
+const char *gather_convert_stats_ascii(const char *data, unsigned long=
 size)
+{
+	unsigned int convert_stats =3D gather_convert_stats(data, size);
+
+	if (convert_stats & CONVERT_STAT_BITS_BIN)
+		return "binary";
+	switch (convert_stats) {
+		case CONVERT_STAT_BITS_TXT_LF:
+			return("text-lf");
+		case CONVERT_STAT_BITS_TXT_CRLF:
+			return("text-crlf");
+		case CONVERT_STAT_BITS_TXT_LF | CONVERT_STAT_BITS_TXT_CRLF:
+			return("text-crlf-lf");
+		default:
+			return ("text-no-eol");
+	}
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
+	const char *ret;
+	struct strbuf sb =3D STRBUF_INIT;
+	if (strbuf_read_file(&sb, path, 0) < 0)
+		return "";
+	ret =3D gather_convert_stats_ascii(sb.buf, sb.len);
+	strbuf_release(&sb);
+	return ret;
+}
+
 static enum eol output_eol(enum crlf_action crlf_action)
 {
 	switch (crlf_action) {
@@ -777,6 +839,30 @@ int would_convert_to_git_filter_fd(const char *pat=
h)
 	return apply_filter(path, NULL, 0, -1, NULL, ca.drv->clean);
 }
=20
+const char *get_convert_attr_ascii(const char *path)
+{
+	struct conv_attrs ca;
+	enum crlf_action crlf_action;
+
+	convert_attrs(&ca, path);
+	crlf_action =3D input_crlf_action(ca.crlf_action, ca.eol_attr);
+	switch (crlf_action) {
+		case CRLF_GUESS:
+			return "";
+		case CRLF_BINARY:
+			return "-text";
+		case CRLF_TEXT:
+			return "text";
+		case CRLF_INPUT:
+			return "eol=3Dlf";
+		case CRLF_CRLF:
+			return "eol=3Dcrlf";
+		case CRLF_AUTO:
+			return "text=3Dauto";
+	}
+	return "";
+}
+
 int convert_to_git(const char *path, const char *src, size_t len,
                    struct strbuf *dst, enum safe_crlf checksafe)
 {
diff --git a/convert.h b/convert.h
index d9d853c..ccf436b 100644
--- a/convert.h
+++ b/convert.h
@@ -32,6 +32,9 @@ enum eol {
 };
=20
 extern enum eol core_eol;
+extern const char *get_cached_convert_stats_ascii(const char *path);
+extern const char *get_wt_convert_stats_ascii(const char *path);
+extern const char *get_convert_attr_ascii(const char *path);
=20
 /* returns 1 if *dst was used */
 extern int convert_to_git(const char *path, const char *src, size_t le=
n,
diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index b343651..7d51aed 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -56,21 +56,16 @@ create_gitattributes () {
 }
=20
 create_NNO_files () {
-	lfname=3D$1
-	crlfname=3D$2
-	lfmixcrlf=3D$3
-	lfmixcr=3D$4
-	crlfnul=3D$5
 	for crlf in false true input
 	do
 		for attr in "" auto text -text lf crlf
 		do
 			pfx=3DNNO_${crlf}_attr_${attr} &&
-			cp $lfname    ${pfx}_LF.txt &&
-			cp $crlfname  ${pfx}_CRLF.txt &&
-			cp $lfmixcrlf ${pfx}_CRLF_mix_LF.txt &&
-			cp $lfmixcr   ${pfx}_LF_mix_CR.txt &&
-			cp $crlfnul   ${pfx}_CRLF_nul.txt
+			cp CRLF_mix_LF ${pfx}_LF.txt &&
+			cp CRLF_mix_LF ${pfx}_CRLF.txt &&
+			cp CRLF_mix_LF ${pfx}_CRLF_mix_LF.txt &&
+			cp CRLF_mix_LF ${pfx}_LF_mix_CR.txt &&
+			cp CRLF_mix_LF ${pfx}_CRLF_nul.txt
 		done
 	done
 }
@@ -96,7 +91,7 @@ commit_check_warn () {
 	crlfnul=3D$7
 	pfx=3Dcrlf_${crlf}_attr_${attr}
 	create_gitattributes "$attr" &&
-	for f in LF CRLF repoMIX LF_mix_CR CRLF_mix_LF LF_nul CRLF_nul
+	for f in LF CRLF LF_mix_CR CRLF_mix_LF LF_nul CRLF_nul
 	do
 		fname=3D${pfx}_$f.txt &&
 		cp $f $fname &&
@@ -149,6 +144,36 @@ commit_chk_wrnNNO () {
 	'
 }
=20
+stats_ascii () {
+	case "$1" in
+		LF)
+		echo text-lf
+		;;
+		CRLF)
+		echo text-crlf
+		;;
+		CRLF_mix_LF)
+		echo text-crlf-lf
+		;;
+		LF_mix_CR)
+		echo binary
+		;;
+		CRLF_nul)
+		echo binary
+		;;
+		LF_nul)
+		echo binary
+		;;
+		CRLF_mix_CR)
+		echo binary
+		;;
+		*)
+		echo huh $1
+		;;
+	esac
+
+}
+
 check_files_in_repo () {
 	crlf=3D$1
 	attr=3D$2
@@ -213,7 +238,18 @@ checkout_files () {
 			git -c core.eol=3D$eol checkout $src$f.txt
 		fi
 	done
-
+	test_expect_success "ls-files --eol $lfname ${pfx}LF.txt" "
+		echo i/text-lf w/$(stats_ascii $lfname) ${src}LF.txt >e &&
+		echo i/text-crlf w/$(stats_ascii $crlfname) ${src}CRLF.txt >>e &&
+		echo i/text-crlf-lf w/$(stats_ascii $lfmixcrlf) ${src}CRLF_mix_LF.tx=
t >>e &&
+		echo i/binary w/$(stats_ascii $lfmixcr) ${src}LF_mix_CR.txt >>e &&
+		echo i/binary w/$(stats_ascii $crlfnul) ${src}CRLF_nul.txt >>e &&
+		echo i/binary w/$(stats_ascii $crlfnul) ${src}LF_nul.txt >>e &&
+		sort <e >exp &&
+		git ls-files --eol $src* | sed -e 's!attr/[=3Da-z-]*!!g' -e 's/  */ =
/g' | sort >act &&
+		test_cmp exp act &&
+		rm e exp act
+	"
 	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$attr file=3DLF" "
 		compare_ws_file $pfx $lfname    ${src}LF.txt
 	"
@@ -231,6 +267,35 @@ checkout_files () {
 	"
 }
=20
+# Test control characters
+# NUL SOH CR EOF=3D=3D^Z
+test_expect_success 'ls-files --eol -o Text/Binary' '
+	test_when_finished "rm e exp act TeBi_*" &&
+	STRT=3DAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA &&
+	STR=3D$STRT$STRT$STRT$STRT &&
+	printf "${STR}BBB\001" >TeBi_127_S &&
+	printf "${STR}BBBB\001">TeBi_128_S &&
+	printf "${STR}BBB\032" >TeBi_127_E &&
+	printf "\032${STR}BBB" >TeBi_E_127 &&
+	printf "${STR}BBBB\000">TeBi_128_N &&
+	printf "${STR}BBB\012">TeBi_128_L &&
+	printf "${STR}BBB\015">TeBi_127_C &&
+	printf "${STR}BB\015\012" >TeBi_126_CL &&
+	printf "${STR}BB\015\012\015" >TeBi_126_CLC &&
+	echo i/ w/binary TeBi_127_S >e &&
+	echo i/ w/text-no-eol TeBi_128_S >>e &&
+	echo i/ w/text-no-eol TeBi_127_E >>e &&
+	echo i/ w/binary TeBi_E_127 >>e &&
+	echo i/ w/binary TeBi_128_N >>e &&
+	echo i/ w/text-lf TeBi_128_L >>e &&
+	echo i/ w/binary TeBi_127_C >>e &&
+	echo i/ w/text-crlf TeBi_126_CL >>e &&
+	echo i/ w/binary TeBi_126_CLC >>e &&
+	sort <e >exp &&
+	git ls-files --eol -o | egrep "TeBi_" | sed -e 's!attr/[=3Da-z-]*!!g'=
 -e "s/  */ /g" | sort >act &&
+	test_cmp exp act
+'
+
 #######
 test_expect_success 'setup master' '
 	echo >.gitattributes &&
@@ -480,4 +545,19 @@ checkout_files    native  true  "lf"      LF    CR=
LF  CRLF_mix_LF  LF_mix_CR
 checkout_files    native  false "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
 checkout_files    native  true  "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
=20
+
+# Should be the last test case
+test_expect_success 'ls-files --eol -d' "
+	rm  crlf_false_attr__CRLF.txt crlf_false_attr__CRLF_mix_LF.txt crlf_f=
alse_attr__LF.txt .gitattributes &&
+	echo i/text-lf w/ .gitattributes >e &&
+	echo i/text-crlf w/ crlf_false_attr__CRLF.txt >>e &&
+	echo i/text-crlf-lf w/ crlf_false_attr__CRLF_mix_LF.txt >>e &&
+	echo i/text-lf w/ crlf_false_attr__LF.txt >>e &&
+	sort <e >exp &&
+	git ls-files --eol -d | sed -e 's!attr/[=3Da-z-]*!!g' -e 's/  */ /g' =
| sort >act &&
+	test_cmp exp act &&
+	rm e exp act
+"
+
+
 test_done
--=20
2.6.1.443.g36d7748
