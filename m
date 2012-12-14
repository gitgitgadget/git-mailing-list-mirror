From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: [PATCH] git.c: add --index-file command-line option.
Date: Fri, 14 Dec 2012 12:23:39 +0100
Message-ID: <1355484219-7517-1-git-send-email-manlio.perillo@gmail.com>
Cc: Manlio Perillo <manlio.perillo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 12:24:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjTNG-0003fd-0z
	for gcvg-git-2@plane.gmane.org; Fri, 14 Dec 2012 12:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755074Ab2LNLX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2012 06:23:56 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39047 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501Ab2LNLXz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2012 06:23:55 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1638391bkw.19
        for <git@vger.kernel.org>; Fri, 14 Dec 2012 03:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=/KZVTtxZrUDNAq12rOBSwd2Vnby98pmu0pfAcMQncug=;
        b=HOhXsM7+e1zITTNgLOy+CYfH+Ivj8exmWiEg/2Jvk4P2T54HNVuHpKZTjxKTiXsu98
         7PHvMKbMwmlVh4Rp4JnL080+q7ndN+n1arIdbWO7U8qujIUo6vLGOR0d044PmIJbws7I
         C0MYmXXRYxIlf28C6rH1eQOJFljD6MYP1maeiID2hmlcIRAsxg5jNl0hLklhZcUAY51n
         JmHbOpIqFtwQMleJzXF5VNijNtX3C5n3DDWJWYpChNkjOFV9H5G+IOIhdVZzr7JmA0zR
         6oFLvuxHpJBYLfgTWzbHhxA7/NEKmfmY/CCr0fIYf6HEkeL665IGa3jopeFo7y7ikI2S
         j8ng==
Received: by 10.204.129.214 with SMTP id p22mr2603189bks.47.1355484234272;
        Fri, 14 Dec 2012 03:23:54 -0800 (PST)
Received: from synapsis.synapsis ([151.70.213.162])
        by mx.google.com with ESMTPS id i20sm4033447bkw.5.2012.12.14.03.23.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Dec 2012 03:23:53 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc1.18.g9db0d25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211489>

Unlike other environment variables (e.g. GIT_WORK_TREE,
GIT_NAMESPACE), it was not possible to set the GIT_INDEX_FILE
environment variable using the command line.

Add a new --index-file command-line option.

Update the t7500-commit test to include --index-file option coverage.
The tests have been adapted from the existing
'using alternate GIT_INDEX_FILE (1)' and
'using alternate GIT_INDEX_FILE (2)' tests.

Signed-off-by: Manlio Perillo <manlio.perillo@gmail.com>
---
 Documentation/git.txt | 10 +++++++++-
 git.c                 | 17 ++++++++++++++++-
 t/t7500-commit.sh     | 29 +++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index e643683..5a582dd 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -12,7 +12,8 @@ SYNOPSIS
 'git' [--version] [--help] [-c <name>=<value>]
     [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
     [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
-    [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
+    [--git-dir=<path>] [--work-tree=<path>] [--index-file=<path>]
+    [--namespace=<name>]
     <command> [<args>]
 
 DESCRIPTION
@@ -408,6 +409,12 @@ help ...`.
 	variable (see core.worktree in linkgit:git-config[1] for a
 	more detailed discussion).
 
+--index-file=<path>::
+	Set the path to the index file. It can be an absolute path
+	or a path relative to the current working directory.
+	This can also be controlled by setting the GIT_INDEX_FILE
+	environment variable.
+
 --namespace=<path>::
 	Set the git namespace.  See linkgit:gitnamespaces[7] for more
 	details.  Equivalent to setting the `GIT_NAMESPACE` environment
@@ -632,6 +639,7 @@ git so take care if using Cogito etc.
 	This environment allows the specification of an alternate
 	index file. If not specified, the default of `$GIT_DIR/index`
 	is used.
+	The '--index-file command-line option also sets this value.
 
 'GIT_OBJECT_DIRECTORY'::
 	If the object storage directory is specified via this
diff --git a/git.c b/git.c
index d33f9b3..b0f473d 100644
--- a/git.c
+++ b/git.c
@@ -8,7 +8,8 @@
 const char git_usage_string[] =
 	"git [--version] [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
 	"           [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]\n"
-	"           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
+	"           [--git-dir=<path>] [--work-tree=<path>] [--index-file=<path>]\n"
+	"           [--namespace=<name>]\n"
 	"           [-c name=value] [--help]\n"
 	"           <command> [<args>]";
 
@@ -121,6 +122,20 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			setenv(GIT_WORK_TREE_ENVIRONMENT, cmd + 12, 1);
 			if (envchanged)
 				*envchanged = 1;
+		} else if (!strcmp(cmd, "--index-file")) {
+			if (*argc < 2) {
+				fprintf(stderr, "No path given for --index-file.\n" );
+				usage(git_usage_string);
+			}
+			setenv(INDEX_ENVIRONMENT, (*argv)[1], 1);
+			if (envchanged)
+				*envchanged = 1;
+			(*argv)++;
+			(*argc)--;
+		} else if (!prefixcmp(cmd, "--index-file=")) {
+			setenv(INDEX_ENVIRONMENT, cmd + 13, 1);
+			if (envchanged)
+				*envchanged = 1;
 		} else if (!strcmp(cmd, "--bare")) {
 			static char git_dir[PATH_MAX+1];
 			is_bare_repository_cfg = 1;
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 1c908f4..c405a78 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -168,6 +168,35 @@ test_expect_success 'using alternate GIT_INDEX_FILE (2)' '
 	cmp .git/index saved-index >/dev/null
 '
 
+test_expect_success 'using alternate --index-file (1)' '
+
+	cp .git/index saved-index &&
+	(
+		echo some new content >file &&
+		index_file=.git/another_index &&
+		git --index-file=$index_file add file &&
+		git --index-file=$index_file commit -m "commit using another index" &&
+		git --index-file=$index_file diff-index --exit-code HEAD &&
+		git --index-file=$index_file diff-files --exit-code
+	) &&
+	cmp .git/index saved-index >/dev/null
+
+'
+
+test_expect_success 'using alternate --index-file (2)' '
+
+	cp .git/index saved-index &&
+	(
+		rm -f .git/no-such-index &&
+		index_file=.git/no-such-index &&
+		git --index-file=$index_file commit -m "commit using nonexistent index" &&
+		test -z "$(git --index-file=$index_file ls-files)" &&
+		test -z "$(git --index-file=$index_file ls-tree HEAD)"
+
+	) &&
+	cmp .git/index saved-index >/dev/null
+'
+
 cat > expect << EOF
 zort
 
-- 
1.8.1.rc1.17.g75ed918.dirty
