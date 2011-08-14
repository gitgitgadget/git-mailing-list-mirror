From: Dan Charney <git@drmoose.net>
Subject: [PATCH] shell: add base path and ~ expansion support.
Date: Sun, 14 Aug 2011 15:25:19 -0400
Message-ID: <96C1D6CB-254C-4E54-9CAE-4FE3A354FEEE@drmoose.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 14 21:25:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsgJb-0006XO-UD
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 21:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754855Ab1HNTZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 15:25:38 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:49042 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754653Ab1HNTZh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2011 15:25:37 -0400
Received: from homiemail-a78.g.dreamhost.com (caibbdcaaaaf.dreamhost.com [208.113.200.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 4D3CC17C7E2
	for <git@vger.kernel.org>; Sun, 14 Aug 2011 12:25:36 -0700 (PDT)
Received: from homiemail-a78.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a78.g.dreamhost.com (Postfix) with ESMTP id 75A9015C065
	for <git@vger.kernel.org>; Sun, 14 Aug 2011 12:25:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=drmoose.net; h=from:content-type
	:content-transfer-encoding:subject:date:message-id:to:
	mime-version; q=dns; s=drmoose.net; b=Rl8UedqDZBZ57j4Dl3RzB5EgEk
	WqLXL7D7VkK51SF8yFmaCIVbwjCCfsDDMAOIaJD6iFu87/7FrsyXL8tU5SN3WTKq
	FVMoBCqxqGEQ6ZyVDURNl75IopSGT9bJPqQEu9xjUX5EriBSG0UgWjV1xeEjZR1P
	wVmKGkLPVxiLNWXqo=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=drmoose.net; h=from
	:content-type:content-transfer-encoding:subject:date:message-id
	:to:mime-version; s=drmoose.net; bh=Bj6z7YfW4SoYUiCeZggwZJ15MLo=
	; b=oPhUpwqwibsFc9wHGwAscvwN3Aefjk5lgPGGEapjY5WAQa1qT1IPAgtviQlA
	LeFrAcx36xMmqmc3+OXVSFCdRSkPHlD2gvnrqDSxykvoFarta+AOQGVjXzS+rHss
	nj/nxYFEt7qy8ucx2Gq034Ab1M9glpdZs8rabztZaINAZcU=
Received: from post.drmoose.net (99-29-49-185.uvs.cntmoh.sbcglobal.net [99.29.49.185])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: copier@drmoose.net)
	by homiemail-a78.g.dreamhost.com (Postfix) with ESMTPSA id 5364915C062
	for <git@vger.kernel.org>; Sun, 14 Aug 2011 12:25:35 -0700 (PDT)
Received: by post.drmoose.net (Postfix, from userid 998)
	id C9289230AB; Sun, 14 Aug 2011 15:25:33 -0400 (EDT)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on post.drmoose.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED
	autolearn=unavailable version=3.3.1
Received: from [10.1.1.46] (kevyn [10.1.1.46])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: drmoose)
	by post.drmoose.net (Postfix) with ESMTPSA id D0A2422674
	for <git@vger.kernel.org>; Sun, 14 Aug 2011 15:25:19 -0400 (EDT)
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179344>

By default, paths that are forwarded to git-shell when users try to
pull from an ssh:// URI are relative to the server's root folder (/).
Add support for an environment variable, GIT_SHELL_BASE_PATH, to
allow sysadmins to make these paths relative to somewhere else
(e.g. /srv/git). Expand a leading "~/" to the value of $HOME.
Allow an additional leading slash to specify a path relative to the
root folder (/).

This change does not improve security in the slightest, just makes
ssh:// URIs prettier.

Signed-off-by: Dan Charney <git@drmoose.net>
---

I should point out that I've not tested the the behavior with the "cvs emulator" mode, in large part because CVS remains thoroughly baffling to me. Despite many attempts to learn how to use it, I never did move beyond the "copy and paste somebody else's pre-written commands" phase.

This is my first attempt at contributing to a project this big, and this is the first time this year I've written any C. Free to tear me a new one if I've done something stupid :-)

