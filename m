From: Dan McGee <dpmcgee@gmail.com>
Subject: [RFC/PATCH] Remove repo-config
Date: Tue, 15 Jan 2008 21:19:14 -0600
Message-ID: <1200453554-14163-1-git-send-email-dpmcgee@gmail.com>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 16 04:19:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEyol-0000QZ-ET
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 04:19:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755144AbYAPDTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 22:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755162AbYAPDTT
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 22:19:19 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:23924 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754967AbYAPDTS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 22:19:18 -0500
Received: by py-out-1112.google.com with SMTP id u52so146523pyb.10
        for <git@vger.kernel.org>; Tue, 15 Jan 2008 19:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=pT17zcB2QyDSYAcJKlOOlSyZow6Q8MBBFHDZTJdmijo=;
        b=hH7dpJT4bnQvL+lMslxH5/iLIylSo2snZ4qwkCc33VXBycTiNivBJ81I5/kLhZFzbSpOtbbNJhy48cDwMPRObmX1TsnTdgE4ifUFyambmYLRUniiOUqIdY13OzGh/KbXAktehrol/uxp60bcz1AkaSBGaAa6jM1HF3YCOqGgh2A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=uh0E9ORqcLc2SrhNAUE38W20uFd+LSB9Vo64QhVMbqrgP4Tas/kVPA8iPbhyYZvTCNGGvGYb8vNmjKN9gPy7WVQRJEjB+ioEk7aHXFIJSXxKp7j8dk1OB9G2ZDWpKMUiLWXvVi0hPmsenm8hqgWBwqzHmK+3cmeELfN4GPA1Lw4=
Received: by 10.35.84.9 with SMTP id m9mr318033pyl.6.1200453557224;
        Tue, 15 Jan 2008 19:19:17 -0800 (PST)
Received: from localhost ( [76.197.238.51])
        by mx.google.com with ESMTPS id n80sm400313pyh.42.2008.01.15.19.19.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Jan 2008 19:19:16 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70609>

'git config' has been used in place of 'git repo-config' for some time in
the documentation and most of the tools, so remove traces of repo-config
from the source.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---

Mainly a request for comment, but I sent this patch becuase I noticed
repo-config is not even listed in command-list.txt. Before the 1.5.4 release,
I would think it either needs to be listed there or removed entirely.

Looking forward to 1.5.5, is there any reason to keep an old command like
this around? It is rarely used and needlessly complicates things, and the
manpage did nothing but send you to config anyway.

All tests pass on Linux 2.6.23.

-Dan

 Documentation/git-repo-config.txt      |   18 ------------------
 Makefile                               |    4 ++--
 contrib/completion/git-completion.bash |    1 -
 contrib/examples/git-tag.sh            |    1 +
 git.c                                  |    1 -
 t/t0020-crlf.sh                        |   24 ++++++++++++------------
 t/t9200-git-cvsexportcommit.sh         |    2 +-
 templates/hooks--update                |    8 ++++----
 8 files changed, 20 insertions(+), 39 deletions(-)
 delete mode 100644 Documentation/git-repo-config.txt

diff --git a/Documentation/git-repo-config.txt b/Documentation/git-repo-config.txt
deleted file mode 100644
index 2ca3994..0000000
--- a/Documentation/git-repo-config.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-git-repo-config(1)
-==================
-
-NAME
-----
-git-repo-config - Get and set repository or global options
-
-
-SYNOPSIS
---------
-'git-repo-config' ...
-
-
-DESCRIPTION
------------
-
-This is a synonym for linkgit:git-config[1].  Please refer to the
-documentation of that command.
diff --git a/Makefile b/Makefile
index 82e9cd6..603f4ac 100644
--- a/Makefile
+++ b/Makefile
@@ -262,7 +262,7 @@ EXTRA_PROGRAMS =
 
 BUILT_INS = \
 	git-format-patch$X git-show$X git-whatchanged$X git-cherry$X \
