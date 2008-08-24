From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 3/3] git-submodule: add "sync" command
Date: Sun, 24 Aug 2008 10:21:40 -0700
Message-ID: <23327a679798d19dc52a27c55a58c5b8c9ebe945.1219598198.git.davvid@gmail.com>
References: <1219598500-8334-1-git-send-email-davvid@gmail.com>
 <e21617f50ffaae98ab73fa364e40440397bcbe33.1219598198.git.davvid@gmail.com>
 <341166c1e31ba26c4e8e48cd7cf9ce12a9f745b9.1219598198.git.davvid@gmail.com>
Cc: mlevedahl@gmail.com, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Aug 24 19:31:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXJQf-0002mk-4Y
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 19:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592AbYHXR3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 13:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752661AbYHXR3q
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 13:29:46 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:25935 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752592AbYHXR3n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 13:29:43 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1296197rvb.1
        for <git@vger.kernel.org>; Sun, 24 Aug 2008 10:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=vzODm4IXt6DbBHIZ0It5lxTgyA6/bi6Zp52UFkX6FOc=;
        b=WAYivn+lmgsXRaWNr52DYVKYH+f1GyQNx3vZAZqnIOmrsXev7M4+7CvK/AEuhqqBW3
         4+ewhSkIF523nsKD19IqB0erV2Aulbd+J0P2+TMQGiePQZQ8oU+4buXyB3VyAt2xmUHM
         L9R7SnAIBZQw+PbeubiNtylocp8ijf7V71xPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=n3Pn2VqUKyJHfS8RgKC/zWvMoUVl1tsv5AEkHT4GpkGLGDh1pNl7rv+74pFCb6w6zN
         n/H85Ow40wZXSbW/m7YNUw32k41WkPVvw/iD/xDdWMas3tBTbtmHDkxwqg7q6yu9zczP
         yWJvTS2gHiildpUSP3NdJwl0n91CTjgb5jzGc=
Received: by 10.141.27.16 with SMTP id e16mr1681027rvj.136.1219598983306;
        Sun, 24 Aug 2008 10:29:43 -0700 (PDT)
Received: from localhost ( [208.106.56.2])
        by mx.google.com with ESMTPS id b8sm5823009rvf.4.2008.08.24.10.29.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Aug 2008 10:29:42 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.90.g436ed
In-Reply-To: <341166c1e31ba26c4e8e48cd7cf9ce12a9f745b9.1219598198.git.davvid@gmail.com>
In-Reply-To: <e21617f50ffaae98ab73fa364e40440397bcbe33.1219598198.git.davvid@gmail.com>
References: <e21617f50ffaae98ab73fa364e40440397bcbe33.1219598198.git.davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93538>

When a submodule's URL changes upstream, existing submodules
will be out of sync since their remote."$origin".url will still
be set to the old value.

This change adds a "git submodule sync" command that reads the
submodule URLs from .gitmodules and updates any existing
submodules accordingly.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Documentation/git-submodule.txt |    9 +++++++
 git-submodule.sh                |   51 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index abbd5b7..babaa9b 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 'git submodule' [--quiet] update [--init] [--] [<path>...]
 'git submodule' [--quiet] summary [--summary-limit <n>] [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach <command>
+'git submodule' [--quiet] sync [--] [<path>...]
 
 
 DESCRIPTION
@@ -139,6 +140,14 @@ foreach::
 As an example, "git submodule foreach 'echo $path `git rev-parse HEAD`' will
 show the path and currently checked out commit for each submodule.
 
+sync::
+	Synchronizes submodules' remote URL configuration setting
+	to the value specified in .gitmodules.  This is useful when
+	submodule URLs change upstream and you need to update your local
+	repositories accordingly.
++
+"git submodule sync" synchronizes all submodules while
+"git submodule sync -- A" synchronizes submodule "A" only.
 
 OPTIONS
 -------
diff --git a/git-submodule.sh b/git-submodule.sh
index d2ae835..2af2ef4 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -6,7 +6,7 @@
 
 USAGE="[--quiet] [--cached] \
 [add <repo> [-b branch] <path>]|[status|init|update [-i|--init]|summary [-n|--summary-limit <n>] [<commit>]] \
-[--] [<path>...]|[foreach <command>]"
+[--] [<path>...]|[foreach <command>]|[sync [--] [<path>...]]"
 OPTIONS_SPEC=
 . git-sh-setup
 require_work_tree
@@ -609,6 +609,53 @@ cmd_status()
 		fi
 	done
 }
+#
+# Sync remote urls for submodules
+# This makes the value for remote.$remote.url match the value
+# specified in .gitmodules.
+#
+cmd_sync()
+{
+	while test $# -ne 0
+	do
+		case "$1" in
+		-q|--quiet)
+			quiet=1
+			shift
+			;;
+		--)
+			shift
+			break
+			;;
+		-*)
+			usage
+			;;
+		*)
+			break
+			;;
+		esac
+	done
+
+	cd_to_toplevel
+	toplevel="$PWD"
+
+	module_list "$@" |
+	while read mode sha1 stage path
+	do
+		name=$(module_name "$path")
+		url=$(git config -f .gitmodules --get submodule."$name".url)
+		if test -d "$path"; then
+		(
+			unset GIT_DIR
+			cd "$path"
+			remote=$(get_remote)
+			say "Synchronizing submodule url for '$name'"
+			git config remote."$remote".url "$url"
+			cd "$toplevel"
+		)
+		fi
+	done
+}
 
 # This loop parses the command line arguments to find the
 # subcommand name to dispatch.  Parsing of the subcommand specific
@@ -619,7 +666,7 @@ cmd_status()
 while test $# != 0 && test -z "$command"
 do
 	case "$1" in
-	add | foreach | init | update | status | summary)
+	add | foreach | init | update | status | summary | sync)
 		command=$1
 		;;
 	-q|--quiet)
-- 
1.6.0.90.g436ed
