From: Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Subject: [PATCHv2] Possibility to read both from ~/.gitconfig and from $XDG_CONFIG_HOME/git/config
Date: Wed, 30 May 2012 23:19:35 +0200
Message-ID: <1338412775-22840-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
References: <1338400509-26087-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Cc: Matthieu.Moy@grenoble.inp.fr,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Lucien KONG <Lucien.Kong@ensimag.imag.fr>,
	Valentin DUPERRAY <Valentin.Duperray@ensimag.imag.fr>,
	Thomas NGUY <Thomas.Nguy@ensimag.imag.fr>,
	Franck JONAS <Franck.Jonas@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 30 23:19:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZqIx-0004BP-No
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 23:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754609Ab2E3VTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 17:19:39 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46956 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752357Ab2E3VTi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 17:19:38 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4ULBHvc010133
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 May 2012 23:11:17 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q4ULJaYj022762;
	Wed, 30 May 2012 23:19:36 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q4ULJZN1027620;
	Wed, 30 May 2012 23:19:36 +0200
Received: (from nguyenhu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q4ULJZd3027619;
	Wed, 30 May 2012 23:19:35 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1338400509-26087-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 30 May 2012 23:11:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4ULBHvc010133
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: huynh-khoi-nguyen.nguyen@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1339017078.40199@b/cYX2xEQATSxy6RRFFn9w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198837>

From: NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>

Git will read both in $XDG_CONFIG_HOME/git/config and in ~/.gitconfig in this order:
.git/config > ~/.gitconfig > $XDG_CONFIG_HOME/git/config > /etc/gitconfig
If $XDG_CONFIG_HOME is either not set or empty, $HOME/.config/git/config will be used.

Signed-off-by: Huynh Khoi Nguyen NGUYEN <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Lucien KONG <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Valentin DUPERRAY <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Thomas NGUY <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Franck JONAS <Franck.Jonas@ensimag.imag.fr>
---
 Documentation/git-config.txt    |    9 +++-
 builtin/config.c                |   48 +++++++++++++++++----
 config.c                        |   21 ++++++++--
 t/t1306-read-xdg-config-file.sh |   87 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 149 insertions(+), 16 deletions(-)
 create mode 100755 t/t1306-read-xdg-config-file.sh

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index d9463cb..30418fa 100644
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
@@ -204,6 +204,9 @@ $GIT_DIR/config::
 	User-specific configuration file. Also called "global"
 	configuration file.
 
+$XDG_CONFIG_HOME/git/config::
+	Second user-specific configuration file. ~/.gitconfig has priority.
+
 $(prefix)/etc/gitconfig::
 	System-wide configuration file.
 
diff --git a/builtin/config.c b/builtin/config.c
index 33c8820..38dba4f 100644
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
@@ -171,8 +171,15 @@ static int get_value(const char *key_, const char *regex_)
 	if (!local) {
 		const char *home = getenv("HOME");
 		local = repo_config = git_pathdup("config");
-		if (home)
-			global = xstrdup(mkpath("%s/.gitconfig", home));
+		if (home) {
+			const char *xdg_config_home = getenv("XDG_CONFIG_HOME");
+			if (xdg_config_home)
+				xdg_global = xstrdup(mkpath("%s/git/config", xdg_config_home));
+			else
+				xdg_global = xstrdup(mkpath("%s/.config/git/config", home));
+
+			gitconfig_global = xstrdup(mkpath("%s/.gitconfig", home));
+		}
 		if (git_config_system())
 			system_wide = git_etc_gitconfig();
 	}
@@ -229,15 +236,19 @@ static int get_value(const char *key_, const char *regex_)
 
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
 
@@ -254,7 +265,8 @@ static int get_value(const char *key_, const char *regex_)
 
 free_strings:
 	free(repo_config);
-	free(global);
+	free(gitconfig_global);
+	free(xdg_global);
 	return ret;
 }
 
@@ -381,7 +393,25 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	if (use_global_config) {
 		char *home = getenv("HOME");
 		if (home) {
-			char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
+			char *user_config;
+			const char *gitconfig_path = mkpath("%s/.gitconfig", home);
+			const char *xdg_config_path = NULL;
+			const char *xdg_config_home = NULL;
+
+			xdg_config_home = getenv("XDG_CONFIG_HOME");
+			if (xdg_config_home)
+				xdg_config_path = mkpath("%s/git/config", xdg_config_home);
+			else
+				xdg_config_path = mkpath("%s/.config/git/config", home);
+
+			if (access(gitconfig_path, R_OK) && !access(xdg_config_path, R_OK) &&
+			    (actions == ACTION_LIST ||
+			     actions == ACTION_GET_COLOR ||
+			     actions == ACTION_GET_COLORBOOL))
+				user_config = xstrdup(xdg_config_path);
+			else
+				user_config = xstrdup(gitconfig_path);
+
 			given_config_file = user_config;
 		} else {
 			die("$HOME not set");
diff --git a/config.c b/config.c
index 71ef171..53557dc 100644
--- a/config.c
+++ b/config.c
@@ -939,10 +939,23 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 
 	home = getenv("HOME");
 	if (home) {
-		char buf[PATH_MAX];
-		char *user_config = mksnpath(buf, sizeof(buf), "%s/.gitconfig", home);
-		if (!access(user_config, R_OK)) {
-			ret += git_config_from_file(fn, user_config, data);
+		const char *gitconfig_path = xstrdup(mkpath("%s/.gitconfig", home));
+		const char *xdg_config_path = NULL;
+		const char *xdg_config_home = NULL;
+
+		xdg_config_home = getenv("XDG_CONFIG_HOME");
+		if (xdg_config_home)
+			xdg_config_path = xstrdup(mkpath("%s/git/config", xdg_config_home));
+		else
+			xdg_config_path = xstrdup(mkpath("%s/.config/git/config", home));
+
+		if (!access(xdg_config_path, R_OK)) {
+			ret += git_config_from_file(fn, xdg_config_path, data);
+			found += 1;
+		}
+
+		if (!access(gitconfig_path, R_OK)) {
+			ret += git_config_from_file(fn, gitconfig_path, data);
 			found += 1;
 		}
 	}
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
