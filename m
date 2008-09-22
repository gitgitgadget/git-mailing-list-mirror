From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 3/3] git abbref-ref: new porcelain for abbreviate_ref()
Date: Mon, 22 Sep 2008 11:09:51 +0200
Message-ID: <1222074591-26548-3-git-send-email-bert.wesarg@googlemail.com>
References: <1222074591-26548-1-git-send-email-bert.wesarg@googlemail.com>
 <1222074591-26548-2-git-send-email-bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, szeder@ira.uka.de,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 11:11:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhhS5-0008T4-Kr
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 11:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbYIVJKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 05:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbYIVJKH
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 05:10:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:40802 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbYIVJKD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 05:10:03 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1299170fgg.17
        for <git@vger.kernel.org>; Mon, 22 Sep 2008 02:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=XAz8epV2V6pOiovTX3qLA69h/jDJ4CRxoEZhC8NpYb0=;
        b=xDPFgCNqrBikkmhz9MdECfCIJH8k68KuZH214oexX8WijQYEQuA4xo3Yinqklh0s0b
         3StUpex3oIxZWuxpW38vTKS4mpubB7jCykTIiSQ5r6Tmf20buWR7Kwt2lXz3eMBGdV9f
         PrsaD5DP9+qatei35M+uycq2pxAOQtZuu3o+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AdcnhmD6S7H+/31fJ3oWddXLrcU55pPmJggAO3OcYNWXBubt3EaLGz7o0gmpfhjG5s
         eO2gPDfM8b9p/UfPstglg6G+WtJOdBE3BmryXpr7dWjXc67A8FgRrNPiQYPrlv8IkNbr
         hyOuxko7TM0lRBhtL1zMIYmPyDjwr2JQ3lUio=
Received: by 10.86.76.20 with SMTP id y20mr4554908fga.14.1222074602937;
        Mon, 22 Sep 2008 02:10:02 -0700 (PDT)
Received: from localhost (p5B0F5781.dip.t-dialin.net [91.15.87.129])
        by mx.google.com with ESMTPS id 12sm5152733fgg.0.2008.09.22.02.10.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Sep 2008 02:10:02 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.1
In-Reply-To: <1222074591-26548-2-git-send-email-bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96466>

This gives direct access to the abbreviate_ref() function. The operation
mode defaults to the core.warnambiguousrefs value, like the refname:short
format, but can be explicitly changed with the --{,no}-strict option.

The bash completion script utilizes this new command.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---

Junio, if this is not a porcelain, tell me.

Cc: git@vger.kernel.org
Cc: szeder@ira.uka.de
Cc: "Shawn O. Pearce" <spearce@spearce.org>

 .gitignore                             |    1 +
 Documentation/git-abbrev-ref.txt       |   34 +++++++++++++++++++++++++++
 Makefile                               |    1 +
 builtin-abbrev-ref.c                   |   40 ++++++++++++++++++++++++++++++++
 builtin.h                              |    1 +
 contrib/completion/git-completion.bash |   16 ++++++------
 git.c                                  |    1 +
 7 files changed, 86 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/git-abbrev-ref.txt
 create mode 100644 builtin-abbrev-ref.c

diff --git a/.gitignore b/.gitignore
index bbaf9de..c2d0ce4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -3,6 +3,7 @@ GIT-CFLAGS
 GIT-GUI-VARS
 GIT-VERSION-FILE
 git
+git-abbrev-ref
 git-add
 git-add--interactive
 git-am
diff --git a/Documentation/git-abbrev-ref.txt b/Documentation/git-abbrev-ref.txt
new file mode 100644
index 0000000..67f6733
--- /dev/null
+++ b/Documentation/git-abbrev-ref.txt
@@ -0,0 +1,34 @@
+git-abbrev-ref(1)
+=================
+
+NAME
+----
+git-abbrev-ref - Abbreviate a named ref
+
+SYNOPSIS
+--------
+'git abbrev-ref' [--strict] <ref>...
+
+DESCRIPTION
+-----------
+
+
+OPTIONS
+-------
+<ref>...::
+	Refnames to be abbreviated.
+
+--strict::
+	Operates in strict mode. Defaults to core.warnambiguousrefs.
+
+Author
+------
+Written by Bert Wesarg <bert.wesarg@googlemail.com>
+
+Documentation
+--------------
+Documentation by Bert Wesarg and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 3c0664a..f78e75f 100644
--- a/Makefile
+++ b/Makefile
@@ -493,6 +493,7 @@ LIB_OBJS += ws.o
 LIB_OBJS += wt-status.o
 LIB_OBJS += xdiff-interface.o
 
+BUILTIN_OBJS += builtin-abbrev-ref.o
 BUILTIN_OBJS += builtin-add.o
 BUILTIN_OBJS += builtin-annotate.o
 BUILTIN_OBJS += builtin-apply.o
