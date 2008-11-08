From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/2] diffcore-rename: add config option to allow to cache renames
Date: Sat,  8 Nov 2008 18:27:33 +0700
Message-ID: <1226143653-3758-2-git-send-email-pclouds@gmail.com>
References: <1226143653-3758-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat Nov 08 12:30:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kym1L-0000uk-A8
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 12:30:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753021AbYKHL1z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2008 06:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753025AbYKHL1z
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 06:27:55 -0500
Received: from wf-out-1314.google.com ([209.85.200.168]:12909 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010AbYKHL1y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 06:27:54 -0500
Received: by wf-out-1314.google.com with SMTP id 27so1730477wfd.4
        for <git@vger.kernel.org>; Sat, 08 Nov 2008 03:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=a3hU55PsMsZsvzqaFD+JBPBVPlkCnXuOTLUmosf0EpU=;
        b=nsIoORM+w/90MlKG3g30hWpe8Ql4FCvnXx2k0Hu/eq5nibUlrqwUuntV1nXmnrftPO
         wNaF7g+kjsJw0x0XD9InsF9OSLm300TFmHNOfrFC8pw5ysiNUyMdHa0NaELTttypbPjK
         w4H/uaNIWGjS/jcQ0WTgAWAI0ABBgHWYWIehA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=GVP+/t7pEqdv5WvanSTyGcu3IF0ehzOQtFXyc0mQjT/3xzAHqadihEYi3cNcJVYs9c
         8iWOM8rpqZybAXzAPIBL19jWXWaQ5v4TiY8jzA1R53p29GDl3AZT2Jl+CfoZHri/td2C
         SGreM2XzcBJvG1jgEzBK+xJH36BK/b1mldY/I=
Received: by 10.142.241.10 with SMTP id o10mr1385832wfh.268.1226143674132;
        Sat, 08 Nov 2008 03:27:54 -0800 (PST)
Received: from pclouds@gmail.com ([117.5.61.191])
        by mx.google.com with ESMTPS id 29sm6079915wfg.0.2008.11.08.03.27.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Nov 2008 03:27:52 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat,  8 Nov 2008 18:27:41 +0700
X-Mailer: git-send-email 1.6.0.3.892.g83538
In-Reply-To: <1226143653-3758-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100395>

If diff.cacherenames is true, then renames will be cached to
$GIT_DIR/rename-cache. By default, it will not overwrite existing
cache. Add --refresh-cache to overwrite.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt       |    5 ++++
 Documentation/diff-options.txt |    5 ++++
 diff.c                         |   12 +++++++++
 diff.h                         |    2 +
 diffcore-rename.c              |   49 ++++++++++++++++++++++++++++++++=
++++++++
 t/t4031-rename-cache.sh        |   36 +++++++++++++++++++++++++++++
 6 files changed, 109 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 965ed74..8a7f00e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -630,6 +630,11 @@ diff.renames::
 	will enable basic rename detection.  If set to "copies" or
 	"copy", it will detect copies, as well.
=20
+diff.cacherenames::
+	Tells git to automatically cache renames when detected. The
+	cache resides in $GIT_DIR/rename-cache, which is used by git
+	if exists.
+
 fetch.unpackLimit::
 	If the number of objects fetched over the git native
 	transfer is below this
diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
index c62b45c..d477a40 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -102,6 +102,11 @@ endif::git-format-patch[]
 	Turn off rename detection, even when the configuration
 	file gives the default to do so.
=20
+--refresh-rename-cache::
+	By default, when git finds a cached version of a commit, it
+	will not overwrite the cache. This option makes git overwrite
+	old cache or create a new one.
+
 --check::
 	Warn if changes introduce trailing whitespace
 	or an indent that uses a space before a tab. Exits with
diff --git a/diff.c b/diff.c
index f644947..604cb12 100644
--- a/diff.c
+++ b/diff.c
@@ -26,6 +26,7 @@ int diff_use_color_default =3D -1;
 static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index =3D 1;
 static int diff_mnemonic_prefix;
+static int diff_cache_renames;
=20
 static char diff_colors[][COLOR_MAXLEN] =3D {
 	"\033[m",	/* reset */
@@ -103,6 +104,11 @@ int git_diff_basic_config(const char *var, const c=
har *value, void *cb)
 		return 0;
 	}
=20
+	if (!strcmp(var, "diff.cacherenames")) {
+		diff_cache_renames =3D git_config_bool(var, value);
+		return 0;
+	}
+
 	switch (userdiff_config(var, value)) {
 		case 0: break;
 		case -1: return -1;
@@ -2272,6 +2278,8 @@ int diff_setup_done(struct diff_options *options)
=20
 	if (options->detect_rename && options->rename_limit < 0)
 		options->rename_limit =3D diff_rename_limit_default;
+	if (options->detect_rename && diff_cache_renames)
+			DIFF_OPT_SET(options, CACHE_RENAMES);
 	if (options->setup & DIFF_SETUP_USE_CACHE) {
 		if (!active_cache)
 			/* read-cache does not die even when it fails
@@ -2439,6 +2447,10 @@ int diff_opt_parse(struct diff_options *options,=
 const char **av, int ac)
 		DIFF_OPT_SET(options, RELATIVE_NAME);
 		options->prefix =3D arg + 11;
 	}
+	else if (!strcmp(arg, "--refresh-rename-cache")) {
+		DIFF_OPT_SET(options, CACHE_RENAMES);
+		DIFF_OPT_SET(options, REFRESH_RENAME_CACHE);
+	}
=20
 	/* xdiff options */
 	else if (!strcmp(arg, "-w") || !strcmp(arg, "--ignore-all-space"))
diff --git a/diff.h b/diff.h
index 64a1edd..0503b57 100644
--- a/diff.h
+++ b/diff.h
@@ -66,6 +66,8 @@ typedef void (*diff_format_fn_t)(struct diff_queue_st=
ruct *q,
 #define DIFF_OPT_DIRSTAT_CUMULATIVE  (1 << 19)
 #define DIFF_OPT_DIRSTAT_BY_FILE     (1 << 20)
 #define DIFF_OPT_ALLOW_TEXTCONV      (1 << 21)
+#define DIFF_OPT_CACHE_RENAMES       (1 << 22)
+#define DIFF_OPT_REFRESH_RENAME_CACHE (1 << 23)
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |=3D DIFF_OPT_##fla=
g)
 #define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &=3D ~DIFF_OPT_##fl=
ag)
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 598cc8d..49651ea 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -527,6 +527,44 @@ static void load_rename_cache(struct diff_queue_st=
ruct *q,
 	free_hash(&filepair_table);
 }
=20
+static void save_rename_cache(struct diff_queue_struct *outq,
+			      struct diff_options *options)
+{
+	int i;
+	FILE *fp =3D NULL;
+	struct stat st;
+
+	for (i =3D 0;i < outq->nr; i++) {
+		struct diff_filepair *dp =3D outq->queue[i];
+
+		if (!(dp->renamed_pair || /* rename pair */
+		      (!DIFF_FILE_VALID(dp->one) && DIFF_FILE_VALID(dp->two)))) /* c=
reate pair */
+			continue;
+
+		if (!fp) {
+			char *sha1 =3D sha1_to_hex(options->commit->object.sha1);
+			char *path =3D git_path("rename-cache/%c%c/%s", sha1[0], sha1[1], s=
ha1+2);
+
+			/* Already cached. If not force refresh, move on */
+			if (!stat(path, &st) && !DIFF_OPT_TST(options, REFRESH_RENAME_CACHE=
))
+				return;
+
+			safe_create_leading_directories(path);
+			fp =3D fopen(path, "w");
+
+			if (!fp)
+				return;
+		}
+
+		fprintf(fp, "%s ", sha1_to_hex(dp->two->sha1));
+		fprintf(fp, "%s %d\n",
+			sha1_to_hex(DIFF_FILE_VALID(dp->one) ?  dp->one->sha1 : null_sha1),
+			dp->score);
+	}
+	if (fp)
+		fclose(fp);
+}
+
 void diffcore_rename(struct diff_options *options)
 {
 	int detect_rename =3D options->detect_rename;
@@ -770,6 +808,17 @@ void diffcore_rename(struct diff_options *options)
 	}
 	diff_debug_queue("done copying original", &outq);
=20
+	/*
+	 * Only cache if:
+	 * - Have a commit hint
+	 * - diff.cacherenames is on
+	 * - no pathspec limits
+	 */
+	if (options->commit &&
+	    DIFF_OPT_TST(options, CACHE_RENAMES) &&
+	    !options->nr_paths)
+		save_rename_cache(&outq, options);
+
 	free(q->queue);
 	if (cacheq.queue)
 		free(cacheq.queue);
diff --git a/t/t4031-rename-cache.sh b/t/t4031-rename-cache.sh
index f7c53fd..2d3f993 100755
--- a/t/t4031-rename-cache.sh
+++ b/t/t4031-rename-cache.sh
@@ -53,4 +53,40 @@ test_expect_success 'load create pair cache' '
 	test_cmp expected result
 '
=20
+cat >expected <<EOF
+f2ad6c76f0115a6ba5b00456a849810e7ec0af20 00000000000000000000000000000=
00000000000 0
+78981922613b2afb6025042ff6bd878ac1994e85 78981922613b2afb6025042ff6bd8=
78ac1994e85 60000
+EOF
+test_expect_success 'save rename cache' '
+	P=3D.git/rename-cache/$(git rev-parse HEAD|sed "s,\(..\)\(.*\),\1/\2,=
")
+	rm -r .git/rename-cache
+	git config diff.cacherenames true
+	git show --summary -C -M --find-copies-harder > /dev/null
+	test_cmp expected $P
+'
+
+test_expect_success 'do not save rename cache with limited pathspec' '
+	P=3D.git/rename-cache/$(git rev-parse HEAD|sed "s,\(..\)\(.*\),\1/\2,=
")
+	echo $P
+	rm $P
+	git config diff.cacherenames true
+	git log --summary -C -M --find-copies-harder HEAD -- sub
+	! test -f $P
+'
+
+test_expect_success 'subsequent command does not change cache' '
+	P=3D.git/rename-cache/$(git rev-parse HEAD|sed "s,\(..\)\(.*\),\1/\2,=
")
+	echo corrupted > $P
+	! test_cmp expected $P &&
+	git show --summary -C -M --find-copies-harder HEAD > /dev/null &&
+	! test_cmp expected $P
+'
+
+test_expect_success 'overwrite cache with --refresh-rename-cache' '
+	P=3D.git/rename-cache/$(git rev-parse HEAD|sed "s,\(..\)\(.*\),\1/\2,=
")
+	! test_cmp expected $P &&
+	git show --summary -C -M --find-copies-harder --refresh-rename-cache =
HEAD > /dev/null &&
+	test_cmp expected $P
+'
+
 test_done
--=20
1.6.0.3.892.g83538
