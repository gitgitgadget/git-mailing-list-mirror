From: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH] add: add --chmod=+x / --chmod=-x options
Date: Tue, 24 May 2016 21:06:09 -0500
Message-ID: <20160525020609.GA20123@zoidberg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 04:06:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5ODP-0005Ks-RX
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 04:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755703AbcEYCGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 22:06:16 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:36290 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755579AbcEYCGO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 22:06:14 -0400
Received: by mail-ig0-f195.google.com with SMTP id c3so3721304igl.3
        for <git@vger.kernel.org>; Tue, 24 May 2016 19:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=P4kDCycZSloBvGQ9lDa7tT06VD42sn8L301FcU7+y8w=;
        b=YhN0SN+wp+mAuGFZCIlrX7GCMar3J0LBYFfpvYYSqfUgDVbzbK9P7y46OBSSs+/fg8
         EvEG1XmsU3+VZy0aTbZyiqVmlw7obeX7KX/asXkqphsKzmviabVTkG6pA8Zc9jYc+1Cu
         RHqZaSldMtjPGuz1HTUrqg7sQ2R9D7jg8P80gsGkbP/gBst8IGNMMVej8FwPDAGH8TSL
         SSJ5jP6e3NbqdBgEaSvWIjEA9FgIX398Ue6VFKA7VmCwX5RXWpicHyVEVC12iJAELjc0
         Vlk2QZFPY1FrSs24ogAZpk0UhGuDj1F8Mc9T2JkLHOoz6uCIsxQGG7XWAf1S3X/KpVIq
         KitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=P4kDCycZSloBvGQ9lDa7tT06VD42sn8L301FcU7+y8w=;
        b=CXz2Wy6VqUgWN6qDAzTvkPETOjYRc8/DdZxK/VPTsi4MUH4li5fTdUAyy5NX0jcZ64
         8MgQdssoF86BAPMNZp1cD6pqB7fheWGQIwc1r/ztzBGDObAIwv9uJQG1RgswSGx9QJ+J
         nKTrh+1jGYQ445PEBlazoDCro9V0/PZ5fHKhNosrTc4Hv7zWDmXmFDW3PJfF482XyhL/
         Fnuj0LAJ3HinUn6xsnAgYp9rWZLpJ2jE4vL6oerPnRnLIPN5UXSGu9tHmk90wTRsAniM
         Wf7V6bJZy7p+mO4AT8WJU5kgM4ek6ujBdOJeBXxcFZD4+fn3uxxzFknMtb1cmbWzXq5Q
         SX/A==
X-Gm-Message-State: ALyK8tJnkxyvZl6QsC3NVgMkdqoW6GBythJSlmT9HkVAVOg0lecLbH9fRE/P5kR/HrWNHA==
X-Received: by 10.50.19.231 with SMTP id i7mr14454934ige.0.1464141973331;
        Tue, 24 May 2016 19:06:13 -0700 (PDT)
Received: from zoidberg ([2601:249:1000:6850:6d00:4a6d:6eb7:3a46])
        by smtp.gmail.com with ESMTPSA id r143sm2097844ita.15.2016.05.24.19.06.11
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 May 2016 19:06:11 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295552>

Users on deficient filesystems that lack an execute bit may still
wish to add files to the repository with the appropriate execute
bit set (or not).  Although this can be done in two steps
(`git add foo && git update-index --chmod=+x foo`), providing the
`--chmod=+x` option to the add command allows users to set a file
executable in a single command that they're already familiar with.

Signed-off-by: Edward Thomson <ethomson@edwardthomson.com>
---
 builtin/add.c  | 18 +++++++++++++++++-
 cache.h        |  2 ++
 read-cache.c   |  6 ++++++
 t/t3700-add.sh | 19 +++++++++++++++++++
 4 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index 145f06e..2a9abf7 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -238,6 +238,8 @@ static int ignore_add_errors, intent_to_add, ignore_missing;
 static int addremove = ADDREMOVE_DEFAULT;
 static int addremove_explicit = -1; /* unspecified */
 
+static char should_chmod = 0;
+
 static int ignore_removal_cb(const struct option *opt, const char *arg, int unset)
 {
 	/* if we are told to ignore, we are not adding removals */
@@ -245,6 +247,15 @@ static int ignore_removal_cb(const struct option *opt, const char *arg, int unse
 	return 0;
 }
 
+static int chmod_cb(const struct option *opt, const char *arg, int unset)
+{
+	char *flip = opt->value;
+	if ((arg[0] != '-' && arg[0] != '+') || arg[1] != 'x' || arg[2])
+		return error("option 'chmod' expects \"+x\" or \"-x\"");
+	*flip = arg[0];
+	return 0;
+}
+
 static struct option builtin_add_options[] = {
 	OPT__DRY_RUN(&show_only, N_("dry run")),
 	OPT__VERBOSE(&verbose, N_("be verbose")),
@@ -263,6 +274,9 @@ static struct option builtin_add_options[] = {
 	OPT_BOOL( 0 , "refresh", &refresh_only, N_("don't add, only refresh the index")),
 	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
 	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
+	{ OPTION_CALLBACK, 0, "chmod", &should_chmod, N_("(+/-)x"),
+	  N_("override the executable bit of the listed files"),
+	  PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP, chmod_cb},
 	OPT_END(),
 };
 
@@ -346,7 +360,9 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		 (intent_to_add ? ADD_CACHE_INTENT : 0) |
 		 (ignore_add_errors ? ADD_CACHE_IGNORE_ERRORS : 0) |
 		 (!(addremove || take_worktree_changes)
-		  ? ADD_CACHE_IGNORE_REMOVAL : 0));
+		  ? ADD_CACHE_IGNORE_REMOVAL : 0)) |
+		 (should_chmod == '+' ? ADD_CACHE_FORCE_EXECUTABLE : 0) |
+		 (should_chmod == '-' ? ADD_CACHE_FORCE_NOTEXECUTABLE : 0);
 
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
index d9fb78b..81bf186 100644
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
@@ -661,6 +663,10 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 
 	if (trust_executable_bit && has_symlinks)
 		ce->ce_mode = create_ce_mode(st_mode);
+	else if (force_executable)
+		ce->ce_mode = create_ce_mode(0777);
+	else if (force_notexecutable)
+		ce->ce_mode = create_ce_mode(0666);
 	else {
 		/* If there is an existing entry, pick the mode bits and type
 		 * from it, otherwise assume unexecutable regular file.
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index f14a665..e551eaf 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -332,4 +332,23 @@ test_expect_success 'git add --dry-run --ignore-missing of non-existing file out
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
 test_done
-- 
2.6.4 (Apple Git-63)
