From: Pranit Bauva <pranit.bauva@zoho.com>
Subject: [PATCH/RFC] git-commit: add a commit.verbose config variable
Date: Fri, 26 Feb 2016 02:57:29 +0000
Message-ID: <56CFBF19.6040004@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Christian Couder <christian.couder@gmail.com>,
	Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 21:49:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ2qr-0001Yu-Km
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 21:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbcBYUt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 15:49:29 -0500
Received: from sender153-mail.zoho.com ([74.201.84.153]:22064 "EHLO
	sender153-mail.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbcBYUt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 15:49:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:subject:to:message-id:date:mime-version:content-type; 
  b=cJQ/u0vMxb3t0/VnRMtgEKf8AIZXdzgwt/Z/dXr1xKAT4DLrYbSA5aXUQ+B8XIVOLzIdTKVHBshW
    QhHlySPMjoRII/2gR0gJW1D2EKD7kajP1ty2KVdtGV5tqarQXn7g  
Received: from 127.0.0.1 (tor-exit.dhalgren.org [46.165.230.5]) by mx.zohomail.com
	with SMTPS id 1456433364079208.18796286815848; Thu, 25 Feb 2016 12:49:24 -0800 (PST)
X-Zoho-Virus-Status: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287438>

>From c273a02fc9cab9305cedf6e37422e257a1cc3b1e Mon Sep 17 00:00:00 2001
From: Pranit Bauva <pranit.bauva@zoho.com>
Date: Fri, 26 Feb 2016 07:14:18 +0530
Subject: [PATCH/RFC] git-commit: add a commit.verbose config variable

Since many people always run the command with this option, and would
prefer not to use the argument again and again but instead specify it in
some config file.

The variable `verbose` is changed instead of `s.verbose` as the method
run_status() updates the `s.verbose` with the value of `verbose`. So in
this way the change is reflected in both of them.

Signed-off-by: Pranit Bauva <pranit.bauva@zoho.com>
---

Notes:
    This is a patch for the microproject of GSOC 2016. I have done the change
    under careful consideration of where to place the line. I have to yet write
    the tests for this. I have explored the config API and I am currently going
    through the tests part. I have run the test locally by manually checking.
    I currently learning about the test suite. I will update this patch
    with some tests in some time.

 Documentation/config.txt     | 5 +++++
 Documentation/git-commit.txt | 3 ++-
 builtin/commit.c             | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 01cca0a..f7e9c09 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1110,6 +1110,11 @@ commit.template::
 	"`~/`" is expanded to the value of `$HOME` and "`~user/`" to the
 	specified user's home directory.
 
+commit.verbose::
+	A boolean to specify whether to always include the verbose option
+	with git-config.
+	See linkgit:git-commit[1]
+
 credential.helper::
 	Specify an external helper to be called when a username or
 	password credential is needed; the helper may consult external
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 9ec6b3c..2a72437 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -290,7 +290,8 @@ configuration variable documented in linkgit:git-config[1].
 	what changes the commit has.
 	Note that this diff output doesn't have its
 	lines prefixed with '#'. This diff will not be a part
-	of the commit message.
+	of the commit message. If this option is used always, it can
+	be set in the git-config with the boolean variable `commit.verbose`.
 +
 If specified twice, show in addition the unified diff between
 what would be committed and the worktree files, i.e. the unstaged
diff --git a/builtin/commit.c b/builtin/commit.c
index b3bd2d4..68080fe 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1644,6 +1644,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
 	s.colopts = 0;
 
+	git_config_get_bool("commit.verbose", &verbose);
+
 	if (get_sha1("HEAD", sha1))
 		current_head = NULL;
 	else {
-- 
2.1.4
