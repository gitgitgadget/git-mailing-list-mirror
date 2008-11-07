From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] diffcore-rename: add config option to allow to cache renames
Date: Fri,  7 Nov 2008 21:35:33 +0700
Message-ID: <1226068533-10152-2-git-send-email-pclouds@gmail.com>
References: <1226068533-10152-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 15:37:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KySSe-0000bb-N7
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 15:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbYKGOf7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Nov 2008 09:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbYKGOf7
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 09:35:59 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:27862 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbYKGOf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 09:35:58 -0500
Received: by wa-out-1112.google.com with SMTP id v27so620382wah.21
        for <git@vger.kernel.org>; Fri, 07 Nov 2008 06:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=LPn38FYs/gedJ0d1MByQ0jt111sodZ1AF4IUwHGzuOQ=;
        b=FtyfZkhiqsQAHW5KHxtgg7HTU1xbuDHoHxnTkPIYmVtJgwO01h4zvxpVMfoYaX5Lbb
         28DtKKvxMtR3Y680QqkxyI/XiZdex9Bwhfcv6gbupFCqwCIFttZEZuph7uvv4uIjUKGK
         2SxoumIyrW3O/U8gdQ/rUTmDHMoECOBBmASz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=bipWaFGD+ZnpFIZETwadbSFgkvfUl9T9JYtBAG5WYOa73uRj/iZ6fBsaH+NwzWSuNJ
         yI5H93l4I0PRzMG6BLQk9XoDAAk3I88yayMygsCNwCu8dYKRYEZh54UmoNAC4DNv/jqp
         ZeUR1f67WN0Bxqht2mgzWsWuqoWqYDBnyNgYE=
Received: by 10.114.126.1 with SMTP id y1mr1402256wac.201.1226068558032;
        Fri, 07 Nov 2008 06:35:58 -0800 (PST)
Received: from pclouds@gmail.com ([117.5.61.191])
        by mx.google.com with ESMTPS id t1sm5062043poh.2.2008.11.07.06.35.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Nov 2008 06:35:52 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri,  7 Nov 2008 21:35:42 +0700
X-Mailer: git-send-email 1.6.0.3.802.g47c38
In-Reply-To: <1226068533-10152-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100315>

If diff.cacherenames is true, then renames will be cached to
$GIT_DIR/rename-cache. By default, it will not overwrite existing
cache. Add --refresh-cache to overwrite.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 if git-svn is going to use this, then perharps we should add a rule to=
 prevent
 overwriting certain cache files with .keep files, so that git-svn gene=
rated cache
 does not get lost

 Documentation/config.txt       |    5 ++++
 Documentation/diff-options.txt |    5 ++++
 diff.c                         |   12 +++++++++++
 diff.h                         |    2 +
 diffcore-rename.c              |   41 ++++++++++++++++++++++++++++++++=
++++++++
 t/t4030-rename-cache.sh        |   27 ++++++++++++++++++++++++++
 6 files changed, 92 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 29369d0..81160d3 100644
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
index e368fef..1d65bd9 100644
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
@@ -109,6 +110,11 @@ int git_diff_basic_config(const char *var, const c=
har *value, void *cb)
 		return 0;
 	}
=20
+	if (!strcmp(var, "diff.cacherenames")) {
+		diff_cache_renames =3D git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!prefixcmp(var, "diff.color.") || !prefixcmp(var, "color.diff."))=
 {
 		int slot =3D parse_diff_color_slot(var, 11);
 		if (!value)
@@ -2248,6 +2254,8 @@ int diff_setup_done(struct diff_options *options)
=20
 	if (options->detect_rename && options->rename_limit < 0)
 		options->rename_limit =3D diff_rename_limit_default;
+	if (options->detect_rename)
+		options->cache_renames =3D diff_cache_renames;
 	if (options->setup & DIFF_SETUP_USE_CACHE) {
 		if (!active_cache)
 			/* read-cache does not die even when it fails
@@ -2415,6 +2423,10 @@ int diff_opt_parse(struct diff_options *options,=
 const char **av, int ac)
 		DIFF_OPT_SET(options, RELATIVE_NAME);
 		options->prefix =3D arg + 11;
 	}
+	else if (!strcmp(arg, "--refresh-rename-cache")) {
+		options->cache_renames =3D 1;
+		options->refresh_rename_cache =3D 1;
+	}
=20
 	/* xdiff options */
 	else if (!strcmp(arg, "-w") || !strcmp(arg, "--ignore-all-space"))
diff --git a/diff.h b/diff.h
index 8b68f6f..eb97955 100644
--- a/diff.h
+++ b/diff.h
@@ -85,6 +85,8 @@ struct diff_options {
 	int pickaxe_opts;
 	int rename_score;
 	int rename_limit;
+	int cache_renames;
+	int refresh_rename_cache;
 	int warn_on_too_large_rename;
 	int dirstat_percent;
 	int setup;
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 598cc8d..2b87e4e 100644
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
+			if (!stat(path, &st) && !options->refresh_rename_cache)
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
@@ -770,6 +808,9 @@ void diffcore_rename(struct diff_options *options)
 	}
 	diff_debug_queue("done copying original", &outq);
=20
+	if (options->commit && options->cache_renames)
+		save_rename_cache(&outq, options);
+
 	free(q->queue);
 	if (cacheq.queue)
 		free(cacheq.queue);
diff --git a/t/t4030-rename-cache.sh b/t/t4030-rename-cache.sh
index 0d8390c..24d3667 100755
--- a/t/t4030-rename-cache.sh
+++ b/t/t4030-rename-cache.sh
@@ -52,4 +52,31 @@ test_expect_success 'load create pair cache' '
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
") &&
+	rm -r .git/rename-cache
+	git config diff.cacherenames true
+	git show --summary -C -M --find-copies-harder > /dev/null
+	test_cmp expected $P
+'
+
+test_expect_success 'subsequent command does not change cache' '
+	P=3D.git/rename-cache/$(git rev-parse HEAD|sed "s,\(..\)\(.*\),\1/\2,=
") &&
+	echo corrupted >> $P
+	! test_cmp expected $P &&
+	git show --summary -C -M --find-copies-harder HEAD > /dev/null &&
+	! test_cmp expected $P
+'
+
+test_expect_success 'overwrite cache with --refresh-rename-cache' '
+	P=3D.git/rename-cache/$(git rev-parse HEAD|sed "s,\(..\)\(.*\),\1/\2,=
") &&
+	! test_cmp expected $P &&
+	git show --summary -C -M --find-copies-harder --refresh-rename-cache =
HEAD > /dev/null &&
+	test_cmp expected $P
+'
+
 test_done
--=20
1.6.0.3.802.g47c38