diff --git a/builtin-abbrev-ref.c b/builtin-abbrev-ref.c
new file mode 100644
index 0000000..4c4d42c
--- /dev/null
+++ b/builtin-abbrev-ref.c
@@ -0,0 +1,40 @@
+#include "builtin.h"
+#include "cache.h"
+#include "refs.h"
+#include "parse-options.h"
+
+static const char * const git_abbrev_ref_usage[] = {
+	"git abbrev-ref [options] ref...",
+	NULL
+};
+
+int cmd_abbrev_ref(int argc, const char **argv, const char *prefix)
+{
+	int i;
+	int strict = 0;
+	struct option options[] = {
+		OPT_BOOLEAN( 0 , "strict", &strict, "use strict mode"),
+		OPT_END(),
+	};
+
+	git_config(git_default_config, NULL);
+	strict = warn_ambiguous_refs;
+	argc = parse_options(argc, argv, options, git_abbrev_ref_usage, 0);
+
+	for (i = 0; i < argc; i++) {
+		unsigned char sha1[20];
+		char *ref;
+		char *abbrev_ref;
+
+		if (!dwim_ref(argv[i], strlen(argv[i]), sha1, &ref))
+			die("No such ref %s", argv[i]);
+
+		abbreviate_refname(ref, strict, &abbrev_ref);
+		puts(abbrev_ref);
+
+		free(ref);
+		free(abbrev_ref);
+	}
+
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index e67cb20..8271a4e 100644
--- a/builtin.h
+++ b/builtin.h
@@ -20,6 +20,7 @@ extern int commit_tree(const char *msg, unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret);
 extern int check_pager_config(const char *cmd);
 
+extern int cmd_abbrev_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_add(int argc, const char **argv, const char *prefix);
 extern int cmd_annotate(int argc, const char **argv, const char *prefix);
 extern int cmd_apply(int argc, const char **argv, const char *prefix);
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 93f0881..7f002c0 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -112,9 +112,9 @@ __git_ps1 ()
 		fi
 
 		if [ -n "$1" ]; then
-			printf "$1" "${b##refs/heads/}$r"
+			printf "$1" "$(git abbrev-ref $b)$r"
 		else
-			printf " (%s)" "${b##refs/heads/}$r"
+			printf " (%s)" "$(git abbrev-ref $b)$r"
 		fi
 	fi
 }
@@ -162,7 +162,7 @@ __git_heads ()
 		case "$is_hash,$i" in
 		y,*) is_hash=n ;;
 		n,*^{}) is_hash=y ;;
-		n,refs/heads/*) is_hash=y; echo "${i#refs/heads/}" ;;
+		n,refs/heads/*) is_hash=y; echo "$(git abbrev-ref $i)" ;;
 		n,*) is_hash=y; echo "$i" ;;
 		esac
 	done
@@ -180,7 +180,7 @@ __git_tags ()
 		case "$is_hash,$i" in
 		y,*) is_hash=n ;;
 		n,*^{}) is_hash=y ;;
-		n,refs/tags/*) is_hash=y; echo "${i#refs/tags/}" ;;
+		n,refs/tags/*) is_hash=y; echo "$(git abbrev-ref $i)" ;;
 		n,*) is_hash=y; echo "$i" ;;
 		esac
 	done
@@ -199,9 +199,9 @@ __git_refs ()
 		case "$is_hash,$i" in
 		y,*) is_hash=n ;;
 		n,*^{}) is_hash=y ;;
-		n,refs/tags/*) is_hash=y; echo "${i#refs/tags/}" ;;
-		n,refs/heads/*) is_hash=y; echo "${i#refs/heads/}" ;;
-		n,refs/remotes/*) is_hash=y; echo "${i#refs/remotes/}" ;;
+		n,refs/tags/*) is_hash=y; echo "$(git abbrev-ref $i)" ;;
+		n,refs/heads/*) is_hash=y; echo "$(git abbrev-ref $i)" ;;
+		n,refs/remotes/*) is_hash=y; echo "$(git abbrev-ref $i)" ;;
 		n,*) is_hash=y; echo "$i" ;;
 		esac
 	done
@@ -222,7 +222,7 @@ __git_refs_remotes ()
 		case "$is_hash,$i" in
 		n,refs/heads/*)
 			is_hash=y
-			echo "$i:refs/remotes/$1/${i#refs/heads/}"
+			echo "$i:refs/remotes/$1/$(git abbrev-ref $i)"
 			;;
 		y,*) is_hash=n ;;
 		n,*^{}) is_hash=y ;;
diff --git a/git.c b/git.c
index 905acc2..052ebb5 100644
--- a/git.c
+++ b/git.c
@@ -263,6 +263,7 @@ static void handle_internal_command(int argc, const char **argv)
 {
 	const char *cmd = argv[0];
 	static struct cmd_struct commands[] = {
+		{ "abbrev-ref", cmd_abbrev_ref, RUN_SETUP },
 		{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 		{ "annotate", cmd_annotate, RUN_SETUP },
 		{ "apply", cmd_apply },
-- 
1.6.0.1
