From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 4/4] Document the configuration file
Date: Tue, 25 Apr 2006 00:59:33 +0200
Message-ID: <20060424225933.14086.42932.stgit@machine.or.cz>
References: <20060424225925.14086.97825.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 25 00:59:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYA1b-0005DF-0v
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 00:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWDXW7K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Apr 2006 18:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWDXW7K
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Apr 2006 18:59:10 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51115 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932099AbWDXW7I (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Apr 2006 18:59:08 -0400
Received: (qmail 14250 invoked from network); 25 Apr 2006 00:59:33 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 25 Apr 2006 00:59:33 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060424225925.14086.97825.stgit@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19116>

This patch adds a Documentation/config.txt file included by git-repo-config
and currently aggregating hopefully all the available git plumbing / core
porcelain configuration variables, as well as briefly describing the format.

It also updates an outdated bit of the example in git-repo-config(1).

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/config.txt          |  181 +++++++++++++++++++++++++++++++++++++
 Documentation/git-repo-config.txt |   29 +++---
 config.c                          |    2 
 3 files changed, 198 insertions(+), 14 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
new file mode 100644
index 0000000..6cd9670
--- /dev/null
+++ b/Documentation/config.txt
@@ -0,0 +1,181 @@
+CONFIGURATION FILE
+------------------
+
+The git configuration file contains a number of variables that affect
+the git commands behaviour. They can be used by both the git plumbing
+and the porcelains. The variables are divided to sections, where
+in the fully qualified variable name the variable itself is the last
+dot-separated segment and the section name is everything before the last
+dot. The variable names are case-insensitive and only alphanumeric
+characters are allowed. Some variables may appear multiple times.
+
+The syntax is fairly flexible and permissive; whitespaces are mostly
+ignored. The '#' and ';' characters begin commends to the end of line,
+blank lines are ignored, lines containing strings enclosed in square
+brackets start sections and all the other lines are recognized
+as setting variables, in the form 'name = value'. If there is no equal
+sign on the line, the entire line is taken as 'name' and the variable
+is recognized as boolean "true". String values may be entirely or partially
+enclosed in double quotes; some variables may require special value format.
+
+Example
+~~~~~~~
+
+	# Core variables
+	[core]
+		; Don't trust file modes
+		filemode = false
+	
+	# Our diff algorithm
+	[diff]
+		external = "/usr/local/bin/gnu-diff -u"
+		renames = true
+
+Variables
+~~~~~~~~~
+
+Note that this list is non-comprehensive and not necessarily complete.
+For command-specific variables, you will find more detailed description
+in the appropriate manual page. You will find description of non-core
+porcelain configuration variables in the respective porcelain documentation.
+
+core.fileMode::
+	If false, the executable bit differences between the index and
+	the working copy are ignored; useful on broken filesystems like FAT.
+	See gitlink:git-update-index[1]. True by default.
+
+core.gitProxy::
+	A "proxy command" to execute (as 'command host port') instead
+	of establishing direct connection to the remote server when
+	using the git protocol for fetching. If the variable value is
+	in the "COMMAND for DOMAIN" format, the command is applied only
+	on hostnames ending with the specified domain string. This variable
+	may be set multiple times and is matched in the given order;
+	the first match wins.
+
+	Can be overriden by the 'GIT_PROXY_COMMAND' environment variable
+	(which always applies universally, without the special "for"
+	handling).
+
+core.ignoreStat::
+	The working copy files are assumed to stay unchanged until you
+	mark them otherwise manually - Git will not detect the file changes
+	by lstat() calls. This is useful on systems where those are very
+	slow, such as Microsoft Windows.  See gitlink:git-update-index[1].
+	False by default.
+
+core.onlyUseSymrefs::
+	Always use the "symref" format instead of symbolic links for HEAD
+	and other symbolic reference files. True by default.
+
+core.repositoryFormatVersion::
+	Internal variable identifying the repository format and layout
+	version.
+
+core.sharedRepository::
+	If true, the repository is made shareable between several users
+	in a group (making sure all the files and objects are group-writable).
+	See gitlink:git-init-db[1]. False by default.
+
+core.warnAmbiguousRefs::
+	If true, git will warn you if the ref name you passed it is ambiguous
+	and might match multiple refs in the .git/refs/ tree. True by default.
+
+apply.whitespace::
+	Tells `git-apply` how to handle whitespaces, in the same way
+	as the '--whitespace' option. See gitlink:git-apply[1].
+
+diff.renameLimit::
+	The number of files to consider when performing the copy/rename
+	detection; equivalent to the git diff option '-l'.
+
+format.headers::
+	Additional email headers to include in a patch to be submitted
+	by mail.  See gitlink:git-format-patch[1].
+
+gitcvs.enabled::
+	Whether the cvs pserver interface is enabled for this repository.
+	See gitlink:git-cvsserver[1].
+
+gitcvs.logfile::
+	Path to a log file where the cvs pserver interface well... logs
+	various stuff. See gitlink:git-cvsserver[1].
+
+http.sslVerify::
+	Whether to verify the SSL certificate when fetching or pushing
+	over HTTPS. Can be overriden by the 'GIT_SSL_NO_VERIFY' environment
+	variable.
+
+http.sslCert::
+	File containing the SSL certificate when fetching or pushing
+	over HTTPS. Can be overriden by the 'GIT_SSL_CERT' environment
+	variable.
+
+http.sslKey::
+	File containing the SSL private key when fetching or pushing
+	over HTTPS. Can be overriden by the 'GIT_SSL_KEY' environment
+	variable.
+
+http.sslCAInfo::
+	File containing the certificates to verify the peer with when
+	fetching or pushing over HTTPS. Can be overriden by the
+	'GIT_SSL_CAINFO' environment variable.
+
+http.sslCAPath::
+	Path containing files with the CA certificates to verify the peer
+	with when fetching or pushing over HTTPS. Can be overriden
+	by the 'GIT_SSL_CAPATH' environment variable.
+
+http.maxRequests::
+	How many HTTP requests to launch in parallel. Can be overriden
+	by the 'GIT_HTTP_MAX_REQUESTS' environment variable. Default is 5.
+
+http.lowSpeedLimit, http.lowSpeedTime::
+	If the HTTP transfer speed is less than 'http.lowSpeedLimit'
+	for longer than 'http.lowSpeedTime' seconds, the transfer is aborted.
+	Can be overriden by the 'GIT_HTTP_LOW_SPEED_LIMIT' and
+	'GIT_HTTP_LOW_SPEED_TIME' environment variables.
+
+i18n.commitEncoding::
+	Character encoding the commit messages are stored in; git itself
+	does not care per se, but this information is necessary e.g. when
+	importing commits from emails or in the gitk graphical history
+	browser (and possibly at other places in the future or in other
+	porcelains). See e.g. gitlink:git-mailinfo[1]. Defaults to 'utf-8'.
+
+merge.summary::
+	Whether to include summaries of merged commits in newly created
+	merge commit messages. False by default.
+
+pull.octopus::
+	The default merge strategy to use when pulling multiple branches
+	at once.
+
+pull.twohead::
+	The default merge strategy to use when pulling a single branch.
+
+show.difftree::
+	The default gitlink:git-diff-tree[1] arguments to be used
+	for gitlink:git-show[1].
+
+showbranch.default::
+	The default set of branches for gitlink:git-show-branch[1].
+	See gitlink:git-show-branch[1].
+
+user.email::
+	Your email address to be recorded in any newly created commits.
+	Can be overriden by the 'GIT_AUTHOR_EMAIL' and 'GIT_COMMITTER_EMAIL'
+	environment variables.  See gitlink:git-commit-tree[1].
+
+user.name::
+	Your full name to be recorded in any newly created commits.
+	Can be overriden by the 'GIT_AUTHOR_NAME' and 'GIT_COMMITTER_NAME'
+	environment variables.  See gitlink:git-commit-tree[1].
+
+whatchanged.difftree::
+	The default gitlink:git-diff-tree[1] arguments to be used
+	for gitlink:git-whatchanged[1].
+
+imap::
+	The configuration variables in the 'imap' section are described
+	in gitlink:git-imap-send[1].
diff --git a/Documentation/git-repo-config.txt b/Documentation/git-repo-config.txt
index c08ab77..566cfa1 100644
--- a/Documentation/git-repo-config.txt
+++ b/Documentation/git-repo-config.txt
@@ -91,11 +91,11 @@ Given a .git/config like this:
 		renames = true
 
 	; Proxy settings
-	[proxy]
-		command="ssh" for "ssh://kernel.org/"
-		command="proxy-command" for kernel.org
-		command="myprotocol-command" for "my://"
-		command=default-proxy ; for all the rest
+	[core]
+		gitproxy="ssh" for "ssh://kernel.org/"
+		gitproxy="proxy-command" for kernel.org
+		gitproxy="myprotocol-command" for "my://"
+		gitproxy=default-proxy ; for all the rest
 
 you can set the filemode to true with
 
@@ -108,7 +108,7 @@ to what URL they apply. Here is how to c
 to "ssh".
 
 ------------
-% git repo-config proxy.command '"ssh" for kernel.org' 'for kernel.org$'
+% git repo-config core.gitproxy '"ssh" for kernel.org' 'for kernel.org$'
 ------------
 
 This makes sure that only the key/value pair for kernel.org is replaced.
@@ -119,7 +119,7 @@ To delete the entry for renames, do
 % git repo-config --unset diff.renames
 ------------
 
-If you want to delete an entry for a multivar (like proxy.command above),
+If you want to delete an entry for a multivar (like core.gitproxy above),
 you have to provide a regex matching the value of exactly one line.
 
 To query the value for a given key, do
@@ -137,27 +137,27 @@ or
 or, to query a multivar:
 
 ------------
-% git repo-config --get proxy.command "for kernel.org$"
+% git repo-config --get core.gitproxy "for kernel.org$"
 ------------
 
 If you want to know all the values for a multivar, do:
 
 ------------
-% git repo-config --get-all proxy.command
+% git repo-config --get-all core.gitproxy
 ------------
 
-If you like to live dangerous, you can replace *all* proxy.commands by a
+If you like to live dangerous, you can replace *all* core.gitproxy by a
 new one with
 
 ------------
-% git repo-config --replace-all proxy.command ssh
+% git repo-config --replace-all core.gitproxy ssh
 ------------
 
 However, if you really only want to replace the line for the default proxy,
 i.e. the one without a "for ..." postfix, do something like this:
 
 ------------
-% git repo-config proxy.command ssh '! for '
+% git repo-config core.gitproxy ssh '! for '
 ------------
 
 To actually match only values with an exclamation mark, you have to
@@ -167,13 +167,16 @@ To actually match only values with an ex
 ------------
 
 
+include::config.txt[]
+
+
 Author
 ------
 Written by Johannes Schindelin <Johannes.Schindelin@gmx.de>
 
 Documentation
 --------------
-Documentation by Johannes Schindelin.
+Documentation by Johannes Schindelin, Petr Baudis and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
diff --git a/config.c b/config.c
index 7ea8a73..4e1f0c2 100644
--- a/config.c
+++ b/config.c
@@ -252,7 +252,7 @@ int git_default_config(const char *var, 
 		return 0;
 	}
 
-	/* Add other config variables here.. */
+	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
 
