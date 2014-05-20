From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 10/19] git-submodule.sh: convert test -a/-o to && and ||
Date: Tue, 20 May 2014 06:50:23 -0700
Message-ID: <1400593832-6510-11-git-send-email-gitter.spiros@gmail.com>
References: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 15:51:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmkRh-0000Bh-DD
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 15:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588AbaETNuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 09:50:51 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:37522 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571AbaETNut (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 09:50:49 -0400
Received: by mail-pb0-f47.google.com with SMTP id rp16so341304pbb.6
        for <git@vger.kernel.org>; Tue, 20 May 2014 06:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hcraud2V3PXNEIvO4puZb8fN1zXKfNThnt8VoNm47P8=;
        b=oSUz9ITD/ANCVMqL+y2T4I+9eAf8bcye9O42VI9NP6SkVzaR7eXVyJATeAGprivT/o
         YdElG5s0OMwn/WXVFMqAOR71cxQK2UFq8pQ4sHa0S29rnvUm2p3TM34F2Yz9Jc/zgjsE
         sm0+dFI6RTZPIYiWcOpaYj8Yk0Gtcj/7B3i/pmbKVXJ8OhuJ81VCSMLRAom4iiyCSbbt
         n85jKCvgW5U3gLNEu6uOS5Y0jXN/+yFbkFoGOOP/FuKTU+nMKto2suHwDq1wRZGjeF3D
         f77ko5wqUu690IQs5tyMs9PwkptEPfVpZkQ7nX7AI341zclEPnqGAtAG0yPWzzcVBHwQ
         Es7g==
X-Received: by 10.68.133.229 with SMTP id pf5mr51485244pbb.115.1400593848853;
        Tue, 20 May 2014 06:50:48 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id oe4sm3317286pbb.33.2014.05.20.06.50.47
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 06:50:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249666>

The interaction with unary operators and operator precedence
for && and || are better known than -a and -o, and for that
reason we prefer them. Replace all existing instances
of -a and -o to save readers from the burden of thinking
about such things.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 git-submodule.sh |   29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index b55d83a..4b57b96 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -396,7 +396,7 @@ cmd_add()
 			sed -e 's|/$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
 	fi
 
-	if test -z "$repo" -o -z "$sm_path"; then
+	if test -z "$repo" || test -z "$sm_path"; then
 		usage
 	fi
 
@@ -453,7 +453,7 @@ Use -f if you really want to add it." >&2
 	# perhaps the path exists and is already a git repo, else clone it
 	if test -e "$sm_path"
 	then
-		if test -d "$sm_path"/.git -o -f "$sm_path"/.git
+		if test -d "$sm_path"/.git || test -f "$sm_path"/.git
 		then
 			eval_gettextln "Adding existing repo at '\$sm_path' to the index"
 		else
@@ -835,7 +835,7 @@ Maybe you want to use 'update --init'?")"
 			continue
 		fi
 
-		if ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
+		if ! test -d "$sm_path"/.git || test -f "$sm_path"/.git
 		then
 			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" || exit
 			cloned_modules="$cloned_modules;$name"
@@ -860,11 +860,11 @@ Maybe you want to use 'update --init'?")"
 			die "$(eval_gettext "Unable to find current ${remote_name}/${branch} revision in submodule path '\$sm_path'")"
 		fi
 
-		if test "$subsha1" != "$sha1" -o -n "$force"
+		if test "$subsha1" != "$sha1" || test -n "$force"
 		then
 			subforce=$force
 			# If we don't already have a -f flag and the submodule has never been checked out
-			if test -z "$subsha1" -a -z "$force"
+			if test -z "$subsha1" || test -z "$force"
 			then
 				subforce="-f"
 			fi
@@ -1034,7 +1034,7 @@ cmd_summary() {
 	then
 		head=$rev
 		test $# = 0 || shift
-	elif test -z "$1" -o "$1" = "HEAD"
+	elif test -z "$1" || test "$1" = "HEAD"
 	then
 		# before the first commit: compare with an empty tree
 		head=$(git hash-object -w -t tree --stdin </dev/null)
@@ -1059,13 +1059,18 @@ cmd_summary() {
 		while read mod_src mod_dst sha1_src sha1_dst status sm_path
 		do
 			# Always show modules deleted or type-changed (blob<->module)
-			test $status = D -o $status = T && echo "$sm_path" && continue
+			{
+			test "$status" = D ||
+			test "$status" = T
+			} &&
+			echo "$sm_path"
+			&& continue
 			# Respect the ignore setting for --for-status.
 			if test -n "$for_status"
 			then
 				name=$(module_name "$sm_path")
 				ignore_config=$(get_submodule_config "$name" ignore none)
-				test $status != A -a $ignore_config = all && continue
+				test $status != A && test $ignore_config = all && continue
 			fi
 			# Also show added or modified modules which are checked out
 			GIT_DIR="$sm_path/.git" git-rev-parse --git-dir >/dev/null 2>&1 &&
@@ -1125,7 +1130,7 @@ cmd_summary() {
 		*)
 			errmsg=
 			total_commits=$(
-			if test $mod_src = 160000 -a $mod_dst = 160000
+			if test $mod_src = 160000 && test $mod_dst = 160000
 			then
 				range="$sha1_src...$sha1_dst"
 			elif test $mod_src = 160000
@@ -1162,7 +1167,7 @@ cmd_summary() {
 			# i.e. deleted or changed to blob
 			test $mod_dst = 160000 && echo "$errmsg"
 		else
-			if test $mod_src = 160000 -a $mod_dst = 160000
+			if test $mod_src = 160000 && test $mod_dst = 160000
 			then
 				limit=
 				test $summary_limit -gt 0 && limit="-$summary_limit"
@@ -1233,7 +1238,7 @@ cmd_status()
 			say "U$sha1 $displaypath"
 			continue
 		fi
-		if test -z "$url" || ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
+		if test -z "$url" || ! test -d "$sm_path"/.git || test -f "$sm_path"/.git
 		then
 			say "-$sha1 $displaypath"
 			continue;
@@ -1402,7 +1407,7 @@ then
 fi
 
 # "--cached" is accepted only by "status" and "summary"
-if test -n "$cached" && test "$command" != status -a "$command" != summary
+if test -n "$cached" && test "$command" != status && test "$command" != summary
 then
 	usage
 fi
-- 
1.7.10.4
