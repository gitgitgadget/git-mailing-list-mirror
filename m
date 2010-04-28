From: Gerhard Wiesinger <lists@wiesinger.com>
Subject: Re: Global .git directory
Date: Wed, 28 Apr 2010 22:22:49 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1004282211431.29101@bbs.intern>
References: <alpine.LFD.2.00.1004270705280.15197@bbs.intern>  <201004271159.34071.trast@student.ethz.ch>  <alpine.LFD.2.00.1004272144470.11216@bbs.intern>  <s2y40aa078e1004271326u3fbbd46au30f187bc3ca9c8c8@mail.gmail.com>  <alpine.LFD.2.00.1004280710380.27548@bbs.intern>
 <q2k40aa078e1004280550o322dc5b8jca74d401a5eb1abe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 28 22:24:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7Dnr-0008Lr-C3
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 22:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173Ab0D1UYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 16:24:11 -0400
Received: from chello084112167138.7.11.vie.surfer.at ([84.112.167.138]:52157
	"EHLO wiesinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932166Ab0D1UYH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 16:24:07 -0400
Received: from bbs.intern (localhost [127.0.0.1])
	by wiesinger.com (8.14.4/8.14.4) with ESMTP id o3SKMq1e032000;
	Wed, 28 Apr 2010 22:22:55 +0200
Received: from localhost (gerhard@localhost)
	by bbs.intern (8.14.4/8.14.4/Submit) with ESMTP id o3SKMn0V031992;
	Wed, 28 Apr 2010 22:22:50 +0200
In-Reply-To: <q2k40aa078e1004280550o322dc5b8jca74d401a5eb1abe@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-MailScanner-Information-wiesinger-com: Please contact the ISP for more information
X-wiesinger-com-MailScanner-ID: o3SKMq1e032000
X-MailScanner-wiesinger-com: Found to be clean
X-MailScanner-SpamCheck-wiesinger-com: not spam, SpamAssassin (not cached,
	score=-4.361, required 4.5, autolearn=not spam, ALL_TRUSTED -1.80,
	AWL 0.04, BAYES_00 -2.60)
X-MailScanner-From: lists@wiesinger.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146013>

On Wed, 28 Apr 2010, Erik Faye-Lund wrote:

> On Wed, Apr 28, 2010 at 7:33 AM, Gerhard Wiesinger <lists@wiesinger.com> wrote:
>> On Tue, 27 Apr 2010, Erik Faye-Lund wrote:
>>
>>> On Tue, Apr 27, 2010 at 10:06 PM, Gerhard Wiesinger <lists@wiesinger.com>
>>> wrote:
>>>>
>>>> On Tue, 27 Apr 2010, Thomas Rast wrote:
>>>>>
>>>> Ok, rather than convincing I've written a (fast) patch which works for me
>>>> :-)
>>>>
>>>> Any comments? Any (further) changes needed? Will you include it in main
>>>> git?
>>>
> I was referring to that you sent the patch attached instead of inlined
> (as Documentation/SubmittingPatches suggests).
>
> By attaching patches you force everyone who wants to review the patch
> to have to copy and manually quote the parts of the patch that they
> have comments about instead of automatic quoting like all decent
> e-mail clients do. That way you get less people interested in the
> patch.
>
> I sent this reply because you did the right thing of cooking up a
> patch in the first place (as opposed to just arguing - very good), so
> I think you deserve a chance of getting the patch reviewed (and
> possibly included... if people agree with you, that is).

Sorry, was in a hurry, and just wanted to get the patch "out there". No
problem, patch is inline now and hopefully in the right format.

Patch is done after V1.7.1.

>From 87cc9d17ec52a6ff2b71b9851c5b61f9e1da72be Mon Sep 17 00:00:00 2001
From: Gerhard Wiesinger <lists@wiesinger.com>
Date: Wed, 28 Apr 2010 06:46:28 +0200
Subject: [PATCH 1/2] Added global git directory when environment variable GIT_DIR_GLOBAL is set, e.g. export GIT_DIR_GLOBAL=/home/gerhard/.git_global

---
  environment.h |    8 ++++++++
  setup.h       |    6 ++++++
  2 files changed, 14 insertions(+), 0 deletions(-)
  create mode 100644 environment.h
  create mode 100644 setup.h

