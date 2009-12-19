From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Introduce the GIT_HOME environment variable
Date: Sat, 19 Dec 2009 17:44:54 +0100
Message-ID: <20091219164454.GJ25474@genesis.frugalware.org>
References: <4B2C0828.4010505@signalbeam.net>
 <20091219013246.GD25474@genesis.frugalware.org>
 <7vhbrnodd9.fsf@alter.siamese.dyndns.org>
 <4B2C5A1A.8000201@signalbeam.net>
 <7vzl5fik3o.fsf@alter.siamese.dyndns.org>
 <20091219153046.GG25474@genesis.frugalware.org>
 <4B2CFCD1.3010208@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Moe <moe@signalbeam.net>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 17:45:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NM2QP-0004xR-Rt
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 17:45:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752936AbZLSQo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 11:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752928AbZLSQo4
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 11:44:56 -0500
Received: from virgo.iok.hu ([212.40.97.103]:48415 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752911AbZLSQo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 11:44:56 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id B381158083;
	Sat, 19 Dec 2009 17:44:54 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 7457744965;
	Sat, 19 Dec 2009 17:44:54 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 793991240014; Sat, 19 Dec 2009 17:44:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B2CFCD1.3010208@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135494>

Honor $GIT_HOME that is favoured over $HOME, just like $GIT_EDITOR
overrides $EDITOR.  That allows us to extend the notion more naturally
in the future.  For example, when we read from $HOME/.gitconfig, if the
GIT_HOME environment is set, we instead read from $GIT_HOME/.gitconfig.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Sat, Dec 19, 2009 at 05:18:25PM +0100, Michael J Gruber <git@drmicha.warpmail.net> wrote:
> Yes, but it makes less sense this way... Junio wrote "when we start
> reading" because we don't do that yet. But we read ~/.gitconfig, of
> course, so "when we start reading" sounds funny here.
>
> (...)
>
> "different from"

Fixed both, thanks.

 Documentation/config.txt |   14 ++++++++++----
 builtin-config.c         |    8 ++++++--
 config.c                 |    4 +++-
 path.c                   |    4 +++-
 t/t1300-repo-config.sh   |    7 +++++++
 5 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a1e36d7..09cbc71 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -8,6 +8,10 @@ is used to store the configuration for that repository, and
 fallback values for the `.git/config` file. The file `/etc/gitconfig`
 can be used to store a system-wide default configuration.
 
+In case you want to store your per-user configuration in a directory
+different from `$HOME`, you can use the `$GIT_HOME` environment variable
+which has preference.
+
 The configuration variables are used by both the git plumbing
 and the porcelains. The variables are divided into sections, wherein
 the fully qualified variable name of the variable itself is the last
@@ -406,8 +410,9 @@ core.excludesfile::
 	In addition to '.gitignore' (per-directory) and
 	'.git/info/exclude', git looks into this file for patterns
 	of files which are not meant to be tracked.  "{tilde}/" is expanded
-	to the value of `$HOME` and "{tilde}user/" to the specified user's
-	home directory.  See linkgit:gitignore[5].
+	to the value of `$GIT_HOME` (or `$HOME` if `$GIT_HOME` is not
+	set) and "{tilde}user/" to the specified user's home directory.  See
+	linkgit:gitignore[5].
 
 core.editor::
 	Commands such as `commit` and `tag` that lets you edit
@@ -707,8 +712,9 @@ color.ui::
 
 commit.template::
 	Specify a file to use as the template for new commit messages.
-	"{tilde}/" is expanded to the value of `$HOME` and "{tilde}user/" to the
-	specified user's home directory.
+	"{tilde}/" is expanded to the value of `$GIT_HOME` (or `$HOME`
+	if `$GIT_HOME` is not set) and "{tilde}user/" to the specified user's
+	home directory.
 
 diff.autorefreshindex::
 	When using 'git-diff' to compare with work tree
diff --git a/builtin-config.c b/builtin-config.c
index a2d656e..da9ebd4 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -146,7 +146,9 @@ static int get_value(const char *key_, const char *regex_)
 
 	local = config_exclusive_filename;
 	if (!local) {
-		const char *home = getenv("HOME");
+		const char *home = getenv("GIT_HOME");
+		if (!home)
+			home = getenv("HOME");
 		local = repo_config = git_pathdup("config");
 		if (git_config_global() && home)
 			global = xstrdup(mkpath("%s/.gitconfig", home));
@@ -326,7 +328,9 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 	}
 
 	if (use_global_config) {
-		char *home = getenv("HOME");
+		char *home = getenv("GIT_HOME");
+		if (!home)
+			home = getenv("HOME");
 		if (home) {
 			char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
 			config_exclusive_filename = user_config;
diff --git a/config.c b/config.c
index 37385ce..7e2ccdb 100644
--- a/config.c
+++ b/config.c
@@ -711,7 +711,9 @@ int git_config(config_fn_t fn, void *data)
 		found += 1;
 	}
 
-	home = getenv("HOME");
+	home = getenv("GIT_HOME");
+	if (!home)
+		home = getenv("HOME");
 	if (git_config_global() && home) {
 		char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
 		if (!access(user_config, R_OK)) {
diff --git a/path.c b/path.c
index 2ec950b..b42a1b6 100644
--- a/path.c
+++ b/path.c
@@ -236,7 +236,9 @@ char *expand_user_path(const char *path)
 		const char *username = path + 1;
 		size_t username_len = first_slash - username;
 		if (username_len == 0) {
-			const char *home = getenv("HOME");
+			const char *home = getenv("GIT_HOME");
+			if (!home)
+				home = getenv("HOME");
 			strbuf_add(&user_path, home, strlen(home));
 		} else {
 			struct passwd *pw = getpw_str(username, username_len);
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 83b7294..d9818ab 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -18,6 +18,13 @@ EOF
 
 test_expect_success 'initial' 'cmp .git/config expect'
 
+test_expect_success 'GIT_HOME' '
+	GIT_HOME="`pwd`" &&
+	export GIT_HOME &&
+	git config --global core.penguin "little blue" &&
+	cmp "$GIT_HOME"/.gitconfig expect
+'
+
 git config Core.Movie BadPhysics
 
 cat > expect << EOF
-- 
1.6.5.2
