Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02CDA202DA
	for <e@80x24.org>; Tue,  7 Mar 2017 14:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755655AbdCGOd0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 09:33:26 -0500
Received: from mout.gmx.net ([212.227.17.22]:51381 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755645AbdCGOdX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 09:33:23 -0500
Received: from virtualbox ([37.201.194.72]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lusmr-1cKxvW323t-0107GH; Tue, 07
 Mar 2017 15:32:59 +0100
Date:   Tue, 7 Mar 2017 15:32:56 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v4 04/10] setup_git_directory_1(): avoid changing global
 state
In-Reply-To: <cover.1488897111.git.johannes.schindelin@gmx.de>
Message-ID: <2c8ab22700fb40c9e4e9b46f4981b45db7f2dcf2.1488897111.git.johannes.schindelin@gmx.de>
References: <cover.1488562287.git.johannes.schindelin@gmx.de> <cover.1488897111.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:p5OUZcHNPaKZqFDjs2cpODWXS+iFXuBtFkv5oU1x7CIAkRFz2It
 3QwGKX6aPg3CJTDdJ1JzXYTjPKN6XN7UTIapXiYi3fOcLtI480O0xjuxFsiDJL6hCMKtiSs
 1DV94HXEGqCHAlern8wOq5Bqp7xyCh5p7FUOWT36SoI1pMCJCwskRHpcFMyAuE3TcVwG+KP
 XgpPaMUfWRAftA03h9Adg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1WceBf2xQLw=:v9RVkVFEe8oxkqEUXY9sH8
 QElkbAzunVqg/e6/s37hYIeUkVqNFwH92B2nNma6OL5bP3663vAHc32Z6pOK+pXCzvHY2xgdy
 kdaSL8/yzY+I4JNIR5HDn/gC700Np3irVKYNaLagkl2eX3G5kM/sYKAuFhTMAxyP1I2wrN9MD
 wv7Cggl2gDSpwIQJ05HyGHgiiASfIQJmCjr6kf/rINW9Aa+czUpo8btydFrvceg7+o8nFQys9
 NgVieXHLL3p6TXBZhOHQi39KTn3LdtHfp5JZb1hfQgTH0N6m63alfGHjEHhogW9RzAFLp/uP5
 gH+6GgDxFt8DDopJgNM5YPr5sN/oLdMyly6EPxsj3aOuguON8s/T4RiOeC8q5V0Xrxw/E4Yd0
 3gyDn/gyH6ClhgiYd9hNv5kY3SuHoCIKH0NwqWWPq0SnOyASRSOhKHVc8bMWsWjShT6mThbdz
 R6vhMhYvlIz/FuqZg51ENMH3LAvu8gyEgyfCNf7dVaQoGtX2mEHx2+hhSGbL4VrM8XiAVgk/+
 JpSc2Cx/7E13zWFjY2bJ9kJC/BftRtKQjc7YynZxR6CD/8bYRmLkN2yf/wQ27KhMX3qQnhGrJ
 W/M5tvPHmYYGgzNFslmf6wQZOGcWCI3oXtS3KybnIQP/j4jm2bChtmzy1a/YyuWa1eDUs4a1E
 ZFKokuA2flDKuoyDXp1y5klUi+6AZ9qsZXZcXGiMDSdTx9pcyqpIfIm9SV4XaatzqiskZ/3AT
 6Gox3f5DxwaQI4yismAtsyGxzCvUcdZOPafMv2eUgfWHeKguldHmxDdO0DdkIpgHkC8RO8+/6
 v/tXlkeaocP3fX0ogZjxIPwAQ6cmZVThEuZ+6r1bQCWHfRQNsITfwkWISWqs+6NuAHBewaY1A
 EW+skWmTacKagfN6Y1+oujrtDDRwxF/onWsLHf2rBqYARCTFkaJbFXNjrNo5qaglQBfjFyQW/
 ePg71S117+XVwJFKWSgpoiPVUzkBKbGkktOUHTN3U3yekm7lg3knXBfkVoCRcc7SPpuLVjRoz
 rXB7r7VEDliM9QdBUzxr9lVFOTi7ZzlxS2mFEOw0qisNEEGFC+gOrz6IMOB4OOuuzw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For historical reasons, Git searches for the .git/ directory (or the
.git file) by changing the working directory successively to the parent
directory of the current directory, until either anything was found or
until a ceiling or a mount point is hit.

Further global state may be changed in case a .git/ directory was found.

We do have a use case, though, where we would like to find the .git/
directory without having any global state touched, though: when we read
the early config e.g. for the pager or for alias expansion.

Let's just move all of code that changes any global state out of the
function `setup_git_directory_gently_1()` into
`setup_git_directory_gently()`.

In subsequent patches, we will use the _1() function in a new
`discover_git_directory()` function that we will then use for the early
config code.

Note: the new loop is a *little* tricky, as we have to handle the root
directory specially: we cannot simply strip away the last component
including the slash, as the root directory only has that slash. To remedy
that, we introduce the `min_offset` variable that holds the minimal length
of an absolute path, and using that to special-case the root directory,
including an early exit before trying to find the parent of the root
directory.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 setup.c | 187 ++++++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 112 insertions(+), 75 deletions(-)

diff --git a/setup.c b/setup.c
index 20a1f0f870e..d7af343d14e 100644
--- a/setup.c
+++ b/setup.c
@@ -818,50 +818,49 @@ static int canonicalize_ceiling_entry(struct string_list_item *item,
 	}
 }
 