diff --git a/environment.h b/environment.h
new file mode 100644
index 0000000..fb6a368
--- /dev/null
+++ b/environment.h
@@ -0,0 +1,8 @@
+#ifndef ENVIRONMENT_H
+#define ENVIRONMENT_H
+
+char *get_git_dir_global_base_dir(void);
+char *get_git_dir_from_environment(void);
+int is_git_dir_global_environment(void);
+
+#endif /* ENVIRONMENT_H */
diff --git a/setup.h b/setup.h
new file mode 100644
index 0000000..2047ba5
--- /dev/null
+++ b/setup.h
@@ -0,0 +1,6 @@
+#ifndef SETUP_H
+#define SETUP_H
+
+int is_git_directory(const char *suspect);
+
+#endif /* SETUP_H */
-- 
1.6.2.5

>From ac2dfd8fcbbafafa92e68b17cb9c419aad0134ed Mon Sep 17 00:00:00 2001
From: Gerhard Wiesinger <lists@wiesinger.com>
Date: Wed, 28 Apr 2010 07:13:09 +0200
Subject: [PATCH 2/2] Added global git directory when environment variable GIT_DIR_GLOBAL is set, missing files, e.g. export GIT_DIR_GLOBAL=${HOME}/.git_global

---
  builtin/init-db.c   |   38 +++++++++++++++-
  builtin/rev-parse.c |    3 +-
  cache.h             |    2 +
  environment.c       |  125 ++++++++++++++++++++++++++++++++++++++++++++++++++-
  setup.c             |    5 +-
  5 files changed, 167 insertions(+), 6 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index edc40ff..a91e762 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -7,6 +7,7 @@
  #include "builtin.h"
  #include "exec_cmd.h"
  #include "parse-options.h"
+#include "environment.h"

  #ifndef DEFAULT_GIT_TEMPLATE_DIR
  #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
@@ -34,6 +35,27 @@ static void safe_create_dir(const char *dir, int share)
  		die("Could not make %s writable by group", dir);
  }

+static void mkdir_recusive(char *directory)
+{
+	char tmp[PATH_MAX+1];
+	char *p = NULL;
+	size_t len;
+
+	snprintf(tmp, sizeof(tmp), "%s", directory);
+	len = strlen(tmp);
+	if(is_dir_sep(tmp[len - 1]))
+		tmp[len - 1] = 0;
+
+	for(p = tmp + 1; *p; p++)
+		if(is_dir_sep(*p)) {
+			char c = *p;
+			*p = 0;
+			safe_create_dir(tmp, 1);
+			*p = c;
+		}
+	safe_create_dir(tmp,1);
+}
+
  static void copy_templates_1(char *path, int baselen,
  			     char *template, int template_baselen,
  			     DIR *dir)
@@ -473,7 +495,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
  	 * GIT_WORK_TREE makes sense only in conjunction with GIT_DIR
  	 * without --bare.  Catch the error early.
  	 */
