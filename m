Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA7CC2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 08:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238545AbiAZIlx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 03:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiAZIlw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 03:41:52 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65855C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 00:41:52 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id c23so8704206wrb.5
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 00:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=K0LgJSigfNyrn4WSwKovSk+APwo3VYPrw32hX33/Q40=;
        b=TyTWWhvV0zXsUyjzTnUELz8XqhtsfUgTlnzOOmb/fRNSe42YFxKKE/6xKD/WvGCryb
         5ZmO9KrQRIWjYMAwtBFmECRLwZW6vGQ1bgrh/97gSAr9B5pUfb4pqWAn+ryD/GUfkMd2
         tYMEp7NTv9sZErvLG4qF8xsz6rAP27YtEXovlc3SOoyjSCNxIf9dAA4iXRLGCpC/Bb6k
         5I6qK1pepCrcsQMShUHv3cNv9qyrbKjHfpv81OlDET+jy6cFyva3fjabOxB1oDnGsON+
         Xd+CO58rNSQ2c0S0h9TpZxbtcGRT85l4w53+F9LUH0j62cFKrPzy8+W1H8uq3j6t8PXF
         BRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=K0LgJSigfNyrn4WSwKovSk+APwo3VYPrw32hX33/Q40=;
        b=6uY/7a42pOENCc1Z7lDb7bEwkY+/T/lHQE32VwKcoxN8vZPMUHcgEzclj2g2c7xECO
         DdB/qHINUv5mIiiaHizxa/dVj4I9eMj73ZqF2OaAAVX7EBuau/6x8V9uYQm1XXCKH5yW
         3PmfGH+KQ0TIWdqwI+JU6fnFqau0gLIZc6r6kGPaMKB8aNgdNSw+A7Z1zGTVqjkkAgJU
         gaq7WtXMtTAoMg6Cj2rF5hFimOLCb9f8XND3HNEa5TyPcyHlDrkWOfjLRi2b3mpCHCi7
         w8ilyXfTmVnk8iOzUKVDltEaRRbFWYLV1QcgaeNEOWQHbnUJy0oPSKOg7hEhIgaPyONT
         aqCg==
X-Gm-Message-State: AOAM532PRw3Nc8/T1ByL1fIkHLIuFcgifBUaBJ8tM5vKTGgLGvkmQwLX
        CzdSLu3HTmdQCMSBY5M6la1IAilNUBc=
X-Google-Smtp-Source: ABdhPJy58qr03mqCGQGBb7odEoceCGSpRmMIGrqCJbYVb0XFIFG2GaOOlJfZ/GL7ywl+Y71ZxdgDoQ==
X-Received: by 2002:adf:b64f:: with SMTP id i15mr16780017wre.228.1643186510718;
        Wed, 26 Jan 2022 00:41:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t5sm19706564wrw.92.2022.01.26.00.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 00:41:50 -0800 (PST)
Message-Id: <ce85506e7a4313a4ae21ef712b84d8396ac45cdc.1643186507.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Jan 2022 08:41:43 +0000
Subject: [PATCH 1/5] Implement `scalar diagnose`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Over the course of Scalar's development, it became obvious that there is
a need for a command that can gather all kinds of useful information
that can help identify the most typical problems with large
worktrees/repositories.

The `diagnose` command is the culmination of this hard-won knowledge: it
gathers the installed hooks, the config, a couple statistics describing
the data shape, among other pieces of information, and then wraps
everything up in a tidy, neat `.zip` archive.

Note: originally, Scalar was implemented in C# using the .NET API, where
we had the luxury of a comprehensive standard library that includes
basic functionality such as writing a `.zip` file. In the C version, we
lack such a commodity. Rather than introducing a dependency on, say,
libzip, we slightly abuse Git's `archive` command: Instead of writing
the `.zip` file directly, we stage the file contents in a Git index of a
temporary, bare repository, only to let `git archive` have at it, and
finally removing the temporary repository.

Also note: Due to the frequently-spawned `git hash-object` processes,
this command is quite a bit slow on Windows. Should it turn out to be a
big problem, the lack of a batch mode of the `hash-object` command could
potentially be worked around via using `git fast-import` with a crafted
`stdin`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          | 170 +++++++++++++++++++++++++++++++
 contrib/scalar/scalar.txt        |  12 +++
 contrib/scalar/t/t9099-scalar.sh |  13 +++
 3 files changed, 195 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 1ce9c2b00e8..13f2b0f4d5a 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -259,6 +259,108 @@ static int unregister_dir(void)
 	return res;
 }
 