+enum discovery_result {
+	GIT_DIR_NONE = 0,
+	GIT_DIR_EXPLICIT,
+	GIT_DIR_DISCOVERED,
+	GIT_DIR_BARE,
+	/* these are errors */
+	GIT_DIR_HIT_CEILING = -1,
+	GIT_DIR_HIT_MOUNT_POINT = -2
+};
+
 /*
  * We cannot decide in this function whether we are in the work tree or
  * not, since the config can only be read _after_ this function was called.
+ *
+ * Also, we avoid changing any global state (such as the current working
+ * directory) to allow early callers.
+ *
+ * The directory where the search should start needs to be passed in via the
+ * `dir` parameter; upon return, the `dir` buffer will contain the path of
+ * the directory where the search ended, and `gitdir` will contain the path of
+ * the discovered .git/ directory, if any. This path may be relative against
+ * `dir` (i.e. *not* necessarily the cwd).
  */
-static const char *setup_git_directory_gently_1(int *nongit_ok)
+static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
+							  struct strbuf *gitdir)
 {
 	const char *env_ceiling_dirs = getenv(CEILING_DIRECTORIES_ENVIRONMENT);
 	struct string_list ceiling_dirs = STRING_LIST_INIT_DUP;
-	static struct strbuf cwd = STRBUF_INIT;
-	const char *gitdirenv, *ret;
-	char *gitfile;
-	int offset, offset_parent, ceil_offset = -1;
+	const char *gitdirenv;
+	int ceil_offset = -1, min_offset = has_dos_drive_prefix(dir->buf) ? 3 : 1;
 	dev_t current_device = 0;
 	int one_filesystem = 1;
 
 	/*
-	 * We may have read an incomplete configuration before
-	 * setting-up the git directory. If so, clear the cache so
-	 * that the next queries to the configuration reload complete
-	 * configuration (including the per-repo config file that we
-	 * ignored previously).
-	 */
-	git_config_clear();
-
-	/*
-	 * Let's assume that we are in a git repository.
-	 * If it turns out later that we are somewhere else, the value will be
-	 * updated accordingly.
-	 */
-	if (nongit_ok)
-		*nongit_ok = 0;
-
-	if (strbuf_getcwd(&cwd))
-		die_errno(_("Unable to read current working directory"));
-	offset = cwd.len;
-
-	/*
 	 * If GIT_DIR is set explicitly, we're not going
 	 * to do any discovery, but we still do repository
 	 * validation.
 	 */
 	gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
-	if (gitdirenv)
-		return setup_explicit_git_dir(gitdirenv, &cwd, nongit_ok);
+	if (gitdirenv) {
+		strbuf_addstr(gitdir, gitdirenv);
+		return GIT_DIR_EXPLICIT;
+	}
 
 	if (env_ceiling_dirs) {
 		int empty_entry_found = 0;
@@ -869,15 +868,15 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 		string_list_split(&ceiling_dirs, env_ceiling_dirs, PATH_SEP, -1);
 		filter_string_list(&ceiling_dirs, 0,
 				   canonicalize_ceiling_entry, &empty_entry_found);
-		ceil_offset = longest_ancestor_length(cwd.buf, &ceiling_dirs);
+		ceil_offset = longest_ancestor_length(dir->buf, &ceiling_dirs);
 		string_list_clear(&ceiling_dirs, 0);
 	}
 
-	if (ceil_offset < 0 && has_dos_drive_prefix(cwd.buf))
-		ceil_offset = 1;
+	if (ceil_offset < 0)
+		ceil_offset = min_offset - 2;
 
 	/*
-	 * Test in the following order (relative to the cwd):
+	 * Test in the following order (relative to the dir):
 	 * - .git (file containing "gitdir: <path>")
 	 * - .git/
 	 * - ./ (bare)
@@ -889,63 +888,101 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 	 */
 	one_filesystem = !git_env_bool("GIT_DISCOVERY_ACROSS_FILESYSTEM", 0);
 	if (one_filesystem)
-		current_device = get_device_or_die(".", NULL, 0);
+		current_device = get_device_or_die(dir->buf, NULL, 0);
 	for (;;) {
-		gitfile = (char*)read_gitfile(DEFAULT_GIT_DIR_ENVIRONMENT);
-		if (gitfile)
-			gitdirenv = gitfile = xstrdup(gitfile);
-		else {
-			if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))
-				gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
+		int offset = dir->len;
+
+		if (offset > min_offset)
+			strbuf_addch(dir, '/');
+		strbuf_addstr(dir, DEFAULT_GIT_DIR_ENVIRONMENT);
+		gitdirenv = read_gitfile(dir->buf);
+		if (!gitdirenv && is_git_directory(dir->buf))
+			gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
+		strbuf_setlen(dir, offset);
+		if (gitdirenv) {
+			strbuf_addstr(gitdir, gitdirenv);
+			return GIT_DIR_DISCOVERED;
 		}
 
-		if (gitdirenv) {
-			ret = setup_discovered_git_dir(gitdirenv,
-						       &cwd, offset,
-						       nongit_ok);
-			free(gitfile);
-			return ret;
+		if (is_git_directory(dir->buf)) {
+			strbuf_addstr(gitdir, ".");
+			return GIT_DIR_BARE;
 		}
-		free(gitfile);
 
-		if (is_git_directory("."))
-			return setup_bare_git_dir(&cwd, offset, nongit_ok);
+		if (offset <= min_offset)
+			return GIT_DIR_HIT_CEILING;
 
-		offset_parent = offset;
-		while (--offset_parent > ceil_offset &&
-		       !is_dir_sep(cwd.buf[offset_parent]))
+		while (--offset > ceil_offset && !is_dir_sep(dir->buf[offset]))
 			; /* continue */
-		if (offset_parent <= ceil_offset)
-			return setup_nongit(cwd.buf, nongit_ok);
-		if (one_filesystem) {
-			dev_t parent_device = get_device_or_die("..", cwd.buf,
-								offset);
-			if (parent_device != current_device) {
-				if (nongit_ok) {
-					if (chdir(cwd.buf))
-						die_errno(_("Cannot come back to cwd"));
-					*nongit_ok = 1;
-					return NULL;
-				}
-				strbuf_setlen(&cwd, offset);
-				die(_("Not a git repository (or any parent up to mount point %s)\n"
-				"Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)."),
-				    cwd.buf);
-			}
-		}
-		if (chdir("..")) {
-			strbuf_setlen(&cwd, offset);
-			die_errno(_("Cannot change to '%s/..'"), cwd.buf);
-		}
-		offset = offset_parent;
+		if (offset <= ceil_offset)
+			return GIT_DIR_HIT_CEILING;
+
+		strbuf_setlen(dir, offset > min_offset ?  offset : min_offset);
+		if (one_filesystem &&
+		    current_device != get_device_or_die(dir->buf, NULL, offset))
+			return GIT_DIR_HIT_MOUNT_POINT;
 	}
 }
 
 const char *setup_git_directory_gently(int *nongit_ok)
 {
+	struct strbuf cwd = STRBUF_INIT, dir = STRBUF_INIT, gitdir = STRBUF_INIT;
 	const char *prefix;
 
-	prefix = setup_git_directory_gently_1(nongit_ok);
+	/*
+	 * We may have read an incomplete configuration before
+	 * setting-up the git directory. If so, clear the cache so
+	 * that the next queries to the configuration reload complete
+	 * configuration (including the per-repo config file that we
+	 * ignored previously).
+	 */
+	git_config_clear();
+
+	/*
+	 * Let's assume that we are in a git repository.
+	 * If it turns out later that we are somewhere else, the value will be
+	 * updated accordingly.
+	 */
+	if (nongit_ok)
+		*nongit_ok = 0;
+
+	if (strbuf_getcwd(&cwd))
+		die_errno(_("Unable to read current working directory"));
+	strbuf_addbuf(&dir, &cwd);
+
+	switch (setup_git_directory_gently_1(&dir, &gitdir)) {
+	case GIT_DIR_NONE:
+		prefix = NULL;
+		break;
+	case GIT_DIR_EXPLICIT:
+		prefix = setup_explicit_git_dir(gitdir.buf, &cwd, nongit_ok);
+		break;
+	case GIT_DIR_DISCOVERED:
+		if (dir.len < cwd.len && chdir(dir.buf))
+			die(_("Cannot change to '%s'"), dir.buf);
+		prefix = setup_discovered_git_dir(gitdir.buf, &cwd, dir.len,
+						  nongit_ok);
+		break;
+	case GIT_DIR_BARE:
+		if (dir.len < cwd.len && chdir(dir.buf))
+			die(_("Cannot change to '%s'"), dir.buf);
+		prefix = setup_bare_git_dir(&cwd, dir.len, nongit_ok);
+		break;
+	case GIT_DIR_HIT_CEILING:
+		prefix = setup_nongit(cwd.buf, nongit_ok);
+		break;
+	case GIT_DIR_HIT_MOUNT_POINT:
+		if (nongit_ok) {
+			*nongit_ok = 1;
+			return NULL;
+		}
+		die(_("Not a git repository (or any parent up to mount point %s)\n"
+		      "Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)."),
+		    dir.buf);
+	default:
+		die("BUG: unhandled setup_git_directory_1() result");
+	}
+
 	if (prefix)
 		setenv(GIT_PREFIX_ENVIRONMENT, prefix, 1);
 	else
-- 
2.12.0.windows.1.7.g94dafc3b124


