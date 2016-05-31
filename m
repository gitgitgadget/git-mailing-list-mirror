From: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH] add: add --chmod=+x / --chmod=-x options
Date: Tue, 31 May 2016 17:08:18 -0500
Message-ID: <20160531220818.GB46739@zoidberg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 00:08:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7rpt-0003vz-8V
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 00:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488AbcEaWIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 18:08:25 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36636 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbcEaWIY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 18:08:24 -0400
Received: by mail-io0-f196.google.com with SMTP id m17so618866ioi.3
        for <git@vger.kernel.org>; Tue, 31 May 2016 15:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1rRhk4jEdzMmSyeUnAIx23+sY2a1n/q1MFlt6++nBQs=;
        b=NKfE3qje8VEBDCZgk/MjRPpFMyAZkyz7VnD6bdDCk7Dwwgt8z2Dhwdvo4owzMKNpVX
         QsTX1fcfajKvK/aL5jSd0fQBCEDK359P3y0lehJERne1pbQEk81M2y0qYT0PgG7Op+ZE
         EupsboPspDZ6jlbI1Nc3UilKk1o1C/OKpVSapzwQNPj042+4jpM7PCdP7dMHIKvwwI43
         4K/eoV0B69XH+e1gLXY/FopUSu+sJjqrWjp1DVTbpYOs0UQz+H5+ALKYeCnQHIm3T2aE
         rDAEah6nNdVLo7M1qOPcGu7vGBgDhfm19reuqvG+ZsDxpAX+VZ6mgh6ErBWQ2Y+YR4gC
         wWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1rRhk4jEdzMmSyeUnAIx23+sY2a1n/q1MFlt6++nBQs=;
        b=BX/SwKFs4pYydqpT4uSGmpm3Bbk5MJwMP0G9zA7Fdm0xQxMhEt8boPCyWYWIINj517
         Q3+q6M+ho7GwUMjUCg2+HfyBfsP2nTGX0G5cjynmyRom2d+FHqKBBtmWO5v4nn72U3DA
         jZX4u4y4qjqfUnzC5i2QPAmyBvpAzFIysSgecSy8t6vyEGXRIirCZ5SdoVPvYp4Ie3/2
         bnal3vj0mX1NsDOy7CuWdzn9V5fpZABmbcvjft7bHN89rwH/p7xJiRQYrM26DFYFNV2+
         sG2tIEbMVYJ1U6s3qR/AjN/bWV0yHjGr//cCawlwmDbB3OYChat1QBNMU8b4VsFU0Puh
         1cBg==
X-Gm-Message-State: ALyK8tJDYk01Xenb5y2E0G02LqmJ6dwzP+2VSbNcBFsUKWLdCL+U3C7YN0pZXaVrgNEW0w==
X-Received: by 10.107.26.206 with SMTP id a197mr1014459ioa.148.1464732503465;
        Tue, 31 May 2016 15:08:23 -0700 (PDT)
Received: from zoidberg ([2601:249:1000:6850:f5c8:2af2:b531:a3f6])
        by smtp.gmail.com with ESMTPSA id r83sm13865590ioi.10.2016.05.31.15.08.21
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 May 2016 15:08:22 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296019>

The executable bit will not be detected (and therefore will not be
set) for paths in a repository with `core.filemode` set to false,
though the users may still wish to add files as executable for
compatibility with other users who _do_ have `core.filemode`
functionality.  For example, Windows users adding shell scripts may
wish to add them as executable for compatibility with users on
non-Windows.

Although this can be done with a plumbing command
(`git update-index --add --chmod=+x foo`), teaching the `git-add`
command allows users to set a file executable with a command that
they're already familiar with.

Signed-off-by: Edward Thomson <ethomson@edwardthomson.com>
---
 builtin/add.c  | 12 +++++++++++-
 cache.h        |  2 ++
 read-cache.c   | 11 +++++++++--
 t/t3700-add.sh | 30 ++++++++++++++++++++++++++++++
 4 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 145f06e..44b6c97 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -238,6 +238,8 @@ static int ignore_add_errors, intent_to_add, ignore_missing;
 static int addremove = ADDREMOVE_DEFAULT;
 static int addremove_explicit = -1; /* unspecified */
 