+static int stage(const char *git_dir, struct strbuf *buf, const char *path)
+{
+	struct strbuf cacheinfo = STRBUF_INIT;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	int res;
+
+	strbuf_addstr(&cacheinfo, "100644,");
+
+	cp.git_cmd = 1;
+	strvec_pushl(&cp.args, "--git-dir", git_dir,
+		     "hash-object", "-w", "--stdin", NULL);
+	res = pipe_command(&cp, buf->buf, buf->len, &cacheinfo, 256, NULL, 0);
+	if (!res) {
+		strbuf_rtrim(&cacheinfo);
+		strbuf_addch(&cacheinfo, ',');
+		/* We cannot stage `.git`, use `_git` instead. */
+		if (starts_with(path, ".git/"))
+			strbuf_addf(&cacheinfo, "_%s", path + 1);
+		else
+			strbuf_addstr(&cacheinfo, path);
+
+		child_process_init(&cp);
+		cp.git_cmd = 1;
+		strvec_pushl(&cp.args, "--git-dir", git_dir,
+			     "update-index", "--add", "--cacheinfo",
+			     cacheinfo.buf, NULL);
+		res = run_command(&cp);
+	}
+
+	strbuf_release(&cacheinfo);
+	return res;
+}
+
+static int stage_file(const char *git_dir, const char *path)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int res;
+
+	if (strbuf_read_file(&buf, path, 0) < 0)
+		return error(_("could not read '%s'"), path);
+
+	res = stage(git_dir, &buf, path);
+
+	strbuf_release(&buf);
+	return res;
+}
+
+static int stage_directory(const char *git_dir, const char *path, int recurse)
+{
+	int at_root = !*path;
+	DIR *dir = opendir(at_root ? "." : path);
+	struct dirent *e;
+	struct strbuf buf = STRBUF_INIT;
+	size_t len;
+	int res = 0;
+
+	if (!dir)
+		return error(_("could not open directory '%s'"), path);
+
+	if (!at_root)
+		strbuf_addf(&buf, "%s/", path);
+	len = buf.len;
+
+	while (!res && (e = readdir(dir))) {
+		if (!strcmp(".", e->d_name) || !strcmp("..", e->d_name))
+			continue;
+
+		strbuf_setlen(&buf, len);
+		strbuf_addstr(&buf, e->d_name);
+
+		if ((e->d_type == DT_REG && stage_file(git_dir, buf.buf)) ||
+		    (e->d_type == DT_DIR && recurse &&
+		     stage_directory(git_dir, buf.buf, recurse)))
+			res = -1;
+	}
+
+	closedir(dir);
+	strbuf_release(&buf);
+	return res;
+}
+
+static int index_to_zip(const char *git_dir)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf oid = STRBUF_INIT;
+
+	cp.git_cmd = 1;
+	strvec_pushl(&cp.args, "--git-dir", git_dir, "write-tree", NULL);
+	if (pipe_command(&cp, NULL, 0, &oid, the_hash_algo->hexsz + 1,
+			 NULL, 0))
+		return error(_("could not write temporary tree object"));
+
+	strbuf_rtrim(&oid);
+	child_process_init(&cp);
+	cp.git_cmd = 1;
+	strvec_pushl(&cp.args, "--git-dir", git_dir, "archive", "-o", NULL);
+	strvec_pushf(&cp.args, "%s.zip", git_dir);
+	strvec_pushl(&cp.args, oid.buf, "--", NULL);
+	strbuf_release(&oid);
+	return run_command(&cp);
+}
+
 /* printf-style interface, expects `<key>=<value>` argument */
 static int set_config(const char *fmt, ...)
 {
@@ -499,6 +601,73 @@ cleanup:
 	return res;
 }
 
