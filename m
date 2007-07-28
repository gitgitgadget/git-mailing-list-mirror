From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] Add a --user option to git-config
Date: Sat, 28 Jul 2007 17:35:13 +0100
Message-ID: <46AB7041.8070605@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jul 28 19:38:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEqF5-0006kU-2j
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 19:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448AbXG1RiL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 13:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754451AbXG1RiK
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 13:38:10 -0400
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:2646 "EHLO
	anchor-post-36.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754410AbXG1RiJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jul 2007 13:38:09 -0400
X-Greylist: delayed 1286 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Jul 2007 13:38:09 EDT
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-36.mail.demon.net with esmtp (Exim 4.42)
	id 1IEpuC-000Hk7-Jt; Sat, 28 Jul 2007 17:16:41 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54043>


At present, the --global option is something of a misnomer, so
we introduce the --user option as a synonym, with the intention
of removing the old option in the future.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

I have recently had the need to create a ~/.gitconfig file for the
first time and I was reminded of this patch. Maybe it's just me who
thinks that --global is odd ... ;-)  Particularly since the system
config file was added.

Actually my config editor of choice is vim, so this is not a high
priority for me.

[This is against 1.5.2, but will hopefully not be too difficult to
forward to current git]

ATB,

Ramsay Jones

 Documentation/git-config.txt           |   30 +++++++++++++++---------------
 Documentation/git-repo-config.txt      |    2 +-
 Documentation/tutorial.txt             |    4 ++--
 Documentation/user-manual.txt          |    2 +-
 builtin-config.c                       |    5 +++--
 contrib/completion/git-completion.bash |    2 +-
 ident.c                                |    2 +-
 7 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 280ef20..26138c4 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -3,22 +3,22 @@ git-config(1)
 
 NAME
 ----
-git-config - Get and set repository or global options
+git-config - Get and set repository, user or system-wide options
 
 
 SYNOPSIS
 --------
 [verse]
-'git-config' [--system | --global] [type] name [value [value_regex]]
-'git-config' [--system | --global] [type] --add name value
-'git-config' [--system | --global] [type] --replace-all name [value [value_regex]]
-'git-config' [--system | --global] [type] --get name [value_regex]
-'git-config' [--system | --global] [type] --get-all name [value_regex]
-'git-config' [--system | --global] [type] --unset name [value_regex]
-'git-config' [--system | --global] [type] --unset-all name [value_regex]
-'git-config' [--system | --global] [type] --rename-section old_name new_name
-'git-config' [--system | --global] [type] --remove-section name
-'git-config' [--system | --global] -l | --list
+'git-config' [--system | --user] [type] name [value [value_regex]]
+'git-config' [--system | --user] [type] --add name value
+'git-config' [--system | --user] [type] --replace-all name [value [value_regex]]
+'git-config' [--system | --user] [type] --get name [value_regex]
+'git-config' [--system | --user] [type] --get-all name [value_regex]
+'git-config' [--system | --user] [type] --unset name [value_regex]
+'git-config' [--system | --user] [type] --unset-all name [value_regex]
+'git-config' [--system | --user] [type] --rename-section old_name new_name
+'git-config' [--system | --user] [type] --remove-section name
+'git-config' [--system | --user] -l | --list
 
 DESCRIPTION
 -----------
@@ -47,7 +47,7 @@ This command will fail if:
 . the section or key is invalid,
 . you try to unset an option which does not exist,
 . you try to unset/set an option for which multiple lines match, or
-. you use --global option without $HOME being properly set.
+. you use --user option without $HOME being properly set.
 
 
 OPTIONS
@@ -73,8 +73,8 @@ OPTIONS
 --get-regexp::
 	Like --get-all, but interprets the name as a regular expression.
 
---global::
-	Use global ~/.gitconfig file rather than the repository .git/config.
+--user::
+	Use per user ~/.gitconfig file rather than the repository .git/config.
 
 --system::
 	Use system-wide $(prefix)/etc/gitconfig rather than the repository
@@ -110,7 +110,7 @@ ENVIRONMENT
 
 GIT_CONFIG::
 	Take the configuration from the given file instead of .git/config.
-	Using the "--global" option forces this to ~/.gitconfig.
+	Using the "--user" option forces this to ~/.gitconfig.
 
 GIT_CONFIG_LOCAL::
 	Currently the same as $GIT_CONFIG; when Git will support global
diff --git a/Documentation/git-repo-config.txt b/Documentation/git-repo-config.txt
index 2deba31..8eec3cd 100644
--- a/Documentation/git-repo-config.txt
+++ b/Documentation/git-repo-config.txt
@@ -3,7 +3,7 @@ git-repo-config(1)
 
 NAME
 ----
-git-repo-config - Get and set repository or global options
+git-repo-config - Get and set repository, user or system-wide options
 
 
 SYNOPSIS
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index f55d408..a401638 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -20,8 +20,8 @@ public email address before doing any operation.  The easiest
 way to do so is:
 
 ------------------------------------------------
-$ git config --global user.name "Your Name Comes Here"
-$ git config --global user.email you@yourdomain.example.com
+$ git config --user user.name "Your Name Comes Here"
+$ git config --user user.email you@yourdomain.example.com
 ------------------------------------------------
 
 
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 52247aa..105e362 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1147,7 +1147,7 @@ The file specified by the `core.excludesfile` config directive:::
 	   more information on configuration options). This config directive
 	   can be set in the per-repo `.git/config` file, in which case the
 	   exclude patterns will apply to that repo only. Alternatively, you
-	   can set the directive in the global `~/.gitconfig` file to apply
+	   can set the directive in the per-user `~/.gitconfig` file to apply
 	   the exclude pattern to all your git repos. As with the above
 	   `.git/info/exclude` (and, indeed, with git config directives in
 	   general), this directive does not follow push/pull/clone, but remain
diff --git a/builtin-config.c b/builtin-config.c
index b2515f7..1850d9d 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -2,7 +2,7 @@
 #include "cache.h"
 
 static const char git_config_set_usage[] =
-"git-config [ --global | --system ] [ --bool | --int ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list";
+"git-config [ --user | --system ] [ --bool | --int ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list";
 
 static char *key;
 static regex_t *key_regexp;
@@ -143,7 +143,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			type = T_BOOL;
 		else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l"))
 			return git_config(show_all_config);
-		else if (!strcmp(argv[1], "--global")) {
+		else if (!strcmp(argv[1], "--user") ||
+				!strcmp(argv[1], "--global")) {
 			char *home = getenv("HOME");
 			if (home) {
 				char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 46356e8..cb5a457 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -745,7 +745,7 @@ _git_config ()
 	case "$cur" in
 	--*)
 		__gitcomp "
-			--global --list --replace-all
+			--user --list --replace-all
 			--get --get-all --get-regexp
 			--add --unset --unset-all
 			"
diff --git a/ident.c b/ident.c
index 69a04b8..21dca3a 100644
--- a/ident.c
+++ b/ident.c
@@ -182,7 +182,7 @@ static const char *env_hint =
 "  git config user.name \"Your Name\"\n"
 "\n"
 "To set the identity in this repository.\n"
-"Add --global to set your account\'s default\n"
+"Add --user to set your account\'s default\n"
 "\n";
 
 const char *fmt_ident(const char *name, const char *email,
-- 
1.5.2
