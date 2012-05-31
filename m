From: Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Subject: [PATCHv3] Read from XDG configuration file, not write
Date: Thu, 31 May 2012 16:40:42 +0200
Message-ID: <1338475242-21770-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
References: <1338412775-22840-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Cc: Matthieu.Moy@grenoble-inp.fr,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Lucien KONG <Lucien.Kong@ensimag.imag.fr>,
	Valentin DUPERRAY <Valentin.Duperray@ensimag.imag.fr>,
	Thomas NGUY <Thomas.Nguy@ensimag.imag.fr>,
	Franck JONAS <Franck.Jonas@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 31 16:40:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa6YX-0002MJ-Bh
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 16:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313Ab2EaOkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 10:40:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47422 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932072Ab2EaOkr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 10:40:47 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4VEWMhb025219
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 May 2012 16:32:22 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q4VEegbA030014;
	Thu, 31 May 2012 16:40:42 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q4VEegd2022437;
	Thu, 31 May 2012 16:40:42 +0200
Received: (from nguyenhu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q4VEegAN022436;
	Thu, 31 May 2012 16:40:42 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1338412775-22840-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 31 May 2012 16:32:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4VEWMhb025219
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: huynh-khoi-nguyen.nguyen@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1339079544.31411@T04dD8BnznEmoWUVd33UZA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198908>

From: NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>

Git will be able to read in $XDG_CONFIG_HOME/git/config, a new
configuration file following XDG specification. In the order of
reading, this file is between global configuration file and system
wide configuration file. Git will not be able to write in this new
configuration file. If $XDG_CONFIG_HOME is either not set or empty,
$HOME/.config/git/config will be used as new configuration file.

Signed-off-by: Huynh Khoi Nguyen NGUYEN <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Lucien KONG <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Valentin DUPERRAY <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Thomas NGUY <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Franck JONAS <Franck.Jonas@ensimag.imag.fr>
---
 Documentation/git-config.txt    |   12 ++++-
 builtin/config.c                |   37 +++++++++++-----
 cache.h                         |    1 +
 config.c                        |    5 ++
 path.c                          |   12 +++++
 t/t1306-read-xdg-config-file.sh |   87 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 139 insertions(+), 15 deletions(-)
 create mode 100755 t/t1306-read-xdg-config-file.sh

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index d9463cb..004015a 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -99,8 +99,8 @@ OPTIONS
 	For writing options: write to global ~/.gitconfig file rather than
 	the repository .git/config.
 +
-For reading options: read only from global ~/.gitconfig rather than
-from all available files.
+For reading options: read only from global ~/.gitconfig then from
+$XDG_CONFIG_HOME/git/config rather than from all available files.
 +
 See also <<FILES>>.
 
@@ -194,7 +194,7 @@ See also <<FILES>>.
 FILES
 -----
 
-If not set explicitly with '--file', there are three files where
+If not set explicitly with '--file', there are four files where
 'git config' will search for configuration options:
 
 $GIT_DIR/config::
@@ -204,6 +204,12 @@ $GIT_DIR/config::
 	User-specific configuration file. Also called "global"
 	configuration file.
 
+$XDG_CONFIG_HOME/git/config::
+	Second user-specific configuration file. If $XDG_CONFIG_HOME is not set
+	or empty, $HOME/.config/git/config will be used. Any single-valued
+	variable set in this file will be overwritten by whatever is in
+	~/.gitconfig.
+
 $(prefix)/etc/gitconfig::
 	System-wide configuration file.
 
diff --git a/builtin/config.c b/builtin/config.c
index 33c8820..3fb23a1 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -161,7 +161,7 @@ static int show_config(const char *key_, const char *value_, void *cb)
 static int get_value(const char *key_, const char *regex_)
 {
 	int ret = -1;
-	char *global = NULL, *repo_config = NULL;
+	char *gitconfig_global = NULL, *xdg_global = NULL, *repo_config = NULL;
 	const char *system_wide = NULL, *local;
 	struct config_include_data inc = CONFIG_INCLUDE_INIT;
 	config_fn_t fn;
@@ -172,7 +172,9 @@ static int get_value(const char *key_, const char *regex_)
 		const char *home = getenv("HOME");
 		local = repo_config = git_pathdup("config");
 		if (home)
-			global = xstrdup(mkpath("%s/.gitconfig", home));
+			gitconfig_global = xstrdup(mkpath("%s/.gitconfig", home));
+		if (xdg_git_path("config"))
+			xdg_global = xdg_git_path("config");
 		if (git_config_system())
 			system_wide = git_etc_gitconfig();
 	}
@@ -229,15 +231,19 @@ static int get_value(const char *key_, const char *regex_)
 
 	if (do_all && system_wide)
 		git_config_from_file(fn, system_wide, data);
-	if (do_all && global)
-		git_config_from_file(fn, global, data);
+	if (do_all && xdg_global)
+		git_config_from_file(fn, xdg_global, data);
+	if (do_all && gitconfig_global)
+		git_config_from_file(fn, gitconfig_global, data);
 	if (do_all)
 		git_config_from_file(fn, local, data);
 	git_config_from_parameters(fn, data);
 	if (!do_all && !seen)
 		git_config_from_file(fn, local, data);
-	if (!do_all && !seen && global)
-		git_config_from_file(fn, global, data);
+	if (!do_all && !seen && gitconfig_global)
+		git_config_from_file(fn, gitconfig_global, data);
+	if (!do_all && !seen && xdg_global)
+		git_config_from_file(fn, xdg_global, data);
 	if (!do_all && !seen && system_wide)
 		git_config_from_file(fn, system_wide, data);
 
@@ -254,7 +260,8 @@ static int get_value(const char *key_, const char *regex_)
 
 free_strings:
 	free(repo_config);
-	free(global);
+	free(gitconfig_global);
+	free(xdg_global);
 	return ret;
 }
 