+static int cmd_diagnose(int argc, const char **argv)
+{
+	struct option options[] = {
+		OPT_END(),
+	};
+	const char * const usage[] = {
+		N_("scalar diagnose [<enlistment>]"),
+		NULL
+	};
+	struct strbuf tmp_dir = STRBUF_INIT;
+	time_t now = time(NULL);
+	struct tm tm;
+	struct strbuf path = STRBUF_INIT, buf = STRBUF_INIT;
+	int res = 0;
+
+	argc = parse_options(argc, argv, NULL, options,
+			     usage, 0);
+
+	setup_enlistment_directory(argc, argv, usage, options, &buf);
+
+	strbuf_addstr(&buf, "/.scalarDiagnostics/scalar_");
+	strbuf_addftime(&buf, "%Y%m%d_%H%M%S", localtime_r(&now, &tm), 0, 0);
+	if (run_git("init", "-q", "-b", "dummy", "--bare", buf.buf, NULL)) {
+		res = error(_("could not initialize temporary repository: %s"),
+			    buf.buf);
+		goto diagnose_cleanup;
+	}
+	strbuf_realpath(&tmp_dir, buf.buf, 1);
+
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, "Collecting diagnostic info into temp folder %s\n\n",
+		    tmp_dir.buf);
+
+	get_version_info(&buf, 1);
+
+	strbuf_addf(&buf, "Enlistment root: %s\n", the_repository->worktree);
+	fwrite(buf.buf, buf.len, 1, stdout);
+
+	if ((res = stage(tmp_dir.buf, &buf, "diagnostics.log")))
+		goto diagnose_cleanup;
+
+	if ((res = stage_directory(tmp_dir.buf, ".git", 0)) ||
+	    (res = stage_directory(tmp_dir.buf, ".git/hooks", 0)) ||
+	    (res = stage_directory(tmp_dir.buf, ".git/info", 0)) ||
+	    (res = stage_directory(tmp_dir.buf, ".git/logs", 1)) ||
+	    (res = stage_directory(tmp_dir.buf, ".git/objects/info", 0)))
+		goto diagnose_cleanup;
+
+	res = index_to_zip(tmp_dir.buf);
+
+	if (!res)
+		res = remove_dir_recursively(&tmp_dir, 0);
+
+	if (!res)
+		printf("\n"
+		       "Diagnostics complete.\n"
+		       "All of the gathered info is captured in '%s.zip'\n",
+		       tmp_dir.buf);
+
+diagnose_cleanup:
+	strbuf_release(&tmp_dir);
+	strbuf_release(&path);
+	strbuf_release(&buf);
+
+	return res;
+}
+
 static int cmd_list(int argc, const char **argv)
 {
 	if (argc != 1)
@@ -800,6 +969,7 @@ static struct {
 	{ "reconfigure", cmd_reconfigure },
 	{ "delete", cmd_delete },
 	{ "version", cmd_version },
+	{ "diagnose", cmd_diagnose },
 	{ NULL, NULL},
 };
 
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index f416d637289..22583fe046e 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -14,6 +14,7 @@ scalar register [<enlistment>]
 scalar unregister [<enlistment>]
 scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files ) [<enlistment>]
 scalar reconfigure [ --all | <enlistment> ]
+scalar diagnose [<enlistment>]
 scalar delete <enlistment>
 
 DESCRIPTION
@@ -129,6 +130,17 @@ reconfigure the enlistment.
 With the `--all` option, all enlistments currently registered with Scalar
 will be reconfigured. Use this option after each Scalar upgrade.
 
+Diagnose
+~~~~~~~~
+
+diagnose [<enlistment>]::
+    When reporting issues with Scalar, it is often helpful to provide the
+    information gathered by this command, including logs and certain
+    statistics describing the data shape of the current enlistment.
++
+The output of this command is a `.zip` file that is written into
+a directory adjacent to the worktree in the `src` directory.
+
 Delete
 ~~~~~~
 
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index 2e1502ad45e..ecd06e207c2 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -65,6 +65,19 @@ test_expect_success 'scalar clone' '
 	)
 '
 
+SQ="'"
+test_expect_success UNZIP 'scalar diagnose' '
+	scalar diagnose cloned >out &&
+	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <out >zip_path &&
+	zip_path=$(cat zip_path) &&
+	test -n "$zip_path" &&
+	unzip -v "$zip_path" &&
+	folder=${zip_path%.zip} &&
+	test_path_is_missing "$folder" &&
+	unzip -p "$zip_path" diagnostics.log >out &&
+	test_file_not_empty out
+'
+
 test_expect_success 'scalar reconfigure' '
 	git init one/src &&
 	scalar register one &&
-- 
gitgitgadget

