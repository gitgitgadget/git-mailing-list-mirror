From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 04/19] new commands: pull_all and push_all
Date: Sat, 9 Mar 2013 19:23:36 +0000
Message-ID: <CALeLG_=fB+-f52k6VKH990BinghrcnAC+9s5jheHVoPnqOG6iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Michael Barr <b@rr-dav.id.au>, Kindjal <kindjal@gmail.com>,
	bibendi <bibendi@bk.ru>, Herman van Rink <rink@initfour.nl>,
	mhoffman <matt.hoffman@quantumretail.com>,
	Nate Jones <nate@endot.org>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 09 20:24:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEPNF-0007oe-GP
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 20:24:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165Ab3CITXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 14:23:39 -0500
Received: from mail-ob0-f178.google.com ([209.85.214.178]:64293 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab3CITXi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 14:23:38 -0500
Received: by mail-ob0-f178.google.com with SMTP id wd20so2247663obb.9
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 11:23:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=YPUABbpjMSr/wuI8JvOQSp6csupmeLHlfDn1ITHV2Kc=;
        b=pZw0P/hvMZvyBGxN1PJTukGCL+DqvSA+pGLSPa3JDWg+XFaGT2Y9TjfWYnBVKJfeYH
         hQ5NHhRmMrd+49kI6nxRNW+p22YCuB0Iv7qIVFOIj89RLCW7vYkhHhT6KkrIY3CdJq4Y
         wQaoxHIpsj7JXYXp/fMFmhBnwcsYEMsxUOJR0sG1xvS3lWy2ZSQJ04w1xXzZPYAB91k5
         1x7hJ/gBkLS5hJDl+ZSZHd/uRlArXOP4sj7pMMQBVdDNDTr+j3Ng00c3FIO5Aj7nuVLO
         VWCc1FhBMWi/yh/3eDTbNTbivWCSIxmI6S6ZcAo8XJCKBGKpqLaYrEnAQBcgIKIW+0FB
         8VmQ==
X-Received: by 10.182.116.70 with SMTP id ju6mr5019974obb.48.1362857016668;
 Sat, 09 Mar 2013 11:23:36 -0800 (PST)
Received: by 10.76.122.109 with HTTP; Sat, 9 Mar 2013 11:23:36 -0800 (PST)
X-Originating-IP: [2.102.85.67]
X-Gm-Message-State: ALoCoQm6gToYSI0Hx6MW3qPNMNZEaHGhNeytcfDtYZISZfeZj5IG5wu9tE1jCcl5x1CcPyd/bkI8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217741>

>From 7e20edee694cbcbac79be4fbe37d9cedebe3e4ee Mon Sep 17 00:00:00 2001
From: Paul Campbell <pcampbell@kemitix.net>
Date: Sat, 9 Mar 2013 18:31:37 +0000
Subject: [PATCH 04/19] new commands: pull_all and push_all

Conflicts:
	contrib/subtree/git-subtree.sh

Original-Author: bibendi <bibendi@bk.ru>
Conflicts-resolved-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.sh | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index cb9e288..c3b1208 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -12,6 +12,7 @@ git subtree add   --prefix=<prefix> <commit>
 git subtree add   --prefix=<prefix> <repository> <commit>
 git subtree merge --prefix=<prefix> <commit>
 git subtree pull  --prefix=<prefix> <repository> <refspec...>
+git subtree pull_all
 git subtree push  --prefix=<prefix> <repository> <refspec...>
 git subtree split --prefix=<prefix> <commit...>
 git subtree from-submodule --prefix=<prefix>
@@ -102,16 +103,18 @@ done
 command="$1"
 shift
 case "$command" in
-	add|merge|pull|from-submodule) default= ;;
+	add|merge|pull|from-submodule|pull_all|push_all) default= ;;
 	split|push) default="--default HEAD" ;;
 	*) die "Unknown command '$command'" ;;
 esac

-if [ -z "$prefix" ]; then
+if [ -z "$prefix" -a "$command" != "pull_all" -a "$command" !=
"push_all" ]; then
 	die "You must provide the --prefix option."
 fi

 case "$command" in
+    pull_all);;
+    push_all);;
 	add) [ -e "$prefix" ] &&
 		die "prefix '$prefix' already exists." ;;
 	*)   [ -e "$prefix" ] ||
@@ -120,7 +123,7 @@ esac

 dir="$(dirname "$prefix/.")"

-if [ "$command" != "pull" -a "$command" != "add" -a "$command" !=
"push" ]; then
+if [ "$command" != "pull" -a "$command" != "add" -a "$command" !=
"push" -a "$command" != "pull_all" ]; then
 	revs=$(git rev-parse $default --revs-only "$@") || exit $?
 	dirs="$(git rev-parse --no-revs --no-flags "$@")" || exit $?
 	if [ -n "$dirs" ]; then
@@ -760,4 +763,20 @@ cmd_from-submodule()
 	rm -rf $tmp_repo
 }

+cmd_pull_all()
+{
+    git config -f .gittrees -l | grep subtree | grep path | grep -o
'=.*' | grep -o '[^=].*' |
+        while read path; do
+            git subtree pull -P $path master || exit $?
+        done
+}
+
+cmd_push_all()
+{
+    git config -f .gittrees -l | grep subtree | grep path | grep -o
'=.*' | grep -o '[^=].*' |
+        while read path; do
+            git subtree push -P $path master || exit $?
+        done
+}
+
 "cmd_$command" "$@"
-- 
1.8.2.rc1


-- 
Paul [W] Campbell