@@ -380,12 +387,18 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 
 	if (use_global_config) {
 		char *home = getenv("HOME");
-		if (home) {
-			char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
-			given_config_file = user_config;
-		} else {
+		const char *gitconfig_path = mkpath("%s/.gitconfig", home);
+		const char *xdg_config_path = xdg_git_path("config");
+
+		if (access(gitconfig_path, R_OK) && !access(xdg_config_path, R_OK) &&
+		    (actions == ACTION_LIST ||
+		     actions == ACTION_GET_COLOR ||
+		     actions == ACTION_GET_COLORBOOL))
+			given_config_file = xdg_config_path;
+		else if (home)
+			given_config_file = xstrdup(gitconfig_path);
+		else
 			die("$HOME not set");
-		}
 	}
 	else if (use_system_config)
 		given_config_file = git_etc_gitconfig();
diff --git a/cache.h b/cache.h
index 06413e1..b86d083 100644
--- a/cache.h
+++ b/cache.h
@@ -708,6 +708,7 @@ int set_shared_perm(const char *path, int mode);
 int safe_create_leading_directories(char *path);
 int safe_create_leading_directories_const(const char *path);
 int mkdir_in_gitdir(const char *path);
+extern char *xdg_git_path(char *file);
 extern char *expand_user_path(const char *path);
 const char *enter_repo(const char *path, int strict);
 static inline int is_absolute_path(const char *path)
diff --git a/config.c b/config.c
index 71ef171..e08632f 100644
--- a/config.c
+++ b/config.c
@@ -937,6 +937,11 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 		found += 1;
 	}
 
+	if (!access(xdg_git_path("config"), R_OK)) {
+		ret += git_config_from_file(fn, xdg_git_path("config"), data);
+		found += 1;
+	}
+
 	home = getenv("HOME");
 	if (home) {
 		char buf[PATH_MAX];
diff --git a/path.c b/path.c
index 6f2aa69..7dbedb2 100644
--- a/path.c
+++ b/path.c
@@ -122,6 +122,18 @@ char *git_path(const char *fmt, ...)
 	return cleanup_path(pathname);
 }
 
+char *xdg_git_path(char *file)
+{
+	const char *home = getenv("HOME");
+	const char *xdg_config_home = getenv("XDG_CONFIG_HOME");
+
+	if (xdg_config_home)
+		return xstrdup(mkpath("%s/git/%s", xdg_config_home, file));
+	if (home)
+		return xstrdup(mkpath("%s/.config/git/%s", home, file));
+	return NULL;
+}
+
 char *git_path_submodule(const char *path, const char *fmt, ...)
 {
 	char *pathname = get_pathname();
diff --git a/t/t1306-read-xdg-config-file.sh b/t/t1306-read-xdg-config-file.sh
new file mode 100755
index 0000000..4cab38b
--- /dev/null
+++ b/t/t1306-read-xdg-config-file.sh
@@ -0,0 +1,87 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Valentin Duperray, Lucien Kong, Franck Jonas,
+#		     Thomas Nguy, Khoi Nguyen
+#		     Grenoble INP Ensimag
+#
+
+test_description='possibility to read $XDG_CONFIG_HOME/git/config file'
+
+. ./test-lib.sh
+
+test_expect_success 'read automatically: xdg file exists and ~/.gitconfig doesn'\''t' '
+	mkdir -p .config/git &&
+	echo "[advice]" >.config/git/config &&
+	echo "	statushints = false" >>.config/git/config &&
+	cat >expect <<-\EOF &&
+	# On branch master
+	#
+	# Initial commit
+	#
+	# Untracked files:
+	#	.config/
+	#	expect
+	#	output
+	nothing added to commit but untracked files present
+	EOF
+	git status >output &&
+	test_cmp expect output
+'
+
+test_expect_success 'read automatically: xdg file exists and ~/.gitconfig exists' '
+	>.gitconfig &&
+	echo "[advice]" >.gitconfig &&
+	echo "	statushints = true" >>.gitconfig &&
+	cat >expect <<-\EOF &&
+	# On branch master
+	#
+	# Initial commit
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	.config/
+	#	.gitconfig
+	#	expect
+	#	output
+	nothing added to commit but untracked files present (use "git add" to track)
+	EOF
+	git status >output &&
+	test_cmp expect output
+'
+
+test_expect_success 'read with --get: xdg file exists and ~/.gitconfig doesn'\''t' '
+	rm .gitconfig &&
+	echo "[user]" >.config/git/config &&
+	echo "	name = read_config" >>.config/git/config &&
+	echo read_config >expect &&
+	git config --get user.name >output &&
+	test_cmp expect output
+'
+
+test_expect_success 'read with --get: xdg file exists and ~/.gitconfig exists' '
+	>.gitconfig &&
+	echo "[user]" >.gitconfig &&
+	echo "	name = read_gitconfig" >>.gitconfig &&
+	echo read_gitconfig >expect &&
+	git config --get user.name >output &&
+	test_cmp expect output
+'
+
+test_expect_success 'read with --list: xdg file exists and ~/.gitconfig doesn'\''t' '
+	rm .gitconfig &&
+	echo user.name=read_config >expect &&
+	git config --global --list >output &&
+	test_cmp expect output
+'
+
+test_expect_success 'read with --list: xdg file exists and ~/.gitconfig exists' '
+	>.gitconfig &&
+	echo "[user]" >.gitconfig &&
+	echo "	name = read_gitconfig" >>.gitconfig &&
+	echo user.name=read_gitconfig >expect &&
+	git config --global --list >output &&
+	test_cmp expect output
+'
+
+test_done
-- 
1.7.8
