From: tboegi@web.de
Subject: [PATCH v12] ls-files: add eol diagnostics
Date: Sat, 16 Jan 2016 07:50:02 +0100
Message-ID: <1452927002-14996-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, tboegi@web.de
X-From: git-owner@vger.kernel.org Sat Jan 16 07:50:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKKhM-0006VQ-Q4
	for gcvg-git-2@plane.gmane.org; Sat, 16 Jan 2016 07:50:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbcAPGuM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Jan 2016 01:50:12 -0500
Received: from mout.web.de ([212.227.15.4]:55836 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750844AbcAPGuK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2016 01:50:10 -0500
Received: from snoopy.lan ([213.66.56.100]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0McT8i-1abrZO36wq-00Heng; Sat, 16 Jan 2016 07:50:06
 +0100
X-Mailer: git-send-email 2.2.1.212.gc5b9256
X-Provags-ID: V03:K0:98mDOT5W8PZpvhQAXSkOVmjw1HQEArav3ZWH0XT7VOfcUSI5rdH
 /ybOOZEFpByN4SpiDrko6TqwBaSEduN0OjJOd4jRbx+h29wZsAijJVIUml3X4I2EeB5WyAK
 Gs62JNOfXK3JjO8tPCCVt3eUPDURz82vWytFXq3CHDVTRfIvzx7iNx7p+XvoxIRLVljzQ/l
 RxaeLuS+njoX5Iv3sUvTQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WTGLIpNtQjM=:jbFcsw5JGIjcD8rHuG6X4u
 /J7F/lkQOx8KrGWJ+dCUp0zrp1hPorTAznuoGKYU7dkWQ7xEWhL2LMRkNru4oEht0hbFRqG5U
 9e+2dkW39Qz5jdpAu+gl+o18AqSpK6VqY8alb6S8EA4s3pwvHC9SOogHDhF3tMZSK5qzcJtkE
 sFqMaLvc9mFa4QM3JNx554Si4fSy7QF9m0LzcWFkc2wQvddmx7sfExgm47AJM8YgWB7tfLzM+
 8j9a0w67HwUDPSaKYd2iY12MrncibCsXyMcH0mMEpDvnRnhRFYF7skgCN+3ZsV6QGPn7myZkh
 pi3+WCTGcGaSnEw+DoTLB7DhIsLSvZhiutqQI5dEU6vkPOBa4NQuf3qsmOfEK34ORkrDdtmm6
 c84+riZJcUIKCBLhv51dBUbPCD6aS7XizoBHs53SxZhyRZ+D6OAI+9X4E59/2r/joFLIKmH+G
 2RASr01CUL4/CJf4cTmQYOb2MieGrrU3LJt3ci1xB/iJJiicYjYSsfhgTeg6Eu9rL2P+isbAg
 tgM1Dtx/VDqfPxXTvW0aS10IyOpyjaYgRW0MtWuu/CK1h5PL88IjJvTrPM3NTxIgsroPKntpI
 tWK58TftotftZMn8ffl+WDZOm8EzCnp9JaC2V5tgR2gDAMhFChTGxQsntvM6yT9gr539BDeFw
 lln+0n/GQvr1qj4F/s9ShUK2FD4CzShpb+/lqSoknHrvRjidmqSEp57dFVUS9A3aBil9pI9Gn
 RBPwXj29DFWOmBsjSG0mbbmvFyV6KhVlh0nLkIOuYH32GFNVV78CGrxtVlFljLXUzXqCcA3b 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284238>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

When working in a cross-platform environment, a user may want to
check if text files are stored normalized in the repository and
if .gitattributes are set appropriately.

Make it possible to let Git show the line endings in the index and
in the working tree and the effective text/eol attributes.

The end of line ("eolinfo") are shown like this:

    "-text"        binary (or with bare CR) file
    "none"         text file without any EOL
    "lf"           text file with LF
    "crlf"         text file with CRLF
    "mixed"        text file with mixed line endings.

The effective text/eol attribute is one of these:

    "", "-text", "text", "text=3Dauto", "text eol=3Dlf", "text eol=3Dcr=
lf"

git ls-files --eol gives an output like this:

    i/none   w/none   attr/text=3Dauto      t/t5100/empty
    i/-text  w/-text  attr/-text          t/test-binary-2.png
    i/lf     w/lf     attr/text eol=3Dlf    t/t5100/rfc2047-info-0007
    i/lf     w/crlf   attr/text eol=3Dcrlf  doit.bat
    i/mixed  w/mixed  attr/               locale/XX.po

to show what eol convention is used in the data in the index ('i'),
and in the working tree ('w'), and what attribute is in effect,
for each path that is shown.

Add test cases in t0027.

Helped-By: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
Changes since v11:
 The format of ls-files --eol is like this:
   i/<eolinfo><SPACES>w/<eolinfo><SPACES>attr/<eolattr><SPACE*><TAB><fi=
le>
 When Git does not convert eols, "binary" is replaced with "-text"
 Other remarks about t0027=20

 Documentation/git-ls-files.txt |  22 ++++++++
 builtin/ls-files.c             |  21 +++++++
 convert.c                      | 119 ++++++++++++++++++++++++++++++---=
-------
 convert.h                      |   3 +
 t/t0027-auto-crlf.sh           | 121 +++++++++++++++++++++++++++++++++=
+-------
 5 files changed, 237 insertions(+), 49 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
index e26f01f..0e08f56 100644
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
@@ -147,6 +148,24 @@ a space) at the start of each line:
 	possible for manual inspection; the exact format may change at
 	any time.
=20
+--eol::
+	Show <eolinfo> and <eolattr> of files.
+	<eolinfo> is the file content identification used by Git when
+	the "text" attribute is "auto" (or not set and core.autocrlf is not f=
alse).
+	<eolinfo> is either "-text", "none", "lf", "crlf", "mixed" or "".
++
+"" means the file is not a regular file, it is not in the index or
+not accessable in the working tree.
++
+<eolattr> is the attribute that is used when checking out or committin=
g,
+it is either "", "-text", "text", "text=3Dauto", "text eol=3Dlf", "tex=
t eol=3Dcrlf".
+Note: Currently Git does not support "text=3Dauto eol=3Dlf" or "text=3D=
auto eol=3Dcrlf",
+that may change in the future.
++
+Both the <eolinfo> in the index ("i/<eolinfo>")
+and in the working tree ("w/<eolinfo>") are shown for regular files,
+followed by the  ("attr/<eolattr>").
+
 \--::
 	Do not interpret any more arguments as options.
=20
@@ -161,6 +180,9 @@ which case it outputs:
=20
         [<tag> ]<mode> <object> <stage> <file>
=20
+'git ls-files --eol' will show
+	i/<eolinfo><SPACES>w/<eolinfo><SPACES>attr/<eolattr><SPACE*><TAB><fil=
e>
+
 'git ls-files --unmerged' and 'git ls-files --stage' can be used to ex=
amine
 detailed information on unmerged paths.
=20
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b6a7cb0..dedf02d 100644
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
@@ -47,6 +48,23 @@ static const char *tag_modified =3D "";
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
+		printf("i/%-5s w/%-5s attr/%-17s\t", i_txt, w_txt, a_txt);
+	}
+}
+
 static void write_name(const char *name)
 {
 	/*
@@ -68,6 +86,7 @@ static void show_dir_entry(const char *tag, struct di=
r_entry *ent)
 		return;
=20
 	fputs(tag, stdout);
+	write_eolinfo(NULL, ent->name);
 	write_name(ent->name);
 }
=20
@@ -170,6 +189,7 @@ static void show_ce_entry(const char *tag, const st=
ruct cache_entry *ce)
 		       find_unique_abbrev(ce->sha1,abbrev),
 		       ce_stage(ce));
 	}
+	write_eolinfo(ce, ce->name);
 	write_name(ce->name);
 	if (debug_mode) {
 		const struct stat_data *sd =3D &ce->ce_stat_data;
@@ -433,6 +453,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 		OPT_BIT(0, "directory", &dir.flags,
 			N_("show 'other' directories' names only"),
 			DIR_SHOW_OTHER_DIRECTORIES),
+		OPT_BOOL(0, "eol", &show_eol, N_("show line endings of files")),
 		OPT_NEGBIT(0, "empty-directory", &dir.flags,
 			N_("don't show empty directories"),
 			DIR_HIDE_EMPTY_DIRECTORIES),
diff --git a/convert.c b/convert.c
index 814e814..4bb4ec1 100644
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
+static int convert_is_binary(unsigned long size, const struct text_sta=
t *stats)
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
+		return "-text";
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
+		return "text eol=3Dlf";
+	case CRLF_CRLF:
+		return "text=3Dauto eol=3Dcrlf";
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
index b343651..504e5a0 100755
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
@@ -149,6 +144,27 @@ commit_chk_wrnNNO () {
 	'
 }
=20
+stats_ascii () {
+	case "$1" in
+	LF)
+		echo lf
+		;;
+	CRLF)
+		echo crlf
+		;;
+	CRLF_mix_LF)
+		echo mixed
+		;;
+	LF_mix_CR|CRLF_nul|LF_nul|CRLF_mix_CR)
+		echo "-text"
+		;;
+	*)
+		echo error_invalid $1
+		;;
+	esac
+
+}
+
 check_files_in_repo () {
 	crlf=3D$1
 	attr=3D$2
@@ -203,35 +219,83 @@ checkout_files () {
 	create_gitattributes $attr &&
 	git config core.autocrlf $crlf &&
 	pfx=3Deol_${eol}_crlf_${crlf}_attr_${attr}_ &&
-	src=3Dcrlf_false_attr__ &&
 	for f in LF CRLF LF_mix_CR CRLF_mix_LF LF_nul
 	do
-		rm $src$f.txt &&
+		rm crlf_false_attr__$f.txt &&
 		if test -z "$eol"; then
-			git checkout $src$f.txt
+			git checkout crlf_false_attr__$f.txt
 		else
-			git -c core.eol=3D$eol checkout $src$f.txt
+			git -c core.eol=3D$eol checkout crlf_false_attr__$f.txt
 		fi
 	done
=20
+	test_expect_success "ls-files --eol $lfname ${pfx}LF.txt" '
+		test_when_finished "rm expect actual" &&
+		sort <<-EOF >expect &&
+		i/crlf w/$(stats_ascii $crlfname) crlf_false_attr__CRLF.txt
+		i/mixed w/$(stats_ascii $lfmixcrlf) crlf_false_attr__CRLF_mix_LF.txt
+		i/lf w/$(stats_ascii $lfname) crlf_false_attr__LF.txt
+		i/-text w/$(stats_ascii $lfmixcr) crlf_false_attr__LF_mix_CR.txt
+		i/-text w/$(stats_ascii $crlfnul) crlf_false_attr__CRLF_nul.txt
+		i/-text w/$(stats_ascii $crlfnul) crlf_false_attr__LF_nul.txt
+		EOF
+		git ls-files --eol crlf_false_attr__* |
+		sed -e "s!attr/[^	]*!!g" -e "s/	/ /g" -e "s/  */ /g" |
+		sort >actual &&
+		test_cmp expect actual
+	'
 	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$attr file=3DLF" "
-		compare_ws_file $pfx $lfname    ${src}LF.txt
+		compare_ws_file $pfx $lfname    crlf_false_attr__LF.txt
 	"
 	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$attr file=3DCRLF" "
-		compare_ws_file $pfx $crlfname  ${src}CRLF.txt
+		compare_ws_file $pfx $crlfname  crlf_false_attr__CRLF.txt
 	"
 	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$attr file=3DCRLF_mix_LF" "
-		compare_ws_file $pfx $lfmixcrlf ${src}CRLF_mix_LF.txt
+		compare_ws_file $pfx $lfmixcrlf crlf_false_attr__CRLF_mix_LF.txt
 	"
 	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$attr file=3DLF_mix_CR" "
-		compare_ws_file $pfx $lfmixcr   ${src}LF_mix_CR.txt
+		compare_ws_file $pfx $lfmixcr   crlf_false_attr__LF_mix_CR.txt
 	"
 	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$attr file=3DLF_nul" "
-		compare_ws_file $pfx $crlfnul   ${src}LF_nul.txt
+		compare_ws_file $pfx $crlfnul   crlf_false_attr__LF_nul.txt
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
+	sort <<-\EOF >expect &&
+	i/ w/-text TeBi_127_S
+	i/ w/none TeBi_128_S
+	i/ w/none TeBi_127_E
+	i/ w/-text TeBi_E_127
+	i/ w/-text TeBi_128_N
+	i/ w/lf TeBi_128_L
+	i/ w/-text TeBi_127_C
+	i/ w/crlf TeBi_126_CL
+	i/ w/-text TeBi_126_CLC
+	EOF
+	git ls-files --eol -o |
+	sed -n -e "/TeBi_/{s!attr/[	]*!!g
+	s!	! !g
+	s!  *! !g
+	p
+	}" | sort >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup master' '
 	echo >.gitattributes &&
 	git checkout -b master &&
@@ -480,4 +544,19 @@ checkout_files    native  true  "lf"      LF    CR=
LF  CRLF_mix_LF  LF_mix_CR
 checkout_files    native  false "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
 checkout_files    native  true  "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
=20
+# Should be the last test case: remove some files from the worktree
+test_expect_success 'ls-files --eol -d -z' '
+	rm crlf_false_attr__CRLF.txt crlf_false_attr__CRLF_mix_LF.txt crlf_fa=
lse_attr__LF.txt .gitattributes &&
+	cat >expect <<-\EOF &&
+	i/crlf w/ crlf_false_attr__CRLF.txt
+	i/lf w/ .gitattributes
+	i/lf w/ crlf_false_attr__LF.txt
+	i/mixed w/ crlf_false_attr__CRLF_mix_LF.txt
+	EOF
+	git ls-files --eol -d |
+	sed -e "s!attr/[^	]*!!g" -e "s/	/ /g" -e "s/  */ /g" |
+	sort >actual &&
+	test_cmp expect actual
+'
+
 test_done
--=20
2.7.0.278.g9379adb.dirty