-	git_dir = getenv(GIT_DIR_ENVIRONMENT);
+	git_dir = get_git_dir_from_environment();
  	if ((!git_dir || is_bare_repository_cfg == 1)
  	    && getenv(GIT_WORK_TREE_ENVIRONMENT))
  		die("%s (or --work-tree=<directory>) not allowed without "
@@ -490,7 +512,19 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
  	if (is_bare_repository_cfg < 0)
  		is_bare_repository_cfg = guess_repository_type(git_dir);

-	if (!is_bare_repository_cfg) {
+	if (is_git_dir_global_environment()) {
+		char *global_base_dir = get_git_dir_global_base_dir();
+		mkdir_recusive(global_base_dir);
+		if (!git_work_tree_cfg) {
+			git_work_tree_cfg = xcalloc(PATH_MAX, 1);
+			strncpy(git_work_tree_cfg, global_base_dir, PATH_MAX);
+		}
+		if (access(get_git_work_tree(), X_OK))
+			die_errno ("Cannot access work tree '%s'",
+				   get_git_work_tree());
+	}
+ 
+	if (!is_bare_repository_cfg && !is_git_dir_global_environment()) {
  		if (git_dir) {
  			const char *git_dir_parent = strrchr(git_dir, '/');
  			if (git_dir_parent) {
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 8fbf9d0..b64260f 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -9,6 +9,7 @@
  #include "quote.h"
  #include "builtin.h"
  #include "parse-options.h"
+#include "environment.h"

  #define DO_REVS		1
  #define DO_NOREV	2
@@ -642,7 +643,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
  				continue;
  			}
  			if (!strcmp(arg, "--git-dir")) {
-				const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
+				const char *gitdir = get_git_dir_from_environment();
  				static char cwd[PATH_MAX];
  				int len;
  				if (gitdir) {
diff --git a/cache.h b/cache.h
index 5eb0573..57a647d 100644
--- a/cache.h
+++ b/cache.h
@@ -372,6 +372,8 @@ static inline enum object_type object_type(unsigned int mode)
  }

  #define GIT_DIR_ENVIRONMENT "GIT_DIR"
+#define GIT_DIR_GLOBAL_ENVIRONMENT "GIT_DIR_GLOBAL"
+#define GIT_DIR_GLOBAL_SPECIAL_ROOT_DIRECTORY "/SPECIAL_ROOT_DIRECTORY"
  #define GIT_WORK_TREE_ENVIRONMENT "GIT_WORK_TREE"
  #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
  #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
diff --git a/environment.c b/environment.c
index 876c5e5..d9768a9 100644
--- a/environment.c
+++ b/environment.c
@@ -8,6 +8,9 @@
   * are.
   */
  #include "cache.h"
+#include "setup.h"
+
+#define DIR_SEPARATOR "/"

  char git_default_email[MAX_GITNAME];
  char git_default_name[MAX_GITNAME];
@@ -80,9 +83,129 @@ const char * const local_repo_env[LOCAL_REPO_ENV_SIZE + 1] = {
  	NULL
  };

+char* path_shorten(char *path)
+{
+	int index = strlen(path);
+
+	while (index > 0) {
+		index--;
+		if (is_dir_sep(path[index])) {
+			path[index] = 0;
+			return path;
+		}
+	}
+
+	// should never get here
+	return "";
+}
+
+static char *get_dir_global_environment(void)
+{
+	return getenv(GIT_DIR_GLOBAL_ENVIRONMENT);
+}
+
+char *get_git_dir_global_base_dir(void)
+{
+	static char cwd_buf[PATH_MAX+1];
+	static char dir_global_buf[PATH_MAX+1];
+	static char git_dir_buf[PATH_MAX+1];
+	int global_environment_len = 0;
+	char *git_dir_global_environment = get_dir_global_environment();
+
+	if (!getcwd(cwd_buf, sizeof(cwd_buf)-1))
+		die_errno("Unable to read current working directory");
+
+	if (!is_absolute_path(git_dir_global_environment))
+		die_errno("Global environment variable" GIT_DIR_GLOBAL_ENVIRONMENT " needs absolute path!");
+
+	strncpy(dir_global_buf, git_dir_global_environment, sizeof(dir_global_buf));
+	global_environment_len = strlen(dir_global_buf);
+	if (is_dir_sep(dir_global_buf[global_environment_len]))
+		dir_global_buf[global_environment_len] = 0;
+
+	return mksnpath(git_dir_buf, sizeof(git_dir_buf), "%s%s", dir_global_buf, cwd_buf);
+}
+
+char *get_git_dir_from_global_environment(char *git_dir_global_environment)
+{
+	static char cwd_buf[PATH_MAX+1];
+	static char cwd_original_buf[PATH_MAX+1];
+	static char dir_global_buf[PATH_MAX+1];
+	static char git_dir_buf[PATH_MAX+1];
+	char *cwd = cwd_buf;
+	char *git_dir = git_dir_buf;
+	int found = 0;
+	int global_environment_len = 0;
+
+	if (!getcwd(cwd_buf, sizeof(cwd_buf)-1))
+		die_errno("Unable to read current working directory");
+
+	if (!is_absolute_path(git_dir_global_environment))
+		die_errno("Global environment variable" GIT_DIR_GLOBAL_ENVIRONMENT " needs absolute path!");
+
+	strncpy(dir_global_buf, git_dir_global_environment, sizeof(dir_global_buf));
+	global_environment_len = strlen(dir_global_buf);
+	if (is_dir_sep(dir_global_buf[global_environment_len]))
+		dir_global_buf[global_environment_len] = 0;
+
+	if (strlen(cwd) == 1 && is_dir_sep(cwd[0]))
+	{
+		// special case for / git repository
+		git_dir = mksnpath(git_dir_buf, sizeof(git_dir_buf), "%s%s" DIR_SEPARATOR "%s", dir_global_buf, GIT_DIR_GLOBAL_SPECIAL_ROOT_DIRECTORY, DEFAULT_GIT_DIR_ENVIRONMENT);
+		return git_dir;
+	}
+
+	strncpy(cwd_original_buf, cwd, sizeof(cwd_original_buf));
+
+	/*
+	 * Test in the following order (relative to the cwd):
+	 * - .git (file containing "gitdir: <path>")
+	 * - .git/
+	 * - ./ (bare)
+	 * - ../.git
+	 * - ../.git/
+	 * - ../ (bare)
+	 * - ../../.git/
+	 *   etc.
+	 */
+	for (;;) {
+		if (*cwd == '\0') {
+			break;
+		}
+
+		git_dir = mksnpath(git_dir_buf, sizeof(git_dir_buf), "%s%s" DIR_SEPARATOR "%s", dir_global_buf, cwd, DEFAULT_GIT_DIR_ENVIRONMENT);
+		if (is_git_directory(git_dir)) {
+			found = 1;
+			break;
+		}
+
+		cwd = path_shorten(cwd);
+	}
+
+	if (!found) {
+		git_dir = mksnpath(git_dir_buf, sizeof(git_dir_buf), "%s%s/%s", dir_global_buf, cwd_original_buf, DEFAULT_GIT_DIR_ENVIRONMENT);
+		return git_dir;
+	}
+
+	return git_dir;
+}
+
+int is_git_dir_global_environment(void)
+{
+	return (get_dir_global_environment() != NULL);
+}
+
+char *get_git_dir_from_environment(void)
+{
+	char *git_dir_global_environment = get_dir_global_environment();
+	if (git_dir_global_environment) return get_git_dir_from_global_environment(git_dir_global_environment);
+
+	return getenv(GIT_DIR_ENVIRONMENT);
+}
+
  static void setup_git_env(void)
  {
-	git_dir = getenv(GIT_DIR_ENVIRONMENT);
+	git_dir = get_git_dir_from_environment();
  	if (!git_dir)
  		git_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
  	if (!git_dir)
diff --git a/setup.c b/setup.c
index 5716d90..6ee3a59 100644
--- a/setup.c
+++ b/setup.c
@@ -1,5 +1,6 @@
  #include "cache.h"
  #include "dir.h"
+#include "environment.h"

  static int inside_git_dir = -1;
  static int inside_work_tree = -1;
@@ -165,7 +166,7 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
   *    a proper "ref:", or a regular file HEAD that has a properly
   *    formatted sha1 object name.
   */
-static int is_git_directory(const char *suspect)
+int is_git_directory(const char *suspect)
  {
  	char path[PATH_MAX];
  	size_t len = strlen(suspect);
@@ -337,7 +338,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
  	 * to do any discovery, but we still do repository
  	 * validation.
  	 */
-	gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
+	gitdirenv = get_git_dir_from_environment();
  	if (gitdirenv) {
  		if (PATH_MAX - 40 < strlen(gitdirenv))
  			die("'$%s' too big", GIT_DIR_ENVIRONMENT);
-- 
1.6.2.5

>From cca30ca806f9758bb0271f08808e2c830d9aba5e Mon Sep 17 00:00:00 2001
From: Gerhard Wiesinger <lists@wiesinger.com>
Date: Wed, 28 Apr 2010 07:30:01 +0200
Subject: [PATCH 3/3] Updated documentation for submitting patches

---
  Documentation/SubmittingPatches |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index abc65de..e871032 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -23,7 +23,7 @@ Checklist (and a short version for the impatient):

  	Patch:

-	- use "git format-patch -M" to create the patch
+	- use "git format-patch -M" to create the patch (e.g. git format-patch -M origin/master)
  	- do not PGP sign your patch
  	- do not attach your patch, but read in the mail
  	  body, unless you cannot teach your mailer to
-- 
1.6.2.5


Ciao,
Gerhard

--
http://www.wiesinger.com/
