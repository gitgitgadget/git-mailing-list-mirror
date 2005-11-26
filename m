From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Cogito documentation updates
Date: Sat, 26 Nov 2005 20:12:02 +0100
Message-ID: <20051126191201.GA29008@diku.dk>
References: <20051120101112.GA2302@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 26 20:12:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eg5T4-0005x2-FB
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 20:12:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVKZTME (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Nov 2005 14:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbVKZTME
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Nov 2005 14:12:04 -0500
Received: from nhugin.diku.dk ([130.225.96.140]:26101 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1750708AbVKZTMD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Nov 2005 14:12:03 -0500
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id AA7A66DFCFF; Sat, 26 Nov 2005 20:11:22 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 5DED36DFAB8; Sat, 26 Nov 2005 20:11:22 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 35A8A61448; Sat, 26 Nov 2005 20:12:02 +0100 (CET)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20051120101112.GA2302@diku.dk>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12785>

 - note the difference between short and long help in cg-help(1)
 - mention the alien repo importers provided by the git core
 - fix typo in cg-update(1)
 - fix help options for the cg(1) manpage

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
diff --git a/Documentation/make-cg-asciidoc b/Documentation/make-cg-asciidoc
index 00e4ce7..51db9e3 100755
--- a/Documentation/make-cg-asciidoc
+++ b/Documentation/make-cg-asciidoc
@@ -79,6 +79,21 @@ else
 	fi
 fi
 
+# cg(1) does not answer to the help options in the same way as the
+# rest of the commands
+if [ "$COMMAND" = "cg" ]; then
+	HELP_OPTIONS="
+-h, --help::
+	Print overview of Cogito commands. Same as gitlink:cg-help[1]."
+else
+	HELP_OPTIONS="
+-h, --help::
+	Print usage summary.
+
+--long-help::
+	Print user manual. The same as found in $TITLE."
+fi
+
 cat <<__END__
 $TITLE
 $TITLELINE
@@ -98,12 +113,7 @@ $DESCRIPTION
 OPTIONS
 -------
 $OPTIONS
-
--h, --help::
-	Print usage summary.
-
---long-help::
-	Print user manual. The same as found in $TITLE.
+$HELP_OPTIONS
 
 $MISC
 
@@ -113,6 +123,6 @@ $COPYRIGHT
 
 SEE ALSO
 --------
-$COMMAND command is part of gitlink:${PACKAGE}[7],
+$COMMAND is part of gitlink:${PACKAGE}[7],
 a toolkit for managing gitlink:git[7] trees.
 __END__
diff --git a/cg-add b/cg-add
index a50c0ac..4611930 100755
--- a/cg-add
+++ b/cg-add
@@ -25,9 +25,8 @@
 # -r::	Add files recursively
 #	If you pass cg-add this flag and any directory names, it will try
 #	to add files in those directories recursively (with regard to your
-#	ignore rules - see cg-status documentation for more detailed
-#	description of those). See also above for more notes about cg-add
-#	vs. directories.
+#	ignore rules - see `cg-status` for a more detailed description of
+#	those). See also above for more notes about cg-add vs. directories.
 
 USAGE="cg-add [-N] [-r] FILE..."
 
diff --git a/cg-help b/cg-help
index 6ba7657..5fa65ef 100755
--- a/cg-help
+++ b/cg-help
@@ -8,8 +8,9 @@
 # If the argument is left out an overview of all the Cogito commands will
 # be shown.
 #
-# Note help for a command is also available by passing `--help` or `-h`
-# to the command.
+# Note, short help for a command is also available by passing `--help` or
+# `-h` to the command. The complete command manual is shown when passing
+# `--long-help` (and is the same as doing "`cg-help command`").
 #
 # OPTIONS
 # -------
diff --git a/cg-init b/cg-init
index a0a7372..31c2e10 100755
--- a/cg-init
+++ b/cg-init
@@ -9,7 +9,9 @@
 # This command is intended for creating repositories for work on new projects.
 # If you want to clone an existing project, see `cg-clone`. If you want to
 # set up a public repository not for direct work but only for pushing/pulling,
-# see `cg-admin-setuprepo`.
+# see `cg-admin-setuprepo`. It is also possible to import repositories from
+# other SCMs into GIT, see `git-cvsimport(1)`, `git-svnimport(1)` and
+# `git-archimport(1)`.
 #
 # OPTIONS
 # -------
diff --git a/cg-update b/cg-update
index ed93c01..9d82fcb 100755
--- a/cg-update
+++ b/cg-update
@@ -8,7 +8,7 @@
 # This is similar to running cg-fetch and cg-merge commands successively.
 # Please refer to the documentation of those commands for more details
 # about the operation. Note that if you are not doing own development
-# but only following some project, you it is recommended to use this command
+# but only following some project, it is recommended to use this command
 # instead of `cg-fetch` + `cg-merge` since `cg-update` can handle some
 # additional corner cases (in particular, if the remote branch rebases,
 # `cg-update` will fast-forward instead of doing a tree merge and diverging).

-- 
Jonas Fonseca