+static char *chmod_arg = NULL;
+
 static int ignore_removal_cb(const struct option *opt, const char *arg, int unset)
 {
 	/* if we are told to ignore, we are not adding removals */
@@ -263,6 +265,7 @@ static struct option builtin_add_options[] = {
 	OPT_BOOL( 0 , "refresh", &refresh_only, N_("don't add, only refresh the index")),
 	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
 	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
+	OPT_STRING( 0 , "chmod", &chmod_arg, N_("(+/-)x"), N_("override the executable bit of the listed files")),
 	OPT_END(),
 };
 
@@ -336,6 +339,11 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (!show_only && ignore_missing)
 		die(_("Option --ignore-missing can only be used together with --dry-run"));
 
+	if (chmod_arg) {
+		if (strcmp(chmod_arg, "-x") && strcmp(chmod_arg, "+x"))
+			die(_("--chmod param must be either -x or +x"));
+	}
+
 	add_new_files = !take_worktree_changes && !refresh_only;
 	require_pathspec = !(take_worktree_changes || (0 < addremove_explicit));
 
@@ -346,7 +354,9 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		 (intent_to_add ? ADD_CACHE_INTENT : 0) |
 		 (ignore_add_errors ? ADD_CACHE_IGNORE_ERRORS : 0) |
 		 (!(addremove || take_worktree_changes)
-		  ? ADD_CACHE_IGNORE_REMOVAL : 0));
+		  ? ADD_CACHE_IGNORE_REMOVAL : 0)) |
+		 (chmod_arg && *chmod_arg == '+' ? ADD_CACHE_FORCE_EXECUTABLE : 0) |
+		 (chmod_arg && *chmod_arg == '-' ? ADD_CACHE_FORCE_NOTEXECUTABLE : 0);
 
 	if (require_pathspec && argc == 0) {
 		fprintf(stderr, _("Nothing specified, nothing added.\n"));
diff --git a/cache.h b/cache.h
index 6049f86..da03cd9 100644
--- a/cache.h
+++ b/cache.h
@@ -581,6 +581,8 @@ extern int remove_file_from_index(struct index_state *, const char *path);
 #define ADD_CACHE_IGNORE_ERRORS	4
 #define ADD_CACHE_IGNORE_REMOVAL 8
 #define ADD_CACHE_INTENT 16
+#define ADD_CACHE_FORCE_EXECUTABLE 32
+#define ADD_CACHE_FORCE_NOTEXECUTABLE 64
 extern int add_to_index(struct index_state *, const char *path, struct stat *, int flags);
 extern int add_file_to_index(struct index_state *, const char *path, int flags);
 extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, unsigned int refresh_options);
diff --git a/read-cache.c b/read-cache.c
index d9fb78b..d12d143 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -641,6 +641,8 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	int intent_only = flags & ADD_CACHE_INTENT;
 	int add_option = (ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE|
 			  (intent_only ? ADD_CACHE_NEW_ONLY : 0));
+	int force_executable = flags & ADD_CACHE_FORCE_EXECUTABLE;
+	int force_notexecutable = flags & ADD_CACHE_FORCE_NOTEXECUTABLE;
 
 	if (!S_ISREG(st_mode) && !S_ISLNK(st_mode) && !S_ISDIR(st_mode))
 		return error("%s: can only add regular files, symbolic links or git-directories", path);
@@ -659,9 +661,14 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	else
 		ce->ce_flags |= CE_INTENT_TO_ADD;
 
-	if (trust_executable_bit && has_symlinks)
+	if (S_ISREG(st_mode) && (force_executable || force_notexecutable)) {
+		if (force_executable)
+			ce->ce_mode = create_ce_mode(0777);
+		else
+			ce->ce_mode = create_ce_mode(0666);
+	} else if (trust_executable_bit && has_symlinks) {
 		ce->ce_mode = create_ce_mode(st_mode);
-	else {
+	} else {
 		/* If there is an existing entry, pick the mode bits and type
 		 * from it, otherwise assume unexecutable regular file.
 		 */
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index f14a665..4865304 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -332,4 +332,34 @@ test_expect_success 'git add --dry-run --ignore-missing of non-existing file out
 	test_i18ncmp expect.err actual.err
 '
 
+test_expect_success 'git add --chmod=+x stages a non-executable file with +x' '
+	echo foo >foo1 &&
+	git add --chmod=+x foo1 &&
+	case "$(git ls-files --stage foo1)" in
+	100755" "*foo1) echo pass;;
+	*) echo fail; git ls-files --stage foo1; (exit 1);;
+	esac
+'
+
+test_expect_success 'git add --chmod=-x stages an executable file with -x' '
+	echo foo >xfoo1 &&
+	chmod 755 xfoo1 &&
+	git add --chmod=-x xfoo1 &&
+	case "$(git ls-files --stage xfoo1)" in
+	100644" "*xfoo1) echo pass;;
+	*) echo fail; git ls-files --stage xfoo1; (exit 1);;
+	esac
+'
+
+test_expect_success POSIXPERM,SYMLINKS 'git add --chmod=+x with symlinks' '
+	git config core.filemode 1 &&
+	git config core.symlinks 1 &&
+	echo foo >foo2 &&
+	git add --chmod=+x foo2 &&
+	case "$(git ls-files --stage foo2)" in
+	100755" "*foo2) echo pass;;
+	*) echo fail; git ls-files --stage foo2; (exit 1);;
+	esac
+'
+
 test_done
-- 
2.7.4 (Apple Git-66)