Documentation/git-shell.txt |   25 ++++++++++++++++++++++++-
shell.c                     |   37 ++++++++++++++++++++++++++++++++++++-
2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
index 9b92506..280282e 100644
--- a/Documentation/git-shell.txt
+++ b/Documentation/git-shell.txt
@@ -22,13 +22,36 @@ is started in interactive mode when no arguments are given; in this
case, COMMAND_DIR must exist, and any of the executables in it can be
invoked.

-'cvs server' is a special command which executes git-cvsserver.
+'cvs server' is a special command which executes git-cvsserver. If 
+"$GIT_SHELL_BASE_PATH" is set, it will be passed to git-cvsserver as
+the --base-path parameter.

COMMAND_DIR is the path "$HOME/git-shell-commands". The user must have
read and execute permissions to the directory in order to execute the
programs in it. The programs are executed with a cwd of $HOME, and
<argument> is parsed as a command-line string.

+PATH MAPPING
+------------
+
+If the environment variable "$GIT_SHELL_BASE_PATH" is set and the shell
+is not in interactive mode, $GIT_SHELL_BASE_PATH will be prepended to
+the front the <argument> passed to <command>. This is analogous to
+the --base-path switch from link:git-daemon[1] - if your environment
+variables include GIT_SHELL_BASE_PATH=/srv/git on example.com, and later
+someone pulls ssh://example.com/my.git, it will be interpreted as 
+/srv/git/my.git. This feature does not restrict clients to subfolders
+of the base path; path elements such as .. are allowed.
+
+If the environment variable "$HOME" is set, git-shell will replace a leading
+"~/" in the <argument> with the value of "$HOME". 
+
+Example::
+	If GIT_SHELL_BASE_PATH=/srv/git and HOME=/home/joeuser, then::
+		ssh://example.com/some.git	will map to /srv/git/some.git
+		ssh://example.com/~/my.git	will map to /home/joeuser/my.git
+		ssh://example.com//var/git/x.git	will map to /var/git/x.git
+
GIT
---
Part of the linkgit:git[1] suite
diff --git a/shell.c b/shell.c
index abb8622..e250b2a 100644
--- a/shell.c
+++ b/shell.c
@@ -6,6 +6,37 @@

#define COMMAND_DIR "git-shell-commands"
#define HELP_COMMAND COMMAND_DIR "/help"
+#define BASE_PATH_VARIABLE "GIT_SHELL_BASE_PATH"
+#define DEFAULT_PATH "/"
+
+static const char *adjust_argument_path(const char *arg) 
+{
+	struct strbuf path = STRBUF_INIT;
+	const char *env;
+	const char *prefix_variable = NULL;
+
+	if (arg == NULL || arg[0] != '/')
+		prefix_variable = BASE_PATH_VARIABLE;
+	else if (arg[1] == '/')
+		++arg;
+	else if (arg[1] == '~' && arg[2] == '/') {
+		prefix_variable = "HOME";
+		arg += 2;
+	} else 
+		prefix_variable = BASE_PATH_VARIABLE;
+
+	if (NULL != prefix_variable) {
+		env = getenv(prefix_variable);
+		if (NULL != env) 
+			strbuf_addstr(&path, env);
+	}
+
+	if (NULL != arg)
+		strbuf_addstr(&path, arg);
+	if (NULL == path.buf || path.buf[0] == '\0')
+		return DEFAULT_PATH;
+	return path.buf;
+}

static int do_generic_cmd(const char *me, char *arg)
{
@@ -18,7 +49,7 @@ static int do_generic_cmd(const char *me, char *arg)
		die("bad command");

	my_argv[0] = me + 4;
-	my_argv[1] = arg;
+	my_argv[1] = adjust_argument_path(arg);
	my_argv[2] = NULL;

	return execv_git_cmd(my_argv);
@@ -30,6 +61,10 @@ static int do_cvs_cmd(const char *me, char *arg)
		"cvsserver", "server", NULL
	};

+	const char *base_path;
+	base_path = adjust_argument_path(NULL);
+	setenv("GIT_CVSSERVER_BASE_PATH", base_path, 1);
+
	if (!arg || strcmp(arg, "server"))
		die("git-cvsserver only handles server: %s", arg);

-- 
1.7.4
