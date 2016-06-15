From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: [PATCH v8] ls-files: Add eol diagnostics
Date: Wed, 30 Dec 2015 13:57:01 +0100
Message-ID: <5683D49D.2010509@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 30 13:57:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEGJU-0002cj-HS
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 13:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754734AbbL3M5I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Dec 2015 07:57:08 -0500
Received: from mout.web.de ([212.227.17.11]:51778 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754708AbbL3M5G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 07:57:06 -0500
Received: from [192.168.2.107] ([79.223.108.227]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LyljP-1a9wm945CR-0169g4; Wed, 30 Dec 2015 13:57:03
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.0
X-Provags-ID: V03:K0:kurjlpNIerdBounO+iHHqyY4HngoFe5zuwRUcdGeQoZjdhTt1Nk
 8zy8EVBJFRjVZqIre2JSCjRzc2KIxILdNxonuUzjSUSrS9TMrPB4sBEjM6Jm5kO7OUjjiFW
 LRySITAP649iPEvKWIJ0yFVAm+aNTwdSymAQTjSYSz4jh8zaL9KjSyM9G2oxTSj58i6xOO7
 UJG7wyDJ+48HhcftVq4jw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B6P2T0DM4EY=:kmK9lcZKUWNvuffCaez6Xb
 sWHSbRhC6v39Y+IyqrqpVEIKL0fdfF55hhEvO90GO7GLuwYy+HZXBVUwIVHivqrakM6nV6UDy
 bQVYAT+Q8t5/4qwv3vYaxy/0pnrkWpBNjhm+n5vG9UxIyDoQaWWlmRadtJSd4t4VOHI2SHEi+
 ptPebI35+D4Wklz/R+2FYHlPR0L7tTjSARqpe87gJPxvz6vTlBWtkxaqOoueGcF3ANZpJo6my
 pd8N0HBcbwFz+CcwgrUavUabIIsZ3EC2jXMU7efXkzg4AcuJK1JWizf83OSs7pI23JDfIImx2
 dqwQ9T6ZWxHFqbxdVA+VuePBWE81658K5SwHuF34vF8ZymUGfyqQ8vwLmgZiaEz0PUrUpIsAW
 b9bJFMV0/ktVltAq2KyaGO+fvBFphxPOvVmHHXDV9YJcAiOjY77fMQboAnfN2u1iTu4E2ORwC
 41CUOXNYxnn7mpW7U9a4oy+QiES/v/7vjxNPWMCweYEWpO1wTHDaUubcEkOKM9R2inQir0FgF
 7jKea4CZnnfXWE1osjRC4hxJkDJnfEQEg4GMfOIy6PXfnDotHxCWULnwPuFqqcmOYhNgrkGum
 zkWDtikV27TC4ot+jl/YyLv56O5r+tVHAKUW+xrC5L4GS7iZRr1wZY5x5Dr9pNktBiSZDdEgv
 WaJSXy8qeUuh556BK+urNFucRasoTit1u/OS1JnikSTFO3qQ6kCznMOW4FjI50BpH7/6DdcP9
 hLdVoMOYhGvYH+ZdJ0ec2GDiFwC4RWzS5z3xuJpA+Bx003D/a595atcFY+cZjdjDd2DaujdO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283180>

When working in a cross-platform environment, a user wants to
check if text files are stored normalized in the repository and if
=2Egitattributes are set appropriately.

Make it possible to let Git show the line endings in the index and
in the working tree and the effective text/eol attributes.

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

Add test cases in t0027, thanks to Junio C Hamano for the optimized
grep-less sed expression.

Helped-By: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
Changes since v7:
- Remove the "may change" from commit message.
- Run make doc, improved git-ls-files.txt
 Documentation/git-ls-files.txt |  23 +++++++++
 builtin/ls-files.c             |  19 +++++++
 convert.c                      |  85 +++++++++++++++++++++++++++++++
 convert.h                      |   3 ++
 t/t0027-auto-crlf.sh           | 112 +++++++++++++++++++++++++++++++++=
+++-----
 5 files changed, 230 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
index e26f01f..13b0e1d 100644
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
@@ -147,6 +148,19 @@ a space) at the start of each line:
 	possible for manual inspection; the exact format may change at
 	any time.
 +--eol::
+	Show line endings ("eolinfo") and the text/eol attributes ("texteolat=
tr") of
files.
+	"eolinfo" is the file content identification used by Git when
+	the "text" attribute is "auto", or core.autocrlf !=3D false.
++
+"eolinfo" is either "" (when the the info is not available"), or one o=
f "binary",
+"text-no-eol", "text-lf", "text-crlf" or "text-crlf-lf".
++
+The "texteolattr" can be "", "-text", "text", "text=3Dauto", "eol=3Dlf=
", "eol=3Dcrlf".
++
+Both the content in the index ("i/") and the content in the working tr=
ee ("w/")
+are shown for regular files, followed by the "texteolattr" ("attr/").
+
 \--::
 	Do not interpret any more arguments as options.
 @@ -161,6 +175,15 @@ which case it outputs:
          [<tag> ]<mode> <object> <stage> <file>
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
 diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b6a7cb0..9eacc64 100644
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
 +static void write_eolinfo(const struct cache_entry *ce, const char *p=
ath)
+{
+	struct stat st;
+	const char *i_txt =3D "";
+	const char *w_txt =3D "";
+	if (!show_eol)
+		return;
+	if (ce && S_ISREG(ce->ce_mode))
+		i_txt =3D get_cached_convert_stats_ascii(ce->name);
+	if (!lstat(path, &st) && S_ISREG(st.st_mode))
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
  	fputs(tag, stdout);
+	write_eolinfo(NULL, ent->name);
 	write_name(ent->name);
 }
 @@ -170,6 +187,7 @@ static void show_ce_entry(const char *tag, const s=
truct
cache_entry *ce)
 		       find_unique_abbrev(ce->sha1,abbrev),
 		       ce_stage(ce));
 	}
+	write_eolinfo(ce, ce->name);
 	write_name(ce->name);
 	if (debug_mode) {
 		const struct stat_data *sd =3D &ce->ce_stat_data;
@@ -433,6 +451,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char
*cmd_prefix)
 		OPT_BIT(0, "directory", &dir.flags,
 			N_("show 'other' directories' names only"),
 			DIR_SHOW_OTHER_DIRECTORIES),
+		OPT_BOOL(0, "eol", &show_eol, N_("show line endings of files")),
 		OPT_NEGBIT(0, "empty-directory", &dir.flags,
 			N_("don't show empty directories"),
 			DIR_HIDE_EMPTY_DIRECTORIES),
diff --git a/convert.c b/convert.c
index 814e814..69a5588 100644
--- a/convert.c
+++ b/convert.c
@@ -13,6 +13,11 @@
  * translation when the "text" attribute or "auto_crlf" option is set.
  */
 +/* Stat bits: When BIN is set, the txt bits are unset */
+#define CONVERT_STAT_BITS_TXT_LF   (1)
+#define CONVERT_STAT_BITS_TXT_CRLF (2)
+#define CONVERT_STAT_BITS_BIN      (4)
+
 enum crlf_action {
 	CRLF_GUESS =3D -1,
 	CRLF_BINARY =3D 0,
@@ -95,6 +100,62 @@ static int is_binary(unsigned long size, struct tex=
t_stat
*stats)
 	return 0;
 }
 +static unsigned int gather_convert_stats(const char *data, unsigned l=
ong size)
+{
+	struct text_stat stats;
+	if (!data || !size)
+		return 0;
+	gather_stats(data, size, &stats);
+	if (is_binary(size, &stats) || stats.cr !=3D stats.crlf)
+		return CONVERT_STAT_BITS_BIN;
+	else if (stats.crlf && stats.crlf =3D=3D stats.lf)
+		return CONVERT_STAT_BITS_TXT_CRLF;
+	else if (stats.crlf && stats.lf)
+		return CONVERT_STAT_BITS_TXT_CRLF | CONVERT_STAT_BITS_TXT_LF;
+	else if (stats.lf)
+		return CONVERT_STAT_BITS_TXT_LF;
+	else
+		return 0;
+}
+
+static const char *gather_convert_stats_ascii(const char *data, unsign=
ed long size)
+{
+	unsigned int convert_stats =3D gather_convert_stats(data, size);
+
+	if (convert_stats & CONVERT_STAT_BITS_BIN)
+		return "binary";
+	switch (convert_stats) {
+		case CONVERT_STAT_BITS_TXT_LF:
+			return "text-lf";
+		case CONVERT_STAT_BITS_TXT_CRLF:
+			return "text-crlf";
+		case CONVERT_STAT_BITS_TXT_LF | CONVERT_STAT_BITS_TXT_CRLF:
+			return "text-crlf-lf";
+		default:
+			return "text-no-eol";
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
+	const char *ret =3D "";
+	struct strbuf sb =3D STRBUF_INIT;
+	if (strbuf_read_file(&sb, path, 0) >=3D 0)
+		ret =3D gather_convert_stats_ascii(sb.buf, sb.len);
+	strbuf_release(&sb);
+	return ret;
+}
+
 static enum eol output_eol(enum crlf_action crlf_action)
 {
 	switch (crlf_action) {
@@ -777,6 +838,30 @@ int would_convert_to_git_filter_fd(const char *pat=
h)
 	return apply_filter(path, NULL, 0, -1, NULL, ca.drv->clean);
 }
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
  extern enum eol core_eol;
+extern const char *get_cached_convert_stats_ascii(const char *path);
+extern const char *get_wt_convert_stats_ascii(const char *path);
+extern const char *get_convert_attr_ascii(const char *path);
  /* returns 1 if *dst was used */
 extern int convert_to_git(const char *path, const char *src, size_t le=
n,
diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index b343651..8580dec 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -56,21 +56,16 @@ create_gitattributes () {
 }
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
+		echo error_invalid $1
+		;;
+	esac
+
+}
+
 check_files_in_repo () {
 	crlf=3D$1
 	attr=3D$2
@@ -214,6 +239,20 @@ checkout_files () {
 		fi
 	done
 +	test_expect_success "ls-files --eol $lfname ${pfx}LF.txt" "
+		test_when_finished 'rm e expect actual' &&
+		cat >e <<-EOF &&
+		i/text-crlf w/$(stats_ascii $crlfname) ${src}CRLF.txt
+		i/text-crlf-lf w/$(stats_ascii $lfmixcrlf) ${src}CRLF_mix_LF.txt
+		i/text-lf w/$(stats_ascii $lfname) ${src}LF.txt
+		i/binary w/$(stats_ascii $lfmixcr) ${src}LF_mix_CR.txt
+		i/binary w/$(stats_ascii $crlfnul) ${src}CRLF_nul.txt
+		i/binary w/$(stats_ascii $crlfnul) ${src}LF_nul.txt
+		EOF
+		sort <e >expect &&
+		git ls-files --eol $src* | sed -e 's!attr/[=3Da-z-]*!!g' -e 's/  */ =
/g' | sort
>actual &&
+		test_cmp expect actual
+	"
 	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf
gitattributes=3D$attr file=3DLF" "
 		compare_ws_file $pfx $lfname    ${src}LF.txt
 	"
@@ -231,7 +270,41 @@ checkout_files () {
 	"
 }
 -#######
+# Test control characters
+# NUL SOH CR EOF=3D=3D^Z
+test_expect_success 'ls-files --eol -o Text/Binary' '
+	test_when_finished "rm e expect actual TeBi_*" &&
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
+	cat >e <<-\EOF &&
+	i/ w/binary TeBi_127_S
+	i/ w/text-no-eol TeBi_128_S
+	i/ w/text-no-eol TeBi_127_E
+	i/ w/binary TeBi_E_127
+	i/ w/binary TeBi_128_N
+	i/ w/text-lf TeBi_128_L
+	i/ w/binary TeBi_127_C
+	i/ w/text-crlf TeBi_126_CL
+	i/ w/binary TeBi_126_CLC
+	EOF
+	sort <e >expect &&
+	git ls-files --eol -o |
+	sed -n -e "/TeBi_/{s!attr/[=3Da-z-]*!!g
+	s!  *! !g
+	p
+	}" | sort >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup master' '
 	echo >.gitattributes &&
 	git checkout -b master &&
@@ -480,4 +553,19 @@ checkout_files    native  true  "lf"      LF    CR=
LF
CRLF_mix_LF  LF_mix_CR
 checkout_files    native  false "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR
 CRLF_nul
 checkout_files    native  true  "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR
 CRLF_nul
 +# Should be the last test case: remove some files from the worktree
+# This test assumes that "rm" can remove staged files
+test_expect_success 'ls-files --eol -d' "
+	rm crlf_false_attr__CRLF.txt crlf_false_attr__CRLF_mix_LF.txt
crlf_false_attr__LF.txt .gitattributes &&
+	cat >expect <<-\EOF &&
+	i/text-crlf w/ crlf_false_attr__CRLF.txt
+	i/text-crlf-lf w/ crlf_false_attr__CRLF_mix_LF.txt
+	i/text-lf w/ .gitattributes
+	i/text-lf w/ crlf_false_attr__LF.txt
+	EOF
+	git ls-files --eol -d | sed -e 's!attr/[=3Da-z-]*!!g' -e 's/  */ /g' =
| sort
>actual &&
+	test_cmp expect actual &&
+	rm expect actual
+"
+
 test_done
--=20
2.5.0