-	git-get-tar-commit-id$X git-init$X git-repo-config$X \
+	git-get-tar-commit-id$X git-init$X \
 	git-fsck-objects$X git-cherry-pick$X git-peek-remote$X git-status$X \
 	$(patsubst builtin-%.o,git-%$X,$(BUILTIN_OBJS))
 
@@ -1145,7 +1145,7 @@ check-docs::
 		case "$$v" in \
 		git-merge-octopus | git-merge-ours | git-merge-recursive | \
 		git-merge-resolve | git-merge-stupid | git-merge-subtree | \
-		git-fsck-objects | git-init-db | git-repo-config | \
+		git-fsck-objects | git-init-db | \
 		git-?*--?* ) continue ;; \
 		esac ; \
 		test -f "Documentation/$$v.txt" || \
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 343364d..c63a642 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -333,7 +333,6 @@ __git_commands ()
 		read-tree)        : plumbing;;
 		receive-pack)     : plumbing;;
 		reflog)           : plumbing;;
-		repo-config)      : plumbing;;
 		rerere)           : plumbing;;
 		rev-list)         : plumbing;;
 		rev-parse)        : plumbing;;
diff --git a/contrib/examples/git-tag.sh b/contrib/examples/git-tag.sh
index ae7c531..a3182df 100755
--- a/contrib/examples/git-tag.sh
+++ b/contrib/examples/git-tag.sh
@@ -167,6 +167,7 @@ type=$(git cat-file -t $object) || exit 1
 tagger=$(git-var GIT_COMMITTER_IDENT) || exit 1
 
 test -n "$username" ||
+	#NOTE: 'git repo-config' has since been replaced by 'git config'
 	username=$(git repo-config user.signingkey) ||
 	username=$(expr "z$tagger" : 'z\(.*>\)')
 
diff --git a/git.c b/git.c
index 15fec89..061d365 100644
--- a/git.c
+++ b/git.c
@@ -340,7 +340,6 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "push", cmd_push, RUN_SETUP },
 		{ "read-tree", cmd_read_tree, RUN_SETUP },
 		{ "reflog", cmd_reflog, RUN_SETUP },
