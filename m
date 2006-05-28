From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Read configuration also from ~/.gitrc
Date: Mon, 29 May 2006 00:26:42 +0200
Message-ID: <20060528222641.GF10488@pasky.or.cz>
References: <20060526152837.GQ23852@progsoc.uts.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 00:26:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkTib-0006sZ-TZ
	for gcvg-git@gmane.org; Mon, 29 May 2006 00:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWE1W0j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 18:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbWE1W0j
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 18:26:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:22207 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750888AbWE1W0j (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 May 2006 18:26:39 -0400
Received: (qmail 2794 invoked by uid 2001); 29 May 2006 00:26:42 +0200
To: Anand Kumria <wildfire@progsoc.uts.edu.au>
Content-Disposition: inline
In-Reply-To: <20060526152837.GQ23852@progsoc.uts.edu.au>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20906>

  Hi,

Dear diary, on Fri, May 26, 2006 at 05:28:37PM CEST, I got a letter
where Anand Kumria <wildfire@progsoc.uts.edu.au> said that...
> git is unable to construct a reasonable default email address in my
> current environment.  So, I use GIT_AUTHOR_EMAIL and GIT_COMMITTER_EMAIL
> to override things.
> 
> This has worked well but, now, I need to vary the email address for some
> repositories.  Unfortunately the environment variables override
> .git/config.
> 
> It would be good if things were like:
> 	- try to construct one automagically
> 	- use ~/.git/config (if available)
> 	- use .git/config
> 	- use environment variables
> 
> That way I could set my default email address in ~/.git/config and
> override it as required for those repositories that need it.

  hmm, might it be as simple as this?

---

This command makes Git read configuration from ~/.gitrc in addition
to the per-repository .git/config configuration file, and updates
the documentation accordingly (and also expands it a little).

Idea by Anand Kumria.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-commit-tree.txt |    9 +++++----
 Documentation/git-repo-config.txt |    6 +++---
 Documentation/git-var.txt         |    5 +++--
 Documentation/git.txt             |   15 +++++++++++----
 config.c                          |    6 +++++-
 5 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index 41d1a1c..1b0d102 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -49,8 +49,9 @@ A commit encapsulates:
 - committer name and email and the commit time.
 
 If not provided, "git-commit-tree" uses your name, hostname and domain to
-provide author and committer info. This can be overridden by
-either `.git/config` file, or using the following environment variables.
+provide author and committer info. This can be overridden by either the
+`~/.gitrc` file, the `.git/config` file, or using the following
+environment variables.
 
 	GIT_AUTHOR_NAME
 	GIT_AUTHOR_EMAIL
@@ -60,8 +61,8 @@ either `.git/config` file, or using the 
 
 (nb "<", ">" and "\n"s are stripped)
 
-In `.git/config` file, the following items are used for GIT_AUTHOR_NAME and
-GIT_AUTHOR_EMAIL:
+In the configuration file, the following items are used for GIT_AUTHOR_NAME
+and GIT_AUTHOR_EMAIL:
 
 	[user]
 		name = "Your Name"
diff --git a/Documentation/git-repo-config.txt b/Documentation/git-repo-config.txt
index 660c18f..bb7f81f 100644
--- a/Documentation/git-repo-config.txt
+++ b/Documentation/git-repo-config.txt
@@ -3,7 +3,7 @@ git-repo-config(1)
 
 NAME
 ----
-git-repo-config - Get and set options in .git/config
+git-repo-config - Get and set git runtime configuration options
 
 
 SYNOPSIS
@@ -37,7 +37,7 @@ no checks or transformations are perform
 
 This command will fail if:
 
-. The .git/config file is invalid,
+. The configuration file is invalid,
 . Can not write to .git/config,
 . no section was provided,
 . the section or key is invalid,
@@ -70,7 +70,7 @@ OPTIONS
 	Remove all matching lines from .git/config.
 
 -l, --list::
-	List all variables set in .git/config.
+	List all variables set in ~/.gitrc or .git/config.
 
 
 EXAMPLE
diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index a5b1a0d..4679aef 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -18,8 +18,9 @@ OPTIONS
 -------
 -l::
 	Cause the logical variables to be listed. In addition, all the
-	variables of the git configuration file .git/config are listed
-	as well. (However, the configuration variables listing functionality
+	variables of the git configuration files `~/.gitrc` and `.git/config`
+	are listed as well.
+	(However, the configuration variables listing functionality
 	is deprecated in favor of `git-repo-config -l`.)
 
 EXAMPLE
diff --git a/Documentation/git.txt b/Documentation/git.txt
index e474bdf..f4e5df5 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -116,7 +116,7 @@ gitlink:git-read-tree[1]::
 	Reads tree information into the index.
 
 gitlink:git-repo-config[1]::
-	Get and set options in .git/config.
+	Get and set git runtime configuration options.
 
 gitlink:git-unpack-objects[1]::
 	Unpacks objects out of a packed archive.
@@ -473,8 +473,7 @@ gitlink:gitk[1]::
 Configuration Mechanism
 -----------------------
 
-Starting from 0.99.9 (actually mid 0.99.8.GIT), `.git/config` file
-is used to hold per-repository configuration options.  It is a
+You can adjust the Git behaviour by a configuration file.  It is a
 simple text file modelled after `.ini` format familiar to some
 people.  Here is an example:
 
@@ -496,7 +495,15 @@ #
 ------------
 
 Various commands read from the configuration file and adjust
-their operation accordingly.
+their operation accordingly. See gitlink:git-repo-config[1]
+for details and list of options.
+
+Git first reads the per-user global configuration from `~/.gitrc`
+and then per-repository configuration from the `.git/config` file.
+Either of these files may be missing; the per-repository configuration
+wins in case of a conflict. Some behaviour can be also tweaked using
+environment variables; in general, they take precedence over configuration
+options.
 
 
 Identifier Terminology
diff --git a/config.c b/config.c
index 0248c6d..8a98865 100644
--- a/config.c
+++ b/config.c
@@ -312,7 +312,11 @@ int git_config_from_file(config_fn_t fn,
 
 int git_config(config_fn_t fn)
 {
-	return git_config_from_file(fn, git_path("config"));
+	int ret = 0;
+	if (getenv("HOME"))
+		ret += git_config_from_file(fn, mkpath("%s/.gitrc", getenv("HOME")));
+	ret += git_config_from_file(fn, git_path("config"));
+	return ret;
 }
 
 /*


-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
