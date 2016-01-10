From: tboegi@web.de
Subject: [PATCH v10] ls-files: add eol diagnostics
Date: Sun, 10 Jan 2016 18:16:43 +0100
Message-ID: <1452446203-20693-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: tboegi@web.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 10 18:17:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIJcY-0004Wt-Cf
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jan 2016 18:17:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757083AbcAJRQ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Jan 2016 12:16:59 -0500
Received: from mout.web.de ([212.227.17.12]:52814 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756796AbcAJRQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2016 12:16:57 -0500
Received: from snoopy.lan ([213.66.56.100]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0Lp71s-1ZffTY0bvo-00etot; Sun, 10 Jan 2016 18:16:48
 +0100
X-Mailer: git-send-email 2.2.1.212.gc5b9256
X-Provags-ID: V03:K0:SJ1obGK9juDg5w+E8PHTEW4K342f5hUS4BZK4wuWtBNtZnUZXH3
 MMEOoFu5WLkQMmP5MLqmshUgas/G54XG6kWflhK5HnMLyZ+gTSp0jrKp2Kjyn3nlWPyFW6J
 PtpwTh0cok21kTpbvs8+k+vRV5BRYXlmRjFZ6cDxtGloJpfnV6rtxFlSV0tdQcuoQS1vXKs
 xuH7Km+MAK4LyNhh8FATA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r/PADinb2nc=:Tf4TzlanbzvTxukndneZAY
 Yks3Z4CqoeT7nu+4OM+P0Pnu0wK3QtGo29NNck/GNyaJoRW7XXZ0M5QI34eEpMQh0RTtyZGT0
 S6FRcjEtlCU31WMWmnLviuVHLDky4QYIUdwfzCSBaR4WE5ebCsvQFbvdXGap8nf4Oo6u6vrNU
 +syEjs5kwAhb/9ueTVDo1SH1C8PsCeOEt7I8BtTnh71oCCW+4a57kyyjGoDoLQych/Yq6pZ0E
 pa6aNoxGN26lciWz0jLosXwutcmKkkk+LXWYoiLcruDiulZzolLBtI6OSDgm+0g9nDRX7wt+y
 jCYTWXztxN79p3rGYx/3L0TuKCf0NDNY2tVMnABFaCsx5s1aWS3HzCJf9icAB9qGPbGVs+Ma6
 K7UFDsktVCmnl85B75iEnPmk+W1ROZy2+MKGNPo7ovYmBJlk7Zbop0w/uum8C3oyuo2CihyRr
 M9xXLksUybRxgU2LuD0mEVshVlKg8dSmhyDckKMj26q4zIOHKvlLhNjFQ0koYJgcPiH1pgvz0
 zOMFY/HnhyuoX0l5Mfk1vCZ5xhpifP5dMXTBuUUYfz7ebcSp3tg6TjGy6xlhQKGavP8Ptm0dz
 Va2YrtEOJXabEeHDKdKxKmZT8f7Nte3t+0u9cq9iZnaSsYqX/UCNJrVrhEnP59tSmcBWFHslR
 RNuKFyNCG5t8BGXjrocBfbFKvBEO0Qh3nNRpqEaHgc74m1EGwdgcImm2weUleNu8BJp1jG+pc
 21f9OP/OjjZ4NmDbDG5CAKR+Fw3krPP/atP0kZ6nucC2r2Yyhv4j30VAUaHcBFtTfFK9x1wK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283623>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

When working in a cross-platform environment, a user may want to
check if text files are stored normalized in the repository and
if .gitattributes are set appropriately.

Make it possible to let Git show the line endings in the index and
in the working tree and the effective text/eol attributes.

The end of line ("eolinfo") are shown like this:

    "binary"       binary file
    "none"         text file without any EOL
    "lf"           text file with LF
    "crlf"         text file with CRLF
    "mixed"        text file with mixed line endings.

The effective text/eol attribute is one of these:

    "", "-text", "text", "text=3Dauto", "eol=3Dlf", "eol=3Dcrlf"

git ls-files --eol gives an output like this:

    i/none   w/none   attr/text=3Dauto t/t5100/empty
    i/binary w/binary attr/-text     t/test-binary-2.png
    i/lf     w/lf     attr/eol=3Dlf    t/t5100/rfc2047-info-0007
    i/lf     w/crlf   attr/eol=3Dcrlf  doit.bat
    i/mixed  w/mixed  attr/          locale/XX.po

to show what eol convention is used in the data in the index ('i'),
and in the working tree ('w'), and what attribute is in effect,
for each path that is shown.

Add test cases in t0027.

Helped-By: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Changes agains pu:
convert.c:=20
 - Indent switch case
 - Introduced convert_is_binary()=20

ls-files.c:
 - Early out in write_eolinfo()
 - Use TAB instead of multiple spaces when -z is used

t0027:
 - case-esac indentattion
 - cat EOF | sort, remove "e"
 - Replace " with '
Documentation/git-ls-files.txt:
 -  Try to make things clearer
 - -z turns SPACES inot TAB
 Documentation/git-ls-files.txt |  30 +++++++++++
 builtin/ls-files.c             |  24 +++++++++
 convert.c                      | 119 +++++++++++++++++++++++++++++++--=
--------
 convert.h                      |   3 ++
 t/t0027-auto-crlf.sh           | 112 +++++++++++++++++++++++++++++++++=
-----
 5 files changed, 248 insertions(+), 40 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
index e26f01f..03f4770 100644
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
@@ -147,6 +148,23 @@ a space) at the start of each line:
 	possible for manual inspection; the exact format may change at
 	any time.
=20
+--eol::
+	Show <eolinfo> and <eolattr> of files.
+	<eolinfo> is the file content identification used by Git when
+	the "text" attribute is "auto" (or not set and core.autocrlf is not f=
alse).
+	<eolinfo> is either "binary", "none", "lf", "crlf" or "mixed" or "".
++
+"" means the file is not a regular file, it is not in the index or
+not accessable in the working tree.
++
+<eolattr> is the attribute that is used when checking out or committin=
g,
+it is either "", "-text", "text", "text=3Dauto", "eol=3Dlf", "eol=3Dcr=
lf".
++
+Both the <eolinfo> in the index ("i/<eolinfo>")
+and in the working tree ("w/<eolinfo>") are shown for regular files,
+followed by the  ("attr/<eolattr>").
+Whenever a file is not a regular file, both <eolinfo> and <eolattr> ar=
e "".
+
 \--::
 	Do not interpret any more arguments as options.
=20
@@ -161,6 +179,18 @@ which case it outputs:
=20
         [<tag> ]<mode> <object> <stage> <file>
=20
+'git ls-files --eol' will show
+	i/<eolinfo><SPACES>w/<eolinfo><SPACES>attr/<eolattr><SPACES><file>
+
+'git ls-files --eol -z' will use a TAB instead of spaces:
+	i/<eolinfo><TAB>w/<eolinfo><TAB>attr/<eolattr><TAB><file>
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
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b6a7cb0..3a9716b 100644
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
@@ -47,6 +48,26 @@ static const char *tag_modified =3D "";
 static const char *tag_skip_worktree =3D "";
 static const char *tag_resolve_undo =3D "";
=20
+static void write_eolinfo(const struct cache_entry *ce, const char *pa=
th)
+{
+	if (!show_eol)
+		return;
+	else {
+		struct stat st;
+		const char *i_txt =3D "";
+		const char *w_txt =3D "";
+		const char *a_txt =3D get_convert_attr_ascii(path);
+		if (ce && S_ISREG(ce->ce_mode))
+			i_txt =3D get_cached_convert_stats_ascii(ce->name);
+		if (!lstat(path, &st) && S_ISREG(st.st_mode))
+			w_txt =3D get_wt_convert_stats_ascii(path);
+		if (line_terminator =3D=3D '\n')
+			printf("i/%-6s w/%-6s attr/%-9s ", i_txt, w_txt, a_txt);
+		else
+			printf("i/%s\tw/%s\tattr/%s\t", i_txt, w_txt, a_txt);
+	}
+}
+
 static void write_name(const char *name)
 {
 	/*
@@ -68,6 +89,7 @@ static void show_dir_entry(const char *tag, struct di=
r_entry *ent)
 		return;
=20
 	fputs(tag, stdout);
+	write_eolinfo(NULL, ent->name);
 	write_name(ent->name);
 }
=20
@@ -170,6 +192,7 @@ static void show_ce_entry(const char *tag, const st=
ruct cache_entry *ce)
 		       find_unique_abbrev(ce->sha1,abbrev),
 		       ce_stage(ce));
 	}
+	write_eolinfo(ce, ce->name);
 	write_name(ce->name);
 	if (debug_mode) {
 		const struct stat_data *sd =3D &ce->ce_stat_data;
@@ -433,6 +456,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 		OPT_BIT(0, "directory", &dir.flags,
 			N_("show 'other' directories' names only"),
 			DIR_SHOW_OTHER_DIRECTORIES),
+		OPT_BOOL(0, "eol", &show_eol, N_("show line endings of files")),
 		OPT_NEGBIT(0, "empty-directory", &dir.flags,
 			N_("don't show empty directories"),
 			DIR_HIDE_EMPTY_DIRECTORIES),
diff --git a/convert.c b/convert.c
index 814e814..de494f0 100644
--- a/convert.c
+++ b/convert.c
@@ -13,6 +13,11 @@
  * translation when the "text" attribute or "auto_crlf" option is set.
  */
=20
+/* Stat bits: When BIN is set, the txt bits are unset */
+#define CONVERT_STAT_BITS_TXT_LF    0x1
+#define CONVERT_STAT_BITS_TXT_CRLF  0x2
+#define CONVERT_STAT_BITS_BIN       0x4
+
 enum crlf_action {
 	CRLF_GUESS =3D -1,
 	CRLF_BINARY =3D 0,
@@ -75,26 +80,75 @@ static void gather_stats(const char *buf, unsigned =
long size, struct text_stat *
=20
 /*
  * The same heuristics as diff.c::mmfile_is_binary()
+ * We treat files with bare CR as binary
  */
-static int is_binary(unsigned long size, struct text_stat *stats)
+static inline int convert_is_binary(unsigned long size, const struct t=
ext_stat *stats)
 {
-
+	if (stats->cr !=3D stats->crlf)
+		return 1;
 	if (stats->nul)
 		return 1;
 	if ((stats->printable >> 7) < stats->nonprintable)
 		return 1;
-	/*
-	 * Other heuristics? Average line length might be relevant,
-	 * as might LF vs CR vs CRLF counts..
-	 *
-	 * NOTE! It might be normal to have a low ratio of CRLF to LF
-	 * (somebody starts with a LF-only file and edits it with an editor
-	 * that adds CRLF only to lines that are added..). But do  we
-	 * want to support CR-only? Probably not.
-	 */
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
+	if (convert_is_binary(size, &stats))
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
+	case CONVERT_STAT_BITS_TXT_LF:
+		return "lf";
+	case CONVERT_STAT_BITS_TXT_CRLF:
+		return "crlf";
+	case CONVERT_STAT_BITS_TXT_LF | CONVERT_STAT_BITS_TXT_CRLF:
+		return "mixed";
+	default:
+		return "none";
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
@@ -187,18 +241,7 @@ static int crlf_to_git(const char *path, const cha=
r *src, size_t len,
 	gather_stats(src, len, &stats);
=20
 	if (crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_GUESS) {
-		/*
-		 * We're currently not going to even try to convert stuff
-		 * that has bare CR characters. Does anybody do that crazy
-		 * stuff?
-		 */
-		if (stats.cr !=3D stats.crlf)
-			return 0;
-
-		/*
-		 * And add some heuristics for binary vs text, of course...
-		 */
-		if (is_binary(len, &stats))
+		if (convert_is_binary(len, &stats))
 			return 0;
=20
 		if (crlf_action =3D=3D CRLF_GUESS) {
@@ -277,11 +320,7 @@ static int crlf_to_worktree(const char *path, cons=
t char *src, size_t len,
 				return 0;
 		}
=20
-		/* If we have any bare CR characters, we're not going to touch it */
-		if (stats.cr !=3D stats.crlf)
-			return 0;
-
-		if (is_binary(len, &stats))
+		if (convert_is_binary(len, &stats))
 			return 0;
 	}
=20
@@ -777,6 +816,30 @@ int would_convert_to_git_filter_fd(const char *pat=
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
+	case CRLF_GUESS:
+		return "";
+	case CRLF_BINARY:
+		return "-text";
+	case CRLF_TEXT:
+		return "text";
+	case CRLF_INPUT:
+		return "eol=3Dlf";
+	case CRLF_CRLF:
+		return "eol=3Dcrlf";
+	case CRLF_AUTO:
+		return "text=3Dauto";
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
index b343651..2614612 100755
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
+	LF)
+	echo lf
+	;;
+	CRLF)
+	echo crlf
+	;;
+	CRLF_mix_LF)
+	echo mixed
+	;;
+	LF_mix_CR)
+	echo binary
+	;;
+	CRLF_nul)
+	echo binary
+	;;
+	LF_nul)
+	echo binary
+	;;
+	CRLF_mix_CR)
+	echo binary
+	;;
+	*)
+	echo error_invalid $1
+	;;
+	esac
+
+}
+
 check_files_in_repo () {
 	crlf=3D$1
 	attr=3D$2
@@ -214,6 +239,19 @@ checkout_files () {
 		fi
 	done
=20
+	test_expect_success "ls-files --eol $lfname ${pfx}LF.txt" "
+		test_when_finished 'rm expect actual' &&
+		cat <<-EOF | sort >expect &&
+		i/crlf w/$(stats_ascii $crlfname) ${src}CRLF.txt
+		i/mixed w/$(stats_ascii $lfmixcrlf) ${src}CRLF_mix_LF.txt
+		i/lf w/$(stats_ascii $lfname) ${src}LF.txt
+		i/binary w/$(stats_ascii $lfmixcr) ${src}LF_mix_CR.txt
+		i/binary w/$(stats_ascii $crlfnul) ${src}CRLF_nul.txt
+		i/binary w/$(stats_ascii $crlfnul) ${src}LF_nul.txt
+		EOF
+		git ls-files --eol $src* | sed -e 's!attr/[=3Da-z-]*!!g' -e 's/  */ =
/g' | sort >actual &&
+		test_cmp expect actual
+	"
 	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$attr file=3DLF" "
 		compare_ws_file $pfx $lfname    ${src}LF.txt
 	"
@@ -231,7 +269,40 @@ checkout_files () {
 	"
 }
=20
-#######
+# Test control characters
+# NUL SOH CR EOF=3D=3D^Z
+test_expect_success 'ls-files --eol -o Text/Binary' '
+	test_when_finished "rm expect actual TeBi_*" &&
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
+	cat <<-\EOF| sort >expect &&
+	i/ w/binary TeBi_127_S
+	i/ w/none TeBi_128_S
+	i/ w/none TeBi_127_E
+	i/ w/binary TeBi_E_127
+	i/ w/binary TeBi_128_N
+	i/ w/lf TeBi_128_L
+	i/ w/binary TeBi_127_C
+	i/ w/crlf TeBi_126_CL
+	i/ w/binary TeBi_126_CLC
+	EOF
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
@@ -480,4 +551,21 @@ checkout_files    native  true  "lf"      LF    CR=
LF  CRLF_mix_LF  LF_mix_CR
 checkout_files    native  false "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
 checkout_files    native  true  "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
=20
+# Should be the last test case: remove some files from the worktree
+# This test assumes that "rm" can remove staged files
+test_expect_success 'ls-files --eol -d' '
+	rm crlf_false_attr__CRLF.txt crlf_false_attr__CRLF_mix_LF.txt crlf_fa=
lse_attr__LF.txt .gitattributes &&
+	cat >expect <<-\EOF &&
+	i/crlf w/ crlf_false_attr__CRLF.txt
+	i/lf w/ .gitattributes
+	i/lf w/ crlf_false_attr__LF.txt
+	i/mixed w/ crlf_false_attr__CRLF_mix_LF.txt
+	EOF
+	git ls-files --eol -d |
+	sed -e "s!attr/[=3Da-z-]*!!g" -e "s/  */ /g" |
+	sort >actual &&
+	test_cmp expect actual &&
+	rm expect actual
+'
+
 test_done
--=20
2.7.0.278.g182263e.dirty