-		{ "repo-config", cmd_config },
 		{ "rerere", cmd_rerere, RUN_SETUP },
 		{ "reset", cmd_reset, RUN_SETUP },
 		{ "rev-list", cmd_rev_list, RUN_SETUP },
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 89baebd..8b27aa8 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -19,7 +19,7 @@ remove_cr () {
 
 test_expect_success setup '
 
-	git repo-config core.autocrlf false &&
+	git config core.autocrlf false &&
 
 	for w in Hello world how are you; do echo $w; done >one &&
 	mkdir dir &&
@@ -46,7 +46,7 @@ test_expect_success 'update with autocrlf=input' '
 
 	rm -f tmp one dir/two three &&
 	git read-tree --reset -u HEAD &&
-	git repo-config core.autocrlf input &&
+	git config core.autocrlf input &&
 
 	for f in one dir/two
 	do
@@ -70,7 +70,7 @@ test_expect_success 'update with autocrlf=true' '
 
 	rm -f tmp one dir/two three &&
 	git read-tree --reset -u HEAD &&
-	git repo-config core.autocrlf true &&
+	git config core.autocrlf true &&
 
 	for f in one dir/two
 	do
@@ -93,7 +93,7 @@ test_expect_success 'update with autocrlf=true' '
 test_expect_success 'checkout with autocrlf=true' '
 
 	rm -f tmp one dir/two three &&
-	git repo-config core.autocrlf true &&
+	git config core.autocrlf true &&
 	git read-tree --reset -u HEAD &&
 
 	for f in one dir/two
@@ -117,7 +117,7 @@ test_expect_success 'checkout with autocrlf=true' '
 test_expect_success 'checkout with autocrlf=input' '
 
 	rm -f tmp one dir/two three &&
-	git repo-config core.autocrlf input &&
+	git config core.autocrlf input &&
 	git read-tree --reset -u HEAD &&
 
 	for f in one dir/two
@@ -143,7 +143,7 @@ test_expect_success 'checkout with autocrlf=input' '
 test_expect_success 'apply patch (autocrlf=input)' '
 
 	rm -f tmp one dir/two three &&
-	git repo-config core.autocrlf input &&
+	git config core.autocrlf input &&
 	git read-tree --reset -u HEAD &&
 
 	git apply patch.file &&
@@ -156,7 +156,7 @@ test_expect_success 'apply patch (autocrlf=input)' '
 test_expect_success 'apply patch --cached (autocrlf=input)' '
 
 	rm -f tmp one dir/two three &&
-	git repo-config core.autocrlf input &&
+	git config core.autocrlf input &&
 	git read-tree --reset -u HEAD &&
 
 	git apply --cached patch.file &&
@@ -169,7 +169,7 @@ test_expect_success 'apply patch --cached (autocrlf=input)' '
 test_expect_success 'apply patch --index (autocrlf=input)' '
 
 	rm -f tmp one dir/two three &&
-	git repo-config core.autocrlf input &&
+	git config core.autocrlf input &&
 	git read-tree --reset -u HEAD &&
 
 	git apply --index patch.file &&
@@ -183,7 +183,7 @@ test_expect_success 'apply patch --index (autocrlf=input)' '
 test_expect_success 'apply patch (autocrlf=true)' '
 
 	rm -f tmp one dir/two three &&
-	git repo-config core.autocrlf true &&
+	git config core.autocrlf true &&
 	git read-tree --reset -u HEAD &&
 
 	git apply patch.file &&
@@ -196,7 +196,7 @@ test_expect_success 'apply patch (autocrlf=true)' '
 test_expect_success 'apply patch --cached (autocrlf=true)' '
 
 	rm -f tmp one dir/two three &&
-	git repo-config core.autocrlf true &&
+	git config core.autocrlf true &&
 	git read-tree --reset -u HEAD &&
 
 	git apply --cached patch.file &&
@@ -209,7 +209,7 @@ test_expect_success 'apply patch --cached (autocrlf=true)' '
 test_expect_success 'apply patch --index (autocrlf=true)' '
 
 	rm -f tmp one dir/two three &&
-	git repo-config core.autocrlf true &&
+	git config core.autocrlf true &&
 	git read-tree --reset -u HEAD &&
 
 	git apply --index patch.file &&
@@ -224,7 +224,7 @@ test_expect_success '.gitattributes says two is binary' '
 
 	rm -f tmp one dir/two three &&
 	echo "two -crlf" >.gitattributes &&
-	git repo-config core.autocrlf true &&
+	git config core.autocrlf true &&
 	git read-tree --reset -u HEAD &&
 
 	if remove_cr dir/two >/dev/null
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 910c584..a15222c 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -225,7 +225,7 @@ test_expect_success \
       ! git-cvsexportcommit -c $id
       )'
 
-case "$(git repo-config --bool core.filemode)" in
+case "$(git config --bool core.filemode)" in
 false)
 	;;
 *)
diff --git a/templates/hooks--update b/templates/hooks--update
index bd93dd1..09a99ff 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -37,9 +37,9 @@ if [ -z "$refname" -o -z "$oldrev" -o -z "$newrev" ]; then
 fi
 
 # --- Config
-allowunannotated=$(git-repo-config --bool hooks.allowunannotated)
-allowdeletebranch=$(git-repo-config --bool hooks.allowdeletebranch)
-allowdeletetag=$(git-repo-config --bool hooks.allowdeletetag)
+allowunannotated=$(git config --bool hooks.allowunannotated)
+allowdeletebranch=$(git config --bool hooks.allowdeletebranch)
+allowdeletetag=$(git config --bool hooks.allowdeletetag)
 
 # check for no description
 projectdesc=$(sed -e '1q' "$GIT_DIR/description")
@@ -53,7 +53,7 @@ fi
 if [ "$newrev" = "0000000000000000000000000000000000000000" ]; then
 	newrev_type=delete
 else
-	newrev_type=$(git-cat-file -t $newrev)
+	newrev_type=$(git cat-file -t $newrev)
 fi
 
 case "$refname","$newrev_type" in
-- 
1.5.4.rc3
